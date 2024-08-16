Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B48C531DC
	for <kexec@archiver.kernel.org>; Fri, 16 Aug 2024 07:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UOuT1PmUJEyxQIqYy4uNu+ZosLYyHvHf6N3CaXPqioc=; b=AByV9IMjbvaI2v
	UfCJPe/CRCX3r3Xdpx90QekKDYXANF0MxYYtkr+JnCya4wKHz/XN4dUsXAmVGFJ3JJhb6jR99RwL2
	lfjH57UXIMuTVthWPof7v0sZiJxZmi34jYMWtDf7VCKmHuBMAYaiO2ro/yxxfTWZN2hzixUT6Ee0p
	mg6NkuC6XCcPq77+om+XB0PGwpXW5bFBX0fBgUK0t/SeeJ7X+peWB0BLkYHduWxB1IIeX2WIu5aRm
	gqyGOZEauzRicC/poixnw7zviC5UwVOHdA3/pDyOWXUfPyVGQjA9FQb1Pg3UkyjEd7R/yOh6XRPEi
	I0B+T1j3FoLpHKWLXFLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ser8v-0000000C3Dc-3aLq;
	Fri, 16 Aug 2024 07:13:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ser8s-0000000C3Au-2x3t
	for kexec@lists.infradead.org;
	Fri, 16 Aug 2024 07:13:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723792376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vBq7aYZZS57mYSej0WqgMxXgRDCvCAbACBmMzM3dZj8=;
	b=WldcU6uTZbdxOVVLAWZ87KIEpNoSUG2PA7uHFEzC3SHZoB4yiK6HfD/k3Ti1mDsAAxu9iU
	ndZdYL6DMGsgH2wX0s2viTNW6GFw1+7/G7kJcj8haDDWr6uHf65U4KIcBRnP1Mq5rMzoE6
	p0G+TIfJhKjBy/rYOqVSix4dZ6b2nOs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-tdPrMVXhPxSuZDkm0UB6fg-1; Fri,
 16 Aug 2024 03:12:47 -0400
X-MC-Unique: tdPrMVXhPxSuZDkm0UB6fg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E7AF1954B11;
	Fri, 16 Aug 2024 07:12:45 +0000 (UTC)
Received: from localhost (unknown [10.72.112.51])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63C9C19560A3;
	Fri, 16 Aug 2024 07:12:42 +0000 (UTC)
Date: Fri, 16 Aug 2024 15:12:38 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Tesarik <petr.tesarik@suse.com>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Eric DeVolder <eric.devolder@oracle.com>,
	"open list:KEXEC" <kexec@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	Petr Tesarik <ptesarik@suse.com>, stable@kernel.org
Subject: Re: [PATCH 1/1] kexec_file: fix elfcorehdr digest exclusion when
 CONFIG_CRASH_HOTPLUG=y
Message-ID: <Zr775rzbuVP6AwMu@MiWiFi-R3L-srv>
References: <20240805150750.170739-1-petr.tesarik@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240805150750.170739-1-petr.tesarik@suse.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240816_001258_832374_D3C90FA4 
X-CRM114-Status: GOOD (  17.20  )
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

Hi Andrew,

On 08/05/24 at 05:07pm, Petr Tesarik wrote:
> From: Petr Tesarik <ptesarik@suse.com>
> 
> Fix the condition to exclude the elfcorehdr segment from the SHA digest
> calculation.
> 
> The j iterator is an index into the output sha_regions[] array, not into
> the input image->segment[] array. Once it reaches image->elfcorehdr_index,
> all subsequent segments are excluded. Besides, if the purgatory segment
> precedes the elfcorehdr segment, the elfcorehdr may be wrongly included in
> the calculation.

Ping.

This is a good fix, could you pick this one into your tree?

Thanks
Baoquan

> 
> Fixes: f7cc804a9fd4 ("kexec: exclude elfcorehdr from the segment digest")
> Cc: stable@kernel.org
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---
>  kernel/kexec_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 3d64290d24c9..3eedb8c226ad 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -752,7 +752,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  
>  #ifdef CONFIG_CRASH_HOTPLUG
>  		/* Exclude elfcorehdr segment to allow future changes via hotplug */
> -		if (j == image->elfcorehdr_index)
> +		if (i == image->elfcorehdr_index)
>  			continue;
>  #endif
>  
> -- 
> 2.45.2
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
