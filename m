Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z7xpP-0002D0-04
 for kexec@lists.infradead.org; Thu, 25 Jun 2015 03:27:51 +0000
From: Minfei Huang <mhuang@redhat.com>
Subject: [PATCH] kexec: Make a pair of reserved pages when kdump fails to start
Date: Thu, 25 Jun 2015 11:31:22 +0800
Message-Id: <1435203082-25338-1-git-send-email-mhuang@redhat.com>
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
To: ebiederm@xmission.com, vgoyal@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, holzheu@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Minfei Huang <mnfhuang@gmail.com>

From: Minfei Huang <mnfhuang@gmail.com>

For some arch, kexec shall map the reserved pages, then use them, when
we try to start the kdump service.

Now kexec will never unmap the reserved pages, once it fails to continue
starting the kdump service.

Make a pair of reserved pages in kdump starting path, whatever kexec
fails or not.

Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
---
 kernel/kexec.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 7a36fdc..ab32d59 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1308,19 +1308,23 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 			image->preserve_context = 1;
 		result = machine_kexec_prepare(image);
 		if (result)
-			goto out;
+			goto failure;
 
 		for (i = 0; i < nr_segments; i++) {
 			result = kimage_load_segment(image, &image->segment[i]);
 			if (result)
-				goto out;
+				goto failure;
 		}
 		kimage_terminate(image);
+
+failure:
 		if (flags & KEXEC_ON_CRASH)
 			crash_unmap_reserved_pages();
 	}
-	/* Install the new kernel, and  Uninstall the old */
-	image = xchg(dest_image, image);
+
+	if (result == 0)
+		/* Install the new kernel, and  Uninstall the old */
+		image = xchg(dest_image, image);
 
 out:
 	mutex_unlock(&kexec_mutex);
-- 
2.2.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
