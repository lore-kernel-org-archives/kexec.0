Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLsr-004vUT-Ed
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:26:50 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 02/43] mm: PKRAM: implement node load and save functions
Date: Tue, 30 Mar 2021 14:35:37 -0700
Message-Id: <1617140178-8773-3-git-send-email-anthony.yznaga@oracle.com>
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

Preserved memory is divided into nodes which can be saved and loaded
independently of each other. PKRAM nodes are kept on a list and
identified by unique names. Whenever a save operation is initiated by
calling pkram_prepare_save(), a new node is created and linked to the
list. When the save operation has been committed by calling
pkram_finish_save(), the node becomes loadable. A load operation can be
then initiated by calling pkram_prepare_load() which deletes the node
from the list and prepares the corresponding stream for loading data
from it. After the load has been finished, the pkram_finish_load()
function must be called to free the node. Nodes are also deleted when a
save operation is discarded, i.e. pkram_discard_save() is called instead
of pkram_finish_save().

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |   8 ++-
 mm/pkram.c            | 148 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 150 insertions(+), 6 deletions(-)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index a575da2d6c79..01055a876450 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -6,6 +6,8 @@
 #include <linux/types.h>
 #include <linux/mm_types.h>
 
+struct pkram_node;
+
 /**
  * enum pkram_data_flags - definition of data types contained in a pkram obj
  * @PKRAM_DATA_none: No data types configured
@@ -14,7 +16,11 @@ enum pkram_data_flags {
 	PKRAM_DATA_none		= 0x0,  /* No data types configured */
 };
 
-struct pkram_stream;
+struct pkram_stream {
+	gfp_t gfp_mask;
+	struct pkram_node *node;
+};
+
 struct pkram_access;
 
 #define PKRAM_NAME_MAX		256	/* including nul */
diff --git a/mm/pkram.c b/mm/pkram.c
index 59e4661b2fb7..21976df6e0ea 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -2,16 +2,85 @@
 #include <linux/err.h>
 #include <linux/gfp.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/mm.h>
+#include <linux/mutex.h>
 #include <linux/pkram.h>
+#include <linux/string.h>
 #include <linux/types.h>
 
