Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from szxga01-in.huawei.com ([119.145.14.64])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WVyVt-0008Qp-Ck
 for kexec@lists.infradead.org; Fri, 04 Apr 2014 07:26:11 +0000
From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH] makedumpfile: bugfix: fix a div-by-zero problem
Date: Fri, 4 Apr 2014 15:19:52 +0800
Message-ID: <1396595992-65949-1-git-send-email-wangnan0@huawei.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: Wang Nan <wangnan0@huawei.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Geng Hui <hui.geng@huawei.com>

In makedumpfile.c, we want the progress printed 10000 times.
It is tested by:

(num_dumped % per) == 0

where per is num_dumpable / 10000.

However, if num_dumpable less than 10000, num_dumped % per causes a
divide-by-zero problem, triggers a SIGFPE.

This patch makes sure per never be 0.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org
Cc: Geng Hui <hui.geng@huawei.com>
Cc: Simon Horman <horms@verge.net.au>
---
 makedumpfile.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 23251a1..d71977a 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5621,6 +5621,7 @@ write_elf_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 
 	num_dumpable = get_num_dumpable();
 	per = num_dumpable / 10000;
+	per = per ? per : 1;
 
 	off_seg_load    = info->offset_load_dumpfile;
 	cd_page->offset = info->offset_load_dumpfile;
@@ -5906,6 +5907,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 
 	num_dumpable = info->num_dumpable;
 	per = num_dumpable / 10000;
+	per = per ? per : 1;
 
 	off_seg_load   = info->offset_load_dumpfile;
 	cd_page->offset = info->offset_load_dumpfile;
@@ -6164,6 +6166,7 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 
 	num_dumpable = get_num_dumpable();
 	per = num_dumpable / 10000;
+	per = per ? per : 1;
 
 	/*
 	 * Calculate the offset of the page data.
@@ -6365,6 +6368,7 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 	}
 
 	per = info->num_dumpable / 10000;
+	per = per ? per : 1;
 
 	/*
 	 * Set a fileoffset of Physical Address 0x0.
-- 
1.8.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
