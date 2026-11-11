Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65499606A324
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 21:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jpMkUzN2;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=OQV1ajE2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=r8AUQA6KaaSP0401Cp0Pm+i8FjqoJHWRTLuh0q617+w=; b=jpMkUzN2o+tqlLeyQJmYyjQ1QO
	tddTeMWjJBPl48Pa1sXCTj3tTC6IOO/+NNyuNIvunc/jlXyQo6mLhhLaOzUGeRyJOfn84CVw0fkJN
	rE9v+m1ptQ9kMg2PHUl2WC2y3cvICoUWlVi78gt8rf8b32qA7tzWCJklO4NHixCQuIS1sMphHkiav
	1E923xEPF30WI6GqVdDIQpwqUtmUeq3MU7Nmx725ctMIeuHig7doNXi77yM1Fj0x9Lg+x1sxn9iZM
	P8snew6QQAcMYoSajiVeAcle1cIFMTeilQMxsSSgKR8alkzqb9TeKuAdavyIWVbnTDYkrF4S6M+cM
	1wd8p+5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFad-00000007iNH-0UZy;
	Wed, 11 Nov 2026 21:10:43 +0000
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFaa-00000007iMv-2QEi
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 21:10:42 +0000
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-990703f817fso1694497241.1
        for <kexec@lists.infradead.org>; Wed, 11 Nov 2026 13:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794431439; x=1795036239; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r8AUQA6KaaSP0401Cp0Pm+i8FjqoJHWRTLuh0q617+w=;
        b=OQV1ajE2W5PxTD1pLd2Q3a+6xjevBwhFmACl6yE5xn3mN8QS4A0qdtiX9CEfZnF4NR
         jDHFoCCZ6Jme/7P1Roz5Elbi/7gLuYNnX4ky7yJxF+QpEVXUMOmnnu1peg2936TVFlO0
         +dOdzF0tUzE1igKXbTihRoXN277qgjNnH9rCKVxWqcZWroh3Ami8WrtLpeJaVV8YXEI2
         zBA2FZ640OHQP0XlBtNEDw3pOLsAzAU51UzKu25o6v0/YN7WkQFXDdnoyAO2QocUXbzk
         9qwWvrHSmkySfrgplECQD0lPhCdEb8gzxrCYNL82iSqfieLLr5smCGctmdDv/BvotrJz
         E1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794431439; x=1795036239;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r8AUQA6KaaSP0401Cp0Pm+i8FjqoJHWRTLuh0q617+w=;
        b=dLodmQq7GF3uu14jl5cFvhd9908KTINeT8Pzv4v6WLnGOSsbBWLQp6ClKgMC7/T49P
         aP2yNGjTOGbi64l+YKUBaosvORiWrhozpWrZHhQS7neDHSTAQR4SnFkPCFoDffXeHRZZ
         j5w4aYZJQ7VUnXTeu0duroPCzXc23yfX+EJKoUcdv0fVzFjWdXokuOOWIsoS9vn8gbF7
         e4y3UTlDGa19ZTfk+E5HhCr2Qs4FnQhE66Ltqk+q4MTTvfrqtoTKAvW/aBT0eh9+q0PF
         nIyAvS35WqBFnZls7ALKePsTYdDoCOjYYRxc8CGmmqH4Ntqv0Z7Q+DX+bdpREeMs8xgY
         Yd5w==
X-Forwarded-Encrypted: i=1; AL+hErGVO6fLkYzUMH26H9kYpP0ogFmKl8q0ft9VaIU/DnZlzPpZR6fJj57sarbeDRJbsVO7682WhQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z8NTMWxAJ0XJdvEriEEX7fnpl2hdt20T6wEDq0h5frRcH0tVG4X
	8LYl/iHjNi4YkMpmT67MCAA7+Fid2PUVK7TMGtHaw59Tcrs2S2VbYFSDEs+I2ffcgzs=
