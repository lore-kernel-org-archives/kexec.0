Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E25FF885A
	for <kexec@archiver.kernel.org>; Sat, 25 Apr 2026 03:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yQTvhWSyeRzzkMlZ8tRqN85t2RdPb6JQ5sP+OFC2oos=; b=sf7kBnxgRQa6gGqkOazWYNwGgz
	l4y0uUFZHK5TEROe6CIJEUohLI1ZQsKbqVy6ijb9fjRf6WxeA+g4cWlVuJzKn/SP7noW+0aHQBW+A
	UCsX6I6uBdYvITQav3DACvkSosEuhXtux8ysw90cwO/B5Mj8rIRdxOlGw/LjaaxKrV0wqPLE1vygI
	rXVBhC1Ky+3K8s9NI1dPhvgB9SpcHBV3dDomGmKFeBi08mYTP5lQ0jWIvhBEHM55dvAKhosQrNATF
	lIJ8uWc/mUo8eld5CyEm0PHrecVXv4ezwN1ihIW9FE/LJfri2wBsAzEohEc4CrCy+XoUew6m+moLJ
	CMaNfHXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGTN8-0000000E1Tf-25WU;
	Sat, 25 Apr 2026 03:07:58 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGTN6-0000000E1TE-1Xoj
	for kexec@lists.infradead.org;
	Sat, 25 Apr 2026 03:07:57 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2b2591757fbso282645ad.0
        for <kexec@lists.infradead.org>; Fri, 24 Apr 2026 20:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777086474; x=1777691274; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yQTvhWSyeRzzkMlZ8tRqN85t2RdPb6JQ5sP+OFC2oos=;
        b=OqB5qGWQuyKP/OpPuWKxBSl2dmCzgdad3ayHKtMEFTjmrWwlHPVMAxucpXiJFbohvc
         U0f1w096OpkbyMRmUCNLY5QzXcGnzaakTw+JD9fv0Ukv9bZh7D/ykU5ok1Jt/9Kg7dk8
         Tmb3weWxcgDzULBrEHsOPkiztlhmdrFhnPnUuUguRSK/eWjyPDlivuBSJgo9tQZdUPcd
         JFIfN0Le9OJHdQr1itHrdo+2VVBMViLSZlJHrsJYxWjaYi039YvA/awHK4cHO3Es6NXi
         WbSChOVQgR0sXn+VxnTlKHoiuqvxnOLacPlpAx9DnC8N5mqw+VxCKk+RKPuUuy6B8jR/
         F3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777086474; x=1777691274;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQTvhWSyeRzzkMlZ8tRqN85t2RdPb6JQ5sP+OFC2oos=;
        b=LvkOrIbLhZ7GLAytykYQtV//qbZRIjjWlSBlahoyUnn77lYLBKwIGzBBHxOhgTsmHX
         BH2U/eOWpbvKEjNUDQBNDAgCaIu/VR333IegMghRVFq5y9HGj76HyVlV1Qw4L8u63p2A
         eFeRiOwBTqRZniTvIvrB7T8TucsMlT62qMlxiZ6REMZ1RyZUWCSpLikBEQzvB5BzVakx
         dGtgVJ1tNFsU05qlIwBxycW8Ok/AeaBy4mA1/vDWCvI4TMaV5phuVNgp/dRPeEkauRjM
         Vh/lTlexRjKk4eb1ytC47e9Jf7YpTbEV4Y1tl4pZ6Yrx5TlVHn72btgbUMaw9XOMIuvp
         9LEg==
X-Forwarded-Encrypted: i=1; AFNElJ8OUiCdSaBRWhKr19x+OmEF9WwZylW9nIyNKjOfc3qWMYgKHFHdgBXVG5aoDmRPyClvnjxxSA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx3Z7M+ZQuZLeSZDkz9s1xbYFFHegXwhnupe4LqUVg7Q9iAUdGf
	ASvSJKoEVV1G5stSh6WoKEHzTbD27ksxydrOZvv9e1hWZ93huxGlrWTi6EOMj36SHA==
X-Gm-Gg: AeBDiesfEMdL2dRYYPbQCktn5eh6HE2eiv6qHv5suhjF7kWkcyfJFe2keXuUmL2jPK9
	Luwi6HdlPjKrvDbF7cU8Ddk6rARBBGTKs7sYZIEAZRDWSExszhQBcEMAiCgtdcJlQctnhUp38XP
	TQ54sg7E8GQ67zkI4WQ89IHHNgQ9PKheRWF7rikpE3IIM5hjDZxw/FbFvi/EpvyMx00A+QbwjqC
	PO9xqbuEOrrldZnaH+SiI+THo0QSlGogK9cVOFbKFA5QLooOSXgV44f4ZY+HD2DI+vTg1bTh8RC
	lAQm9ivatoIvTuGfPPz0mti03w8rBcPkw+fX9IZU0lk8gJVKyBd5naZHmUgz9+7lE9amJ1QA0FY
	rMKRZgU4dwvfZkDQovMfjAd9uvg5OPu2wTwWfGVhBH6hinpWdLeIO2GGIes27SKkKlMYXctPhT5
	i6oVykmsJuJSwTdBd5bu5B2bZqYCNa793DIUzkl6TGiBCB/mlyxkwCs++b+oTOZsm4PQ/6WwL9o
	g79Aorj+zf5r/XRVi9mRQ1iwIP+8VU55K1d4MPyQe0bk0UhYGD/lW52bY89AYRp9ZaCu9/SYvw=
