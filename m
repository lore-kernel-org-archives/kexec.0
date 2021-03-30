Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLt6-004vZt-33
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:27:13 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 19/43] mm: PKRAM: allow preserved memory to be freed from
 userspace
Date: Tue, 30 Mar 2021 14:35:54 -0700
Message-Id: <1617140178-8773-20-git-send-email-anthony.yznaga@oracle.com>
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

To free all space utilized for preserved memory, one can write 0 to
/sys/kernel/pkram. This will destroy all PKRAM nodes that are not
currently being read or written.

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/mm/pkram.c b/mm/pkram.c
index dcf84ba785a7..8700fd77dc67 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -493,6 +493,32 @@ static void pkram_truncate_node(struct pkram_node *node)
 	node->obj_pfn = 0;
 }
 
+/*
+ * Free all nodes that are not under operation.
+ */
+static void pkram_truncate(void)
+{
+	struct page *page, *tmp;
+	struct pkram_node *node;
+	LIST_HEAD(dispose);
+
+	mutex_lock(&pkram_mutex);
+	list_for_each_entry_safe(page, tmp, &pkram_nodes, lru) {
+		node = page_address(page);
+		if (!(node->flags & PKRAM_ACCMODE_MASK))
+			list_move(&page->lru, &dispose);
+	}
+	mutex_unlock(&pkram_mutex);
+
+	while (!list_empty(&dispose)) {
+		page = list_first_entry(&dispose, struct page, lru);
+		list_del(&page->lru);
+		node = page_address(page);
+		pkram_truncate_node(node);
+		pkram_free_page(node);
+	}
+}
+
 static void pkram_add_link(struct pkram_link *link, struct pkram_data_stream *pds)
 {
 	__u64 link_pfn = page_to_pfn(virt_to_page(link));
@@ -1233,8 +1259,19 @@ static ssize_t show_pkram_sb_pfn(struct kobject *kobj,
 	return sprintf(buf, "%lx\n", pfn);
 }
 
+static ssize_t store_pkram_sb_pfn(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	int val;
+
+	if (kstrtoint(buf, 0, &val) || val)
+		return -EINVAL;
+	pkram_truncate();
+	return count;
+}
+
 static struct kobj_attribute pkram_sb_pfn_attr =
-	__ATTR(pkram, 0444, show_pkram_sb_pfn, NULL);
+	__ATTR(pkram, 0644, show_pkram_sb_pfn, store_pkram_sb_pfn);
 
 static struct attribute *pkram_attrs[] = {
 	&pkram_sb_pfn_attr.attr,
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
