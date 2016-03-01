Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x244.google.com ([2607:f8b0:400e:c03::244])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aafGi-00076S-OR
 for kexec@lists.infradead.org; Tue, 01 Mar 2016 08:02:57 +0000
Received: by mail-pa0-x244.google.com with SMTP id a7so8676949pax.3
 for <kexec@lists.infradead.org>; Tue, 01 Mar 2016 00:02:36 -0800 (PST)
From: Minfei Huang <mnfhuang@gmail.com>
Subject: [PATCH V2 1/2] kexec: Make a pair of map/unmap reserved pages in
 error path
Date: Tue,  1 Mar 2016 16:02:28 +0800
Message-Id: <1456819349-8650-2-git-send-email-mnfhuang@gmail.com>
In-Reply-To: <1456819349-8650-1-git-send-email-mnfhuang@gmail.com>
References: <1456819349-8650-1-git-send-email-mnfhuang@gmail.com>
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
To: ebiederm@xmission.com, akpm@linux-foundation.org
Cc: mhuang@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Minfei Huang <mnfhuang@gmail.com>

For some arch, kexec shall map the reserved pages, then use them, when
we try to start the kdump service.

kexec may return directly, without unmaping the reserved pages, if it
fails during starting service. To fix it, we make a pair of map/unmap
reserved pages both in generic path and error path.

Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
---
 kernel/kexec.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index ee70aef..5cd60c4 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -169,6 +169,7 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 	dest_image = &kexec_image;
 	if (flags & KEXEC_ON_CRASH)
 		dest_image = &kexec_crash_image;
+
 	if (nr_segments > 0) {
 		unsigned long i;
 
@@ -190,22 +191,25 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 						   segments, flags);
 		}
 		if (result)
-			goto out;
+			goto unmap_page;
 
 		if (flags & KEXEC_PRESERVE_CONTEXT)
 			image->preserve_context = 1;
 		result = machine_kexec_prepare(image);
 		if (result)
-			goto out;
+			goto unmap_page;
 
 		for (i = 0; i < nr_segments; i++) {
 			result = kimage_load_segment(image, &image->segment[i]);
 			if (result)
-				goto out;
+				goto unmap_page;
 		}
 		kimage_terminate(image);
+unmap_page:
 		if (flags & KEXEC_ON_CRASH)
 			crash_unmap_reserved_pages();
+		if (result)
+			goto out;
 	}
 	/* Install the new kernel, and  Uninstall the old */
 	image = xchg(dest_image, image);
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
