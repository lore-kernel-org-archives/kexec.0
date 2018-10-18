Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gCzJ5-0004En-9O
 for kexec@lists.infradead.org; Thu, 18 Oct 2018 03:49:08 +0000
Date: Thu, 18 Oct 2018 11:48:49 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] kexec: don't act as EFI chainloader if noefi.
Message-ID: <20181018034849.GA13107@dhcp-128-65.nay.redhat.com>
References: <20181017234139.241414-1-chrisko@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181017234139.241414-1-chrisko@google.com>
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
To: Chris Koch <chrisko@google.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

On 10/17/18 at 04:41pm, Chris Koch wrote:
> From: Christopher Koch <chrisko@google.com>
> 
> An EFI-booted Linux kernel will commit a virtual memory map in
> efi_enter_virtual_mode, which is only done if
> efi_enabled(EFI_RUNTIME_SERVICES). This can be disabled by adding noefi
> to the command line.
> 
> kexec's setup_efi_state will then pass a memmap_size of 0 to the next
> kernel.
> 
> A Linux kernel cannot handle a memmap_size of 0 given by its bootloader:
> efi_memblock_x86_reserve_range divides by the memmap_size and hits a
> divide by 0 error.
> 
> When the 1st kernel is booted with noefi, it should not even attempt to
> pass EFI information to any kexec'd kernel.
> 
> Signed-off-by: Christopher Koch <chrisko@google.com>
> ---
>  arch/x86/kernel/kexec-bzimage64.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 278cd07228dd..8ab4ffb901ce 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -179,6 +179,14 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
>  	if (efi_enabled(EFI_OLD_MEMMAP))
>  		return 0;
>  
> +	/*
> +	 * If we booted with noefi on the command line, we never committed a
> +	 * virtual memory map. It makes no sense to act as an EFI chainloader in
> +	 * that case.
> +	 */
> +	if (!efi_enabled(EFI_RUNTIME_SERVICES))
> +		return 0;
> +

Previously there was a report from Mike Galbraith <efault@gmx.de> for
the case efi=noruntime,  I was doing some cleanup for the
kexec_file_load efi code path, but I'm occupied with some other thing,
that is delayed.

I think your patch looks good,  can you add more words in the code
comment about efi=noruntime,  also maybe mention if one want to use
kexec reboot in case noefi/noruntime he should pass acpi_rsdp= param
in 2nd kernel cmdline.

>  	ei->efi_loader_signature = current_ei->efi_loader_signature;
>  	ei->efi_systab = current_ei->efi_systab;
>  	ei->efi_systab_hi = current_ei->efi_systab_hi;
> -- 
> 2.19.1.331.ge82ca0e54c-goog
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
