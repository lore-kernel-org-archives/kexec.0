Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F438CD8C8E
	for <kexec@archiver.kernel.org>; Sun,  7 Jun 2026 16:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KygAnOo/dmpBJQ+i2VrBBc9LJ5ZQpG2OVVfBe430lG8=; b=Jye5M5bRHgpmS34gqGgg8wHkET
	PZk7TpVwwUw6HoMyy5oCQAZUM/y344743v6ifc8e8IouyY6+6wnD0uRB1/f/hvb4T4s5iJzsb/CQ1
	xo8PQwABEhGP4DP1yBtV+8Uo2SczRTc8zxsXWVZrcs0Hvryoy1C9Jt2A3ERJylHG6fYw+P0vZdoGg
	DqvNZxlNJny6vPc9TE1/BA6eMOmZjm4JXWrQiBVPPuIm3HNnHi3Nhu6MGUWBV1QzuG8RK0MCH0/BL
	SrN1ZuVMxWZv0p2aFARiXZC2ZGAk+addGUunZj9BpQiOvZ5gGFxfJHPz0ao5/yCR2l0mQDv8UZMwk
	TcJho+eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWG0l-00000002KaT-3Hx7;
	Sun, 07 Jun 2026 16:06:07 +0000
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWG0i-00000002Ka6-3Z8X
	for kexec@lists.infradead.org;
	Sun, 07 Jun 2026 16:06:06 +0000
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-7dd3f176f84so40789007b3.0
        for <kexec@lists.infradead.org>; Sun, 07 Jun 2026 09:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780848363; x=1781453163; darn=lists.infradead.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KygAnOo/dmpBJQ+i2VrBBc9LJ5ZQpG2OVVfBe430lG8=;
        b=XEqOvegqmX6Nl2b3cJSQMRnIy66yQtakr91J46Ma7anT6g3vrtndoOsl4gQTTR0rBx
         MfgZ4L4HYWKJmbJivSGN07l5AOUfbU4yI05qGZv8nRz3edTVHASxIRzVk8JcXabfPp4x
         ostMsjc2fGoI+EX1znmkYw6S7fMzDyKunNjNKK8gSlJ9mmk2EcgzXml2B1kQGgae3u27
         Wgosm4VUQRX7wf7F8n5jp7ob3+55JuR8jrzzlB+o8ZAywMF1IY2ATu5yL+Irg5ZEy/oh
         ZcCOxLToS5me9VKwe3gFxl0V5KNDA1LtumqnklXGcAy5Od9QFuN2kruX2UbzyKg2/8EY
         xWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780848363; x=1781453163;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KygAnOo/dmpBJQ+i2VrBBc9LJ5ZQpG2OVVfBe430lG8=;
        b=YiPaa8bcI4+7hcH1MTQ0luaEeZvvJM/PcKhyYjvcCN9FYTXWU2Uo5OS6tToEGWmVdW
         yYiZD3t2jgfvLpMNIDxImUFmCx5cEbz/FPyoYuIeuRP8JK+jaZk0CRmzYGR4ZfPJC7sj
         PWIrBqMBN7wYLnmGwntL8y8hFCNnAy8iRAJvaO31cg/tlNFGq+hIeYmrNfVeBTP1Xuop
         sOl8VF2SWu3HPhxZ4gnsTFa6Cdcsg4xfo7FivmFRsHugwsK8C4vrC5Kvn37uTrcDaXRR
         PlyFWnwWeTHBP4UlsnCgvQYM7dPcbjbDrxOTS0c9wvMLOuIBfx0iPH3ptakgecqRsg1X
         Wtyw==
X-Forwarded-Encrypted: i=1; AFNElJ9t8pNVipDSDtmPQLK59VLO97ivReWD4F6K6wbujWH8KvCkS3jFBLzzowpKmZrytQtHD4uWDg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzpUI/im6kUDMdalXh7ooYRO+mrFALhN3oM/ipBRJezMfP4UAiI
	RJRC8482xBlVtoWflDgzcd5WHNOP9O79MSVKyNem3yiv/cEXIycfGDUKEzV76Tc/uD4=
X-Gm-Gg: Acq92OGwcnQTkJZYFEPSb2EArIuficq/GSa9FSRzmHVy6GtTPhHPICD4YCg1WbDJeiY
	SmYlRpKkF0qbddb/u7yVdAokSJAHF/Aoh+I8PF+DZxRiOiSdEBw4Pwt3gSiisvRwIqmKR/fsksy
	Hhkxd0Jbstye4G3z+iLYBZ6j1mbSQkZSvc9QzWO1BF84wqu5LUVmRFqVl61xqKtlDY/KwVtmmYo
	HdaGAPJwiii6kIDlXSi0gNrqtoCgKkMgRiOqX8TYiQg+yI27cua+ApoFrpOel5nSx6p4TyjzyKR
	q9JLnKi80R2k0P2j9GqyKoCGn8CVENX6XluM4ovumU1HCWrfrho1zUJwk2NcCDMuqCW8Ke/tFFY
	szX6f4tIrbtliGyjG4nDQzEpYQO/mAqrfvXereWH2Uu+O7w5QwAkSlDrzfGb3oo4gUFcyY1L4Im
	nEqQDfMS2v7eXyZXULCp22fzWNPhRUr9aJTUVUEmQcbBwsJ2zoU/v5J0nmHeAPjaPSkkh05FwX+
	SQNWuhWBFDbj5So5dX2jooIVKwd+cOpJdxn8XlFY8u0oU/Nvh1DIR4=