X-Received: by 2002:a17:902:e552:b0:2ae:45cc:aeb6 with SMTP id d9443c01a7336-2b602f42603mr12894195ad.6.1777086473646;
        Fri, 24 Apr 2026 20:07:53 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:a18f:54fc:a476:f72a] ([2a00:79e0:2eb0:8:a18f:54fc:a476:f72a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614186adddsm25961188a91.2.2026.04.24.20.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 20:07:52 -0700 (PDT)
Date: Fri, 24 Apr 2026 20:07:51 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Alexander Graf <graf@amazon.com>, 
    "Andersen, Tycho" <Tycho.Andersen@amd.com>, 
    Anthony Yznaga <anthony.yznaga@oracle.com>, 
    Baolu Lu <baolu.lu@linux.intel.com>, David Hildenbrand <david@kernel.org>, 
    David Matlack <dmatlack@google.com>, 
    "Heyne, Maximillian" <mheyne@amazon.de>, James Gowans <jgowans@amazon.com>, 
    Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
    Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
    Pasha Tatashin <tatashin@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
    Praveen Kumar <kpraveen.lkml@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
    Vishal Annapurve <vannapurve@google.com>, 
    "Woodhouse, David" <dwmw@amazon.co.uk>
cc: linux-mm@kvack.org, kexec@lists.infradead.org
Subject: [Hypervisor Live Update] Notes from April 20, 2026
Message-ID: <014fae14-28e1-ff32-c126-28bdffdff636@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_200756_497689_69A11120 
X-CRM114-Status: GOOD (  22.71  )
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
on Monday, April 20.  Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
Pasha updated on systemd integration for LUO.  He created a pull request 
for initial LUO support and that patch series is under review.  In 
addition, the session limit was removed.  Luca sent a patch series that 
allows finding the name for a session and logic to determine if this is a 
LUO session.  Those patches are also under review.

He also mentioned that Pratyush was working on boot time optimizations for 
KHO but were not in attendance at the meeting.  Deferred struct page 
initialization v8 was sent out last Friday and all major comments have 
been addressed so we are hopeful these patches will be staged soon.  For 
memblock improvements to automatically expand the scratch area, Pratyush 
is working on this and he'll likely send this series out soon.  This will 
add a new data structure to find holes of 1GB or better to create separate 
radix tree for boot time allocations.

----->o-----
David Matlack updated on VFIO and the roadmap going forward.  He said that 
the series will be split into two with him taking the PCI core changes and 
iterate on those separately while Vipin Sharma takes the VFIO patches and 
selftests.  While iterating on them independently, they will be tested 
together.  v4 of the PCI core changes are prepped and ready but he's still 
cleaning them up for posting this week.

Vipin updated on VFIO which will largely be based on the previous v3 
patches and he is targeting sending these out before the next meeting.

----->o-----
Samiullah updated on IOMMU persistence and said that it should be out by 
the end of this week for feedback.  There was discussion upstream to 
preserve the minimum that is required to free the domain.  He is planning 
on sharing a roadmap externally on the shared drive for discussion to keep 
the conversation going and to preview future thoughts.

----->o-----
Maximilian Heyne joined us and noted that he is continuing Pratyush's 
work.  Imagining a database or a process with a huge amount of cache or 
memory, all that memory is gone after updating to a new kernel.  He wished 
to discuss how to preserve that memory over reboot or kexec.  His idea is 
to take a process and dump its state to disk and then restore on the other 
side of the reboot.  The problem is this takes a very long time so perhaps 
it would possible to leverage KHO to preserve the data in memfds.  He is 
using splice to move pages from the process into the memfd and this seems 
very inefficient.  He would like a solution where he can turn the process 
address space into a memfd to do the preservation directly.

Pasha noted the limitation with CRIU was the snapshotting and restore that 
would make this difficult to do in place.  He also pointed out existing 
APIs for preserving memory through DAX.  He didn't think this would need 
to be an application level change but rather a CRIU snapshotting change.  
Pasha said the VM use case is different than CRIU because the guest memory 
is preserved but the data structures associated with it get recreated.

Jason suggested the pathway would be equivalent to converting an anonymous 
VMA into a memfd so that CRIU can just use the memfd right away and that 
would likely be better as an upstream discussion including core MM 
developers.  He thought that some amount of application enlightenment 
should be used for this, however, either through memfd or hugetlb.  Pasha 
said an alternative may be to preserve random files in tmpfs.

----->o-----
NOTE!!!  The next meeting will be canceled due to LSF/MM/BPF 2026.

Next meeting will be on Monday, May 18 at 8am PDT (UTC-7), everybody is
welcome: https://meet.google.com/rjn-dmzu-hgq

Topics for the next meeting:

 - systemd integration for LUO, patches from both Pasha and Luca
 - KHO optimizations for boot time performance including initialization
   of memblock list and deferred struct page initialization
 - HugeTLB preservation support including selftests and fallback
   allocation strategy
 - PCI core changes v4 and next round of VFIO patches including selftests
 - Vipin and David Matlack roadmap for PCI and VFIO changes to solicit
   upstream feedback
 - IOMMU persistence patch series status
 - Samiullah's roadmap for IOMMU persistence to share with stakeholders
 - Maximilian demo for persisting process memory across kexec
 - guest_memfd HugeTLB enlightenment: conversion support, HugeTLB support
   without restructuring, and HugeTLB support with restructuring
 - KHO support for Confidential VMs including page table preservation and
   pinning
 - later: versioning support for luod to negotiate
 - later: KHO enlightenment for ASI

Please let me know if you'd like to propose additional topics for
discussion, thank you!

