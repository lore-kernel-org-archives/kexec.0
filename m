Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7425C88E41
	for <kexec@archiver.kernel.org>; Thu, 10 Sep 2026 15:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2+MOwVd/hSplAvFbBk52yvKLS3w7cDWTRO3ieRL0csc=; b=YnWyBCGLBxg7yxaG6BOUUtcPoo
	6/5w3vX+QvQ9cLhvQnVErn1KfFW9xrr5Gj/n88aPAyblWanSMGXNxVYA6UfpV7yHo+5Qmc+fYbHZm
	sFVga+xfRlG+syI8yOi5sRqrLrUDGxhADBVXYcLivphYmpx0FCu44BFtqLflPacPU2/rxR5thVivw
	+xcFxnFQo3Ydd03k8ekp8Sol1EFfVGZJY6JcheBnNCEz5U+8395Mu/5Z+UaXnv96YWf2gk9/KI9cY
	Woz9EaujLteSllrprO5DXGXTeVMQu78y6tCnEeQDaYZ6xV3ZycW2HZIoH7DENkFN4vUf9yGma99PI
	bZFk2mPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4goh-0000000EoEF-33SE;
	Thu, 10 Sep 2026 15:35:59 +0000
Received: from mail-pl1-x645.google.com ([2607:f8b0:4864:20::645])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4gof-0000000EoCT-0D4m
	for kexec@lists.infradead.org;
	Thu, 10 Sep 2026 15:35:58 +0000
Received: by mail-pl1-x645.google.com with SMTP id d9443c01a7336-2ccb6823efcso74824595ad.0
        for <kexec@lists.infradead.org>; Thu, 10 Sep 2026 08:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789054555; x=1789659355; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2+MOwVd/hSplAvFbBk52yvKLS3w7cDWTRO3ieRL0csc=;
        b=i4067qxb3NGzOipqPmKN6x37anplWN2BA8DjmfZA7QVlKx9Xv/2K2bVDahYktTgdu2
         d1tLhzqRMFd880+Y6KZikHj6s8FQvKN1hBFD/1715lYp1os7w30QdF+YfsdK3BqUUNG/
         CytG/w/u8Nb31c7Js32jXwKRjmJIQiAyQuJVOb/TbY6uHd7Xe6eIvDx80qKboFnQKxVh
         ZrtBwb03xmFQGI3HOENR+8m/AoZnxyGBcfqGeFrakkjLXjkFK7xqVtXF8cNI6FSKciKV
         YJ4ivfu99A8EBv6S6VVOSlUxKz9q8tCAQ0tRa0dDuOLL/EWfRIj/+Z0eMih++BLpeUPi
         ZdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789054555; x=1789659355;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2+MOwVd/hSplAvFbBk52yvKLS3w7cDWTRO3ieRL0csc=;
        b=JptyR7qtOIadJseHn+wTpTCi6rr5WczSdGLcn05/Vfz51UeVeEnpQfd3V3QowKGZm8
         z3Y4d5/FEnXEQiMgMk5PIawL5wHPPDDxhJk7YzOO4wiXS1JRsXnv1O09EpBtQ2USNwaf
         eKSy9KTX5Y6w7RM3+K2OWbSRz7rhxxKkP57jELo+xacLrvYftpcbC3rAwVzJVvLqDyfn
         piaEEEmX+Cpazh/c+HA7CEOxOX7hIDAAMgPp7hNOwRER5Z8/EmxusGIeTBEBlkFckjeV
         VZKEwQSAGbZicVJClAYzJhqFAa4EXJTN9FqCO1Hc9kW4l4Ct+e9JTd2dBq5X+NAILBqX
         DAug==
X-Forwarded-Encrypted: i=1; AKwUvBzBIEamyfnEXoBluare1Bz494MeY3jGLC/wC9qggsxV9miPqPw46K84gMWD07/OifFJD4hTzg==@lists.infradead.org
X-Gm-Message-State: AFuF++lAc1Lsv5SmFxAJr6HpVozKQo+ujZmXhz0KCvngpVlFLw5xe0+H
	kCNcDcVHkxVXA08WQFV5MLDXZNqFsAzantD6h3/5Yo1aQB+/TUipvThmIsqIj5UvPTLbilCwWfV
	+x2RC0A==
