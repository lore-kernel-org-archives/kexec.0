Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Rxs9T-0001Bb-0a
 for kexec@lists.infradead.org; Thu, 16 Feb 2012 03:37:00 +0000
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Thu, 16 Feb 2012 09:06:53 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1G3aTJQ3436754
 for <kexec@lists.infradead.org>; Thu, 16 Feb 2012 09:06:30 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1G3aTKx006644
 for <kexec@lists.infradead.org>; Thu, 16 Feb 2012 14:36:29 +1100
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v1 2/4] [makedumpfile][ppc] Generic vmalloc translation support
Date: Thu, 16 Feb 2012 09:06:18 +0530
Message-ID: <20120216033601.7972.27961.stgit@suzukikp>
In-Reply-To: <20120216033411.7972.77705.stgit@suzukikp>
References: <20120216033411.7972.77705.stgit@suzukikp>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

This patch adds the generic vmalloc address translation support for PPC32.

There are different types of platforms under PPC32 and the vmalloc translation
requires the knowledge about the page translation bits for each of them. This patch
introduces a generic translation routine with some default values which may work
well for most of the platforms. Later patches in this series would add an
infrastructure to identify the platforms and dynamically change the translation
based on the platform definition.

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
---

 arch/ppc.c     |   40 ++++++++++++++++++++++++++++++++++++----
 makedumpfile.h |    6 ++++++
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/arch/ppc.c b/arch/ppc.c
index 2bc8d5f..2ca0dc5 100644
--- a/arch/ppc.c
+++ b/arch/ppc.c
@@ -77,7 +77,9 @@ vaddr_to_paddr_ppc(unsigned long vaddr)
 {
 	unsigned long *pgd, *pmd;
 	unsigned long long pte;
+	unsigned long pte_32;
 	unsigned long long paddr;
+	int res = 0;
 
 	paddr = vaddr_to_paddr_general(vaddr);
 	if (paddr != NOT_PADDR)
@@ -91,10 +93,40 @@ vaddr_to_paddr_ppc(unsigned long vaddr)
 	if (!is_vmalloc_addr_ppc(vaddr))
 		return (vaddr - info->kernel_start);
 
-	/*
-	 * TODO: Support vmalloc translation.
-	 */
-	ERRMSG("This makedumpfile does not support vmalloc translation.\n");
+	if ((SYMBOL(swapper_pg_dir) == NOT_FOUND_SYMBOL) &&
+		!readmem(VADDR, SYMBOL(swapper_pg_dir), &pgd, sizeof(pgd))) {
+		ERRMSG("Can't get the PGD for vmalloc translation. \n");
+		return NOT_PADDR;
+	}
+
+	pgd += vaddr >> PGDIR_SHIFT;
+	DEBUG_MSG("vaddr: 0x%lx , PGD = 0x%lx\n", vaddr, (unsigned long)pgd);
+	if (!readmem(VADDR, (unsigned long)pgd, &pmd, sizeof(pmd))) {
+		ERRMSG("Can't get the PMD for address 0x%lx\n.", vaddr);
+		return NOT_PADDR;
+	}
+
+	pmd += (PAGEBASE(vaddr) & (PTRS_PER_PTE - 1));
+	DEBUG_MSG("vaddr: 0x%lx , PMD = 0x%lx\n", vaddr, (unsigned long)pmd);
+
+	if (PTE_SIZE == sizeof(unsigned long long))
+		res = readmem(VADDR, (unsigned long)pmd, &pte, sizeof(pte));
+	else {
+		res = readmem(VADDR, (unsigned long)pmd, &pte_32, sizeof(pte_32));
+		pte = pte_32;
+	}
+
+	if (!res) {
+		ERRMSG("Can't get PTE for address 0x%lx\n", vaddr);
+		return NOT_PADDR;
+	}
+
+	DEBUG_MSG("vaddr: 0x%lx , PTE = 0x%llx\n", vaddr, (unsigned long long)pte);
+	if (pte & _PAGE_PRESENT) {
+		paddr = PAGEBASE(pte) | PAGEOFFSET(vaddr);
+		return paddr;
+	}
+
 	return NOT_PADDR;
 }
 
diff --git a/makedumpfile.h b/makedumpfile.h
index 9dc254e..f7603d7 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -539,6 +539,12 @@ do { \
 #define _SECTION_SIZE_BITS	(24)
 #define _MAX_PHYSMEM_BITS	(44)
 
+#define PGDIR_SHIFT		(22)
+#define PTRS_PER_PTE		(1024)
+#define PTE_SIZE		(sizeof(unsigned long))
+
+#define _PAGE_PRESENT		(0x1)
+
 #endif
 
 #ifdef __s390x__


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
