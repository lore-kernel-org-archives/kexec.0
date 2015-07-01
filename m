Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZAJBz-000852-Uu
 for kexec@lists.infradead.org; Wed, 01 Jul 2015 14:40:52 +0000
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Wed, 1 Jul 2015 15:40:27 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id D75B717D8069
 for <kexec@lists.infradead.org>; Wed,  1 Jul 2015 15:41:39 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t61EeRni31654138
 for <kexec@lists.infradead.org>; Wed, 1 Jul 2015 14:40:27 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t61EePUR001556
 for <kexec@lists.infradead.org>; Wed, 1 Jul 2015 08:40:26 -0600
Date: Wed, 1 Jul 2015 16:40:23 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] kexec: Make a pair of map and unmap reserved pages
 when kdump fails to start
Message-ID: <20150701164023.011988b1@holzheu>
In-Reply-To: <1435643086-8555-1-git-send-email-mnfhuang@gmail.com>
References: <1435643086-8555-1-git-send-email-mnfhuang@gmail.com>
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

Hello Minfei,

Regarding functionality your patch looks ok for me.
But the code is not easy to read.

What about replacing the "failure" label with "fail_unmap_pages"?

Michael

On Tue, 30 Jun 2015 13:44:46 +0800
Minfei Huang <mnfhuang@gmail.com> wrote:

> For some arch, kexec shall map the reserved pages, then use them, when
> we try to start the kdump service.
> 
> Now kexec will never unmap the reserved pages, once it fails to continue
> starting the kdump service.
> 
> Make a pair of reserved pages in kdump starting path, whatever kexec
> fails or not.
> 
> Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
> ---
>  kernel/kexec.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 4589899..68f6dfb 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1291,35 +1291,37 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
>  			 */
> 
>  			kimage_free(xchg(&kexec_crash_image, NULL));
> -			result = kimage_alloc_init(&image, entry, nr_segments,
> -						   segments, flags);
> -			crash_map_reserved_pages();
> -		} else {
> -			/* Loading another kernel to reboot into. */
> -
> -			result = kimage_alloc_init(&image, entry, nr_segments,
> -						   segments, flags);
>  		}
> +
> +		result = kimage_alloc_init(&image, entry, nr_segments,
> +				segments, flags);
>  		if (result)
>  			goto out;
> 
> +		if (flags & KEXEC_ON_CRASH)
> +			crash_map_reserved_pages();
> +
>  		if (flags & KEXEC_PRESERVE_CONTEXT)
>  			image->preserve_context = 1;
>  		result = machine_kexec_prepare(image);
>  		if (result)
> -			goto out;
> +			goto failure;
> 
>  		for (i = 0; i < nr_segments; i++) {
>  			result = kimage_load_segment(image, &image->segment[i]);
>  			if (result)
> -				goto out;
> +				goto failure;
>  		}
>  		kimage_terminate(image);
> +
> +failure:
>  		if (flags & KEXEC_ON_CRASH)
>  			crash_unmap_reserved_pages();
>  	}
> -	/* Install the new kernel, and  Uninstall the old */
> -	image = xchg(dest_image, image);
> +
> +	if (result == 0)
> +		/* Install the new kernel, and  Uninstall the old */
> +		image = xchg(dest_image, image);
> 
>  out:
>  	mutex_unlock(&kexec_mutex);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
