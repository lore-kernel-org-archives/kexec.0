Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a7S3R-0006hE-TH
 for kexec@lists.infradead.org; Fri, 11 Dec 2015 18:04:31 +0000
Date: Fri, 11 Dec 2015 19:04:03 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [V6.1 PATCH 5/6] x86/nmi: Fix to save registers for crash dump
 on external NMI broadcast
Message-ID: <20151211180403.GD4815@pd.tnic>
References: <20151210014634.25437.217.stgit@softrs>
 <201512101102.6UNkKzbX%fengguang.wu@intel.com>
 <04EAB7311EE43145B2D3536183D1A84454A4EA10@GSjpTKYDCembx31.service.hitachi.net>
 <20151210065245.4587.39316.stgit@softrs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20151210065245.4587.39316.stgit@softrs>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: x86@kernel.org, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Dec 10, 2015 at 03:52:46PM +0900, Hidehiro Kawai wrote:
> Now, multiple CPUs can receive external NMI simultaneously by
> specifying "apic_extnmi=all" as an boot option.  When we take a
> crash dump by using external NMI with this option, we fail to save
> register values into the crash dump.  This happens as follows:
> 
>   CPU 0                              CPU 1
>   ================================   =============================
>   receive an external NMI
>   default_do_nmi()                   receive an external NMI
>     spin_lock(&nmi_reason_lock)      default_do_nmi()
>     io_check_error()                   spin_lock(&nmi_reason_lock)
>       panic()                            busy loop
>       ...
>         kdump_nmi_shootdown_cpus()
>           issue NMI IPI -----------> blocked until IRET
>                                          busy loop...
> 
>   Here, since CPU 1 is in NMI context, additional NMI from CPU 0
>   is blocked until CPU 1 executes IRET.  However, CPU 1 never
>   executes IRET, so the NMI is not handled and the callback function
>   to save registers is never called.
> 
> To solve this issue, we check if the IPI for crash dumping was
> issued while waiting for nmi_reason_lock to be released, and if so,
> call its callback function directly.  If the IPI is not issued (e.g.
> kdump is disabled), the actual behavior doesn't change.
> 
> V6.1:
> - Reintroduce the UP version of run_crash_ipi_callback to fix build
>   error for CONFIG_SMP=n and CONFIG_DEBUG_SPINLOCK=y case
> 
> V6:
> - Separated from the former patch `panic/x86: Allow cpus to save
>   registers even if they are looping in NMI context'
> - Fix comments
> - Remove unneeded UP version of poll_crash_ipi_and_calback
> - Rename poll_crash_ipi_and_callback to run_crash_ipi_callback
> 
> Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> ---
>  arch/x86/include/asm/reboot.h |    1 +
>  arch/x86/kernel/nmi.c         |   11 ++++++++++-
>  arch/x86/kernel/reboot.c      |   22 +++++++++++++++++-----
>  3 files changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/reboot.h b/arch/x86/include/asm/reboot.h
> index a82c4f1..2cb1cc2 100644
> --- a/arch/x86/include/asm/reboot.h
> +++ b/arch/x86/include/asm/reboot.h
> @@ -25,5 +25,6 @@ void __noreturn machine_real_restart(unsigned int type);
>  
>  typedef void (*nmi_shootdown_cb)(int, struct pt_regs*);
>  void nmi_shootdown_cpus(nmi_shootdown_cb callback);
> +void run_crash_ipi_callback(struct pt_regs *regs);
>  
>  #endif /* _ASM_X86_REBOOT_H */
> diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> index 5e00de7..cbfa0b5 100644
> --- a/arch/x86/kernel/nmi.c
> +++ b/arch/x86/kernel/nmi.c
> @@ -29,6 +29,7 @@
>  #include <asm/mach_traps.h>
>  #include <asm/nmi.h>
>  #include <asm/x86_init.h>
> +#include <asm/reboot.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/nmi.h>
> @@ -357,7 +358,15 @@ static void default_do_nmi(struct pt_regs *regs)
>  	}
>  
>  	/* Non-CPU-specific NMI: NMI sources can be processed on any CPU */
> -	raw_spin_lock(&nmi_reason_lock);
> +	/*
> +	 * Another CPU may be processing panic routines while holding
> +	 * nmi_reason_lock.  Check if the CPU issued the IPI for crash
> +	 * dumping, and if so, call its callback directly.  If there is
> +	 * no CPU preparing crash dump, we simply loop here without doing
> +	 * special things.
> +	 */
> +	while (!raw_spin_trylock(&nmi_reason_lock))
> +		run_crash_ipi_callback(regs);

Added cpu_relax() here too:

+       while (!raw_spin_trylock(&nmi_reason_lock)) {
+               run_crash_ipi_callback(regs);
+               cpu_relax();
+       }

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
