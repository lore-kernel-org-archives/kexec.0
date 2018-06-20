Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fVZlE-0000Fk-Ed
 for kexec@lists.infradead.org; Wed, 20 Jun 2018 09:50:47 +0000
From: Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH 1/2] makedumpfile: Use monotonic clock to calculate ETA and
 stats
Date: Wed, 20 Jun 2018 11:50:18 +0200
Message-Id: <20180620095019.18449-1-ptesarik@suse.com>
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
To: lijiang <lijiang@redhat.com>, kexec-ml <kexec@lists.infradead.org>
Cc: Petr Tesarik <ptesarik@suse.com>

Execution time should be always measured by a monotonic clock,
because the system clock may be affected by discontinuous jumps,
e.g. when time is set manually by an admin.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 makedumpfile.c | 84 +++++++++++++++++++++++++++++-----------------------------
 print_info.c   | 30 +++++++++++----------
 print_info.h   |  6 ++---
 3 files changed, 61 insertions(+), 59 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 450825b..5908b5a 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5364,7 +5364,7 @@ _exclude_free_page(struct cycle *cycle)
 {
 	int i, nr_zones, num_nodes, node;
 	unsigned long node_zones, zone, spanned_pages, pgdat;
-	struct timeval tv_start;
+	struct timespec ts_start;
 
 	if ((node = next_online_node(0)) < 0) {
 		ERRMSG("Can't get next online node.\n");
@@ -5374,7 +5374,7 @@ _exclude_free_page(struct cycle *cycle)
 		ERRMSG("Can't get pgdat list.\n");
 		return FALSE;
 	}
-	gettimeofday(&tv_start, NULL);
+	clock_gettime(CLOCK_MONOTONIC, &ts_start);
 
 	for (num_nodes = 1; num_nodes <= vt.numnodes; num_nodes++) {
 
@@ -5420,7 +5420,7 @@ _exclude_free_page(struct cycle *cycle)
 	 * print [100 %]
 	 */
 	print_progress(PROGRESS_FREE_PAGES, vt.numnodes, vt.numnodes, NULL);
-	print_execution_time(PROGRESS_FREE_PAGES, &tv_start);
+	print_execution_time(PROGRESS_FREE_PAGES, &ts_start);
 
 	return TRUE;
 }
@@ -5567,7 +5567,7 @@ create_1st_bitmap_file(void)
  	char buf[info->page_size];
 	mdf_pfn_t pfn, pfn_start, pfn_end, pfn_bitmap1;
 	unsigned long long phys_start, phys_end;
-	struct timeval tv_start;
+	struct timespec ts_start;
 	off_t offset_page;
 
 	if (info->flag_refiltering)
@@ -5597,7 +5597,7 @@ create_1st_bitmap_file(void)
 		offset_page += info->page_size;
 	}
 
-	gettimeofday(&tv_start, NULL);
+	clock_gettime(CLOCK_MONOTONIC, &ts_start);
 
 	/*
 	 * If page is on memory hole, set bit on the 1st-bitmap.
@@ -5629,7 +5629,7 @@ create_1st_bitmap_file(void)
 	 */
 	if (!info->flag_mem_usage) {
 		print_progress(PROGRESS_HOLES, info->max_mapnr, info->max_mapnr, NULL);
-		print_execution_time(PROGRESS_HOLES, &tv_start);
+		print_execution_time(PROGRESS_HOLES, &ts_start);
 	}
 
 	if (!sync_1st_bitmap())
