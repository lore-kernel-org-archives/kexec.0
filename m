Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6832ECAAD5
	for <kexec@archiver.kernel.org>; Tue, 30 Aug 2022 03:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MrxQgKsp/QHko+/L1rCNS01S0DHsRdpDL37PAhu1jPU=; b=gsPkN7l9GNBUM6
	xvlap5I1CygnJIy2z2c5hQbRIqSP/pHVqYJZFiteNoITrT+x5XtiKDdIPcK6xjsw8T6SLg+QyC6sH
	o6AhB/Fxc9MgLTOXht7e1nggpB9SNEcMeOvximLCdZbYQG63XtuWSTvhdWuefYAmFbcq2hrRUcQsL
	E27aJfbTztJMICXZuSjU9zS21Fv2YTCgrBZVn4oVu0BVb+Gx4jcHoLAD9jO75lrWuH1ULEq1gM6+E
	Yw39jg0rqi0kaANqyn+IXZtq2DAyphrAOKtwNWIwKApamdmMnhiXvhIgPMPGKMOkRL16WiSMLWmD/
	tkwVOeVw6y40XM5/3YUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSrsD-00Dk3u-IA; Tue, 30 Aug 2022 03:25:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSrrx-00Dk0n-PB
	for kexec@lists.infradead.org; Tue, 30 Aug 2022 03:24:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661829890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K9eHM5bdDrU457dsjk7yJ0LqGH38gn04owAekbromuM=;
	b=R9xU5H2hqnDI8/RRgnTGGjZ214DCwVxTnLv7BeD9+5qIPGd5x9EI+fPa2bfVfa8mpVlAtS
	tnADUad3i/BUQmVqFzjk+EIlBLY3wAJYbK8CMJr6Y9Psqsp11UDAiq7HB8SO264/4OFD+A
	yReaUo1CKJnBAO/IbmNpM3d0raVUptk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-H6hKGCrnPduvbUXehoYbfA-1; Mon, 29 Aug 2022 23:24:44 -0400
X-MC-Unique: H6hKGCrnPduvbUXehoYbfA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6815857FE7;
	Tue, 30 Aug 2022 03:24:42 +0000 (UTC)
Received: from localhost (ovpn-12-78.pek2.redhat.com [10.72.12.78])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A06A951CE;
	Tue, 30 Aug 2022 03:24:41 +0000 (UTC)
Date: Tue, 30 Aug 2022 11:24:37 +0800
From: Baoquan He <bhe@redhat.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>,
	kexec@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mike Rapoport <rppt@linux.ibm.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Mike Rapoport <mike.rapoport@gmail.com>
Subject: Re: [PATCH 0/5] arm64/mm: remap crash kernel with base pages even if
 rodata_full disabled
Message-ID: <Yw2C9ahluhX4Mg3G@MiWiFi-R3L-srv>
References: <20220819041156.873873-1-rppt@kernel.org>
 <YwcmKAink5XvoaTe@MiWiFi-R3L-srv>
 <YwcpRQvNErbTq1XB@kernel.org>
 <YwspSc83XveXSFnW@MiWiFi-R3L-srv>
 <YwzNyVH8FB374In5@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YwzNyVH8FB374In5@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_202453_898641_2EA29BB6 
X-CRM114-Status: GOOD (  53.34  )
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

