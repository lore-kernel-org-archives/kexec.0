Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwym02.jp.fujitsu.com ([211.128.242.41])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1bEsGn-0005VZ-JV
 for kexec@lists.infradead.org; Mon, 20 Jun 2016 06:01:14 +0000
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
 by yt-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 23AF5AC03BE
 for <kexec@lists.infradead.org>;
 Mon, 20 Jun 2016 15:00:46 +0900 (JST)
Date: Mon, 20 Jun 2016 15:00:37 +0900 (JST)
Message-Id: <20160620.150037.194320068.d.hatayama@jp.fujitsu.com>
Subject: [PATCH 2/2] sadump: fix wrong progress report on sadump formats
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20160620.145744.403680288.d.hatayama@jp.fujitsu.com>
References: <20160620.145744.403680288.d.hatayama@jp.fujitsu.com>
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
Cc: kexec@lists.infradead.org

Currently, makedumpfile displays wrong progress report on sadump
formats and could result in "Floating point exception" in the worst
case:

    Original pages  : 0x0000000000000000
      Excluded pages   : 0x0000000001f2b44a
        Pages filled with zero  : 0x0000000000b160b5
        Non-private cache pages : 0x0000000000007a7e
        Private cache pages     : 0x0000000000000431
        User process data pages : 0x000000000140d4dc
        Free pages              : 0x0000000000000000
        Hwpoison pages          : 0x000000000000000a
      Remaining pages  : 0xfffffffffe0d4bb6
    Floating point exception (core dumped)

This is because on sadump-related formats, the number of memory hole
pages is not counted, the number of original pages becomes 0 and zero
division exception occurs below:

    9409void
    9410print_report(void)
    9411{
    9412        mdf_pfn_t pfn_original, pfn_excluded, shrinking;
    9413
    9414        /*
    9415         * /proc/vmcore doesn't contain the memory hole area.
    9416         */
    9417        pfn_original = info->max_mapnr - pfn_memhole;
    9418
    9419        pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private
    9420            + pfn_user + pfn_free + pfn_hwpoison;
    9421        shrinking = (pfn_original - pfn_excluded) * 100;
    9422        shrinking = shrinking / pfn_original;  <-- Here.

This commit fixes this issue by counting the number of memory hole
pages and so the number of original pages. As a result, makedumpfile
displays correct progress report on sadump formats and doesn't exit
abnormally:

    Original pages  : 0x0000000001ffaa23
      Excluded pages   : 0x0000000001f2b44a
        Pages filled with zero  : 0x0000000000b160b5
        Non-private cache pages : 0x0000000000007a7e
        Private cache pages     : 0x0000000000000431
        User process data pages : 0x000000000140d4dc
        Free pages              : 0x0000000000000000
        Hwpoison pages          : 0x000000000000000a
      Remaining pages  : 0x00000000000cf5d9
      (The number of pages is reduced to 2%.)
    Memory Hole     : 0x00000000000a55dd
    --------------------------------------------------
    Total pages     : 0x00000000020a0000

    Cache hit: 1570176, miss: 12997082, hit rate: 10.8%

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 sadump_info.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sadump_info.c b/sadump_info.c
index 8716167..5ff5595 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -213,6 +213,8 @@ sadump_copy_1st_bitmap_from_memory(void)
 	char buf[si->sh_memory->block_size];
 	off_t offset_page;
 	unsigned long bitmap_offset, bitmap_len;
+	mdf_pfn_t pfn, pfn_bitmap1;
+	extern mdf_pfn_t pfn_memhole;
 
 	bitmap_offset =	si->sub_hdr_offset + sh->block_size*sh->sub_hdr_size;
 	bitmap_len = sh->block_size * sh->bitmap_blocks;
@@ -250,6 +252,13 @@ sadump_copy_1st_bitmap_from_memory(void)
 		offset_page += sizeof(buf);
 	}
 
+	pfn_bitmap1 = 0;
+	for (pfn = 0; pfn < info->max_mapnr; ++pfn) {
+		if (sadump_is_ram(pfn))
+			pfn_bitmap1++;
+	}
+	pfn_memhole = info->max_mapnr - pfn_bitmap1;
+
 	/*
 	 * kdump uses the first 640kB on the 2nd kernel. But both
 	 * bitmaps should reflect the 1st kernel memory situation. We
-- 
1.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
