From: Sean Christopherson <seanjc@google.com>
Date: Mon, 9 May 2022 15:52:49 +0000
Subject: [PATCH 01/30] x86/crash,reboot: Avoid re-disabling VMX in all
 CPUs on crash/restart
In-Reply-To: <20220427224924.592546-2-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-2-gpiccoli@igalia.com>
Message-ID: <Ynk40U/KA+hLBZRC@google.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

I find the shortlog to be very confusing, the bug has nothing to do with disabling
VMX and I distinctly remember wrapping VMXOFF with exception fixup to prevent doom
if VMX is already disabled :-).  The issue is really that nmi_shootdown_cpus() doesn't
play nice with being called twice.

On Wed, Apr 27, 2022, Guilherme G. Piccoli wrote:
> In the panic path we have a list of functions to be called, the panic
> notifiers - such callbacks perform various actions in the machine's
> last breath, and sometimes users want them to run before kdump. We
> have the parameter "crash_kexec_post_notifiers" for that. When such
> parameter is used, the function "crash_smp_send_stop()" is executed
> to poweroff all secondary CPUs through the NMI-shootdown mechanism;
> part of this process involves disabling virtualization features in
> all CPUs (except the main one).
> 
> Now, in the emergency restart procedure we have also a way of
> disabling VMX in all CPUs, using the same NMI-shootdown mechanism;
> what happens though is that in case we already NMI-disabled all CPUs,
> the emergency restart fails due to a second addition of the same items
> in the NMI list, as per the following log output:
> 
> sysrq: Trigger a crash
> Kernel panic - not syncing: sysrq triggered crash
> [...]
> Rebooting in 2 seconds..
> list_add double add: new=<addr1>, prev=<addr2>, next=<addr1>.
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:29!
> invalid opcode: 0000 [#1] PREEMPT SMP PTI

Call stacks for the two callers would be very, very helpful.

> In order to reproduce the problem, users just need to set the kernel
> parameter "crash_kexec_post_notifiers" *without* kdump set in any
> system with the VMX feature present.
> 
> Since there is no benefit in re-disabling VMX in all CPUs in case
> it was already done, this patch prevents that by guarding the restart
> routine against doubly issuing NMIs unnecessarily. Notice we still
> need to disable VMX locally in the emergency restart.
> 
> Fixes: ed72736183c4 ("x86/reboot: Force all cpus to exit VMX root if VMX is supported)
> Fixes: 0ee59413c967 ("x86/panic: replace smp_send_stop() with kdump friendly version in panic path")
> Cc: David P. Reed <dpreed@deepplum.com>
> Cc: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>  arch/x86/include/asm/cpu.h |  1 +
>  arch/x86/kernel/crash.c    |  8 ++++----
>  arch/x86/kernel/reboot.c   | 14 ++++++++++++--
>  3 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
> index 86e5e4e26fcb..b6a9062d387f 100644
> --- a/arch/x86/include/asm/cpu.h
> +++ b/arch/x86/include/asm/cpu.h
> @@ -36,6 +36,7 @@ extern int _debug_hotplug_cpu(int cpu, int action);
>  #endif
>  #endif
>  
> +extern bool crash_cpus_stopped;
>  int mwait_usable(const struct cpuinfo_x86 *);
>  
>  unsigned int x86_family(unsigned int sig);
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index e8326a8d1c5d..71dd1a990e8d 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -42,6 +42,8 @@
>  #include <asm/crash.h>
>  #include <asm/cmdline.h>
>  
> +bool crash_cpus_stopped;
> +
>  /* Used while preparing memory map entries for second kernel */
>  struct crash_memmap_data {
>  	struct boot_params *params;
> @@ -108,9 +110,7 @@ void kdump_nmi_shootdown_cpus(void)
>  /* Override the weak function in kernel/panic.c */
>  void crash_smp_send_stop(void)
>  {
> -	static int cpus_stopped;
> -
> -	if (cpus_stopped)
> +	if (crash_cpus_stopped)
>  		return;
>  
>  	if (smp_ops.crash_stop_other_cpus)
> @@ -118,7 +118,7 @@ void crash_smp_send_stop(void)
>  	else
>  		smp_send_stop();
>  
> -	cpus_stopped = 1;
> +	crash_cpus_stopped = true;

This feels like were just adding more duct tape to the mess.  nmi_shootdown() is
still unsafe for more than one caller, and it takes a _lot_ of staring and searching
to understand that crash_smp_send_stop() is invoked iff CONFIG_KEXEC_CORE=y, i.e.
that it will call smp_ops.crash_stop_other_cpus() and not just smp_send_stop().

Rather than shared a flag between two relatively unrelated functions, what if we
instead disabling virtualization in crash_nmi_callback() and then turn the reboot
call into a nop if an NMI shootdown has already occurred?  That will also add a
bit of documentation about multiple shootdowns not working.

And I believe there's also a lurking bug in native_machine_emergency_restart() that
can be fixed with cleanup.  SVM can also block INIT and so should be disabled during
an emergency reboot.

The attached patches are compile tested only.  If they seem sane, I'll post an
official mini series.

>  }
>  
>  #else
> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> index fa700b46588e..2fc42b8402ac 100644
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -589,8 +589,18 @@ static void native_machine_emergency_restart(void)
>  	int orig_reboot_type = reboot_type;
>  	unsigned short mode;
>  
> -	if (reboot_emergency)
> -		emergency_vmx_disable_all();
> +	/*
> +	 * We can reach this point in the end of panic path, having
> +	 * NMI-disabled all secondary CPUs. This process involves
> +	 * disabling the CPU virtualization technologies, so if that
> +	 * is the case, we only miss disabling the local CPU VMX...
> +	 */
> +	if (reboot_emergency) {
> +		if (!crash_cpus_stopped)
> +			emergency_vmx_disable_all();
> +		else
> +			cpu_emergency_vmxoff();
> +	}
>  
>  	tboot_shutdown(TB_SHUTDOWN_REBOOT);
>  
> -- 
> 2.36.0
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-x86-crash-Disable-virt-in-core-NMI-crash-handler-to-.patch
Type: text/x-diff
Size: 6626 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/kexec/attachments/20220509/5e99544c/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-x86-reboot-Disable-virtualization-in-an-emergency-if.patch
Type: text/x-diff
Size: 2721 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/kexec/attachments/20220509/5e99544c/attachment-0003.bin>