@@ -5731,7 +5731,7 @@ create_bitmap_from_memhole(struct cycle *cycle, struct dump_bitmap *bitmap, int
 	mdf_pfn_t pfn_start_roundup, pfn_end_round;
 	unsigned long pfn_start_byte, pfn_end_byte;
 	unsigned int num_pt_loads = get_num_pt_loads();
-	struct timeval tv_start;
+	struct timespec ts_start;
 
 	/*
 	 * At first, clear all the bits on the bitmap.
@@ -5741,7 +5741,7 @@ create_bitmap_from_memhole(struct cycle *cycle, struct dump_bitmap *bitmap, int
 	/*
 	 * If page is on memory hole, set bit on the bitmap.
 	 */
-	gettimeofday(&tv_start, NULL);
+	clock_gettime(CLOCK_MONOTONIC, &ts_start);
 	for (i = 0; get_pt_load(i, &phys_start, &phys_end, NULL, NULL); i++) {
 		pfn_start = MAX(paddr_to_pfn(phys_start), cycle->start_pfn);
 		pfn_end = MIN(paddr_to_pfn(phys_end), cycle->end_pfn);
@@ -5786,7 +5786,7 @@ create_bitmap_from_memhole(struct cycle *cycle, struct dump_bitmap *bitmap, int
 	 * print 100 %
 	 */
 	print_progress(PROGRESS_HOLES, info->max_mapnr, info->max_mapnr, NULL);
-	print_execution_time(PROGRESS_HOLES, &tv_start);
+	print_execution_time(PROGRESS_HOLES, &ts_start);
 
 	return TRUE;
 }
@@ -6046,14 +6046,14 @@ exclude_unnecessary_pages(struct cycle *cycle)
 {
 	unsigned int mm;
 	struct mem_map_data *mmd;
-	struct timeval tv_start;
+	struct timespec ts_start;
 
 	if (is_xen_memory() && !info->dom0_mapnr) {
 		ERRMSG("Can't get max domain-0 PFN for excluding pages.\n");
 		return FALSE;
 	}
 
-	gettimeofday(&tv_start, NULL);
+	clock_gettime(CLOCK_MONOTONIC, &ts_start);
 
 	for (mm = 0; mm < info->num_mem_map; mm++) {
 
@@ -6077,7 +6077,7 @@ exclude_unnecessary_pages(struct cycle *cycle)
 	 */
 	if (!info->flag_mem_usage) {
 		print_progress(PROGRESS_UNN_PAGES, info->num_mem_map, info->num_mem_map, NULL);
-		print_execution_time(PROGRESS_UNN_PAGES, &tv_start);
+		print_execution_time(PROGRESS_UNN_PAGES, &ts_start);
 	}
 
 	return TRUE;
@@ -7475,7 +7475,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	unsigned long frac_head, frac_tail;
 	off_t off_seg_load, off_memory;
 	Elf64_Phdr load;
-	struct timeval tv_start;
+	struct timespec ts_start;
 	struct cycle cycle = {0};
 
 	if (!info->flag_elf_dumpfile)
@@ -7500,7 +7500,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	if (!(phnum = get_phnum_memory()))
 		return FALSE;
 
-	gettimeofday(&tv_start, NULL);
+	clock_gettime(CLOCK_MONOTONIC, &ts_start);
 
 	for (i = 0; i < phnum; i++) {
 		if (!get_phdr_memory(i, &load))
@@ -7548,7 +7548,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 				}
 
 				if ((num_dumped % per) == 0)
-					print_progress(PROGRESS_COPY, num_dumped, num_dumpable, &tv_start);
+					print_progress(PROGRESS_COPY, num_dumped, num_dumpable, &ts_start);
 
 				num_dumped++;
 
@@ -7667,8 +7667,8 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	/*
 	 * print [100 %]
 	 */
-	print_progress(PROGRESS_COPY, num_dumpable, num_dumpable, &tv_start);
-	print_execution_time(PROGRESS_COPY, &tv_start);
+	print_progress(PROGRESS_COPY, num_dumpable, num_dumpable, &ts_start);
+	print_execution_time(PROGRESS_COPY, &ts_start);
 	PROGRESS_MSG("\n");
 
 	return TRUE;
@@ -8004,8 +8004,8 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
 	mdf_pfn_t per;
 	mdf_pfn_t start_pfn, end_pfn;
 	struct page_desc pd;
-	struct timeval tv_start;
-	struct timeval last, new;
+	struct timespec ts_start;
+	struct timespec last, new;
 	pthread_t **threads = NULL;
 	struct thread_args *kdump_thread_args = NULL;
 	void *thread_result;
@@ -8043,7 +8043,7 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
 	per = info->num_dumpable / 10000;
 	per = per ? per : 1;
 
-	gettimeofday(&tv_start, NULL);
+	clock_gettime(CLOCK_MONOTONIC, &ts_start);
 
 	start_pfn = cycle->start_pfn;
 	end_pfn   = cycle->end_pfn;
@@ -8091,7 +8091,7 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
 		 * The next pfn is smallest pfn in all page_flag_buf.
 		 */
 		sem_wait(&info->page_flag_buf_sem);
-		gettimeofday(&last, NULL);
+		clock_gettime(CLOCK_MONOTONIC, &last);
 		while (1) {
 			current_pfn = end_pfn;
 
@@ -8134,7 +8134,7 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
 			 * So we should recheck.
 			 */
 			if (info->page_flag_buf[consuming]->ready != FLAG_READY) {
-				gettimeofday(&new, NULL);
+				clock_gettime(CLOCK_MONOTONIC, &new);
 				if (new.tv_sec - last.tv_sec > WAIT_TIME) {
 					ERRMSG("Can't get data of pfn.\n");
 					goto out;
@@ -8147,7 +8147,7 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
 		}
 
 		if ((num_dumped % per) == 0)
-			print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable, &tv_start);
+			print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable, &ts_start);
 
 		num_dumped++;
 
@@ -8183,8 +8183,8 @@ finish:
 	/*
 	 * print [100 %]
 	 */
-	print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable, &tv_start);
-	print_execution_time(PROGRESS_COPY, &tv_start);
+	print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable, &ts_start);
+	print_execution_time(PROGRESS_COPY, &ts_start);
 	PROGRESS_MSG("\n");
 
 out:
@@ -8234,7 +8234,7 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 	struct page_desc pd;
 	unsigned char buf[info->page_size], *buf_out = NULL;
 	unsigned long len_buf_out;
-	struct timeval tv_start;
+	struct timespec ts_start;
 	const off_t failed = (off_t)-1;
 	unsigned long len_buf_out_zlib, len_buf_out_lzo, len_buf_out_snappy;
 
@@ -8295,12 +8295,12 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 			end_pfn = info->split_end_pfn;
 	}
 
-	gettimeofday(&tv_start, NULL);
+	clock_gettime(CLOCK_MONOTONIC, &ts_start);
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 
 		if ((num_dumped % per) == 0)
-			print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable, &tv_start);
+			print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable, &ts_start);
 
 		/*
 		 * Check the excluded page.
@@ -8380,8 +8380,8 @@ out:
 		free(wrkmem);
 #endif
 
-	print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable, &tv_start);
-	print_execution_time(PROGRESS_COPY, &tv_start);
+	print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable, &ts_start);
+	print_execution_time(PROGRESS_COPY, &ts_start);
 
 	return ret;
 }
@@ -8743,7 +8743,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 	off_t offset_data=0;
 	struct disk_dump_header *dh = info->dump_header;
 	unsigned char buf[info->page_size];
-	struct timeval tv_start;
+	struct timespec ts_start;
 
 	cd_header->offset
 		= (DISKDUMP_HEADER_BLOCKS + dh->sub_hdr_size + dh->bitmap_blocks)
@@ -8825,7 +8825,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 	}
 	free_bitmap2_buffer();
 
-	gettimeofday(&tv_start, NULL);
+	clock_gettime(CLOCK_MONOTONIC, &ts_start);
 
 	/*
 	 * Write the remainder.
@@ -8838,8 +8838,8 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 	/*
 	 * print [100 %]
 	 */
