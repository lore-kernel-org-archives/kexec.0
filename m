Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PGiU2-0001V6-Ru
	for kexec@lists.infradead.org; Fri, 12 Nov 2010 01:31:20 +0000
Date: Fri, 12 Nov 2010 10:28:56 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH v1] makedumpfile: s390x: Add support for s390x crashdump
	analysis
Message-Id: <20101112102856.a20dae40.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20101111052840.14598.72719.stgit@mars.in.ibm.com>
References: <20101111052840.14598.72719.stgit@mars.in.ibm.com>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Mahesh J Salgaonkar <mahesh@linux.vnet.in.ibm.com>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec-ml <kexec@lists.infradead.org>, Michael Holzheu <holzheu@de.ibm.com>, Dave Anderson <anderson@redhat.com>, Reinhard <BUENDGEN@de.ibm.com>


Hi Mahesh,

Thank you for the patch.
I reviewed this patch, and I think this is good.

I have one question.

On Thu, 11 Nov 2010 11:04:17 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.in.ibm.com> wrote:
>
> This patch adds support for processing s390x kernel crashdumps.
> 
> The changes have been tested on s390x system.
> The dump compression and filtering (for all dump levels 1,2,4,8,16 and 31)
> tests are succussfull.

What version of linux kernel are the above tests on ?
I'd like to write the version on README file.


Thanks
Ken'ichi Ohmichi


