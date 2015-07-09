Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZDE9m-0002ik-G8
 for kexec@lists.infradead.org; Thu, 09 Jul 2015 15:54:39 +0000
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Thu, 9 Jul 2015 16:54:16 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3DC8F17D8042
 for <kexec@lists.infradead.org>; Thu,  9 Jul 2015 16:55:30 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t69FsDAk35455084
 for <kexec@lists.infradead.org>; Thu, 9 Jul 2015 15:54:13 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t69FsDSZ026778
 for <kexec@lists.infradead.org>; Thu, 9 Jul 2015 11:54:13 -0400
Date: Thu, 9 Jul 2015 17:54:11 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] kexec: Make a pair of map and unmap reserved pages
 when kdump fails to start
Message-ID: <20150709175411.7037a4fa@holzheu>
In-Reply-To: <20150707211840.GA4388@redhat.com>
References: <1435801552-1230-1-git-send-email-mnfhuang@gmail.com>
 <20150707211840.GA4388@redhat.com>
Mime-Version: 1.0
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: linux-s390@vger.kernel.org, kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, Minfei Huang <mnfhuang@gmail.com>, schwidefsky@de.ibm.com, linux390@de.ibm.com, ebiederm@xmission.com

On Tue, 7 Jul 2015 17:18:40 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Thu, Jul 02, 2015 at 09:45:52AM +0800, Minfei Huang wrote:

[snip]

> I am thinking of moving kernel loading code in a separate function to
> make things little simpler. Right now it is confusing.
> 
> Can you please test attached patch. I have only compile tested it. This
> is primarily doing what you are doing but in a separate function. It
> seems more readable now.

The patch looks good to me. What about the following patch on top
to make things even more readable?
---
 kernel/kexec.c |   50 +++++++++++++++++---------------------------------
 1 file changed, 17 insertions(+), 33 deletions(-)

--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1236,14 +1236,18 @@ int kexec_load_disabled;
 
 static DEFINE_MUTEX(kexec_mutex);
 
-static int __kexec_load(struct kimage **rimage, unsigned long entry,
-			unsigned long nr_segments,
+static int __kexec_load(unsigned long entry, unsigned long nr_segments,
 			struct kexec_segment __user * segments,
 			unsigned long flags)
 {
+	struct kimage *image, **dest_image;
 	unsigned long i;
 	int result;
-	struct kimage *image;
+
+	dest_image = (flags & KEXEC_ON_CRASH) ? &kexec_crash_image : &kexec_image;
+
+	if (nr_segments == 0)
+		return 0;
 
 	if (flags & KEXEC_ON_CRASH) {
 		/*
@@ -1251,7 +1255,6 @@ static int __kexec_load(struct kimage **
 		 * crashes.  Free any current crash dump kernel before
 		 * we corrupt it.
 		 */
-
 		kimage_free(xchg(&kexec_crash_image, NULL));
 	}
 
@@ -1267,30 +1270,29 @@ static int __kexec_load(struct kimage **
 
 	result = machine_kexec_prepare(image);
 	if (result)
-		goto out;
+		goto fail;
 
 	for (i = 0; i < nr_segments; i++) {
 		result = kimage_load_segment(image, &image->segment[i]);
 		if (result)
-			goto out;
+			goto fail;
 	}
-
 	kimage_terminate(image);
-	*rimage = image;
-out:
+	/* Install the new kernel, and  uninstall the old */
+	kimage_free(xchg(dest_image, image));
 	if (flags & KEXEC_ON_CRASH)
 		crash_unmap_reserved_pages();
-
-	/* Free image if there was an error */
-	if (result)
-		kimage_free(image);
+	return 0;
+fail:
+	if (flags & KEXEC_ON_CRASH)
+		crash_unmap_reserved_pages();
+	kimage_free(image);
 	return result;
 }
 
 SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		struct kexec_segment __user *, segments, unsigned long, flags)
 {
-	struct kimage **dest_image, *image;
 	int result;
 
 	/* We only trust the superuser with rebooting the system. */
@@ -1315,9 +1317,6 @@ SYSCALL_DEFINE4(kexec_load, unsigned lon
 	if (nr_segments > KEXEC_SEGMENT_MAX)
 		return -EINVAL;
 
-	image = NULL;
-	result = 0;
-
 	/* Because we write directly to the reserved memory
 	 * region when loading crash kernels we need a mutex here to
 	 * prevent multiple crash  kernels from attempting to load
@@ -1329,24 +1328,9 @@ SYSCALL_DEFINE4(kexec_load, unsigned lon
 	if (!mutex_trylock(&kexec_mutex))
 		return -EBUSY;
 
-	dest_image = &kexec_image;
-	if (flags & KEXEC_ON_CRASH)
-		dest_image = &kexec_crash_image;
-
 	/* Load new kernel */
-	if (nr_segments > 0) {
-		result = __kexec_load(&image, entry, nr_segments, segments,
-				      flags);
-		if (result)
-			goto out;
-	}
-
-	/* Install the new kernel, and  Uninstall the old */
-	image = xchg(dest_image, image);
-
-out:
+	result = __kexec_load(entry, nr_segments, segments, flags);
 	mutex_unlock(&kexec_mutex);
-	kimage_free(image);
 
 	return result;
 }


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
