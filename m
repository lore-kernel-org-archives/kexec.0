Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8E5CA0FE6
	for <kexec@archiver.kernel.org>; Fri,  1 Sep 2023 10:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lgq53K5efvDNEWbLuxKRAYMUperQUUFV2o7gRyn9658=; b=qI+XW6n4XFllKJ
	EnK2X9EMQMdq6OoPh0A+6+CnX6XQ2XPLre0JrdM6UEV8ntVhMKpK+eQm84V/IUja+ciQmJ1UAmfdo
	A+6hAg/TVhjjmA42wLJKXrgP6OjMSp0ql90lG5IBPFaH/lG+sYKUMFadAU04WdyqRNQtdPAIN8hIq
	tkZYfSRMsTMSX7DgqvEcGjb1zD5Y6sGe/oNTVDDQMX3YGtZvCRsjJ+OrZf87utn30zRM6u0D7x26y
	0LWMfA/QUDOljFUJCkpY8xjm4q8AEMCkz+qbhr4QpiI2XkZmUDct3jvIiJXjXaUbALd6aTZj25Lf9
	UhbXhh4C1eceqNGGE2TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qc15P-00Go2S-0t;
	Fri, 01 Sep 2023 10:09:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qc15M-00Go1g-0s
	for kexec@lists.infradead.org;
	Fri, 01 Sep 2023 10:09:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693562942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i8CdRaFuyX7B1sgP28cqTdKjALW2usXqlIRObbQvCxc=;
	b=BlegyQ759o3KVd/bnkRS1NQHIqBlgi+1jL/xJe86RvR2nj+U4nHFlbkP5+Yc+2HoXI04UT
	2B4m3ows0fDARSTdOohrdi+bBpZMZt8/9lauaGht4pk3p9YOvga0sq5c5eAskKRWFkjG8f
	jYr0fOJ+BFK47AwN16a6w2FiL4AXDXQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-Xs10w53IOouXn1DUb9QA0g-1; Fri, 01 Sep 2023 06:09:00 -0400
X-MC-Unique: Xs10w53IOouXn1DUb9QA0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA83F185A78F;
	Fri,  1 Sep 2023 10:08:59 +0000 (UTC)
Received: from localhost (unknown [10.72.113.156])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 08A0621EE560;
	Fri,  1 Sep 2023 10:08:58 +0000 (UTC)
Date: Fri, 1 Sep 2023 18:08:55 +0800
From: Baoquan He <bhe@redhat.com>
To: "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	catalin.marinas@arm.com, thunder.leizhen@huawei.com,
	dyoung@redhat.com, prudo@redhat.com, samuel.holland@sifive.com,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Subject: Re: [PATCH v2 4/8] crash_core: add generic function to do reservation
Message-ID: <ZPG4Nzd/4JdU1Ft4@MiWiFi-R3L-srv>
References: <20230829121610.138107-1-bhe@redhat.com>
 <20230829121610.138107-5-bhe@redhat.com>
 <df395f20-55e9-169b-846b-f55d21d00861@huaweicloud.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <df395f20-55e9-169b-846b-f55d21d00861@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230901_030904_422604_447445D3 
X-CRM114-Status: GOOD (  12.43  )
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

On 08/31/23 at 11:23am, Leizhen (ThunderTown) wrote:
......
> > +void __init reserve_crashkernel_generic(char *cmdline,
> > +			     unsigned long long crash_size,
> > +			     unsigned long long crash_base,
> > +			     unsigned long long crash_low_size,
> > +			     bool high)
> > +{
> > +	unsigned long long search_end = CRASH_ADDR_LOW_MAX, search_base = 0;
> > +	bool fixed_base = false;
> > +
> > +	/* User specifies base address explicitly. */
> > +	if (crash_base) {
> > +		fixed_base = true;
> > +		search_base = crash_base;
> > +		search_end = crash_base + crash_size;
> > +	}
> > +
> > +	if (high) {
> 
> It might be a little clearer to use "else if (high) {"

Makes sense, will update.

> 
> > +		search_base = CRASH_ADDR_LOW_MAX;
> > +		search_end = CRASH_ADDR_HIGH_MAX;
> > +	}
> > +
> > +retry:
> > +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> > +					       search_base, search_end);
......


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
