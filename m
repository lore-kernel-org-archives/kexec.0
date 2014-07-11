Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X5V4Z-0004I3-8Y
 for kexec@lists.infradead.org; Fri, 11 Jul 2014 07:16:47 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 1/7] initialize pfn_memhole in get_num_dumpable_cyclic
Date: Fri, 11 Jul 2014 15:15:58 +0800
Message-Id: <1405062964-11406-1-git-send-email-bhe@redhat.com>
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
To: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp
Cc: Baoquan He <bhe@redhat.com>, vgoyal@redhat.com

This is a code bug. In initialize_2nd_bitmap_cyclic pfn_memhole is
calculated, however it's not initialized before that. If an available
pfn_memhole is wanted after get_num_dumpable_cyclic invocation,
initializing pfn_memhole in get_num_dumpable_cyclic is necessary.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 makedumpfile.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 3884aa5..760bfd1 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5588,6 +5588,8 @@ get_num_dumpable_cyclic(void)
 	mdf_pfn_t pfn, num_dumpable=0;
 	struct cycle cycle = {0};
 
+	pfn_memhole = info->max_mapnr;
+
 	for_each_cycle(0, info->max_mapnr, &cycle)
 	{
 		if (!exclude_unnecessary_pages_cyclic(&cycle))
-- 
1.8.4.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
