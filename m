Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YsuED-0001aG-T0
 for kexec@lists.infradead.org; Thu, 14 May 2015 14:35:14 +0000
Date: Thu, 14 May 2015 10:34:37 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] prepend elfcorehdr instead of appending it to the
 crash-kernel command-line.
Message-ID: <20150514143437.GD21327@redhat.com>
References: <1431511554-16861-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1431511554-16861-1-git-send-email-karahmed@amazon.de>
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
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, aliguori@amazon.com, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

On Wed, May 13, 2015 at 12:05:54PM +0200, KarimAllah Ahmed wrote:
> Any parameter passed after '--' in the kernel command-line will not be parsed
> by the kernel at all, instead it will be passed directly to init process.
> 
> Currently the kernel appends elfcorehdr=<paddr> to the cmdline passed from kexec
> load, and if this command-line is used to pass parameters to init process this
> means that 'elfcorehdr' will not be parsed as a kernel parameter at all which
> will be a problem for vmcore subsystem since it will know nothing about the
> location of the ELF structure!
> 
> Prepending 'elfcorehdr' instead of appending it fixes this problem since it
> ensures that it always comes before '--' and so it's always parsed as a kernel
> command-line parameter.
> 
> Even with this patch things can still go wrong if 'CONFIG_CMDLINE' was also used
> to embedd a command-line to the crash dump kernel and this command-line contains
> '--' since the current behavior of the kernel is to actually append the boot
> loader command-line to the embedded command-line.
> 
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>

Looks good to me. 

We might require a similar change in kexec-tools for old systemcall?

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Thanks
Vivek

> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Haren Myneni <hbabu@us.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> ---
>  arch/x86/kernel/kexec-bzimage64.c |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index ca05f86..ca83f7ac 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -72,15 +72,16 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
>  			 unsigned long cmdline_len)
>  {
>  	char *cmdline_ptr = ((char *)params) + cmdline_offset;
> -	unsigned long cmdline_ptr_phys, len;
> +	unsigned long cmdline_ptr_phys, len = 0;
>  	uint32_t cmdline_low_32, cmdline_ext_32;
>  
> -	memcpy(cmdline_ptr, cmdline, cmdline_len);
>  	if (image->type == KEXEC_TYPE_CRASH) {
> -		len = sprintf(cmdline_ptr + cmdline_len - 1,
> -			" elfcorehdr=0x%lx", image->arch.elf_load_addr);
> -		cmdline_len += len;
> +		len = sprintf(cmdline_ptr,
> +			"elfcorehdr=0x%lx ", image->arch.elf_load_addr);
>  	}
> +	memcpy(cmdline_ptr + len, cmdline, cmdline_len);
> +	cmdline_len += len;
> +
>  	cmdline_ptr[cmdline_len - 1] = '\0';
>  
>  	pr_debug("Final command line is: %s\n", cmdline_ptr);
> -- 
> 1.7.9.5

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
