Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aqwKf-0001DE-4U
 for kexec@lists.infradead.org; Fri, 15 Apr 2016 05:30:17 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH v7] Improve the performance of --num-threads -d 31
Date: Fri, 15 Apr 2016 05:25:10 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E3ACC1@BPXM01GP.gisp.nec.co.jp>
References: <1460689191-21923-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1460689191-21923-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
To: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>v7:
>	1. fix a bug pointed by Minfei Huang
>v6:
>        1. address Atsushi Kumagai's comments about calculating and reserving memory
>v5:
>        1. remove unused variable check_out
>        2. reset num_threads if memory is not enough
>v4:
>        1. fix a bug caused by the logic
>v3:
>        1. remove some unused variables
>        2. fix a bug caused by the wrong logic
>        3. fix a bug caused by optimising
>        4. improve more performance by using Minoru Usui's code

I have just one comment for this version:

[snip]

>@@ -10223,6 +10263,26 @@ calculate_cyclic_buffer_size(void) {
> 	 *  free memory for safety.
> 	 */
> 	limit_size = get_free_memory_size() * 0.6;
>+
>+	/*
>+	 * Recalculate the limit_size according to num_threads.
>+	 * And reset num_threads if there is not enough memory.
>+	 */
>+	if (limit_size < maximun_size) {
>+		if (info->num_threads > 0) {
>+			MSG("There isn't enough memory for multi-threads.\n");
>+			info->num_threads = 0;
>+		}
>+	}

This condition should be "limit_size <= maximun_size", otherwise
division by zero can occur below:


>+	else if ((limit_size - maximum_size) / info->num_threads < THREAD_REGION) {
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Thanks,
Atsushi Kumagai

>+		MSG("There isn't enough memory for %d threads.\n", info->num_threads);
>+
>+		info->num_threads = (limit_size - maximum_size) / THREAD_REGION;
>+		MSG("--num_threads is set to %d.\n", info->num_threads);
>+	}
>+
>+	limit_size = limit_size - THREAD_REGION * info->num_threads;
>+
> 	/* Try to keep both 1st and 2nd bitmap at the same time. */
> 	bitmap_size = info->max_mapnr * 2 / BITPERBYTE;
>
>diff --git a/makedumpfile.h b/makedumpfile.h
>index e0b5bbf..322d31b 100644
>--- a/makedumpfile.h
>+++ b/makedumpfile.h
>@@ -44,6 +44,7 @@
> #include "print_info.h"
> #include "sadump_mod.h"
> #include <pthread.h>
>+#include <semaphore.h>
>
> /*
>  * Result of command
>@@ -974,10 +975,11 @@ typedef unsigned long long int ulonglong;
>  * for parallel process
>  */
>
>-#define PAGE_DATA_NUM	(50)
>+#define PAGE_FLAG_NUM	(20)
>+#define PAGE_DATA_NUM	(5)
> #define WAIT_TIME	(60 * 10)
> #define PTHREAD_FAIL	((void *)-2)
>-#define NUM_BUFFERS	(50)
>+#define THREAD_REGION	(200 * 1024)
>
> struct mmap_cache {
> 	char	*mmap_buf;
>@@ -985,28 +987,33 @@ struct mmap_cache {
> 	off_t   mmap_end_offset;
> };
>
>+enum {
>+	FLAG_UNUSED,
>+	FLAG_READY,
>+	FLAG_FILLING
>+};
>+struct page_flag {
>+	mdf_pfn_t pfn;
>+	char zero;
>+	char ready;
>+	short index;
>+	struct page_flag *next;
>+};
>+
> struct page_data
> {
>-	mdf_pfn_t pfn;
>-	int dumpable;
>-	int zero;
>-	unsigned int flags;
> 	long size;
> 	unsigned char *buf;
>-	pthread_mutex_t mutex;
>-	/*
>-	 * whether the page_data is ready to be consumed
>-	 */
>-	int ready;
>+	int flags;
>+	int used;
> };
>
> struct thread_args {
> 	int thread_num;
> 	unsigned long len_buf_out;
>-	mdf_pfn_t start_pfn, end_pfn;
>-	int page_data_num;
> 	struct cycle *cycle;
> 	struct page_data *page_data_buf;
>+	struct page_flag *page_flag_buf;
> };
>
> /*
>@@ -1295,11 +1302,12 @@ struct DumpInfo {
> 	pthread_t **threads;
> 	struct thread_args *kdump_thread_args;
> 	struct page_data *page_data_buf;
>+	struct page_flag **page_flag_buf;
>+	sem_t page_flag_buf_sem;
> 	pthread_rwlock_t usemmap_rwlock;
> 	mdf_pfn_t current_pfn;
> 	pthread_mutex_t current_pfn_mutex;
>-	mdf_pfn_t consumed_pfn;
>-	pthread_mutex_t consumed_pfn_mutex;
>+	pthread_mutex_t page_data_mutex;
> 	pthread_mutex_t filter_mutex;
> };
> extern struct DumpInfo		*info;
>--
>1.8.3.1
>
>
>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
