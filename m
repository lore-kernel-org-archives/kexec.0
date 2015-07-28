Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pd0-x231.google.com ([2607:f8b0:400e:c02::231])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZJwo3-0000nK-7f
 for kexec@lists.infradead.org; Tue, 28 Jul 2015 04:47:59 +0000
Received: by pdjr16 with SMTP id r16so64887467pdj.3
 for <kexec@lists.infradead.org>; Mon, 27 Jul 2015 21:47:38 -0700 (PDT)
From: Minfei Huang <mnfhuang@gmail.com>
Subject: [REPOST PATCH] kexec: Remove the unnecessary conditional judgement to
 simplify the code logic
Date: Tue, 28 Jul 2015 12:46:42 +0800
Message-Id: <1438058802-6462-1-git-send-email-mnfhuang@gmail.com>
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
To: akpm@linux-foundation.org, vgoyal@redhat.com, ebiederm@xmission.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Minfei Huang <mnfhuang@gmail.com>

Transforming PFN(Page Frame Number) to struct page is never failure, so
we can simplify the code logic to do the image->control_page assignment
directly in the loop, and remove the unnecessary conditional judgement.

Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
Acked-by: Dave Young <dyoung@redhat.com>
Acked-by: Vivek Goyal <vgoyal@redhat.com>
---
 kernel/kexec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 6f1ed75..cf82474 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -807,11 +807,10 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
 		/* If I don't overlap any segments I have found my hole! */
 		if (i == image->nr_segments) {
 			pages = pfn_to_page(hole_start >> PAGE_SHIFT);
+			image->control_page = hole_end;
 			break;
 		}
 	}
-	if (pages)
-		image->control_page = hole_end;
 
 	return pages;
 }
-- 
2.4.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
