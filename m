Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF10EC35FF7
	for <kexec@archiver.kernel.org>; Mon, 17 Mar 2025 03:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NlW8w4RRBWj9GTYyM0QR0pwlik2bQU9FbiljA2VJaMo=; b=1FH9FYexgKjV6TzfHe3AXFh2vm
	wzEnYf3WJug/+r5yPg8QOnXZwKF3zuBZ0yesUuw524Tq+fTJaRxMDv1Y5gLD+Ytcx5R+OsM8jc5rK
	VHnTrre1XHAvYklLDMrAd9FwrrmAGmaN+0Zmq2JeSlJw6xznSFqf3j5banStkDIWsP+Zoy88+VVgo
	NpXqTqgiU41f18XqObJZ7VUNCgsiBMTcurMC1NwC2mealHwAtHGsfm/OHl1tWnU/VEIh37CmPJLmK
	WXinhlJS2J7ginnpS2Mq2uv/LxbOq6XvNnvGqvT61qIR1zW7wFttK8JB8nZR7OgiVNidXAU0JQlbq
	nVoAMCUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tu1X1-000000016Gp-2XUc;
	Mon, 17 Mar 2025 03:52:51 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tu1Wx-000000016Fk-1DHG
	for kexec@lists.infradead.org;
	Mon, 17 Mar 2025 03:52:48 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-225489a0ae6so321575ad.0
        for <kexec@lists.infradead.org>; Sun, 16 Mar 2025 20:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742183565; x=1742788365; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NlW8w4RRBWj9GTYyM0QR0pwlik2bQU9FbiljA2VJaMo=;
        b=pKu9J92HGuWdYKICXgixYl4emkawyjZ6VHD0SnKSqZE9pf6YX0Pcm1ghp8ezqCDIUL
         KNlG6xDf8bdVVXSUWzdw7AhhjEZN/EJ0CYNGebvpxfXI2jM6hJ+UixHXLgSynT4+4fPl
         3jeXnDNsnUb4/SC5sa8XOw5+po+kQWIuQTZuQ0lLh7CmNiznnjlEP1wKWTVst/ZcG+4p
         IgGofF0BhmrQ38r9BoMG7s5ZN5KiqiYnYSQ5o2hR8f9LNW/lqdp174cwOKMgaPQUQtV5
         vdnaQoEKhbBJKqvSW/uq16Fdxd/2sQCidSWtEQ8AVlRDOiCRCUncUnlKjEQu6EgBDhB5
         zIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742183565; x=1742788365;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NlW8w4RRBWj9GTYyM0QR0pwlik2bQU9FbiljA2VJaMo=;
        b=jbluDpklfB9C9J+KkR6bEMGpKPYNbO0bgPQY16TWkVpHT20dJ+jBsTwjpfl+UW+DIb
         r3aUUapOxMdb7Q+JBqg6v+hEaoqmXw+APnksAVPex+GvYLnv/vjaGXZNIbNkgtKWUwhq
         x0ClaQibWobGocuRy+NZayOixPiIJC3qe/A9GTPeahKa3JY2RYUOCkO670at13+blVy2
         Y5dTSzAxFQxCmTOG/ngmhfF6SAdHZXONvskHWIQMdM8hXnrIpzH3swg+3yEk0z9ouXCG
         L67kx8+fDL4oQzIaHw1Z4lB//S2OyEL3WpPBoJLJr3agt6m8h/P7Fupg2Ry4URJY6qHJ
         qriw==
X-Forwarded-Encrypted: i=1; AJvYcCUi0SVKmEVj2L1w5Auhh6eSQ0yoCUtom2Fk77RlC3GGUgzN0Wll7DffeKklEk7WkLOFHEjEBA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx8oC+5N2PkVKGsdpuaJtvUGzxBcvo+E8uRjX2Hcfa5D+PAVtEH
	B3CxB6vtHybC0hS2Trhc7Eap2QONor1agu5gX0uufKd9+nmGtvfURGPSTOrE5Q==
