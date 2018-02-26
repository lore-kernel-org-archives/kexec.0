Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eqGms-0002wG-25
 for kexec@lists.infradead.org; Mon, 26 Feb 2018 11:17:43 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1QBEW10043735
 for <kexec@lists.infradead.org>; Mon, 26 Feb 2018 06:17:29 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gcd0ajj2m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 26 Feb 2018 06:17:28 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <prudo@linux.vnet.ibm.com>;
 Mon, 26 Feb 2018 11:17:26 -0000
Date: Mon, 26 Feb 2018 12:17:18 +0100
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: Re: [PATCH v8 03/13] kexec_file, x86, powerpc: factor out
 kexec_file_ops functions
In-Reply-To: <20180222111732.23051-4-takahiro.akashi@linaro.org>
References: <20180222111732.23051-1-takahiro.akashi@linaro.org>
 <20180222111732.23051-4-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Message-Id: <20180226121718.3432bbd6@ThinkPad>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, julien.thierry@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com, akpm@linux-foundation.org, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com

Hi AKASHI

On Thu, 22 Feb 2018 20:17:22 +0900
AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:

[...]

> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 990adae52151..a6d14a768b3e 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -26,34 +26,83 @@
>  #include <linux/vmalloc.h>
>  #include "kexec_internal.h"
> 
> +const __weak struct kexec_file_ops * const kexec_file_loaders[] = {NULL};
> +

Having a weak definition of kexec_file_loaders causes trouble on s390 with 
gcc 4.8 (newer versions seem to work fine). For me it looks like that in this
version gcc doesn't recognize __weak but use the default value for
optimization. This leads to _kexec_kernel_image_probe to always return ENOEXEC
because the for-loop gets optimized out.

The problem can easily be worked around by declaring kexec_file_loaders in
include/linux/kexec.h and defining it in arch code. In particular doing this

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 37e9dce518aa..fc0788540d90 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -139,6 +139,8 @@ struct kexec_file_ops {
 #endif
 };
 
+extern const struct kexec_file_ops * const kexec_file_loaders[];
+
 /**
  * struct kexec_buf - parameters for finding a place for a buffer in memory
  * @image:	kexec image in which memory to search.
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 17ba407d0e79..4e3d1e4bc7f6 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -31,8 +31,6 @@
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
 
-const __weak struct kexec_file_ops * const kexec_file_loaders[] = {NULL};
-
 #ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
 static int kexec_calculate_store_digests(struct kimage *image);
 #else

A nice side effect of this solution is, that a developer who forgets to define
kexec_file_loaders gets a linker error. So he directly knows what's missing
instead of first having to find out where/why an error gets returned.

Otherwise the series is fine for me.

Thanks
Philipp

>  #ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
>  static int kexec_calculate_store_digests(struct kimage *image);
>  #else
>  static int kexec_calculate_store_digests(struct kimage *image) { return 0; };
>  #endif
> 
> +int _kexec_kernel_image_probe(struct kimage *image, void *buf,
> +			     unsigned long buf_len)
> +{
> +	const struct kexec_file_ops * const *fops;
> +	int ret = -ENOEXEC;
> +
> +	for (fops = &kexec_file_loaders[0]; *fops && (*fops)->probe; ++fops) {
> +		ret = (*fops)->probe(buf, buf_len);
> +		if (!ret) {
> +			image->fops = *fops;
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  /* Architectures can provide this probe function */
>  int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
>  					 unsigned long buf_len)
>  {
> -	return -ENOEXEC;
> +	return _kexec_kernel_image_probe(image, buf, buf_len);
> +}
> +
> +void *_kexec_kernel_image_load(struct kimage *image)
> +{
> +	if (!image->fops || !image->fops->load)
> +		return ERR_PTR(-ENOEXEC);
> +
> +	return image->fops->load(image, image->kernel_buf,
> +				 image->kernel_buf_len, image->initrd_buf,
> +				 image->initrd_buf_len, image->cmdline_buf,
> +				 image->cmdline_buf_len);
>  }
> 
>  void * __weak arch_kexec_kernel_image_load(struct kimage *image)
>  {
> -	return ERR_PTR(-ENOEXEC);
> +	return _kexec_kernel_image_load(image);
> +}
> +
> +int _kimage_file_post_load_cleanup(struct kimage *image)
> +{
> +	if (!image->fops || !image->fops->cleanup)
> +		return 0;
> +
> +	return image->fops->cleanup(image->image_loader_data);
>  }
> 
>  int __weak arch_kimage_file_post_load_cleanup(struct kimage *image)
>  {
> -	return -EINVAL;
> +	return _kimage_file_post_load_cleanup(image);
>  }
> 
>  #ifdef CONFIG_KEXEC_VERIFY_SIG
> +int _kexec_kernel_verify_sig(struct kimage *image, void *buf,
> +			    unsigned long buf_len)
> +{
> +	if (!image->fops || !image->fops->verify_sig) {
> +		pr_debug("kernel loader does not support signature verification.\n");
> +		return -EKEYREJECTED;
> +	}
> +
> +	return image->fops->verify_sig(buf, buf_len);
> +}
> +
>  int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>  					unsigned long buf_len)
>  {
> -	return -EKEYREJECTED;
> +	return _kexec_kernel_verify_sig(image, buf, buf_len);
>  }
>  #endif
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
