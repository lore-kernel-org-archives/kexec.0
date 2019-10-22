Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iMpZH-0007Yc-N5
 for kexec@lists.infradead.org; Tue, 22 Oct 2019 08:31:06 +0000
Date: Tue, 22 Oct 2019 10:30:15 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3 v4] x86/kdump: always reserve the low 1MiB when the
 crashkernel option is specified
Message-ID: <20191022083015.GB31700@zn.tnic>
References: <20191017094347.20327-1-lijiang@redhat.com>
 <20191017094347.20327-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191017094347.20327-2-lijiang@redhat.com>
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: jgross@suse.com, Thomas.Lendacky@amd.com, bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, vgoyal@redhat.com

On Thu, Oct 17, 2019 at 05:43:45PM +0800, Lianbo Jiang wrote:
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204793

Put that as a Link: below.

> Kdump kernel will reuse the first 640k region because of some reasons,

s/ of some reasons//

> for example: the trampline and conventional PC system BIOS region may

spellcheck: s/trampline/trampoline/

I see two more typos in here and if you had a spellchecker enabled in
your editor where you write the commit message, you'll see them too.
Please use one.

> require to allocate memory in this area. Obviously, kdump kernel will
> also overwrite the first 640k region,

Well, it is not obvious to me. Please be more specific: why would the
kdump kernel do that?

> therefore, kernel has to copy
> the contents of the first 640k area to a backup area, which is done in
> purgatory(), because vmcore may need the old memory. When vmcore is
> dumped, kdump kernel will read the old memory from the backup area of
> the first 640k area.
> 
> Basically, the main reason should be clear, kernel does not correctly
> handle the first 640k region when SME is active,

If you mention the actual reason here, that sentence would be clearer:

"When SME is enabled in the first kernel, the kdump kernel must access
the first kernel's memory with the encryption bit set."

Something like that. 

> which causes that
> kernel does not properly copy these old memory to the backup area in
> purgatory(). Therefore, kdump kernel reads out the incorrect contents

s/incorrect/encrypted/

> from the backup area when dumping vmcore. Finally, the phenomenon is

phenomenon?

> as follow:
> 
> [root linux]$ crash vmlinux /var/crash/127.0.0.1-2019-09-19-08\:31\:27/vmcore
> WARNING: kernel relocated [240MB]: patching 97110 gdb minimal_symbol values
> 
>       KERNEL: /var/crash/127.0.0.1-2019-09-19-08:31:27/vmlinux
>     DUMPFILE: /var/crash/127.0.0.1-2019-09-19-08:31:27/vmcore  [PARTIAL DUMP]
>         CPUS: 128
>         DATE: Thu Sep 19 08:31:18 2019
>       UPTIME: 00:01:21
> LOAD AVERAGE: 0.16, 0.07, 0.02
>        TASKS: 1343
>     NODENAME: amd-ethanol
>      RELEASE: 5.3.0-rc7+
>      VERSION: #4 SMP Thu Sep 19 08:14:00 EDT 2019
>      MACHINE: x86_64  (2195 Mhz)
>       MEMORY: 127.9 GB
>        PANIC: "Kernel panic - not syncing: sysrq triggered crash"
>          PID: 9789
>      COMMAND: "bash"
>         TASK: "ffff89711894ae80  [THREAD_INFO: ffff89711894ae80]"
>          CPU: 83
>        STATE: TASK_RUNNING (PANIC)
> 
> crash> kmem -s|grep -i invalid
> kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac099f0c5a4
> kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac099f0c5a4
> crash>

I fail to see what that's trying to tell me? You have invalid pointers?

> BTW: I also tried to fix the above problem in purgatory(), but there
> are too many restricts in purgatory() context, for example: i can't
> allocate new memory to create the identity mapping page table for SME
> situation.

This paragraph belongs under the "---" line below.

> Currently, there are two places where the first 640k area is needed,
> the first one is in the find_trampoline_placement(), another one is
> in the reserve_real_mode(), and their content doesn't matter.
> 
> To avoid the above error, when the crashkernel kernel command line
> option is specified, lets reserve the remaining low 1MiB memory(
> after reserving real mode memroy) so that the allocated memory does
> not fall into the low 1MiB area, which makes us not to copy the first
> 640k content to a backup region in purgatory(). This indicates that
> it does not need to be included in crash dumps or used for anything
> execept the processor trampolines that must live in the low 1MiB.
> 
> In addition, also need to clean all the code related to the backup
> region later.

Ditto.

> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/x86/realmode/init.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> index 7dce39c8c034..1f0492830f2c 100644
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -34,6 +34,17 @@ void __init reserve_real_mode(void)
>  
>  	memblock_reserve(mem, size);
>  	set_real_mode_mem(mem);
> +
> +#ifdef CONFIG_KEXEC_CORE
> +	/*
> +	 * When the crashkernel option is specified, only use the low
> +	 * 1MiB for the real mode trampoline.
> +	 */
> +	if (strstr(boot_command_line, "crashkernel=")) {
> +		memblock_reserve(0, 1<<20);
> +		pr_info("Reserving the low 1MiB of memory for crashkernel\n");
> +	}
> +#endif /* CONFIG_KEXEC_CORE */

This ifdeffery needs to be a function in kernel/kexec_core.c which is
called by reserve_real_mode(), instead.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
