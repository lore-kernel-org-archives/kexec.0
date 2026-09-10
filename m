Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8CCC79FBB
	for <kexec@archiver.kernel.org>; Thu, 10 Sep 2026 21:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hOLKQV5MP6URX3X9jqnRFyBsWQauQYYSupdkNVN7Yn8=; b=NKAYsx6N3NY6UaWF8MXQE/8NG0
	IfE8rksRPZRtlZN8mH0dRObbCDMTyGhZ1BtL7uzDiO8kKLRuZaohNub6cwZvjcIlI55cBPDrDBmHP
	VAEeRE1YyJxZjMvwFcwEd6TRzGr1wlXld8PKNe4P/a0L/6An/VNdf0if/+0ZU7tR3PMr/6WDFUu1f
	2MlF4zWNjPb/TzZyWZXmcRmMNoxBrEHUqnWnky0EhsnEhY1Ob7bpHyhdsuZ4kaQrTMR4ft+bsolvS
	lQj15FUGFdDLU+ExZzIZRFH9BMg+LQhy/rUGrQep2RbvFXfsvXcDzgWBEpdaw+hLVhQo+c5A8pSk5
	H6Bpzs/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4mJc-0000000FPtV-2tOd;
	Thu, 10 Sep 2026 21:28:16 +0000
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4mJZ-0000000FPs4-30jU
	for kexec@lists.infradead.org;
	Thu, 10 Sep 2026 21:28:15 +0000
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2d747ed9866so1573365ad.2
        for <kexec@lists.infradead.org>; Thu, 10 Sep 2026 14:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789075692; x=1789680492; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hOLKQV5MP6URX3X9jqnRFyBsWQauQYYSupdkNVN7Yn8=;
        b=QuNHeR0hkcwXaZ55ogKmShB01OH2fmGX7gnqZ8+ej2w/SasA9WcGWrmJXmZGdI8HUc
         Bkw0a6UuP+igYd7HOUg6jHzzEkPbcHeyGUi5UE+ocJ8SSIQcvpLnMFnPWVPUxD/jT+v3
         HkPWGzz632IdxIT282CEtoaTcfQLbxlZKENoRhAk2F5VSKG/MjULHjyydrDHGTEnqSlQ
         BDylrdmwU//YtayS6kzK4S8fl7/Xevi64YPZe/sgEZwBe+T7w9QumPmIQM/t2v4dCVaK
         Q7jP+IayGc/qW7Hv9EC1UV3uQiwwltN5BPVH5ZpfijmkJJHhaahousk4Cb4dlkz+0Bv9
         0Bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789075692; x=1789680492;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hOLKQV5MP6URX3X9jqnRFyBsWQauQYYSupdkNVN7Yn8=;
        b=Dt8EGOQv9IJrDYXLzyDm7QytMP0GRg1h3iBFfR6Wt918boSn96zxmLilOK1o+aH14Q
         5YxpuuQWWvQrwtojLknwXIIk5OI695WscNtEnCI0k54qwye+XMLHnP6BsbAoXOFQKMIE
         INKiN2YD3xOtwspr6AQo8arnbmvl0up4Ag63qkHS0FSKI9Byoiyr/J5kOtcJLcIWe+Bg
         h7agiUYK5v8cmczMceAjLQu3zxzguGbn4xL6lsQiy/ek750WzAJbRGSWKxQroLeuCygA
         IgwO/8nUyT5Hq2BmDkxThfAHDsvSpNzsNXE5xIXFFwr0EsNRghV0DFyDb/iInxbwBr2B
         wJ3Q==
X-Forwarded-Encrypted: i=1; AKwUvBzJjc18YQB9bD8Jrkf67MojBPKhNu1U0dhoKdNAnlDYpthg/dyjmx7e3cEuu5EWfIaN1Y8kYQ==@lists.infradead.org
X-Gm-Message-State: AFuF++kVEcrIjnVho7mtpY4VbQP918QSPIPhyyYQmxp5HVOMJiSuOn2t
	2BRHy8dTAzwEG40XGmZbXS2SfVYW5Afb67pY+wErLXrPaC3y6SEQz2IPGAddyQrmow==
