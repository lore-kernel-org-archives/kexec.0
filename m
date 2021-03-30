Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2130.oracle.com ([141.146.126.79])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLsq-004vUP-0y
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:26:48 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 01/43] mm: add PKRAM API stubs and Kconfig
Date: Tue, 30 Mar 2021 14:35:36 -0700
Message-Id: <1617140178-8773-2-git-send-email-anthony.yznaga@oracle.com>
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

Preserved-across-kexec memory or PKRAM is a method for saving memory
pages of the currently executing kernel and restoring them after kexec
boot into a new one. This can be utilized for preserving guest VM state,
large in-memory databases, process memory, etc. across reboot. While
DRAM-as-PMEM or actual persistent memory could be used to accomplish
these things, PKRAM provides the latency of DRAM with the flexibility
of dynamically determining the amount of memory to preserve.

The proposed API:

 * Preserved memory is divided into nodes which can be saved or loaded
   independently of each other. The nodes are identified by unique name
   strings. A PKRAM node is created when save is initiated by calling
   pkram_prepare_save(). A PKRAM node is removed when load is initiated by
   calling pkram_prepare_load(). See below

 * A node is further divided into objects. An object represents closely
   coupled data in the form of a grouping of pages and/or a stream of
   byte data.  For example, the pages and attributes of a file.
   After initiating an operation on a PKRAM node, PKRAM objects are
   initialized for saving or loading by calling pkram_prepare_save_obj()
   or pkram_prepare_load_obj().

 * For saving/loading data from a PKRAM node/object instances of the
   pkram_stream and pkram_access structs are used.  pkram_stream tracks
   the node and object being operated on while pkram_access tracks the
   data type and position within an object.

   The pkram_stream struct is initialized by calling pkram_prepare_save()
   or pkram_prepare_load() and then pkram_prepare_save_obj() or
   pkram_prepare_load_obj().

   Once a pkram_stream is fully initialized, a pkram_access struct
   is initialized for each data type associated with the object.
   After save or load of a data type for the object is complete,
   pkram_finish_access() is called.

   After save or load is complete for the object, pkram_finish_save_obj()
   or pkram_finish_load_obj() must be called followed by pkram_finish_save()
   or pkram_finish_load() when save or load is completed for the node.
   If an error occurred during save, the saved data and the PKRAM node
   may be freed by calling pkram_discard_save() instead of
   pkram_finish_save().

 * Both page data and byte data can separately be streamed to a PKRAM
   object.  pkram_save_file_page() and pkram_load_file_page() are used
   to stream page data while pkram_write() and pkram_read() are used to
   stream byte data.

A sequence of operations for saving/loading data from PKRAM would
look like:

  * For saving data to PKRAM:

    /* create a PKRAM node and do initial stream setup */
    pkram_prepare_save()

    /* create a PKRAM object associated with the PKRAM node and complete stream initialization */
    pkram_prepare_save_obj()

    /* save data to the node/object */
    PKRAM_ACCESS(pa_pages,...)
    PKRAM_ACCESS(pa_bytes,...)
    pkram_save_file_page(pa_pages,...)[,...]  /* for file pages */
    pkram_write(pa_bytes,...)[,...]           /* for a byte stream */
    pkram_finish_access(pa_pages)
    pkram_finish_access(pa_bytes)

    pkram_finish_save_obj()

    /* commit the save or discard and delete the node */
    pkram_finish_save()          /* on success, or
    pkram_discard_save()          * ... in case of error */

  * For loading data from PKRAM:

    /* remove a PKRAM node from the list and do initial stream setup */
    pkram_prepare_load()

    /* Remove a PKRAM object from the node and complete stream initializtion for loading data from it. */
    pkram_prepare_load_obj()

    /* load data from the node/object */
    PKRAM_ACCESS(pa_pages,...)
    PKRAM_ACCESS(pa_bytes,...)
    pkram_load_file_page(pa_pages,...)[,...] /* for file pages */
    pkram_read(pa_bytes,...)[,...]           /* for a byte stream */
