Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XRGVY-0000Wa-Ll
 for kexec@lists.infradead.org; Tue, 09 Sep 2014 08:10:37 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.193])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id s898A8bm010629
 for <kexec@lists.infradead.org>; Tue, 9 Sep 2014 17:10:08 +0900 (JST)
Received: from mailsv.nec.co.jp (imss63.nec.co.jp [10.7.69.158]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id s898A8C09039 for <kexec@lists.infradead.org>;
 Tue, 9 Sep 2014 17:10:08 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id s898A8s9011504
 for <kexec@lists.infradead.org>; Tue, 9 Sep 2014 17:10:08 +0900 (JST)
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH] makedumpfile: Stop adjusting info->max_mapnr when no
 mem_maps are found.
Date: Tue, 9 Sep 2014 08:08:36 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE97253B62@BPXM01GP.gisp.nec.co.jp>
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello,

I found an issue during the test for v1.5.7, so I fixed it
by the patch below and I'm re-testing now.
I'm still going to release v1.5.7 in this week, please
wait a little longer.


Thanks
Atsushi Kumagai

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Mon, 8 Sep 2014 16:04:17 +0900
Subject: [PATCH] Stop adjusting info->max_mapnr when no mem_maps are found.

If mem_maps are allocated with remap allocator, makedumpfile can't
find them without vmlinux. In that case, info->max_mapnr will be
truncated to 0 and there will be no page data in a dump file.

This patch enables the environment above to save full dump at
least.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index c965745..230e5fd 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2963,12 +2963,16 @@ get_mem_map(void)
 	 * dumped system.
 	 */
 	if (!is_xen_memory()) {
+		unsigned int valid_memmap = 0;
 		for (i = 0; i < info->num_mem_map; i++) {
 			if (info->mem_map_data[i].mem_map == NOT_MEMMAP_ADDR)
 				continue;
 			max_pfn = MAX(max_pfn, info->mem_map_data[i].pfn_end);
+			valid_memmap++;
+		}
+		if (valid_memmap) {
+			info->max_mapnr = MIN(info->max_mapnr, max_pfn);
 		}
-		info->max_mapnr = MIN(info->max_mapnr, max_pfn);
 	}
 	return ret;
 }
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
