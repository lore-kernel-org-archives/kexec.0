Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwym01.jp.fujitsu.com ([211.128.242.40])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZoR5G-0005zj-Va
 for kexec@lists.infradead.org; Tue, 20 Oct 2015 07:11:47 +0000
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
 by yt-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id A49FEAC0145
 for <kexec@lists.infradead.org>; Tue, 20 Oct 2015 16:11:22 +0900 (JST)
Date: Tue, 20 Oct 2015 16:11:16 +0900 (JST)
Message-Id: <20151020.161116.161122832.d.hatayama@jp.fujitsu.com>
Subject: [PATCH 2/2] sadump, bugfix: perform explicit zero page filtering
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20151020.160741.273311739.d.hatayama@jp.fujitsu.com>
References: <20151020.160741.273311739.d.hatayama@jp.fujitsu.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ats-kumagai@wm.jp.nec.com
Cc: indou.takao@jp.fujitsu.com, d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org

Currently, crash utility faces different behaviors on reading zero
pages that are filtered out on the kdump-compressed format originating
from kdump ELF and from sadump formats: the former succeeds in reading
zero pages but the latter fails. This is a design bug. To fix this
issue, perform zero pages filtering explicitly if some pages are
filtered out.

Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 sadump_info.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/sadump_info.c b/sadump_info.c
index e30b802..63d00c6 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -878,6 +878,21 @@ sadump_initialize_bitmap_memory(void)
 	bmp->offset = si->sub_hdr_offset + sh->block_size * sh->sub_hdr_size;
 	si->ram_bitmap = bmp;
 
+	/*
+	 * Perform explicitly zero filtering. Without this processing
+	 * crash utility faces different behaviors on reading zero
+	 * pages that are filtered out on the kdump-compressed format
+	 * originating from kdump ELF and from sadump formats: the
+	 * former succeeds in reading zero pages but the latter fails.
+	 */
+	for (pfn = 0; pfn < si->max_mapnr; pfn++) {
+		if (sadump_is_ram(pfn) &&
+		    !sadump_is_dumpable(info->bitmap_memory, pfn)) {
+			info->dump_level |= DL_EXCLUDE_ZERO;
+			break;
+		}
+	}
+
 	return TRUE;
 }
 
@@ -1053,9 +1068,8 @@ readpage_sadump(unsigned long long paddr, void *bufptr)
 	}
 
 	if (!sadump_is_dumpable(info->bitmap_memory, pfn)) {
-		ERRMSG("pfn(%llx) is excluded from %s.\n", pfn,
-		       info->name_memory);
-		return FALSE;
+		memset(bufptr, 0, info->page_size);
+		return TRUE;
 	}
 
 	block = pfn_to_block(pfn);
-- 
1.9.3



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
