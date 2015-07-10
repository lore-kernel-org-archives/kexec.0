Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZDU4v-0002LV-73
 for kexec@lists.infradead.org; Fri, 10 Jul 2015 08:54:42 +0000
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 10 Jul 2015 09:54:18 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 64EA317D8042
 for <kexec@lists.infradead.org>; Fri, 10 Jul 2015 09:55:32 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6A8sF4536700388
 for <kexec@lists.infradead.org>; Fri, 10 Jul 2015 08:54:15 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6A8sEVA011698
 for <kexec@lists.infradead.org>; Fri, 10 Jul 2015 02:54:15 -0600
Date: Fri, 10 Jul 2015 10:54:13 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v4] kexec: Make a pair of map and unmap reserved pages
 when kdump fails to start
Message-ID: <20150710105413.04e1db00@holzheu>
In-Reply-To: <1436505137-4364-1-git-send-email-mnfhuang@gmail.com>
References: <1436505137-4364-1-git-send-email-mnfhuang@gmail.com>
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
To: Minfei Huang <mnfhuang@gmail.com>
Cc: linux-s390@vger.kernel.org, kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, schwidefsky@de.ibm.com, linux390@de.ibm.com, vgoyal@redhat.com

On Fri, 10 Jul 2015 13:12:17 +0800
Minfei Huang <mnfhuang@gmail.com> wrote:

> For some arch, kexec shall map the reserved pages, then use them, when
> we try to start the kdump service.
> 
> Now kexec will never unmap the reserved pages, once it fails to continue
> starting the kdump service. So we make a pair of map/unmap reserved
> pages whatever kexec fails or not in code path.
> 
> In order to make code readable, wrap a new function __kexec_load which
> contains all of the logic to deal with the image loading.
> 
> Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
> ---
> v3:
> - reconstruct the patch, wrap a new function to deal with the code logic, based on Vivek and Michael's patch
> v2:
> - replace the "failure" label with "fail_unmap_pages"
> v1:
> - reconstruct the patch code
> ---
>  kernel/kexec.c | 112 ++++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 63 insertions(+), 49 deletions(-)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index a785c10..2232c90 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1247,10 +1247,71 @@ int kexec_load_disabled;
> 
>  static DEFINE_MUTEX(kexec_mutex);
> 
> +static int __kexec_load(unsigned long entry, unsigned long nr_segments,
> +			struct kexec_segment __user *segments,
> +			unsigned long flags)
> +{
> +	int result = 0;
> +	struct kimage **dest_image, *image;
> +
> +	dest_image = &kexec_image;
> +
> +	if (flags & KEXEC_ON_CRASH)
> +		dest_image = &kexec_crash_image;
> +
> +	if (nr_segments == 0) {
> +		/* Install the new kernel, and  Uninstall the old */
> +		image = xchg(dest_image, image);
> +		kimage_free(image);

Well this is wrong and should probably be:

        if (nr_segments == 0) {
                /* Uninstall image */
                image = xchg(dest_image, NULL);
                kimage_free(image);

> +	} else {
> +		unsigned long i;
> +
> +		if (flags & KEXEC_ON_CRASH) {
> +			/*

[snip]

> +			result = kimage_load_segment(image, &image->segment[i]);
> +			if (result)
> +				goto failure_unmap_mem;
> +		}
> +
> +		kimage_terminate(image);
> +
> +		/* Install the new kernel, and  Uninstall the old */

Perhaps fix the comment: Remove superfluous blank and lowercase "uninstall"?

> +		image = xchg(dest_image, image);
> +
> +failure_unmap_mem:
> +		if (flags & KEXEC_ON_CRASH)
> +			crash_unmap_reserved_pages();
> +		kimage_free(image);

Here the update patch:
---
diff --git a/kernel/kexec.c b/kernel/kexec.c
index e686a39..2f5b4aa 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1249,8 +1249,8 @@ static int __kexec_load(unsigned long entry, unsigned long nr_segments,
 		dest_image = &kexec_crash_image;
 
 	if (nr_segments == 0) {
-		/* Install the new kernel, and  Uninstall the old */
-		image = xchg(dest_image, image);
+		/* Uninstall image */
+		image = xchg(dest_image, NULL);
 		kimage_free(image);
 	} else {
 		unsigned long i;
@@ -1287,7 +1287,7 @@ static int __kexec_load(unsigned long entry, unsigned long nr_segments,
 
 		kimage_terminate(image);
 
-		/* Install the new kernel, and  Uninstall the old */
+		/* Install the new kernel, and uninstall the old */
 		image = xchg(dest_image, image);
 
 failure_unmap_mem:


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
