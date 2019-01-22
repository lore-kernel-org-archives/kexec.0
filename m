Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glr2e-0003ol-EQ
 for kexec@lists.infradead.org; Tue, 22 Jan 2019 08:04:22 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 2/2] Remove the memory encryption mask to obtain the true
 physical address
Date: Tue, 22 Jan 2019 16:03:57 +0800
Message-Id: <20190122080357.23381-3-lijiang@redhat.com>
In-Reply-To: <20190122080357.23381-1-lijiang@redhat.com>
References: <20190122080357.23381-1-lijiang@redhat.com>
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
To: kexec@lists.infradead.org
Cc: dyoung@redhat.com, k-hagio@ab.jp.nec.com, anderson@redhat.com, bhe@redhat.com

For AMD machine with SME feature, if SME is enabled in the first
kernel, the crashed kernel's page table(pgd/pud/pmd/pte) contains
the memory encryption mask, so makedumpfile needs to remove the
memory encryption mask to obtain the true physical address.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86_64.c  | 3 +++
 makedumpfile.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/x86_64.c b/arch/x86_64.c
index 537fb78..7651d36 100644
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -346,6 +346,7 @@ __vtop4_x86_64(unsigned long vaddr, unsigned long pagetable)
 			return NOT_PADDR;
 		}
 		pud_paddr  = pgd & ENTRY_MASK;
+		pud_paddr = pud_paddr & ~(NUMBER(sme_mask));
 	}
 
 	/*
@@ -371,6 +372,7 @@ __vtop4_x86_64(unsigned long vaddr, unsigned long pagetable)
 	 * Get PMD.
 	 */
 	pmd_paddr  = pud_pte & ENTRY_MASK;
+	pmd_paddr = pmd_paddr & ~(NUMBER(sme_mask));
 	pmd_paddr += pmd_index(vaddr) * sizeof(unsigned long);
 	if (!readmem(PADDR, pmd_paddr, &pmd_pte, sizeof pmd_pte)) {
 		ERRMSG("Can't get pmd_pte (pmd_paddr:%lx).\n", pmd_paddr);
@@ -391,6 +393,7 @@ __vtop4_x86_64(unsigned long vaddr, unsigned long pagetable)
 	 * Get PTE.
 	 */
 	pte_paddr  = pmd_pte & ENTRY_MASK;
+	pte_paddr = pte_paddr & ~(NUMBER(sme_mask));
 	pte_paddr += pte_index(vaddr) * sizeof(unsigned long);
 	if (!readmem(PADDR, pte_paddr, &pte, sizeof pte)) {
 		ERRMSG("Can't get pte (pte_paddr:%lx).\n", pte_paddr);
diff --git a/makedumpfile.c b/makedumpfile.c
index a03aaa1..81c7bb4 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -977,6 +977,7 @@ next_page:
 	read_size = MIN(info->page_size - PAGEOFFSET(paddr), size);
 
 	pgaddr = PAGEBASE(paddr);
+	pgaddr = pgaddr & ~(NUMBER(sme_mask));
 	pgbuf = cache_search(pgaddr, read_size);
 	if (!pgbuf) {
 		++cache_miss;
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
