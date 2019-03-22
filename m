Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h7Ppk-0005oc-UX
 for kexec@lists.infradead.org; Fri, 22 Mar 2019 19:28:06 +0000
Date: Fri, 22 Mar 2019 20:28:00 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/3 v9] resource: add the new I/O resource descriptor
 'IORES_DESC_RESERVED'
Message-ID: <20190322192800.GM12472@zn.tnic>
References: <20190321103309.27883-1-lijiang@redhat.com>
 <20190321103309.27883-3-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190321103309.27883-3-lijiang@redhat.com>
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
Cc: Thomas.Lendacky@amd.com, x86@kernel.org, bhe@redhat.com, peterz@infradead.org, dave.hansen@linux.intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, luto@kernel.org, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On Thu, Mar 21, 2019 at 06:33:08PM +0800, Lianbo Jiang wrote:
> When doing kexec_file_load, the first kernel needs to pass the e820

Please end function names with parentheses.

> reserved ranges to the second kernel.

... because... ?

> But kernel can not exactly match the e820 reserved ranges
     ^
     the

> when walking through the iomem resources with the descriptor
> 'IORES_DESC_NONE', because several e820 types( e.g.
> E820_TYPE_RESERVED_KERN/E820_TYPE_RAM/E820_TYPE_UNUSABLE/E820
> _TYPE_RESERVED) are converted to the descriptor 'IORES_DESC_NONE'.
> It may pass these four types to the kdump kernel, that is not desired result.

Rewrite that sentence.

> So, this patch adds a new I/O resource descriptor 'IORES_DESC_RESERVED'

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> for the iomem resources search interfaces. It is helpful to exactly
> match the reserved resource ranges when walking through iomem resources.
> 
> In addition, since the new descriptor 'IORES_DESC_RESERVED' is introduced,
> these code originally related to the descriptor 'IORES_DESC_NONE' need to

"the code"

> be updated.

> Otherwise, it will be easily confused and also cause some errors.

What errors?

> Because the 'E820_TYPE_RESERVED' type is converted to the new
> descriptor 'IORES_DESC_RESERVED' instead of 'IORES_DESC_NONE', it has been
> changed.

That sentence I cannot parse.

> Suggested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/x86/kernel/e820.c | 2 +-
>  include/linux/ioport.h | 1 +
>  kernel/resource.c      | 6 +++---
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 2879e234e193..16fcde196243 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -1050,10 +1050,10 @@ static unsigned long __init e820_type_to_iores_desc(struct e820_entry *entry)
>  	case E820_TYPE_NVS:		return IORES_DESC_ACPI_NV_STORAGE;
>  	case E820_TYPE_PMEM:		return IORES_DESC_PERSISTENT_MEMORY;
>  	case E820_TYPE_PRAM:		return IORES_DESC_PERSISTENT_MEMORY_LEGACY;
> +	case E820_TYPE_RESERVED:	return IORES_DESC_RESERVED;
>  	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
>  	case E820_TYPE_RAM:		/* Fall-through: */
>  	case E820_TYPE_UNUSABLE:	/* Fall-through: */
> -	case E820_TYPE_RESERVED:	/* Fall-through: */
>  	default:			return IORES_DESC_NONE;
>  	}
>  }
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index da0ebaec25f0..6ed59de48bd5 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -133,6 +133,7 @@ enum {
>  	IORES_DESC_PERSISTENT_MEMORY_LEGACY	= 5,
>  	IORES_DESC_DEVICE_PRIVATE_MEMORY	= 6,
>  	IORES_DESC_DEVICE_PUBLIC_MEMORY		= 7,
> +	IORES_DESC_RESERVED			= 8,
>  };
>  
>  /* helpers to define resources */

IORES_DESC_RESERVED is supposed to represent E820_TYPE_RESERVED. And if
that is the case, then all three hunks below look wrong to me. If you
want to pass E820_TYPE_RESERVED ranges, then do that explicitly.

> diff --git a/kernel/resource.c b/kernel/resource.c
> index e81b17b53fa5..ee7348761858 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -990,7 +990,7 @@ __reserve_region_with_split(struct resource *root, resource_size_t start,
>  	res->start = start;
>  	res->end = end;
>  	res->flags = type | IORESOURCE_BUSY;
> -	res->desc = IORES_DESC_NONE;
> +	res->desc = IORES_DESC_RESERVED;
>  
>  	while (1) {
>  
> @@ -1025,7 +1025,7 @@ __reserve_region_with_split(struct resource *root, resource_size_t start,
>  				next_res->start = conflict->end + 1;
>  				next_res->end = end;
>  				next_res->flags = type | IORESOURCE_BUSY;
> -				next_res->desc = IORES_DESC_NONE;
> +				next_res->desc = IORES_DESC_RESERVED;
>  			}
>  		} else {
>  			res->start = conflict->end + 1;
> @@ -1488,7 +1488,7 @@ static int __init reserve_setup(char *str)
>  			res->start = io_start;
>  			res->end = io_start + io_num - 1;
>  			res->flags |= IORESOURCE_BUSY;
> -			res->desc = IORES_DESC_NONE;
> +			res->desc = IORES_DESC_RESERVED;
>  			res->child = NULL;
>  			if (request_resource(parent, res) == 0)
>  				reserved = x+1;
> -- 
> 2.17.1
> 

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
