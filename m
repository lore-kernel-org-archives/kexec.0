Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nf-out-0910.google.com ([64.233.182.190])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KJrWg-0007wV-Qe
	for kexec@lists.infradead.org; Fri, 18 Jul 2008 15:05:43 +0000
Received: by nf-out-0910.google.com with SMTP id d21so218420nfb.22
	for <kexec@lists.infradead.org>; Fri, 18 Jul 2008 08:05:40 -0700 (PDT)
Date: Fri, 18 Jul 2008 16:04:10 +0100
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: [Patch] kexec: remove redundant if-else
Message-ID: <20080718150410.GB26261@hack.voiplan.pt>
MIME-Version: 1.0
Content-Disposition: inline
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: kexec@lists.infradead.org, ebiederm@xmission.com


These if-else's can be removed.

Signed-off-by: WANG Cong <wangcong@zeuux.org>
Cc: ebiederm@xmission.com

---
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 1c5fcac..ea6fa9b 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -203,13 +203,11 @@ static int do_kimage_alloc(struct kimage **rimage, unsigned long entry,
 			goto out;
 	}
 
-	result = 0;
-out:
-	if (result == 0)
-		*rimage = image;
-	else
-		kfree(image);
+	*rimage = image;
+	return 0;
 
+out:
+	kfree(image);
 	return result;
 
 }
@@ -242,13 +240,11 @@ static int kimage_normal_alloc(struct kimage **rimage, unsigned long entry,
 		goto out;
 	}
 
-	result = 0;
- out:
-	if (result == 0)
-		*rimage = image;
-	else
-		kfree(image);
+	*rimage = image;
+	return 0;
 
+ out:
+	kfree(image);
 	return result;
 }
 
@@ -311,13 +307,11 @@ static int kimage_crash_alloc(struct kimage **rimage, unsigned long entry,
 		goto out;
 	}
 
-	result = 0;
-out:
-	if (result == 0)
-		*rimage = image;
-	else
-		kfree(image);
+	*rimage = image;
+	return 0;
 
+out:
+	kfree(image);
 	return result;
 }
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
