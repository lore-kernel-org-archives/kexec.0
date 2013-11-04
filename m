Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VdM70-0006ia-Ps
 for kexec@lists.infradead.org; Mon, 04 Nov 2013 15:30:43 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 195063EE0B6
 for <kexec@lists.infradead.org>; Tue,  5 Nov 2013 00:30:21 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 08E4E45DE54
 for <kexec@lists.infradead.org>; Tue,  5 Nov 2013 00:30:21 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.nic.fujitsu.com [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id D447645DE55
 for <kexec@lists.infradead.org>; Tue,  5 Nov 2013 00:30:20 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id C8B38E08002
 for <kexec@lists.infradead.org>; Tue,  5 Nov 2013 00:30:20 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 77EA91DB8046
 for <kexec@lists.infradead.org>; Tue,  5 Nov 2013 00:30:20 +0900 (JST)
Message-ID: <5277BD5F.6030207@jp.fujitsu.com>
Date: Tue, 05 Nov 2013 00:29:35 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH v2] makedumpfile: improve progress information for huge memory
 system
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Jingbai Ma <jingbai.ma@hp.com>

On system with huge memory, percentage in progress information is
updated at very slow interval, because 1 percent on 1 TiB memory is
about 10 GiB, which looks like as if system has freezed. Then,
confused users might get tempted to push a reset button to recover the
system. We want to avoid such situation as much as possible.

To address the issue, this patch:

- increases the number of calling print_progress() from once in
  (written pages / 100)-pages to once in (written pages /
  10000)-pages,

- extends precision in progress information by adding 1 digit to its
  fractional part, and

- adds spinner that rotates in the order of /, |, \ and - in next to
  the progress indicator in percentage,

which help users to get aware that system is still active and crash
dump process is still in progress now.

The spinner code is borrowed from diskdump code.

The ouput is changed from:

Copying data                       : [  0 %] /
Copying data                       : [  8 %] |
Copying data                       : [ 11 %] \
Copying data                       : [ 14 %] -
Copying data                       : [ 16 %] /
...
Copying data                       : [ 99 %] /
Copying data                       : [100 %] |

to:

Copying data                       : [  0.1 %] /
Copying data                       : [  8.9 %] |
Copying data                       : [ 11.6 %] \
Copying data                       : [ 14.3 %] -
Copying data                       : [ 16.4 %] /
...
Copying data                       : [ 99.2 %] /
Copying data                       : [100.0 %] |

This patch doesn't adopt purely time-based approach that records the
time when print_progress() is called at each invocation and print the
recorded time if it is strictly larger than the previous time value.

The problem is that calling time() system call amounts to
considertably long time in total on huge memory system. For example,
here is a simple bench that measures total execution time of time()
system call for (1TiB / 4KiB)-times:

$ ./bench
total: 18.360503
total: 34.910297

the result of which reveals that it amounts to about 20 seconds with
vDSO optimization and about 35 seconds without.

BTW, on our 12 TiB memory system, we collect about 300 GiB crash dump
in about 40 minutes with dump level 31. On 12TiB, the benchmark result
corresponds to about 4 minutes and 7 minutes respectively, both of which
affects a whole performance.

==bench.c
static inline double getdtime(void)
{
        struct timeval tv;
        gettimeofday(&tv, NULL);
        return (double)tv.tv_sec + (double)tv.tv_usec * 1.0e-6;
}

int main(int argc, char **argv)
{
        unsigned long i;
        time_t t;
        double t1, t2, total;
        const int NR_time = 201;
        const unsigned long nr_repeat = (1UL << 40) / 4096;

        total = 0;
        for (i = 0; i < nr_repeat; ++i) {
                t1 = getdtime();
                time(&t);
                t2 = getdtime();
                total += t2 - t1;
        }
        printf("total: %lf\n", total);

        total = 0;
        for (i = 0; i < nr_repeat; ++i) {
                t1 = getdtime();
                syscall(NR_time, &t);
                t2 = getdtime();
                total += t2 - t1;
        }
        printf("total: %lf\n", total);

        return 0;
}
==

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 makedumpfile.c |  8 ++++----
 print_info.c   | 15 +++++++++------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 428c53e..d00cf38 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5409,7 +5409,7 @@ write_elf_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 	initialize_2nd_bitmap(&bitmap2);
 
 	num_dumpable = get_num_dumpable();
-	per = num_dumpable / 100;
+	per = num_dumpable / 10000;
 
 	off_seg_load    = info->offset_load_dumpfile;
 	cd_page->offset = info->offset_load_dumpfile;
@@ -5694,7 +5694,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 		return FALSE;
 
 	num_dumpable = info->num_dumpable;
-	per = num_dumpable / 100;
+	per = num_dumpable / 10000;
 
 	off_seg_load   = info->offset_load_dumpfile;
 	cd_page->offset = info->offset_load_dumpfile;
@@ -5952,7 +5952,7 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 	}
 
 	num_dumpable = get_num_dumpable();
-	per = num_dumpable / 100;
+	per = num_dumpable / 10000;
 
 	/*
 	 * Calculate the offset of the page data.
@@ -6153,7 +6153,7 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 		goto out;
 	}
 
-	per = info->num_dumpable / 100;
+	per = info->num_dumpable / 10000;
 
 	/*
 	 * Set a fileoffset of Physical Address 0x0.
diff --git a/print_info.c b/print_info.c
index 3527970..d7a8600 100644
--- a/print_info.c
+++ b/print_info.c
@@ -283,27 +283,30 @@ print_usage(void)
 void
 print_progress(const char *msg, unsigned long current, unsigned long end)
 {
-	int progress;
+	float progress;
 	time_t tm;
 	static time_t last_time = 0;
+	static unsigned int lapse = 0;
+	static const char *spinner = "/|\\-";
 
 	if (current < end) {
 		tm = time(NULL);
 		if (tm - last_time < 1)
 			return;
 		last_time = tm;
-		progress = current * 100 / end;
+		progress = (float)current * 100 / end;
 	} else
 		progress = 100;
 
 	if (flag_ignore_r_char) {
-		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%]\n",
-			     msg, progress);
+		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%5.1f %%] %c\n",
+			     msg, progress, spinner[lapse % 4]);
 	} else {
 		PROGRESS_MSG("\r");
-		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%] ",
-			     msg, progress);
+		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%5.1f %%] %c",
+			     msg, progress, spinner[lapse % 4]);
 	}
+	lapse++;
 }
 
 void
-- 
1.8.3.1

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
