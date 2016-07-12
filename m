Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga02-in.huawei.com ([119.145.14.65])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bMpmR-0002WD-Fx
 for kexec@lists.infradead.org; Tue, 12 Jul 2016 04:58:49 +0000
From: zhongjiang <zhongjiang@huawei.com>
Subject: [PATCH 2/2] kexec: add a pmd huge entry condition during the page
 table
Date: Tue, 12 Jul 2016 12:56:43 +0800
Message-ID: <1468299403-27954-2-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1468299403-27954-1-git-send-email-zhongjiang@huawei.com>
References: <1468299403-27954-1-git-send-email-zhongjiang@huawei.com>
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
To: ebiederm@xmission.com, dyoung@redhat.com, horms@verge.net.au, vgoyal@redhat.com, yinghai@kernel.org, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, kexec@lists.infradead.org

From: zhong jiang <zhongjiang@huawei.com>

when image is loaded into kernel, we need set up page table for it. and 
all valid pfn also set up new mapping. it will tend to establish a pmd 
page table in the form of a large page if pud_present is true. relocate_kernel 
points to code segment can locate in the pmd huge entry in init_transtion_pgtable. 
therefore, we need to take the situation into account.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 arch/x86/kernel/machine_kexec_64.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 5a294e4..c33e344 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -14,6 +14,7 @@
 #include <linux/gfp.h>
 #include <linux/reboot.h>
 #include <linux/numa.h>
+#include <linux/hugetlb.h>
 #include <linux/ftrace.h>
 #include <linux/io.h>
 #include <linux/suspend.h>
@@ -34,6 +35,17 @@ static struct kexec_file_ops *kexec_file_loaders[] = {
 };
 #endif
 
+static void split_pmd(pmd_t *pmd, pte_t *pte)
+{
+	unsigned long pfn = pmd_pfn(*pmd);
+	int i = 0;
+
+	do {
+		set_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC));
+		pfn++;
+	} while (pte++, i++, i < PTRS_PER_PTE);
+}
+
 static void free_transition_pgtable(struct kimage *image)
 {
 	free_page((unsigned long)image->arch.pud);
@@ -68,15 +80,19 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
 		set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
 	}
 	pmd = pmd_offset(pud, vaddr);
-	if (!pmd_present(*pmd)) {
+	if (!pmd_present(*pmd) || pmd_huge(*pmd)) {
 		pte = (pte_t *)get_zeroed_page(GFP_KERNEL);
 		if (!pte)
 			goto err;
 		image->arch.pte = pte;
-		set_pmd(pmd, __pmd(__pa(pte) | _KERNPG_TABLE));
+		if (pmd_huge(*pmd))
+			split_pmd(pmd, pte);
+		else
+			set_pmd(pmd, __pmd(__pa(pte) | _KERNPG_TABLE));
 	}
 	pte = pte_offset_kernel(pmd, vaddr);
 	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, PAGE_KERNEL_EXEC));
+
 	return 0;
 err:
 	free_transition_pgtable(image);
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
