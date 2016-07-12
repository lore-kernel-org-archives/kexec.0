Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga02-in.huawei.com ([119.145.14.65])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bMpmR-0002WE-GQ
 for kexec@lists.infradead.org; Tue, 12 Jul 2016 04:58:49 +0000
From: zhongjiang <zhongjiang@huawei.com>
Subject: [PATCH 1/2] kexec: remove unnecessary unusable_pages
Date: Tue, 12 Jul 2016 12:56:42 +0800
Message-ID: <1468299403-27954-1-git-send-email-zhongjiang@huawei.com>
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
To: ebiederm@xmission.com, dyoung@redhat.com, horms@verge.net.au, vgoyal@redhat.com, yinghai@kernel.org, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, kexec@lists.infradead.org

From: zhong jiang <zhongjiang@huawei.com>

In general, kexec alloc pages from buddy system, it cannot exceed
the physical address in the system.

The patch just remove this unnecessary code, no functional change.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 include/linux/kexec.h |  1 -
 kernel/kexec_core.c   | 13 -------------
 2 files changed, 14 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index e8acb2b..26e4917 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -162,7 +162,6 @@ struct kimage {
 
 	struct list_head control_pages;
 	struct list_head dest_pages;
-	struct list_head unusable_pages;
 
 	/* Address of next control page to allocate for crash kernels. */
 	unsigned long control_page;
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 56b3ed0..448127d 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -257,9 +257,6 @@ struct kimage *do_kimage_alloc_init(void)
 	/* Initialize the list of destination pages */
 	INIT_LIST_HEAD(&image->dest_pages);
 
-	/* Initialize the list of unusable pages */
-	INIT_LIST_HEAD(&image->unusable_pages);
-
 	return image;
 }
 
@@ -517,10 +514,6 @@ static void kimage_free_extra_pages(struct kimage *image)
 {
 	/* Walk through and free any extra destination pages I may have */
 	kimage_free_page_list(&image->dest_pages);
-
-	/* Walk through and free any unusable pages I have cached */
-	kimage_free_page_list(&image->unusable_pages);
-
 }
 void kimage_terminate(struct kimage *image)
 {
@@ -647,12 +640,6 @@ static struct page *kimage_alloc_page(struct kimage *image,
 		page = kimage_alloc_pages(gfp_mask, 0);
 		if (!page)
 			return NULL;
-		/* If the page cannot be used file it away */
-		if (page_to_pfn(page) >
-				(KEXEC_SOURCE_MEMORY_LIMIT >> PAGE_SHIFT)) {
-			list_add(&page->lru, &image->unusable_pages);
-			continue;
-		}
 		addr = page_to_pfn(page) << PAGE_SHIFT;
 
 		/* If it is the destination page we want use it */
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
