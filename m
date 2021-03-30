Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2130.oracle.com ([141.146.126.79])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLu1-004vuu-BM
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:27:59 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 32/43] shmem: preserve shmem files a chunk at a time
Date: Tue, 30 Mar 2021 14:36:07 -0700
Message-Id: <1617140178-8773-33-git-send-email-anthony.yznaga@oracle.com>
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

To prepare for multithreading the work to preserve a shmem file,
divide the work into subranges of the total index range of the file.
The chunk size is a rather arbitrary 256k indices.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/shmem_pkram.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 7 deletions(-)

diff --git a/mm/shmem_pkram.c b/mm/shmem_pkram.c
index 8682b0c002c0..e52722b3a709 100644
--- a/mm/shmem_pkram.c
+++ b/mm/shmem_pkram.c
@@ -74,16 +74,14 @@ static int save_page(struct page *page, struct pkram_access *pa)
 	return err;
 }
 
-static int save_file_content(struct pkram_stream *ps, struct address_space *mapping)
+static int save_file_content_range(struct pkram_access *pa,
+				   struct address_space *mapping,
+				   unsigned long start, unsigned long end)
 {
-	PKRAM_ACCESS(pa, ps, pages);
 	struct pagevec pvec;
-	unsigned long start, end;
 	int err = 0;
 	int i;
 
-	start = 0;
-	end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
 	pagevec_init(&pvec);
 	for ( ; ; ) {
 		pvec.nr = find_get_pages_range(mapping, &start, end,
@@ -95,7 +93,7 @@ static int save_file_content(struct pkram_stream *ps, struct address_space *mapp
 
 			lock_page(page);
 			BUG_ON(page->mapping != mapping);
-			err = save_page(page, &pa);
+			err = save_page(page, pa);
 			if (PageCompound(page)) {
 				start = page->index + compound_nr(page);
 				i += compound_nr(page);
@@ -113,10 +111,62 @@ static int save_file_content(struct pkram_stream *ps, struct address_space *mapp
 		cond_resched();
 	}
 
-	pkram_finish_access(&pa, err == 0);
 	return err;
 }
 
+struct shmem_pkram_arg {
+	struct pkram_stream *ps;
+	struct address_space *mapping;
+	struct mm_struct *mm;
+	atomic64_t next;
+};
+
+unsigned long shmem_pkram_max_index_range = 512 * 512;
+
+static int get_save_range(unsigned long max, atomic64_t *next, unsigned long *start, unsigned long *end)
+{
+	unsigned long index;
+ 
+	index = atomic64_fetch_add(shmem_pkram_max_index_range, next);
+	if (index >= max)
+		return -ENODATA;
+ 
+	*start = index;
+	*end = index + shmem_pkram_max_index_range - 1;
+ 
+	return 0;
+}
+
+static int do_save_file_content(struct pkram_stream *ps,
+				struct address_space *mapping,
+				atomic64_t *next)
+{
+	PKRAM_ACCESS(pa, ps, pages);
+	unsigned long start, end, max;
+	int ret;
+ 
+	max = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
+ 
+	do {
+		ret = get_save_range(max, next, &start, &end);
+		if (!ret)
+			ret = save_file_content_range(&pa, mapping, start, end);
+	} while (!ret);
+ 
+	if (ret == -ENODATA)
+		ret = 0;
+ 
+	pkram_finish_access(&pa, ret == 0);
+	return ret;
+}
+
+static int save_file_content(struct pkram_stream *ps, struct address_space *mapping)
+{
+	struct shmem_pkram_arg arg = { ps, mapping, NULL, ATOMIC64_INIT(0) };
+ 
+	return do_save_file_content(arg.ps, arg.mapping, &arg.next);
+}
+
 static int save_file(struct dentry *dentry, struct pkram_stream *ps)
 {
 	PKRAM_ACCESS(pa_bytes, ps, bytes);
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
