Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aadbq-0001cE-A0
 for kexec@lists.infradead.org; Tue, 01 Mar 2016 06:16:38 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: [PATCH 2/2] kexec: export OFFSET(page.compound_head) to find out
 compound tail page
Date: Tue, 1 Mar 2016 06:14:38 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E25FD3@BPXM01GP.gisp.nec.co.jp>
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
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

PageAnon() always look at head page to check PAGE_MAPPING_ANON and
tail page's page->mapping has just a poisoned data since commit
1c290f642101e6.

If makedumpfile checks page->mapping of an compound tail page to
distinguish anonymous page as usual, it must fail in newer kernel.
So it's necessary to export OFFSET(page.compound_head) to
avoid checking compound tail pages.

Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
---
 kernel/kexec_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 7c0b61d..4726999 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1415,6 +1415,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_OFFSET(page, private);
 	VMCOREINFO_OFFSET(page, compound_dtor);
 	VMCOREINFO_OFFSET(page, compound_order);
+	VMCOREINFO_OFFSET(page, compound_head);
 	VMCOREINFO_OFFSET(pglist_data, node_zones);
 	VMCOREINFO_OFFSET(pglist_data, nr_zones);
 #ifdef CONFIG_FLAT_NODE_MEM_MAP
-- 
2.7.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
