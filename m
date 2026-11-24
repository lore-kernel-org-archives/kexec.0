Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB33F606A31E
	for <kexec@archiver.kernel.org>; Tue, 24 Nov 2026 20:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4qPlFV0i;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=dFqy6LJm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=9lR7+FZK4pMd/mVqImDERZx+vy1vSfASfONjlk0tOlI=; b=4qPlFV0i9S1kjsP2wH+FTiqCXI
	K8haajyVwif+H19vZy6YSckSGZxp58U8bZJs4SgKUd7bFIYc59B0fGJHVlKEwH8fprwb3vD8/3o9w
	GjXpXGlool97imlb7yptOTqTt4SOAu0p6QTBf00lW6td5cDxD0OQsLl4uuBZVs9Fg/Jl5JHFjJEWS
	Fo0N1hNvI/CP8SZdkkoz0IitC1diBTQAIZr9K5U4Dr7gOmrN0yu30fXxhXr1thS63coOzKNoeLl3K
	G4rL26rpYpvcJcv9JyDgOuwzCyK9yyTxz7H+Lp4mAjGAY8aMr4ldg2bEg2Ao5ZFcYTt169M0feTSU
	kEn7SUgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVxai-00000007nqd-2ag2;
	Tue, 24 Nov 2026 20:58:16 +0000
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVxaf-00000007nq3-0U35
	for kexec@lists.infradead.org;
	Tue, 24 Nov 2026 20:58:14 +0000
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-9214032a2fdso40816236d6.0
        for <kexec@lists.infradead.org>; Tue, 24 Nov 2026 12:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1795553891; x=1796158691; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9lR7+FZK4pMd/mVqImDERZx+vy1vSfASfONjlk0tOlI=;
        b=dFqy6LJmToC3a1lB1C+Pp9rySN+cFBxkJGBJElNo7yBsHT2KCB51xxnOjtVv/+5ebh
         /G94GsyW+Qrg7cas1quK5UlWMiu0cnQEhkRRQJC9ekVJqarlIwBSgeUbgKINPHefvQFB
         +WPzKdlQnXkS93OaTJ//gzpi+MEDTluT0zsM20Wz7VZIvMmnTyAmWveXD7ieOGEGpygp
         MGhAx3KvmEC1aIOHswtr29uARw1UDfJc8ndCkemZSbAFNMnqWRDidRVpkx1NKOiIr+La
         fpqWv13fYd5yorvW62qJaUiKzYFmAB4rUCwnvSnmDckiXqYUiHNH/NmOBXoyrNg1lH/L
         UuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795553891; x=1796158691;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9lR7+FZK4pMd/mVqImDERZx+vy1vSfASfONjlk0tOlI=;
        b=qUtrlRC2G1XIV7/si5SLrynCL7yW84UpAC/dtqWaxrlOrlgsxTriaq+AkifahuLIs+
         UNmtcU4DVF0/Ywa7zg24rZ09+axTU0MErlJmgkahuIjd4q8OxtpNX81m3flyKSqqprh+
         02OjaSn1I6gfduVRirtv37ehdeUmYpEQPHeBAlHHo4zdC5dzafGgvq3HbjNv0QC7R0MV
         9Jivf6O7iDM/MfUddngfhZwBsIfw/RgEAsdmQIdZil3Haa4EL9mQd9rAShVuL5A53DT5
         ozjO8zf7n+KpXfWcYkR/ESi0lN6Xe4Auxkjn/cSY9zjtUmEL25NnSMoLN5/AHc3XqG9Y
         5B6w==
X-Forwarded-Encrypted: i=1; AL+hErFEcPvTLrG4Ec7hUZOylqLrsKECoT7EYG5puk9o4yDp3TXVaoviEqKGvwVcikB3+pc5SFMP+Q==@lists.infradead.org
X-Gm-Message-State: APuU4Z/VIHsgqLPgxu5hEXMMy4okBUi7DnYtgmY7oy2zLDUIUdlhzHSA
	9kGQ5vxp3+xhhtHtGW5W5goHZ2jy85+OUZgAdChJQ7pdN/3RZEPF1T+pQyUYh8Hn2bs=
