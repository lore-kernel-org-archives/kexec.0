Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W31aj-0007oE-2X
 for kexec@lists.infradead.org; Tue, 14 Jan 2014 10:51:30 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 2636D3EE1D1
 for <kexec@lists.infradead.org>; Tue, 14 Jan 2014 19:50:59 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 1681845DE4E
 for <kexec@lists.infradead.org>; Tue, 14 Jan 2014 19:50:59 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.nic.fujitsu.com [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 007F745DD77
 for <kexec@lists.infradead.org>; Tue, 14 Jan 2014 19:50:59 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id E6F401DB803E
 for <kexec@lists.infradead.org>; Tue, 14 Jan 2014 19:50:58 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 920711DB8032
 for <kexec@lists.infradead.org>; Tue, 14 Jan 2014 19:50:58 +0900 (JST)
Message-ID: <52D51655.2020700@jp.fujitsu.com>
Date: Tue, 14 Jan 2014 19:49:57 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH] makedumpfile: fix wrong report time for copying data
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Cliff Wickman <cpw@sgi.com>

From 81c669484d6e38856f931af025e0d391abcdd168 Mon Sep 17 00:00:00 2001
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Fri, 10 Jan 2014 12:29:03 +0900
Subject: [PATCH] fix wrong report time for copying data

Currently, in cyclic mode, reported time for copying pages includes
the time consumed for 1) update cycles, 2) filtering memory, 3)
writing pages and 4) other things among the three. This is wrong. The
``copying pages'' should be ``3) writing pages'' only.

On the system with terabyte-scale memory, it requires several minutes
to process memory filtering. As a result, on such system, copying data
in cyclic mode looks several minutes slower than the actual.

This patch fixes this by counting times for ``3) writing pages'' only
as a time for ``copying pages.''

The output changes like below:

[before]

Excluding unnecessary pages        : [100.0 %] \STEP [Excluding unnecessary pages] : 0.124988 seconds
Excluding unnecessary pages        : [100.0 %] -STEP [Excluding unnecessary pages] : 0.142915 seconds
Excluding unnecessary pages        : [100.0 %] /STEP [Excluding unnecessary pages] : 0.024244 seconds
Excluding unnecessary pages        : [100.0 %] |STEP [Excluding unnecessary pages] : 0.118873 seconds
Excluding unnecessary pages        : [100.0 %] \STEP [Excluding unnecessary pages] : 0.142979 seconds
Excluding unnecessary pages        : [100.0 %] -STEP [Excluding unnecessary pages] : 0.024361 seconds
Excluding unnecessary pages        : [100.0 %] /STEP [Excluding unnecessary pages] : 0.118428 seconds
Excluding unnecessary pages        : [100.0 %] \STEP [Excluding unnecessary pages] : 0.143258 seconds
Excluding unnecessary pages        : [100.0 %] |STEP [Excluding unnecessary pages] : 0.024470 seconds
Copying data                       : [100.0 %] -STEP [Copying data               ] : 19.807846 seconds

[after]

Excluding unnecessary pages        : [100.0 %] \STEP [Excluding unnecessary pages] : 0.118851 seconds
Excluding unnecessary pages        : [100.0 %] -STEP [Excluding unnecessary pages] : 0.142766 seconds
Excluding unnecessary pages        : [100.0 %] /STEP [Excluding unnecessary pages] : 0.024204 seconds
Excluding unnecessary pages        : [100.0 %] |STEP [Excluding unnecessary pages] : 0.118849 seconds
Excluding unnecessary pages        : [100.0 %] \STEP [Excluding unnecessary pages] : 0.142812 seconds
Excluding unnecessary pages        : [100.0 %] -STEP [Excluding unnecessary pages] : 0.024394 seconds
Excluding unnecessary pages        : [100.0 %] /STEP [Excluding unnecessary pages] : 0.118293 seconds
Copying data                       : [ 25.6 %] |STEP [Copying data               ] : 4.343230 seconds
Excluding unnecessary pages        : [100.0 %] \STEP [Excluding unnecessary pages] : 0.143136 seconds
Copying data                       : [ 73.4 %] /STEP [Copying data               ] : 9.939977 seconds
Excluding unnecessary pages        : [100.0 %] |STEP [Excluding unnecessary pages] : 0.024642 seconds
Copying data                       : [100.0 %] -STEP [Copying data               ] : 4.844130 seconds
Copying data                       : [100.0 %] /STEP [Copying data               ] : 0.000093 seconds

So, you need to calculate a total time for copying data by yourself.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 makedumpfile.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index ef08d91..32ad513 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -6331,6 +6331,7 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 	struct page_desc pd;
 	unsigned char buf[info->page_size], *buf_out = NULL;
 	unsigned long len_buf_out;
+	struct timeval tv_start;
 	const off_t failed = (off_t)-1;
 	unsigned long len_buf_out_zlib, len_buf_out_lzo, len_buf_out_snappy;
 
@@ -6390,6 +6391,8 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 			end_pfn = info->split_end_pfn;
 	}
 
+	gettimeofday(&tv_start, NULL);
+
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 
 		if ((num_dumped % per) == 0)
@@ -6482,6 +6485,9 @@ out:
 		free(wrkmem);
 #endif
 
+	print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable);
+	print_execution_time(PROGRESS_COPY, &tv_start);
+
 	return ret;
 }
 
@@ -6816,8 +6822,6 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 	unsigned long long pfn;
 	struct timeval tv_start;
 
-	gettimeofday(&tv_start, NULL);
-
 	/*
 	 * Reset counter for debug message.
 	 */
@@ -6888,6 +6892,8 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 			return FALSE;
         }
 
+	gettimeofday(&tv_start, NULL);
+
 	/*
 	 * Write the remainder.
 	 */
-- 
1.8.4.2

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
