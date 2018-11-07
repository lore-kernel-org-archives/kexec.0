Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gKGEf-0002Ur-8J
 for kexec@lists.infradead.org; Wed, 07 Nov 2018 05:18:39 +0000
Date: Wed, 7 Nov 2018 13:17:45 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/2 v5] x86/kexec_file: add e820 entry in case e820 type
 string matches to io resource name
Message-ID: <20181107051745.GP27491@MiWiFi-R3L-srv>
References: <20181107050019.6663-1-lijiang@redhat.com>
 <20181107050019.6663-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181107050019.6663-2-lijiang@redhat.com>
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
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

Hi Lianbo,

On 11/07/18 at 01:00pm, Lianbo Jiang wrote:
> kdump uses walk_iomem_res_desc() to iterate io resources, then adds matched
> desc to e820 table for kdump kernel.
> 
> But IORES_DESC_NONE resource type includes several different e820 types,

As we discussed privately, better say more clearly what is
"IORES_DESC_NONE resource type includes several different e820 types".

You can tell:

When convert e820 type into iores descriptors, several e820 types are
all converted to IORES_DESC_NONE in function e820_type_to_iores_desc().

Here may no need to list below code if you have told clearly what
happened. Otherwise could you tell what it mean about the sentence:
"IORES_DESC_NONE resource type includes several different e820 types".

They are diffeent types, why one type includes another type, how does it
include? Why it matters when one type includes another type? Why do you
care?

static unsigned long __init e820_type_to_iores_desc(struct e820_entry *entry)                                                                     
{
        switch (entry->type) {
        case E820_TYPE_ACPI:            return IORES_DESC_ACPI_TABLES;
        case E820_TYPE_NVS:             return IORES_DESC_ACPI_NV_STORAGE;
        case E820_TYPE_PMEM:            return IORES_DESC_PERSISTENT_MEMORY;
        case E820_TYPE_PRAM:            return IORES_DESC_PERSISTENT_MEMORY_LEGACY;
        case E820_TYPE_RESERVED_KERN:   /* Fall-through: */
        case E820_TYPE_RAM:             /* Fall-through: */
        case E820_TYPE_UNUSABLE:        /* Fall-through: */
        case E820_TYPE_RESERVED:        /* Fall-through: */
        default:                        return IORES_DESC_NONE;
        }
}

> we need add exact e820 type to kdump kernel e820 table, thus it also needs

Why we need add exact e820 type to kdump kernel e820 table? just because 
"IORES_DESC_NONE resource type includes several different e820 types"?
Why we didn't need it before, why need it now?

Add it for what? Fix a bug/add a feature?

> an extra checking in memmap_entry_callback() to match the e820 type and
> resource name.

This paragraph only tells how you fix it. "IORES_DESC_NONE resource type
includes several different e820 types" only tells a fact. So what's
impacted by the including? Why i'ts impacted?

> 
> Suggested-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/x86/include/asm/e820/api.h | 2 ++
>  arch/x86/kernel/crash.c         | 6 +++++-
>  arch/x86/kernel/e820.c          | 2 +-
>  kernel/resource.c               | 1 +
>  4 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
> index 62be73b23d5c..6d5451b36e80 100644
> --- a/arch/x86/include/asm/e820/api.h
> +++ b/arch/x86/include/asm/e820/api.h
> @@ -42,6 +42,8 @@ extern void e820__register_nosave_regions(unsigned long limit_pfn);
>  
>  extern int  e820__get_entry_type(u64 start, u64 end);
>  
> +extern const char *e820_type_to_string(struct e820_entry *entry);
> +
>  /*
>   * Returns true iff the specified range [start,end) is completely contained inside
>   * the ISA region.
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index f631a3f15587..ae724a6e0a5f 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -37,6 +37,7 @@
>  #include <asm/reboot.h>
>  #include <asm/virtext.h>
>  #include <asm/intel_pt.h>
> +#include <asm/e820/api.h>
>  
>  /* Used while preparing memory map entries for second kernel */
>  struct crash_memmap_data {
> @@ -314,11 +315,14 @@ static int memmap_entry_callback(struct resource *res, void *arg)
>  	struct crash_memmap_data *cmd = arg;
>  	struct boot_params *params = cmd->params;
>  	struct e820_entry ei;
> +	const char *name;
>  
>  	ei.addr = res->start;
>  	ei.size = resource_size(res);
>  	ei.type = cmd->type;
> -	add_e820_entry(params, &ei);
> +	name = e820_type_to_string(&ei);
> +	if (res->name && !strcmp(name, res->name))
> +		add_e820_entry(params, &ei);
>  
>  	return 0;
>  }
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 50895c2f937d..4c1fe4f8db1e 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -1011,7 +1011,7 @@ void __init e820__finish_early_params(void)
>  	}
>  }
>  
> -static const char *__init e820_type_to_string(struct e820_entry *entry)
> +const char *e820_type_to_string(struct e820_entry *entry)
>  {
>  	switch (entry->type) {
>  	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
> diff --git a/kernel/resource.c b/kernel/resource.c
> index b3a3a1fc499e..6285a6b4de6c 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -366,6 +366,7 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
>  	res->end = min(end, p->end);
>  	res->flags = p->flags;
>  	res->desc = p->desc;
> +	res->name = p->name;
>  	return 0;
>  }
>  
> -- 
> 2.17.1
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
