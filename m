Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SbS9w-0001P1-Fr
 for kexec@lists.infradead.org; Mon, 04 Jun 2012 07:57:06 +0000
Date: Mon, 4 Jun 2012 16:54:49 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [RFC PATCH 0/4] makedumpfile: cyclic processing to keep memory
 consumption.
Message-Id: <20120604165449.e7236889.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <CAJGZr0LSC3GKKTSDm9zH4YiY3V3B27O1t0v7YQWNho_Q+s3msw@mail.gmail.com>
References: <20120531135358.c1fc797f.kumagai-atsushi@mxc.nes.nec.co.jp>
 <CAJGZr0LSC3GKKTSDm9zH4YiY3V3B27O1t0v7YQWNho_Q+s3msw@mail.gmail.com>
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
To: muvarov@gmail.com
Cc: kexec@lists.infradead.org

Hello Maxim,

On Thu, 31 May 2012 10:50:39 +0400
Maxim Uvarov <muvarov@gmail.com> wrote:

> Atsushi,
> 
> do you have speed measurements for saving vmcore with this patches and
> without them?
> How much is speed up?
> 
> Thanks,
> Maxim.

After received your mail, I measured executing time with the patch below.
The result below was measured in 5GB memory machine.

Result:
  a. makedumpfile -Kcd31 
    excluding time:   6.55 [sec]
    writing time:     5.89 [sec]

  b. makedumpfile -cd31
    excluding time:   0.21 [sec]
    writing time:     5.82 [sec]

I don't think this result is good, the prototype has some points to be
improved for performance. 
(e.g. buffer size, the way to exclude free pages, etc...)

However, I think getting a bit of speed down can't be helped to keep
memory consumption.


Thanks
Atsushi Kumagai


From 56e807066b333e3ef26afe8745deab8c952b5ca6 Mon Sep 17 00:00:00 2001
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Mon, 4 Jun 2012 10:15:50 +0900
Subject: [PATCH] [RFC PATCH] Add time report for cyclic processing.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c |   25 +++++++++++++++++++++++++
 makedumpfile.h |   11 +++++++++++
 2 files changed, 36 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index f4b6f83..a211a89 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -45,6 +45,9 @@ unsigned long long pfn_user;
 unsigned long long pfn_free;
 unsigned long long num_dumped;
 
+double d_exclude_start, d_exclude_end, d_exclude_time;
+double d_write_start, d_write_end, d_write_time;
+
 int retcd = FAILED;	/* return code */
 
 #define INITIALIZE_LONG_TABLE(table, value) \
@@ -4078,10 +4081,13 @@ create_dump_bitmap(void)
 	} else {
 		if (!prepare_bitmap_buffer())
 			goto out;
+		d_exclude_start = getdtime();
 		if (!create_1st_bitmap())
 			goto out;
 		if (!create_2nd_bitmap())
 			goto out;
+		d_exclude_end = getdtime();
+		d_exclude_time += d_exclude_end - d_exclude_start;		
 	}
 
 	ret = TRUE;
@@ -5500,12 +5506,15 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 	/*
 	 * Get number of dumpable pages.
 	 */
+	d_exclude_start = getdtime();
 	for (info->split_start_pfn = 0, info->split_end_pfn = PFN_CYCLIC;
 	     info->split_end_pfn <= info->max_mapnr;
 	     info->split_start_pfn += PFN_CYCLIC, info->split_end_pfn += PFN_CYCLIC) {
 
 		info->num_dumpable += get_num_dumpable_cyclic();
 	}
+	d_exclude_end = getdtime();
+	d_exclude_time += d_exclude_end - d_exclude_start;
 
 	/*
 	 * Reset counter for debug message.
@@ -5540,26 +5549,35 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 	     info->split_end_pfn <= info->max_mapnr;
 	     info->split_start_pfn += PFN_CYCLIC, info->split_end_pfn += PFN_CYCLIC) {
 
+		d_exclude_start = getdtime();
 		if (!create_1st_bitmap_cyclic())
 			return FALSE;
 
 		if (!exclude_unnecessary_pages_cyclic())
 			return FALSE;
+		d_exclude_end = getdtime();
+		d_exclude_time += d_exclude_end - d_exclude_start;
 
+		d_write_start = getdtime();
 		if (!write_kdump_pages_cyclic(cd_header, cd_page, &pd_zero, &offset_data))
 			return FALSE;
 
 		if (!write_kdump_bitmap_cyclic())
 			return FALSE;
+		d_write_end = getdtime();
+		d_write_time += d_write_end - d_write_start;
 	}
 
 	/*
 	 * Write the remainder.
 	 */
+	d_write_start = getdtime();
 	if (!write_cache_bufsz(cd_page))
 		return FALSE;
 	if (!write_cache_bufsz(cd_header))
 		return FALSE;
+	d_write_end = getdtime();
+	d_write_time += d_write_end - d_write_start;
 
 	return TRUE;
 }
@@ -6310,6 +6328,10 @@ print_report(void)
 	REPORT_MSG("--------------------------------------------------\n");
 	REPORT_MSG("Total pages     : 0x%016llx\n", info->max_mapnr);
 	REPORT_MSG("\n");
+
+	MSG("\n");
+	MSG("excluding time  %lf [sec]\n", d_exclude_time);
+	MSG("writing time: %lf [sec]\n", d_write_time);
 }
 
 int
@@ -6349,10 +6371,13 @@ writeout_dumpfile(void)
 		if (!write_kdump_eraseinfo(&cd_page))
 			goto out;
 	} else {
+		d_write_start = getdtime();
 		if (!write_kdump_header())
 			goto out;
 		if (!write_kdump_pages(&cd_header, &cd_page))
 			goto out;
+		d_write_end = getdtime();
+		d_write_time = d_write_end - d_write_start;
 		if (!write_kdump_eraseinfo(&cd_page))
 			goto out;
 		if (!write_kdump_bitmap())
diff --git a/makedumpfile.h b/makedumpfile.h
index a8aab2a..ca9b100 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -16,6 +16,7 @@
 #ifndef _MAKEDUMPFILE_H
 #define _MAKEDUMPFILE_H
 
+#include <sys/time.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <fcntl.h>
@@ -1502,4 +1503,14 @@ struct elf_prstatus {
 
 #endif
 
+static inline double
+getdtime(void)
+{
+	struct timeval tv;
+	
+	gettimeofday(&tv, NULL);
+	
+	return (double)tv.tv_sec + (double)tv.tv_usec * 0.001 * 0.001;
+}
+
 #endif /* MAKEDUMPFILE_H */
-- 
1.7.9.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
