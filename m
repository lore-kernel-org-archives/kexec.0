Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMu9Q-0007se-Mk
 for kexec@lists.infradead.org; Fri, 10 Apr 2020 13:56:58 +0000
Date: Fri, 10 Apr 2020 21:56:44 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] efi/x86: Revert struct layout change to fix kexec boot
 regression
Message-ID: <20200410135644.GB6772@dhcp-128-65.nay.redhat.com>
References: <20200410074320.16589-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200410074320.16589-1-ardb@kernel.org>
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
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, tytso@mit.edu, x86@kernel.org, kexec@lists.infradead.org, bp@alien8.de, mingo@kernel.org

On 04/10/20 at 09:43am, Ard Biesheuvel wrote:
> Commit
> 
>   0a67361dcdaa29 ("efi/x86: Remove runtime table address from kexec EFI setup data")
> 
> removed the code that retrieves the non-remapped UEFI runtime services
> pointer from the data structure provided by kexec, as it was never really
> needed on the kexec boot path: mapping the runtime services table at its
> non-remapped address is only needed when calling SetVirtualAddressMap(),
> which never happens during a kexec boot in the first place.
> 
> However, dropping the 'runtime' member from struct efi_setup_data was a
> mistake. That struct is shared ABI between the kernel and the kexec tooling
> for x86, and so we cannot simply change its layout. So let's put back the
> removed field, but call it 'unused' to reflect the fact that we never look
> at its contents. While at it, add a comment to remind our future selves
> that the layout is external ABI.
> 
> Reported-by: Theodore Ts'o <tytso@mit.edu>
> Tested-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> 
> Ingo, Thomas, Boris: I sent out my efi-urgent pull request just yesterday,
> so please take this directly into tip:efi/urgent - no need to wait for the
> next batch.
> 
>  arch/x86/include/asm/efi.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index 781170d36f50..96044c8d8600 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -178,8 +178,10 @@ extern void efi_free_boot_services(void);
>  extern pgd_t * __init efi_uv1_memmap_phys_prolog(void);
>  extern void __init efi_uv1_memmap_phys_epilog(pgd_t *save_pgd);
>  
> +/* kexec external ABI */
>  struct efi_setup_data {
>  	u64 fw_vendor;
> +	u64 unused;
>  	u64 tables;
>  	u64 smbios;
>  	u64 reserved[8];
> -- 
> 2.17.1
> 

Ah, replied too quick in another mail.  I just cced kexec list again.

Thanks for the fix:

Reviewed-by: Dave Young <dyoung@redhat.com>

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
