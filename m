Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE79C5DF81
	for <kexec@archiver.kernel.org>; Tue, 18 Aug 2026 16:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mHrQKH+zHwT+WPXcscvHx+YAi87Fp0trF0xTLxVXA3U=; b=OTaOhHwkKQbzqX8Qt2/Cd8lPXd
	Tlz8tDvGx8mKCkHufY9DKlISjwYDoLaqOIRR4L4tsfocwwR0nrou+7D1lQY/9IvqP2j6iZLjI0vMR
	3OopRstGwZGSfbSils4vaZnIjcCm1uZznB2vHv938OPbhsejp9NPIGIUZAy8SmC+Sqgsc4YqbZlNr
	Qt0yewoJHkK3CsUIYNOImfcBfAit2kcdm8Nk29bU84KNq/ARAE/lry9mumHdaSvWqhORZzJ3ikjvr
	qIbfUMMHBY1Ue2iW6/lGDBg/YO7ak/vi+l0NcindGhOTaVDcc7Twb9VOHCvjCiUtzd6+AsQun7c32
	e9t4wQVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwMOd-00000008K7L-3R8Z;
	Tue, 18 Aug 2026 16:10:39 +0000
Received: from mail-ed1-x548.google.com ([2a00:1450:4864:20::548])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwMOZ-00000008K6F-0IWb
	for kexec@lists.infradead.org;
	Tue, 18 Aug 2026 16:10:38 +0000
Received: by mail-ed1-x548.google.com with SMTP id 4fb4d7f45d1cf-69cd6606b19so5352a12.1
        for <kexec@lists.infradead.org>; Tue, 18 Aug 2026 09:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787069432; x=1787674232; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mHrQKH+zHwT+WPXcscvHx+YAi87Fp0trF0xTLxVXA3U=;
        b=YpsU6BrP5ce8LNt1XbnoxjL/vx02nlk3DFLucmJQI5KVcrrvtZeyRf3inlpnfOVFYS
         Bii9c01Mjp199vERspsJAWHHeMWE5wGcEOL7OZCJKG7FZZ8xLAe+QI13eVRVoOl/iI4p
         KcKNJGkZuZnGj0pGR/2n7kKdWnYKUf/apIr3Ix27LaUqLFh8wu3T0lEXBwGUL7ZPi/O/
         GmpsuRkfLvh82BNF6J9I1o4YCrEAheeyIiZH0VSLQCWaaqBkeKHfejyRe3d6evc2alNF
         tcLlZPInrU9D+sERYyjAqnNeK2b32qYwwmICXN5cNMLW4Zcm1VqiJNEQMUFrG0VwethC
         9V/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787069432; x=1787674232;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mHrQKH+zHwT+WPXcscvHx+YAi87Fp0trF0xTLxVXA3U=;
        b=AHHuZZW1mhKoJ/5qE+4m4s5keJ+C/WC9HeViUG9wU0O+LtDZ1JKnHGKSlFpPSqQEDe
         XSRcpaMItqbav8QB9pqbohFi5F0qgLs2UCFAc+sZOh7jo4kbkTEKPkCXcKsp/cWN5h7N
         gEdVE6GQZk42PDdoBsTg0lr6TH8fYBrzDKCRUY5Tp3bCBv26UIf/KKaDVGHmJcYIS0Gy
         EmyPpsnj4MIfgPD+BzKdHoK5aUyQV7o8+GMsIF0wbfbLUv2NINdMwHMx9C78GLbZsAIk
         WgwyZU/LAN6Wju6rrLCogE3wXbHK1Ad6Sug5OwtJikQzs2XKW6s8KrqH0+S2hsNJ4/Ex
         9pWw==
X-Forwarded-Encrypted: i=1; AHgh+RrTGUGhr5NfgJBnMMxP5kG6PuLuENvhVo7kMp0jmsiF6MTFDrd9uPraacLW/CzcntTwKe+/Cw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwrZ7O66tA+fxlXFFLg4gZNwTRbly4F2mtxu+rQ0Ue0H0Do3ucM
	uIVyyEh7tQ6mNPHX7PaJvqvLMZB1SMIgrvRchyWEr2wENygVn0hXXO68MJAe4K35WMQ+gvuGuXD
	uW+xUa/ZIL7WL9jUAKA==
X-Received: from edts26.prod.google.com ([2002:aa7:cb1a:0:b0:6a1:f410:2ec5])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:210b:b0:6a0:a4f5:f4eb with SMTP id 4fb4d7f45d1cf-6a3e0fed785mr5782524a12.4.1787069432349;
 Tue, 18 Aug 2026 09:10:32 -0700 (PDT)
Date: Tue, 18 Aug 2026 16:10:31 +0000
In-Reply-To: <anssOQFNZ2LfihbU@google.com>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-6-tarunsahu@google.com> <anphyjFv3FhF61iB@google.com>
 <2vxzpkzo51wg.fsf@kernel.org> <anssOQFNZ2LfihbU@google.com>