*/
    pkram_finish_access(pa_pages)
    pkram_finish_access(pa_bytes)

    /* free the object */
    pkram_finish_load_obj()

    /* free the node */
    pkram_finish_load()

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  47 +++++++++++++
 mm/Kconfig            |   9 +++
 mm/Makefile           |   1 +
 mm/pkram.c            | 179 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 236 insertions(+)
 create mode 100644 include/linux/pkram.h
 create mode 100644 mm/pkram.c

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
new file mode 100644
index 000000000000..a575da2d6c79
--- /dev/null
+++ b/include/linux/pkram.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PKRAM_H
+#define _LINUX_PKRAM_H
+
+#include <linux/gfp.h>
+#include <linux/types.h>
+#include <linux/mm_types.h>
+
+/**
+ * enum pkram_data_flags - definition of data types contained in a pkram obj
+ * @PKRAM_DATA_none: No data types configured
+ */
+enum pkram_data_flags {
+	PKRAM_DATA_none		= 0x0,  /* No data types configured */
+};
+
+struct pkram_stream;
+struct pkram_access;
+
+#define PKRAM_NAME_MAX		256	/* including nul */
+
+int pkram_prepare_save(struct pkram_stream *ps, const char *name,
+		       gfp_t gfp_mask);
+int pkram_prepare_save_obj(struct pkram_stream *ps, enum pkram_data_flags flags);
+
+void pkram_finish_save(struct pkram_stream *ps);
+void pkram_finish_save_obj(struct pkram_stream *ps);
+void pkram_discard_save(struct pkram_stream *ps);
+
+int pkram_prepare_load(struct pkram_stream *ps, const char *name);
+int pkram_prepare_load_obj(struct pkram_stream *ps);
+
+void pkram_finish_load(struct pkram_stream *ps);
+void pkram_finish_load_obj(struct pkram_stream *ps);
+
+#define PKRAM_ACCESS(name, stream, type)			\
+	struct pkram_access name
+
+void pkram_finish_access(struct pkram_access *pa, bool status_ok);
+
+int pkram_save_file_page(struct pkram_access *pa, struct page *page);
+struct page *pkram_load_file_page(struct pkram_access *pa, unsigned long *index);
+
+ssize_t pkram_write(struct pkram_access *pa, const void *buf, size_t count);
+size_t pkram_read(struct pkram_access *pa, void *buf, size_t count);
+
+#endif /* _LINUX_PKRAM_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 24c045b24b95..ea8242c91728 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -872,4 +872,13 @@ config MAPPING_DIRTY_HELPERS
 config KMAP_LOCAL
 	bool
 