X-Gm-Gg: AYBFou2TncRelNSy4yXuK9NSQhZ/KjXr0vBNe71KeRvFqN665IQTs70Ez7gaF/8EBBM
	dwYerdg8t4v6BH6K9lX+CUYormiRUl7JfkWAEHvJMK95v1yZGCYktW9LA16YZktAhW2hksoQCrQ
	5qXGo07B0+Q9xIm7FC3zQLEDKFGgPZTLALrYUO8SlFPfVX34v6wa94W3H5wmi7Ybn2uZ0wQTm/t
	lr30z6fxTnLD5ZDGrBx3RaVxwJTfxjgivnOVw3Nk2SxB4XtFt1eLqg4iHRD7r5IVx4OLl6xYs8B
	2sqYZYmZiPNSqI3xBZf6ndFp8WVIQf6nUhNZTmVoLpFoIHZFMp6BWNpOPeB4QqqHQqCTg3wo9C4
	GyOnUoLo6hY3vM7vXgnsN/lZXExVdKH1XRVBgo68IkL2a3pjtOFbtfZc+I+ng5YkjF/GkM1It89
	nl/5SMgyDpUOYVsZdDzLFRmb8iEqWGk4rAELp5RgLBwoMH1KeuBDdUEQ7z9ahUJTTSLpZAKwVi4
	rWaPQ8Y8oT82fN/uN2R1yFDxzUL4jnhvq7xbmsu
X-Received: by 2002:a17:902:d984:b0:2d7:f0:896b with SMTP id d9443c01a7336-2dd2a33648emr23827755ad.13.1789075690962;
        Thu, 10 Sep 2026 14:28:10 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2ceb715bsm1812275ad.39.2026.09.10.14.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 14:28:10 -0700 (PDT)
Date: Thu, 10 Sep 2026 21:27:58 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Logan Odell <loganodell@google.com>, arnd@arndb.de,
	pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org,
	graf@amazon.com, akpm@linux-foundation.org, pbonzini@redhat.com,
	maz@kernel.org, oupton@kernel.org, bhelgaas@google.com,
	alex@shazbot.org, kevin.tian@intel.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/3] liveupdate: Move to feature flags for LUO and
 memfd ABI compatibility
Message-ID: <aqMgjXfTJ8u3n7Kj@google.com>
References: <20260903023452.721732-1-loganodell@google.com>
 <20260904160009.GV4157646@nvidia.com>
 <aptFFYqcSiBdMLE8@google.com>
 <20260905012403.GX4157646@nvidia.com>
 <aqIAtOoew-_6jw29@google.com>
 <20260910143448.GD3968357@nvidia.com>
 <aqLOWkuVKccR-I7W@google.com>
 <20260910171210.GF3968357@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910171210.GF3968357@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_142813_771532_F376337A 
X-CRM114-Status: GOOD (  70.67  )
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

On 2026-09-10 02:12 PM, Jason Gunthorpe wrote:
> On Thu, Sep 10, 2026 at 08:35:54AM -0700, Sean Christopherson wrote:
> 
> > I guess maybe we have a different definition of ABI? 
> > 
> > I'm not saying that upstream has to be 100% forwards and backwards compatible.
> > I'm saying the serialization payload itself should communicate what features are
> > effectively required.  I.e. *if* there are incompatibilities, they should be
> > naturally expressed in the serialization format, not communicated out-of-band
> > through magic numbers.
> 
> The ABI strings were introduced specifically because extension makes
> the actual compatibility indeterminate by userspace. 
> 
> Keep in mind the actual goal here. Someone has kernel A and they need
> to blind kexec into kernel B and NOT have the machine explode, or all
> the VMs sitting on it lost.
> 
> Meaning you must have a way to determine before the kexec if kernel A
> is producing something B will *accept*. Accept is not "parse and fail
> with EOPNOTSUPP" like most uapi schems. Aceept means bring in and
> actually fully support and use.
> 
> So how do you solve this problem? You MUST declare in some kind of
> manifest exactly what ABIs are supported, in some way.

I think this series solves this problem in a fairly clean way without
relying on version numbers.

Each ABI is now extensible with a set of structured featured flags that
are exposed to userspace. Userspace can inspect the flags that the
kernel supports and confirm the next kernel also supports them.

I think there is still room for improvement, like determining what
features are used at runtime rather than statically at compile time, or
allowing userspace to disable use of certain features to control
compatability, but I think these things can be built into this type of
model.

> > The scenario you describe fits exactly with what I am proposing.  
> 
> It does not. What is really wanted here is to tell kernel A to only
> support ABI 1 for memfd and so kernel A will fail to serialize if it
> cannot do it because a newer seal flag was used.
> 
> We do not want to succeed to serialize then fail to accept after
> kexec and have a dead machine.
> 
> This is not anything like a normal uapi compatability problem.
> 
> > actually starts using the new sealing flag, the CSP can downgrade to
> > older kernels at will.  And if the user cares about downgrading,
> > then they need to prevent the flag from being used until the new
> > kernel is rollback-safe and deployed to enough hosts to prevent
> > stockout.
> 
> Yeah, CSP broadly has to do exactly this across a wide range of
> topics. It is a further reason why this feature is not exactly usable
> by a "mainstream" user :\
> 
> > > This is why I think the very idea we can support any version pair is
> > > too much to ask for. We should focus on supporting a small set of
> > > version pairs and not making it too invasive or hard in the kernel or
> > > on the maintainers.
> > >
> > > Thus live update within a stable branch only is my proposal for
> > > upstream support.
> > > 
> > > If it really succeeds at that and it becomes very popular, then let's
> > > discuss upstreaming doing additional version combinations.
> >
> > Why on earth would we have version numbers in the first place?  IMO, monotically
> > increasing version numbers are flat out the worst way to communicate
> > features.
> 
> As above, discoverablility is a key requirement.
> 
> Each version number is a very specific upstream defined ABI, in the
> sense if kernel A emits version X and kernel B accepts version X then
> kexec *must* work.
> 
> You can make some manifest in other more complicated ways, but I'm
> deeply skeptical that is really going to bring any value. It feels
> like it is just increasing the testing matrix :\

