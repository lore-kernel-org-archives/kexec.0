Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBFBC001DE
	for <kexec@archiver.kernel.org>; Wed, 26 Jul 2023 05:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TyCoNmgFyjOAElEhL5y7qPrRLfKuHv45zVccEnoHFgY=; b=LnFzZbB0OB5pmB
	DPDe3IZxOG/dMijk5HMfQWR04UCOA5clcUHthnKbzlJr2LcmiN1C5TNNndkaJk2XN//eV5Ohc6saF
	jom894HQ9+d04Rmr3CIVp3wIW6gWgEZUdQDsGcnQiSILWVZDhGqudJGYkkZQ9JK2oPzTd0p0t+ROM
	0/S/Dbmk9TvSZp2piQVY+UxT6ToK57aomy3PtG6sEz+uTTNIR+MqgIwLGAegHlvmKsGIJrX9EJNNP
	gShdHYR8Yi89su7bJpoJ9OyZtR45RO5KmF7j1t8sWjP9UW1Ha6/g6tvvPUmWELh4RTlyMuvdsb6ft
	+yzsYyL9yndkQWQZ9kSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOXVt-009EoW-2S;
	Wed, 26 Jul 2023 05:56:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOXVq-009Emw-2m
	for kexec@lists.infradead.org;
	Wed, 26 Jul 2023 05:56:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690350998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cCdtovwVGt1zGQDulnNlAkJ36m7TNP783WWClrPi0Zk=;
	b=UFGvau/0GEwfHptkPxQQRx8kP5sKmweNAVm54Twkg5c02SSOzgdNWeWRkEf5pE39UZrNCB
	ZzkXnkqBle5G+H+RzjMCwG0m5w881lvCt2+yA4dwOQL79L+pNmjlSrMnthUy0cRVds9o+w
	6ZnLpnoaQmyKgL847oI2Esgac3n2sZw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-680-95vf44wnPFeaXlb7Y-rxNw-1; Wed, 26 Jul 2023 01:56:34 -0400
X-MC-Unique: 95vf44wnPFeaXlb7Y-rxNw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85523830EFC;
	Wed, 26 Jul 2023 05:56:33 +0000 (UTC)
Received: from localhost (ovpn-12-99.pek2.redhat.com [10.72.12.99])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D183246A3A7;
	Wed, 26 Jul 2023 05:56:32 +0000 (UTC)
Date: Wed, 26 Jul 2023 13:56:29 +0800
From: Baoquan He <bhe@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Matthew Wilcox <willy@infradead.org>, Vivek Goyal <vgoyal@redhat.com>,
	akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] proc/vmcore: fix signedness bug in read_from_oldmem()
Message-ID: <ZMC1jU7ywPGt1QmO@MiWiFi-R3L-srv>
References: <b55f7eed-1c65-4adc-95d1-6c7c65a54a6e@moroto.mountain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b55f7eed-1c65-4adc-95d1-6c7c65a54a6e@moroto.mountain>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230725_225643_009330_2C2AC387 
X-CRM114-Status: GOOD (  18.52  )
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

Hi Dan,

On 07/25/23 at 08:03pm, Dan Carpenter wrote:
> The bug is the error handling:
> 
> 	if (tmp < nr_bytes) {
> 
> "tmp" can hold negative error codes but because "nr_bytes" is type
> size_t the negative error codes are treated as very high positive
> values (success).  Fix this by changing "nr_bytes" to type ssize_t.  The
> "nr_bytes" variable is used to store values between 1 and PAGE_SIZE and
> they can fit in ssize_t without any issue.
> 
> Fixes: 5d8de293c224 ("vmcore: convert copy_oldmem_page() to take an iov_iter")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  fs/proc/vmcore.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index cb80a7703d58..1fb213f379a5 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -132,7 +132,7 @@ ssize_t read_from_oldmem(struct iov_iter *iter, size_t count,
>  			 u64 *ppos, bool encrypted)
>  {
>  	unsigned long pfn, offset;
> -	size_t nr_bytes;
> +	ssize_t nr_bytes;
>  	ssize_t read = 0, tmp;
>  	int idx;

Thanks for this fix. Just curious, this is found out by code exploring,
or any breaking?

Acked-by: Baoquan He <bhe@redhat.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