On 08/29/22 at 05:31pm, Mike Rapoport wrote:
> On Sun, Aug 28, 2022 at 04:37:29PM +0800, Baoquan He wrote:
> > On 08/25/22 at 10:48am, Mike Rapoport wrote:
> > ...... 
> > > > > There were several rounds of discussion how to remap with base pages only
> > > > > the crash kernel area, the latest one here:
> > > > > 
> > > > > https://lore.kernel.org/all/1656777473-73887-1-git-send-email-guanghuifeng@linux.alibaba.com
> > > > > 
> > > > > and this is my attempt to allow having both large pages in the linear map
> > > > > and protection for the crash kernel memory.
> > > > > 
> > > > > For server systems it is important to protect crash kernel memory for
> > > > > post-mortem analysis, and for that protection to work the crash kernel
> > > > > memory should be mapped with base pages in the linear map. 
> > > > > 
> > > > > On the systems with ZONE_DMA/DMA32 enabled, crash kernel reservation
> > > > > happens after the linear map is created and the current code forces using
> > > > > base pages for the entire linear map, which results in performance
> > > > > degradation.
> > > > > 
> > > > > These patches enable remapping of the crash kernel area with base pages
> > > > > while keeping large pages in the rest of the linear map.
> > > > > 
> > > > > The idea is to align crash kernel reservation to PUD boundaries, remap that
> > > > > PUD and then free the extra memory.
> > > > 
> > > > Hi Mike,
> > > > 
> > > > Thanks for the effort to work on this issue. While I have to say this
> > > > isnt's good because it can only be made relying on a prerequisite that
> > > > there's big enough memory. If on a system, say 2G memory, it's not easy
> > > > to succeed on getting one 1G memory. While we only require far smaller
> > > > region than 1G, e.g about 200M which should be easy to get. So the way
> > > > taken in this patchset is too quirky and will cause regression on
> > > > systemswith small memory. This kind of sytems with small memory exists
> > > > widely on virt guest instance.
> > > 
> > > I don't agree there is a regression. If the PUD-aligned allocation fails,
> > > there is a fallback to the allocation of the exact size requested for crash
> > > kernel. This allocation just won't get protected.
> > 
> > Sorry, I misunderstood it. I just went through the log and didn't
> > look into codes.
> > 
> > But honestly, if we accept the fallback which doesn't do the protection,
> > we should be able to take off the protection completely, right?
> > Otherwise, the reservation code is a little complicated.
> 
> We don't do protection of the crash kernel for most architectures
> supporting kexec ;-)

Yeah. The protection was introduced into x86 firstly by my former
colleague of Redhat as an enhancement. Later people ported it to arm64.
We have signature verification mechanism to check if corruption on
loaded kdump kernel happened. In fact, panic is a small probability
event, and accidental corruption on kdump kernel data is a much smaller
probability event. The protection is an icing on the cake. But if it
brings mess, better take it away if no way to clean up the mess.

> 
> My goal was to allow large systems with ZONE_DMA/DMA32 have block mappings
> in the linear map and crash kernel protection without breaking backward
> compatibility for the existing systems.
> 
> > > Also please note, that the changes are only for the case when user didn't
> > > force base-size pages in the linear map, so anything that works now will
> > > work the same way with this set applied.
> > >  
> > > > The crashkernel reservation happens after linear map because the
> > > > reservation needs to know the dma zone boundary, arm64_dma_phys_limit.
> > > > If we can deduce that before bootmem_init(), the reservation can be
> > > > done before linear map. I will make an attempt on that. If still can't
> > > > be accepted, we would like to take off the crashkernel region protection
> > > > on arm64 for now.
> > > 
> > > I doubt it would be easy because arm64_dma_phys_limit is determined after
> > > parsing of the device tree and there might be memory allocations of
> > > possibly unmapped memory during the parsing.
> > 
> > I have sent out the patches with an attempt, it's pretty straightforward
> > and simple. Because arm64 only has one exception, namely Raspberry Pi 4,
> > on which some peripherals can only address 30bit range. That is a corner
> > case, to be honest. And kdump is a necessary feature on server, but may
> > not be so expected on Raspberry Pi 4, a system for computer education
> > and hobbyists. And kdump only cares whether the dump target devices can
> > address 32bit range, namely storage device or network card on server.
> > If finally confirmed that storage devices can only address 30bit range
> > on Raspberry Pi 4, people still can have crashkernel=xM@yM method to
> > reserve crashkernel regions.
> 
> I hope you are right and Raspberry Pi 4 is the only system that limits
> DMA'able range to 30 bits. But with diversity of arm64 chips and boards I
> won't be surprised that there are other variants with a similar problem.

We still need people to confirm if the storage disk or NIC on RPi4 is
able to address 32 bit range. From Nicalas's patch log and cover-letter,
he said not all devices on RPi4 are 30bit addressable.

That's possible a new arm64 chip comes out with devices of 30bit addresing,
even though those arm64 servers usually deployed with devices of wider than
32bit DMA addressing ability. And I don't think users of the chip will care
about kdump. Kdump is relied more on enterprise level system.

On x86, we ignore those ISA devices in kdump kernel at the beginning.
As you can see, the current kdump kernel has no available physical pages
in DMA zone on x86. If people have a ISA device in x86_64 system, and
want to set it as dump target, it doesn't work at all. We don't support
the corner case. If we want to cover everything, we can only limp with
patches all over us.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
