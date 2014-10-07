Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x230.google.com ([2607:f8b0:400e:c03::230])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XbLs5-0003rz-Kp
 for kexec@lists.infradead.org; Tue, 07 Oct 2014 03:55:34 +0000
Received: by mail-pa0-f48.google.com with SMTP id eu11so6365116pac.7
 for <kexec@lists.infradead.org>; Mon, 06 Oct 2014 20:55:11 -0700 (PDT)
From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] kexec: Remove unnecessary KERN_ERR from kexec.c
Date: Tue,  7 Oct 2014 12:54:58 +0900
Message-Id: <1412654098-31847-1-git-send-email-standby24x7@gmail.com>
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
To: linux-kernel@vger.kernel.org, vgoyal@redhat.com, hbabu@us.ibm.com, kexec@lists.infradead.org
Cc: Masanari Iida <standby24x7@gmail.com>

This patch remove unnecessary KERN_ERR from pr_err() within kexec.c.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 kernel/kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 2abf9f6..9a8a01a 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -600,7 +600,7 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
 	if (!kexec_on_panic) {
 		image->swap_page = kimage_alloc_control_pages(image, 0);
 		if (!image->swap_page) {
-			pr_err(KERN_ERR "Could not allocate swap buffer\n");
+			pr_err("Could not allocate swap buffer\n");
 			goto out_free_control_pages;
 		}
 	}
-- 
2.1.1.273.g97b8860


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
