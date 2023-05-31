Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F419C77B7A
	for <kexec@archiver.kernel.org>; Wed, 31 May 2023 00:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EVvAWy+4tgAML+9z7XJRY297U933jubacF+KouIok+Y=; b=QXpinq8jxVt+qd
	7wnvlRBSNYCgpoGcDZPFCpxZt6+DwHo3/IdCbSZ638f8NQ0e0dOfxayFBP1ofPuK3F7SWNP6l3QS4
	3JxBAzkGtpwyO+LRrlx63q81TabWHr3FaWI02F9wgjxw+v/0wB6lFozjswCGzM1GPeC3vtr1zCOHT
	7AprYhBBCuF5gvqnVaMDy86k0khqQ9OavonLF8JBUp7v60dJqp39HgevBmf6ROMQvWBIjDQqhxrPQ
	INphXzJGJB5b9MVZawX/SYpmwAWF10qDDIkJ46gf5pklfh9fc6CWhQoqi3JLt3tqJARla75QCkDH0
	Wd0NQeRwHj9E+LTLm3cQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q49XN-00FaV4-1r;
	Wed, 31 May 2023 00:18:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q49XL-00FaUA-0J
	for kexec@lists.infradead.org;
	Wed, 31 May 2023 00:18:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685492277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=baSFBqUUVIrLoDCDA2ucQJhIAa+yyQWxP1bD9ZLCVTk=;
	b=EFb6Ox/p5aJSQIQtf+3Tg/B5qftYntBP0fvHO7HYtXajoOzxHyh49ol/rSTbDy+0FcCKMi
	FV5+AF57jdazJQbGkQv1bLpRYgW70SAYprPFWwHQjD70mH+DaPTo/mXjK3kZEoWjDFyyBQ
	+FOf6cp2+k+2ZyEG+9JBIJsIeYXXZSM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-NsKU-DCeN1KOYrl-AbZAIQ-1; Tue, 30 May 2023 20:17:56 -0400
X-MC-Unique: NsKU-DCeN1KOYrl-AbZAIQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECA7C1C05B04;
	Wed, 31 May 2023 00:17:55 +0000 (UTC)
Received: from localhost (ovpn-12-54.pek2.redhat.com [10.72.12.54])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EE9D3492B0A;
	Wed, 31 May 2023 00:17:54 +0000 (UTC)
Date: Wed, 31 May 2023 08:17:51 +0800
From: Baoquan He <bhe@redhat.com>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michael Holzheu <holzheu@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/6] kexec: delete a useless check in
 crash_shrink_memory()
Message-ID: <ZHaSF4EGNwSGhGAL@MiWiFi-R3L-srv>
References: <20230527123439.772-1-thunder.leizhen@huawei.com>
 <20230527123439.772-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230527123439.772-3-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_171759_210054_9290F47A 
X-CRM114-Status: GOOD (  20.09  )
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
> The check '(crashk_res.parent != NULL)' is added by
> commit e05bd3367bd3 ("kexec: fix Oops in crash_shrink_memory()"), but it's
> stale now. Because if 'crashk_res' is not reserved, it will be zero in
> size and will be intercepted by the above 'if (new_size >= old_size)'.
> 
> Ago:
> 	if (new_size >= end - start + 1)
> 
> Now:
> 	old_size = (end == 0) ? 0 : end - start + 1;
> 	if (new_size >= old_size)

Hmm, I would strongly suggest we keep that check. Even though the
current code like above can do the acutal checking, but its actual usage
is not obvious for checking of crashk_res existence. In the future,
someone may change above calculation and don't notice the hidden
functionality at all behind the calculation. The cost of the check is
almost zero, right?

> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  kernel/kexec_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 22acee18195a591..d1ab139dd49035e 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1137,7 +1137,7 @@ int crash_shrink_memory(unsigned long new_size)
>  	end = start + new_size;
>  	crash_free_reserved_phys_range(end, crashk_res.end);
>  
> -	if ((start == end) && (crashk_res.parent != NULL))
> +	if (start == end)
>  		release_resource(&crashk_res);
>  
>  	ram_res->start = end;
> -- 
> 2.25.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