-	print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable, &tv_start);
-	print_execution_time(PROGRESS_COPY, &tv_start);
+	print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable, &ts_start);
+	print_execution_time(PROGRESS_COPY, &ts_start);
 	PROGRESS_MSG("\n");
 
 	return TRUE;
@@ -9559,10 +9559,10 @@ exclude_xen4_user_domain(void)
 int
 exclude_xen_user_domain(void)
 {
-	struct timeval tv_start;
+	struct timespec ts_start;
 	int ret;
 
-	gettimeofday(&tv_start, NULL);
+	clock_gettime(CLOCK_MONOTONIC, &ts_start);
 
 	if (info->xen_crash_info.com &&
 	    info->xen_crash_info.com->xen_major_version >= 4)
@@ -9574,7 +9574,7 @@ exclude_xen_user_domain(void)
 	 * print [100 %]
 	 */
 	print_progress(PROGRESS_XEN_DOMAIN, 1, 1, NULL);
-	print_execution_time(PROGRESS_XEN_DOMAIN, &tv_start);
+	print_execution_time(PROGRESS_XEN_DOMAIN, &ts_start);
 
 	return ret;
 }
@@ -10498,7 +10498,7 @@ reassemble_kdump_pages(void)
 	struct disk_dump_header dh;
 	struct page_desc pd, pd_zero;
 	struct cache_data cd_pd, cd_data;
-	struct timeval tv_start;
+	struct timespec ts_start;
 	char *data = NULL;
 	unsigned long data_buf_size = info->page_size;
 
@@ -10534,7 +10534,7 @@ reassemble_kdump_pages(void)
 	/*
 	 * Write page header of zero-filled page.
 	 */
