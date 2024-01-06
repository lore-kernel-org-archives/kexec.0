Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D735C3DA6E
	for <kexec@archiver.kernel.org>; Sat,  6 Jan 2024 02:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZLFLCvKSeYVXlHV5nicbuEqthbHR72VkEuomaggxEkM=; b=va4Vj1MRg1Pb73
	4OVC2MjqSSVCpIwO8YqAWPup3R1VUrR7zAbao0BtsM7e8IrCGK+e6hhrptsj6V4jF4oXPqfS1v/B2
	vKKjuZF8t5apFK2A9G+JbESnfq1wcITv8xf85jptn0eUb0zofc5Rnb9rQvJuB0s/fQJTZbEjs6kbg
	wbopnR4JxtmGSHE27C9K63ZsKDQeg3FXZnXCsot1BI60lyw0e93X0aFk5bpw8BjwAOmRo6RaICynQ
	I7iqkAFChtgdcILHXj9NE2c3SFgnauevAZ4t9Oro9nOa82JvR/QkeRebB1lAQ2f8Cr35MPhOvjGd9
	RozSfcuNep8nXc22dOfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLw8B-000a8Y-0G;
	Sat, 06 Jan 2024 02:09:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLw87-000a86-1U
	for kexec@lists.infradead.org;
	Sat, 06 Jan 2024 02:09:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704506980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ralLWF95EMwMr9Y7Fs/3WcboK17YpbM9ruojoVv6Wh4=;
	b=Ua7VnlbfH1aYN4XWxuamUh1zwI+FgwkOC3Zb1ICdrTp7cb4XstfeaeVy2UanzaQfIN6Ks9
	jh2NgHubAxX9bbcvNFUrHDHLcX+ePbs6IKXc19aYdWexstVUoU9vh4/Te3Ybtgu5bFvsM7
	ZAjZLYRQ0IMnj67Ry5xOPLPssSAnkN0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-kxv7lDphNcaJwhh3PvQing-1; Fri, 05 Jan 2024 21:09:34 -0500
X-MC-Unique: kxv7lDphNcaJwhh3PvQing-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6005985A588;
	Sat,  6 Jan 2024 02:09:34 +0000 (UTC)
Received: from localhost (unknown [10.72.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C9B0B3C27;
	Sat,  6 Jan 2024 02:09:32 +0000 (UTC)
Date: Sat, 6 Jan 2024 10:09:29 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Youling Tang <tangyouling@kylinos.cn>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdump: Defer the insertion of crashkernel resources
Message-ID: <ZZi2WXVmXHcmd17c@MiWiFi-R3L-srv>
References: <20231229080213.2622204-1-chenhuacai@loongson.cn>
 <20240105084911.b64f43b12b0c7e25436cb093@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240105084911.b64f43b12b0c7e25436cb093@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_180943_594430_693E302E 
X-CRM114-Status: GOOD (  17.19  )
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

On 01/05/24 at 08:49am, Andrew Morton wrote:
> On Fri, 29 Dec 2023 16:02:13 +0800 Huacai Chen <chenhuacai@loongson.cn> wrote:
> 
> > In /proc/iomem, sub-regions should be inserted after their parent,
> > otherwise the insertion of parent resource fails. But after generic
> > crashkernel reservation applied, in both RISC-V and ARM64 (LoongArch
> > will also use generic reservation later on), crashkernel resources are
> > inserted before their parent, which causes the parent disappear in
> > /proc/iomem. So we defer the insertion of crashkernel resources to an
> > early_initcall().
> > 
> > ...
> >
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -377,7 +377,6 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
> >  
> >  	crashk_low_res.start = low_base;
> >  	crashk_low_res.end   = low_base + low_size - 1;
> > -	insert_resource(&iomem_resource, &crashk_low_res);
> >  #endif
> >  	return 0;
> >  }
> > @@ -459,8 +458,19 @@ void __init reserve_crashkernel_generic(char *cmdline,
> >  
> >  	crashk_res.start = crash_base;
> >  	crashk_res.end = crash_base + crash_size - 1;
> > -	insert_resource(&iomem_resource, &crashk_res);
> >  }
> > +
> > +static __init int insert_crashkernel_resources(void)
> > +{
> > +	if (crashk_res.start < crashk_res.end)
> > +		insert_resource(&iomem_resource, &crashk_res);
> > +
> > +	if (crashk_low_res.start < crashk_low_res.end)
> > +		insert_resource(&iomem_resource, &crashk_low_res);
> > +
> > +	return 0;
> > +}
> > +early_initcall(insert_crashkernel_resources);
> >  #endif
> >  
> >  int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
> 
> I'm thinking 
> 
> Fixes: 0ab97169aa0 ("crash_core: add generic function to do reservation").

Yes.

> 
> Also, is this a regression?  Were earlier kernels OK?

It's a regression, will impact arm64 in v6.6 kernel. Add below too?

Cc: <stable@vger.kernel.org> # 6.6.x


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
