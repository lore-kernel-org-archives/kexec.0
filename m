Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05D8C88E50
	for <kexec@archiver.kernel.org>; Fri, 11 Sep 2026 13:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=35qTFGciq12kEJU+EMJ4woELZzEj6I4YMtoPAd4aNAQ=; b=t5ZzEP3+S4tf1JPKINj26Z8kpm
	QHtt6seR7mDnr3Qa6n7GT6V3lrYtZTL266dfxa1voeJrONcGRuA1yX9Gwm4zHoa34X80jkhCVkBh0
	/4m+J52FB7UsYF1FUIyVqUp7QxhURavA5pNSCfgbraciPxwok8+nlh25nxmK5QIC9OyIxIQ1ypV3H
	2VZBEMr6EP5soCRBG7x1q0Vbi/y8NCIFoc7OMXIRvtk0z6TvxA5wGrtQ74f8jdq6g9We6RXhv/tv0
	s2mK8BwpNFv6Jyf9C7OcBg80JLRdx+X5CKvkNrVz56Ms46bpb4s4cx0GsjTkRIXOgcYcHIGvDVMyC
	aXHE4syA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x51Yl-0000000GmcD-1MeK;
	Fri, 11 Sep 2026 13:44:55 +0000
Received: from mail-pg1-x547.google.com ([2607:f8b0:4864:20::547])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x51Yi-0000000GmZj-3aiJ
	for kexec@lists.infradead.org;
	Fri, 11 Sep 2026 13:44:53 +0000
Received: by mail-pg1-x547.google.com with SMTP id 41be03b00d2f7-cb6cf425e86so1189391a12.1
        for <kexec@lists.infradead.org>; Fri, 11 Sep 2026 06:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789134291; x=1789739091; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=35qTFGciq12kEJU+EMJ4woELZzEj6I4YMtoPAd4aNAQ=;
        b=OwvzWeWs4bAfAC2UbV3pRD9EkBvM4zmQsCQodxTxNeL9716y16NQKjiPFR2YKGuBus
         XEu1gq9/lTNY3T1ndpYYtT0OR1Dp8HY1xjLeQnP8KhJGGPYpLTk5tmRlGxA5w+yS0BVA
         JX7tRiXffPG2I/mCuo+NA3pnhU9QFlwop2Gbop8w2/r7nHLMLE11WMsh3HYc6B6pBBZX
         JsGpv4qwiQ3+2AWoNiHBHtc3v3cf9eLDRZFL05tsyeTqAc70hcA7LVjXQ5FyYslUH9GE
         g853OLEfo4PojMZK1KrfJBjgN67EGYty50OGbWgbrsAgDfLE1oenCWJf+iMYh/4p8Nt5
         yvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789134291; x=1789739091;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=35qTFGciq12kEJU+EMJ4woELZzEj6I4YMtoPAd4aNAQ=;
        b=jYJNp1t55EK+eBuADq5SeLd9ZTyPIzNJ6xvq8K/uPJDhA+mSMzsU4R9Pl5153yZaRL
         6axue8JBVvklKSVW9c4rzsxZaUZt/4t1mQui/HuyEUd4Ke2SRkkeeguZsWEBKxxDX2M/
         GjWhztjjcaF6uQcONQdl/LlKHbrNsMbrkngnXEAtlaCp3T3ZsASqCsaIoVUnnzG4+S6p
         tRB2IAbA41rAsOy/NlF1A/teaeAk4PlJ+ovvIcmOyDzixsIu/2KJrFBuU/X6h+srcqKa
         kyvLzoE1LP4uVu8wxtGTkzTkrie70YzAdhgSeRZcrfHLzeBwyLFMnGR2j69IL7GRx51m
         xUZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzVcdeJnhMceKAQ2EoL8HWIeIYOTfGOtjHERu676j2ozbmZbMLe8uZ/7fp5ewGeZq4QRqJeGw==@lists.infradead.org