-	gettimeofday(&tv_start, NULL);
+	clock_gettime(CLOCK_MONOTONIC, &ts_start);
 	if (info->dump_level & DL_EXCLUDE_ZERO) {
 		/*
 		 * makedumpfile outputs the data of zero-filled page at first
@@ -10569,7 +10569,7 @@ reassemble_kdump_pages(void)
 
 			num_dumped++;
 
-			print_progress(PROGRESS_COPY, num_dumped, num_dumpable, &tv_start);
+			print_progress(PROGRESS_COPY, num_dumped, num_dumpable, &ts_start);
 
 			if (lseek(fd, offset_ph_org, SEEK_SET) < 0) {
 				ERRMSG("Can't seek a file(%s). %s\n",
@@ -10666,8 +10666,8 @@ reassemble_kdump_pages(void)
 						    size_eraseinfo))
 			goto out;
 	}
-	print_progress(PROGRESS_COPY, num_dumpable, num_dumpable, &tv_start);
-	print_execution_time(PROGRESS_COPY, &tv_start);
+	print_progress(PROGRESS_COPY, num_dumpable, num_dumpable, &ts_start);
+	print_execution_time(PROGRESS_COPY, &ts_start);
 
 	ret = TRUE;
 out:
diff --git a/print_info.c b/print_info.c
index 6bfcd11..732d5b8 100644
--- a/print_info.c
+++ b/print_info.c
@@ -19,6 +19,8 @@
 
 #define PROGRESS_MAXLEN		"50"
 
+#define NSEC_PER_SEC		1000000000L
+
 int message_level;
 int flag_strerr_message;
 int flag_ignore_r_char; /* 0: '\r' is effective. 1: not effective. */
@@ -338,16 +340,16 @@ print_usage(void)
 	MSG("\n");
 }
 
-static void calc_delta(struct timeval *tv_start, struct timeval *delta)
+static void calc_delta(struct timespec *ts_start, struct timespec *delta)
 {
-	struct timeval tv_end;
+	struct timespec ts_end;
 
-	gettimeofday(&tv_end, NULL);
-	delta->tv_sec = tv_end.tv_sec - tv_start->tv_sec;
-	delta->tv_usec = tv_end.tv_usec - tv_start->tv_usec;
-	if (delta->tv_usec < 0) {
+	clock_gettime(CLOCK_MONOTONIC, &ts_end);
+	delta->tv_sec = ts_end.tv_sec - ts_start->tv_sec;
+	delta->tv_nsec = ts_end.tv_nsec - ts_start->tv_nsec;
+	if (delta->tv_nsec < 0) {
 		delta->tv_sec--;
-		delta->tv_usec += 1000000;
+		delta->tv_nsec += NSEC_PER_SEC;
 	}
 }
 
@@ -371,14 +373,14 @@ static int eta_to_human_short (unsigned long secs, char* msg)
 
 
 void
-print_progress(const char *msg, unsigned long current, unsigned long end, struct timeval *start)
+print_progress(const char *msg, unsigned long current, unsigned long end, struct timespec *start)
 {
 	unsigned progress;	/* in promilles (tenths of a percent) */
 	time_t tm;
 	static time_t last_time = 0;
 	static unsigned int lapse = 0;
 	static const char *spinner = "/|\\-";
-	struct timeval delta;
+	struct timespec delta;
 	unsigned long eta;
 	char eta_msg[16] = " ";
 
@@ -393,7 +395,7 @@ print_progress(const char *msg, unsigned long current, unsigned long end, struct
 
 	if (start != NULL && progress != 0) {
 		calc_delta(start, &delta);
-		eta = 1000 * delta.tv_sec + delta.tv_usec / 1000;
+		eta = 1000 * delta.tv_sec + delta.tv_nsec / (NSEC_PER_SEC / 1000);
 		eta = eta / progress - delta.tv_sec;
 		eta_to_human_short(eta, eta_msg);
 	}
@@ -411,12 +413,12 @@ print_progress(const char *msg, unsigned long current, unsigned long end, struct
 }
 
 void
-print_execution_time(char *step_name, struct timeval *tv_start)
+print_execution_time(char *step_name, struct timespec *ts_start)
 {
-	struct timeval delta;
+	struct timespec delta;
 
-	calc_delta(tv_start, &delta);
+	calc_delta(ts_start, &delta);
 	REPORT_MSG("STEP [%s] : %ld.%06ld seconds\n",
-		   step_name, delta.tv_sec, delta.tv_usec);
+		   step_name, delta.tv_sec, delta.tv_nsec / 1000);
 }
 
diff --git a/print_info.h b/print_info.h
index 1ce3593..49b70f4 100644
--- a/print_info.h
+++ b/print_info.h
@@ -17,7 +17,7 @@
 #define _PRINT_INFO_H
 
 #include <stdio.h>
-#include <sys/time.h>
+#include <time.h>
 
 extern int message_level;
 extern int flag_strerr_message;
@@ -25,9 +25,9 @@ extern int flag_ignore_r_char;
 
 void show_version(void);
 void print_usage(void);
-void print_progress(const char *msg, unsigned long current, unsigned long end, struct timeval *start);
+void print_progress(const char *msg, unsigned long current, unsigned long end, struct timespec *start);
 
-void print_execution_time(char *step_name, struct timeval *tv_start);
+void print_execution_time(char *step_name, struct timespec *ts_start);
 
 /*
  * Message texts
-- 
2.16.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
