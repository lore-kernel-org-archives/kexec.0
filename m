Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A23C624D6
	for <kexec@archiver.kernel.org>; Thu,  3 Sep 2026 15:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GmFek9macUO7lb98mH13+DwSxNV0cpAjOXbf35SyPVg=; b=EaZJP1WoVBhQoTezcrCYQPvtZH
	dZV7GFqgb6VSmbsYV5j2OW9o71N4oxGvZLXmO0oE3dlhTB+nb6jLite8lxiQauXI7cTFdGafruHqH
	aMtu3ubbGkA71IL6JmQzEPIIx4Zp4C4IUbH/eBzPm0FeBmSFeUDByRz3pEp6UeCZWH5VcWv7HGyue
	MOrlkTSUXRvtPPpg+them1PXgN1xbSc2ECGsdCboHxaC3DpJhjWOp42VDNTp0d6TSxfesvG85Q13V
	PNzC9u3xyHKtoZdbR595fR5e8/aB5F9q9O3HJuhNhlzoWum9jqqd1ajg2iW7/2DfvtWinoTGZFys4
	gZw+jl7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x29HO-000000000EB-3WOQ;
	Thu, 03 Sep 2026 15:23:06 +0000
Received: from mail-ej1-x646.google.com ([2a00:1450:4864:20::646])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x29HM-000000000Cx-299e
	for kexec@lists.infradead.org;
	Thu, 03 Sep 2026 15:23:05 +0000
Received: by mail-ej1-x646.google.com with SMTP id a640c23a62f3a-c252b87e9a2so197032766b.3
        for <kexec@lists.infradead.org>; Thu, 03 Sep 2026 08:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788448981; x=1789053781; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GmFek9macUO7lb98mH13+DwSxNV0cpAjOXbf35SyPVg=;
        b=C6M4+zduEKqTgPttQ5PijB8l8UwH9lXqThyZGpqNjI2+XjP7/Q5KbEOWegHnw/3c9h
         P/MdhZQz+v3z30rsj2Zz8sop0x2rQe7rmYCvQL6U49symjUO02rpGuCz8z5eNAF9r9JJ
         WUnpQSEW3Fo2pLs8XG3DG/Zc/YXH/jsiA3iUuKU7KdbltnviqeJr+f1mfA63bAIfZ2X0
         QLyvOvXK4fqqBJK1tHnOaKNxv8OQ7wTksZ3WuPoqVuelhhKd+m5FGMsHDqDRz0NBAFyB
         mFC6xnIMGXCVDZ0x5JNXz7av7sL/t41a/NxMD8TONYc8LJHqHRr/92cJcTMmI6y3N4uN
         oWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788448981; x=1789053781;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GmFek9macUO7lb98mH13+DwSxNV0cpAjOXbf35SyPVg=;
        b=gK58UOOiTLcPF6SHo9NaiMkKgpVDmOLAjKSUT10im+2SuqYwVpxzHOgYkyf92kwQEa
         B3Xdg5Rb/YZcm/JDkaM5AjbwsXpTBVqegIzy6seP2IjEnbXILtCxN9XI5eC0dQneQZl+
         ASLz5tTaXsIa/GZnwDqnve2qywVy69d51TXjuuKZwxY5cpfbfYp6WBPhp7nXjTdYFKAk
         vdnJI62WItquZd1qGJFFpeTjcXAMZraI1RdOKp0ySCgRx7q4KxF+Hf3vMyn4SwPPO7r5
         KzJXHKRwpWGrp2Ixp/9Hd4WtoIiim2WjS55QI+0QBu0s1hF2yPrKzJvRh7l9GafE4oUP
         5STQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/w54PAo+YUvcVrQk+tTh5415CekZkpmoi64YyI7OlL9ps0OiuXi8c9tRG0cuPu0YFgP6t/A==@lists.infradead.org
X-Gm-Message-State: AFuF++mGQNfEwxnUjQkBGWT9wYpUN9m7oUBAaB9R1SCLuO2AN0OO146e
	Y86lP5W0CGiQR36pKikUTg0SN5lJYxXUWNtYRquUaFSFpcWZ1HW60RPJf6nbglPTRicQzL5NBcA
	BqnUfXR6dt23lcwKEXQ==
X-Received: from ejctj4.prod.google.com ([2002:a17:907:c244:b0:c25:127e:8e75])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:d508:b0:c16:13e7:fd63 with SMTP id a640c23a62f3a-c260436b4e0mr108793366b.0.1788448981126;
 Thu, 03 Sep 2026 08:23:01 -0700 (PDT)
Date: Thu, 03 Sep 2026 15:23:00 +0000
In-Reply-To: <aohwGv6TRqPg9Dwx@google.com>
Mime-Version: 1.0
References: <anphyjFv3FhF61iB@google.com> <2vxzpkzo51wg.fsf@kernel.org>
 <anssOQFNZ2LfihbU@google.com> <2vxzik5f311e.fsf@kernel.org>
 <anyObKiZIhfok5mk@google.com> <2vxzqzjz1x5f.fsf@kernel.org>
 <aoMcqp0gr06YXAPU@google.com> <2vxzy0e3zgqz.fsf@kernel.org>
 <aoSCCTTBn9D5hqzk@google.com> <2vxzy0dzy4gn.fsf@kernel.org> <aohwGv6TRqPg9Dwx@google.com>
