Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c17nW-00038P-CC
 for kexec@lists.infradead.org; Mon, 31 Oct 2016 08:18:29 +0000
Received: by mail-qt0-f177.google.com with SMTP id w33so27948484qtc.3
 for <kexec@lists.infradead.org>; Mon, 31 Oct 2016 01:18:06 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile PATCH V2 2/4] x86_64: translate all VA to PA using page
 table values
Date: Mon, 31 Oct 2016 13:47:35 +0530
Message-Id: <c72c3722595f7b86754c6d9835ffdc3c68361bb4.1477901442.git.panand@redhat.com>
In-Reply-To: <cover.1477901442.git.panand@redhat.com>
References: <cover.1477901442.git.panand@redhat.com>
In-Reply-To: <cover.1477901442.git.panand@redhat.com>
References: <cover.1477901442.git.panand@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ats-kumagai@wm.jp.nec.com
Cc: Pratyush Anand <panand@redhat.com>, dyoung@redhat.com, louis.bouchard@canonical.com, kexec@lists.infradead.org, bhe@redhat.com

Currently we translate some of the VA areas using linear mapping while some
other(which can not be linearly mapped) using page table.

However, we will have entry of a page in the page table irrespective of its
virtual region. So, we can always look into page table for any VA to PA
translation. This approach will solve lot of complexity in makedumpfile. It
will in turn remove dependency over variables like VMALLOC_START,
MODULES_VADDR etc whose definition keeps changing in newer kernel version.

Moreover, I do not see any side effect of this approach in terms of
execution timing. I tested with IBM x3950 X6 machine having 4136359 MB of
memory with -d 1 option. In fact, over a 19+ trials, new code shows
slightly better result (2592 S) than upstream code (2652 S). These are the
results of makedumpfile execution time:

$ cat console.log | grep "makedumpfile execution time with upstream code
is"
makedumpfile execution time with upstream code is 2750.243266765
makedumpfile execution time with upstream code is 2772.954322748
makedumpfile execution time with upstream code is 2778.147847869
makedumpfile execution time with upstream code is 2668.136180424
makedumpfile execution time with upstream code is 2543.101660682
makedumpfile execution time with upstream code is 2757.314292073
makedumpfile execution time with upstream code is 2478.658846427
makedumpfile execution time with upstream code is 2745.728099825
makedumpfile execution time with upstream code is 2577.807602709
makedumpfile execution time with upstream code is 2548.787385748
makedumpfile execution time with upstream code is 2757.644602365
makedumpfile execution time with upstream code is 2562.336482019
makedumpfile execution time with upstream code is 2559.935682252
makedumpfile execution time with upstream code is 2546.670738446
makedumpfile execution time with upstream code is 2744.063245015
makedumpfile execution time with upstream code is 2744.243866098
makedumpfile execution time with upstream code is 2549.050846459
makedumpfile execution time with upstream code is 2759.081822434
makedumpfile execution time with upstream code is 2549.571317987
$ cat console.log | grep "makedumpfile execution time with upstream code
is" | cut -d ' ' -f 8 | awk -F : '{sum+=$1} END {print "AVG=",sum/NR}'
AVG= 2652.29

$ cat console.log | grep "makedumpfile execution time with new code is"
makedumpfile execution time with new code is 2534.312841588
makedumpfile execution time with new code is 2549.943691468
makedumpfile execution time with new code is 2562.056355355
makedumpfile execution time with new code is 2744.429671429
makedumpfile execution time with new code is 2536.959188162
makedumpfile execution time with new code is 2543.148060626
makedumpfile execution time with new code is 2548.634229064
makedumpfile execution time with new code is 2554.985669453
makedumpfile execution time with new code is 2756.479546003
makedumpfile execution time with new code is 2736.303174442
makedumpfile execution time with new code is 2564.855527093
makedumpfile execution time with new code is 2479.417937688
makedumpfile execution time with new code is 2555.431578921
makedumpfile execution time with new code is 2741.293207275
makedumpfile execution time with new code is 2745.547802440
makedumpfile execution time with new code is 2555.950078489
makedumpfile execution time with new code is 2558.421768940
makedumpfile execution time with new code is 2534.342072864
makedumpfile execution time with new code is 2542.824611652
makedumpfile execution time with new code is 2557.413054122
makedumpfile execution time with new code is 2553.609188082
makedumpfile execution time with new code is 2766.161683444
makedumpfile execution time with new code is 2571.997408197
makedumpfile execution time with new code is 2541.121903364
makedumpfile execution time with new code is 2472.805795262
$ cat console.log | grep "makedumpfile execution time with new code is" |
cut -d ' ' -f 8 | awk -F : '{sum+=$1} END {print "AVG=",sum/NR}'
AVG= 2592.34

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/x86_64.c  | 42 ++++++++----------------------------------
 makedumpfile.h |  4 ++--
 2 files changed, 10 insertions(+), 36 deletions(-)

