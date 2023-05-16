Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58E3C77B7D
	for <kexec@archiver.kernel.org>; Tue, 16 May 2023 03:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z5bEm+geS2DOfdx27D0T4CUyJBIpE/HpDKE/K33TRP0=; b=h/Kna5u0T9mNKY
	XStXyUipmaegOWSqWDp1r7lKX7GPnRt0PrnNfX2zYl7MiH99nhx15ee2sCrkKRnxya52T92805r7O
	dp/bJQaZChBmzJfjRUKEWYwvMGLmphuclf33Ew/bznRyyWEGlHoGxicVws3z2C40mKgLB4zlZ77r6
	e/wgtEAyUAh3609wNtDZJ4YKWARcihfeMjHsZZtARqH9RlNUcmIOw3+BC5dqNBDnipdcDjrNnLmh9
	ldNLQZGm0NWK2GlI1bfky1opWi5F4IDyNTB7eP5crKmGUJXp9bI3Vd2GxMo2eP+/AvOpxm0BjFtgm
	V6D4BNoLkFZSJ9NqEx1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pykvQ-004CbQ-2E;
	Tue, 16 May 2023 03:00:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pykvN-004CaA-1m
	for kexec@lists.infradead.org;
	Tue, 16 May 2023 03:00:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684206018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEAd3D4zy/iD7bH1Yo/MWqtNt/Zaten+LoJ4wRMWN0U=;
	b=WstC8P8HUBmKrXDc23tFQDgEmgUg/GXmKYfc8dJQXaDADHwF32LSSg66DQB8/jkEWPwj4L
	LdVhGXa79Qku7SOO1SDKfg1RCsv805KlPh8d+FJ1fMus7BpJJ1WiADVzoeACdwxA1d3Ib2
	99dt3r/vxk+hE4BcGOSZfVclKqVVCik=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-4FWlob5xMauTLOaaeX6gTA-1; Mon, 15 May 2023 23:00:15 -0400
X-MC-Unique: 4FWlob5xMauTLOaaeX6gTA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 968591C09500;
	Tue, 16 May 2023 03:00:14 +0000 (UTC)
Received: from localhost (ovpn-12-32.pek2.redhat.com [10.72.12.32])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B316714171B6;
	Tue, 16 May 2023 03:00:13 +0000 (UTC)
Date: Tue, 16 May 2023 11:00:10 +0800
From: Baoquan He <bhe@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, catalin.marinas@arm.com, horms@kernel.org,
	thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZGLxul+c4vYQBn27@MiWiFi-R3L-srv>
References: <20230407022419.19412-1-bhe@redhat.com>
 <20230414143413.GA27911@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230414143413.GA27911@willie-the-truck>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_200029_708445_1C09F1E5 
X-CRM114-Status: GOOD (  21.54  )
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

Hi Will,

On 04/14/23 at 03:34pm, Will Deacon wrote:
> Hi,
> 
> On Fri, Apr 07, 2023 at 10:24:19AM +0800, Baoquan He wrote:
> > On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> > suitable memory region top down. If the 'xM' of crashkernel high memory
> > is reserved from high memory successfully, it will try to reserve
> > crashkernel low memory later accoringly. Otherwise, it will try to search
> > low memory area for the 'xM' suitable region. Please see the details in
> > Documentation/admin-guide/kernel-parameters.txt.
> 
> [...]
> 
> >  arch/arm64/mm/init.c | 44 ++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 34 insertions(+), 10 deletions(-)
> 
> I tried to apply this, but smatch is unhappy with the result:
> 
>   | arch/arm64/mm/init.c:153 reserve_crashkernel() error: uninitialized symbol 'search_base'.
> 
> I _think_ this is a false positive, but I must say that the control flow
> in reserve_crashkernel() is extremely hard to follow so I couldn't be
> sure. If the static checker is struggling, then so will humans!
> 
> Ideally, this would all be restructured to make it easier to follow,
> but in the short term we need something to squash the warning.

I tried to refactor the code as you suggested, while it seems not easy
to do. The complexity comes from several cases which need be handled.
I try my best to write a document with the things I think important to
help understand the code. Please help check if it helps or we just having
the current code is fine.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
