Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E660AC79F9F
	for <kexec@archiver.kernel.org>; Thu, 10 Sep 2026 16:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PjpQmguvZKqFc40yaCCUF9DxHpcHtd3drRjNMUjWpE8=; b=1bOVJr42ECshvUJe04fMyj7hHY
	5cNCs/jYe9bH5FRgsWUfA/rHP3xCA8qHLtAf9dHvttNJFkeTHx7dTz5RqtZcn1dmdfDQ6v0IOS7mm
	cbg8GlcAVFoagPl3YsX39fybI4lS/2bhCRtS26tCtrsHNCHusJF/qsR73tkGUTxmUdW9a+lmYQBy0
	lAoiez6BuQCovV37T+h7N6o+6RtWZf/nnGn53B0rpYkA/9Gs4EhKnYt1m/pLtdWJwr+mps93H/vAM
	6t6og1qJnP8/Dv2NE0eYo//2Hs0DdRIEVsWHU/+fE7aEyLIwKXT0M0J9xDSw0LvmFBHTuqEdDpFA7
	szr2VBGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4hFp-0000000Etba-20Zt;
	Thu, 10 Sep 2026 16:04:01 +0000
Received: from mail-pg1-x547.google.com ([2607:f8b0:4864:20::547])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4hFm-0000000Etau-3JZ3
	for kexec@lists.infradead.org;
	Thu, 10 Sep 2026 16:03:59 +0000
Received: by mail-pg1-x547.google.com with SMTP id 41be03b00d2f7-cc489e7a701so5548617a12.2
        for <kexec@lists.infradead.org>; Thu, 10 Sep 2026 09:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789056237; x=1789661037; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PjpQmguvZKqFc40yaCCUF9DxHpcHtd3drRjNMUjWpE8=;
        b=TbXTGGvTPOXeW2FW7YtTdPVH5CEAs0KN+f7MftuddU4GZS+JhLPZP+VZ1q1mkymi5t
         c3wNvCrsWR6ejgVnQDjkwS2Jmfv0jnmDX7uR5C9ummS5q6P9Qdhz+3NYHvXjdlC0dxFX
         xjV8+BAs5ysx1d+8ZrcA4wwXMRZucu5+BatJnTK5LGKOi/pL6m3/8FRD7XtsNADSFBso
         PhaxyYIhgyFhZaMlBCzMe4JMg8t0AXbixU6ze/CeWjI/smSbFdht76jrSg4olwVhUiPf
         3FDXAQ7ua/ab4dfl7uMbLKpPVhUPxtghWH0xoKiLQ1MDuGa8t/thUiPmYDaHv3zmES3y
         onoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789056237; x=1789661037;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PjpQmguvZKqFc40yaCCUF9DxHpcHtd3drRjNMUjWpE8=;
        b=OV3hg8wHDBdZWnVW5l9Ec/z3ZX/Bqwzen8YeydZNiKa4Xv2pSrM5+7JwHnR8EeffME
         knYK1TTiPpFH+I1tUSUge0YyrQez6oWVLesgBj99vL6+oJ7sOb6mnXhkcYkAppKPLEXx
         smCMIS3OdeWeBhG9zw+4Fg4cjK449zNdKL6nuUxmE2aHkGeJJ3/62m1i/6UxTBD5DYcr
         UbwXf6TvmUHXWx4/ZD9iqCjjRPjK2YASZrdBP52vk8CXnhQfPKCzHqEJa2gtsSgYutjA
         bwiI4AtLqTqoffvKcAY4//aWFCYr4/QpJNHlM0IMBelLsGZY4Et0IeidZSLVgVm/LahH
         SB4A==
X-Forwarded-Encrypted: i=1; AKwUvBx6qdLZzWTj6Aa4924UqH5BbbvnJj5djtnT2sqtXk3iZKNekEfRm/g5mIQOxSKWQDAfDXVe6A==@lists.infradead.org
X-Gm-Message-State: AFuF++mWnGKMdTw5mj7ofBPWIDsenhjPjefv0gWKe+JWkcT5nuWppdqd
	NZJratTis54a4t9wolFBAfE2pj0+VhyFvQEzH5X3k5FtJbfWburiD0SZOpGZjugkr60i2YNUMdm
	hRHe0rQ==
X-Received: from pgmh20.prod.google.com ([2002:a63:5754:0:b0:cc4:3b01:7730])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4303:b0:3c3:7179:a640
 with SMTP id adf61e73a8af0-3dacbd6e061mr12520616637.3.1789056236336; Thu, 10
 Sep 2026 09:03:56 -0700 (PDT)
Date: Thu, 10 Sep 2026 09:03:55 -0700
In-Reply-To: <20260905011956.GA856309@nvidia.com>
Mime-Version: 1.0
References: <anphyjFv3FhF61iB@google.com> <2vxzpkzo51wg.fsf@kernel.org>
 <anssOQFNZ2LfihbU@google.com> <2vxzik5f311e.fsf@kernel.org>
 <anyObKiZIhfok5mk@google.com> <2vxzqzjz1x5f.fsf@kernel.org>
 <aoMcqp0gr06YXAPU@google.com> <2vxzy0e3zgqz.fsf@kernel.org>
 <aoSCCTTBn9D5hqzk@google.com> <20260905011956.GA856309@nvidia.com>