The value I see of the flag-based approach over the version-based
approach is:

 - Each component can have one ABI struct that extends over time and one
   serialization/deserialization routines, rather than N for the N
   supported current versions. Supporting multiple versions within a
   single kernel would be required for upgrade/downgrade. Maybe there is
   a way to make the multi-versioning support maintainable but it seems
   like it will be messy to me.

 - Features can be managed individually. Let's say a downstream user
   wants to use a new upstream feature. If we had a versioning model
   they would have to backport the entire version delta from their
   current kernel to that feature upstream. With flags they can backport
   and use an individual feature.

I agree testing matrix becomes more complex but maybe that can be
mitigated with your suggestion that upstream only "officially" supports
(i.e. tests) some constrained version sets like within a stable branch?

>  
> > > > I could see things like HugeTLB not working if someone booted the kernel with
> > > > support for only 1GiB pages and then tried to feed it payload with sub-1GiB ranges.
> > > > But to me, those sorts of things fall into the "well yeah, don't do that" category.
> > > 
> > > Okay, how about worse, todays kernel has hugetlbfs and there are
> > > patches around to luo serialize that. Lots and lots of talks about a
> > > post-hugetlbfs world out there.
> > 
> > And?  Adding a compatibility layer to a future kernel so that it
> > understands an incoming HugeTLBFS payload should be trivial.
> 
> From my experience that's optimistic :(
> 
> > > Do we want to constrain what is possible to ensure we accomodate this
> > > hugetlbfs serialization? I vote no.
> > 
> > In what way is providing strong ABI guarantees for individual components
> > constraining HugeTBLFS serialization?
> 
> I bet it will. Other things we've looked at seemed to be like that.
> Even the above about "yall screwed up" with memfd has the problem
> already. I don't believe we can ever do this so right that it won't be
> constraining to the kernel internals.
> 
> > > Do we want to reject the hugetlbfs serialization until we have a year
> > > of debate outlining every possible ABI scenario? I also vote no.
> > 
> > That's a bit of a strawman argument.  Is designing a forward-looking ABI easy?
> > No, but IMO "a year" is a massive exaggeration of the effort required to come up
> > with a scheme that can survive a variety of plausible upgrade/downgrade scenarios.
> 
> Have you tried to get anything merged into the kernel lately? I've got
> lots of uncontroversial stuff pushed out past 4 months already. Some
> luo patches are close to a year already and don't even have any
> controversy.
> 
> > And again, I'm not saying we have to support infinite compatibility.  
> 
> Okay, I said same stable branch only, do you have some wider
> limitation in mind?
> 
> > > Should we make a downgrade round trip a downstream problem? I think
> > > so!
> > 
> > Hard NAK.  There will inevitably be boundaries that cannot be crossed, but I am
> > not at all ok punting on downgrades.  To me, that's basically saying "we want to
> > add just enough support upstream so that it's not too painful to carry full support
> > out-of-tree".  That completely goes against the spirit of open source and upstream
> > Linux, and I want no part of it.
> 
> I generally agree with you sentiment, but I think this is a unique
> case. I've asked around a fair bit, this is sufficiently complicated,
> requires alot of userspace that the CSPs are not open sourcing so has
> a very minimal usage foot print out side their world. I found one
> other possible user that might be more open source oriented..
> 
> So, if I was feeling unreasonable I'd say stay out of the upstream
> kernel entirely.
> 
> Though, I think this could grow and maybe some open source ecosystem
> will develop around it. I don't know. I'm willing to give it a
> chance.
> 
> HOWEVER upstream is not some kind of free outsourcing for the CSP's
> proprietary forks! Do not ask maintainers to do significant and
> burdensome work that only a CSP is ever going to consume and can only
> really work in a closed proprietary environment. There is no "spirit
> of open source" in that kind of demand. I will be NAKing anything like
> that in my subsystems, I am not signing up to do live update stable
> ABI so the CSPs alone can have a better proprietary product.
> 
> This is how I come to my conclusion that upstream should support same
> stable branch only at this point. It minimizes the burden, it is a
> decent trail of the technology, and if things go well with a quality
> open ecosystem then sure, upstream can change its mind.
> 
> Jason

