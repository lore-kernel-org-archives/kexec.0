Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kg3h4-0001eI-Rt
	for kexec@lists.infradead.org; Wed, 17 Sep 2008 20:32:12 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <48D0067F.3020007@esentire.com>
Date: Tue, 16 Sep 2008 15:21:53 -0700
In-Reply-To: <48D0067F.3020007@esentire.com> (Jonathan Steel's message of
	"Tue, 16 Sep 2008 15:18:23 -0400")
Message-ID: <m1d4j3g29q.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: [PATCH] kexec: segmentation fault in kimage_add_entry
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jonathan Steel <jon.steel@esentire.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

From: Jonathan Steel <jon.steel@esentire.com>

A segmentation fault can occur in kimage_add_entry in kexec.c when
loading a kernel image into memory. The fault occurs because a page is
requested by calling kimage_alloc_page with gfp_mask GFP_KERNEL and the
function may actually return a page with gfp_mask GFP_HIGHUSER. The high
mem page is returned because it was swapped with the kernel page due to
the kernel page being a page that will shortly be copied to.

This patch ensures that kimage_alloc_page returns a page that was
created with the correct gfp flags.


I have verified the change and fixed the whitespace damage of the
original patch.  Jonathan did a great job of tracking this down
after he hit the problem. -- Eric

Signed-off-by: Jonathan Steel <jon.steel@esentire.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 kernel/kexec.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 59f3f0d..aef2653 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -753,8 +753,14 @@ static struct page *kimage_alloc_page(struct kimage *image,
 			*old = addr | (*old & ~PAGE_MASK);
 
 			/* The old page I have found cannot be a
-			 * destination page, so return it.
+			 * destination page, so return it if it's
+			 * gfp_flags honor the ones passed in.
 			 */
+			if (!(gfp_mask & __GFP_HIGHMEM) &&
+			    PageHighMem(old_page)) {
+				kimage_free_pages(old_page);
+				continue;
+			}
 			addr = old_addr;
 			page = old_page;
 			break;
-- 
1.5.3.rc6.17.g1911


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
