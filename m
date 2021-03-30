Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLuZ-004w1P-63
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:28:34 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 36/43] PKRAM: add support for loading pages in bulk
Date: Tue, 30 Mar 2021 14:36:11 -0700
Message-Id: <1617140178-8773-37-git-send-email-anthony.yznaga@oracle.com>
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

Implement a new API function, pkram_load_file_pages(), to support
loading pages in bulk.  A caller provided buffer not smaller than
PKRAM_PAGES_BUFSIZE is populated with pages pointers that are contiguous
by their original mapping index values.  The number of pages in the buffer
and the mapping index of the first page are provided to the caller.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  4 ++++
 mm/pkram.c            | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 977cf45a1bcf..ca46e5eafe71 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -96,6 +96,10 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name,
 int pkram_save_file_page(struct pkram_access *pa, struct page *page);
 struct page *pkram_load_file_page(struct pkram_access *pa, unsigned long *index);
 
+#define PKRAM_PAGES_BUFSIZE	PAGE_SIZE
+
+int pkram_load_file_pages(struct pkram_access *pa, struct page *pages[], unsigned int *nr_pages, unsigned long *index);
+
 ssize_t pkram_write(struct pkram_access *pa, const void *buf, size_t count);
 size_t pkram_read(struct pkram_access *pa, void *buf, size_t count);
 
diff --git a/mm/pkram.c b/mm/pkram.c
index 382ccf6f789f..b63b2a3958e7 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1099,6 +1099,52 @@ struct page *pkram_load_file_page(struct pkram_access *pa, unsigned long *index)
 }
 
 /**
+ * Load pages from the preserved memory node and object associated with
+ * pkram stream access @pa. The stream must have been initialized with
+ * pkram_prepare_load() and pkram_prepare_load_obj() and access initialized
+ * with PKRAM_ACCESS().
+ * The page entries of a single pkram_link are processed, and @pages is
+ * populated with the page pointers.  @nr_pages is set to the number of
+ * pages, and @index is set to the mapping index of the first page.
+ *
+ * Returns 0 if one or more pages are loaded or -ENODATA if there are no
+ * pages to load.
+ *
+ * The pages loaded have an incremented refcount either because the page
+ * was initialized with a refcount of 1 at boot or because the page was
+ * subsequently preserved which increased the refcount.
+ */
+int pkram_load_file_pages(struct pkram_access *pa, struct page *pages[], unsigned int *nr_pages, unsigned long *index)
+{
+	struct pkram_data_stream *pds = &pa->pds;
+	struct pkram_link *link;
+	int nr_entries = 0;
+	int i, ret;
+
+	ret = pkram_next_link(pds, &link);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < PKRAM_LINK_ENTRIES_MAX; i++) {
+		unsigned long p = link->entry[i];
+
+		if (!p)
+			break;
+
+		pages[i] = __pkram_prep_load_page(p);
+		nr_entries++;
+	}
+
+	*nr_pages = nr_entries;
+	*index = link->index;
+
+	pkram_free_page(link);
+	pds->link = NULL;
+
+	return 0;
+}
+
+/**
  * Copy @count bytes from @buf to the preserved memory node and object
  * associated with pkram stream access @pa. The stream must have been
  * initialized with pkram_prepare_save() and pkram_prepare_save_obj()
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
