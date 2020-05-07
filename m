Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUf6-0002nx-BY
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:45:27 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 03/43] mm: PKRAM: implement object load and save functions
Date: Wed,  6 May 2020 17:41:29 -0700
Message-Id: <1588812129-8596-4-git-send-email-anthony.yznaga@oracle.com>
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

PKRAM nodes are further divided into a list of objects. After a save
operation has been initiated for a node, a save operation for an object
associated with the node is initiated by calling pkram_prepare_save_obj().
A new object is created and linked to the node.  The save operation for
the object is committed by calling pkram_finish_save_obj().  After a load
operation has been initiated, pkram_prepare_load_obj() is called to
delete the next object from the node and prepare the corresponding
stream for loading data from it.  After the load of object has been
finished, pkram_finish_load_obj() is called to free the object.  Objects
are also deleted when a save operation is discarded.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  1 +
 mm/pkram.c            | 77 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 83a0579e4c1c..fabde2cd8203 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -11,6 +11,7 @@ struct pkram_node;
 struct pkram_stream {
 	gfp_t gfp_mask;
 	struct pkram_node *node;
+	struct pkram_obj *obj;
 };
 
 #define PKRAM_NAME_MAX		256	/* including nul */
diff --git a/mm/pkram.c b/mm/pkram.c
index 5c57126353ff..4934ffd8b019 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -6,9 +6,14 @@
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/pkram.h>
+#include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/types.h>
 
+struct pkram_obj {
+	__u64   obj_pfn;	/* points to the next object in the list */
+};
+
 /*
  * Preserved memory is divided into nodes that can be saved or loaded
  * independently of each other. The nodes are identified by unique name
@@ -18,6 +23,7 @@
  */
 struct pkram_node {
 	__u32	flags;
+	__u64	obj_pfn;	/* points to the first obj of the node */
 
 	__u8	name[PKRAM_NAME_MAX];
 };
@@ -62,6 +68,21 @@ static struct pkram_node *pkram_find_node(const char *name)
 	return NULL;
 }
 
+static void pkram_truncate_node(struct pkram_node *node)
+{
+	unsigned long obj_pfn;
+	struct pkram_obj *obj;
+
+	obj_pfn = node->obj_pfn;
+	while (obj_pfn) {
+		obj = pfn_to_kaddr(obj_pfn);
+		obj_pfn = obj->obj_pfn;
+		pkram_free_page(obj);
+		cond_resched();
+	}
+	node->obj_pfn = 0;
+}
+
 static void pkram_stream_init(struct pkram_stream *ps,
 			     struct pkram_node *node, gfp_t gfp_mask)
 {
@@ -70,6 +91,11 @@ static void pkram_stream_init(struct pkram_stream *ps,
 	ps->node = node;
 }
 
+static void pkram_stream_init_obj(struct pkram_stream *ps, struct pkram_obj *obj)
+{
+	ps->obj = obj;
+}
+
 /**
  * Create a preserved memory node with name @name and initialize stream @ps
  * for saving data to it.
@@ -124,12 +150,31 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name, gfp_t gfp_mask
  *
  * Returns 0 on success, -errno on failure.
  *
+ * Error values:
+ *	%ENOMEM: insufficient memory available
+ *
  * After the save has finished, pkram_finish_save_obj() (or pkram_discard_save()
  * in case of failure) is to be called.
  */
 int pkram_prepare_save_obj(struct pkram_stream *ps)
 {
-	return -ENOSYS;
+	struct pkram_node *node = ps->node;
+	struct pkram_obj *obj;
+	struct page *page;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
+
+	page = pkram_alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!page)
+		return -ENOMEM;
+	obj = page_address(page);
+
+	if (node->obj_pfn)
+		obj->obj_pfn = node->obj_pfn;
+	node->obj_pfn = page_to_pfn(page);
+
+	pkram_stream_init_obj(ps, obj);
+	return 0;
 }
 
 /**
@@ -137,7 +182,9 @@ int pkram_prepare_save_obj(struct pkram_stream *ps)
  */
 void pkram_finish_save_obj(struct pkram_stream *ps)
 {
-	BUG();
+	struct pkram_node *node = ps->node;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
 }
 
 /**
@@ -169,6 +216,7 @@ void pkram_discard_save(struct pkram_stream *ps)
 	pkram_delete_node(node);
 	mutex_unlock(&pkram_mutex);
 
+	pkram_truncate_node(node);
 	pkram_free_page(node);
 }
 
@@ -216,11 +264,26 @@ int pkram_prepare_load(struct pkram_stream *ps, const char *name)
  *
  * Returns 0 on success, -errno on failure.
  *
+ * Error values:
+ *	%ENODATA: Stream @ps has no preserved memory objects
+ *
  * After the load has finished, pkram_finish_load_obj() is to be called.
  */
 int pkram_prepare_load_obj(struct pkram_stream *ps)
 {
-	return -ENOSYS;
+	struct pkram_node *node = ps->node;
+	struct pkram_obj *obj;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
+
+	if (!node->obj_pfn)
+		return -ENODATA;
+
+	obj = pfn_to_kaddr(node->obj_pfn);
+	node->obj_pfn = obj->obj_pfn;
+
+	pkram_stream_init_obj(ps, obj);
+	return 0;
 }
 
 /**
@@ -230,7 +293,12 @@ int pkram_prepare_load_obj(struct pkram_stream *ps)
  */
 void pkram_finish_load_obj(struct pkram_stream *ps)
 {
-	BUG();
+	struct pkram_node *node = ps->node;
+	struct pkram_obj *obj = ps->obj;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
+
+	pkram_free_page(obj);
 }
 
 /**
@@ -244,6 +312,7 @@ void pkram_finish_load(struct pkram_stream *ps)
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
 
+	pkram_truncate_node(node);
 	pkram_free_page(node);
 }
 
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
