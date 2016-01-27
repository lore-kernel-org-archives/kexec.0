Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aOKSU-0003kL-FP
 for kexec@lists.infradead.org; Wed, 27 Jan 2016 07:24:19 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: [PATCH] kexec: Add compound_order/compound_dtor to VMCOREINFO
Date: Wed, 27 Jan 2016 07:19:01 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E19DFC@BPXM01GP.gisp.nec.co.jp>
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
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

makedumpfile refers to page.lru.next to get the order of compound pages
for page filtering. However, now the order is stored in page.compound_order,
hence VMCOREINFO should be updated to export the offset of page.compound_order.

The fact is, page.compound_order was introduced already in kernel 4.0,
but the offset of it was the same as page.lru.next until kernel 4.3,
so this was not actual problem.

The above can be said also for page.lru.prev, it contained the address of
destructor for compound pages but it was moved to page.compound_dtor.
It's necessary to detect hugetlbfs pages. Further, the content of
page.compound_dtor was changed from direct address of destructor to the
ID of it.

Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
---
 kernel/kexec_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 11b64a6..8c7a6e8 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1388,6 +1388,8 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_OFFSET(page, lru);
 	VMCOREINFO_OFFSET(page, _mapcount);
 	VMCOREINFO_OFFSET(page, private);
+	VMCOREINFO_OFFSET(page, compound_dtor);
+	VMCOREINFO_OFFSET(page, compound_order);
 	VMCOREINFO_OFFSET(pglist_data, node_zones);
 	VMCOREINFO_OFFSET(pglist_data, nr_zones);
 #ifdef CONFIG_FLAT_NODE_MEM_MAP
@@ -1420,8 +1422,8 @@ static int __init crash_save_vmcoreinfo_init(void)
 #ifdef CONFIG_X86
 	VMCOREINFO_NUMBER(KERNEL_IMAGE_SIZE);
 #endif
-#ifdef CONFIG_HUGETLBFS
-	VMCOREINFO_SYMBOL(free_huge_page);
+#ifdef CONFIG_HUGETLB_PAGE
+	VMCOREINFO_NUMBER(HUGETLB_PAGE_DTOR);
 #endif
 
 	arch_crash_save_vmcoreinfo();
-- 
1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