X-Gm-Gg: AZFdTZeTuy3/59RbZsC8HfqV0GgvayFQiZBA56+WQ3eNVHbtPwbGAj871sN4Mwkp7r1
	6whZJxnHgZO/2Xi8ngrDSoX2ne1xtFWHBlIPLmIe8+wWhK2bdikbqys4ePg7xZZf5t6PWslKHFx
	y83tWotJfY2V3f9L4oGttzjNeLFQucidtHwVDuLMVIyuZP86Ta7ZJlW8raIEoqcK1UheawvqAFm
	gop1P6A5339C1/p8aJ1Ocb7y4jAod8zjDY8EHhY6LWfIVox9qlllnkEv0N/Jurs5mU3J3Wc0wvH
	1HXemXwodZoS7m18xWbNxU2QJsvADaDKEa7jLcMwxZcy0GTKUla4qwD9/gk13e0M9Y5gEKJ2+bF
	RJYN7kctF1EGtZC3+fVA8BqYgNc870uL5EnJ5Afag/WXikmpfGNAAlQumrJLFqr8dEYfC28G7g0
	ut7b2UpPgMOKwh5zMdO+bjdNy7tKta2E3Z/lcimyEnwmvfhkMK8mhM167F7KghWTAELEsmZaU+0
	EiF+YP5MzrO809ekUcQC+x0NFkqorFyYxEokZyGsZPMTpeFwWEbwvFsmRR4UGinSPfVKtSyqnww
	RvPYbxBx2H2W9ZTNg7K/OnKKZI2HIXKT6AG1CXkwKGCDiRWads8QlpyOlpihbz6xtmeH/yCzXAp
	xL5TaOdPUzRvj7rhNCgaLJxk35VUqQoBhAIlpJoP2nkWie1HV3PXfMk4N71au0gae9kz+6j1iXA
	==
X-Received: by 2002:a05:6214:3382:b0:921:27a1:a4e5 with SMTP id 6a1803df08f44-92134a9a0b6mr276905586d6.28.1795553891171;
        Tue, 24 Nov 2026 12:58:11 -0800 (PST)
Received: from soleen.c.googlers.com.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349d0f6bsm145562816d6.21.2026.11.24.12.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:58:10 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	"Andersen, Tycho" <Tycho.Andersen@amd.com>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Chris Down <chris@chrisdown.name>,
	David Hildenbrand <david@kernel.org>,
	David Matlack <dmatlack@google.com>,
	"Heyne, Maximillian" <mheyne@amazon.de>,
	James Gowans <jgowans@amazon.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Praveen Kumar <kpraveen.lkml@gmail.com>,
	Sagi Shahar <sagis@google.com>,
	Tarun Sahu <tarunsahu@google.com>,
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
Subject: [Hypervisor Live Update] Notes from November 16, 2026
Date: Tue, 24 Nov 2026 15:58:05 -0500
Message-ID: <20261124205808.4097419-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_125813_337557_FE646E55 
X-CRM114-Status: GOOD (  20.20  )
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

Here are the notes from our Hypervisor Live Update call held on November 16.
These notes are intended to bring those who could not attend up to speed
and to keep the momentum going between meetings.

Starting with this meeting, we introduced an "Upstream Review Overview"
section at the top of the agenda to track recent mailing list activity from
the past two weeks, followed by our rotating subsystem workstreams. We also
began maintaining each call's agenda and notes as dated tabs in the shared
Hypervisor Live Update document.

----->o-----
Cross-Subsystem Versioning & Feature Header (kho_header_ser v4)

* Review Feedback & Struct Versioning Policy: Tarun Sahu reported that review
  comments on v4 of the expandable feature header series are largely minor
  and formatting-related, with no major design objections:
  https://lore.kernel.org/all/20261110050202.529473-1-tarunsahu@google.com/

  Responding to David Matlack's question on whether secondary serialized
  structures (such as memfd_folio_ser and pci_dev_ser) should each carry a
  kho_header_ser or defer to their parent struct's feature flags, Pasha,
  David, and Pratyush Yadav aligned on two rules:
  - Any separate serialized struct referenced by pointer (e.g., memfd
    pointing to folio state, or a generic KVM struct pointing to an
    arch-specific struct) should carry its own kho_header_ser. At 8–16 bytes,
    versioning is cheap and ensures uniform static size checks and
    independent evolution.
  - Serialized structs should generally not be embedded directly inside
    another serialized struct, as embedded structs cannot grow later. Callers
    wanting to avoid allocating a dedicated page for a secondary struct can
    pack it after the parent struct in the same preserved page and reference
    it via pointer (as memfd does for kho_vmalloc).

* Separate Metadata Header for kho_block Sets: David Matlack noted that v4
  repeated entry_size and the serialization header on every page in a
  kho_block linked list, even though all entries in a block set share a
  single entry size and version. After weighing special-casing block 0 vs.
  separating the metadata from the data blocks (matching kho_vmalloc and
  upcoming radix-tree / KHO map structures whose root pages hold child
  pointers with no room for inline headers), the group aligned on Pratyush's
  proposal:
  - Move block-set metadata (KHO's own versioning header, entry_size, pointer
    to the first block, and the single shared feature header for the array's
    payload entries) into a separate block-set metadata header struct that
    callers place either in its own page or packed alongside their parent
    struct.
  - Remove the per-block serialization header from individual 1-page data
    blocks so all blocks in the chain are uniform.

