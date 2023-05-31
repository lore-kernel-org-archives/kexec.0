Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DC2C7EE23
	for <kexec@archiver.kernel.org>; Wed, 31 May 2023 00:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1wnyFocbr55cHss2BHZIb1qEPGO2bkrYD40YgWkYLH0=; b=CuESZ03Jmu1ict
	fo37xxdN8nB3qnrNsWAcBAesKZwCADBC8TDLoZ4yRB9I5s9uGRUTCP7D/OG62k95BI3pwQSUozyl8
	MJXrt+i5JwpWM6P4XeAXDMKy6MKbtdeuhREtIDNo3psOp5OWZF5VFXt/nR1BrvFAshEUSUk3dnEeQ
	lmbAlGe13WpjwUCEIf1vMenA6ZR9AZspUrv2hY10HT0yrbsfu0f1/DOUBbUx5wKc2jw5udn2fySz0
	+qLJLrSQ0TR1LwEnXRYQg39PmwTQ6qqUXP/6NxsPeSYIGaAhz8zMvZr0bKRAW94q42DRuoCS8TmAS
	HiWFRDbM5Gq+FItgAQxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q49mg-00FcQL-07;
	Wed, 31 May 2023 00:33:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q49md-00FcOj-1m
	for kexec@lists.infradead.org;
	Wed, 31 May 2023 00:33:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685493224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v9DIsXmdxClvcSIg28Mmd8pgsPz6Obkd4iWTsPHZoEc=;
	b=QIMXxubgQiePi6IutV61nDP0VuYcTB8Dbr08fn9xFqjc94F9c9X8EAphV2WI6++Bhn6aLq
	EGSgakaQdy/It4+dJPBmOQjaggbi2kEdEHh+CwQ4HPdxnmZRHF8L698ZuxGploVaoOftow
	Z0QDLTbN4XZ2TH/4fIXgGSs0+Xegq3w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-KrBGifksNNmvdSLxs9mF8g-1; Tue, 30 May 2023 20:33:40 -0400
X-MC-Unique: KrBGifksNNmvdSLxs9mF8g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D54629DD988;
	Wed, 31 May 2023 00:33:40 +0000 (UTC)
Received: from localhost (ovpn-12-54.pek2.redhat.com [10.72.12.54])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 64F8A112132C;
	Wed, 31 May 2023 00:33:39 +0000 (UTC)
Date: Wed, 31 May 2023 08:33:34 +0800
From: Baoquan He <bhe@redhat.com>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michael Holzheu <holzheu@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/6] kexec: clear crashk_res if all its memory has been
 released
Message-ID: <ZHaVuJrlYhIlpkFE@MiWiFi-R3L-srv>
References: <20230527123439.772-1-thunder.leizhen@huawei.com>
 <20230527123439.772-4-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230527123439.772-4-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_173347_659306_BCFA2467 
X-CRM114-Status: GOOD (  19.07  )
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

On 05/27/23 at 08:34pm, Zhen Lei wrote:
> If the resource of crashk_res has been released, it is better to clear
> crashk_res.start and crashk_res.end. Because 'end = start - 1' is not
> reasonable, and in some places the test is based on crashk_res.end, not
> resource_size(&crashk_res).

This looks reasonable, at least I haven't think of any risk it could
bring. Thanks.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  kernel/kexec_core.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index d1ab139dd49035e..bcc86a250ab3bf9 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1137,15 +1137,18 @@ int crash_shrink_memory(unsigned long new_size)
>  	end = start + new_size;
>  	crash_free_reserved_phys_range(end, crashk_res.end);
>  
> -	if (start == end)
> -		release_resource(&crashk_res);
> -
>  	ram_res->start = end;
>  	ram_res->end = crashk_res.end;
>  	ram_res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
>  	ram_res->name = "System RAM";
>  
> -	crashk_res.end = end - 1;
> +	if (start == end) {
> +		release_resource(&crashk_res);
> +		crashk_res.start = 0;
> +		crashk_res.end = 0;
> +	} else {
> +		crashk_res.end = end - 1;
> +	}
>  
>  	insert_resource(&iomem_resource, ram_res);
>  
> -- 
> 2.25.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
