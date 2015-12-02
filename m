Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a3zwb-0004r0-5L
 for kexec@lists.infradead.org; Wed, 02 Dec 2015 05:27:09 +0000
From: Xunlei Pang <xlpang@redhat.com>
Subject: [PATCH 1/2] kexec: Set KEXEC_TYPE_CRASH before
 sanity_check_segment_list()
Date: Wed,  2 Dec 2015 13:26:35 +0800
Message-Id: <1449033995-15700-1-git-send-email-xlpang@redhat.com>
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
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: Xunlei Pang <xlpang@redhat.com>, Dave Young <dyoung@redhat.com>, Eric Biederman <ebiederm@xmission.com>

sanity_check_segment_list() checks KEXEC_TYPE_CRASH flag to ensure
all the segments of the loaded crash kernel are winthin the kernel
crash resource limits, so set the flag beforehand.

Signed-off-by: Xunlei Pang <xlpang@redhat.com>
---
 kernel/kexec.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index d873b64..9624391 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -63,16 +63,19 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 	if (ret)
 		goto out_free_image;
 
-	ret = sanity_check_segment_list(image);
-	if (ret)
-		goto out_free_image;
-
-	 /* Enable the special crash kernel control page allocation policy. */
+	/*
+	 * Enable the special crash kernel control page allocation policy,
+	 * and set the crash type flag.
+	 */
 	if (kexec_on_panic) {
 		image->control_page = crashk_res.start;
 		image->type = KEXEC_TYPE_CRASH;
 	}
 
+	ret = sanity_check_segment_list(image);
+	if (ret)
+		goto out_free_image;
+
 	/*
 	 * Find a location for the control code buffer, and add it
 	 * the vector of segments so that it's pages will also be
-- 
2.5.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