* FLB Early-Boot Versioning: Pasha highlighted Chris Down's review comment
  that File Lifecycle Bound (FLB) incoming data is accessed very early in
  boot—before file handlers initialize—so FLB versioning must be validated
  when retrieving incoming FLB state.

----->o-----
Upstream Review Overview (tmpfs, IOMMU, VFIO, PCIe, KHO & LUO)

* tmpfs File Preservation (v4): David Matlack posted v4, returning to the
  "retrieve into an existing file" model per Christian Brauner's feedback
  (which simplifies the implementation) and splitting the selftests into
  smaller commits for easier review:
  https://lore.kernel.org/all/20261111002358.1842967-1-dmatlack@google.com/

* IOMMU Persistence (v7 -> v8): Samiullah Khawaja collected Reviewed-by tags
  from Baolu Lu and Ankit Soni on v6, posted v7, and received follow-up
  feedback from Baolu that he will address in v8:
  https://lore.kernel.org/all/20261110040828.1774343-1-skhawaja@google.com/

* VFIO PCI Live Update (v6 -> v7 Split): Vipin Sharma is addressing David
  Matlack's reviews on v6—evaluating the "retrieve into" user-provided FD
  model (for consistency with LUO APIs) and a dedicated locking scheme:
  https://lore.kernel.org/all/20261102153656.1431701-1-vipinsh@google.com/
  Per discussions with David and Alex Williamson (at KVM Forum), Vipin will
  split the 27-patch v6 series into two smaller series for v7: ~14 core VFIO
  patches and a separate VFIO selftests series (which David can review in
  parallel while Alex reviews core VFIO). Alex also noted that stacking on
  in-flight dependencies prevents Sashiko bot reviews from running, and
  encouraged broader upstream VFIO code participation from the team.

* PCIe Live Update, Save State Refactor & P2P DMA Selftest:
  - PCI Save State Refactor v2: Pasha and David agreed this ~90% PCI core
    refactor should merge via the PCI tree. David is gathering initial
    reviews from Pranjal Shrivastava and Vipin before pinging Bjorn Helgaas:
    https://lore.kernel.org/all/20261106004218.604799-1-dmatlack@google.com/
  - VFIO P2P DMA Selftest RFC: General VFIO selftest extending Vipin's DMA
    test to validate peer-to-peer DMA across live update:
    https://lore.kernel.org/all/20261111192411.4133780-1-dmatlack@google.com/
  - PCI Core Live Update v10: David posted Bjorn's requested pci_dev_ser
    allocation/release refactor as a standalone follow-up patch on top of v10
    to avoid churning linux-next; only two ACS save/restore patches remained
    awaiting Bjorn's Ack:
    https://lore.kernel.org/all/20261109174009.735309-1-dmatlack@google.com/

* Early Session Freeze (v5 -> v6): Per Mike Rapoport's feedback on v5, Pasha
  will move Linux caretaker-specific logic out into the read-only KHO/LUO
  caretaker series and post v6 as a pure LIVEUPDATE_SESSION_FREEZE series:
  https://lore.kernel.org/all/20261105050053.3063001-1-pasha.tatashin@soleen.com/

* KHO Bootmem Sizing, Observability, RISC-V & memfd_luo Fixes:
  - Bootmem Sizing v3 (Mike Rapoport): Reviewed and ready to land:
    https://lore.kernel.org/all/20261112-kho-bootmem-sizing-v3-0-f0c8d00295d5@kernel.org/
  - KHO/LUO Observability (Chris Down): Strong support for observability.
    Pasha and Pratyush discussed sysfs vs. debugfs ABI stability: LUO
    UAPI-visible state (e.g., outgoing/incoming sessions and FDs) fits sysfs,
    whereas KHO internal bootmem/scratch details are still evolving (and KHO
    should be made more flexible rather than cementing internal bootmem
    layout as stable sysfs ABI prematurely):
    https://lore.kernel.org/all/cover.1794383544.git.chris@chrisdown.name/
  - RISC-V KHO v3 (Chen Pei): Clean implementation; reviewed by Pasha and
    Mike, awaiting prerequisites:
    https://lore.kernel.org/all/20261106071459.2003-1-cp0613@linux.alibaba.com/
  - memfd_luo Fixes (Pratyush Yadav): Pratyush will check Chris Down's note
    on "keep memfd frozen until finish" v2 (already reviewed by Pasha and
    Samiullah), and will send v3 of "don't use memfd_pin_folios()" addressing
    Mike's wording comments:
    https://lore.kernel.org/all/20261110175855.2437084-1-pratyush@kernel.org/
    https://lore.kernel.org/all/20261103172251.2348370-1-pratyush@kernel.org/

----->o-----
Orphaned VMs & Linux Caretaker