Message-ID: <9huzv78m2wbv.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 05/11] KVM: LUO: Support VM preservation across live updates
From: tarunsahu@google.com
To: Sean Christopherson <seanjc@google.com>, Pratyush Yadav <pratyush@kernel.org>
Cc: ackerleytng@google.com, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, dmatlack@google.com, 
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
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260903_082304_599617_6F8FBFB4 
X-CRM114-Status: GOOD (  60.33  )
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

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Aug 21, 2026, Pratyush Yadav wrote:
>> Hi Sean,
>> 
>> On Tue, Aug 18 2026, Sean Christopherson wrote:
>> >> Does this idea of "backwards compatibility" sound acceptable to you, at
>> >> least at a high level?
>> >
>> > No.
>> >
>> > It's probably fine for Google and other large companies that tightly control their
>> > kernels and use cases, and have the resources to juggle the resulting complexity,
>> > e.g. have kernel engineers on staff to track feature and dependencies, coordinate
>> > and plan kernel upgrades, etc.
>> >
>> > It's not acceptable for upstream, where downstream consumers often run a distro
>> > kernel, have much more varied use cases, and don't always have a horde of kernel
>> > engineers on staff to help them thread the needle you describe above.  And if
>> > supporting live update as a general feature for all users of the kernel isn't
>> > being factored into design considerations, then that needs to change, otherwise
>> > this is all dead in the water.
>> >
>> > I also don't see the point.  Maintaining a rigid save/restore ABI is annoying,
>> > but it's not _hard_ (or at least, not _that_ hard), especially if there's a set
>> > of well-documented best known practices that subsystems can follow, e.g. so that
>> > individual subsystems don't need to learn painful lessons first-hand.  I genuinely
>> > believe that maintaining the version hell you describe above would be more costly
>> > in the long run than simply committing to full backwards compatibility within a
>> > given subsystem.  I can imagine that enumerating what subsystems' information is
>> > in the payload will require a different scheme, but for a given subsystem, I don't
>> > see any reason to aim for anything less than full backwards compatibility.
>> 
>> Let's say for argument's sake that we commit for a fully stable
>> backwards compatible ABI. Even then, you have to deal with multiple ABI
>> versions.
>> 
>> Live update's ABI is more complex compared to KVM's save/restore ABI.
>> For the KVM save/restore uAPI, you are largely describing architectural
>> state like CPU registers, etc. These things don't evolve as fast and
>> more or less stay the same.
>
> Right, because nothing meaningful has changed in any architecture in the 20+
> years since KVM has provided save/restore support, whereas guest_memfd looks
> nothing like it did when it was introduced three years ago.
>
>> Live update needs to describe the state of kernel objects. These are
>> more complex
>
> LOL, you might be the first to claim x86 virtualization isn't all that complex.
>
>> and evolve faster.
>
> The speed at which things change doesn't automatically mean we shouldn't strive
> for backwards compatibility.  Yes, providing backwards compatibility requires
> additional care and planning, and over time *might* lead to an ABI that is
> difficult to maintain.  But IMO, that just makes it all the more important to
> get the design right the first time, not that we shouldn't even try because it's
> hard.
>
>> For example, say you merge guest_memfd preservation today. Some time
>> later, someone comes up with a more efficient data structure to track
>> the folios in the file. You _have_ to make a backwards-incompatible ABI
>> change to use this data structure.
>
> Only if those details bleed into the ABI/contract.  I actually have a concrete
> KVM (well, virtualization) example for this.
>
> Intel's VMX architecture disallows direct memory accesses to the VMCS, and instead
> requires software to access the VMCS via dedicated ISA, using architectural encoding
> numbers to reference VMCS fields.  I.e. VMX decouples how data is stored in memory
> (the data structures) from the ABI/contract with software (VMCS field encodings).
>
> This allows Intel to optimize the data structures to be more efficient and performant
> for each microarchitecture based on the features and properties of each uarch, all
> without breaking backwards/forwards compatibility with software.
>
> My favorite esoteric example is AR_BYTES packing.  For Haswell, Intel added an
> optimization in ucode to allow saving/loading segment register state in a single
> uop (IIRC).  The optimization was especially valuable for virtualization as it
> shaved cycles off the VM-Enter/VM-Exit hot paths.  A key piece of the optimization
> was it required the AR_BYTES metadata to be stored in 16 bits, but existing CPUs
> stored AR_BYTES using 32 bits in an "unpacked" format.
>
> Fortunately, because the in-memory representation was decoupled from the contract
> with software, Intel could pack AR_BYTES into 16 bits for Haswell+ and pack/unpack
> the data on VMWRITE/VMREAD, so that the format presented to software remained
> unchanged.
>
> Does VMX's decoupling of the in-memory represntation of a VMCS have downsides?
> Absolutely.  Most notably, it incurs extra complexity (in software and hardware)
> to achieve comparable performance to directly accessible data structures (AMD's
> VMCB and Hyper-V's eVMCS) for nested virtualization.  And I'm sure it has placed
> contraints on Intel's designs, and obviously introduces complexity into the
> overall system by adding a layer of indirection.  But IMO the VMX architecture
> has been a huge win overall for Intel.
>
>> Or say you add a new memory backend (like the HugeTLB patches in
>> flight). That likely will need a different ABI to describe the state of
>> the guest_memfd.
>> 
>> So you will end up with multiple ABI versions that aren't always
>> backwards compatible.
>
> No, you end up with *features* that aren't backwards compatible.  I can't imagine
> anyone will argue that we should never add new features because then we can't
> rollback to an older kernel.
>
> But adding a new feature shouldn't break the existing ABI.  E.g. adding support
> for HugeTLB in guest_memfd shouldn't prevent rolling back to an older kernel when
> the HugeTLB functionality isn't being used.
>
> Using AMD's VMCB and Intel's VMCS as examples, literally every major new AMD/Intel
> uarch extends the VMC{B,S} in some way, but without fail it's always done in a way
> that is backwards compatible with existing software.  I.e. AMD and Intel ship new
> features, but existing software continues to work, and VMs continue to be migratable
> across CPU generations[*], with the obvious restriction that migrating a VM using
> a feature introduced on generation N to a generation N-1 CPU isn't a smart idea.
>
> [*] There are exceptions.  E.g. Intel removed MPX, and so VMs with MPX can't be
>     migrated to newer CPUs.  Migrating between CPUs with different MAXPHYADDR is
>     sketchy (and simply not done by some CSPs) because neither AMD nor Intel
>     virtualizes MAXPHYADDR.  But those exceptions are absolutely Big Deals that
>     undergo significant scrutiny, from all parties involved.
>
>> If you refuse that idea too, then KVM live update will be dead in the
>> water for a different reason. It will be damn near useless because it
>> can't keep up with an evolving subsystem.
>> 
>> Now once you get multiple ABI versions and you can seamlessly go from
>> old to new one, say you have a version that was superseded 5 years ago.
>> It would be completely reasonable to say that this version is old enough
>> and no one should be going from a 5 year old kernel to a modern one.
>
> LOL, Google literally does this.  Granted, the extreme cases only happen for
> stragglers, and I think we do force VMs to bounce through a "middle" kernel in
> those cases, but I doubt Google is the only company that runs frankenkernels
> for an absurd number of years for a variety of reasons.  E.g. 4.4 LTS was officially
> supported for 6 years, and I'll bet dollars to donuts people ran it for much longer
> than that.
>
>> So you deprecate this ABI. Deprecating old unused uAPIs is not unprecedented.
>
> When there are provably no users, or we can convince existing userspace to migrate
> to an alternative.
>
>> I think we are better off formalizing this deprecation period from the
>> get go.
>
> Why?  What does it buy us?  Because all I see is potential abuse and an excuse
> for not spending time getting the designs right.
>
>> A somewhat tangential example is BPF kfuncs. My BPF program that works
>> in kernel X might not work in kernel Y because the kfunc has changed or
>> been removed.
>> 
>> The argument they make in kfuncs.rst is that kfuncs "provide a kernel
>> <-> kernel API, and thus are not bound by any of the strict stability
>> restrictions associated with kernel <-> user UAPIs".
>
> BPF's documentation isn't arguing anything, it's merely reiterating Linux's
> long-standing policy that there is no such thing as a stable kernel ABI (in upstream).
>
>> For LUO as well, this is a kernel -> kernel API.
>
> Stating the obvious, I disagree with this.  As I said before, if this is the
> stance LUO wants to take, then so be it, but my NAK stands.
>
>> Users can also still do a regular kexec or reboot. They just won't get the
>> performance optimization of LUO.
>
> The amount of time, energy, and money poured into minimizing VM downtime on live
> migration suggests the overwhelming majority of LUO's targeted users aren't going
> to take kindly to this stance.
>
>> Regardless of if you agree with the last bit about deprecating old
>> versions, ABIs evolving with the subsystem is a ground reality of live
>> update and it would be foolish to think we can do with only
>> backwards-compatible ABI changes forever.
>
> I never said the ABI is immutable, I said it needs to be backwards/forwards
> compatible.


Thanks Sean, Pratyush. @loganodell has recently sent the RFC[1] on
backward compatibility for liveupdate. This discussion is important
so I propose to move the backward compatibility discussion on [1].

For guest_memfd preservation, I will sent v5 soon with the following
changes:
1. Suggestions from across the patches
2. tentative Plan for future Guest_memfd preservation
3. tentative Plan for VM preservation.
4. Backward compatibility built on top of RFC [1]

What do you think?

[1]: https://lore.kernel.org/all/20260903023452.721732-1-loganodell@google.com/








