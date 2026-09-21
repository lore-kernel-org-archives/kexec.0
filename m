Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C20C982DE
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 05:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qIvuPN6/WzgNqJCUjuOUJwBEDkwuxe9xKnTs3tPz+lo=; b=TilYKRK7li5EP23R76CzTo20/V
	LPWxuBOd24eFkJrwcScRJLMhypTwEAsgcaPPuOKwzRhW91ulCxGs662pgR+XClm72QQXTMxUMXEdO
	pXQ+yzOVKN/A0QzWusPd6ksji9k+HkcoIKu8zjznmHEE+VMHlsl2h9SrZmMW0m2qbNqgoPNBCz8U7
	EQPOuc/OgsqnJp5D247CdeH1wt2GdKTYaDZA1MnU6O6ilSHumrjU6nbm595C942IGt7S9p67tZfFg
	Hle+eEWagqb3ooSfkBAGefP0xzG/vtrnEyXRTpw/qehTLpdDUS5hZxl57q5jGFvShdM5SAXAGA/hY
	fA4JJ1kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8WxY-00000000yQN-1PkZ;
	Mon, 21 Sep 2026 05:53:00 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8WxW-00000000yPc-3QcV
	for kexec@bombadil.infradead.org;
	Mon, 21 Sep 2026 05:52:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qIvuPN6/WzgNqJCUjuOUJwBEDkwuxe9xKnTs3tPz+lo=; b=Ua1lJXvAvQmsPfbdP5pMboF6x9
	Ugv2gLxCacbrsYx2GTcDms2mZn1dwStDfgLV/SUyCyJiPzbAXDc3Dj8ule66nudKnapfaIhRvg51F
	R9CmP1QHROEaAzCA3g1BAyiri0BBd/1S+gbVeKU5utP3TgVCa7I+1yRdfwbut0zC27W7+zfiidueN
	y4txpVu0Pz2umaqS2sQK2cEi1jZ/sKYEBIsl1qGbHaQpjmmzrQ8hBt3MQGykvlosAg7vK1IMe8mOW
	6WiL7fwh6T+Du1V/eCJ8katfybXei/WAnWeP6RChURMRxgRmwLuS8qWDSxnodNiXs85eGPgdAI6I3
	j0FKTn9g==;
Received: from out-226.mta0.migadu.com ([2001:41d0:1004:224b::e2] helo=mta0.migadu.com)
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x8Wx5-0000000Bqpj-1GIl
	for kexec@lists.infradead.org;
	Mon, 21 Sep 2026 05:52:49 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=+3OQfzHRoTvBjBd8jB9/THE2C+GAiBoDPdOUT4cBopw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789969947; v=1; x=1790574747;
 b=AGqHNvoBHNAK5Sgs8bbNFPB9LRfWqahsS8hsc3FUslRi1QNL9CbtcXuiBuAODhnoALewzvTz
 zAJKHdCmXss9/DvIqB5/J8rDlIqMR5eOYjWyZsTcomxdHzlJCmmDAyvIWSZur3TyrC6BPzAwIHN
 locxBrK8oD3Q849lc7AWjrUk=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta12.migadu.com with ESMTPS id 3106e5e1082e60f1;
	Mon, 21 Sep 2026 05:52:26 +0000
X-Mizu-Trace-ID: 3106e5e1082e60f1
X-Migadu-Flow: FLOW_OUT
Date: Mon, 21 Sep 2026 13:52:24 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Wandun <chenwandun1@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>, catalin.marinas@arm.com,
	will@kernel.org, chenhuacai@kernel.org, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, robh@kernel.org, saravanak@kernel.org,
	akpm@linux-foundation.org, pasha.tatashin@soleen.com,
	pratyush@kernel.org, m.szyprowski@samsung.com, mark.rutland@arm.com,
	kernel@xen0n.name, alex@ghiti.fr, hpa@zytor.com,
	ruirui.yang@linux.dev, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, iommu@lists.linux.dev
Subject: Re: [PATCH v6 06/10] memblock: introduce MEMBLOCK_NODUMP flag
Message-ID: <arDGGOhKFueI90tJ@fedora>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <20260902073116.802752-7-chenwandun1@gmail.com>
 <aqzxavL91icLw-Xv@fedora>
 <aq41nFRPtRWTQ7cK@kernel.org>
 <aq9UGXeqmCfuPHdD@fedora>
 <32b00102-0961-49e3-b780-74d6db182809@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32b00102-0961-49e3-b780-74d6db182809@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_065248_268269_C86D9FB0 
X-CRM114-Status: GOOD (  20.50  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 09/20/26 at 04:00pm, Wandun wrote:
> 
> 
> On 9/20/26 11:33, Baoquan He wrote:
> > On 09/19/26 at 10:11am, Mike Rapoport wrote:
> >> On Fri, Sep 18, 2026 at 04:08:10PM +0800, Baoquan He wrote:
> >>> On 09/02/26 at 03:31pm, Wandun Chen wrote:
> > ...snip... 
> >>>> +/**
> >>>> + * memblock_mark_nodump - Mark a memory region with flag MEMBLOCK_NODUMP.
> >>>> + * @base: the base phys addr of the region
> >>>> + * @size: the size of the region
> >>>> + *
> >>>> + * Mark the region as not to be included in crash dumps.
> >>>> + *
> >>>> + * Return: 0 on success, -errno on failure.
> >>>> + */
> >>>> +int __init_memblock memblock_mark_nodump(phys_addr_t base, phys_addr_t size)
> >>>       ~~~~~~~~~~~~~~^
> >>> Is it impossible to use at runtime even thought it claims to be generic?
> >>
> >> This should only happen at boot.
> >>
> >> Allowing modifications of memblock properties in runtime is a can of worms
> >> I don't want to open.
> > 
> > Thank you. This is why I said this can't be claimed as a generic way to
> > mark memory region as no dump. The generic way I'd like to see is
> > at any time of system we can mark any unwanted memory region as no dump.
> > And it won't impact the behaviour of the current system.
> 
> Thanks Mike for the explanation and Baoquan for the suggestion.
> I'll drop the "generic" related description in the next version.
> 
> 
> Baoquan, by the way, patch 2 is still awaiting review. It rewrites
> the riscv side of the code that patch 3 (which you've acked) then
> folds into the weak defaults, if you could take a look at it too,
> that would be very helpful.

I checked and looks good, I have added ACK. While RISC-V people can hold
it anytime if they have concern.


