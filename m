Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99691C54E94
	for <kexec@archiver.kernel.org>; Tue, 24 Jan 2023 02:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IRCYfxGBBHUvyec3zJu2HAfYiZSms2OZ353cXv+XJr8=; b=n6vaXL/MqqjQvj
	+smsWnzDtGvcDxUnlm/qfGvqm5y/dRckcKdzDqllOydXsF5sI5GpO01flXuGq8mM8pGLAouVteWl2
	jU+g8dFbvffU4hC/E5irRHD/3acu0Vk+VwWWg9MrZaMAQCmfO6cI49TKYkssLc54gGAJ7HR4J3T45
	2IyzicRFPWUIwn7lauDozSffAjUhbIXTlkQmDq1BTVdfmGuKBvjEtxIYMNb8g9qelBiCVbaRSzKkN
	nmko77t5QTceI5DEFr5h+jcmGa1A1S/xJBGAWkT2MqhkyCFzYJi5WsH6TPJ011i0mgcohTOUgIiuq
	vwaHnWCTQmYIfIqM9sEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pK9Nj-0028OX-PC; Tue, 24 Jan 2023 02:49:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pK9Ng-0028NM-1C
	for kexec@lists.infradead.org; Tue, 24 Jan 2023 02:49:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674528590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tDEShTc+qxEMTNcIsETbduQ+QSQW/4E7thNs06NrHuI=;
	b=RRv+k+9frVG95OjJax32o0aR4EcILedyLs3VYU1MEsp99ya2tWd5BKe8UNMrYoh/y3FMEx
	N8erMWM1xGjWwciXe8fwSBUPto9WFiICXBEf+8bzBf6f5BKYwfZoR2msETA+AONpqbDJPw
	OU44QS84+fTqlrZH7b0sjFBOS3oRFMk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-ajSWj7FDNyGCHfrOcokx7g-1; Mon, 23 Jan 2023 21:49:48 -0500
X-MC-Unique: ajSWj7FDNyGCHfrOcokx7g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE1E385C069;
	Tue, 24 Jan 2023 02:49:47 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 607FC4069768;
	Tue, 24 Jan 2023 02:49:45 +0000 (UTC)
Date: Tue, 24 Jan 2023 10:49:42 +0800
From: Baoquan He <bhe@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will@kernel.org, thunder.leizhen@huawei.com,
	John.p.donnelly@oracle.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH 2/2] arm64/kdump: add code comments for crashkernel
 reservation cases
Message-ID: <Y89HRnIzq034pJH8@fedora>
References: <20230117034921.185150-1-bhe@redhat.com>
 <20230117034921.185150-3-bhe@redhat.com>
 <Y8pYvBvDonUya1mx@vergenet.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y8pYvBvDonUya1mx@vergenet.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_184952_165729_BB32B4AA 
X-CRM114-Status: GOOD (  32.30  )
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

On 01/20/23 at 10:02am, Simon Horman wrote:
> On Tue, Jan 17, 2023 at 11:49:21AM +0800, Baoquan He wrote:
> > This will help understand codes on crashkernel reservations on arm64.
> 
> FWIIW, I think you can fold this into the first patch.

Sure, will do.

I folded this into patch 1 at the very beginning. Then felt the added
code comments add lines of change and make the code change not so
straightforward. I admit it's from personal feeling. 

> 
> And, although I have no good idea at this moment, I do wonder
> if the logic can be simplified - I for one really needed the
> comments to understand the retry logic.

Got it. I will consider if I can improve the logic readability. Thanks.

> 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/arm64/mm/init.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 26a05af2bfa8..f88ad17cb20d 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -177,6 +177,10 @@ static void __init reserve_crashkernel(void)
> >  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> >  					       search_base, crash_max);
> >  	if (!crash_base) {
> > +		/*
> > +		 * For crashkernel=size[KMG]@offset[KMG], print out failure
> > +		 * message if can't reserve the specified region.
> > +		 */
> >  		if (fixed_base) {
> >  			pr_warn("cannot reserve crashkernel region [0x%llx-0x%llx]\n",
> >  				search_base, crash_max);
> > @@ -188,6 +192,11 @@ static void __init reserve_crashkernel(void)
> >  		 * high memory, the minimum required low memory will be
> >  		 * reserved later.
> >  		 */
> > +		/*
> > +		 * For crashkernel=size[KMG], if the first attempt was for
> > +		 * low memory, fall back to high memory, the minimum required
> > +		 * low memory will be reserved later.
> > +		 */
> 
> I think this duplicates the preceding comment.
> Perhaps just replace the earlier comment with this one.
> 
> >  		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
> >  			crash_max = CRASH_ADDR_HIGH_MAX;
> >  			search_base = CRASH_ADDR_LOW_MAX;
> > @@ -195,6 +204,10 @@ static void __init reserve_crashkernel(void)
> >  			goto retry;
> >  		}
> >  
> > +		/*
> > +		 * For crashkernel=size[KMG],high, if the first attempt was for
> > +		 * high memory, fall back to low memory.
> > +		 */
> >  		if (high && (crash_max == CRASH_ADDR_HIGH_MAX)) {
> >  			crash_max = CRASH_ADDR_LOW_MAX;
> >  			search_base = 0;
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
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