Message-ID: <9huzo6ezv288.fsf@tarunix.c.googlers.com>
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
X-CRM114-CacheID: sfid-20260818_091035_194667_ED762AE5 
X-CRM114-Status: GOOD (  49.65  )
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

> On Tue, Aug 11, 2026, Pratyush Yadav wrote:
>> On Mon, Aug 10 2026, Sean Christopherson wrote:
>> 
>> > On Tue, Jul 28, 2026, Tarun Sahu wrote:
>> >> Register a Live Update Orchestrator (LUO) file handler for KVM VM files
>> >> to serialize and deserialize VM state across kexec live updates.
>> >> 
>> >> Currently, Only VM type (e.g. arch.vm_type on x86) is preserved as part
>> >> of VM preservation.
>> >
>> > Why?
>> >
>> >> On retrieval, kvm_luo_retrieve() recreates the KVM VM file via
>> >> kvm_create_vm_file() and use an atomically incremented ID for the internal
>> >> fdname, as the final fdname assigned by userspace is not yet known during
>> >> retrieval. As this fdname is only used in debugfs infra, This will not break
>> >> any UAPI.
>> >> 
>> >> This infrastructure establishes the foundation for preserving guest_memfd
>> >> instances across live updates, and can be expanded in the future to
>> >> preserve additional VM state.
>> >
>> > Uh, why guest_memfd?  As much as I want to push guest_memfd adoption, it seems
>> > guest_memfd should be the _last_ thing we support, not the first.  As evidenced
>> > by the last two decades, it's very doable to have KVM VMs without guest_memfd,
>> > but it's rather hard to have VMs without vCPUs.
>> 
>> You _can_ preserve vCPUs today using KVM_{GET,SET}_REGS, they just won't
>> run in the background during the reboot.
>
> What about x86 CoCo VMs?  Which are quite literally _the_ reason guest_memfd was
> created in the first place.
>
>> This series can save you from dumping VM memory to disk if it is backed by
>> guest_memfd.
>
> Or to word it another way, one _can_ save guest_memfd, it's just
> slower.
>
>
> My point is that this series needs to provide a _lot_ more information about the
> bigger KVM picture.

Yes, I agree. I will try to layout the plan.

End goal of this series is to preserve VM memory which is backed by
guest_memfd. Not all VM are backed by guest_memfd. So preservation of
KVM (vm_file) is independent of preservation of guest_memfd.
But guest_memefd can not be preserved without preserving the KVM (vm_file).
So I agree to your suggestion:

diff --git virt/kvm/Makefile.kvm virt/kvm/Makefile.kvm
index d047d4cf58c9..e6f098498795 100644
--- virt/kvm/Makefile.kvm
+++ virt/kvm/Makefile.kvm
@@ -13,3 +13,8 @@ kvm-$(CONFIG_HAVE_KVM_IRQ_ROUTING) += $(KVM)/irqchip.o
 kvm-$(CONFIG_HAVE_KVM_DIRTY_RING) += $(KVM)/dirty_ring.o
 kvm-$(CONFIG_HAVE_KVM_PFNCACHE) += $(KVM)/pfncache.o
 kvm-$(CONFIG_KVM_GUEST_MEMFD) += $(KVM)/guest_memfd.o
+
+ifdef CONFIG_LIVEUPDATE
+kvm-y += $(KVM)/kvm_luo.o
+kvm-$(CONFIG_KVM_GUEST_MEMFD) += $(KVM)/guest_memfd_luo.o
+endif

Guest_memfd can't be created alone without struct kvm
(kvm_gmem_create() and KVM_GMEM_CREATE ioctl). This is how
guest_memfd has been designed. I don't want to break this design which
has been accepted upstream after lot of discussion.

So while LUO preserve guest_memfd's data, It just preserve the PFNs
value, few flags that belongs to the guest_memfd.

On restore side in new kernel, These PFNs, flags will be populated
to a _newly_ created guest_memfd. that is how preservation and
retrieval works. So To create this new guest_memfd, We need struct
kvm (vm_file). this vm_file must be the same VM which had this
guest_memfd in old kernel, So we preserve the vm_file, get its TOKEN
preserve with guest_memfd and during restore, we create the guest_memfd
with the same VM (vm_file/struct kvm).

I agree, I did not do good job explaining things in commit message. I
will make sure to update them in next revision.

> For those of us that are on the very fringes of live update,
> it's practically impossible to review because, to us, it seems very arbitrary.
>
> The part that's especially confusing is the saving of the VM type.  That comes
> straight from userspace, so it's super bizarre to automatically save/restore that,
> but nothing else.

