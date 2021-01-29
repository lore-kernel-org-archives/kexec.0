Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5OSd-00064p-Hz
 for kexec@lists.infradead.org; Fri, 29 Jan 2021 07:44:57 +0000
Subject: Re: [PATCH] makedumpfile: Add initial mips64 support
References: <1611019046-7291-1-git-send-email-tangyouling@loongson.cn>
 <OSBPR01MB1991974ACAB0FE4FDBEA9182DDB99@OSBPR01MB1991.jpnprd01.prod.outlook.com>
From: Youling Tang <tangyouling@loongson.cn>
Message-ID: <252fde58-3761-5b4c-c882-50ca06134322@loongson.cn>
Date: Fri, 29 Jan 2021 15:44:40 +0800
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB1991974ACAB0FE4FDBEA9182DDB99@OSBPR01MB1991.jpnprd01.prod.outlook.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="iso-2022-jp"; Format="flowed"; DelSp="yes"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= <k-hagio-ab@nec.com>
Cc: Jinyang He <hejinyang@loongson.cn>, kexec-ml <kexec@lists.infradead.org>, Huacai Chen <chenhuacai@loongson.cn>

Hi HAGIO KAZUHITO,

On 01/29/2021 02:13 PM, HAGIO KAZUHITO(萩尾　一仁) wrote:
> Hi Yuling Tang,
>
> -----Original Message-----
>> Patch adds support for mips64 in makedumpfile. It takes care of vmalloc,
>> module and directly map kernel memory region's translation. Currently we
>> only support 3 leverl 16K pages and VA_BITS as 48.
>>
>> The changes were tested on a mips64 Loongson-3A4000 processor. The dump
>> compression and filtering (for all dump levels 1,2,4,8,16 and 31) tests
>> are succussfull.
>>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
>> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
>> ---
>>   Makefile       |   2 +-
>>   arch/mips64.c  | 113 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   makedumpfile.h |  54 +++++++++++++++++++++++++++
>>   3 files changed, 168 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/mips64.c
>>
>> diff --git a/Makefile b/Makefile
>> index cb6bd42..6f8ade0 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -47,7 +47,7 @@ endif
>>   SRC_BASE = makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h sadump_info.h
>>   SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c
>>   OBJ_PART=$(patsubst %.c,%.o,$(SRC_PART))
>> -SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c
>> arch/ppc.c arch/sparc64.c
>> +SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c
>> arch/ppc.c arch/sparc64.c arch/mips64.c
>>   OBJ_ARCH=$(patsubst %.c,%.o,$(SRC_ARCH))
>>
>>   LIBS = -ldw -lbz2 -ldl -lelf -lz
>> diff --git a/arch/mips64.c b/arch/mips64.c
>> new file mode 100644
>> index 0000000..18a9e05
>> --- /dev/null
>> +++ b/arch/mips64.c
>> @@ -0,0 +1,113 @@
>> +/*
>> + * mips64.c
>> + *
>> + * Copyright (C) 2021 Loongson Technology Co., Ltd.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation (version 2 of the License).
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>> + */
>> +#ifdef __mips64__
>> +
>> +#include "../print_info.h"
>> +#include "../elf_info.h"
>> +#include "../makedumpfile.h"
>> +
>> +int
>> +get_phys_base_mips64(void)
>> +{
>> +	info->phys_base = 0ULL;
>> +
>> +	DEBUG_MSG("phys_base    : %lx\n", info->phys_base);
>> +
>> +	return TRUE;
>> +}
>> +
>> +int
>> +get_versiondep_info_mips64(void)
>> +{
>> +	info->page_offset  = 0x9800000000000000ULL;
>> +	info->max_physmem_bits  = _MAX_PHYSMEM_BITS;
>> +	info->section_size_bits = _SECTION_SIZE_BITS;
>> +
>> +	DEBUG_MSG("page_offset : %lx\n", info->page_offset);
>> +	DEBUG_MSG("max_physmem_bits : %lx\n", info->max_physmem_bits);
>> +	DEBUG_MSG("section_size_bits: %lx\n", info->section_size_bits);
>> +
>> +	return TRUE;
>> +}
>> +
>> +/*
>> + * Translate a virtual address to a physical address by using 3 levels paging.
>> + */
>> +unsigned long long
>> +vaddr_to_paddr_mips64(unsigned long vaddr)
>> +{
>> +	unsigned long long paddr = NOT_PADDR;
>> +	pgd_t	*pgda, pgdv;
>> +	pmd_t	*pmda, pmdv;
>> +	pte_t 	*ptea, ptev;
>> +
>> +	/*
>> +	 * CKSEG0/CKSEG1
>> +	 */
>> +	if (vaddr >= 0xffffffff80000000ULL && vaddr < 0xffffffffc0000000ULL)
>> +		return vaddr & 0x1fffffffULL;
>> +
>> +	/*
>> +	 * XKPHYS
>> +	 */
>> +	if (vaddr >= 0x9000000000000000ULL && vaddr < 0xc000000000000000ULL)
>> +		return vaddr & ((1ULL << MAX_PHYSMEM_BITS()) - 1);
>  From the current implementation, vaddr_to_paddr() is called the first time
> in the context of:
>
> initial()
>    get_machdep_info()
>    calibrate_machdep_info()
>    check_release()
>      readmem()
>        vaddr_to_paddr()
>    get_versiondep_info()
>
> So setting info->max_physmem_bits in get_versiondep_info() is late,
> but it might work because
> - The address that the readmem() reads is SYMBOL(init_uts_ns), so
>    this XKPHYS condition does not match,  or/and
> - 5.9+ kernels have NUMBER(MAX_PHYSMEM_BITS) entry in vmcoreinfo, so
>    info->max_physmem_bits is set in calibrate_machdep_info().
>
> So I would suggest moving max_physmem_bits and section_size_bits to
> get_machdep_info() for future changes and to not confuse readers.. (including me :-)
>
> Otherwise, looks good to me.  Thank you for using makedumpfile!
Thank you for your reply and suggestions.
I will move max_physmem_bits and section_size_bits to
get_machdep_info_mips64() in V2.

Thanks,
Youling.
>
> Kazu
>
>> +
>> +	if (SYMBOL(swapper_pg_dir) == NOT_FOUND_SYMBOL) {
>> +		ERRMSG("Can't get the symbol of swapper_pg_dir.\n");
>> +		return NOT_PADDR;
>> +	}
>> +
>> +	pgda = pgd_offset(SYMBOL(swapper_pg_dir), vaddr);
>> +	if (!readmem(PADDR, (unsigned long long)pgda, &pgdv, sizeof(pgdv))) {
>> +		ERRMSG("Can't read pgd\n");
>> +		return NOT_PADDR;
>> +	}
>> +
>> +	pmda = pmd_offset(&pgdv, vaddr);
>> +	if (!readmem(PADDR, (unsigned long long)pmda, &pmdv, sizeof(pmdv))) {
>> +		ERRMSG("Can't read pmd\n");
>> +		return NOT_PADDR;
>> +	}
>> +
>> +	switch (pmdv & (_PAGE_PRESENT|_PAGE_HUGE)) {
>> +	case _PAGE_PRESENT:
>> +		ptea = pte_offset(&pmdv, vaddr);
>> +		/* 64k page */
>> +		if (!readmem(PADDR, (unsigned long long)ptea, &ptev, sizeof(ptev))) {
>> +			ERRMSG("Can't read pte\n");
>> +			return NOT_PADDR;
>> +		}
>> +
>> +		if (!(ptev & _PAGE_PRESENT)) {
>> +			ERRMSG("Can't get a valid pte.\n");
>> +			return NOT_PADDR;
>> +		} else {
>> +			paddr = PAGEBASE(ptev) + (vaddr & (PAGESIZE() - 1));
>> +		}
>> +		break;
>> +	case _PAGE_PRESENT|_PAGE_HUGE:
>> +		paddr = (pmdv & PMD_MASK) + (vaddr & (PMD_SIZE - 1));
>> +		break;
>> +	}
>> +
>> +	return paddr;
>> +}
>> +
>> +#endif /* mips64 */
>> diff --git a/makedumpfile.h b/makedumpfile.h
>> index 5f50080..bc86bf2 100644
>> --- a/makedumpfile.h
>> +++ b/makedumpfile.h
>> @@ -958,6 +958,39 @@ typedef unsigned long pgd_t;
>>
>>   #endif          /* sparc64 */
>>
>> +#ifdef __mips64__ /* mips64 */
>> +#define KVBASE			PAGE_OFFSET
>> +#define _SECTION_SIZE_BITS	(28)
>> +#define _MAX_PHYSMEM_BITS	(48)
>> +#define _PAGE_PRESENT		(1 << 0)
>> +#define _PAGE_HUGE		(1 << 4)
>> +
>> +typedef unsigned long pte_t;
>> +typedef unsigned long pmd_t;
>> +typedef unsigned long pgd_t;
>> +
>> +#define PAGE_MASK		(~(PAGESIZE() - 1))
>> +#define PMD_MASK		(~(PMD_SIZE - 1))
>> +#define PMD_SHIFT		((PAGESHIFT() - 3) * 2 + 3)
>> +#define PMD_SIZE		(1UL << PMD_SHIFT)
>> +#define PGDIR_SHIFT		((PAGESHIFT() - 3) * 3 + 3)
>> +#define PTRS_PER_PTE		(1 << (PAGESHIFT() - 3))
>> +#define PTRS_PER_PMD		PTRS_PER_PTE
>> +#define PTRS_PER_PGD		PTRS_PER_PTE
>> +
>> +#define pte_index(vaddr)		(((vaddr) >> PAGESHIFT()) & (PTRS_PER_PTE - 1))
>> +#define pmd_page_paddr(pmd)		(pmd & (int32_t)PAGE_MASK)
>> +#define pte_offset(dir, vaddr)		((pte_t *)pmd_page_paddr((*dir)) + pte_index(vaddr))
>> +
>> +#define pmd_index(vaddr)		(((vaddr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
>> +#define pgd_page_paddr(pgd)		(pgd & (int32_t)PAGE_MASK)
>> +#define pmd_offset(pgd, vaddr)		((pmd_t *)pgd_page_paddr((*pgd)) + pmd_index(vaddr))
>> +
>> +#define pgd_index(vaddr)		(((vaddr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
>> +#define pgd_offset(pgdir, vaddr)	((pgd_t *)(pgdir) + pgd_index(vaddr))
>> +
>> +#endif		/* mips64 */
>> +
>>   /*
>>    * The function of dependence on machine
>>    */
>> @@ -1112,6 +1145,21 @@ unsigned long long vaddr_to_paddr_sparc64(unsigned long vaddr);
>>   #define arch_crashkernel_mem_size()	stub_false()
>>   #endif		/* sparc64 */
>>
>> +#ifdef __mips64__ /* mips64 */
>> +int get_phys_base_mips64(void);
>> +int get_versiondep_info_mips64(void);
>> +unsigned long long vaddr_to_paddr_mips64(unsigned long vaddr);
>> +#define find_vmemmap()		stub_false()
>> +#define get_phys_base() 	get_phys_base_mips64()
>> +#define get_machdep_info()	stub_true()
>> +#define get_versiondep_info()	get_versiondep_info_mips64()
>> +#define get_kaslr_offset(X)	stub_false()
>> +#define vaddr_to_paddr(X)	vaddr_to_paddr_mips64(X)
>> +#define paddr_to_vaddr(X)	paddr_to_vaddr_general(X)
>> +#define is_phys_addr(X) 	stub_true_ul(X)
>> +#define arch_crashkernel_mem_size()	stub_false()
>> +#endif		/* mips64 */
>> +
>>   typedef unsigned long long mdf_pfn_t;
>>
>>   #ifndef ARCH_PFN_OFFSET
>> @@ -2228,6 +2276,12 @@ int get_xen_info_ia64(void);
>>   #define get_xen_info_arch(X) FALSE
>>   #endif	/* sparc64 */
>>
>> +#ifdef __mips64__ /* mips64 */
>> +#define kvtop_xen(X)	FALSE
>> +#define get_xen_basic_info_arch(X) FALSE
>> +#define get_xen_info_arch(X) FALSE
>> +#endif	/* mips64 */
>> +
>>   struct cycle {
>>   	mdf_pfn_t start_pfn;
>>   	mdf_pfn_t end_pfn;
>> --
>> 2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