+config PKRAM
+	bool "Preserved-over-kexec memory storage"
+	default n
+	help
+	  This option adds the kernel API that enables saving memory pages of
+	  the currently executing kernel and restoring them after a kexec in
+	  the newly booted one. This can be utilized for speeding up reboot by
+	  leaving process memory and/or FS caches in-place.
+
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 72227b24a616..ab3a724769b5 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -120,3 +120,4 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
+obj-$(CONFIG_PKRAM) += pkram.o
diff --git a/mm/pkram.c b/mm/pkram.c
new file mode 100644
index 000000000000..59e4661b2fb7
--- /dev/null
+++ b/mm/pkram.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/err.h>
+#include <linux/gfp.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/pkram.h>
+#include <linux/types.h>
+
+/**
+ * Create a preserved memory node with name @name and initialize stream @ps
+ * for saving data to it.
+ *
+ * @gfp_mask specifies the memory allocation mask to be used when saving data.
+ *
+ * Returns 0 on success, -errno on failure.
+ *
+ * After the save has finished, pkram_finish_save() (or pkram_discard_save() in
+ * case of failure) is to be called.
+ */
+int pkram_prepare_save(struct pkram_stream *ps, const char *name, gfp_t gfp_mask)
+{
+	return -ENOSYS;
+}
+
+/**
+ * Create a preserved memory object and initialize stream @ps for saving data
+ * to it.
+ *
+ * Returns 0 on success, -errno on failure.
+ *
+ * After the save has finished, pkram_finish_save_obj() (or pkram_discard_save()
+ * in case of failure) is to be called.
+ */
+int pkram_prepare_save_obj(struct pkram_stream *ps, enum pkram_data_flags flags)
+{
+	return -ENOSYS;
+}
+
+/**
+ * Commit the object started with pkram_prepare_save_obj() to preserved memory.
+ */
+void pkram_finish_save_obj(struct pkram_stream *ps)
+{
+	BUG();
+}
+
+/**
+ * Commit the save to preserved memory started with pkram_prepare_save().
+ * After the call, the stream may not be used any more.
+ */
+void pkram_finish_save(struct pkram_stream *ps)
+{
+	BUG();
+}
+
+/**
+ * Cancel the save to preserved memory started with pkram_prepare_save() and
+ * destroy the corresponding preserved memory node freeing any data already
+ * saved to it.
+ */
+void pkram_discard_save(struct pkram_stream *ps)
+{
+	BUG();
+}
+
+/**
+ * Remove the preserved memory node with name @name and initialize stream @ps
+ * for loading data from it.
+ *
+ * Returns 0 on success, -errno on failure.
+ *
+ * After the load has finished, pkram_finish_load() is to be called.
+ */
+int pkram_prepare_load(struct pkram_stream *ps, const char *name)
+{
+	return -ENOSYS;
+}
+
+/**
+ * Remove the next preserved memory object from the stream @ps and
+ * initialize stream @ps for loading data from it.
+ *
+ * Returns 0 on success, -errno on failure.
+ *
+ * After the load has finished, pkram_finish_load_obj() is to be called.
+ */
+int pkram_prepare_load_obj(struct pkram_stream *ps)
+{
+	return -ENOSYS;
+}
+
+/**
+ * Finish the load of a preserved memory object started with
+ * pkram_prepare_load_obj() freeing the object and any data that has not
+ * been loaded from it.
+ */
+void pkram_finish_load_obj(struct pkram_stream *ps)
+{
+	BUG();
+}
+
+/**
+ * Finish the load from preserved memory started with pkram_prepare_load()
+ * freeing the corresponding preserved memory node and any data that has
+ * not been loaded from it.
+ */
+void pkram_finish_load(struct pkram_stream *ps)
+{
+	BUG();
+}
+
+/**
+ * Finish the data access to or from the preserved memory node and object
+ * associated with pkram stream access @pa.  The access must have been
+ * initialized with PKRAM_ACCESS(). 
+ */
+void pkram_finish_access(struct pkram_access *pa, bool status_ok)
+{
+	BUG();
+}
+
+/**
+ * Save file page @page to the preserved memory node and object associated
+ * with pkram stream access @pa. The stream must have been initialized with
+ * pkram_prepare_save() and pkram_prepare_save_obj() and access initialized
+ * with PKRAM_ACCESS().
+ *
+ * Returns 0 on success, -errno on failure.
+ */
+int pkram_save_file_page(struct pkram_access *pa, struct page *page)
+{
+	return -ENOSYS;
+}
+
+/**
+ * Load the next page from the preserved memory node and object associated
+ * with pkram stream access @pa. The stream must have been initialized with
+ * pkram_prepare_load() and pkram_prepare_load_obj() and access initialized
+ * with PKRAM_ACCESS().
+ *
+ * If not NULL, @index is initialized with the preserved mapping offset of the
+ * page loaded.
+ *
+ * Returns the page loaded or NULL if the node is empty.
+ *
+ * The page loaded has its refcount incremented.
+ */
+struct page *pkram_load_file_page(struct pkram_access *pa, unsigned long *index)
+{
+	return NULL;
+}
+
+/**
+ * Copy @count bytes from @buf to the preserved memory node and object
+ * associated with pkram stream access @pa. The stream must have been
+ * initialized with pkram_prepare_save() and pkram_prepare_save_obj()
+ * and access initialized with PKRAM_ACCESS();
+ *
+ * On success, returns the number of bytes written, which is always equal to
+ * @count. On failure, -errno is returned.
+ */
+ssize_t pkram_write(struct pkram_access *pa, const void *buf, size_t count)
+{
+	return -ENOSYS;
+}
+
+/**
+ * Copy up to @count bytes from the preserved memory node and object
+ * associated with pkram stream access @pa to @buf. The stream must have been
+ * initialized with pkram_prepare_load() and pkram_prepare_load_obj() and
+ * access initialized PKRAM_ACCESS().
+ *
+ * Returns the number of bytes read, which may be less than @count if the node
+ * has fewer bytes available.
+ */
+size_t pkram_read(struct pkram_access *pa, void *buf, size_t count)
+{
+	return 0;
+}
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