* Read-Only KHO & Dedicated Caretaker Mapping Code: Mike Rapoport raised
  concerns on the read-only KHO series about exposing raw physical addresses
  (design alternatives still under discussion). On the memfd side, rather
  than adding a caretaker-specific read-only retrieval mode into generic
  memfd code, Pasha and Pratyush agreed to place caretaker-specific memfd
  retrieval/mapping logic in a dedicated caretaker file under
  kernel/liveupdate/ so the intent is clear. Pasha plans to combine the next
  version of read-only KHO, read-only LUO, and initial caretaker mapping code
  into one cohesive series so reviewers can evaluate the end-to-end design.

* Updating the KVM Community on the Linux Caretaker Pivot: David Matlack
  noted that KVM maintainers from LPC may still expect the standalone
  KVM-based caretaker RFC to be the active path. Pasha agreed to post an
  update replying to the original Orphaned VMs RFC cover letter explaining
  why the Linux caretaker approach is being pursued first (more generic,
  supports VMM/virtio exits, easier bring-up) while keeping the KVM-only
  model in mind as a potential future security-hardened option:
  https://lore.kernel.org/all/20260920193650.3373435-1-pasha.tatashin@soleen.com/

----->o-----
KVM Forum Recap & Meeting Logistics

* KVM Forum: David Matlack and Vipin Sharma reported from KVM Forum that
  Paolo Bonzini highlighted Live Update on his "what's coming in KVM"
  roadmap slide, and Vipin aligned with Alex Williamson on splitting the VFIO
  live update series.

* Community Growth & Potential Schedule Adjustment: Pasha noted growing
  upstream interest from Meta and other companies and will invite engineers
  working on live update to join the call. Because Mike Rapoport has a
  recurring biweekly LPC committee conflict at the current Monday 8am PT
  slot, Pasha will check with the expanded group to see whether shifting the
  meeting day/time accommodates more participants.

* Shared Agenda Document Link: Going forward, agendas and notes will live in
  dated tabs inside the public Hypervisor Live Update Google Doc. Pasha will
  add the document link to the internal calendar invite as well.

----->o-----
Agenda Rotation for Next Meeting

* Deferred Deep-Dive Topics First: Because the Upstream Review Overview
  (including the kho_header_ser / kho_block design discussion) and Orphaned
  VMs update filled the hour, Pasha will rotate the agenda so that unreached
  deep-dive topics—KHO & Boot Memory (including Pratyush's KHO map RFC),
  PowerPC/LoongArch/RISC-V KHO Support, Resource Accounting & Session
  Handover, Guest Memory (guest_memfd) / KVM & Confidential VMs, and TDX
  Module & VM Preservation—are covered at the start of the next call.

----->o-----
Action Items & Next Steps

Tarun:
* Post kho_header_ser v5 using a separate block-set metadata header for
  kho_block (removing per-block headers), retaining kho_header_ser on
  pointer-referenced structs, and addressing Chris Down's FLB early-boot
  versioning comment.

Pasha:
* Post LIVEUPDATE_SESSION_FREEZE v6 as a standalone session freeze series
  (moving caretaker-specific pieces to the read-only KHO/LUO caretaker
  series).
* Combine read-only KHO, read-only LUO, and initial kernel/liveupdate/
  caretaker mapping code into a cohesive next revision, and continue
  discussing the physical-address exposure feedback with Mike Rapoport.
* Reply to the Orphaned VMs RFC cover letter updating the KVM community on
  the shift to the Linux caretaker approach.
* Invite interested engineers from Meta and other organizations, explore a
  conflict-free time slot (for Mike Rapoport and others), and add the shared
  Hypervisor Live Update doc link to the internal invite.

David M:
* Follow up with Bjorn Helgaas on the remaining two ACS save/restore patches
  in PCI Live Update v10.
* Coordinate reviews from Pranjal Shrivastava and Vipin Sharma on PCI save
  state refactor v2 before pinging Bjorn.

Vipin:
* Split VFIO Live Update v7 into separate core VFIO (~14 patches) and VFIO
  selftests series, and evaluate "retrieve into" FD semantics and locking per
  David Matlack's review feedback.
* Review David's PCI save state refactor v2 series.

Samiullah:
* Address Baolu Lu's review comments on IOMMU persistence v7 and post v8.

Pratyush:
* Check Chris Down's comment on "memfd_luo: keep memfd frozen until finish"
  v2 and post v3 of "mm/memfd_luo: don't use memfd_pin_folios()" addressing
  Mike's wording feedback.

The Group:
* Review David's tmpfs preservation v4 series, Pratyush's KHO map RFC, and
  Chris Down's KHO/LUO observability series on the mailing list.

----->o-----

Next meeting will be on Monday, November 30 at 8am PST (UTC-8), everybody is
welcome!

Join Here: https://meet.google.com/rjn-dmzu-hgq

Please let me know if you'd like to propose additional topics for
discussion, thank you!

Best regards,
Pasha

