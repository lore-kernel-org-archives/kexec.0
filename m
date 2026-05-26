Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C22ECD5BB1
	for <kexec@archiver.kernel.org>; Tue, 26 May 2026 18:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=act60vUxIIaCqxwJhQbB9YMS0EUrx0ri9T2HmFauSng=; b=Sz7mgnX27mpz5sNmeUeJIMreVJ
	FUL6bFzpIuXJ7z4PzOvQZifvPIarO7d6ToNlNIXXDcoEJyozEc7LnIJt0KzEVW5PAKyWGSMhI8lWe
	KAf19w7FJ9oifsQ1zjMC4r6aD3DD6w8Atv2rgyLV/UJ0T2uE/jAxXx294WVDb0aed8lhuhL710siv
	zXEkDs3wClQ/d1QQFcZJKTFEFSY219R2hk5VL+1BaPAYEVyAgHbecocZkOrMW2Hf7EpjH1+3Ph+Op
	Bxd8/jESHp9vcmJ3EC1Wh/HMfpoFx6w9kF8XgBZsL53cR1HTDYPfaDQ2Dckd0h8av+wSZZklhTxSv
	FXAwJsFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRweP-00000002rSW-14Ms;
	Tue, 26 May 2026 18:37:13 +0000
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRweM-00000002rRk-2Vgr
	for kexec@lists.infradead.org;
	Tue, 26 May 2026 18:37:12 +0000
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-7c7fc722b50so84599267b3.2
        for <kexec@lists.infradead.org>; Tue, 26 May 2026 11:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779820629; x=1780425429; darn=lists.infradead.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=act60vUxIIaCqxwJhQbB9YMS0EUrx0ri9T2HmFauSng=;
        b=WDl9zL/q537KA+P9vOj6BRWGWCwRU9bGkWtUd3XjhcoQIB2cHI3RHsN4hgM8a17xhy
         8XMo6E+rJQXkRlHBgoaKFiu8JxT1WWefairdHzreS9HIRmnKexbKNufixhlXJj9m4onw
         VaQul7Qolrx+xwKgGOWO3+FTL42q8SlSgPzfOH8M/uOKf645r1sAWYS2wq0m2pWG/JDw
         dknD9K1rx0LNU3dE1QVGS+cwp2Ltc/EwzRxTM6ZoHdV8IAbOMsMFW2WhT1dIDE1p8dT0
         pFuPbQIql2y7o4O48OzOmk4+vQ1rmTf5DH47L9W/+bOzmC9KB6Cq4UwE3uIuobc6LHuu
         H78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779820629; x=1780425429;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=act60vUxIIaCqxwJhQbB9YMS0EUrx0ri9T2HmFauSng=;
        b=FQSVTpaU6O5tpcXvhSsBTCOmYRhShZFgvE8L7WPK9OG2zqXOu7G8cE1Hxw7sg6Eets
         itFXgK4/4yA1AVob53mVS2kuTIOQIEGjSpPfkKDuR/rOVJMOt/99cbZYHVA1NnjRQ1N+
         PGjfjcnSyk3cTFzXBt1BFtLKLtlp67nKSedJEFxOdYTQF73wuedjLF7UfmJpuQ3Wyksx
         PrODMqnUhbTpjloJd5pLImytclBcVU8VA7Sw46rx4wnUeCwLziWbckM38LTILzvGgnt5
         gNCsEPcuFsZR7tj3hYu+VX4kosfhoauHJWD/VJLU7ejpXvr8mX9rdJGqH5W4o+JxiLqQ
         EeWQ==
X-Forwarded-Encrypted: i=1; AFNElJ/qRselez7DdZri6pmcVCFhov7o1eF+bqiBOfxhEn9Y/8Nnb4zdBpWTk5UBSWgB7Ye040Ahfw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx6douTx9H7bkTpDkD03CaEisUGotPF7xtKiYL+mWLbWWJKOxmh
	Fpw8esOBtxTT4pK0EkepuAHdcwt+BjvaLwcm8GANMPbWdXMGH+qh5UJnknZSVWiQ2kE=
X-Gm-Gg: Acq92OFWVtNmYxbxrBXS7MqG/s8riAiIjQBY7ZaBsa8r6SAhoTM02YunME7OuLkfqLx
	68sx1azPsXgv8XbNhWFbzcvPV53VVaG4Lcx1rHXCx/RSRlkkbVL5PJsY7f11/z0Pi26SQ5LDM+e
	vw64HrCVLnPQvbFpNfZS5+w4z27xyh+8QnfqQrIGxjp7cJ1DSlRyFIDnmmgMi7iNEQqRky7elgh
	zAWrh72b+Xw8bH2ApkxH+uf5gnoIZzi+EDTVN0IGY6HXqAlPv0d/1DP4JSicVEeP+LdujalvDSm
	iK4CGpdbM4LG6ruxHuk5nCDdqo7hQ9AccefM23hmNG8gUA5CY8XfX6AT5+TVv9DxbTVegYK926U
	PTj5GOJX1Z+evc1aD7ZlHjG0U8x3klbwgyJfxWGQpzEWPk2m2R8bZnP4Cz0GVzTd5JNyN2+1NGZ
	VqU9nRVTE5f4MOGeJ5mPik1stnOg1VrTStIScdyZ1KCbIu+g8rqN3Ip+5+5w0h6oC5wwa1xbdQi
	0jA0vkJq0d6m973Cm6935s4anLwb5w2
X-Received: by 2002:a05:690c:4d05:b0:7cf:ab4d:a0d7 with SMTP id 00721157ae682-7d3341d5e82mr196847047b3.19.1779820628942;
        Tue, 26 May 2026 11:37:08 -0700 (PDT)