Message-ID: <aqLU653FXjJjhbop@google.com>
Subject: Re: [PATCH v4 05/11] KVM: LUO: Support VM preservation across live updates
From: Sean Christopherson <seanjc@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Tarun Sahu <tarunsahu@google.com>, ackerleytng@google.com, 
	fuad.tabba@linux.dev, Andrew Morton <akpm@linux-foundation.org>, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, sagis@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	linux-kselftest@vger.kernel.org, andre.przywara@arm.com, michael.roth@amd.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, will@kernel.org, 
	vannapurve@google.com, maz@kernel.org, fvdl@google.com, kvm@vger.kernel.org, 
	oliver.upton@linux.dev, kvmarm@lists.linux.dev, alexandru.elisei@arm.com, 
	skhawaja@google.com, aneesh.kumar@kernel.org, linux-doc@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, kexec@lists.infradead.org, 
	suzuki.poulose@arm.com
Content-Type: text/plain; charset="us-ascii"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_090358_845067_8C0FF611 
X-CRM114-Status: GOOD (  45.31  )
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

On Fri, Sep 04, 2026, Jason Gunthorpe wrote:
> On Tue, Aug 18, 2026 at 09:02:17AM -0700, Sean Christopherson wrote:
> > The rule is thou shalt not break userspace.  Whether or not the
> > breakage is the result of an explicit ABI change is irrelevant.
> 
> I argued strongly for this simpler approach, I will write here the
> reasoning I gave.
> 
> Firstly, "live update" is not uABI per-say. It is not "userspace
> breaking", and it is not a "regression". It is an internal kernel
> mechanism to allow the kernel to self-upgrade. In the industry it is
> typical any of these hitless update/patch/etc schemes to only work
> between a few tightly controlled version pairs.
> 
> Asking upstream to carry a full matrix of every single version pair
> ever released is massive over-engineering and cost on upstream
> maintainers. Refusing to do this is not a uABI breakage, it is not a
> regression, it is simply a lack of a feature.
> 
> I think upstream should start by agreeing to only support forward
> going upgrades within a single stable branch. If live update becomes a
> success then maybe we could do from a stable branch to the immediate
> next stable branch too. I don't know.

From that perspective, what I am proposing actually goes a step further.  I'm
saying don't commit to supporting *any* specific versions in upstream.  Express
the feature requirements in the serialization payloads, and let userspace sort
out what kernels are compatible based on their actual usage.  The kernel may need
to provide additional discovery mechanisms, e.g. so that userspace can probe to
see what is supported, but discovery is usually fairly simple to implement and
maintain.

> This alone is already much more powerful than live patching.
> 
> The balancing issue here is the impact on the kernel subsystems
> adopting luo. Every time you change anything about the internal
> function of the subystem you now have to go test a massive version
> pair matrix to make sure everything works? No thanks.

No, the subsystem just needs to make sure that it serializes its data using the
defined ABI (where ABI here means the format of the payload and the meaning of
any flags in the header).  That should be *easier* for maintainers to handle than
trying to support arbitrary versions, because it eliminates subjectivity and
having to make judgment calls or remember magic version numbers.

> Luo is very invasive and a huge PITA at the best of times. It doesn't
> need to be even worse.
> 
> > It's probably fine for Google and other large companies that tightly
> > control their kernels and use cases, and have the resources to
> > juggle the resulting complexity, e.g. have kernel engineers on staff
> > to track feature and dependencies, coordinate and plan kernel
> > upgrades, etc.
> 
> Every downstream that wants to support luo is going to necessarily
> severely restrict the version pairs that can work. Like a RH type
> distro may only support it for 9.1.x -> 9.1.x+1 - they can carry the
> cost of figuring out how to manage their patching and compatability
> matrix on their own with the tools upstream provides.
> 
> > engineers on staff to help them thread the needle you describe
> > above.  And if supporting live update as a general feature for all
> > users of the kernel isn't being factored into design considerations,
> > then that needs to change, otherwise this is all dead in the water.
> 
> General uses can use upstream and do CVE upgrades within a single
> stable branch. That's good enough, lets start there. We don't need to
> boil the ocean.

We're in violent agreement on this point, I think we just disagree on how to
express compatibility.

> > I also don't see the point.  Maintaining a rigid save/restore ABI is
> > annoying, but it's not _hard_ (or at least, not _that_ hard),
> > especially if there's a set
> 
> I was told KVM had the smallest luo footprint of everything, so
> perhaps your perspective is different.

Only because KVM already has a massive ABI surface for save/restore.  If you
want to convince me that magic version numbers are the right approach, then show
me how KVM's existing save/restore support would be made "better" and easier to
maintain by throwing away all of KVM's save/restore uAPI and replacing it with a
versioning scheme.

> In other places luo becomes coupled to the internal datastructures of
> the kernel, we literally have to preserve lots of kernel memory
> utterly unchanged without any kind of serialization at all. 

Have to, or choose to?  I have a very, very hard time believing that it's infeasible
to define a serialization format that is decoupled from kernel internals.

> This inevitably creates restrictions on the evolution of the kernel in
> general if we can no longer change in-kernel architecture because it would
> make some data structure incompatible with a kernel 10 years old.

Only if the relevant subsystem defined a poor save/restore ABI in the first place.

> There is also a need for *downgrade*. Meaning the N+1 kernel has to
> strictly emulate the limitations and capabilities of the N kernel so
> it can be rolled back. Can you imagine the nightmare of trying to
> codify the feature progression for every single kernel release forever
> in some impossible scheme to enable this? Again, no thanks.
> 
> So, what upstream can reasonably do, that still provides real value
> without severely burdening every subsystem, is upgrades within a
> stable kernel branch only.
> 
> If some distro or CSP wants to do more, they can deal with it. They
> have a far, far simpler problem because they can exactly lock down
> their version pairs to a very small universe. They don't need a single
> kernel that can emulate 10 different releases of behaviors
> concurrently.
> 
> Jason