X-Gm-Gg: AYBFou2NY4zUOYYvR1niY5KlGm/sdrJIw9JcV4O6Wsow5UKMwlHXyAcO5NMapQHI82n
	wFMvwSoOb3RUJVyWY3EvtEtobAud1ec5KhnV3q2lCRKNhDiwojOvVF4VtkS75dKckaopWKM649I
	hVu6xYamElZzTf+1wtI+f8GINajE1PxXFgbGWrO6hySlAMWU0XHXPiuuJhViwlvutuX79caaZOX
	4uiqeupQmYGwM9tSZa9vmZI623pzx1ZniNNg+ZCED3jKApJbsH9kEVlqhKGLu69MEsMCF1pGVHp
	pX/D8QJOj30XmI4jo3G32Y6RwpeTRV2YfeBgbpUzKgoCa0ivaEOHpJ4qfozj0fLZuheclZjMByC
	KOjPaAmbBfJUzTWDwU8O3Pg/i7jooOgxeXR4R2k9REzxyNEQrjXr5A1j+MleTMlPMO1qyXmJrHk
	rDP9n8SOfNxSHeIyVf+TFDQTKDhyJULKqhNCGZCvReJ/jBwd5NIJ+8bpO+bhkvZD9hKhwajjjKR
	Gud4MQnmBzXLIuGNcXnxUmySsVGn+SOvgbzMu25MofVOZRNO0QRG0Cf+mWKgIMmxnzdSlp4J1pd
	Cn8ZnfOts4rE1REsUK3N53WtSaRcd6FRJ1g1Hoyz8LfahahXaOldH4d/aYbh6V9afrb9lcbRHXs
	fMK4RXgtpndijx+SWWYVq6NYA4I2e9m5tto38qdMyxYGD5JGV7W/Z
X-Received: by 2002:a05:6102:4496:b0:7c3:1395:a090 with SMTP id ada2fe7eead31-7d4fb2a592fmr1781381137.6.1794431438861;
        Wed, 11 Nov 2026 13:10:38 -0800 (PST)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d3023847absm4914038137.8.2026.11.11.13.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 13:10:38 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	"Andersen, Tycho" <Tycho.Andersen@amd.com>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	David Matlack <dmatlack@google.com>,
	"Heyne, Maximillian" <mheyne@amazon.de>,
	James Gowans <jgowans@amazon.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Praveen Kumar <kpraveen.lkml@gmail.com>,
	Vipin Sharma <vipinsh@google.com>,
	Vishal Annapurve <vannapurve@google.com>,
	"Woodhouse, David" <dwmw@amazon.co.uk>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Jork Loeser <jloeser@linux.microsoft.com>,
	Chenghao Duan <duanchenghao@kylinos.cn>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	linux-mm@kvack.org,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [Hypervisor Live Update] Notes from November 2, 2026