> Please review this patch and let me know your feedback.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
> ---
> 
>  Makefile       |    4 -
>  makedumpfile.h |   52 ++++++++++
>  s390x.c        |  280 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 334 insertions(+), 2 deletions(-)
>  create mode 100644 s390x.c
> 
> diff --git a/Makefile b/Makefile
> index 4dad21e..e79be1c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -23,8 +23,8 @@ CFLAGS_ARCH += -m64
>  endif
>  
>  SRC	= makedumpfile.c makedumpfile.h diskdump_mod.h
> -SRC_ARCH = arm.c x86.c x86_64.c ia64.c ppc64.c
> -OBJ_ARCH = arm.o x86.o x86_64.o ia64.o ppc64.o
> +SRC_ARCH = arm.c x86.c x86_64.c ia64.c ppc64.c s390x.c
> +OBJ_ARCH = arm.o x86.o x86_64.o ia64.o ppc64.o s390x.o
>  
>  all: makedumpfile
>  
> diff --git a/makedumpfile.h b/makedumpfile.h
> index b703077..c56afd8 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -612,6 +612,45 @@ do { \
>  #define _MAX_PHYSMEM_BITS	(44)
>  #endif
>  
> +#ifdef __s390x__
> +#define __PAGE_OFFSET		(info->page_size - 1)
> +#define KERNELBASE		(0)
> +#define KVBASE			(SYMBOL(_stext))
> +#define _SECTION_SIZE_BITS	(28)
> +#define _MAX_PHYSMEM_BITS	(42)
> +
> +/* Bits in the segment/region table address-space-control-element */
> +#define _ASCE_TYPE_MASK		0x0c
> +#define _ASCE_TABLE_LENGTH	0x03	/* region table length  */
> +
> +#define TABLE_LEVEL(x)		(((x) & _ASCE_TYPE_MASK) >> 2)
> +#define TABLE_LENGTH(x)		((x) & _ASCE_TABLE_LENGTH)
> +
> +/* Bits in the region table entry */
> +#define _REGION_ENTRY_ORIGIN	~0xfffUL	/* region table origin*/
> +#define _REGION_ENTRY_TYPE_MASK	0x0c	/* region table type mask */
> +#define _REGION_ENTRY_INVALID	0x20	/* invalid region table entry */
> +#define _REGION_ENTRY_LENGTH	0x03	/* region table length */
> +#define _REGION_OFFSET_MASK	0x7ffUL	/* region/segment table offset mask */
> +
> +#define RSG_TABLE_LEVEL(x)	(((x) & _REGION_ENTRY_TYPE_MASK) >> 2)
> +#define RSG_TABLE_LENGTH(x)	((x) & _REGION_ENTRY_LENGTH)
> +
> +/* Bits in the segment table entry */
> +#define _SEGMENT_ENTRY_ORIGIN	~0x7ffUL
> +#define _SEGMENT_ENTRY_LARGE	0x400
> +#define _SEGMENT_PAGE_SHIFT	31
> +#define _SEGMENT_INDEX_SHIFT	20
> +
> +/* Hardware bits in the page table entry */
> +#define _PAGE_CO		0x100	/* HW Change-bit override */
> +#define _PAGE_ZERO		0x800	/* Bit pos 52 must conatin zero */
> +#define _PAGE_INVALID		0x400	/* HW invalid bit */
> +#define _PAGE_INDEX_SHIFT	12
> +#define _PAGE_OFFSET_MASK	0xffUL	/* page table offset mask */
> +
> +#endif /* __s390x__ */
> +
>  #ifdef __ia64__ /* ia64 */
>  #define REGION_SHIFT		(61)
>  
> @@ -710,6 +749,15 @@ unsigned long long vaddr_to_paddr_ppc64(unsigned long vaddr);
>  #define vaddr_to_paddr(X)	vaddr_to_paddr_ppc64(X)
>  #endif          /* powerpc */
>  
> +#ifdef __s390x__ /* s390x */
> +int get_machdep_info_s390x(void);
> +unsigned long long vaddr_to_paddr_s390x(unsigned long vaddr);
> +#define get_phys_base()		TRUE
> +#define get_machdep_info()	get_machdep_info_s390x()
> +#define get_versiondep_info()	TRUE
> +#define vaddr_to_paddr(X)	vaddr_to_paddr_s390x(X)
> +#endif          /* s390x */
> +
>  #ifdef __ia64__ /* ia64 */
>  int get_phys_base_ia64(void);
>  int get_machdep_info_ia64(void);
> @@ -1274,3 +1322,7 @@ int get_xen_info_ia64(void);
>  #define get_xen_info_arch(X) FALSE
>  #endif	/* powerpc */
>  
> +#ifdef __s390x__ /* s390x */
> +#define kvtop_xen(X)	FALSE
> +#define get_xen_info_arch(X) FALSE
> +#endif	/* s390x */
> diff --git a/s390x.c b/s390x.c
> new file mode 100644
> index 0000000..128e5f0
> --- /dev/null
> +++ b/s390x.c
> @@ -0,0 +1,280 @@
> +/*
> + * s390x.c
> + *
> + * Created by: Michael Holzheu (holzheu@de.ibm.com)
> + * Copyright IBM Corp. 2010
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation (version 2 of the License).
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#ifdef __s390x__
> +
> +#include "makedumpfile.h"
> +
> +#define TABLE_SIZE		4096
> +
> +/*
> + * Bits in the virtual address
> + *
> + * |<-----  RX  ---------->|
> + * |  RFX  |  RSX  |  RTX  |  SX  | PX |  BX  |
> + * 0        11      22      33     44   52    63
> + *
> + * RX: Region Index
> + *	RFX:	Region first index
> + *	RSX:	Region second index
> + *	RTX:	Region third index
> + * SX: Segment index
> + * PX: Page index
> + * BX: Byte index
> + *
> + * RX part of vaddr is divided into three fields RFX, RSX and RTX each of
> + * 11 bit in size
> + */
> +#define _REGION_INDEX_SHIFT	11
> +#define _PAGE_INDEX_MASK	0xff000UL	/* page index (PX) mask */
> +#define _BYTE_INDEX_MASK	0x00fffUL	/* Byte index (BX) mask */
> +#define _PAGE_BYTE_INDEX_MASK	(_PAGE_INDEX_MASK | _BYTE_INDEX_MASK)
> +
> +/* Region/segment table index */
> +#define rsg_index(x, y)	\
> +		(((x) >> ((_REGION_INDEX_SHIFT * y) + _SEGMENT_INDEX_SHIFT)) \
> +		& _REGION_OFFSET_MASK)
> +/* Page table index */
> +#define pte_index(x)	(((x) >> _PAGE_INDEX_SHIFT) & _PAGE_OFFSET_MASK)
> +
> +#define rsg_offset(x, y)	(rsg_index( x, y) * sizeof(unsigned long))
> +#define pte_offset(x)		(pte_index(x) * sizeof(unsigned long))
> +
> +int
> +get_machdep_info_s390x(void)
> +{
> +	unsigned long vmlist, vmalloc_start;
> +
> +	info->section_size_bits = _SECTION_SIZE_BITS;
> +	info->max_physmem_bits  = _MAX_PHYSMEM_BITS;
> +	info->page_offset = __PAGE_OFFSET;
> +
> +	if (SYMBOL(_stext) == NOT_FOUND_SYMBOL) {
> +		ERRMSG("Can't get the symbol of _stext.\n");
> +		return FALSE;
> +	}
> +	info->kernel_start = SYMBOL(_stext);
> +	DEBUG_MSG("kernel_start : %lx\n", info->kernel_start);
> +
> +	/*
> +	 * For the compatibility, makedumpfile should run without the symbol
> +	 * vmlist and the offset of vm_struct.addr if they are not necessary.
> +	 */
> +	if ((SYMBOL(vmlist) == NOT_FOUND_SYMBOL)
> +	    || (OFFSET(vm_struct.addr) == NOT_FOUND_STRUCTURE)) {
> +		return TRUE;
> +	}
> +	if (!readmem(VADDR, SYMBOL(vmlist), &vmlist, sizeof(vmlist))) {
> +		ERRMSG("Can't get vmlist.\n");
> +		return FALSE;
> +	}
> +	if (!readmem(VADDR, vmlist + OFFSET(vm_struct.addr), &vmalloc_start,
> +	    sizeof(vmalloc_start))) {
> +		ERRMSG("Can't get vmalloc_start.\n");
> +		return FALSE;
> +	}
> +	info->vmalloc_start = vmalloc_start;
> +	DEBUG_MSG("vmalloc_start: %lx\n", vmalloc_start);
> +
> +	return TRUE;
> +}
> +
> +static int
> +is_vmalloc_addr_s390x(unsigned long vaddr)
> +{
> +	return (info->vmalloc_start && vaddr >= info->vmalloc_start);
> +}
> +
> +static int
> +rsg_table_entry_bad(unsigned long entry, int level)
> +{
> +	unsigned long mask = ~_REGION_ENTRY_INVALID
> +				& ~_REGION_ENTRY_TYPE_MASK
> +				& ~_REGION_ENTRY_LENGTH;
> +
> +	if (level)
> +		mask &= ~_REGION_ENTRY_ORIGIN;
> +	else
> +		mask &= ~_SEGMENT_ENTRY_ORIGIN;
> +
> +	return  (entry & mask) != 0;
> +}
> +
> +/* Region or segment table traversal function */
> +static unsigned long
> +_kl_rsg_table_deref_s390x(unsigned long vaddr, unsigned long table,
> +							int len, int level)
> +{
> +	unsigned long offset, entry;
> +
> +	offset = rsg_offset(vaddr, level);
> +
> +	/* check if offset is over the table limit. */
> +	if (offset >= ((len + 1) * TABLE_SIZE)) {
> +		ERRMSG("offset is over the table limit.\n");
> +		return 0;
> +	}
> +
> +	if (!readmem(VADDR, table + offset, &entry, sizeof(entry))) {
> +		if (level)
> +			ERRMSG("Can't read region table %d entry\n", level);
> +		else
> +			ERRMSG("Can't read segment table entry\n");
> +		return 0;
> +	}
> +	/*
> +	 * Check if the segment table entry could be read and doesn't have
> +	 * any of the reserved bits set.
> +	 */
> +	if (rsg_table_entry_bad(entry, level)) {
> +		ERRMSG("Bad region/segment table entry.\n");
> +		return 0;
> +	}
> +	/*
> +	 * Check if the region/segment table entry is with valid
> +	 * level and not invalid.
> +	 */
> +	if ((RSG_TABLE_LEVEL(entry) != level)
> +			&& (entry & _REGION_ENTRY_INVALID)) {
> +		ERRMSG("Invalid region/segment table level or entry.\n");
> +		return 0;
> +	}
> +
> +	return entry;
> +}
> +
> +/* Page table traversal function */
> +static ulong _kl_pg_table_deref_s390x(unsigned long vaddr, unsigned long table)
> +{
> +	unsigned long offset, entry;
> +
> +	offset = pte_offset(vaddr);
> +	readmem(VADDR, table + offset, &entry, sizeof(entry));
> +	/*
> +	 * Check if the page table entry could be read and doesn't have
> +	 * any of the reserved bits set.
> +	 * Check if the page table entry has the invalid bit set.
> +	 */
> +	if (entry &  (_PAGE_CO | _PAGE_ZERO | _PAGE_INVALID)) {
> +		ERRMSG("Invalid page table entry.\n");
> +		return 0;
> +	}
> +
> +	return entry;
> +}
> +
> +/* vtop_s390x() - translate virtual address to physical
> + *	@vaddr: virtual address to translate
> + *
> + * Function converts the @vaddr into physical address using page tables.
> + *
> + * Return:
> + *	Physical address or NOT_PADDR if translation fails.
> + */
> +static unsigned long long
> +vtop_s390x(unsigned long vaddr)
> +{
> +	unsigned long long paddr = NOT_PADDR;
> +	unsigned long table, entry;
> +	int level, len;
> +
> +	if (SYMBOL(swapper_pg_dir) == NOT_FOUND_SYMBOL) {
> +		ERRMSG("Can't get the symbol of swapper_pg_dir.\n");
> +		return NOT_PADDR;
> +	}
> +	table = SYMBOL(swapper_pg_dir);
> +
> +	/* Read the first entry to find the number of page table levels. */
> +	readmem(VADDR, table, &entry, sizeof(entry));
> +	level = TABLE_LEVEL(entry);
> +	len = TABLE_LENGTH(entry);
> +
> +	if ((vaddr >> (_SEGMENT_PAGE_SHIFT + (_REGION_INDEX_SHIFT * level)))) {
> +		ERRMSG("Address too big for the number of page table " \
> +								"levels.\n");
> +		return NOT_PADDR;
> +	}
> +
> +	/*
> +	 * Walk the region and segment tables.
> +	 */
> +	while (level >= 0) {
> +		entry = _kl_rsg_table_deref_s390x(vaddr, table, len, level);
> +		if (!entry) {
> +			return NOT_PADDR;
> +		}
> +		table = entry & _REGION_ENTRY_ORIGIN;
> +		len = RSG_TABLE_LENGTH(entry);
> +		level--;
> +	}
> +
> +	/*
> +	 * Check if this is a large page.
> +	 * if yes, then add the 1MB page offset (PX + BX) and return the value.
> +	 * if no, then get the page table entry using PX index.
> +	 */
> +	if (entry & _SEGMENT_ENTRY_LARGE) {
> +		paddr = table + (vaddr &  _PAGE_BYTE_INDEX_MASK);
> +	} else {
> +		entry = _kl_pg_table_deref_s390x(vaddr,
> +					entry & _SEGMENT_ENTRY_ORIGIN);
> +		if (!entry)
> +			return NOT_PADDR;
> +
> +		/*
> +		 * Isolate the page origin from the page table entry.
> +		 * Add the page offset (BX).
> +		 */
> +		paddr = (entry &  _REGION_ENTRY_ORIGIN)
> +			+ (vaddr & _BYTE_INDEX_MASK);
> +	}
> +
> +	return paddr;
> +}
> +
> +unsigned long long
> +vaddr_to_paddr_s390x(unsigned long vaddr)
> +{
> +	unsigned long long paddr;
> +
> +	paddr = vaddr_to_paddr_general(vaddr);
> +	if (paddr != NOT_PADDR)
> +		return paddr;
> +
> +	if ((SYMBOL(vmlist) == NOT_FOUND_SYMBOL)
> +	    || (OFFSET(vm_struct.addr) == NOT_FOUND_STRUCTURE)) {
> +		ERRMSG("Can't get necessary information for vmalloc "
> +			"translation.\n");
> +		return NOT_PADDR;
> +	}
> +
> +	if (is_vmalloc_addr_s390x(vaddr)) {
> +		paddr = vtop_s390x(vaddr);
> +	}
> +	else {
> +		ERRMSG("Can't convert a virtual address(%lx) to " \
> +		    "physical address.\n", vaddr);
> +		return NOT_PADDR;
> +	}
> +
> +	return paddr;
> +}
> +
> +#endif /* __s390x__ */
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