diff --git a/arch/x86_64.c b/arch/x86_64.c
index eba725e41aac..9afa38fd141a 100644
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -203,6 +203,12 @@ vtop4_x86_64(unsigned long vaddr)
 {
 	unsigned long page_dir, pml4, pgd_paddr, pgd_pte, pmd_paddr, pmd_pte;
 	unsigned long pte_paddr, pte;
+	unsigned long phys_base;
+
+	if (SYMBOL(phys_base) != NOT_FOUND_SYMBOL)
+		phys_base = info->phys_base;
+	else
+		phys_base = 0;
 
 	if (SYMBOL(init_level4_pgt) == NOT_FOUND_SYMBOL) {
 		ERRMSG("Can't get the symbol of init_level4_pgt.\n");
@@ -212,9 +218,9 @@ vtop4_x86_64(unsigned long vaddr)
 	/*
 	 * Get PGD.
 	 */
-	page_dir  = SYMBOL(init_level4_pgt);
+	page_dir = SYMBOL(init_level4_pgt) - __START_KERNEL_map + phys_base;
 	page_dir += pml4_index(vaddr) * sizeof(unsigned long);
-	if (!readmem(VADDR, page_dir, &pml4, sizeof pml4)) {
+	if (!readmem(PADDR, page_dir, &pml4, sizeof pml4)) {
 		ERRMSG("Can't get pml4 (page_dir:%lx).\n", page_dir);
 		return NOT_PADDR;
 	}
@@ -285,38 +291,6 @@ vtop4_x86_64(unsigned long vaddr)
 	return (pte & ENTRY_MASK) + PAGEOFFSET(vaddr);
 }
 
-unsigned long long
-vaddr_to_paddr_x86_64(unsigned long vaddr)
-{
-	unsigned long phys_base;
-	unsigned long long paddr;
-
-	/*
-	 * Check the relocatable kernel.
-	 */
-	if (SYMBOL(phys_base) != NOT_FOUND_SYMBOL)
-		phys_base = info->phys_base;
-	else
-		phys_base = 0;
-
-	if (is_vmalloc_addr_x86_64(vaddr)) {
-		if ((paddr = vtop4_x86_64(vaddr)) == NOT_PADDR) {
-			ERRMSG("Can't convert a virtual address(%lx) to " \
-			    "physical address.\n", vaddr);
-			return NOT_PADDR;
-		}
-	} else if (vaddr >= __START_KERNEL_map) {
-		paddr = vaddr - __START_KERNEL_map + phys_base;
-
-	} else {
-		if (is_xen_memory())
-			paddr = vaddr - PAGE_OFFSET_XEN_DOM0;
-		else
-			paddr = vaddr - PAGE_OFFSET;
-	}
-	return paddr;
-}
-
 /*
  * for Xen extraction
  */
diff --git a/makedumpfile.h b/makedumpfile.h
index a5955ff750e5..13559651feb6 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -863,12 +863,12 @@ int is_vmalloc_addr_x86_64(ulong vaddr);
 int get_phys_base_x86_64(void);
 int get_machdep_info_x86_64(void);
 int get_versiondep_info_x86_64(void);
-unsigned long long vaddr_to_paddr_x86_64(unsigned long vaddr);
+unsigned long long vtop4_x86_64(unsigned long vaddr);
 #define find_vmemmap()		find_vmemmap_x86_64()
 #define get_phys_base()		get_phys_base_x86_64()
 #define get_machdep_info()	get_machdep_info_x86_64()
 #define get_versiondep_info()	get_versiondep_info_x86_64()
-#define vaddr_to_paddr(X)	vaddr_to_paddr_x86_64(X)
+#define vaddr_to_paddr(X)	vtop4_x86_64(X)
 #define is_phys_addr(X)		(!is_vmalloc_addr_x86_64(X))
 #endif /* x86_64 */
 
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
