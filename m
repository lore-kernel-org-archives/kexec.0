Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cFFoq-0003yG-JS
 for kexec@lists.infradead.org; Fri, 09 Dec 2016 07:42:14 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [Makedumpfile PATCH V2 2/4] x86_64: translate all VA to PA
 using page table values
Date: Fri, 9 Dec 2016 07:35:55 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E87E88@BPXM01GP.gisp.nec.co.jp>
References: <cover.1477901442.git.panand@redhat.com>
 <c72c3722595f7b86754c6d9835ffdc3c68361bb4.1477901442.git.panand@redhat.com>
In-Reply-To: <c72c3722595f7b86754c6d9835ffdc3c68361bb4.1477901442.git.panand@redhat.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: Pratyush Anand <panand@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "louis.bouchard@canonical.com" <louis.bouchard@canonical.com>, "dyoung@redhat.com" <dyoung@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>

Hello Pratyush,

>---
> arch/x86_64.c  | 42 ++++++++----------------------------------
> makedumpfile.h |  4 ++--
> 2 files changed, 10 insertions(+), 36 deletions(-)
>
>diff --git a/arch/x86_64.c b/arch/x86_64.c
>index eba725e41aac..9afa38fd141a 100644
>--- a/arch/x86_64.c
>+++ b/arch/x86_64.c
>@@ -203,6 +203,12 @@ vtop4_x86_64(unsigned long vaddr)
> {
> 	unsigned long page_dir, pml4, pgd_paddr, pgd_pte, pmd_paddr, pmd_pte;
> 	unsigned long pte_paddr, pte;
>+	unsigned long phys_base;
>+
>+	if (SYMBOL(phys_base) != NOT_FOUND_SYMBOL)
>+		phys_base = info->phys_base;
>+	else
>+		phys_base = 0;
>
> 	if (SYMBOL(init_level4_pgt) == NOT_FOUND_SYMBOL) {
> 		ERRMSG("Can't get the symbol of init_level4_pgt.\n");
>@@ -212,9 +218,9 @@ vtop4_x86_64(unsigned long vaddr)
> 	/*
> 	 * Get PGD.
> 	 */
>-	page_dir  = SYMBOL(init_level4_pgt);
>+	page_dir = SYMBOL(init_level4_pgt) - __START_KERNEL_map + phys_base;

I found that this change breaks the backward compatibility for
kernel 2.6.21 or older since phys_base was introduced in kernel 2.6.22
by the commit below:

  commit 1ab60e0f72f71ec54831e525a3e1154f1c092408
  Author: Vivek Goyal <vgoyal@in.ibm.com>
  Date:   Wed May 2 19:27:07 2007 +0200

      [PATCH] x86-64: Relocatable Kernel Support

There is no problem if phys_base is always 0 in older kernel, but
get_phys_base_x86_64() calculates "phys_base = 0x100000" from my vmcore:

  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  NOTE           0x0000000000000190 0x0000000000000000 0x0000000000000000
                 0x0000000000000590 0x0000000000000590         0
  LOAD           0x0000000000000720 0xffffffff80000000 0x0000000000100000    // CONFIG_PHYSICAL_START = 0x100000
                 0x00000000008b2000 0x00000000008b2000  RWE    0
  LOAD           0x00000000008b2720 0xffff810000000000 0x0000000000000000
                 0x00000000000a0000 0x00000000000a0000  RWE    0
  LOAD           0x0000000000952720 0xffff810000100000 0x0000000000100000
                 0x0000000000f00000 0x0000000000f00000  RWE    0
  LOAD           0x0000000001852720 0xffff810005000000 0x0000000005000000
                 0x00000000caf70000 0x00000000caf70000  RWE    0
  LOAD           0x00000000cc7c2720 0xffff810100000000 0x0000000100000000
                 0x0000000070000000 0x0000000070000000  RWE    0

Of course we shouldn't use that invalid phys_base:

  crash> sym init_level4_pgt
  ffffffff80101000 (T) init_level4_pgt
  crash> vtop ffffffff80101000
  VIRTUAL           PHYSICAL
  ffffffff80101000  101000               // just "VIRTUAL - __START_KERNEL_map"

  PML4 DIRECTORY: ffffffff80101000
  PAGE DIRECTORY: 103027
     PUD: 103ff0 => 105027
     PMD: 105000 => 1e3
    PAGE: 0  (2MB)

  PTE  PHYSICAL  FLAGS
  1e3      0     (PRESENT|RW|ACCESSED|DIRTY|PSE|GLOBAL)

        PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
  ffff810005004838    101000                0        0  1 400
  crash>

At first I thought about setting 0 to phys_base if the kernel is
older than 2.6.22, but unfortunately we can't get the kernel version
before getting correct phys_base since VtoP is necessary to read
system_utsname. 
(and 2.6.21 doesn't have VMCOREINFO, OSRELEASE can't be used too.)

Do you have any ideas for this issue ?


Thanks,
Atsushi Kumagai


> 	page_dir += pml4_index(vaddr) * sizeof(unsigned long);
>-	if (!readmem(VADDR, page_dir, &pml4, sizeof pml4)) {
>+	if (!readmem(PADDR, page_dir, &pml4, sizeof pml4)) {
> 		ERRMSG("Can't get pml4 (page_dir:%lx).\n", page_dir);
> 		return NOT_PADDR;
> 	}
>@@ -285,38 +291,6 @@ vtop4_x86_64(unsigned long vaddr)
> 	return (pte & ENTRY_MASK) + PAGEOFFSET(vaddr);
> }
>
>-unsigned long long
>-vaddr_to_paddr_x86_64(unsigned long vaddr)
>-{
>-	unsigned long phys_base;
>-	unsigned long long paddr;
>-
>-	/*
>-	 * Check the relocatable kernel.
>-	 */
>-	if (SYMBOL(phys_base) != NOT_FOUND_SYMBOL)
>-		phys_base = info->phys_base;
>-	else
>-		phys_base = 0;
>-
>-	if (is_vmalloc_addr_x86_64(vaddr)) {
>-		if ((paddr = vtop4_x86_64(vaddr)) == NOT_PADDR) {
>-			ERRMSG("Can't convert a virtual address(%lx) to " \
>-			    "physical address.\n", vaddr);
>-			return NOT_PADDR;
>-		}
>-	} else if (vaddr >= __START_KERNEL_map) {
>-		paddr = vaddr - __START_KERNEL_map + phys_base;
>-
>-	} else {
>-		if (is_xen_memory())
>-			paddr = vaddr - PAGE_OFFSET_XEN_DOM0;
>-		else
>-			paddr = vaddr - PAGE_OFFSET;
>-	}
>-	return paddr;
>-}
>-
> /*
>  * for Xen extraction
>  */
>diff --git a/makedumpfile.h b/makedumpfile.h
>index a5955ff750e5..13559651feb6 100644
>--- a/makedumpfile.h
>+++ b/makedumpfile.h
>@@ -863,12 +863,12 @@ int is_vmalloc_addr_x86_64(ulong vaddr);
> int get_phys_base_x86_64(void);
> int get_machdep_info_x86_64(void);
> int get_versiondep_info_x86_64(void);
>-unsigned long long vaddr_to_paddr_x86_64(unsigned long vaddr);
>+unsigned long long vtop4_x86_64(unsigned long vaddr);
> #define find_vmemmap()		find_vmemmap_x86_64()
> #define get_phys_base()		get_phys_base_x86_64()
> #define get_machdep_info()	get_machdep_info_x86_64()
> #define get_versiondep_info()	get_versiondep_info_x86_64()
>-#define vaddr_to_paddr(X)	vaddr_to_paddr_x86_64(X)
>+#define vaddr_to_paddr(X)	vtop4_x86_64(X)
> #define is_phys_addr(X)		(!is_vmalloc_addr_x86_64(X))
> #endif /* x86_64 */
>
>--
>2.7.4
>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
