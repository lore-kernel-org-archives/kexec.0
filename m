Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF26C4167B
	for <kexec@archiver.kernel.org>; Thu, 30 Nov 2023 07:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NbNyLSpduU/gGsH35F4XviBbsCNX/BqFSGm5C2x2GuU=; b=SiXpyZk4+i1ts4
	UG1fFZ1Spa8ayscO+eNiAWVZLZGy6BNWdgCLqJo63wLCJ6jGZke1+FH+WkhakVJ6KIWrCuHFjWX9w
	+pEMX/Sb/FJYPdxXMjSmGQnT6A4nzetUL65wy8snKyLOc6yskV2XYb8YrwmWs679+Bar+xdHWs8OK
	CW7JMJZaPk2q+NujFwRy7cZHUSRi+2OWd3lOUKMTuRxn4FASmhiFoUfGJuoQ05x2GQ5HeAa4FYSjl
	FYfCodezVGT31d9p+urtkV08xnitfnrup69wgnZEQj01YRhBoj54qGQDLM1RXe26+T2IU6EOrHiYk
	21coiC5cG9OoiSDl5+3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8bjO-00A7ve-2k;
	Thu, 30 Nov 2023 07:45:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8bjK-00A7ur-2u
	for kexec@lists.infradead.org;
	Thu, 30 Nov 2023 07:45:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701330301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kFX81jkgr22XnPLJhetZKt46F/xnkz4cCCAQykO/SFc=;
	b=htIGOMYXo625VCeRWY8aCK/78E4EhspQMeTVlDcBFdHSalkJi81ppCgLe0Ab0wcXR4FGTr
	hiKsTF3ys817g9M9j/92WI7Ths2MKP/QkEdyWyyh+FZmtEnojrIlk/6IvEvB4jviHS0ay/
	k4Dmdw1VyG2Tuy1xpo9oS7TNdrzfWa4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-AHfMViECMDaF78Bs7fn4Uw-1; Thu, 30 Nov 2023 02:44:56 -0500
X-MC-Unique: AHfMViECMDaF78Bs7fn4Uw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD3E6185A781;
	Thu, 30 Nov 2023 07:44:55 +0000 (UTC)
Received: from localhost (unknown [10.72.113.121])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D7468C1596F;
	Thu, 30 Nov 2023 07:44:44 +0000 (UTC)
Date: Thu, 30 Nov 2023 15:44:41 +0800
From: Baoquan He <bhe@redhat.com>
To: fuqiang wang <fuqiang.wang@easystack.cn>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: avoid out of bounds in crash_exclude_mem_range()
Message-ID: <ZWg9aZYoo0v+tCQ8@MiWiFi-R3L-srv>
References: <20231127025641.62210-1-fuqiang.wang@easystack.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231127025641.62210-1-fuqiang.wang@easystack.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231129_234503_013114_7B75232F 
X-CRM114-Status: GOOD (  22.63  )
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

On 11/27/23 at 10:56am, fuqiang wang wrote:
> When the split happened, judge whether mem->nr_ranges is equal to
> mem->max_nr_ranges. If it is true, return -ENOMEM.
> 
> The advantage of doing this is that it can avoid array bounds caused by
> some bugs. E.g., Before commit 4831be702b95 ("arm64/kexec: Fix missing
> extra range for crashkres_low."), reserve both high and low memories for
> the crashkernel may cause out of bounds.
> 
> On the other hand, move this code before the split to ensure that the
> array will not be changed when return error.

If out of array boundary is caused, means the laoding failed, whether
the out of boundary happened or not. I don't see how this code change
makes sense. Do I miss anything?

Thanks
Baoquan

> 
> Signed-off-by: fuqiang wang <fuqiang.wang@easystack.cn>
> ---
>  kernel/crash_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index efe87d501c8c..ffdc246cf425 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -611,6 +611,9 @@ int crash_exclude_mem_range(struct crash_mem *mem,
>  		}
>  
>  		if (p_start > start && p_end < end) {
> +			/* Split happened */
> +			if (mem->nr_ranges == mem->max_nr_ranges)
> +				return -ENOMEM;
>  			/* Split original range */
>  			mem->ranges[i].end = p_start - 1;
>  			temp_range.start = p_end + 1;
> @@ -626,9 +629,6 @@ int crash_exclude_mem_range(struct crash_mem *mem,
>  	if (!temp_range.end)
>  		return 0;
>  
> -	/* Split happened */
> -	if (i == mem->max_nr_ranges - 1)
> -		return -ENOMEM;
>  
>  	/* Location where new range should go */
>  	j = i + 1;
> -- 
> 2.42.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
