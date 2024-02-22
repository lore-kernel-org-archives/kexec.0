Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE05C48BF8
	for <kexec@archiver.kernel.org>; Thu, 22 Feb 2024 07:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wp0rq480TR3z5wtmh/KBPF5U6q3XWK6orkFkl675Ii0=; b=ZqA71vrLrddtd0
	tHRSXrQkqD4MCJ4Bps+ehqpbGrE8XMVomAQgXI9Z9KxN882vlmSY2f3XLjacX6CBCOiyDVu1frLaW
	KB1r9k29GLC5ZxzHnzH40AKvPzYd/8RBJRky7sw3o9HDfQ/2izeh9p3/pPWAU9gUVRhTk5p90V2ci
	kWUmq7/4PgPazULBIzAs3Qvwyk6XamMv3RRTj7+2C8xHCtq2JS2WZ3LkgJVvIQkvJlXeWZbdlk25/
	l/r/U6p1kCn7jFSRPN7oRX+NwVSzwPVZ0TqjZL786VtruyY9o/HsgBD2lLC1wxn36XK8NVKb6r38i
	XRycsoah0GETu2QCQtsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3mH-00000003rTI-2CFY;
	Thu, 22 Feb 2024 07:45:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3mF-00000003rSF-3CQE
	for kexec@lists.infradead.org;
	Thu, 22 Feb 2024 07:45:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708587954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CWJNOewjkbYW7x9RFz6EQgzz3x0akjI564V6xJTycn4=;
	b=J8nqZ5UO9m5Mab1l1rRARXUSg/nWh+nyJh6psJfDS2pHTneUNK1YLPusJEKBqGLM5Q0dSI
	khth4Jb1xlWG+PPaxE8F27sMUFgTocP7NpWYbKU3I9IF+U+hKP5hoEPZxLaEl1fEBAPp4k
	IvcmoL91OM3C9d2aPmiLIX5ZSiPr/m0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-BpkYVYw7PvSVZX4hEb9qVw-1; Thu, 22 Feb 2024 02:45:48 -0500
X-MC-Unique: BpkYVYw7PvSVZX4hEb9qVw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43DE11021F64;
	Thu, 22 Feb 2024 07:45:48 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 38A011121337;
	Thu, 22 Feb 2024 07:45:27 +0000 (UTC)
Date: Thu, 22 Feb 2024 15:45:38 +0800
From: Baoquan He <bhe@redhat.com>
To: "yang.zhang" <gaoshanliukou@163.com>
Cc: ebiederm@xmission.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	"yang.zhang" <yang.zhang@hexintek.com>
Subject: Re: [PATCH v2] kexec: copy only happens before uchunk goes to zero
Message-ID: <Zdb7ogmu/7IOBN3U@MiWiFi-R3L-srv>
References: <20240220021106.694-1-gaoshanliukou@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240220021106.694-1-gaoshanliukou@163.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_234555_906885_485848A8 
X-CRM114-Status: GOOD (  18.53  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 02/20/24 at 10:11am, yang.zhang wrote:
> From: "yang.zhang" <yang.zhang@hexintek.com>
> 
> When load segments, all of the copying and the rest
> only happens before uchunk goes to zero.

The code change looks good, while the log can be improved with more
details so that people can more easily get what's wrong and fixed.

===
When loading segments, ubytes is <= mbytes. When ubytes is exhausted,
there could be remaining mbytes. Then in the while loop, the buf pointer
advancing with mchunk will causing meaningless reading even though it
doesn't harm. 

So let's change to make sure that all of the copying and the rest only
happens before uchunk goes to zero.
===

Please take above words as reference to udpate patch log and post v3,
and you can add:

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: yang.zhang <yang.zhang@hexintek.com>
> 
> ---
> v1 -> v2:
> - Only copy before uchunk goes to zero
> 
> V1: https://lore.kernel.org/lkml/20240130101802.23850-1-gaoshanliukou@163.com/
> ---
>  kernel/kexec_core.c | 44 ++++++++++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index d08fc7b5db97..2fc3d0e3715a 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -800,22 +800,24 @@ static int kimage_load_normal_segment(struct kimage *image,
>  				PAGE_SIZE - (maddr & ~PAGE_MASK));
>  		uchunk = min(ubytes, mchunk);
>  
> -		/* For file based kexec, source pages are in kernel memory */
> -		if (image->file_mode)
> -			memcpy(ptr, kbuf, uchunk);
> -		else
> -			result = copy_from_user(ptr, buf, uchunk);
> +		if (uchunk) {
> +			/* For file based kexec, source pages are in kernel memory */
> +			if (image->file_mode)
> +				memcpy(ptr, kbuf, uchunk);
> +			else
> +				result = copy_from_user(ptr, buf, uchunk);
> +			ubytes -= uchunk;
> +			if (image->file_mode)
> +				kbuf += uchunk;
> +			else
> +				buf += uchunk;
> +		}
>  		kunmap_local(ptr);
>  		if (result) {
>  			result = -EFAULT;
>  			goto out;
>  		}
> -		ubytes -= uchunk;
>  		maddr  += mchunk;
> -		if (image->file_mode)
> -			kbuf += mchunk;
> -		else
> -			buf += mchunk;
>  		mbytes -= mchunk;
>  
>  		cond_resched();
> @@ -866,11 +868,18 @@ static int kimage_load_crash_segment(struct kimage *image,
>  			memset(ptr + uchunk, 0, mchunk - uchunk);
>  		}
>  
> -		/* For file based kexec, source pages are in kernel memory */
> -		if (image->file_mode)
> -			memcpy(ptr, kbuf, uchunk);
> -		else
> -			result = copy_from_user(ptr, buf, uchunk);
> +		if (uchunk) {
> +			/* For file based kexec, source pages are in kernel memory */
> +			if (image->file_mode)
> +				memcpy(ptr, kbuf, uchunk);
> +			else
> +				result = copy_from_user(ptr, buf, uchunk);
> +			ubytes -= uchunk;
> +			if (image->file_mode)
> +				kbuf += uchunk;
> +			else
> +				buf += uchunk;
> +		}
>  		kexec_flush_icache_page(page);
>  		kunmap_local(ptr);
>  		arch_kexec_pre_free_pages(page_address(page), 1);
> @@ -878,12 +887,7 @@ static int kimage_load_crash_segment(struct kimage *image,
>  			result = -EFAULT;
>  			goto out;
>  		}
> -		ubytes -= uchunk;
>  		maddr  += mchunk;
> -		if (image->file_mode)
> -			kbuf += mchunk;
> -		else
> -			buf += mchunk;
>  		mbytes -= mchunk;
>  
>  		cond_resched();
> -- 
> 2.25.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
