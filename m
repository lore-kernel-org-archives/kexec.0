Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aZTBL-0001bd-6Z
 for kexec@lists.infradead.org; Sat, 27 Feb 2016 00:56:27 +0000
Date: Fri, 26 Feb 2016 16:56:05 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kexec: Make a pair of map/unmap reserved pages in error
 path
Message-Id: <20160226165605.efc4bc6fe3e90faccff79fd9@linux-foundation.org>
In-Reply-To: <1456408960-12296-1-git-send-email-mhuang@redhat.com>
References: <1456408960-12296-1-git-send-email-mhuang@redhat.com>
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
To: Minfei Huang <mhuang@redhat.com>
Cc: Minfei Huang <mnfhuang@gmail.com>, kexec@lists.infradead.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org

On Thu, 25 Feb 2016 22:02:40 +0800 Minfei Huang <mhuang@redhat.com> wrote:

> From: Minfei Huang <mnfhuang@gmail.com>
> 
> For some arch, kexec shall map the reserved pages, then use them, when
> we try to start the kdump service.
> 
> kexec may return directly, without unmaping the reserved pages, if it
> fails during starting service. To fix it, we make a pair of map/unmap
> reserved pages both in generic path and error path.

This patch both refactors the code AND fixes the bug.  It is a
decent-looking refactoring, but mixing the two together makes it *much*
harder to review the bugfix.  These two steps should be separated
please, with the bugfix patch coming first.

> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -103,6 +103,68 @@ out_free_image:
>  	return ret;
>  }
>  
> +static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> +		struct kexec_segment __user *segments, unsigned long flags)
> +{
> +	struct kimage **dest_image, *image;
> +	unsigned long i;
> +	int ret;
> +
> +	if (flags & KEXEC_ON_CRASH)
> +		dest_image = &kexec_crash_image;
> +	else
> +		dest_image = &kexec_image;
> +
> +	if (nr_segments == 0) {
> +		/* Uninstall image */
> +		kimage_free(xchg(dest_image, NULL));
> +		return 0;
> +	}
> +	if (flags & KEXEC_ON_CRASH) {
> +		/*
> +		 * Loading another kernel to switch to if this one
> +		 * crashes.  Free any current crash dump kernel before
> +		 * we corrupt it.
> +		 */
> +		kimage_free(xchg(&kexec_crash_image, NULL));
> +	}
> +
> +	ret = kimage_alloc_init(&image, entry, nr_segments, segments, flags);
> +	if (ret)
> +		return ret;

This is a bug, isn't it?  Missed kimage_free().

> +	if (flags & KEXEC_ON_CRASH)
> +		crash_map_reserved_pages();
> +
> +	if (flags & KEXEC_PRESERVE_CONTEXT)
> +		image->preserve_context = 1;
> +
> +	ret = machine_kexec_prepare(image);
> +	if (ret)
> +		goto out;
> +
> +	for (i = 0; i < nr_segments; i++) {
> +		ret = kimage_load_segment(image, &image->segment[i]);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	kimage_terminate(image);
> +
> +	/* Install the new kernel and uninstall the old */
> +	image = xchg(dest_image, image);
> +
> +out:
> +	/*
> +	 * Once the reserved memory is mapped, we should unmap this memory
> +	 * before returning
> +	 */
> +	if (flags & KEXEC_ON_CRASH)
> +		crash_unmap_reserved_pages();
> +	kimage_free(image);
> +	return ret;
> +}
> +
>
> ...
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