X-Received: from pjbdt17.prod.google.com ([2002:a17:90a:fa51:b0:39d:8f18:feb5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:6081:b0:39b:51cc:4586
 with SMTP id 98e67ed59e1d1-39b51cc65admr27199424a91.19.1789054554982; Thu, 10
 Sep 2026 08:35:54 -0700 (PDT)
Date: Thu, 10 Sep 2026 08:35:54 -0700
In-Reply-To: <20260910143448.GD3968357@nvidia.com>
Mime-Version: 1.0
References: <20260903023452.721732-1-loganodell@google.com>
 <20260904160009.GV4157646@nvidia.com> <aptFFYqcSiBdMLE8@google.com>
 <20260905012403.GX4157646@nvidia.com> <aqIAtOoew-_6jw29@google.com> <20260910143448.GD3968357@nvidia.com>
Message-ID: <aqLOWkuVKccR-I7W@google.com>
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
X-CRM114-CacheID: sfid-20260910_083557_089547_E82225A9 
X-CRM114-Status: GOOD (  56.01  )
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
> On Wed, Sep 09, 2026 at 05:58:28PM -0700, Sean Christopherson wrote:
> > On Fri, Sep 04, 2026, Jason Gunthorpe wrote:
> > > On Fri, Sep 04, 2026 at 10:24:21PM +0000, David Matlack wrote:
> > > 
> > > > The proposal here (which is inspired by the KVM UAPI) is to ensure every
> > > > LUO ABI struct has 2 properties:
> > > > 
> > > >  1. A field to encode options/features (e.g. u64 flags).
> > > >  2. A way way to grow without breaking backward compatibility (e.g. so
> > > >     we can add new fields).
> > > > 
> > > > Each flag can mean whatever it needs to. e.g. It can indicate the
> > > > precence of one or more fields (i.e. new fields in the struct), or it
> > > > can mean a field now has a different meaning (i.e. union in the struct).
> > > > 
> > > > This would enable adding support for new features without breaking
> > > > backward compatibility. Downstream users would have to ensure their
> > > > kernel does not start using a new feature while it can still rollback to
> > > > a version that does not support the new feature.
> > > 
> > > This was never the biggest problem. The main issue was the functional
> > > behaviors of the kernel that cannot be represented simply as data in a
> > > struct with some flag bits.
> > > 
> > > Like for instance kernel A supports memfd folio sizes far larger than
> > > kernel B because we fixed MAX_ORDER. You can't fix that just with
> > > simplistic flags.
> > 
> > Can you elaborate on why the folio sizes matter?  Honest question, because I don't
> > understand why the serialization format wouldn't express things as "N contiguous
> > pages starting at PFN X".  Then the implementation would rebuild its folios as
> > appropriate.
> 
> That's an idyllic view, yes, but my point is (IIRC) we didn't do
> exactly that for memfd.

Well, y'all screwed up then.  I don't see why past mistakes should force other
subsystems to support a flawed implementation.  Learn from the mistakes, add v2
of serialization for memfd, and move on.

> Sometimes you can do more and more work to try and be more and more
> general but this is *alot* of work and even then eventually hits
> problematic limits. Like what do you do with the sealing flags? That's
> ABI breaking if the successor does not support them, and downgrades
> make exactly that possible.
>
> A CSPish user can do things like patch the new sealing flag into their
> current kernel (while preventing userspace from using it), ensure
> everything is updated to that, then jump ahead to a newer kernel and
> enjoy the new flag with full downgrade support. There is so much more
> control on their part that makes the problem far more managably simple
> that upstream does not get to have.

I guess maybe we have a different definition of ABI? 

I'm not saying that upstream has to be 100% forwards and backwards compatible.
I'm saying the serialization payload itself should communicate what features are
effectively required.  I.e. *if* there are incompatibilities, they should be
naturally expressed in the serialization format, not communicated out-of-band
through magic numbers.

The scenario you describe fits exactly with what I am proposing.  Until something
actually starts using the new sealing flag, the CSP can downgrade to older kernels
at will.  And if the user cares about downgrading, then they need to prevent the
flag from being used until the new kernel is rollback-safe and deployed to enough
hosts to prevent stockout.

> This is why I think the very idea we can support any version pair is
> too much to ask for. We should focus on supporting a small set of
> version pairs and not making it too invasive or hard in the kernel or
> on the maintainers.
>
> Thus live update within a stable branch only is my proposal for
> upstream support.
> 
> If it really succeeds at that and it becomes very popular, then let's
> discuss upstreaming doing additional version combinations.

Why on earth would we have version numbers in the first place?  IMO, monotically
increasing version numbers are flat out the worst way to communicate features.

I am completely against supporting any scheme that relies on magic version numbers.
It creates problems where none need exist, and checking for compatibility can't be
sanely done in a programmatic way, because by definition it relies on magic numbers.

E.g. if the ABI for a given component hasn't changed, why should anyone care if
the overall "version" of the kernel is ahead or behind by N kernels?

> > I could see things like HugeTLB not working if someone booted the kernel with
> > support for only 1GiB pages and then tried to feed it payload with sub-1GiB ranges.
> > But to me, those sorts of things fall into the "well yeah, don't do that" category.
> 
> Okay, how about worse, todays kernel has hugetlbfs and there are
> patches around to luo serialize that. Lots and lots of talks about a
> post-hugetlbfs world out there.

And?  Adding a compatibility layer to a future kernel so that it understands an
incoming HugeTLBFS payload should be trivial.  I can totally see not wanting to
support serializing a post-HugeTBLFS kernel's memory representation into the "old"
format, though even that probably wouldn't be all that difficult.

> Do we want to constrain what is possible to ensure we accomodate this
> hugetlbfs serialization? I vote no.

In what way is providing strong ABI guarantees for individual components
constraining HugeTBLFS serialization?

> Do we want to reject the hugetlbfs serialization until we have a year
> of debate outlining every possible ABI scenario? I also vote no.

That's a bit of a strawman argument.  Is designing a forward-looking ABI easy?
No, but IMO "a year" is a massive exaggeration of the effort required to come up
with a scheme that can survive a variety of plausible upgrade/downgrade scenarios.

And again, I'm not saying we have to support infinite compatibility.  If some
future kernel drops HugeTLBFS, and we decide not to provide a shim to support
downgrading (which IMO is totally reasonable), then it's on the user to understand
that moving to that new kernel is a one-way street.  Given that dropping something
like HugeTLBFS would require significant changes in the software stack, I think
it's perfectly fine to put the burden of understanding the implications on the end
user (though realistically, there would be a copious amount of documentation and
deprecation warnings).

> Should we make a downgrade round trip a downstream problem? I think
> so!

Hard NAK.  There will inevitably be boundaries that cannot be crossed, but I am
not at all ok punting on downgrades.  To me, that's basically saying "we want to
add just enough support upstream so that it's not too painful to carry full support
out-of-tree".  That completely goes against the spirit of open source and upstream
Linux, and I want no part of it.

