Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gRNs6-0005Uq-BL
 for kexec@lists.infradead.org; Mon, 26 Nov 2018 20:52:47 +0000
Subject: Re: [PATCH 1/2 RESEND v7] resource: add the new I/O resource
 descriptor 'IORES_DESC_RESERVED'
References: <20181124051223.19994-1-lijiang@redhat.com>
 <20181124051223.19994-2-lijiang@redhat.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <ae405fe9-94fd-3fb7-decd-c7821cf95b7d@intel.com>
Date: Mon, 26 Nov 2018 12:52:33 -0800
MIME-Version: 1.0
In-Reply-To: <20181124051223.19994-2-lijiang@redhat.com>
Content-Language: en-US
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
To: Lianbo Jiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org
Cc: fenghua.yu@intel.com, linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org, bhe@redhat.com, ard.biesheuvel@linaro.org, peterz@infradead.org, x86@kernel.org, kexec@lists.infradead.org, tony.luck@intel.com, dave.hansen@linux.intel.com, mingo@redhat.com, bp@alien8.de, luto@kernel.org, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On 11/23/18 9:12 PM, Lianbo Jiang wrote:
> The upstream kernel can not accurately add the e820 reserved type to> kdump krenel e820 table.

	^ kernel

> Kdump uses walk_iomem_res_desc() to iterate io resources, then adds
> the matched resource ranges to the e820 table for kdump kernel. But,
> when convert the e820 type to the iores descriptor, several e820
> types are converted to 'IORES_DESC_NONE' in this function e820_type
> _to_iores_desc(). So the walk_iomem_res_desc() will get the redundant
> types(such as E820_TYPE_RAM/E820_TYPE_UNUSABLE/E820_TYPE_KERN) when
> walk through io resources with the descriptor 'IORES_DESC_NONE'.

Let me see if I understand.

When doing kexec, the old kernel makes a new e820 table for the new
kernel.  The old kernel constructs the new e820 table from
'iomem_resource'.  But, when creating the 'iomem_resource' tree,
reserved areas like E820_TYPE_RESERVED are not properly passed through.
 This causes problems like described in the next patch.

> This patch adds the new I/O resource descriptor 'IORES_DESC_RESERVED'
> for the iomem resources search interfaces. It is helpful to exactly
> match the reserved resource ranges when walking through iomem resources.

It's more than that, though.  You're specifically storing the reserved
area(s) when we see them come through the firmware.

> Furthermore, in order to make it still work after the new descriptor
> is added, these codes originally related to 'IORES_DESC_NONE' have
> been updated.

It would be nice to explain why they needed to be updated and what
breaks if they are not.

> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 5378d10f1d31..91b6112e7489 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -83,7 +83,14 @@ static bool __ioremap_check_ram(struct resource *res)
>  
>  static int __ioremap_check_desc_other(struct resource *res)
>  {
> -	return (res->desc != IORES_DESC_NONE);
> +	/*
> +	 * The E820_TYPE_RESERVED was converted to the IORES_DESC_NONE
> +	 * before the new IORES_DESC_RESERVED is added, so it contained
> +	 * the e820 reserved type. In order to make it still work for
> +	 * SEV, here keep it the same as before.
> +	 */
> +	return ((res->desc != IORES_DESC_NONE) ||
> +		(res->desc != IORES_DESC_RESERVED));
>  }

After reading the changelog and the comment, I still have no idea why
this hunk is here.  Could you try to explain a bit more?



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
