Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF58C35274
	for <kexec@archiver.kernel.org>; Thu, 21 Dec 2023 04:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+mIMfi2cg2JCSRa4/1/XmJRTGMM/IGvHW9DbDGZQbzE=; b=0YGzcTzLk1sVDf
	NY9uBhN9p+A4JWQhYdCQ1Xgbdg7cw0PCgMpv1TS0hNVcWwKwF8R8HZB7xGdovGJTnHXeKAVuh77j1
	kP3A3BJkfgnqebmqOrkl1vBmCpsh1B4a+Xz3NifV+lIDx4Sa3e8pvEeReqY21MfEzORu3i19VtYfT
	n/PqdA5PINWcuhEvKQK+VkUOJA7hX9t3yyjhwoTmyPMo5Q0xkdaArybhWdnAz7KYuKtPiltZVw19z
	yG01wVchmKxQAQYPXpxHwya44VbDcKCjEc4UpbhOyUCL+BbpyS2Rch9+P+gaq/MK+nINLFUSzMQqH
	B8dHDgx7X7GKplHUD7+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGAQS-001epx-2x;
	Thu, 21 Dec 2023 04:12:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGAQP-001epY-36
	for kexec@lists.infradead.org;
	Thu, 21 Dec 2023 04:12:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703131962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LYwTBqplqqI5GDQJ4vYImBgIRehExp2gFU18Pdx2r5A=;
	b=Wo9RKi5bEPXdf1J4jO3NHnYX5tVfS53mGaOavN9UcUgDFWy1v13EZtMLfdphfawunRazZX
	n+gPes63UrFTnSnk6tuMQV078dhsXH3RfOZ5KC+W2rJ1Zu34ODn9KYchLuRo4PQOEmq8Ol
	tlBjsWEmbiPdYjo7B/pTnq/dliZ84eQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-PbxvE6g8MM-gJ25qgLEakw-1; Wed,
 20 Dec 2023 23:12:38 -0500
X-MC-Unique: PbxvE6g8MM-gJ25qgLEakw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CD242999B21;
	Thu, 21 Dec 2023 04:12:38 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7503840C6EB9;
	Thu, 21 Dec 2023 04:12:37 +0000 (UTC)
Date: Thu, 21 Dec 2023 12:12:34 +0800
From: Baoquan He <bhe@redhat.com>
To: Huang Shijie <shijie@os.amperecomputing.com>
Cc: vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, patches@amperecomputing.com
Subject: Re: [PATCH] crash_core: export vmemmap when CONFIG_SPARSEMEM_VMEMMAP
 is enabled
Message-ID: <ZYO7MvpT9yWWfjO7@MiWiFi-R3L-srv>
References: <20231127020727.25296-1-shijie@os.amperecomputing.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231127020727.25296-1-shijie@os.amperecomputing.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231220_201246_095668_CAB27647 
X-CRM114-Status: GOOD (  15.36  )
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

On 11/27/23 at 10:07am, Huang Shijie wrote:
> In memory_model.h, if CONFIG_SPARSEMEM_VMEMMAP is configed,
> kernel will use vmemmap to do the __pfn_to_page/page_to_pfn,
> and kernel will not use the "classic sparse" to do the
> __pfn_to_page/page_to_pfn.
> 
> So export the vmemmap when CONFIG_SPARSEMEM_VMEMMAP is configed.
> This makes the user applications (crash, etc) get faster
> pfn_to_page/page_to_pfn operations too.
> 
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
>  kernel/crash_core.c | 3 +++
>  1 file changed, 3 insertions(+)

Ack this one as it's needed by crash utility patches.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index efe87d501c8c..9653c4177191 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -765,6 +765,9 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	VMCOREINFO_SYMBOL(mem_map);
>  	VMCOREINFO_SYMBOL(contig_page_data);
>  #endif
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +	VMCOREINFO_SYMBOL_ARRAY(vmemmap);
> +#endif
>  #ifdef CONFIG_SPARSEMEM
>  	VMCOREINFO_SYMBOL_ARRAY(mem_section);
>  	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
> -- 
> 2.40.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
