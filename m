Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF60C678D4
	for <kexec@archiver.kernel.org>; Fri,  3 Mar 2023 03:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yyLfmc+E7G36hO7tzLMMSBXfdyED/DBwgNiZg02PQzE=; b=KWLA1tt4l6X39x
	+q22AGTms+Q4YTvc65IvfdrKYlz/MCx4JTOkQfILWoA+Q8TMPqyPhl6AFVLXU9H3uxESnzB4YEcs8
	GVqCu3gf/02+EzjuiuuWkACAgGqvlem80Vi/qZq+YQOeM3maMvrDT4eAB3Ik1tD2rOIo+mJDRgYKo
	QI6ouljf/yXISLZN28K6IDMGlX/E7bKGc8mcsI4aoWOkRicg9FrPuRsBavxEdPwL2HZ7GnI6dE3q3
	JTqIlO7QWYTTT3+9Jhhjn9dWGU2Vzb0iD6oATqTqkmR4jfN1b9EN4kWpJrkixfQG+rQsxH2fSlk2W
	n+BDKrLnUp61XVDzjm1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXvfw-004auq-D6; Fri, 03 Mar 2023 03:01:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXvfm-004arr-W3
	for kexec@lists.infradead.org; Fri, 03 Mar 2023 03:01:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677812488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B79nsr/L+yxY5ZiHIGPfHGlquDm1c+TbNdmntyfdbOk=;
	b=YymS7dHCHNkHaQaZGgoir+EBtPa0YK6V+qO/NCY1g6YnfKvkYqTSsrcW69Qc6zlpNLa4YE
	gV2hKGAxj6psqUz97ouYZXzJI2NvcaztQLkwZk34+cGhc0WbexTCGDV76rO3VpIn2Gdwdm
	78acoBSPhVc7BgdJ8JOEXoaXmrZ5ZJI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-kfVt7ZOyPxuBPOeHxtUHfg-1; Thu, 02 Mar 2023 22:01:25 -0500
X-MC-Unique: kfVt7ZOyPxuBPOeHxtUHfg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6E8F280BF64;
	Fri,  3 Mar 2023 03:01:24 +0000 (UTC)
Received: from localhost (ovpn-13-150.pek2.redhat.com [10.72.13.150])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B93040C6EC4;
	Fri,  3 Mar 2023 03:01:22 +0000 (UTC)
Date: Fri, 3 Mar 2023 11:01:19 +0800
From: Baoquan He <bhe@redhat.com>
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc: linux-kernel@vger.kernel.org, catalin.marinas@arm.com, horms@kernel.org,
	John.p.donnelly@oracle.com, will@kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZAFi/+J7WITdcUWb@MiWiFi-R3L-srv>
References: <20230223124532.128744-1-bhe@redhat.com>
 <7971ddbe-aefb-271e-647c-59d81c5840a7@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7971ddbe-aefb-271e-647c-59d81c5840a7@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230302_190131_129068_1294DD3E 
X-CRM114-Status: GOOD (  21.78  )
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

On 03/02/23 at 11:32am, Leizhen (ThunderTown) wrote:
......
> > @@ -166,31 +169,51 @@ static void __init reserve_crashkernel(void)
> >  	/* User specifies base address explicitly. */
> >  	if (crash_base) {
> >  		fixed_base = true;
> > +		search_base = crash_base;
> >  		crash_max = crash_base + crash_size;
> >  	}
> >  
> >  retry:
> >  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> > -					       crash_base, crash_max);
> > +					       search_base, crash_max);
> >  	if (!crash_base) {
> >  		/*
> > -		 * If the first attempt was for low memory, fall back to
> > -		 * high memory, the minimum required low memory will be
> > -		 * reserved later.
> > +		 * For crashkernel=size[KMG]@offset[KMG], print out failure
> > +		 * message if can't reserve the specified region.
> >  		 */
> > -		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
> > +		if (fixed_base) {
> > +			pr_info("crashkernel reservation failed - memory is in use.\n");
> 
> How about changing pr_info to pr_warn?
> 
> > +			return;
> > +		}
> > +
> > +		/*
> > +		 * For crashkernel=size[KMG], if the first attempt was for
> > +		 * low memory, fall back to high memory, the minimum required
> > +		 * low memory will be reserved later.
> > +		 */
> > +		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
> >  			crash_max = CRASH_ADDR_HIGH_MAX;
> > +			search_base = CRASH_ADDR_LOW_MAX;
> >  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> >  			goto retry;
> >  		}
> >  
> > +		/*
> > +		 * For crashkernel=size[KMG],high, if the first attempt was
> > +		 * for high memory, fall back to low memory.
> > +		 */
> > +		if (high && crash_max == CRASH_ADDR_HIGH_MAX) {
> 
> Adding unlikely to indicate that it is rare would be better.
> 
> if (unlikely(high && crash_max == CRASH_ADDR_HIGH_MAX))

Rethink about this and checked code in kernel, seems likely|unlikely are
mostly used in highly frequent execution branch optimize code path, while 
crashkernel resevatoin is one time execution during boot, we may not
need to bother to add unlikely. What do you think?


> 
> > +			crash_max = CRASH_ADDR_LOW_MAX;
> > +			search_base = 0;
> > +			goto retry;
> > +		}
> >  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> >  			crash_size);
> >  		return;
> >  	}
> >  
> > -	if ((crash_base > CRASH_ADDR_LOW_MAX - crash_low_size) &&
> > -	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
> > +	if ((crash_base >= CRASH_ADDR_LOW_MAX) && crash_low_size &&
> > +	     reserve_crashkernel_low(crash_low_size)) {
> >  		memblock_phys_free(crash_base, crash_size);
> >  		return;
> >  	}
> > 
> 
> -- 
> Regards,
>   Zhen Lei
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