Like, guest_memfd needs struct kvm to create itself. struct kvm (vm_file) needs
vm_type to create itself (kvm_create_vm() or KVM_CREATE_VM IOCTL). LUO
does not provde functionality to pass any subsystem specific arguments. So
vm_type needs to be preserved even though, userspace is aware about it.

So Why do we preserve only vm_type:  To keep things simple for this
series, As target is guest_memfd.

Currently I dont have discreet plan on what else will
,in future, be needed to be preserved. Which I agree not a absoulute right
way to approach. I will layout a rough plan on KVM side preservation.

Having this need for backward compatiblity: I responded here:
https://lore.kernel.org/all/9huzv797v45k.fsf@tarunix.c.googlers.com/



>
>> >> +KVM LIVE UPDATE
>> >> +M:	Pasha Tatashin <pasha.tatashin@soleen.com>
>> >> +M:	Mike Rapoport <rppt@kernel.org>
>> >> +M:	Pratyush Yadav <pratyush@kernel.org>
>> >> +R:	Tarun Sahu <tarunsahu@google.com>
>> >> +L:	kexec@lists.infradead.org
>> >> +L:	kvm@vger.kernel.org
>> >> +S:	Maintained
>> >> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
>> >
>> > NAK on taking changes through a different tree.  This is KVM code, period.
>> >
>> > In general, I'm skeptical of the dedicated MAINTAINERS entry.  It's extremely
>> > difficult to tell since this series is little more than a skeleton (either that
>> > or liveupdate is way simpler that I was expecting), but I suspect that maintaining
>
> ...
>
>> > E.g. the LUO APIs seem pretty straightforward; I assume the bulk of the complexity
>> > is going to be in knowing what to save/restore, and how, which is much more about
>> > KVM than it is about liveupdate.
>> 
>> I think it is fine if you want to take these changes through the KVM
>> tree, but I would like live update maintainers to be listed as reviewers
>> at least.
>
> Why not simply add a file pattern match to the LIVE UPDATE entry?
>
> diff --git MAINTAINERS MAINTAINERS
> index 8014b9f8253e..2eb57b22c37f 100644
> --- MAINTAINERS
> +++ MAINTAINERS
> @@ -15052,8 +15052,8 @@ F:      include/linux/liveupdate.h
>  F:     include/uapi/linux/liveupdate.h
>  F:     kernel/liveupdate/
>  F:     lib/tests/liveupdate.c
> -F:     mm/memfd_luo.c
>  F:     tools/testing/selftests/liveupdate/
> +N:     [^a-z]luo
>  
>  LLC (802.2)
>  L:     netdev@vger.kernel.org
>
>> At the same time, I also keep being (pleasantly)
>> surprised at preservation being relatively simple. For example, the code
>> to preserve a shmem file (via memfd) is roughly 600 lines, a big chunk
>> of which is comments. The code of course has some limitations, but it is
>> good enough for use in production.
>> 
>> For one, we care about ABI breakages and versioning. 
>
> Which is amusing to me because that implies KVM does not, and I would hazard to
> guess that KVM has the biggest ABI surface of any subsystem in the kernel by a
> country mile (though I'm probably wildly underestimating the effective ABI surface
> of filesystems).
>
>> The serialized state is a part of live update ABI and changes to it should be
>> ACKed by us. 
>
> Meh, "Don't break userspace" is a universal rule in the kernel, I genuinely don't
> see why liveupdate needs special treatment.
>
>> For another, how the file handlers interact with their dependencies can
>> affect the behaviour that VMMs observe. Those changes should also pass by
>> some live update eyes.
>
> Perhaps in the short term, but IMO, that's not a winning strategy in the long
> term.  From my perspective, that like saying the PAGE CACHE maintainers should
> review every usage of the filemap APIs, because how the APIs are used impacts
> the page cache and affects userspace-visible behavior.  There are myriad analogies
> like that throughout the kernel.
>
> Yes, liveupdate is new and shiny, but IMO for it to be successful and maintainable,
> it needs to be treated like any other core infrastructure in the kernel, not a
> special snowflake whose details are known only by a handful of people.  Because
> I think it's likely liveupdate goes one of two ways: either liveupdate becomes a
> very niche thing that is used sparingly throughout the kernel, or it becomes a
> broadly used feature that is supported by many filesystems and subsystems.
>
> If liveupdate is relegated to niche status, then it probably isn't going to see
> a significant amount of ongoing development, at which point the folks working on
> liveupdate will naturally migrate to other projects, and maintenance will largely
> be left to subsystem maintainers.
>
> If liveupdate is broadly used, then having a single group of people maintain
> every subsystem's usage won't scale, and maintenance will again largely fall on
> the shoulder of subsystem maintainers.  Which is totally fine and working as
> intended, because that's exactly what subystem maintainers are signing up for
> by merging support for liveupdate.