Received: from google.com (138.200.150.34.bc.googleusercontent.com. [34.150.200.138])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d389e1291asm65377997b3.12.2026.05.26.11.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 11:37:08 -0700 (PDT)
Date: Tue, 26 May 2026 14:37:07 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Alexander Graf <graf@amazon.com>, 
	"Andersen, Tycho" <Tycho.Andersen@amd.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, 
	Baolu Lu <baolu.lu@linux.intel.com>, David Hildenbrand <david@kernel.org>, 
	David Matlack <dmatlack@google.com>, "Heyne, Maximillian" <mheyne@amazon.de>, 
	James Gowans <jgowans@amazon.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Praveen Kumar <kpraveen.lkml@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, "Woodhouse, David" <dwmw@amazon.co.uk>, 
	Luca Boccassi <luca.boccassi@gmail.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Jork Loeser <jloeser@linux.microsoft.com>
Cc: linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: [Hypervisor Live Update] Notes from May 18, 2026
Message-ID: <ahXiYGo-IWI94IVP@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_113710_658579_CA353FA8 
X-CRM114-Status: GOOD (  14.07  )
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

Here are the notes from the last Hypervisor Live Update call that 
happened on Monday, May 18. Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not 
attend the call as well as keep the conversation going in between 
meetings.

----->o-----

Administrative Updates & LPC 2026

To kick off the meeting, it was announced that I will be taking
over the management of the Hypervisor Live Update meetings going
forward, with David Matlack serving as a backup for scheduling
conflicts. Thank you to David Rientjes for running these up to this
point!

Additionally, the Live Update micro-conference has been officially
accepted for LPC 2026. Attendees are highly encouraged to submit topics
and proposals as the micro-conference will be listed among the available
tracks.

----->o-----
Systemd LUO Integration

Systemd: Luca's patch has been successfully merged into systemd. This
allows for the use of the fdstore to pass file descriptors across a live
update, which is a major milestone for adoption.

----->o-----
MSHV + KHO

Pratyush and I discussed using the Radix Tree as a
sparse bitmap for MSHV. To improve code modularity, we agreed to explore
establishing a new lib directory to house common data structures (e.g.,
blocked linked lists, memory management structures) that can be easily
shared by the other KHO users.

----->o-----
KHO, Boot Time & HugeTLB Preservation

LSF/MM/BPF Debrief: Pratyush provided an update on the HugeTLB
preservation talk. The consensus is that VFS hooks must be made aware of
the freezing process. Generic fallocate and setattr functions will be
updated to return errors up the stack immediately, rather than requiring
individual filesystems to handle freezing logic.

Boot Time Performance: The struct page initialization patch is ready for
the upcoming merge window. Broader boot time optimizations (like
refactoring the buddy memory allocator) remain a future project.

HugeTLB Preservation: Progress is currently gated by the I/O freezing
work and the fallback allocation strategy (which helps the kernel
discover free memory ranges lacking preserved pages for HugeTLB
allocation). Pratyush has requested reviews to unblock this.

----->o-----
VFIO, PCI Core, & IOMMU Persistence

PCI Core: David Matlack sent v5 last week and is planning to send v6 this
week after incorporating recent feedback. He is currently awaiting
reviews from Bjorn on the refactored code.

IOMMU Persistence: Samiullah Khawaja noted that v2 of the series
received positive feedback from Intel. He is preparing v3 and has also
submitted related series for VFIO self-tests and DMA lock preservation.

IOMMU Development Roadmap:
Samiullah outlined the following milestones, noting that
architecture-specific streams can run in parallel once foundational hooks
land:

Milestone 1 (Foundations): Intel IOMMU state persistence.

Milestone 2 (Multi-Arch): ARM SMMU persistence; Intel 2nd stage
hitless domain replacement.

Milestone 3 (PASID): PASID support across core and driver components.

Milestone 4 (Virtualization): vIOMMU and nested IOMMU virtualization
(Intel VT-d, then ARM/AMD).

----->o-----
guest_memfd & Confidential VMs

guest_memfd: The team discussed the guest_memfd HugeTLB enlightenment
RFC, highlighting challenges with handling shared vs. private mappings
(since LU currently only supports fully shared guest memory). There is an
ongoing debate regarding flags and whether one-time creation flags need
dynamic conversions.

CVMs: We acknowledged that supporting Confidential VMs will act as a
massive stress test for KVM due to the high volume of 4K page table
preservations. This topic was tabled for a future meeting.

----->o-----
Process Memory Persistence (CRIU & Kexec)

Maximilian Heyne presented a PoC using CRIU to preserve process memory
across a kexec reboot without writing image files to disk, successfully
keeping 10GB of memory in a memfd.

----->o-----
Next meeting will be on Monday, June 1 at 8am PDT (UTC-7), everybody is
welcome: https://meet.google.com/rjn-dmzu-hgq

Topics for the next meeting:
- Vipin and David Matlack roadmap for PCI and VFIO changes to solicit
  upstream feedback
- Status of I/O freezing implementations and HugeTLB fallback allocation
  patches
- PCI core changes v6 review and next steps
- IOMMU persistence v3 and roadmap progress
- Updates on vm_splice investigations for CRIU memory preservation
- later: KHO support for Confidential VMs including page table
  preservation and pinning
- later: versioning support for luo to negotiate
- later: KHO enlightenment for ASI
- later: testing methodology to allow downstream consumers to qualify
  that live update works from one version to another
- later: reducing blackout window during live update

