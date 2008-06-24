Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KBDSF-0002JT-6r
	for kexec@lists.infradead.org; Tue, 24 Jun 2008 18:41:23 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20080624164240.GF10512@hack.voiplan.pt>
Date: Tue, 24 Jun 2008 11:40:46 -0700
In-Reply-To: <20080624164240.GF10512@hack.voiplan.pt> (WANG Cong's message of
	"Tue, 24 Jun 2008 17:42:40 +0100")
Message-ID: <m14p7iy8up.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [Patch] kernel/kexec.c: make 'kimage_terminate' void
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: WANG Cong <xiyou.wangcong@gmail.com>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>

From: WANG Cong <xiyou.wangcong@gmail.com>

Since kimage_terminate() always returns 0, make it void.

Signed-off-by: WANG Cong <wangcong@zeuux.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

---
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 1c5fcac..6db42ff 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -589,14 +589,12 @@ static void kimage_free_extra_pages(struct kimage *image)
 	kimage_free_page_list(&image->unuseable_pages);
 
 }
-static int kimage_terminate(struct kimage *image)
+static void kimage_terminate(struct kimage *image)
 {
 	if (*image->entry != 0)
 		image->entry++;
 
 	*image->entry = IND_DONE;
-
-	return 0;
 }
 
 #define for_each_kimage_entry(image, ptr, entry) \
@@ -997,9 +995,7 @@ asmlinkage long sys_kexec_load(unsigned long entry, unsigned long nr_segments,
 			if (result)
 				goto out;
 		}
-		result = kimage_terminate(image);
-		if (result)
-			goto out;
+		kimage_terminate(image);
 	}
 	/* Install the new kernel, and  Uninstall the old */
 	image = xchg(dest_image, image);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