X-Gm-Gg: ASbGncuX9HPz0tBy+V8CkXCICeC8IgXM8zEu5xVK/q3xqk8pODUl0vqe0InxilMBh9d
	T3Q/IuToxKqbQExj6WQ1z+g/KsB0chQzq5GQFTuaJlnCFVEzxcEX/4Z5s99d1dlKDe+zL/U9bsU
	1NWCgn2qmZCHk2Er28PNqnnUuIrigg+cCznQt2kkfw5yRb08LHQkrzJYsC7GEgvD+fY+INbxGKj
	rFvgjYWJiW5EzrZmp6ANZpw3p3iShyoQvWuT4X4kaC/6sBEbghp5HpfJBzaG+g9k2Lg+4no+oy5
	Fi2pfAUdQHidPWJwHP/mwvk3j1fXWGHPw2T57qN6MXPQJwlbZFZpun/iVaUJFViqjmya8CNGfBe
	swCNdPucrxq/yU1+Ky4dNcSt7wSeLQkkEzhxxKOc=
X-Google-Smtp-Source: AGHT+IGFM2A4MRU9B7FIvTISeZ8zh3JOwAXWXqa/+F5Ql3k1wf0V5Gs+c+TCo+oRN1EITcTysPQTCA==
X-Received: by 2002:a17:903:41cc:b0:223:37ec:63be with SMTP id d9443c01a7336-225f3c14de3mr2958175ad.4.1742183564977;
        Sun, 16 Mar 2025 20:52:44 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:37fc:ef4d:16b9:8b63] ([2a00:79e0:2eb0:8:37fc:ef4d:16b9:8b63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3015364ec12sm4950195a91.44.2025.03.16.20.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 20:52:44 -0700 (PDT)
Date: Sun, 16 Mar 2025 20:52:43 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Alexander Graf <graf@amazon.com>, 
    Anthony Yznaga <anthony.yznaga@oracle.com>, 
    Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, 
    Frank van der Linden <fvdl@google.com>, James Gowans <jgowans@amazon.com>, 
    Jason Gunthorpe <jgg@nvidia.com>, Junaid Shahid <junaids@google.com>, 
    Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
    Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
    Pasha Tatashin <tatashin@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
    Vipin Sharma <vipinsh@google.com>, 
    Vishal Annapurve <vannapurve@google.com>, 
    "Woodhouse, David" <dwmw@amazon.co.uk>
cc: linux-mm@kvack.org, kexec@lists.infradead.org
Subject: [Hypervisor Live Update] Notes from March 10, 2025
Message-ID: <a350f3e5-e764-4ba6-f871-da7252f314da@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250316_205247_356555_752729C9 
X-CRM114-Status: GOOD (  39.99  )
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

Hi everybody,

Here are the notes from the last Hypervisor Live Update call that happened 
on Monday, March 10.  Thanks for everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
Mike discussed taking Jason's proposal in response to v4 with xarray and
extending it a bit for memory reservations, it appeared to be working
correctly.  He's hoping to have the first implementation for that by this
week.

Mike noted that the next KHO series was being prepared to be sent out
before LSF/MM/BPF, including device tree.

----->o-----
Mike noted that Pratyush found that the KHO scratch area does not work
well with swiotlb[1].  The scratch area is reserved before the swiotlb is
initialized; the second kernel doesn't have enough low memory for the
swiotlb because it's still allocated from memblock.  The current scratch
areas are allocated in higher memory.  Mike posted a patch series that
split meminit for all architectures so this should be easier to fix.
This will affect any driver that requires memory in the first 4GB.

Alexander suggested allocating a scratch region in the low memory area.
Pratyush proposed this as a solution, although he wondered if it would be
possible to move swiotlb allocations to after the buddy allocator was up.
Heuristics were discussed to determine how much memory should be reserved
in low memory for this.

Mike noted that for successive kexecs, there will be multiple regions of
scratch area for each NUMA node.  For low memory, this would be sized
suitable for allocations that must originate below 4GB for DMA.  Mike
said a solution would still need to be developed for overlap with
preserved scratch memory and Pratyush noted that should be explicit by
denying those reservations.

Pasha asked how drivers would know if reservations would be denied in the
first 4GB of memory.  Mike said an error code would be returned.  Pasha
was specific about devices that wanted to preserve the memory because
they knew DMA would be on-going during the reboot.  This became a more
general question: what devices should we support for KHO and what should
we not (what is considered too legacy?).  In the meantime, Pratyush
suggested explicit checks for this.

----->o-----
We shifted to talking about Pratyush's patch series supporting fdbox for
memfd[2].  Reaction was mixed to this: some feedback focused on the use
of miscdevice and there were security concerns.  Pratyush noted that
there was no intent to propose this as a generic concept outside KHO.

Pratyush noted there was no way to preserve folio orders in KHO and he
also noted there was a need for page flags.  He also said it would be
possible to move away from miscdevice and perhaps toward VFS but would
need to look more into this.

Pasha asked about how the page flags were preserved.  Pratyush said there
was another property that would store them currently.

Pasha asked how cgroups would be handled, but there was no current
support for that.  Pratyush said the current RFC focused on anon memfd
and has not yet looked at hugetlb.  Pasha emphasized the importance of
focusing on one type of memory to start.

Pratyush noted in chat: "With FDBox work, I also realized that you can't
use FDT code from modules. Should not really be a problem since we can
export those symbols I suppose, but it doesn't work _currently_ at
least".

----->o-----
Andrey had recently sent another patch series for KSTATE[3] that was
discussed, now in v2, which was closer to being a formal submission
rather than an RFC.  He noted his concern with KHO was how hard it was to
write serialization code.  His goal was to give drivers the ability to
migrate structs across kexec which could be more elegant (see the
struct kstate_description).  He suggested this would be more
maintainable.  It had previously been used for live migration in qemu.

Andrey noted that each description would have a version field that
enables defining the minimal supported version for each driver.  He made
the connection between this and version control in qemu.  Pasha asked how
this solves the problem when memory becomes sufficiently fragmented and
the next kernel cannot boot due to it; Andrey noted the kexec would fail.
Andrey suggested allocating a big contiguous area, the source and
destination ranges would be the same.

Mike noted that kstate_description definitions and the way drivers
declare their state to preserve are independent from scratch memory
reservation.  Andrey noted this wasn't a replacement for KHO but rather
could be built on top of KHO.

Mike suggested on top of KHO we have FDT, then what Pasha is proposing
for dynamic tree on top of that, then perhaps kstate on top of that.  He
would need to look more into kstate.

----->o-----
Mike asked if kstate descriptions depend on how it's preserved on the
backend, an earlier version had a migration stream.  Andrey suggested
using FDT underneath, but there is no strong dependency.

Pasha asked what architectures were supported today for kstate, Andrey
said x86.  Pasha suggested that anything that lands upstream should
likely support both x86 and ARM.

Chris Li asked about kstate descriptions and if a struct adds or removes
a member.  Andrey said if you want to add a new member, then you can bump
the version number.  He showed an example from qemu[4] that could be used
as reference for this.  You could also add a new kstate description with
a new id, on downgrade it wouldn't be used for backward compatibility.

Alexander suggested starting with FDT logic because it already exists and
then serialize and de-serialize binary data using a UAPI.  Then, we
should discuss deprecating FDT if/when we have something better.  That
won't be problematic unless we gain hundreds of users.  He emphaszied we
should focus on how to easily and quickly preserve memory across kexec,
calling back to drivers to store their state at the right time, etc.  The
data format for how to serialize is a tiny detail in comparison.  Pasha
fully agreed with this.

----->o-----
Next meeting is PREEMPTED for LSF/MM/BPF 2025 in Montreal.  So the next 
meeting will be on Monday, April 7 at 8am PDT (UTC-7).  I'll send a 
reminder on this mailing list.

Topics I think we should cover in the next meeting:

 - debrief discussions at LSF/MM/BPF 2025
 - update on Mike's patch series for memory reservation
 - update on Pratyush's progress for allocating swiotlb in low memory
   regions and any additional support required based on device
   requirements (who needs this scratch support?)
 - discuss whether the fdbox support would obsolete the need for
   guestmemfs in the long term
 - alignment on memblock as the first use case for KHO to justify
   upstreaming, including ftrace use cases
 - discuss Live Update Orchestrater (LUO) based on RFC patches sent by
   Pasha before then that helps to define the state machine
 - discuss how KSTATE plays into KHO upstreaming and complementary or
   overlapping goals
 - decoupling 1GB pages for hugetlb, guest_memfd, and memfds and how fds
   can be added to an fdbox
 - iommufd patch series (as well as qemu) from James
 - establishing an API for callbacks into drivers to serialize state
   during brownout
 - topics proposed by Pasha: reducing blackout window, relaxed
   serialization, and KHO activation requirements
 - implications of preserving vIOMMU state
 - testing methodology for these components, including selftests

Please let me know if you'd like to propose additional topics for
discussion, thank you!

[1] https://lore.kernel.org/all/mafs0cyf4ii4k.fsf@kernel.org
[2] 
https://lore.kernel.org/lkml/20250307005830.65293-5-ptyadav@amazon.de/T/
[3] 
https://lore.kernel.org/linux-mm/20250310120318.2124-6-arbn@yandex-team.com/T/
[4] https://www.qemu.org/docs/master/devel/migration/main.html#vmstate