X-Gm-Message-State: AFuF++k8mYLru2Rkj79y3xmRxFDIOVEIyZISxLDQDFmY+JHoGXpuVtSb
	uI+BRDQSUkvMCIMkHxjHiI5Wsss4mwoFO2fRQGxwFW+ZBBohWbGd2BPhuzsJLA1AmK+z5yPz7is
	O0et4DA==
X-Received: from pgjj10.prod.google.com ([2002:a63:230a:0:b0:cc4:5907:21e9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:b08d:b0:3c6:61b9:917c
 with SMTP id adf61e73a8af0-3daed1fd3cfmr8633653637.11.1789134291123; Fri, 11
 Sep 2026 06:44:51 -0700 (PDT)
Date: Fri, 11 Sep 2026 06:44:50 -0700
In-Reply-To: <20260910225728.GB857650@nvidia.com>
Mime-Version: 1.0
References: <aptFFYqcSiBdMLE8@google.com> <20260905012403.GX4157646@nvidia.com>
 <aqIAtOoew-_6jw29@google.com> <20260910143448.GD3968357@nvidia.com>
 <aqLOWkuVKccR-I7W@google.com> <20260910171210.GF3968357@nvidia.com>
 <aqMgjXfTJ8u3n7Kj@google.com> <20260910221832.GH3968357@nvidia.com>
 <aqMyXE-fD-UN6w5L@google.com> <20260910225728.GB857650@nvidia.com>
Message-ID: <aqQF0gz3Q2weDyEd@google.com>
Subject: Re: [RFC PATCH 0/3] liveupdate: Move to feature flags for LUO and
 memfd ABI compatibility
From: Sean Christopherson <seanjc@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Matlack <dmatlack@google.com>, Logan Odell <loganodell@google.com>, arnd@arndb.de, 
	pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org, 
	graf@amazon.com, akpm@linux-foundation.org, pbonzini@redhat.com, 
	maz@kernel.org, oupton@kernel.org, bhelgaas@google.com, alex@shazbot.org, 
	kevin.tian@intel.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-pci@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_064452_899545_463E92EA 
X-CRM114-Status: GOOD (  18.77  )
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

On Thu, Sep 10, 2026, Jason Gunthorpe wrote:
> On Thu, Sep 10, 2026 at 03:42:36PM -0700, Sean Christopherson wrote:
> > On Thu, Sep 10, 2026, Jason Gunthorpe wrote:
> > > Sean's initial email was asking for strict never-break ABI compatability
> > > rules on top, and that is what I've been reacting to.
> > 
> > No, I was never asking for that.  I think we just have a different interpretation
> > of ABI, or rather are talking about different pieces of ABI.
> > 
> > I am still asking for never-break serialization format compatibility, i.e. the
> > more literal save/restore ABI.  I'm not asking for full backwards/forwards
> > compatibility across all kernels version, i.e. the higher level "kernel" ABI.
> > 
> > To phrase things differently: I am a-ok if kernels are inherently incompatible
> > because they fundamentally operate differently and/or support different features.
> > I am not ok if we end up with incompatible kernels because the save/restore
> > interfaces and payloads are poorly designed, lack abstraction, etc.  
> 
> I can more agree with this, it is mostly what I thought we'd end up
> doing anyhow with version numbers and growing the structs not
> replacing them.
> 
> So you still end up with a version label (string I guess?) because we
> can break it from time to time, 
   
Why bother with a label/string?  I don't understand what it buys us; I see only
pain.  Make the features discoverable and punt on all of the "is this pile of
insanity my company has created compatible with this other pile of insanity?" to
layers above the kernel.

IMO, trying to capture compatibility in a version string is doomed to fail.  To
be useful, the version would have to be extremely sensitive to changes, otherwise
userspace will have to do its own compatibility analysis/checks anyways.  And at
that point, a verson string will be too restrictive, e.g. will mismatch due to
changes in features the deployment isn't using.

> just the version should have the feature mechanism layered under it? I'm fine
> with that
> 
> Jason