+/*
+ * Preserved memory is divided into nodes that can be saved or loaded
+ * independently of each other. The nodes are identified by unique name
+ * strings.
+ *
+ * The structure occupies a memory page.
+ */
+struct pkram_node {
+	__u32	flags;
+
+	__u8	name[PKRAM_NAME_MAX];
+};
+
+#define PKRAM_SAVE		1
+#define PKRAM_LOAD		2
+#define PKRAM_ACCMODE_MASK	3
+
+static LIST_HEAD(pkram_nodes);			/* linked through page::lru */
+static DEFINE_MUTEX(pkram_mutex);		/* serializes open/close */
+
+static inline struct page *pkram_alloc_page(gfp_t gfp_mask)
+{
+	return alloc_page(gfp_mask);
+}
+
+static inline void pkram_free_page(void *addr)
+{
+	free_page((unsigned long)addr);
+}
+
+static inline void pkram_insert_node(struct pkram_node *node)
+{
+	list_add(&virt_to_page(node)->lru, &pkram_nodes);
+}
+
+static inline void pkram_delete_node(struct pkram_node *node)
+{
+	list_del(&virt_to_page(node)->lru);
+}
+
+static struct pkram_node *pkram_find_node(const char *name)
+{
+	struct page *page;
+	struct pkram_node *node;
+
+	list_for_each_entry(page, &pkram_nodes, lru) {
+		node = page_address(page);
+		if (strcmp(node->name, name) == 0)
+			return node;
+	}
+	return NULL;
+}
+
+static void pkram_stream_init(struct pkram_stream *ps,
+			     struct pkram_node *node, gfp_t gfp_mask)
+{
+	memset(ps, 0, sizeof(*ps));
+	ps->gfp_mask = gfp_mask;
+	ps->node = node;
+}
+
 /**
  * Create a preserved memory node with name @name and initialize stream @ps
  * for saving data to it.
  *
  * @gfp_mask specifies the memory allocation mask to be used when saving data.
  *
+ * Error values:
+ *	%ENAMETOOLONG: name len >= PKRAM_NAME_MAX
+ *	%ENOMEM: insufficient memory available
+ *	%EEXIST: node with specified name already exists
+ *
  * Returns 0 on success, -errno on failure.
  *
  * After the save has finished, pkram_finish_save() (or pkram_discard_save() in
@@ -19,7 +88,34 @@
  */
 int pkram_prepare_save(struct pkram_stream *ps, const char *name, gfp_t gfp_mask)
 {
-	return -ENOSYS;
+	struct page *page;
+	struct pkram_node *node;
+	int err = 0;
+
+	if (strlen(name) >= PKRAM_NAME_MAX)
+		return -ENAMETOOLONG;
+
+	page = pkram_alloc_page(gfp_mask | __GFP_ZERO);
+	if (!page)
+		return -ENOMEM;
+	node = page_address(page);
+
+	node->flags = PKRAM_SAVE;
+	strcpy(node->name, name);
+
+	mutex_lock(&pkram_mutex);
+	if (!pkram_find_node(name))
+		pkram_insert_node(node);
+	else
+		err = -EEXIST;
+	mutex_unlock(&pkram_mutex);
+	if (err) {
+		pkram_free_page(node);
+		return err;
+	}
+
+	pkram_stream_init(ps, node, gfp_mask);
+	return 0;
 }
 
 /**
@@ -50,7 +146,12 @@ void pkram_finish_save_obj(struct pkram_stream *ps)
  */
 void pkram_finish_save(struct pkram_stream *ps)
 {
-	BUG();
+	struct pkram_node *node = ps->node;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
+
+	smp_wmb();
+	node->flags &= ~PKRAM_ACCMODE_MASK;
 }
 
 /**
@@ -60,7 +161,15 @@ void pkram_finish_save(struct pkram_stream *ps)
  */
 void pkram_discard_save(struct pkram_stream *ps)
 {
-	BUG();
+	struct pkram_node *node = ps->node;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
+
+	mutex_lock(&pkram_mutex);
+	pkram_delete_node(node);
+	mutex_unlock(&pkram_mutex);
+
+	pkram_free_page(node);
 }
 
 /**
@@ -69,11 +178,36 @@ void pkram_discard_save(struct pkram_stream *ps)
  *
  * Returns 0 on success, -errno on failure.
  *
+ * Error values:
+ *	%ENOENT: node with specified name does not exist
+ *	%EBUSY: save to required node has not finished yet
+ *
  * After the load has finished, pkram_finish_load() is to be called.
  */
 int pkram_prepare_load(struct pkram_stream *ps, const char *name)
 {
-	return -ENOSYS;
+	struct pkram_node *node;
+	int err = 0;
+
+	mutex_lock(&pkram_mutex);
+	node = pkram_find_node(name);
+	if (!node) {
+		err = -ENOENT;
+		goto out_unlock;
+	}
+	if (node->flags & PKRAM_ACCMODE_MASK) {
+		err = -EBUSY;
+		goto out_unlock;
+	}
+	pkram_delete_node(node);
+out_unlock:
+	mutex_unlock(&pkram_mutex);
+	if (err)
+		return err;
+
+	node->flags |= PKRAM_LOAD;
+	pkram_stream_init(ps, node, 0);
+	return 0;
 }
 
 /**
@@ -106,7 +240,11 @@ void pkram_finish_load_obj(struct pkram_stream *ps)
  */
 void pkram_finish_load(struct pkram_stream *ps)
 {
-	BUG();
+	struct pkram_node *node = ps->node;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
+
+	pkram_free_page(node);
 }
 
 /**
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
