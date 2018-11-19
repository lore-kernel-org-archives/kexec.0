Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gOgcn-0001Zv-Mg
 for kexec@lists.infradead.org; Mon, 19 Nov 2018 10:17:53 +0000
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 6/8] vmw_balloon: mark inflated pages PG_offline
Date: Mon, 19 Nov 2018 11:16:14 +0100
Message-Id: <20181119101616.8901-7-david@redhat.com>
In-Reply-To: <20181119101616.8901-1-david@redhat.com>
References: <20181119101616.8901-1-david@redhat.com>
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
To: linux-mm@kvack.org
Cc: Michal Hocko <mhocko@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, pv-drivers@vmware.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org, kexec-ml <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Xavier Deguillard <xdeguillard@vmware.com>, Julien Freche <jfreche@vmware.com>, Nadav Amit <namit@vmware.com>, xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, devel@linuxdriverproject.org, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

Mark inflated and never onlined pages PG_offline, to tell the world that
the content is stale and should not be dumped.

Cc: Xavier Deguillard <xdeguillard@vmware.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Julien Freche <jfreche@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/misc/vmw_balloon.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index e6126a4b95d3..8cc8bd9a4e32 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -544,6 +544,36 @@ unsigned int vmballoon_page_order(enum vmballoon_page_size_type page_size)
 	return page_size == VMW_BALLOON_2M_PAGE ? VMW_BALLOON_2M_ORDER : 0;
 }
 
+/**
+ * vmballoon_mark_page_offline() - mark a page as offline
+ * @page: pointer for the page
+ * @page_size: the size of the page.
+ */
+static void
+vmballoon_mark_page_offline(struct page *page,
+			    enum vmballoon_page_size_type page_size)
+{
+	int i;
+
+	for (i = 0; i < 1ULL << vmballoon_page_order(page_size); i++)
+		__SetPageOffline(page + i);
+}
+
+/**
+ * vmballoon_mark_page_online() - mark a page as online
+ * @page: pointer for the page
+ * @page_size: the size of the page.
+ */
+static void
+vmballoon_mark_page_online(struct page *page,
+			   enum vmballoon_page_size_type page_size)
+{
+	int i;
+
+	for (i = 0; i < 1ULL << vmballoon_page_order(page_size); i++)
+		__ClearPageOffline(page + i);
+}
+
 /**
  * vmballoon_page_in_frames() - returns the number of frames in a page.
  * @page_size: the size of the page.
@@ -612,6 +642,7 @@ static int vmballoon_alloc_page_list(struct vmballoon *b,
 					 ctl->page_size);
 
 		if (page) {
+			vmballoon_mark_page_offline(page, ctl->page_size);
 			/* Success. Add the page to the list and continue. */
 			list_add(&page->lru, &ctl->pages);
 			continue;
@@ -850,6 +881,7 @@ static void vmballoon_release_page_list(struct list_head *page_list,
 
 	list_for_each_entry_safe(page, tmp, page_list, lru) {
 		list_del(&page->lru);
+		vmballoon_mark_page_online(page, page_size);
 		__free_pages(page, vmballoon_page_order(page_size));
 	}
 
-- 
2.17.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
