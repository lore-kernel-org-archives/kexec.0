Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD641C5CFCF
	for <kexec@archiver.kernel.org>; Wed, 12 Aug 2026 15:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=97wksvVZ+thl5LcpXUGbBxNzodsfrcBWwlOTdvF+br0=; b=yWEFGB+6uYzPVaZY567rp/kgLK
	mJdXa3KxqcyZwFzkjHSqiEHv87nzDz3k6IfDXIe75J9ue492ZWaRrA89CO101GYsZ/UkzYjBWP4t0
	s9Z43ArY3k4P2rWMmxb25VWcrNyqJ2Fhpnb81YlxUGroXcHStfMLvtLHIkgwJJSZpsbs/kejjG7IC
	ze2TFpfIkNLLpH0ty1aggYKAhJqcc7e1bOGJYy++t76HwD0t3f+NhK+R4wVBYmEBucwM7k+IppkEW
	ZPFYIAPiNqG9kVT2UUFF5G05XPyU43z0Ua35XlSf/PSQAoFTOu6ytaqDvP+nDtJbFQiS9XyBjVbkG
	lfZmlYRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuAhV-0000000GS6u-2DZv;
	Wed, 12 Aug 2026 15:17:05 +0000
Received: from mail-pf1-x447.google.com ([2607:f8b0:4864:20::447])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuAhT-0000000GS5k-1c9u
	for kexec@lists.infradead.org;
	Wed, 12 Aug 2026 15:17:04 +0000
Received: by mail-pf1-x447.google.com with SMTP id d2e1a72fcca58-84fb5376cb8so1092533b3a.2
        for <kexec@lists.infradead.org>; Wed, 12 Aug 2026 08:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786547822; x=1787152622; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=97wksvVZ+thl5LcpXUGbBxNzodsfrcBWwlOTdvF+br0=;
        b=YeyymE2rjbm4vcSOWnWx4p3zCDHuIq2Puix7/IaDFx77yqj/uEbOrvR7SsIVobMZr4
         5RaOsaKM1tlJWLYDTpNRS0Egnek8jp9+GJQsoGf6XrEB42P8OwzNb54RBCZe1RB58CB4
         X6HCM0K+3tZB2Fo+pEfS56NeWzkFcIWtxa0aRlaaiHxB2MgjVBeOhv2NsnvAst8k8WA4
         EyLvs23fjF4RVeFYP+IU8ZnWbbHaIGhwbvC26WhrQtxRl/zpCy6uQDnlYMXhbv8SN6n5
         ZMx3amC2NpdGM08/lFECNv67EFF9Lhp52n0KO+pUtZFyOMYjN8DppddwxnMD3Cyhfo2L
         mYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786547822; x=1787152622;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=97wksvVZ+thl5LcpXUGbBxNzodsfrcBWwlOTdvF+br0=;
        b=Rd6DP6c2EEWurL3fY7JhD5lmVP0AMDMIBdj2MUrSQ53PSZZJW1qKhCflKytuSzbfPk
         Wj55w1D6mHjm1/zu6+TWVFbhOWI12phTVX0D9YSd7t2kLSL9OU6CLIJ6+p9L9JIeacrm
         1ktfab2iGq3ocSOpZYBOpYbc5x7Vrlgem6D9Qm3JTx6FWGi0kkLKxxBhjmfbEk4mV10K
         MbmoFBccECISqxHuvGt8V+Gfk8MglzI50OV3nav171yic7edDhPZ69VRDDlDEiD5DyaV
         PaZ08WZcdwScz3skfnbYUquqckjitJyg1NThkGuNx4x2D3S4yH0kv1RMhGfNovnF9sxP
         DjnA==
X-Forwarded-Encrypted: i=1; AHgh+Rq4FSncnw70bp7Sj89VzmCv04jMaVHmr3ajdRCvBJM8UxwBgztPYRqEobiNrNMycEEBDsnrFg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwH6w/GucBNi/khZy5aK8sQVLym5407ArF6Y/bxqHoldLWlRTHY
	J1/tth2u64+j5WXF47/47rRy1QQz5xn2ZhhJ6MbiiAqM9hDOuzyCde5FtCN/e9YMWu7ij8KCyVM
	6oIH8JA==
X-Received: from pfbcv13.prod.google.com ([2002:a05:6a00:44cd:b0:847:7f5d:6b90])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4fc5:b0:845:4cb5:2343
 with SMTP id d2e1a72fcca58-84fb551821bmr6172462b3a.19.1786547821109; Wed, 12
 Aug 2026 08:17:01 -0700 (PDT)
Date: Wed, 12 Aug 2026 08:17:00 -0700
In-Reply-To: <2vxzik5f311e.fsf@kernel.org>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-6-tarunsahu@google.com> <anphyjFv3FhF61iB@google.com>
 <2vxzpkzo51wg.fsf@kernel.org> <anssOQFNZ2LfihbU@google.com> <2vxzik5f311e.fsf@kernel.org>
