Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91E6C41535
	for <kexec@archiver.kernel.org>; Fri, 22 Dec 2023 13:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/F4OCuvtojB1DB1H6NW38Bajo6p/QzIIKNy5QSJRnm4=; b=cfAW26hE2VveB/
	jH8+ku2wY76oSTbATyE0gUm21XscI0gCRCbu+LGdAgiXFRshXKoZsxJhIg1NAIaFVQ0adJdMEnFUB
	/EMeWN3gyf+BXNReZaG3gSp/Se529Zf36zy71Wn7Ado/yEDKKvyMwA6WuCXBwl1mOVENCxqw3Xa0k
	AOSBcV/UB2MTizuoDfE6i5XBQYOwvzZlTCkS4C9qkOy0xAE2uyLxnGqeBg8zFgvknY74a9lPWZirv
	HqcKJa6mxGHb4OM7lVO+xWeWNl73+JGD7tPf9PKvko8Ro/kgIXagtGRANH0imK56jqwL9ErUWn4om
	Mv787Zs10QJ3DI6DeRCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGfaU-00621Z-2z;
	Fri, 22 Dec 2023 13:29:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGfaR-0061zw-2f
	for kexec@lists.infradead.org;
	Fri, 22 Dec 2023 13:29:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703251750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1AKVs7FXg/jWbWMuTLae6aE+SqB8wGNXZoXLlyCDH7c=;
	b=ARrdx0k3d09Ba86oflONlmxgAr9nnasS/uCYvF6RFECeCbABTjowpF3sOzc+d1rM9SAplu
	a0erlErS3TJMg0TOKXud+JWlFSYnEYY54J//nF942dWZhKnDuUGT0uUnR/5PXpMXJe1XNr
	pRQofaX8uQhF2oneisrmvRZVWFq+qgU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-3J-sf6PDOOaljrRLbWYWug-1; Fri, 22 Dec 2023 08:29:06 -0500
X-MC-Unique: 3J-sf6PDOOaljrRLbWYWug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 807558489A8;
	Fri, 22 Dec 2023 13:29:06 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AA44FC15968;
	Fri, 22 Dec 2023 13:29:04 +0000 (UTC)
Date: Fri, 22 Dec 2023 21:29:01 +0800
From: Baoquan He <bhe@redhat.com>
To: fuqiang wang <fuqiang.wang@easystack.cn>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86/kexec: fix potential cmem->ranges out of bounds
Message-ID: <ZYWPHSmwK8iG6xUr@MiWiFi-R3L-srv>
References: <20231222121855.148215-1-fuqiang.wang@easystack.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231222121855.148215-1-fuqiang.wang@easystack.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231222_052911_935171_CE0170B1 
X-CRM114-Status: GOOD (  24.39  )
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

On 12/22/23 at 08:18pm, fuqiang wang wrote:
> In memmap_exclude_ranges(), there will exclude elfheader from
                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      elfheader will be excluded from crashk_res. OR
      it will exclude elfheader from crashk_res.

> crashk_res. In the current x86 architecture code, the elfheader is
> always allocated at crashk_res.start. It seems that there won't be a
> split a new range. But it depends on the allocation position of
 ~~~~~~~~~~~~~~~~~~
  It seems that there won't be a new split range.
> elfheader in crashk_res. To avoid potential out of bounds in future, add
> a extra slot.
> 
> The similar issue also exists in fill_up_crash_elf_data(). The range to
> be excluded is [0, 1M], start (0) is special and will not appear in the
> middle of existing cmem->ranges[]. But in order to lest the low 1M could
                                         ~~~~~~~~~~~~~~~~
                                          in case
> be changed in the future, add a extra slot too.
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
> index c92d88680dbf..97d33a6fc4fb 100644
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

Sometime, too much is as bad as too little. I feel below words are
enough to state three regions are gonna be excluded, and may cause
another split (may not cause). The code comment plus commit log can help
people know why they are needed.

  	 * Exclusion of low1M, crashk_res and/or crashk_low_res may cause
  	 * another range split. So add extra three slots here.

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

Ditto.

 +	/*
 +	 * Elfheader gonna be excluded from crashk_res, to avoid potential
 +	 * out of bounds, add one extra slot.
 +	 */

> +	cmem = vzalloc(struct_size(cmem, ranges, 2));
>  	if (!cmem)
>  		return -ENOMEM;
> +	cmem->max_nr_ranges = 2;
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
