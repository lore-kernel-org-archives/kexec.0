Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUgJ-0004Qk-FZ
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:46:47 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 34/43] shmem: PKRAM: multithread preserving and restoring shmem
 pages
Date: Wed,  6 May 2020 17:42:00 -0700
Message-Id: <1588812129-8596-35-git-send-email-anthony.yznaga@oracle.com>
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
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
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, linux-doc@vger.kernel.org, gustavo@embeddedor.com, peterz@infradead.org, kexec@lists.infradead.org, paul.c.lai@intel.com, dave.hansen@linux.intel.com, mhocko@kernel.org, lei.l.li@intel.com, nivedita@alum.mit.edu, ziqian.lzq@antfin.com, hpa@zytor.com, ardb@kernel.org, ashok.raj@intel.com, bhe@redhat.com, corbet@lwn.net, masahiroy@kernel.org, rafael.j.wysocki@intel.com, hughd@google.com, willy@infradead.org, rppt@linux.ibm.com, mingo@redhat.com, vdavydov.dev@gmail.com, ying.huang@intel.com, Thomas.Lendacky@amd.com, kevin.tian@intel.com, jroedel@suse.de, keescook@chromium.org, dan.j.williams@intel.com, bp@alien8.de, zhiyuan.lv@intel.com, luto@kernel.org, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, dima@golovin.in, yang.shi@linux.alibaba.com, ndesaulniers@google.com, zhenzhong.duan@oracle.com, guro@fb.com, minchan@kernel.org, ebiederm@xmission.com, jason.zeng@intel.com, hannes@cmpxchg.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, daniel.kiper@oracle.com

Improve performance by multithreading the work to preserve and restore
shmem pages.

Add 'pkram_max_threads=' kernel option to specify the maximum number
of threads to use to preserve or restore the pages of a shmem file.
The default is 16.

When preserving pages each thread saves chunks of a file to a pkram_obj
until no more no more chunks are available.

When restoring pages each thread loads pages using a copy of a
pkram_stream initialized by pkram_prepare_load_obj(). Under the hood
each thread ends up fetching and operating on pkram_link pages.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |   2 +
 mm/shmem_pkram.c      | 101 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index e71ccb91d6a6..bf2e138b044e 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -13,6 +13,8 @@ struct pkram_stream {
 	struct pkram_node *node;
 	struct pkram_obj *obj;
 
+	int error;
+
 	struct pkram_link *link;		/* current link */
 	unsigned int entry_idx;		/* next entry in link */
 
diff --git a/mm/shmem_pkram.c b/mm/shmem_pkram.c
index 2f4d0bdf3e05..4992b6c3e54e 100644
--- a/mm/shmem_pkram.c
+++ b/mm/shmem_pkram.c
@@ -126,6 +126,16 @@ static int save_file_content_range(struct address_space *mapping,
 	return err;
 }
 
+/* Completion tracking for do_save_file_content_thr() threads */
+static atomic_t pkram_save_n_undone;
+static DECLARE_COMPLETION(pkram_save_all_done_comp);
+
+static inline void pkram_save_report_one_done(void)
+{
+	if (atomic_dec_and_test(&pkram_save_n_undone))
+		complete(&pkram_save_all_done_comp);
+}
+
 static int do_save_file_content(struct pkram_stream *ps)
 {
 	int ret;
@@ -142,11 +152,55 @@ static int do_save_file_content(struct pkram_stream *ps)
 	return ret;
 }
 
+static int do_save_file_content_thr(void *data)
+{
+	struct pkram_stream *ps = data;
+	struct pkram_stream pslocal = *ps;
+	int ret;
+
+	ret = do_save_file_content(&pslocal);
+	if (ret && !ps->error)
+		ps->error = ret;
+
+	pkram_save_report_one_done();
+	return 0;
+}
+#define PKRAM_DEFAULT_MAX_THREADS	16
+
+static int pkram_max_threads = PKRAM_DEFAULT_MAX_THREADS;
+
+static int __init set_pkram_max_threads(char *str)
+{
+	unsigned int val;
+
+	if (kstrtouint(str, 0, &val))
+		return 1;
+
+	pkram_max_threads = val;
+
+	return 1;
+}
+__setup("pkram_max_threads=", set_pkram_max_threads);
+
 static int save_file_content(struct pkram_stream *ps)
 {
+	unsigned int thr, nr_threads;
+
+	nr_threads = num_online_cpus() - 1;
+	nr_threads = clamp_val(pkram_max_threads, 1, nr_threads);
+
 	ps->max_idx = DIV_ROUND_UP(i_size_read(ps->mapping->host), PAGE_SIZE);
 
-	return do_save_file_content(ps);
+	if (nr_threads == 1)
+		return do_save_file_content(ps);
+
+	atomic_set(&pkram_save_n_undone, nr_threads);
+	for (thr = 0; thr < nr_threads; thr++)
+		kthread_run(do_save_file_content_thr, ps, "pkram_save%d", thr);
+
+	wait_for_completion(&pkram_save_all_done_comp);
+
+	return ps->error;
 }
 
 static int save_file(struct dentry *dentry, struct pkram_stream *ps)
@@ -248,7 +302,17 @@ int shmem_save_pkram(struct super_block *sb)
 	return err;
 }
 
-static int load_file_content(struct pkram_stream *ps)
+/* Completion tracking for do_load_file_content_thr() threads */
+static atomic_t pkram_load_n_undone;
+static DECLARE_COMPLETION(pkram_load_all_done_comp);
+
+static inline void pkram_load_report_one_done(void)
+{
+	if (atomic_dec_and_test(&pkram_load_n_undone))
+		complete(&pkram_load_all_done_comp);
+}
+
+static int do_load_file_content(struct pkram_stream *ps)
 {
 	unsigned long index;
 	struct page *page;
@@ -266,6 +330,39 @@ static int load_file_content(struct pkram_stream *ps)
 	return err;
 }
 
+static int do_load_file_content_thr(void *data)
+{
+	struct pkram_stream *ps = data;
+	struct pkram_stream pslocal = *ps;
+	int ret;
+
+	ret = do_load_file_content(&pslocal);
+	if (ret && !ps->error)
+		ps->error = ret;
+
+	pkram_load_report_one_done();
+	return 0;
+}
+
+static int load_file_content(struct pkram_stream *ps)
+{
+	unsigned int thr, nr_threads;
+
+	nr_threads = num_online_cpus() - 1;
+	nr_threads = clamp_val(pkram_max_threads, 1, nr_threads);
+
+	if (nr_threads == 1)
+		return do_load_file_content(ps);
+
+	atomic_set(&pkram_load_n_undone, nr_threads);
+	for (thr = 0; thr < nr_threads; thr++)
+		kthread_run(do_load_file_content_thr, ps, "pkram_load%d", thr);
+
+	wait_for_completion(&pkram_load_all_done_comp);
+
+	return ps->error;
+}
+
 static int load_file(struct dentry *parent, struct pkram_stream *ps,
 		     char *buf, size_t bufsize)
 {
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