Message-ID: <anyObKiZIhfok5mk@google.com>
Subject: Re: [PATCH v4 05/11] KVM: LUO: Support VM preservation across live updates
From: Sean Christopherson <seanjc@google.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Tarun Sahu <tarunsahu@google.com>, ackerleytng@google.com, fuad.tabba@linux.dev, 
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
Content-Type: text/plain; charset="us-ascii"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_081703_440172_E43A6538 
X-CRM114-Status: GOOD (  61.81  )
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

On Wed, Aug 12, 2026, Pratyush Yadav wrote:
> On Tue, Aug 11 2026, Sean Christopherson wrote:
> 
> > On Tue, Aug 11, 2026, Pratyush Yadav wrote:
> >> On Mon, Aug 10 2026, Sean Christopherson wrote:
> >> 
> >> > On Tue, Jul 28, 2026, Tarun Sahu wrote:
> >> >> Register a Live Update Orchestrator (LUO) file handler for KVM VM files
> >> >> to serialize and deserialize VM state across kexec live updates.
> >> >> 
> >> >> Currently, Only VM type (e.g. arch.vm_type on x86) is preserved as part
> >> >> of VM preservation.
> >> >
> >> > Why?
> >> >
> >> >> On retrieval, kvm_luo_retrieve() recreates the KVM VM file via
> >> >> kvm_create_vm_file() and use an atomically incremented ID for the internal
> >> >> fdname, as the final fdname assigned by userspace is not yet known during
> >> >> retrieval. As this fdname is only used in debugfs infra, This will not break
> >> >> any UAPI.
> >> >> 
> >> >> This infrastructure establishes the foundation for preserving guest_memfd
> >> >> instances across live updates, and can be expanded in the future to
> >> >> preserve additional VM state.
> >> >
> >> > Uh, why guest_memfd?  As much as I want to push guest_memfd adoption, it seems
> >> > guest_memfd should be the _last_ thing we support, not the first.  As evidenced
> >> > by the last two decades, it's very doable to have KVM VMs without guest_memfd,
> >> > but it's rather hard to have VMs without vCPUs.
> >> 
> >> You _can_ preserve vCPUs today using KVM_{GET,SET}_REGS, they just won't
> >> run in the background during the reboot.
> >
> > What about x86 CoCo VMs?  Which are quite literally _the_ reason guest_memfd was
> > created in the first place.  
> 
> I don't know much about the history but I thought these days guest_memfd
> is used for more than just encrypted memory. I have seen talk of it
> being used for non-confidential VMs. For example these patches [0][1][2].

It's getting there, but it's all still very nascent.

> The CoCo parts can follow, but IIUC guest_memfd is being used to back
> guest memory on non-CoCo VMs too.

Not using upstream code, though there are most definitely folks using guest_memfd
in production with out-of-tree patches.

But that's all beside the point.  What I'm saying is that SNP and TDX *must* use
guest_memfd, whereas guest_memfd is optional for all other VM types.  And so adding
LUO support for guest_memfd without even sketching out a plan for CoCo VMs feels
backwards.

I'm not necessarily opposed to gradual guest_memfd support, but there needs to be
a clear plan of how all of this is going to fit together.  It doesn't need to be
perfect, and I'm sure we'll make mistakes along the way, but I want to at least
try not to paint ourselves into a corner, especially with respect to the ABI.

> >> > E.g. the LUO APIs seem pretty straightforward; I assume the bulk of the complexity
> >> > is going to be in knowing what to save/restore, and how, which is much more about
> >> > KVM than it is about liveupdate.
> >> 
> >> I think it is fine if you want to take these changes through the KVM
> >> tree, but I would like live update maintainers to be listed as reviewers
> >> at least.
> >
> > Why not simply add a file pattern match to the LIVE UPDATE entry?
> >
> > diff --git MAINTAINERS MAINTAINERS
> > index 8014b9f8253e..2eb57b22c37f 100644
> > --- MAINTAINERS
> > +++ MAINTAINERS
> > @@ -15052,8 +15052,8 @@ F:      include/linux/liveupdate.h
> >  F:     include/uapi/linux/liveupdate.h
> >  F:     kernel/liveupdate/
> >  F:     lib/tests/liveupdate.c
> > -F:     mm/memfd_luo.c
> >  F:     tools/testing/selftests/liveupdate/
> > +N:     [^a-z]luo
> >  
> >  LLC (802.2)
> >  L:     netdev@vger.kernel.org
> 
> This would list us as maintainers of kvm_luo.c and the tree as liveupdate.git, 

It would list both "LIVE UPDATE" and "KERNEL VIRTUAL MACHINE (KVM)", as KVM would
still cover the files via "F:	virt/kvm/*".  And my read of MAINTAINERS is that
N: and K: entries are "secondary" if the files/scope is covered by an F: entry.

