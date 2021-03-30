Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLsr-004vUS-Ed
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:26:50 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 03/43] mm: PKRAM: implement object load and save functions
Date: Tue, 30 Mar 2021 14:35:38 -0700
Message-Id: <1617140178-8773-4-git-send-email-anthony.yznaga@oracle.com>
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
 include/linux/pkram.h |  2 ++
 mm/pkram.c            | 72 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 01055a876450..a4d55af392c0 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -7,6 +7,7 @@
 #include <linux/mm_types.h>
 
 struct pkram_node;
+struct pkram_obj;
 
 /**
  * enum pkram_data_flags - definition of data types contained in a pkram obj
@@ -19,6 +20,7 @@ enum pkram_data_flags {
 struct pkram_stream {
 	gfp_t gfp_mask;
 	struct pkram_node *node;
+	struct pkram_obj *obj;
 };
 
 struct pkram_access;
diff --git a/mm/pkram.c b/mm/pkram.c
index 21976df6e0ea..7c977c5982f8 100644
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
@@ -124,12 +145,31 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name, gfp_t gfp_mask
  *
  * Returns 0 on success, -errno on failure.
  *
+ * Error values:
+ *	%ENOMEM: insufficient memory available
+ *
  * After the save has finished, pkram_finish_save_obj() (or pkram_discard_save()
  * in case of failure) is to be called.
  */
 int pkram_prepare_save_obj(struct pkram_stream *ps, enum pkram_data_flags flags)
 {
-	return -ENOSYS;
+	struct pkram_node *node = ps->node;
+	struct pkram_obj *obj;
+	struct page *page;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
+
+	page = pkram_alloc_page(ps->gfp_mask | __GFP_ZERO);
+	if (!page)
+		return -ENOMEM;
+	obj = page_address(page);
+
+	if (node->obj_pfn)
+		obj->obj_pfn = node->obj_pfn;
+	node->obj_pfn = page_to_pfn(page);
+
+	ps->obj = obj;
+	return 0;
 }
 
 /**
@@ -137,7 +177,9 @@ int pkram_prepare_save_obj(struct pkram_stream *ps, enum pkram_data_flags flags)
  */
 void pkram_finish_save_obj(struct pkram_stream *ps)
 {
-	BUG();
+	struct pkram_node *node = ps->node;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
 }
 
 /**
@@ -169,6 +211,7 @@ void pkram_discard_save(struct pkram_stream *ps)
 	pkram_delete_node(node);
 	mutex_unlock(&pkram_mutex);
 
+	pkram_truncate_node(node);
 	pkram_free_page(node);
 }
 
@@ -216,11 +259,26 @@ int pkram_prepare_load(struct pkram_stream *ps, const char *name)
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
+	ps->obj = obj;
+	return 0;
 }
 
 /**
@@ -230,7 +288,12 @@ int pkram_prepare_load_obj(struct pkram_stream *ps)
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
@@ -244,6 +307,7 @@ void pkram_finish_load(struct pkram_stream *ps)
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
 
+	pkram_truncate_node(node);
 	pkram_free_page(node);
 }
 
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
