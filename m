Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0560BC05027
	for <kexec@archiver.kernel.org>; Tue, 24 Jan 2023 02:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xiG52YFfYEqyq6s79o8meLTWS9HKKUCQTuB4LMjWwWY=; b=4/5Tu4PhtQf79Z
	mpgkQvdwls4hXlYYNuZB0gHaJ/shSkwJEr4BDSVJ2rdKFh4hDLAJX7jyiy+XT/wDFAhmZyts6ZYEB
	PyoNaMI7zhSHKJXfhjuI7itJOnDtSmR6/u+u6RAUOo2apLPF+/GvpjK9uoCK/0pxSW6Kbp6Oxpkhx
	EFVqTY2ErTnu09iiG4xyohvwQYd6qNRBqYb61Xjc2b14rPr7kw8yTXLPF9lXzRu9/0SCI89w7s1oR
	ogMb00Yja2sFS+jTu2t3OyrPV/sjiB5cWmQPVpT5uJAPPcXYMVJAwn2guElSaI1TPXIWYegeqGBeM
	kfbg6hs3IGAPb+7ENZxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pK93P-00273g-8Y; Tue, 24 Jan 2023 02:28:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pK93D-00272I-JX
	for kexec@lists.infradead.org; Tue, 24 Jan 2023 02:28:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674527319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O3FeUpCFbal/XQSd3YuGc685icXaaWE7dr05c0MkDV0=;
	b=gXFzyS3nnDbjMFUNpsitPF07BTgJ+V8A/qDAGPdcRd2VamnTukjXV1bViaec958VZvnQv+
	/wYN+0JRjsVSBTvuJwWUdrydvwZmc59LIKsxkYoTGgF4mS6jIewqj40DCd/gvX2mtdmabU
	z2pAozuWbw6Zg3CR8atVymhgNdqyQ6A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-LtDMyEoqMzCPnM1iqGlPDw-1; Mon, 23 Jan 2023 21:28:37 -0500
X-MC-Unique: LtDMyEoqMzCPnM1iqGlPDw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B0A318E5340;
	Tue, 24 Jan 2023 02:28:37 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 733D42026D2A;
	Tue, 24 Jan 2023 02:28:35 +0000 (UTC)
Date: Tue, 24 Jan 2023 10:28:31 +0800
From: Baoquan He <bhe@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will@kernel.org, thunder.leizhen@huawei.com,
	John.p.donnelly@oracle.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH 1/2] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <Y89CT+69j9dfnxwt@fedora>
References: <20230117034921.185150-1-bhe@redhat.com>
 <20230117034921.185150-2-bhe@redhat.com>
 <Y8pZMQoJOdgz+Xba@vergenet.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y8pZMQoJOdgz+Xba@vergenet.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_182843_744114_76D4C08B 
X-CRM114-Status: GOOD (  34.58  )
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

On 01/20/23 at 10:04am, Simon Horman wrote:
> On Tue, Jan 17, 2023 at 11:49:20AM +0800, Baoquan He wrote:
> > On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> > suitable memory region up down. If the 'xM' of crashkernel high memory
> > is reserved from high memory successfully, it will try to reserve
> > crashkernel low memory later accoringly. Otherwise, it will try to search
> > low memory area for the 'xM' suitable region.
> > 
> > While we observed an unexpected case where a reserved region crosses the
> > high and low meomry boundary. E.g on a system with 4G as low memory end,
> > user added the kernel parameters like: 'crashkernel=512M,high', it could
> > finally have [4G-126M, 4G+386M], [1G, 1G+128M] regions in running kernel.
> > This looks very strange because we have two low memory regions
> > [4G-126M, 4G] and [1G, 1G+128M]. Much explanation need be given to tell
> > why that happened.
> > 
> > Here, for crashkernel=xM,high, search the high memory for the suitable
> > region above the high and low memory boundary. If failed, try reserving
> > the suitable region below the boundary. Like this, the crashkernel high
> > region will only exist in high memory, and crashkernel low region only
> > exists in low memory. The reservation behaviour for crashkernel=,high is
> > clearer and simpler.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/arm64/mm/init.c | 30 +++++++++++++++++++++++-------
> >  1 file changed, 23 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 58a0bb2c17f1..26a05af2bfa8 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -127,12 +127,13 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
> >   */
> >  static void __init reserve_crashkernel(void)
> >  {
> > -	unsigned long long crash_base, crash_size;
> > -	unsigned long long crash_low_size = 0;
> > +	unsigned long long crash_base, crash_size, search_base;
> >  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> > +	unsigned long long crash_low_size = 0;
> >  	char *cmdline = boot_command_line;
> > -	int ret;
> >  	bool fixed_base = false;
> > +	bool high = false;
> > +	int ret;
> >  
> >  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
> >  		return;
> > @@ -155,7 +156,9 @@ static void __init reserve_crashkernel(void)
> >  		else if (ret)
> >  			return;
> >  
> > +		search_base = CRASH_ADDR_LOW_MAX;
> >  		crash_max = CRASH_ADDR_HIGH_MAX;
> > +		high = true;
> >  	} else if (ret || !crash_size) {
> >  		/* The specified value is invalid */
> >  		return;
> > @@ -166,31 +169,44 @@ static void __init reserve_crashkernel(void)
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
> > +		if (fixed_base) {
> > +			pr_warn("cannot reserve crashkernel region [0x%llx-0x%llx]\n",
> > +				search_base, crash_max);
> > +			return;
> > +		}
> > +
> >  		/*
> >  		 * If the first attempt was for low memory, fall back to
> >  		 * high memory, the minimum required low memory will be
> >  		 * reserved later.
> >  		 */
> > -		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
> > +		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
> >  			crash_max = CRASH_ADDR_HIGH_MAX;
> > +			search_base = CRASH_ADDR_LOW_MAX;
> >  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> >  			goto retry;
> >  		}
> >  
> > +		if (high && (crash_max == CRASH_ADDR_HIGH_MAX)) {
> 
> nit: unnecessary (and inconsistent with code just above) parentheses.

Indeed, will remove it. Thanks for reviewing.

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
> > -- 
> > 2.34.1
> > 
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> > 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