E.g. arch/x86/kvm/vmx/tdx.c is covered by "KERNEL VIRTUAL MACHINE FOR X86 (KVM/x86)"
via "F:	arch/x86/kvm/*/", and also by "X86 TRUST DOMAIN EXTENSIONS (TDX)" via
"N:	tdx" (or maybe "K:	\b(tdx)"?  I haven't bothered to check which one
triggers).  And while I don't think there was ever any formal discussion, AFAIK
everyone reads the situation as KVM still being the primary maintainer/tree for
that code.

> both of which is something you're saying you _don't_ want.

No, what I don't want is a dedicated "KVM LIVE UPDATE" entry, because I think most
people would read "F:     virt/kvm/kvm_luo.c" and "F:     virt/kvm/guest_memfd_luo.c"
as being more precise than KVM's "F:   virt/kvm/*" and thus would read things as
"KVM LIVE UPDATE" being the primary maintainer.

In other words, I'm more than ok with LUO being looped in on KVM LUO changes and
having the authority to object to problematic changes, but I'm not ok with LUO
taking primary ownership of KVM code.

I realize there's more than a bit of nuance in my interpretation of N: and K:,
but again my experience with TDX is that so long as the maintainers are aligned
on expectations, it's a non-issue in practice.

> >> At the same time, I also keep being (pleasantly)
> >> surprised at preservation being relatively simple. For example, the code
> >> to preserve a shmem file (via memfd) is roughly 600 lines, a big chunk
> >> of which is comments. The code of course has some limitations, but it is
> >> good enough for use in production.
> >> 
> >> For one, we care about ABI breakages and versioning. 
> >
> > Which is amusing to me because that implies KVM does not, and I would hazard to
> 
> No, it doesn't. What I'm saying is I care about changes to the _live
> update ABI_. Just like you probably care about changes to KVM ABI but
> not so much about BPF for example.
> 
> > guess that KVM has the biggest ABI surface of any subsystem in the kernel by a
> > country mile (though I'm probably wildly underestimating the effective ABI surface
> > of filesystems).
> >
> >> The serialized state is a part of live update ABI and changes to it should be
> >> ACKed by us. 
> >
> > Meh, "Don't break userspace" is a universal rule in the kernel, I genuinely don't
> > see why liveupdate needs special treatment.
> 
> Ironically enough, you miss my point. I'm not talking about userspace
> ABI. We all know not to break that. I am talking about live update
> _serialization ABI_. See the stuff under include/linux/kho/abi. This
> series also adds things there.

No, I understand exactly what ABI you're talking about.

> This is ABI between kernels. It needs to be stable-ish so you can move
> from one kernel version to another. At the same time, unlike userspace
> ABI, it can change.

Uh, yeah, so KVM has been managing such immutable ABI for practically its entire
existence.  KVM's save/restore uAPI has exactly what you're describing: serialization
ABI that needs to be backwards and forwards compatible between different kernels
in order to support both upgrade and rollback scenarios via live migration.

KVM also has immutable ABI between itself and guest kernels, including implicit
"ABI" in the form of not changing guest-visible behavior.

> Today we don't have any rules and let you change things freely as long as you
> do a version bump. But at a later point, the plan is to add some stability
> requirements to the ABI so you can actually upgrade the kernel across major
> versions.
> 
> So at least for ABI changes, there should be an explicit ACK from the
> live update group.

I don't entirely agree.  I get where you're coming from, and I 100% agree that
the more eyeballs on changes that may affect ABI, the better.

Where I have problems with the above is that it doesn't account for the nuances
of save/restore across different kernels.  The literal format of the serialized
data is the most obvious form of ABI, but it's absolutely possible to change ABI
without changing the data format.

E.g. say there's a flags field in some serialization structure, and flags X and Y
are mutually exclusive in current kernels.  If a future kernel relaxes that
restriction for whatever reason, then the effective ABI has been broken because
state created and saved on new kernels can't be restored on old kernels.  And
this is not a theoretical concern, KVM has run afoul of this a few times (though
thankfully very rarely).

I don't think it's reasonable to expect LUO maintainers to gain enough expertise
in each subsystem to be able to ensure changes are forwards and backwards
compatible.  The only way I see LUO being successful in the long term is to get
subsystem maintainers/contributors to understand *and buy-in* to the LUO model
and rules, so that each subsystem can largely be self-sustatining.  I.e. setting
yourselves up as literal gatekeepers will help prevent blatant breakage, but it's
less likely to help guard against more subtle breakage, and in my experience,
subtle breakage is by far harder to detect and more painful to deal with.

Somewhat of a side topic: in my experience, using monotonically increasing version
numbers is a horrible way to enumerate features/content.  So for me, allowing
KVM's LUO ABI to change with a verson bump is probably a non-starter.  I.e.
whatever gets merged needs to be more future-proof than "we'll deal with it later".

