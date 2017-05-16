Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dAcbe-0001VR-3f
 for kexec@lists.infradead.org; Tue, 16 May 2017 13:33:44 +0000
Subject: Re: [PATCH] sparc64: Add initial sparc64 support
References: <1494345865-430884-1-git-send-email-tom.hromatka@oracle.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701ED623C@BPXM01GP.gisp.nec.co.jp>
 <6427edb3-e2c9-960c-b78f-353e62518f17@oracle.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701ED6940@BPXM01GP.gisp.nec.co.jp>
From: Tom Hromatka <tom.hromatka@oracle.com>
Message-ID: <9661e47d-57fc-03ed-a290-742f6f30bb72@oracle.com>
Date: Tue, 16 May 2017 07:33:09 -0600
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701ED6940@BPXM01GP.gisp.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, "tom.hromatka@gmail.com" <tom.hromatka@gmail.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>



On 05/15/2017 08:04 PM, Atsushi Kumagai wrote:
>> On 05/14/2017 10:32 PM, Atsushi Kumagai wrote:
>>> Hello Tom,
>>>
>>>> This commit adds support for sparc64. The changes were tested on a
>>>> sparc64 T7-2 processor with 2 TB of RAM
>>> Thanks for your work, what kernel version does this patch support ?
>> I tested it on 4.1.12.  I am trying to test it on 4.11.0 as well, but I
>> am running into problems unrelated to kexec.
> Sure, I note this test result.
>
>>> I can't test for sparc64, so I hope you maintain this code.
>>> Anyway, I'll merge this into v1.6.2.
>> You can add me as the maintainer for sparc64.  Thanks.
> Thank you, too !
>
>>> BTW, I have a trivial question below.
>>>
>>>> ---
>>>> Makefile       |    6 +-
>>>> arch/sparc64.c |  236 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>> makedumpfile.h |  110 ++++++++++++++++++++++++++
>>>> 3 files changed, 350 insertions(+), 2 deletions(-)
>>>> create mode 100644 arch/sparc64.c
>>>>
>>>> diff --git a/Makefile b/Makefile
>>>> index 8b0fd24..4d96490 100644
>>>> --- a/Makefile
>>>> +++ b/Makefile
>>>> @@ -48,11 +48,13 @@ endif
>>>> SRC_BASE = makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h sadump_info.h
>>>> SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c
>>>> OBJ_PART=$(patsubst %.c,%.o,$(SRC_PART))
>>>> -SRC_ARCH = arch/arm.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c
>>>> -SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c
>>>> +SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c
>>>> arch/sparc64.c
>>>> OBJ_ARCH=$(patsubst %.c,%.o,$(SRC_ARCH))
>>>>
>>>> LIBS = -ldw -lbz2 -lebl -ldl -lelf -lz
>>>> +ifeq ($(ARCH), sparc64)
>>>> +LIBS += -llzma
>>>> +endif
>>> Why lzma is required only on sparc64 ?
>> I assumed it was a sparc-specific problem.  On sparc64, I was seeing errors
>> like the following:
>>
>> /usr/lib/gcc/sparc64-redhat-linux/4.4.7/../../../../lib64/libdw.a(lzma.o):
>> In function `__libdw_unlzma':
>> (.text+0x19c): undefined reference to `lzma_auto_decoder'
>>
>> But I tried building makedumpfile in an x86/64 VM, and also saw similar
>> errors:
>>
>> /home/thromatka/git/elfutils-0.169/libdwfl/gzip.c:233: undefined
>> reference to `lzma_auto_decoder'
>>
>> Perhaps it was the way I built elfutils?  Thoughts?
> Actually, elfutils requires liblzma as you said.
>
>    $ rpm -qf /usr/lib64/libdw.so.1
>    elfutils-libs-0.152-1.el6.x86_64
>    $ ldd /usr/lib64/libdw.so.1
>            linux-vdso.so.1 =>  (0x00007fff0917d000)
>            libelf.so.1 => /usr/lib64/libelf.so.1 (0x0000003085200000)
>            libdl.so.2 => /lib64/libdl.so.2 (0x0000003083e00000)
>            liblzma.so.0 => /usr/lib64/liblzma.so.0 (0x000000308ee00000)
>            libbz2.so.1 => /lib64/libbz2.so.1 (0x0000003097200000)
>            libz.so.1 => /lib64/libz.so.1 (0x0000003084200000)
>            libc.so.6 => /lib64/libc.so.6 (0x0000003083600000)
>            /lib64/ld-linux-x86-64.so.2 (0x0000563009dfc000)
>            libpthread.so.0 => /lib64/libpthread.so.0 (0x0000003083a00000)
>    $
>
> It seems that -llzma is necessary if the library is static.
> At least this is not a sparc64 issue, so I'll get rid of the code below
> and fix it in another commit, is this fine with you ?

Sounds like a good plan to me.  Thanks for the help.

Tom


>
>    +ifeq ($(ARCH), sparc64)
>    +LIBS += -llzma
>    +endif
>
>
> Thanks,
> Atsushi Kumagai
>
>>> Thanks,
>>> Atsushi Kumagai
>>>
>>>> ifneq ($(LINKTYPE), dynamic)
>>>> LIBS := -static $(LIBS)
>>>> endif
>>>> diff --git a/arch/sparc64.c b/arch/sparc64.c
>>>> new file mode 100644
>>>> index 0000000..1cfaa85
>>>> --- /dev/null
>>>> +++ b/arch/sparc64.c
>>>> @@ -0,0 +1,236 @@
>>>> +/*
>>>> + * Copyright (C) 2014, 2017 Oracle and/or its affiliates
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License as published by
>>>> + * the Free Software Foundation (version 2 of the License).
>>>> + *
>>>> + * This program is distributed in the hope that it will be useful,
>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> + * GNU General Public License for more details.
>>>> + *
>>>> + * You should have received a copy of the GNU General Public License
>>>> + * along with this program; if not, write to the Free Software
>>>> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>>>> + */
>>>> +
>>>> +#ifdef __sparc64__
>>>> +
>>>> +#include "../elf_info.h"
>>>> +#include "../makedumpfile.h"
>>>> +#include "../print_info.h"
>>>> +
>>>> +int get_versiondep_info_sparc64(void)
>>>> +{
>>>> +	info->section_size_bits = _SECTION_SIZE_BITS;
>>>> +
>>>> +	if (info->kernel_version >= KERNEL_VERSION(3, 8, 13))
>>>> +		info->max_physmem_bits = _MAX_PHYSMEM_BITS_L4;
>>>> +	else {
>>>> +		info->max_physmem_bits = _MAX_PHYSMEM_BITS_L3;
>>>> +		info->flag_vmemmap = TRUE;
>>>> +		info->vmemmap_start = VMEMMAP_BASE_SPARC64;
>>>> +		info->vmemmap_end = VMEMMAP_BASE_SPARC64 +
>>>> +			((1UL << (info->max_physmem_bits - PAGE_SHIFT)) *
>>>> +			 SIZE(page));
>>>> +	}
>>>> +
>>>> +	return TRUE;
>>>> +}
>>>> +
>>>> +int get_phys_base_sparc64(void)
>>>> +{
>>>> +	/* Ideally we'd search the pt_load entries until we found one
>>>> +	 * containing KVBASE (_stext), but get_symbol_info hasn't been
>>>> +	 * called yet. We'll just go with the first entry.
>>>> +	 */
>>>> +	unsigned long long phys_start;
>>>> +	unsigned long long virt_start;
>>>> +	unsigned long long virt_end;
>>>> +
>>>> +	if (get_pt_load(0, &phys_start, NULL, &virt_start, &virt_end)) {
>>>> +		info->phys_base = phys_start & ~KVBASE_MASK;
>>>> +		return TRUE;
>>>> +	}
>>>> +	ERRMSG("Can't find kernel segment\n");
>>>> +	return FALSE;
>>>> +}
>>>> +
>>>> +int is_vmalloc_addr_sparc64(unsigned long vaddr)
>>>> +{
>>>> +	return (vaddr >= VMALLOC_START_SPARC64);
>>>> +}
>>>> +
>>>> +int is_vmemmap_addr_sparc64(unsigned long vaddr)
>>>> +{
>>>> +	if (info->flag_vmemmap &&
>>>> +	    (vaddr >= info->vmemmap_start) && (vaddr < info->vmemmap_end))
>>>> +		return TRUE;
>>>> +
>>>> +	return FALSE;
>>>> +}
>>>> +
>>>> +unsigned long vmemmap_to_phys_sparc64(unsigned long vaddr)
>>>> +{
>>>> +	unsigned long vmemmap_table;
>>>> +	unsigned long offset = vaddr - info->vmemmap_start;
>>>> +	unsigned long chunk_offset = offset & ~VMEMMAP_CHUNK_MASK;
>>>> +	unsigned long chunk;
>>>> +	unsigned long index;
>>>> +	unsigned long pte;
>>>> +	unsigned long pte_paddr;
>>>> +	unsigned long pte_offset;
>>>> +
>>>> +	vmemmap_table = SYMBOL(vmemmap_table);
>>>> +	if (vmemmap_table == NOT_FOUND_SYMBOL) {
>>>> +		ERRMSG("Can't get symbol of vmemmap_table\n");
>>>> +		return NOT_PADDR;
>>>> +	}
>>>> +
>>>> +	index = offset >> NR_CHUNKS_SHIFT;
>>>> +	if (!readmem(VADDR, vmemmap_table + (index * sizeof(long)),
>>>> +		     &pte_paddr, sizeof(long))) {
>>>> +		ERRMSG("Error reading 1st level vmemmap_table\n");
>>>> +		return NOT_PADDR;
>>>> +	}
>>>> +	chunk = (vaddr & ~NR_CHUNKS_MASK) >> VMEMMAP_CHUNK_SHIFT;
>>>> +	pte_offset = chunk * sizeof(pte);
>>>> +	pte_paddr += pte_offset;
>>>> +	if (!readmem(PADDR, pte_paddr, &pte, sizeof(pte))) {
>>>> +		ERRMSG("Error reading 2nd level vmemmap_table\n");
>>>> +		return NOT_PADDR;
>>>> +	}
>>>> +	return pte_to_pa(pte) | chunk_offset;
>>>> +}
>>>> +
>>>> +unsigned long vtop3_sparc64(unsigned long vaddr)
>>>> +{
>>>> +	unsigned long pgdir, pgd_paddr, pmd_paddr, pte_paddr;
>>>> +	unsigned long pgd_pte, pmd_pte, pte;
>>>> +
>>>> +	pgdir = SYMBOL(swapper_pg_dir);
>>>> +	if (pgdir == NOT_FOUND_SYMBOL) {
>>>> +		ERRMSG("Can't get symbol of swapper_pg_dir\n");
>>>> +		return NOT_PADDR;
>>>> +	}
>>>> +
>>>> +	pgd_paddr = pgd_offset_l3(pgdir, vaddr);
>>>> +	if (!readmem(VADDR, pgd_paddr, &pgd_pte, sizeof pgd_pte)) {
>>>> +		ERRMSG("Can't get pgd_pte, pgd_paddr = 0x%lx\n", pgd_paddr);
>>>> +		return NOT_PADDR;
>>>> +	}
>>>> +	if (pgd_none(pgd_pte)) {
>>>> +		ERRMSG("Can't get a valid pgd_pte.\n");
>>>> +		return NOT_PADDR;
>>>> +	}
>>>> +
>>>> +	pmd_paddr = pmd_offset(pgd_pte, vaddr);
>>>> +	if (!readmem(PADDR, pmd_paddr, &pmd_pte, sizeof pmd_pte)) {
>>>> +		ERRMSG("Can't get pmd_pte, pmd_paddr = 0x%lx\n", pmd_paddr);
>>>> +		return NOT_PADDR;
>>>> +	}
>>>> +	if (pmd_none(pmd_pte)) {
>>>> +		ERRMSG("Can't get a valid pmd_pte.\n");
>>>> +		return NOT_PADDR;
>>>> +	}
>>>> +
>>>> +	if (pmd_large(pmd_pte))
>>>> +		return pte_to_pa(pmd_pte) + (vaddr & ~PMD_MASK);
>>>> +
>>>> +	pte_paddr = pte_offset(pmd_pte, vaddr);
>>>> +	if (!readmem(PADDR, pte_paddr, &pte, sizeof pte)) {
>>>> +		ERRMSG("Can't get pte, pte_paddr = 0x%lx\n", pmd_paddr);
>>>> +		return NOT_PADDR;
>>>> +	}
>>>> +	if (!pte_present(pte)) {
>>>> +		ERRMSG("Can't get a valid pte.\n");
>>>> +		return NOT_PADDR;
>>>> +	}
>>>> +
>>>> +	return pte_to_pa(pte) + (vaddr & ~PAGE_MASK);
>>>> +}
>>>> +
>>>> +unsigned long vtop4_sparc64(unsigned long vaddr)
>>>> +{
>>>> +	unsigned long pgdir, pgd_paddr, pud_paddr, pmd_paddr, pte_paddr;
>>>> +	unsigned long pgd_pte, pud_pte, pmd_pte, pte;
>>>> +
>>>> +	pgdir = SYMBOL(swapper_pg_dir);
>>>> +	if (pgdir == NOT_FOUND_SYMBOL) {
>>>> +		ERRMSG("Can't get symbol of swapper_pg_dir\n");
>>>> +		return NOT_PADDR;
>>>> +	}
>>>> +
>>>> +	pgd_paddr = pgd_offset_l4(pgdir, vaddr);
>>>> +	if (!readmem(VADDR, pgd_paddr, &pgd_pte, sizeof pgd_pte)) {
>>>> +		ERRMSG("Can't get pgd_pte, pgd_paddr = 0x%lx\n", pgd_paddr);
>>>> +		return NOT_PADDR;
>>>> +	}
>>>> +	if (pgd_none(pgd_pte)) {
>>>> +		ERRMSG("Can't get a valid pgd_pte.\n");
>>>> +		return NOT_PADDR;
>>>> +	}
>>>> +
>>>> +	pud_paddr = pud_offset(pgd_pte, vaddr);
>>>> +	if (!readmem(PADDR, pud_paddr, &pud_pte, sizeof pud_pte)) {
>>>> +		ERRMSG("Can't get pud_pte, pud_paddr = 0x%lx\n", pud_paddr);
>>>> +		return NOT_PADDR;
>>>> +	}
>>>> +	if (pud_none(pud_pte)) {
>>>> +		ERRMSG("Can't get a valid pud_pte.\n");
>>>> +		return NOT_PADDR;
>>>> +	}
>>>> +
>>>> +	if (pud_large(pud_pte))
>>>> +		return pte_to_pa(pud_pte) + (vaddr & ~PUD_MASK);
>>>> +
>>>> +	pmd_paddr = pmd_offset(pud_pte, vaddr);
>>>> +	if (!readmem(PADDR, pmd_paddr, &pmd_pte, sizeof pmd_pte)) {
>>>> +		ERRMSG("Can't get pmd_pte, pmd_paddr = 0x%lx\n", pmd_paddr);
>>>> +		return NOT_PADDR;
>>>> +	}
>>>> +	if (pmd_none(pmd_pte)) {
>>>> +		ERRMSG("Can't get a valid pmd_pte.\n");
>>>> +		return NOT_PADDR;
>>>> +	}
>>>> +
>>>> +	if (pmd_large(pmd_pte))
>>>> +		return pte_to_pa(pmd_pte) + (vaddr & ~PMD_MASK);
>>>> +
>>>> +	pte_paddr = pte_offset(pmd_pte, vaddr);
>>>> +	if (!readmem(PADDR, pte_paddr, &pte, sizeof pte)) {
>>>> +		ERRMSG("Can't get pte, pte_paddr = 0x%lx\n", pmd_paddr);
>>>> +		return NOT_PADDR;
>>>> +	}
>>>> +	if (!pte_present(pte)) {
>>>> +		ERRMSG("Can't get a valid pte.\n");
>>>> +		return NOT_PADDR;
>>>> +	}
>>>> +
>>>> +	return pte_to_pa(pte) + (vaddr & ~PAGE_MASK);
>>>> +}
>>>> +
>>>> +unsigned long long vaddr_to_paddr_sparc64(unsigned long vaddr)
>>>> +{
>>>> +	unsigned long paddr;
>>>> +
>>>> +	paddr = vaddr_to_paddr_general(vaddr);
>>>> +	if (paddr != NOT_PADDR)
>>>> +		return paddr;
>>>> +
>>>> +	if (is_vmemmap_addr_sparc64(vaddr))
>>>> +		paddr = vmemmap_to_phys_sparc64(vaddr);
>>>> +	else if (is_vmalloc_addr_sparc64(vaddr)) {
>>>> +		if (info->kernel_version >= KERNEL_VERSION(3, 8, 13))
>>>> +			paddr = vtop4_sparc64(vaddr);
>>>> +		else
>>>> +			paddr = vtop3_sparc64(vaddr);
>>>> +	}
>>>> +	if (paddr == NOT_PADDR)
>>>> +		ERRMSG("vaddr not mapped: 0x%lx\n", vaddr);
>>>> +
>>>> +	return paddr;
>>>> +}
>>>> +
>>>> +#endif /* sparc64 */
>>>> diff --git a/makedumpfile.h b/makedumpfile.h
>>>> index e32e567..9e222b8 100644
>>>> --- a/makedumpfile.h
>>>> +++ b/makedumpfile.h
>>>> @@ -820,6 +820,93 @@ unsigned long get_kvbase_arm64(void);
>>>>
>>>> #endif          /* ia64 */
>>>>
>>>> +#ifdef __sparc64__
>>>> +
>>>> +#define KVBASE			(SYMBOL(_stext))
>>>> +#define KVBASE_MASK		(0xffff)
>>>> +#define _SECTION_SIZE_BITS	(30)
>>>> +#define _MAX_PHYSMEM_BITS_L3	(49)
>>>> +#define _MAX_PHYSMEM_BITS_L4	(53)
>>>> +#define VMALLOC_START_SPARC64	(0x0000000100000000UL)
>>>> +#define VMEMMAP_BASE_SPARC64	(0x0000010000000000UL)
>>>> +#define VMEMMAP_CHUNK_SHIFT	(22)
>>>> +#define VMEMMAP_CHUNK		(1UL << VMEMMAP_CHUNK_SHIFT)
>>>> +#define VMEMMAP_CHUNK_MASK	(~(VMEMMAP_CHUNK - 1UL))
>>>> +
>>>> +#define PAGE_SHIFT		13
>>>> +#define PAGE_SIZE		(1UL << PAGE_SHIFT)
>>>> +#define PAGE_MASK		(~(PAGE_SIZE - 1))
>>>> +
>>>> +#define MAX_PHYS_ADDRESS_LOBITS	(41)
>>>> +#define NR_CHUNKS_SHIFT		(MAX_PHYS_ADDRESS_LOBITS - PAGE_SHIFT + 6)
>>>> +#define NR_CHUNKS_MASK		(~((1UL << NR_CHUNKS_SHIFT) - 1))
>>>> +
>>>> +#define PMD_SHIFT		(PAGE_SHIFT + (PAGE_SHIFT - 3))
>>>> +#define PMD_SIZE		(1UL << PMD_SHIFT)
>>>> +#define PMD_MASK		(~(PMD_SIZE - 1))
>>>> +#define PMD_BITS		(PAGE_SHIFT - 3)
>>>> +
>>>> +#define PUD_SHIFT		(PMD_SHIFT + PMD_BITS)
>>>> +#define PUD_SIZE		(1UL << PUD_SHIFT)
>>>> +#define PUD_MASK		(~(PUD_SIZE - 1))
>>>> +#define PUD_BITS		(PAGE_SHIFT - 3)
>>>> +
>>>> +#define PGDIR_SHIFT_L4		(PUD_SHIFT + PUD_BITS)
>>>> +#define PGDIR_SIZE_L4		(1UL << PGDIR_SHIFT_L4)
>>>> +#define PGDIR_MASK_L4		(~(PGDIR_SIZE_L4 - 1))
>>>> +
>>>> +#define PGDIR_SHIFT_L3		(PMD_SHIFT + PMD_BITS)
>>>> +#define PGDIR_SIZE_L3		(1UL << PGDIR_SHIFT_L3)
>>>> +#define PGDIR_MASK_L3		(~(PGDIR_SIZE_L3 - 1))
>>>> +
>>>> +#define PGDIR_BITS		(PAGE_SHIFT - 3)
>>>> +
>>>> +#define PTRS_PER_PTE		(1UL << (PAGE_SHIFT - 3))
>>>> +#define PTRS_PER_PMD		(1UL << PMD_BITS)
>>>> +#define PTRS_PER_PUD		(1UL << PUD_BITS)
>>>> +#define PTRS_PER_PGD		(1UL << PGDIR_BITS)
>>>> +
>>>> +#define _PAGE_PMD_HUGE		(0x0100000000000000UL)
>>>> +#define _PAGE_PUD_HUGE		_PAGE_PMD_HUGE
>>>> +#define _PAGE_PADDR_4V		(0x00FFFFFFFFFFE000UL)
>>>> +#define _PAGE_PRESENT_4V	(0x0000000000000010UL)
>>>> +
>>>> +typedef unsigned long pte_t;
>>>> +typedef unsigned long pmd_t;
>>>> +typedef unsigned long pud_t;
>>>> +typedef unsigned long pgd_t;
>>>> +
>>>> +#define pud_none(pud)		(!(pud))
>>>> +#define pgd_none(pgd)		(!(pgd))
>>>> +#define pmd_none(pmd)		(!(pmd))
>>>> +
>>>> +#define pte_to_pa(pte) (pte & _PAGE_PADDR_4V)
>>>> +
>>>> +#define pgd_index_l4(addr) (((addr) >> PGDIR_SHIFT_L4) & (PTRS_PER_PGD - 1))
>>>> +#define pgd_offset_l4(pgdir,addr)	((unsigned long) \
>>>> +				 ((pgd_t *)pgdir + pgd_index_l4(addr)))
>>>> +
>>>> +#define pgd_index_l3(addr) (((addr) >> PGDIR_SHIFT_L3) & (PTRS_PER_PGD - 1))
>>>> +#define pgd_offset_l3(pgdir,addr)	((unsigned long) \
>>>> +				 ((pgd_t *)pgdir + pgd_index_l3(addr)))
>>>> +
>>>> +#define pud_index(addr)		(((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
>>>> +#define pud_offset(pgdp, addr)	((unsigned long) \
>>>> +				 ((pud_t *)pgdp + pud_index(addr)))
>>>> +#define pud_large(pud)		(pud & _PAGE_PUD_HUGE)
>>>> +
>>>> +#define pmd_index(addr)		(((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
>>>> +#define pmd_offset(pudp, addr)	((unsigned long) \
>>>> +				 ((pmd_t *)pudp + pmd_index(addr)))
>>>> +#define pmd_large(pmd)		(pmd & _PAGE_PMD_HUGE)
>>>> +
>>>> +#define pte_index(addr)		(((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
>>>> +#define pte_offset(pmdp, addr)	((unsigned long) \
>>>> +				 ((pte_t *)(pte_to_pa(pmdp) + pte_index(addr))))
>>>> +#define pte_present(pte)	(pte & _PAGE_PRESENT_4V)
>>>> +
>>>> +#endif
>>>> +
>>>> /*
>>>>    * The function of dependence on machine
>>>>    */
>>>> @@ -928,6 +1015,18 @@ unsigned long long vaddr_to_paddr_ia64(unsigned long vaddr);
>>>> #define is_phys_addr(X)		stub_true_ul(X)
>>>> #endif          /* ia64 */
>>>>
>>>> +#ifdef __sparc64__ /* sparc64 */
>>>> +int get_versiondep_info_sparc64(void);
>>>> +int get_phys_base_sparc64(void);
>>>> +unsigned long long vaddr_to_paddr_sparc64(unsigned long vaddr);
>>>> +#define find_vmemmap()          stub_false()
>>>> +#define get_machdep_info()      TRUE
>>>> +#define get_phys_base()         get_phys_base_sparc64()
>>>> +#define get_versiondep_info()   get_versiondep_info_sparc64()
>>>> +#define vaddr_to_paddr(X)       vaddr_to_paddr_sparc64(X)
>>>> +#define is_phys_addr(X)		stub_true_ul(X)
>>>> +#endif		/* sparc64 */
>>>> +
>>>> typedef unsigned long long mdf_pfn_t;
>>>>
>>>> #ifndef ARCH_PFN_OFFSET
>>>> @@ -1474,6 +1573,11 @@ struct symbol_table {
>>>> 	unsigned long long		cpu_pgd;
>>>> 	unsigned long long		demote_segment_4k;
>>>> 	unsigned long long		cur_cpu_spec;
>>>> +
>>>> +	/*
>>>> +	 * symbols on sparc64 arch
>>>> +	 */
>>>> +	unsigned long long		vmemmap_table;
>>>> };
>>>>
>>>> struct size_table {
>>>> @@ -1952,6 +2056,12 @@ int get_xen_info_ia64(void);
>>>> #define get_xen_info_arch(X) FALSE
>>>> #endif	/* s390x */
>>>>
>>>> +#ifdef __sparc64__ /* sparc64 */
>>>> +#define kvtop_xen(X)	FALSE
>>>> +#define get_xen_basic_info_arch(X) FALSE
>>>> +#define get_xen_info_arch(X) FALSE
>>>> +#endif	/* sparc64 */
>>>> +
>>>> struct cycle {
>>>> 	mdf_pfn_t start_pfn;
>>>> 	mdf_pfn_t end_pfn;
>>>> --
>>>> 1.7.1
>>>>
>>>>
>>>> _______________________________________________
>>>> kexec mailing list
>>>> kexec@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
