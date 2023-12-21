Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C79C35274
	for <kexec@archiver.kernel.org>; Thu, 21 Dec 2023 13:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5rXGFx+Moo7bmDiYh0q2emqbX1Fr1XKyNC7BAuHHYyw=; b=Z1SQ2rUYAGlUX0
	acFkbxmht3tPl121cnul2WdQ2Cc7sXMlZHKGaI4WWbLazfaL1kJf8o+T/g9rMK73mcbFBX6bHEiUJ
	NHdbCjAU9rqUOcBaxXzs1Oa+yByqnKI1QfPPeqoIXMIQfY7oCjBA5bjjMfvns/Tmjo1USGtfttGCW
	bR80Oobxq/FnzrVAumZ93BtZNROBrJknqKG0pyFkaiYFWFJ4peGwMnSx5Rg98euU+BktB4mw6nFgn
	zG1hHE9SC/sPMz0R4xg84dAenr60cwJHPC3ZNdIQFjjQ99Crm5vTZ1ET1OxWHeGOseAjnCtX5L8Zd
	ne9FDWsZvnogrDuROWpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGIsy-002ucA-2u;
	Thu, 21 Dec 2023 13:14:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGIsw-002ubn-1s
	for kexec@lists.infradead.org;
	Thu, 21 Dec 2023 13:14:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703164485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1eNoYJka76W6z/XIQNg+OgUP1x/5sVSGmIF7sB3PyIM=;
	b=H/FcolORCuVhS2HJ1O/k5i0o78ZXGdNSLsUzCJBuDrxPSGe9zSbLSQ8rdtZ7/imGmikIS6
	x+kgUIC6DkDc6OOR9Zi0q6s/FFj4J9JYiHWHW+5Fotv27FTG+svXmY9Qo5kQNhBjiKZmlL
	cLC8gxJk2MC+qltZ6SrG5NJKCIeYI4U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-9gOrF8nDO3O1s7WKoG1OmQ-1; Thu,
 21 Dec 2023 08:14:39 -0500
X-MC-Unique: 9gOrF8nDO3O1s7WKoG1OmQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B5AD3816B4E;
	Thu, 21 Dec 2023 13:14:39 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D7ACC2166B31;
	Thu, 21 Dec 2023 13:14:38 +0000 (UTC)
Date: Thu, 21 Dec 2023 21:14:35 +0800
From: Baoquan He <bhe@redhat.com>
To: fuqiang wang <fuqiang.wang@easystack.cn>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/kexec: Fix potential out of bounds in
 crash_setup_memmap_entries()
Message-ID: <ZYQ6O/57sHAPxTHm@MiWiFi-R3L-srv>
References: <20231220055733.100325-1-fuqiang.wang@easystack.cn>
 <20231220055733.100325-2-fuqiang.wang@easystack.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231220055733.100325-2-fuqiang.wang@easystack.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_051446_697985_7E48E92B 
X-CRM114-Status: GOOD (  27.46  )
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

On 12/20/23 at 01:57pm, fuqiang wang wrote:
> In memmap_exclude_ranges(), there will exclude elfheader from
> crashk_res. In the current x86 architecture code, the elfheader is
> always allocated at crashk_res.start. It seems that there won't be a
> split a new range. But it depends on the allocation position of
> elfheader in crashk_res. To avoid potential out of bounds in future, Set
> the array size to 2.

If so, I would suggest to add extra slot for low 1M too in
fill_up_crash_elf_data() lest the low 1M could be changed in the future,
e.g [start, 1M].

> 
> But similar issue will not exist in fill_up_crash_elf_data(). Because
> the range to be excluded is [0, 1M], start (0) is special and will not
> appear in the middle of existing cmem->ranges[]. I added a comment to
> explain it.
> 
> Signed-off-by: fuqiang wang <fuqiang.wang@easystack.cn>
> ---
>  arch/x86/kernel/crash.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index c92d88680dbf..1c15d0884c90 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -149,6 +149,13 @@ static struct crash_mem *fill_up_crash_elf_data(void)
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
>  	 */
>  	nr_ranges += 2;
>  	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
> @@ -282,9 +289,15 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>  	struct crash_memmap_data cmd;
>  	struct crash_mem *cmem;
>  
> -	cmem = vzalloc(struct_size(cmem, ranges, 1));
> +	cmem = vzalloc(struct_size(cmem, ranges, 2));
>  	if (!cmem)
>  		return -ENOMEM;
> +	cmem->max_nr_ranges = 2;
> +
> +	/* Exclude some ranges from crashk_res and add rest to memmap */
> +	ret = memmap_exclude_ranges(image, cmem, crashk_res.start, crashk_res.end);
> +	if (ret)
> +		goto out;
>  
>  	memset(&cmd, 0, sizeof(struct crash_memmap_data));
>  	cmd.params = params;
> @@ -320,11 +333,6 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>  		add_e820_entry(params, &ei);
>  	}
>  
> -	/* Exclude some ranges from crashk_res and add rest to memmap */
> -	ret = memmap_exclude_ranges(image, cmem, crashk_res.start, crashk_res.end);
> -	if (ret)
> -		goto out;

And you didn't mention moving above code block up in log. I would
suggest keeping it as is because it looks more reasonable to be adjacent
to the following cmem->ranges[] handling.

> -
>  	for (i = 0; i < cmem->nr_ranges; i++) {
>  		ei.size = cmem->ranges[i].end - cmem->ranges[i].start + 1;
>  
> -- 
> 2.42.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
