Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUda-0007Xu-Tx
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:43:44 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 08/43] mm: PKRAM: introduce super block
Date: Wed,  6 May 2020 17:41:34 -0700
Message-Id: <1588812129-8596-9-git-send-email-anthony.yznaga@oracle.com>
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

The PKRAM super block is the starting point for restoring preserved
memory. By providing the super block to the new kernel at boot time,
preserved memory can be reserved and made available to be restored.
To point the kernel to the location of the super block, one passes
its pfn via the 'pkram' boot param. For that purpose, the pkram super
block pfn is exported via /sys/kernel/pkram. If none is passed, any
preserved memory will not be kept, and a new super block will be
allocated.

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 94 insertions(+), 2 deletions(-)

diff --git a/mm/pkram.c b/mm/pkram.c
index 44fadb70acf6..70f2219e6218 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -5,15 +5,18 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/list.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
+#include <linux/pfn.h>
 #include <linux/pkram.h>
 #include <linux/reboot.h>
 #include <linux/sched.h>
 #include <linux/string.h>
+#include <linux/sysfs.h>
 #include <linux/types.h>
 
 #include "internal.h"
@@ -80,12 +83,38 @@ struct pkram_node {
 #define PKRAM_ACCMODE_MASK	3
 
 /*
+ * The PKRAM super block contains data needed to restore the preserved memory
+ * structure on boot. The pointer to it (pfn) should be passed via the 'pkram'
+ * boot param if one wants to restore preserved data saved by the previously
+ * executing kernel. For that purpose the kernel exports the pfn via
+ * /sys/kernel/pkram. If none is passed, preserved memory if any will not be
+ * preserved and a new clean page will be allocated for the super block.
+ *
+ * The structure occupies a memory page.
+ */
+struct pkram_super_block {
+	__u64	node_pfn;		/* first element of the node list */
+};
+
+static unsigned long pkram_sb_pfn __initdata;
+static struct pkram_super_block *pkram_sb;
+
+/*
  * For convenience sake PKRAM nodes are kept in an auxiliary doubly-linked list
  * connected through the lru field of the page struct.
  */
 static LIST_HEAD(pkram_nodes);			/* linked through page::lru */
 static DEFINE_MUTEX(pkram_mutex);		/* serializes open/close */
 
+/*
+ * The PKRAM super block pfn, see above.
+ */
+static int __init parse_pkram_sb_pfn(char *arg)
+{
+	return kstrtoul(arg, 16, &pkram_sb_pfn);
+}
+early_param("pkram", parse_pkram_sb_pfn);
+
 static inline struct page *pkram_alloc_page(gfp_t gfp_mask)
 {
 	return alloc_page(gfp_mask);
@@ -209,6 +238,7 @@ static void pkram_stream_init_obj(struct pkram_stream *ps, struct pkram_obj *obj
  * @gfp_mask specifies the memory allocation mask to be used when saving data.
  *
  * Error values:
+ *	%ENODEV: PKRAM not available
  *	%ENAMETOOLONG: name len >= PKRAM_NAME_MAX
  *	%ENOMEM: insufficient memory available
  *	%EEXIST: node with specified name already exists
@@ -224,6 +254,9 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name, gfp_t gfp_mask
 	struct pkram_node *node;
 	int err = 0;
 
+	if (!pkram_sb)
+		return -ENODEV;
+
 	if (strlen(name) >= PKRAM_NAME_MAX)
 		return -ENAMETOOLONG;
 
@@ -333,6 +366,7 @@ void pkram_discard_save(struct pkram_stream *ps)
  * Returns 0 on success, -errno on failure.
  *
  * Error values:
+ *	%ENODEV: PKRAM not available
  *	%ENOENT: node with specified name does not exist
  *	%EBUSY: save to required node has not finished yet
  *
@@ -343,6 +377,9 @@ int pkram_prepare_load(struct pkram_stream *ps, const char *name)
 	struct pkram_node *node;
 	int err = 0;
 
+	if (!pkram_sb)
+		return -ENODEV;
+
 	mutex_lock(&pkram_mutex);
 	node = pkram_find_node(name);
 	if (!node) {
@@ -708,6 +745,7 @@ static void __pkram_reboot(void)
 		node->node_pfn = node_pfn;
 		node_pfn = page_to_pfn(page);
 	}
+	pkram_sb->node_pfn = node_pfn;
 }
 
 static int pkram_reboot(struct notifier_block *notifier,
@@ -715,7 +753,8 @@ static int pkram_reboot(struct notifier_block *notifier,
 {
 	if (val != SYS_RESTART)
 		return NOTIFY_DONE;
-	__pkram_reboot();
+	if (pkram_sb)
+		__pkram_reboot();
 	return NOTIFY_OK;
 }
 
@@ -723,9 +762,62 @@ static struct notifier_block pkram_reboot_notifier = {
 	.notifier_call = pkram_reboot,
 };
 
+static ssize_t show_pkram_sb_pfn(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	unsigned long pfn = pkram_sb ? PFN_DOWN(__pa(pkram_sb)) : 0;
+
+	return sprintf(buf, "%lx\n", pfn);
+}
+
+static struct kobj_attribute pkram_sb_pfn_attr =
+	__ATTR(pkram, 0444, show_pkram_sb_pfn, NULL);
+
+static struct attribute *pkram_attrs[] = {
+	&pkram_sb_pfn_attr.attr,
+	NULL,
+};
+
+static struct attribute_group pkram_attr_group = {
+	.attrs = pkram_attrs,
+};
+
+/* returns non-zero on success */
+static int __init pkram_init_sb(void)
+{
+	unsigned long pfn;
+	struct pkram_node *node;
+
+	if (!pkram_sb) {
+		struct page *page;
+
+		page = pkram_alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!page) {
+			pr_err("PKRAM: Failed to allocate super block\n");
+			return 0;
+		}
+		pkram_sb = page_address(page);
+	}
+
+	/*
+	 * Build auxiliary doubly-linked list of nodes connected through
+	 * page::lru for convenience sake.
+	 */
+	pfn = pkram_sb->node_pfn;
+	while (pfn) {
+		node = pfn_to_kaddr(pfn);
+		pkram_insert_node(node);
+		pfn = node->node_pfn;
+	}
+	return 1;
+}
+
 static int __init pkram_init(void)
 {
-	register_reboot_notifier(&pkram_reboot_notifier);
+	if (pkram_init_sb()) {
+		register_reboot_notifier(&pkram_reboot_notifier);
+		sysfs_update_group(kernel_kobj, &pkram_attr_group);
+	}
 	return 0;
 }
 module_init(pkram_init);
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
