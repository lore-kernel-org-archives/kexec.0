Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2130.oracle.com ([141.146.126.79])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLuE-004vxx-Nz
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:28:17 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 34/43] shmem: PKRAM: multithread preserving and restoring
 shmem pages
Date: Tue, 30 Mar 2021 14:36:09 -0700
Message-Id: <1617140178-8773-35-git-send-email-anthony.yznaga@oracle.com>
In-Reply-To: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
References: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
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
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: willy@infradead.org, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org, hughd@google.com, ebiederm@xmission.com, keescook@chromium.org, ardb@kernel.org, nivedita@alum.mit.edu, jroedel@suse.de, masahiroy@kernel.org, nathan@kernel.org, terrelln@fb.com, vincenzo.frascino@arm.com, martin.b.radev@gmail.com, andreyknvl@google.com, daniel.kiper@oracle.com, rafael.j.wysocki@intel.com, dan.j.williams@intel.com, Jonathan.Cameron@huawei.com, bhe@redhat.com, rminnich@gmail.com, ashish.kalra@amd.com, guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz, alex.shi@linux.alibaba.com, david@redhat.com, richard.weiyang@gmail.com, vdavydov.dev@gmail.com, graf@amazon.com, jason.zeng@intel.com, lei.l.li@intel.com, daniel.m.jordan@oracle.com, steven.sistare@oracle.com, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, kexec@lists.infradead.org

Improve performance by multithreading the work to preserve and restore
shmem pages.

When preserving pages each thread saves non-overlapping ranges of a file
to a pkram_obj until all pages are preserved.

When restoring pages each thread loads pages using a local pkram_access.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/shmem_pkram.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 89 insertions(+), 5 deletions(-)

diff --git a/mm/shmem_pkram.c b/mm/shmem_pkram.c
index e52722b3a709..354c2b58962c 100644
--- a/mm/shmem_pkram.c
+++ b/mm/shmem_pkram.c
@@ -115,6 +115,7 @@ static int save_file_content_range(struct pkram_access *pa,
 }
 
 struct shmem_pkram_arg {
+	int *error;
 	struct pkram_stream *ps;
 	struct address_space *mapping;
 	struct mm_struct *mm;
@@ -137,6 +138,16 @@ static int get_save_range(unsigned long max, atomic64_t *next, unsigned long *st
 	return 0;
 }
 
+/* Completion tracking for save_file_content_thr() threads */
+static atomic_t pkram_save_n_undone;
+static DECLARE_COMPLETION(pkram_save_all_done_comp);
+
+static inline void pkram_save_report_one_done(void)
+{
+	if (atomic_dec_and_test(&pkram_save_n_undone))
+		complete(&pkram_save_all_done_comp);
+}
+
 static int do_save_file_content(struct pkram_stream *ps,
 				struct address_space *mapping,
 				atomic64_t *next)
@@ -160,11 +171,40 @@ static int do_save_file_content(struct pkram_stream *ps,
 	return ret;
 }
 
-static int save_file_content(struct pkram_stream *ps, struct address_space *mapping)
+static int save_file_content_thr(void *data)
 {
-	struct shmem_pkram_arg arg = { ps, mapping, NULL, ATOMIC64_INIT(0) };
- 
-	return do_save_file_content(arg.ps, arg.mapping, &arg.next);
+	struct shmem_pkram_arg *arg = data;
+	int ret;
+
+	ret = do_save_file_content(arg->ps, arg->mapping, &arg->next);
+	if (ret && !*arg->error)
+		*arg->error = ret;
+
+	pkram_save_report_one_done();
+	return 0;
+}
+
+static int shmem_pkram_max_threads = 16;
+
+static int save_file_content(struct pkram_stream *ps, struct address_space *mapping)
+ {
+	int err = 0;
+	struct shmem_pkram_arg arg = { &err, ps, mapping, NULL, ATOMIC64_INIT(0) };
+	unsigned int thr, nr_threads;
+
+	nr_threads = num_online_cpus() - 1;
+	nr_threads = clamp_val(shmem_pkram_max_threads, 1, nr_threads);
+
+	if (nr_threads == 1)
+		return do_save_file_content(arg.ps, arg.mapping, &arg.next);
+
+	atomic_set(&pkram_save_n_undone, nr_threads);
+	for (thr = 0; thr < nr_threads; thr++)
+		kthread_run(save_file_content_thr, &arg, "pkram_save%d", thr);
+
+	wait_for_completion(&pkram_save_all_done_comp);
+
+	return err;
 }
 
 static int save_file(struct dentry *dentry, struct pkram_stream *ps)
@@ -275,7 +315,17 @@ int shmem_save_pkram(struct super_block *sb)
 	return err;
 }
 
-static int load_file_content(struct pkram_stream *ps, struct address_space *mapping, struct mm_struct *mm)
+/* Completion tracking for load_file_content_thr() threads */
+static atomic_t pkram_load_n_undone;
+static DECLARE_COMPLETION(pkram_load_all_done_comp);
+
+static inline void pkram_load_report_one_done(void)
+{
+	if (atomic_dec_and_test(&pkram_load_n_undone))
+		complete(&pkram_load_all_done_comp);
+}
+
+static int do_load_file_content(struct pkram_stream *ps, struct address_space *mapping, struct mm_struct *mm)
 {
 	PKRAM_ACCESS(pa, ps, pages);
 	unsigned long index;
@@ -296,6 +346,40 @@ static int load_file_content(struct pkram_stream *ps, struct address_space *mapp
 	return err;
 }
 
+static int load_file_content_thr(void *data)
+{
+	struct shmem_pkram_arg *arg = data;
+	int ret;
+
+	ret = do_load_file_content(arg->ps, arg->mapping, arg->mm);
+	if (ret && !*arg->error)
+		*arg->error = ret;
+
+	pkram_load_report_one_done();
+	return 0;
+}
+
+static int load_file_content(struct pkram_stream *ps, struct address_space *mapping, struct mm_struct *mm)
+{
+	int err = 0;
+	struct shmem_pkram_arg arg = { &err, ps, mapping, mm };
+	unsigned int thr, nr_threads;
+
+	nr_threads = num_online_cpus() - 1;
+	nr_threads = clamp_val(shmem_pkram_max_threads, 1, nr_threads);
+
+	if (nr_threads == 1)
+		return do_load_file_content(ps, mapping, mm);
+
+	atomic_set(&pkram_load_n_undone, nr_threads);
+	for (thr = 0; thr < nr_threads; thr++)
+		kthread_run(load_file_content_thr, &arg, "pkram_load%d", thr);
+
+	wait_for_completion(&pkram_load_all_done_comp);
+
+	return err;
+}
+
 static int load_file(struct dentry *parent, struct pkram_stream *ps,
 		     char *buf, size_t bufsize)
 {
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
