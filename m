Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFwEK-00267h-V5
 for kexec@lists.infradead.org; Tue, 17 Aug 2021 10:22:05 +0000
Date: Tue, 17 Aug 2021 12:22:33 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 09/12] mm: Remove the now unused mem_encrypt_active()
 function
Message-ID: <YRuN6QhdIQtlluUh@zn.tnic>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <83e4a62108eec470ac0b3f2510b982794d2b7989.1628873970.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <83e4a62108eec470ac0b3f2510b982794d2b7989.1628873970.git.thomas.lendacky@amd.com>
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
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Joerg Roedel <jroedel@suse.de>

On Fri, Aug 13, 2021 at 11:59:28AM -0500, Tom Lendacky wrote:
> The mem_encrypt_active() function has been replaced by prot_guest_has(),
> so remove the implementation.
> 
> Reviewed-by: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  include/linux/mem_encrypt.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
> index 5c4a18a91f89..ae4526389261 100644
> --- a/include/linux/mem_encrypt.h
> +++ b/include/linux/mem_encrypt.h
> @@ -16,10 +16,6 @@
>  
>  #include <asm/mem_encrypt.h>
>  
> -#else	/* !CONFIG_ARCH_HAS_MEM_ENCRYPT */
> -
> -static inline bool mem_encrypt_active(void) { return false; }
> -
>  #endif	/* CONFIG_ARCH_HAS_MEM_ENCRYPT */
>  
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
> -- 

This one wants to be part of the previous patch.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
