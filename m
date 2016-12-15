Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cHQHx-0002BQ-Ms
 for kexec@lists.infradead.org; Thu, 15 Dec 2016 07:17:15 +0000
Date: Thu, 15 Dec 2016 15:16:46 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 1/2] kexec: add a dummy note for each offline cpu
Message-ID: <20161215071646.GA10673@dhcp-128-65.nay.redhat.com>
References: <1481695887-21090-1-git-send-email-piliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1481695887-21090-1-git-send-email-piliu@redhat.com>
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
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, kernelfans@gmail.com, Baoquan He <bhe@redhat.com>

Hi, Pingfan
On 12/14/16 at 02:11pm, Pingfan Liu wrote:
> kexec-tools always allocates program headers for each possible cpu. This
> incurs zero PT_NOTE for offline cpu. We mark this case so that later,
> the capture kernel can distinguish it from the mistake of allocated
> program header.
> The counterpart of the capture kernel comes in next patch.

I thought you saw the warnings on ppc64 and it might be a ppc64 issue.
But if this is instead a general issue, can we think about if this is
really necessary?

Does it have any side effect other than the warning messages? If there
is nothing bad other than the warnings maybe leave it as is will be
a better way.

> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> ---
> This unnecessary warning buzz on all archs when there is offline cpu
> 
>  include/uapi/linux/elf.h | 1 +
>  kernel/kexec_core.c      | 9 +++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index b59ee07..9744f1e 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -367,6 +367,7 @@ typedef struct elf64_shdr {
>   * using the corresponding note types via the PTRACE_GETREGSET and
>   * PTRACE_SETREGSET requests.
>   */
> +#define NT_DUMMY	0
>  #define NT_PRSTATUS	1
>  #define NT_PRFPREG	2
>  #define NT_PRPSINFO	3
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 5616755..aeac16e 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -891,9 +891,12 @@ void __crash_kexec(struct pt_regs *regs)
>  	if (mutex_trylock(&kexec_mutex)) {
>  		if (kexec_crash_image) {
>  			struct pt_regs fixed_regs;
> +			unsigned int cpu;
>  
>  			crash_setup_regs(&fixed_regs, regs);
>  			crash_save_vmcoreinfo();
> +			for_each_cpu_not(cpu, cpu_online_mask)
> +				crash_save_cpu(NULL, cpu);
>  			machine_crash_shutdown(&fixed_regs);
>  			machine_kexec(kexec_crash_image);
>  		}
> @@ -1040,6 +1043,12 @@ void crash_save_cpu(struct pt_regs *regs, int cpu)
>  	buf = (u32 *)per_cpu_ptr(crash_notes, cpu);
>  	if (!buf)
>  		return;
> +	if (regs == NULL) {
> +		buf = append_elf_note(buf, KEXEC_CORE_NOTE_NAME, NT_DUMMY,
> +				NULL, 0);
> +		final_note(buf);
> +		return;
> +	}
>  	memset(&prstatus, 0, sizeof(prstatus));
>  	prstatus.pr_pid = current->pid;
>  	elf_core_copy_kernel_regs(&prstatus.pr_reg, regs);
> -- 
> 2.7.4
> 

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
