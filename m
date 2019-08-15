Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v1 2/8] arm64, mm: transitional tables
References: <20190801152439.11363-1-pasha.tatashin@soleen.com>
 <20190801152439.11363-3-pasha.tatashin@soleen.com>
From: James Morse <james.morse@arm.com>
Message-ID: <e00455af-a9f6-82e1-4c0d-78fae01ae00a@arm.com>
Date: Thu, 15 Aug 2019 19:11:15 +0100
MIME-Version: 1.0
In-Reply-To: <20190801152439.11363-3-pasha.tatashin@soleen.com>
Content-Language: en-GB
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: sashal@kernel.org, vladimir.murzin@arm.com, corbet@lwn.net, marc.zyngier@arm.com, catalin.marinas@arm.com, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, linux-mm@kvack.org, ebiederm@xmission.com, matthias.bgg@gmail.com, will@kernel.org, linux-arm-kernel@lists.infradead.org

Hi Pavel,

On 01/08/2019 16:24, Pavel Tatashin wrote:
> There are cases where normal kernel pages tables, i.e. idmap_pg_dir
> and swapper_pg_dir are not sufficient because they may be overwritten.
> 
> This happens when we transition from one world to another: for example
> during kexec kernel relocation transition, and also during hibernate
> kernel restore transition.
> 
> In these cases, if MMU is needed, the page table memory must be allocated
> from a safe place. Transitional tables is intended to allow just that.

> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index db92950bb1a0..dcb4f13c7888 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -110,6 +110,7 @@
>  #define PUD_TABLE_BIT		(_AT(pudval_t, 1) << 1)
>  #define PUD_TYPE_MASK		(_AT(pudval_t, 3) << 0)
>  #define PUD_TYPE_SECT		(_AT(pudval_t, 1) << 0)
> +#define PUD_SECT_RDONLY		(_AT(pudval_t, 1) << 7)		/* AP[2] */

This shouldn't be needed. As far as I'm aware, we only get read-only pages in the linear
map from debug-pagealloc, and the module aliases. Both of which require the linear map to
be made of page-size mappings.

Where are you seeing these?


> diff --git a/arch/arm64/include/asm/trans_table.h b/arch/arm64/include/asm/trans_table.h
> new file mode 100644
> index 000000000000..c7aef70587a1
> --- /dev/null
> +++ b/arch/arm64/include/asm/trans_table.h
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (c) 2019, Microsoft Corporation.
> + * Pavel Tatashin <patatash@linux.microsoft.com>
> + */
> +
> +#ifndef _ASM_TRANS_TABLE_H
> +#define _ASM_TRANS_TABLE_H
> +
> +#include <linux/bits.h>
> +#include <asm/pgtable-types.h>
> +
> +/*
> + * trans_alloc_page
> + *	- Allocator that should return exactly one uninitilaized page, if this
> + *	 allocator fails, trans_table returns -ENOMEM error.
> + *
> + * trans_alloc_arg
> + *	- Passed to trans_alloc_page as an argument
> + *
> + * trans_flags
> + *	- bitmap with flags that control how page table is filled.
> + *	  TRANS_MKWRITE: during page table copy make PTE, PME, and PUD page
> + *			 writeable by removing RDONLY flag from PTE.
> + *	  TRANS_MKVALID: during page table copy, if PTE present, but not valid,
> + *			 make it valid.
> + *	  TRANS_CHECKPFN: During page table copy, for every PTE entry check that
> + *			  PFN that this PTE points to is valid. Otherwise return
> + *			  -ENXIO

Adding top-level global knobs to manipulate the copied linear map is going to lead to
bugs. The existing code will only change the PTE in specific circumstances, that it tests
for, that only happen at the PTE level.


> + *	  TRANS_FORCEMAP: During page map, if translation exists, force
> + *			  overwrite it. Otherwise -ENXIO may be returned by
> + *			  trans_table_map_* functions if conflict is detected.

This one, sounds like a very bad idea.


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
