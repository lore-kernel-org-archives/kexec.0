Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F307C46CD2
	for <kexec@archiver.kernel.org>; Tue,  9 Jan 2024 03:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OC2wz0yitXq/qlCqJRaDjL/GwRWn+3Z8qwZI8Ii+HTU=; b=o+Pj/X/GNvj4A5
	z2lMMXt8Zuz8eWSOC4VpZl+e2schZKD6ZRW8V8K4Zj6Au+EIKITl6eJzUANZK1XLY2X7MgwIUho8M
	wWyMlKwYg9neA+kMvv40vMYNEe3LkDGjj4fvVrOTIdeXdLKpmcH3t9AVfNbigWpqdqgViJQUEg+uu
	p+NYb37uF3dayNrM0+7dH/m23xo0aUWnMlPiZ1ZyKC2dX/Evp+8T6caedFmnTktIMK9JSSkqgvBFj
	COfhu2wZsw4YkbYwiMB4Sd+IN3YFVw69y6+dfCgUMuNjQWwuZzGTqYJjyONekc1ySv0lp7cJRf0c2
	0x/jnejR+cyW6I9Uzaxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rN34O-006oxE-0x;
	Tue, 09 Jan 2024 03:46:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rN34M-006owg-12
	for kexec@lists.infradead.org;
	Tue, 09 Jan 2024 03:46:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704771984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+YYuPB0UP8nrf3dr6Uqp0ctj7evXBLUo2P/GyLhOgRg=;
	b=gtV0EstGJ6C07KwQMvW4LP5VUp5HjhH/aFkSp4Ar+8fJkiJ1v4RUA+cEB06t0OToYWZ3mW
	RFgVcaSOjS5p8o3me/CG/xJWzJBUmOYnRFCwXlI50SLggKPDK/fBo+iat/Jok+AqnU6fQW
	F3G5RpOOU8CFff50eMobaidDTe7k+3o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-5-cXVQ9DPoad6f18TBIeuw-1; Mon,
 08 Jan 2024 22:46:20 -0500
X-MC-Unique: 5-cXVQ9DPoad6f18TBIeuw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0833C3C0F689;
	Tue,  9 Jan 2024 03:46:20 +0000 (UTC)
Received: from localhost (unknown [10.72.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CFC51121337;
	Tue,  9 Jan 2024 03:46:12 +0000 (UTC)
Date: Tue, 9 Jan 2024 11:46:15 +0800
From: Baoquan He <bhe@redhat.com>
To: fuqiang wang <fuqiang.wang@easystack.cn>
Cc: akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] x86/kexec: fix potential cmem->ranges out of bounds
Message-ID: <ZZzBhy5bLj0JuZZw@MiWiFi-R3L-srv>
References: <20240108130720.228478-1-fuqiang.wang@easystack.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240108130720.228478-1-fuqiang.wang@easystack.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240108_194626_429746_F3FE7AC6 
X-CRM114-Status: GOOD (  23.65  )
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

On 01/08/24 at 09:06pm, fuqiang wang wrote:
> In memmap_exclude_ranges(), elfheader will be excluded from crashk_res.
> In the current x86 architecture code, the elfheader is always allocated
> at crashk_res.start. It seems that there won't be a new split range.
> But it depends on the allocation position of elfheader in crashk_res. To
> avoid potential out of bounds in future, add a extra slot.
> 
> The similar issue also exists in fill_up_crash_elf_data(). The range to
> be excluded is [0, 1M], start (0) is special and will not appear in the
> middle of existing cmem->ranges[]. But in cast the low 1M could be
> changed in the future, add a extra slot too.
> 
> Previously discussed link:
> [1] https://lore.kernel.org/kexec/ZXk2oBf%2FT1Ul6o0c@MiWiFi-R3L-srv/
> [2] https://lore.kernel.org/kexec/273284e8-7680-4f5f-8065-c5d780987e59@easystack.cn/
> [3] https://lore.kernel.org/kexec/ZYQ6O%2F57sHAPxTHm@MiWiFi-R3L-srv/
> 
> Signed-off-by: fuqiang wang <fuqiang.wang@easystack.cn>
> ---
>  arch/x86/kernel/crash.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index b6b044356f1b..d21592ad8952 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -149,8 +149,18 @@ static struct crash_mem *fill_up_crash_elf_data(void)
>  	/*
>  	 * Exclusion of crash region and/or crashk_low_res may cause
>  	 * another range split. So add extra two slots here.
> +	 *
> +	 * Exclusion of low 1M may not cause another range split, because the
> +	 * range of exclude is [0, 1M] and the condition for splitting a new
> +	 * region is that the start, end parameters are both in a certain
> +	 * existing region in cmem and cannot be equal to existing region's
> +	 * start or end. Obviously, the start of [0, 1M] cannot meet this
> +	 * condition.
> +	 *
> +	 * But in order to lest the low 1M could be changed in the future,
> +	 * (e.g. [stare, 1M]), add a extra slot.
>  	 */
> -	nr_ranges += 2;
> +	nr_ranges += 3;
>  	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
>  	if (!cmem)
>  		return NULL;
> @@ -282,9 +292,16 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>  	struct crash_memmap_data cmd;
>  	struct crash_mem *cmem;
>  
> -	cmem = vzalloc(struct_size(cmem, ranges, 1));
> +	/*
> +	 * In the current x86 architecture code, the elfheader is always
> +	 * allocated at crashk_res.start. But it depends on the allocation
> +	 * position of elfheader in crashk_res. To avoid potential out of
> +	 * bounds in future, add a extra slot.
> +	 */
> +	cmem = vzalloc(struct_size(cmem, ranges, 2));
>  	if (!cmem)
>  		return -ENOMEM;
> +	cmem->max_nr_ranges = 2;

LGTM, thx

Acked-by: Baoquan He <bhe@redhat.com>

>  
>  	memset(&cmd, 0, sizeof(struct crash_memmap_data));
>  	cmd.params = params;
> -- 
> 2.42.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