Date: Wed, 11 Nov 2026 16:10:30 -0500
Message-ID: <20261111211035.3297484-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_131040_677504_EDC50096 
X-CRM114-Status: GOOD (  21.79  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi everybody,

Here are the notes from our Hypervisor Live Update call held on November 2.
These notes are intended to bring those who could not attend up to speed
and to keep the momentum going between meetings.

----->o-----
Orphaned VMs & Linux Caretaker

* Shift to Specialized Full Linux Caretaker: Evolving the Orphaned VMs RFC
  architecture presented at LPC:

  https://lore.kernel.org/all/20260920193650.3373435-1-pasha.tatashin@soleen.com

  Pasha moved from a standalone KVM-only caretaker runtime to a specialized
  full Linux caretaker kernel. Using Linux directly avoids reimplementing and
  abstracting KVM execution logic in a separate environment and enables
  handling VMM-level VM exits (including select virtio exits such as pvpanic).
  To stay lightweight and isolated, the caretaker boots strictly within its
  assigned memory and physical CPUs—skipping PCI discovery and device access
  entirely and leaving the global KHO tree owned by the host machine owner.

* Supporting Upstream Series:
  - CPU Hotplug Performance Improvements: Standalone series accelerating CPU
    offlining and onlining to reduce physical CPU transfer blackout time
    between the host and caretaker domains:
    https://lore.kernel.org/all/20261019011446.834487-1-pasha.tatashin@soleen.com
  - Read-Only KHO: Introduces a read-only KHO mode for the caretaker kernel
    (currently awaiting upstream review):
    https://lore.kernel.org/all/20261025174017.3870481-1-pasha.tatashin@soleen.com
    Following discussions with Pratyush Yadav and Mike Rapoport, Pasha will
    continue enforcing that KHO-preserved memory outside the caretaker's own
    RAM is excluded from its direct map and mapped read-only on demand,
    preventing accidental KHO modification and avoiding unscalable direct-map
    / struct page exceptions. Read-only memfd changes (previously prototyped
    solely to exercise an end-to-end selftest) will stay separate while core
    read-only KHO is reviewed.
  - Early Session Freeze (LIVEUPDATE_SESSION_FREEZE): v4 is posted upstream:
    https://lore.kernel.org/all/20261026014948.162559-1-pasha.tatashin@soleen.com/

* Caretaker Handover Lifecycle & Session Pinning: Pasha walked through the
  caretaker lifecycle: a global session (e.g., session_lc) holds the
  caretaker's preserved physical CPUs and boot RAM memfd. On the outgoing
  path, the VMM suspends the VM, freezes its LUO session (resolving circular
  FD dependencies and committing metadata to KHO), and tells the caretaker to
  look up the session by name; on the incoming path after kexec, userspace
  stops the caretaker before retrieving and resuming the VM session. Pasha
  discussed adding an optional LIVEUPDATE_SESSION_FREEZE_COMMIT flag (avoiding
  "_IRREVOCABLE" in case an explicit LIVEUPDATE_CMD_SESSION_UNFREEZE ioctl is
  added later) so frozen sessions remain committed in LUO if the VMM exits.
  Pratyush Yadav, David Matlack, and Samiullah Khawaja noted that session
  protection is symmetric across outgoing and incoming paths: while the
  caretaker is actively using a session's preserved resources, the kernel
  should pin / hold a reference in LUO metadata so userspace cannot unfreeze,
  close, or prematurely retrieve and release backing memory (e.g., memfd
  pages) until the caretaker stops.

* Session Isolation vs. Global KHO Tree: Pratyush and David Matlack also
  asked whether the caretaker needs visibility into the global KHO radix tree
  (whose primary purpose is excluding preserved memory from early boot
  allocations, whereas the caretaker boots from dedicated RAM) or could be
  handed only its target LUO session payload(s) for stronger isolation. Pasha
  noted that the caretaker currently maps KHO nodes read-only only along the
  lookup path at retrieve time, and will evaluate whether KHO tree access is
  still needed if session physical addresses are passed directly.

----->o-----
Cross-Subsystem Versioning & Compatibility Strategy

* Expandable Serialization Header (kho_header_ser) v4: Tarun Sahu has v4 of
  the minimal expandable serialization header series ready to post, adding
  entry_size alongside feature flags per Pratyush's review feedback and
  updating existing KHO/LUO serialized structures across upstream Linux.
  Recording entry_size in the header is necessary for early-boot array
  deserialization (such as luo_session_header_ser entries), where callers do
  not inherently know the entry size written by the previous kernel.

* Header Naming Alignment: Tarun asked whether kho_header_ser should be
  renamed to include "feature" to distinguish it when prepended to
  kho_block_header_ser. Pasha and David Matlack agreed to keep kho_header_ser:
  every serialized structure starts with kho_header_ser, while KHO blocks
  naturally follow it with their block-specific kho_block_header_ser.

* Custom Preserve/Retrieve Arguments & Version UAPI: David Matlack is working
  on custom preserve/retrieve argument support alongside tmpfs preservation.
  Pasha suggested landing the serialization header series first and starting
  upstream discussion on the kernel version UAPI in the coming weeks.

----->o-----
Guest Memory (guest_memfd), KVM & Confidential VMs

* End-to-End KVM & Confidential VM PoC Series: Tarun Sahu prepared a combined
  PoC patch series to demonstrate the end-to-end preservation ABI and future
  extensibility for KVM maintainers, structured in layered stages with
  kselftests for each:
  - Non-confidential VM preservation (guest_memfd, KVM VM FD, and vCPU FD
    preservation + selftests).
  - Intel TDX preservation (feature header + selftests, thoroughly reviewed
    with Sagi Shahar).
  - AMD SEV-SNP and ARM CCA preservation (feature headers + selftests,
    prototyped/LLM-tested to illustrate cross-architecture ABI coverage and
    noted accordingly in the cover letter).

* Rebasing & Split Plan: Tarun is cleaning up the PoC series and rebasing it
  onto kho_header_ser v4. Once kho_header_ser lands in liveupdate/next, he
  will post the PoC (marked not-for-merge) to anchor ABI review, with
  standalone vCPU and guest_memfd preservation series prioritized next.

----->o-----
TDX Module & VM Preservation

* KVM PoC Integration & HKID Preservation: Sagi Shahar confirmed that TDX
  preservation is integrated into Tarun's combined KVM PoC patch set. Ongoing
  work is focused on resolving Intel TDX Host Key ID (HKID) preservation
  across kexec.

----->o-----
PCIe Persistence

* Merging PCI v10 & Sequencing for Linux 7.5: With Linux 7.4-rc1 released on
  November 1, liveupdate/next is now open for Linux 7.5. Rather than delaying
  David Matlack's reviewed PCI Live Update v10 series or posting a PCI v11
  that would require re-collecting Reviewed-by tags across the series, Pasha,
  David, and Tarun agreed on a two-step landing sequence:
  1. Pasha will merge PCI v10 into liveupdate/next immediately so it begins
     soaking in linux-next.
  2. Tarun will base kho_header_ser v4 on liveupdate/next and include a patch
     converting PCI's serialized structures (alongside KHO, LUO, and memfd)
     to kho_header_ser, requiring review only on that conversion patch.

----->o-----
VFIO Persistence

* VFIO Live Update v6 Posted: Vipin Sharma returned from leave and posted v6
  of the VFIO live update series (based on PCI v10). Moving beyond the LPC
  prototype (memmap + DSA), v6 uses preserved memfd as the DMA backing source
  in no-IOMMU mode and has been validated end-to-end across kexec on both
  Intel IGB and DSA devices. Community reviews on v6 are welcome.

* PCI Save State Dependency: To get v6 out for review without stacking another
  unmerged series, Vipin included temporary manual serialization of PCI save
  state into an allocated buffer. David Matlack noted that because the
  kernel's current pci_saved_state layout is code-driven and not ABI-stable
  across kernel versions, his PCI save state rework series must merge ahead
  of VFIO. David will review VFIO v6 while Vipin reviews the PCI save state
  rework series to accelerate landing it first.

----->o-----
IOMMU Persistence & LUO Core

* IOMMU Persistence v6 -> v7: Samiullah Khawaja received Reviewed-by tags
  from Baolu Lu on the Intel IOMMU driver, IOMMU core, and IOMMUFD changes in
  v6, and plans to post v7 soon.

* Preventing memfd Hole-Punching Hazards for IOMMU Mappings: Samiullah
  started an upstream discussion (mm/memfd: add F_SEAL_PUNCH_HOLE) to prevent
  a gap where userspace maps memfd pages into IOMMUFD and punches a hole
  (FALLOC_FL_PUNCH_HOLE) prior to memfd preservation—discarding pinned pages
  that existing seals do not block so they are missing after kexec. Per
  feedback from David Hildenbrand, rather than introducing a new seal UAPI,
  memfd will set a sticky flag whenever a hole is punched, and IOMMU preserve
  will reject memfds with that flag set (leaving standalone memfd preserve
  unchanged). Investigating this path also uncovered and fixed a bug in
  memfd_pin_folios().

* Hitless Replacement & IOTLB Conflicts: Upstream discussions continue on
  hitless IOMMU translation replacement across kexec and evaluating potential
  IOTLB conflicts.

----->o-----
Agenda Rotation for Next Meeting

* Deferred Topics First: Because the first seven agenda items filled the
  hour, Pasha will continue rotating the agenda so that the remaining topics—
  tmpfs File Preservation, KHO & Boot Memory (bootmem), PowerPC & LoongArch
  KHO Support, and Resource Accounting & Session Handover—are covered at the
  beginning of the next call.

----->o-----
Action Items & Next Steps

Pasha:
* Merge PCI Live Update v10 into liveupdate/next for Linux 7.5.
* Post the next revision of the early session freeze series incorporating
  caretaker session pinning / lifecycle updates.
* Evaluate whether the Linux caretaker still requires KHO tree access if
  session payload physical addresses are passed directly.
* Rotate the deferred topics (tmpfs, KHO/bootmem, PowerPC & LoongArch) to the
  top of the agenda for the next meeting.

Tarun:
* Post kho_header_ser v4 (with entry_size) rebased onto liveupdate/next,
  converting PCI v10 alongside existing KHO, LUO, and memfd structures.
* Clean up, rebase, and post the combined KVM + guest_memfd + confidential VM
  (TDX, SEV-SNP, ARM CCA) preservation PoC series once kho_header_ser is in
  liveupdate/next.

David M:
* Review Vipin's VFIO live update v6 series.
* Continue work on generic/custom LUO preserve & retrieve arguments alongside
  the next tmpfs preservation series.

Vipin:
* Review David Matlack's PCI save state rework series so VFIO preservation
  can rebase onto ABI-stable PCI save state structures.

Samiullah:
* Post IOMMU persistence v7 incorporating review feedback and tags.
* Implement the sticky memfd punch-hole tracking flag check for IOMMU
  preserve and continue hitless IOTLB replacement discussions.

Pratyush:
* Review Pasha's read-only KHO and updated early session freeze series, as
  well as Tarun's kho_header_ser v4 series.

Sagi:
* Continue working on TDX HKID preservation across kexec with Tarun's KVM/TDX
  PoC series.

The Group:
* Review Pasha's read-only KHO series and Vipin's VFIO live update v6 series
  on the mailing list.

----->o-----

Next meeting will be on Monday, November 16 at 8am PST (UTC-8), everybody is
welcome!

Join Here: https://meet.google.com/rjn-dmzu-hgq

Please let me know if you'd like to propose additional topics for
discussion, thank you!

Best regards,
Pasha

