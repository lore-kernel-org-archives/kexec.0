Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUdb-0007Xy-0T
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:43:45 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 07/43] mm: PKRAM: link nodes by pfn before reboot
Date: Wed,  6 May 2020 17:41:33 -0700
Message-Id: <1588812129-8596-8-git-send-email-anthony.yznaga@oracle.com>
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

Since page structs are used for linking PKRAM nodes and cleared
on boot, organize all PKRAM nodes into a list singly-linked by pfns
before reboot to facilitate the node list restore in the new kernel.

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/mm/pkram.c b/mm/pkram.c
index 06b471eea0b0..44fadb70acf6 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -2,12 +2,16 @@
 #include <linux/err.h>
 #include <linux/gfp.h>
 #include <linux/highmem.h>
+#include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/notifier.h>
 #include <linux/pkram.h>
+#include <linux/reboot.h>
 #include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -58,11 +62,15 @@ struct pkram_obj {
  * singly-linked list of PKRAM link structures (see above), the node has a
  * pointer to the head of.
  *
+ * To facilitate data restore in the new kernel, before reboot all PKRAM nodes
+ * are organized into a list singly-linked by pfn's (see pkram_reboot()).
+ *
  * The structure occupies a memory page.
  */
 struct pkram_node {
 	__u32	flags;
 	__u64	obj_pfn;	/* points to the first obj of the node */
+	__u64	node_pfn;	/* points to the next node in the node list */
 
 	__u8	name[PKRAM_NAME_MAX];
 };
@@ -71,6 +79,10 @@ struct pkram_node {
 #define PKRAM_LOAD		2
 #define PKRAM_ACCMODE_MASK	3
 
+/*
+ * For convenience sake PKRAM nodes are kept in an auxiliary doubly-linked list
+ * connected through the lru field of the page struct.
+ */
 static LIST_HEAD(pkram_nodes);			/* linked through page::lru */
 static DEFINE_MUTEX(pkram_mutex);		/* serializes open/close */
 
@@ -679,3 +691,41 @@ size_t pkram_read(struct pkram_stream *ps, void *buf, size_t count)
 
 	return copy_count;
 }
+
+/*
+ * Build the list of PKRAM nodes.
+ */
+static void __pkram_reboot(void)
+{
+	struct page *page;
+	struct pkram_node *node;
+	unsigned long node_pfn = 0;
+
+	list_for_each_entry_reverse(page, &pkram_nodes, lru) {
+		node = page_address(page);
+		if (WARN_ON(node->flags & PKRAM_ACCMODE_MASK))
+			continue;
+		node->node_pfn = node_pfn;
+		node_pfn = page_to_pfn(page);
+	}
+}
+
+static int pkram_reboot(struct notifier_block *notifier,
+		       unsigned long val, void *v)
+{
+	if (val != SYS_RESTART)
+		return NOTIFY_DONE;
+	__pkram_reboot();
+	return NOTIFY_OK;
+}
+
+static struct notifier_block pkram_reboot_notifier = {
+	.notifier_call = pkram_reboot,
+};
+
+static int __init pkram_init(void)
+{
+	register_reboot_notifier(&pkram_reboot_notifier);
+	return 0;
+}
+module_init(pkram_init);
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
