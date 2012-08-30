Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T6ziz-00027l-Jw
 for kexec@lists.infradead.org; Thu, 30 Aug 2012 08:03:38 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.192])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U83ZkI014318
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 17:03:35 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q7U83ZR01976 for kexec@lists.infradead.org;
 Thu, 30 Aug 2012 17:03:35 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U83ZQq019791
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 17:03:35 +0900 (JST)
Date: Thu, 30 Aug 2012 16:55:42 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 11/16] [PATCH v3 11/12] Remove waste calculation to improve
 performance.
Message-Id: <20120830165542.20a1646a9738a17076b3d0c9@mxc.nes.nec.co.jp>
In-Reply-To: <20120830164422.8d05cbcdd650398d5d5cbad9@mxc.nes.nec.co.jp>
References: <20120830164422.8d05cbcdd650398d5d5cbad9@mxc.nes.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Fri, 24 Aug 2012 10:16:52 +0900
Subject: [PATCH 11/16] [PATCH v3 11/12] Remove waste calculation to improve performance.

This patch adds check whether each page correspond to target memory
region or not into filtering logic.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index cc90d39..879f73a 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3751,6 +3751,12 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 	for (pfn = pfn_start; pfn < pfn_end; pfn++, mem_map += SIZE(page)) {
 
 		/*
+		 * If this pfn doesn't belong to target region, skip this pfn.
+		 */
+		if (info->flag_cyclic && !is_cyclic_region(pfn))
+			continue;
+
+		/*
 		 * Exclude the memory hole.
 		 */
 		if (is_xen_memory()) {
-- 
1.7.9.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
