Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v3 07/17] arm64, hibernate: move page handling function to
 new trans_pgd.c
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-8-pasha.tatashin@soleen.com>
Message-ID: <f1db863a-de57-2d1a-6bec-6020b2130964@arm.com>
Date: Fri, 6 Sep 2019 16:18:37 +0100
MIME-Version: 1.0
In-Reply-To: <20190821183204.23576-8-pasha.tatashin@soleen.com>
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
Cc: sashal@kernel.org, mark.rutland@arm.com, vladimir.murzin@arm.com, corbet@lwn.net, marc.zyngier@arm.com, catalin.marinas@arm.com, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, linux-mm@kvack.org, ebiederm@xmission.com, matthias.bgg@gmail.com, will@kernel.org, linux-arm-kernel@lists.infradead.org

Hi Pavel,

On 21/08/2019 19:31, Pavel Tatashin wrote:
> Now, that we abstracted the required functions move them to a new home.
> Later, we will generalize these function in order to be useful outside
> of hibernation.

> diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
> new file mode 100644
> index 000000000000..00b62d8640c2
> --- /dev/null
> +++ b/arch/arm64/mm/trans_pgd.c
> @@ -0,0 +1,211 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (c) 2019, Microsoft Corporation.
> + * Pavel Tatashin <patatash@linux.microsoft.com>

Hmmm, while line-count isn't a useful metric: this file contains 41% of the code that was
in hibernate.c, but has stripped the substantial copyright-pedigree that the hibernate
code had built up over the years.
(counting lines identified by 'cloc' as code, not comments or blank)

If you are copying or moving a non trivial quantity of code, you need to preserve the
copyright. Something like 'Derived from the arm64 hibernate support which has:'....


> + */
> +
> +/*
> + * Transitional tables are used during system transferring from one world to
> + * another: such as during hibernate restore, and kexec reboots. During these
> + * phases one cannot rely on page table not being overwritten.

I think you need to mention that hibernate and kexec are rewriting memory, and may
overwrite the live page tables, therefore ...


> + *
> + */
> +
> +#include <asm/trans_pgd.h>
> +#include <asm/pgalloc.h>
> +#include <asm/pgtable.h>
> +#include <linux/suspend.h>

#include <linux/bug.h>
#include <linux/mm.h>
#include <linux/mmzone.h>


> +static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
> +{
> +	pte_t pte = READ_ONCE(*src_ptep);
> +

> +	if (pte_valid(pte)) {

> +		/*
> +		 * Resume will overwrite areas that may be marked
> +		 * read only (code, rodata). Clear the RDONLY bit from
> +		 * the temporary mappings we use during restore.
> +		 */
> +		set_pte(dst_ptep, pte_mkwrite(pte));

> +	} else if (debug_pagealloc_enabled() && !pte_none(pte)) {

> +		/*
> +		 * debug_pagealloc will removed the PTE_VALID bit if
> +		 * the page isn't in use by the resume kernel. It may have
> +		 * been in use by the original kernel, in which case we need
> +		 * to put it back in our copy to do the restore.
> +		 *
> +		 * Before marking this entry valid, check the pfn should
> +		 * be mapped.
> +		 */

> +		BUG_ON(!pfn_valid(pte_pfn(pte)));


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