X-Received: by 2002:a05:690e:1908:b0:650:1cdb:5f57 with SMTP id 956f58d0204a3-66106e0097amr10641440d50.5.1780848363355;
        Sun, 07 Jun 2026 09:06:03 -0700 (PDT)
Received: from google.com (212.255.145.34.bc.googleusercontent.com. [34.145.255.212])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d5f3b494sm8243034d50.2.2026.06.07.09.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 09:06:02 -0700 (PDT)
Date: Sun, 7 Jun 2026 12:06:01 -0400
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
Subject: [Hypervisor Live Update] Notes from June 1, 2026
Message-ID: <aiWW6ZwwalqQmVcB@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260607_090604_917803_604668AD 
X-CRM114-Status: GOOD (  15.15  )
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

Here are the notes from the Hypervisor Live Update call that happened on 
Monday, June 1. Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not 
attend the call as well as keep the conversation going in between 
meetings.

----->o-----
LPC 2026 Call for Proposals

The Call for Proposals for the Live Update Microconference at LPC 2026 
is officially open. Please submit your topics and proposals before the 
deadline on July 24th.

https://lore.kernel.org/all/ahcc3Qyuy7Oy03Iq@plex

----->o-----
KHO Xarray Implementation & Core Data Structures

Pratyush is collaborating with Mike on a KHO fallback allocation 
strategy for memblock. Alongside this, Pratyush is designing a 
serialized, sparse "KHO Xarray" data structure to lift current mapping 
restrictions across all three memfd types (shared, hugeTLB, and 
guest_memfd). By allowing runtime page faults and allocation tracking 
post-preservation, this avoids flat vmalloc array scalability 
limitations.

Potential wider use cases for the KHO Xarray were discussed:
- MSHV sparse bitmap tracking.
- IOMMU page table tracking (Samiullah will evaluate domain/device tree 
  association fit).
- PCI/VFIO sparse tracking via Bus/Device/Function (BDF) key spaces.

Slab/Cache Preservation vs. Linked Blocks:
David Matlack noted that using an Xarray page per PCI device would be 
too expensive given their small struct sizes. Pratyush suggested 
preserving slab caches via dedicated kmem_cache flags to manage small, 
arbitrary allocations. As an immediate alternative, Pasha's ongoing LUO 
limits refactor series introduces a highly compact block-linked list 
structure optimized for runtime file/session tracking. David Matlack 
will review if this fits the PCI core tracking requirements.

----->o-----
LUO Limit Removal & PCI Core Status

LUO Refactor: Pasha is updating the LUO series to address Pratyush's 
comments (primarily renaming iterator functions) and plans to send out 
v2 shortly. Given that LUO is not yet in fleet production, the group 
agreed to fast-track this into the upcoming merge window to align with 
systemd's fdstore integration.

PCI Core v6: David Matlack sent out v6 incorporating two critical fixes 
spotted by Sachiko regarding get/put semantics and double-retrieval 
failures. Review tags from the live update team are needed to help 
secure Bjorn's Ack once he returns from vacation next week.

----->o-----
IOMMU Persistence & Process Memory

IOMMU v3: Samiullah is addressing recent review feedback on the IOMMU 
persistence series and intends to post v3 by the end of this week. The 
associated development roadmap document has received positive 
stakeholder attention.

CRIU & vm_splice: Maximilian's investigation into optimizing vm_splice 
for copy-less data preservation remains deferred but remains in the 
pipeline, with potential future collaboration with Google's tmpfs splice 
efforts.

----->o-----
guest_memfd Enlightenment & VMM Documentation

Tarun debriefed the community on his upstream presentation regarding the 
initial guest_memfd preservation patch series (currently covering fully 
shared mappings with page-sized folios).

Key design and architecture alignments include:
- VM File Association: guest_memfd requires an active 'struct kvm' 
  context to be retrieved. VMMs must preserve the parent VM file 
  alongside guest_memfd, using LUO tokens to re-link them on the 
  incoming kernel path. This sets the stage for future private 
  mapping/secure EPT table tracking.
- Relaxed Fault Logic: The group agreed to drop strict upfront pre-fault 
  checks. Instead, standard runtime page-fault semantics will apply. If 
  a guest page fault occurs post-preservation, it will bubble up via 
  standard KVM_RUN ioctl exits to the VMM, which can safely pause vCPUs 
  and retry the fault post-kexec.
- Centralized VMM Documentation: Pasha and David Matlack proposed 
  creating a centralized guide under live_update/vmm detailing the 
  overall live update flow, timing constraints, and subsystem 
  requirements to assist external QEMU and VMM developers.

----->o-----
Next meeting will be on Monday, June 15 at 8am PDT (UTC-7), everybody is
welcome: https://meet.google.com/rjn-dmzu-hgq

Note: I am going to be traveling on June 15th, David Matlack is going to
be hosting it.

Topics for the next meeting:
- Presentation of VFIO roadmap (Vipin and David Matlack)
- Status of KHO Xarray development and slab preservation feasibility
- Review of PCI core changes v7 and upstream merge coordination
- IOMMU persistence v3 review feedback
- Detailed review of guest_memfd v2 and VMM interaction documentation
- Review and coordination of LPC 2026 Microconference topic submissions
- later: KHO support for Confidential VMs including page table
  preservation and pinning
- later: versioning support for luod to negotiate
- later: KHO enlightenment for ASI
- later: update on PCI preservation series and next steps
- later: testing methodology to allow downstream consumers to qualify
  that live update works from one version to another
- later: reducing blackout window during live update, including deferred
  struct page initialization

Please let me know if you'd like to propose additional topics for
discussion, thank you!

