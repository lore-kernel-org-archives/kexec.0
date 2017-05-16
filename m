Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1dAd6I-0007yG-OG
 for kexec@lists.infradead.org; Tue, 16 May 2017 14:05:25 +0000
Date: Tue, 16 May 2017 16:04:49 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 19/32] x86/mm: Add support to access persistent memory
 in the clear
Message-ID: <20170516140449.zmp3sm4krro55bbi@pd.tnic>
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418211941.10190.19751.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170418211941.10190.19751.stgit@tlendack-t1.amdoffice.net>
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
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Apr 18, 2017 at 04:19:42PM -0500, Tom Lendacky wrote:
> Persistent memory is expected to persist across reboots. The encryption
> key used by SME will change across reboots which will result in corrupted
> persistent memory.  Persistent memory is handed out by block devices
> through memory remapping functions, so be sure not to map this memory as
> encrypted.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/mm/ioremap.c |   31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index bce0604..55317ba 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -425,17 +425,46 @@ void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr)
>   * Examine the physical address to determine if it is an area of memory
>   * that should be mapped decrypted.  If the memory is not part of the
>   * kernel usable area it was accessed and created decrypted, so these
> - * areas should be mapped decrypted.
> + * areas should be mapped decrypted. And since the encryption key can
> + * change across reboots, persistent memory should also be mapped
> + * decrypted.
>   */
>  static bool memremap_should_map_decrypted(resource_size_t phys_addr,
>  					  unsigned long size)
>  {
> +	int is_pmem;
> +
> +	/*
> +	 * Check if the address is part of a persistent memory region.
> +	 * This check covers areas added by E820, EFI and ACPI.
> +	 */
> +	is_pmem = region_intersects(phys_addr, size, IORESOURCE_MEM,
> +				    IORES_DESC_PERSISTENT_MEMORY);
> +	if (is_pmem != REGION_DISJOINT)
> +		return true;
> +
> +	/*
> +	 * Check if the non-volatile attribute is set for an EFI
> +	 * reserved area.
> +	 */
> +	if (efi_enabled(EFI_BOOT)) {
> +		switch (efi_mem_type(phys_addr)) {
> +		case EFI_RESERVED_TYPE:
> +			if (efi_mem_attributes(phys_addr) & EFI_MEMORY_NV)
> +				return true;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
>  	/* Check if the address is outside kernel usable area */
>  	switch (e820__get_entry_type(phys_addr, phys_addr + size - 1)) {
>  	case E820_TYPE_RESERVED:
>  	case E820_TYPE_ACPI:
>  	case E820_TYPE_NVS:
>  	case E820_TYPE_UNUSABLE:
> +	case E820_TYPE_PRAM:

Can't you simply add:

	case E820_TYPE_PMEM:

here too and thus get rid of the region_intersects() thing above?

Because, for example, e820_type_to_iores_desc() maps E820_TYPE_PMEM to
IORES_DESC_PERSISTENT_MEMORY so those should be equivalent...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
