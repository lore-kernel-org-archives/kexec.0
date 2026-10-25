Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C4B606A31A
	for <kexec@archiver.kernel.org>; Sun, 25 Oct 2026 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xJ0DUicf;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=Au7F2L0m
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=p8TpnlZQqHoJQXNIEVycNifGEfr+D4SXzqPcwNXn9W8=; b=xJ0DUicfe5HGMxp05dBVSrSK3j
	3CYjOeJr7M1wADbJdaL5EJOGeg+F1ltxGix3u1seuDpY2p50iaMRkMSacNDl1Og06jZcbnTJo2VHv
	Gw5ei5EC8VbCPwUtu3Zg8wlIYqyxr9WtcA2MOayNoICT7//0GVlfBrop2C39UL2WDsWRgzDyuWVEs
	xTTHPi61OmHASBmIze7PcPRKuYG55awZqgcLsjXE4QSoqLyg8jdcBDNsyEjJywNwjn7sTKBezL4RC
	Z8RPLnB3cFADhrT1IqtaMnZMN2q0NimGrCPT8SuXe9Jc1MTq7kAvNdlPk1SX4PUF1WLZX8yrrUut+
	Zs1cwADQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKzKW-000000017r7-43Im;
	Sun, 25 Oct 2026 14:36:12 +0000
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKzKQ-000000017qe-3G0B
	for kexec@lists.infradead.org;
	Sun, 25 Oct 2026 14:36:08 +0000
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-5eac6c5f927so916224e0c.0
        for <kexec@lists.infradead.org>; Sun, 25 Oct 2026 07:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792938965; x=1793543765; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p8TpnlZQqHoJQXNIEVycNifGEfr+D4SXzqPcwNXn9W8=;
        b=Au7F2L0mcOjSAeIVb3XUcpHnXQc6qrlkOMbUUsbx0z4J38IOk/HlpVa9biESQSy34M
         VgbE7lqbp19FAfqnJfga4BSR1rt20vydrOFOqu6HIgthI/bKASmOdxCEnIAu3IwlaYeE
         VnD4bMttObBT14Kd1fkxZ3eDgfs3Z3cy6szxJhh3mz1ix9xG2ZkmnLh/OS+BQjxqohZT
         dMMFKlgK2Mkh+cPxe/2NVr8zHGZ0lGNlP/SQQZ8WghNLnupYmueezE2N0FXZFyQ85ZbK
         IO8+OH2Br5zFAE2igHvmHxdOP3WJJ/O3/ffPvqpjayBcBL6kVadhp7LybniA9JVQ8m68
         QtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792938965; x=1793543765;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p8TpnlZQqHoJQXNIEVycNifGEfr+D4SXzqPcwNXn9W8=;
        b=b4O3r1toQ095CJWKFv8F2wW60wFo8yCiW+2HF6SRC583OgBXyQN797C1F5olwpDV8Q
         DTOUCHfTaIJnV28RfAXFqXq9wNbXbvp8JZKkUD+ld0rtW4OS9vzPCklllFENtFJb6w1j
         mOY65ETByPBfStM4HLHIaUczTgIwsiKkNaPpTRk+dGxsDTl3do/IFoTZAz/8BlriEUcq
         8Od9+0HPxYl4TBGZN0vx+0GrdhCHFDd3PE/9PVJAbVJnY/NfrkTB15v8XXFbGU6WCE6J
         v2bxL++JpdJ/jhAbjZoCO0htWOB74i64o8V28VR6mTlYQrZpwEeBoDC+DR4ENilmXeiU
         Ddyg==
X-Forwarded-Encrypted: i=1; AKwUvByoZlC8GcUQp2NQVrWghALdZE/6amqOli+y2+YVDLUNGskYYWYkuBfrYxz4Y6t21yQc5eaX5Q==@lists.infradead.org
X-Gm-Message-State: AFq9FYJIB1BVJIHz5bLDeVid55R6FilAslwzeAS1jeuzFHuDonTKfGpm
	FUS3H5A+XOt5IIYf8Y2e8YthaQtuF3Q3t2EJ0pA+lydbzpJx0cfT02oAQQRV5MaJS28=
X-Gm-Gg: AYBFou3dtHIPw4LGOZ7fioa/k+ox/XwRR29TAtSi8gBHSSNmS/bWjawASsYt764dCE/
	Kz2M8P9ei8an9q1bAgOv/SNsnMhtAc3q/vAw9kQ0QorpyeoHrJdw/2MuIqqSTIs9eGAWrIfdQ3J
	a3BSJL8CfpdPXxfiF/vjakpx5OLoKMEFa+wy7nuBDfWGKaN+gu1p3wiR3fNsUC8NNmft4e+CYzU
	fgIAC0FNTBYUMQKmyWua9SlVGQ249On1vpp9sKMaoQJUp2zd7GrV/abhtfQB+e5xxyFbqQojgjY
	KB+Srw577Nc4IBmqUdQUcSKF5O8n0qH6eMsPNJYNHiHLYs5NKChRnAcgsNfcLof+GshYSnTP4Ic
	RDUZ0HhQjFns03FLHPF+zyaO8Z2U403eix7xH0GhkpSTypcZhtdhiqzvyPDKU1b0s/5VDa8QrUh
	JpVFLOnNnq7mTdyo2REqWZnzHfE6pMq3vfSf1CXtSGTi+Tomf+qzHiU0gCnZUpHsAFWlxfSLOfy
	MWcqtrZSpaRYMYGSmjA4+l1h0PcqoiaIT55N1E3nSuANkyuP2+l7y2e79uwjOYtwidwxjGJGfNP
	L6rrzVag10ZO03+Wf08T1ukkj5jyGjjFdzK3R9qEt5kVdoLpaVpCop0v6AV6QLBomTsrgIaU6RK
	5
X-Received: by 2002:a05:6122:1b05:b0:5db:4749:1737 with SMTP id 71dfb90a1353d-5ec231f5be2mr1218362e0c.4.1792938964559;
        Sun, 25 Oct 2026 07:36:04 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec234618c9sm5531291e0c.11.2026.10.25.07.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 07:36:04 -0700 (PDT)
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
Subject: [Hypervisor Live Update] Notes from October 19, 2026
Date: Sun, 25 Oct 2026 10:35:33 -0400
Message-ID: <20261025143601.2564170-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261025_073606_920095_695D743F 
X-CRM114-Status: GOOD (  22.03  )
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi everybody,

Here are the notes from our Hypervisor Live Update call held on October 19.
These notes are intended to bring those who could not attend up to speed
and to keep the momentum going between meetings.

----->o-----
LPC 2026 Recap & Takeaways

* Track Placement for Subsystem Topics: Following a successful experiment
  moving KVM-related live update talks (such as Orphaned VMs) into the KVM
  Microconference, David Matlack and Pasha agreed that subsystem-specific
  live update topics (e.g., VFIO, IOMMU, PCI) should target their respective
  subsystem microconferences next year. Now that core Live Update concepts
  are established, presenting directly in subsystem tracks ensures the
  relevant maintainers are in the room while freeing up time in the
  Live Update Microconference.

* Focused Core Sessions: For future Live Update Microconferences, the group
  plans to be stricter on topic selection—focusing the track on core,
  cross-cutting architectural topics (such as versioning and LUO core)—with
  longer time slots, minimal slides (2–3 slides), and discussion-focused
  sessions aimed at concrete outcomes.

----->o-----
Cross-Subsystem Versioning & Compatibility Strategy

* Post-LPC Alignment: The Live Update BoF organized by Pratyush Yadav at
  LPC helped clarify maintainer expectations and establish a path forward
  with Sean Christopherson and Jason Gunthorpe without blocking ongoing
  series.

* Minimal Expandable Header First: Rather than trying to lock down a full
  versioning UAPI upfront—which requires extensive scrutiny given permanent
  UAPI stability guarantees—the group will start by introducing a minimal,
  expandable serialization header (with size and feature flags) and updating
  all existing serialized structures across upstream Linux to use it.

* Next Steps: Tarun Sahu took over sending the initial expandable header
  patch series from Pratyush, as it directly unblocks the guest_memfd and
  KVM preservation work.

----->o-----
PCIe Persistence

* PCI v10 & Target Kernel Retargeting: David Matlack posted v10 of the base
  PCIe Live Update series, adding ACS egress control vector save/restore per
  Alex Williamson, kernel-doc improvements per Mike Rapoport, and a flags
  field in the serialized structure (to be replaced by the standard header
  once available). Because v10 arrived too late for sufficient linux-next
  soak time ahead of Linux 7.4, Mike Rapoport noted off-list that the series
  will now target Linux 7.5. Pasha will merge v10 into liveupdate/next
  immediately after the Linux 7.4 merge window closes.

* PCIe Core Roadmap & Upcoming Series: David published the PCIe core live
  update roadmap to the mailing list prior to LPC:
  - PCI Save State Refactor: Posted upstream to restructure PCI save state
    data structures in preparation for VFIO preservation.
  - Peer-to-Peer DMA & MMIO Preservation: Ready to post this week. Preserves
    bridge windows and device BARs and avoids destructive BAR sizing during
    enumeration so preserved devices (and Orphaned VMs performing MMIO) can
    continue memory transactions across kexec.

* Testing Strategy: David is currently validating the peer-to-peer DMA
  series using the VFIO live update kexec selftests under QEMU with PCI
  config space write tracing to verify that preserved BARs and bridge
  windows are untouched across reboot. To enable standalone PCI core testing
  before VFIO support lands, David plans to prototype a selftest kernel
  module (a minimal no-op PCI driver that binds to a device and preserves
  it via LUO).

----->o-----
VFIO Persistence

* Full Preservation via no-IOMMU Mode: Vipin Sharma returns from parental
  leave on October 21. At LPC, the group agreed with Alex Williamson to
  restructure the next VFIO series so that it lands full VFIO device
  preservation in a single series using no-IOMMU mode (preserving internal
  driver state and skipping device reset across kexec), rather than landing
  a partial series that resets the device.

* IOMMUFD Integration & Ordering: Once the complete no-IOMMU VFIO series is
  in place, Samiullah Khawaja's IOMMUFD persistence series will hook into it
  via a single small patch calling IOMMUFD preserve/unpreserve/restore APIs.
  Samiullah clarified the dependency ordering: userspace preserves IOMMUFD
  first (preserving core domain state), followed by VFIO. Because an IOMMU
  domain may have multiple attached devices where only a subset is being
  preserved, VFIO calls into IOMMUFD during its preservation step to
  preserve the device-specific IOMMUFD state whose lifecycle it owns.

----->o-----
IOMMU Persistence & LUO Core

* IOMMU v6 & Architecture RFCs: Samiullah received review feedback from
  Nicolin Chen and Baolu Lu on v5 and is preparing v6, incorporating
  LPC UAPI and design updates. Additionally, AMD and ARM IOMMU preservation
  RFC series have now been posted to the mailing list; Samiullah will review
  both series.

* Dependency Ordering & Early Freeze: Samiullah will defer his LPC proposal
  for explicit FD dependency tracking and batching in LUO. Following
  discussions with KVM maintainers on how live migration enforces strict
  ioctl ordering in userspace, Pasha and Samiullah agreed to enforce
  dependency ordering on userspace during preservation, while using Pasha's
  new user-triggerable early freeze patch as the synchronization point to
  resolve any circular dependencies across file handlers.

----->o-----
tmpfs File Preservation

* Refined Retrieve Design (O_TMPFILE + linkat): Building on the LPC
  discussion and subsequent mailing list refinement by David Matlack,
  Pratyush Yadav, and Pasha, LUO will create the restored tmpfs file
  directly during the retrieve ioctl via generic arguments rather than
  backfilling a pre-opened userspace FD (avoiding races with concurrent
  userspace accesses).

* Unlinked File Creation: Modeled after openat(2) with O_TMPFILE, userspace
  passes a target directory FD and flags to retrieve, and LUO returns an
  unnamed, unlinked tmpfs file FD on that mount. Userspace can either keep
  it as an anonymous temp file or link it into the filesystem namespace via
  linkat(2). This keeps LUO completely agnostic of filenames and variable-
  length path strings.

* Patch Series Split: David will include Pasha's generic retrieve argument
  patches in the next revision of the tmpfs series. Pasha's early freeze
  patches will be split out as a standalone series, with Pratyush reviewing
  them on v1.

----->o-----
KHO & Scratch Memory

* Scratch-to-Bootmem Rename: Pratyush reported that the patch series
  renaming KHO "scratch memory" to "boot memory" (bootmem) is queued in
  liveupdate/next.

* KHO XArray & Sparse memfd Support: Pratyush has implemented the KHO XArray
  data structure and is integrating it into memfd. Pasha and Pratyush
  discussed using sparse memfd preservation (large virtual address space
  with unpopulated holes) as the primary motivating use case and selftest.
  Supporting sparse memfds without faulting in holes requires updating the
  pinning path to pin only populated pages and disallow new page faults
  after preservation; Pratyush will evaluate the fault, migration, and swap
  path implications.

* CMA Pinning Bottlenecks & Scratch Memory: Pratyush noted an Ubuntu bug
  report where KHO's pre-reserved CMA regions restrict pinnable memory for
  GPUs. Tarun has been analyzing CMA allocation behavior: normal movable
  allocations default to ZONE_NORMAL until it fills up, leaving no room for
  pinned allocations in ZONE_NORMAL because movable pages are not migrated
  into CMA (ZONE_MOVABLE). Tarun discussed adding ZONE_NORMAL-to-CMA page
  migration with David Hildenbrand, who agreed it would be a valuable
  kernel improvement to alleviate CMA pinning pressure while longer-term
  alternatives to pre-reserved KHO scratch memory are investigated.

----->o-----
PowerPC & LoongArch KHO Support

* Real-Mode Execution of kho_populate(): Sourabh Jain reported a review finding
  from Sashiko on the PowerPC KHO series: kho_populate() was being invoked
  too late during boot, after several early memblock allocations had already
  taken place and could overwrite preserved memory regions. On PowerPC,
  running kho_populate() prior to any memblock allocations requires calling
  it in real mode (before the MMU is enabled in start_kernel). However,
  generic kho_populate() uses early_memremap(), which returns virtual
  addresses that cannot be accessed in PowerPC real mode.

* Architecture Mapping Abstraction: Sourabh and Pratyush agreed to add a
  lightweight architecture abstraction so generic kho_populate() receives a
  usable pointer—continuing to use early_memremap() on architectures like
  x86 (where the MMU is active and uncached physical accesses are slow)
  while allowing PowerPC to pass a direct real-mode physical address.
  Sourabh plans to post the updated series this week.

* Static memblock Array Limit (128 Regions): Sourabh also checked whether
  populating KHO regions before dynamic memblock array resizing is enabled
  could hit the static 128-entry BSS array limit. Pratyush and Pasha confirmed
  that 128 entries are shared across architectures and sufficient for 2 + N
  scratch regions (where N is the number of NUMA nodes); if ever needed,
  dynamic resizing can be enabled as soon as the first scratch region is
  registered, or the static size can scale with CONFIG_NODES_SHIFT.

----->o-----
Guest Memory (guest_memfd), KVM & Confidential VMs

* KVM & guest_memfd PoC Series: Following LPC discussions, Tarun Sahu is
  preparing a combined PoC series (VM preservation, vCPU preservation, and
  guest_memfd preservation) by the end of October to demonstrate the end-to-
  end ABI for KVM maintainers, after which guest_memfd preservation can
  proceed standalone. To unblock this, Tarun is also incorporating custom
  arguments for LUO preserve and retrieve ioctls alongside the expandable
  serialization header series.

* Confidential VMs (TDX & SEV-SNP) Require In-Kernel Live Update: Pasha,
  Sagi Shahar, and David Matlack confirmed that confidential VMs (Intel TDX
  and AMD SEV-SNP) cannot perform host kernel updates via userspace live
  migration / copy-out flows: guest memory and control structures use
  physical-address-dependent encryption (pages cannot be relocated in
  physical memory) and architectural state (TDX SEPT tables and VMCS pages,
  or SNP RMP/VMSA state) cannot be exported to userspace. Consequently,
  in-kernel KHO/LUO preservation of guest_memfd, VM FDs, and vCPU FDs is an
  essential requirement for updating hypervisor kernels running confidential
  VMs. Sagi noted that Google's internal copyless TDX migration uses this
  same in-kernel transfer approach.

----->o-----
TDX Module Preservation & Orphaned VMs

* TDX Module Preservation Status: Sagi Shahar reported that TDX module
  preservation across kexec is working. He is now connecting it to TDX VM
  preservation, where the main remaining hurdle is traversing and preserving
  Secure EPT (SEPT) tables across kexec. Pasha pointed Sagi to the EPT
  traversal and preservation implementation in the Orphaned VMs RFC series.

* Orphaned VMs Supporting Series: Pasha posted two new upstream patch series
  supporting Orphaned VMs:
  1. Read-only KHO: Enables the lightweight Linux caretaker to read preserved
     KHO state without full KHO initialization.
  2. CPU Hotplug (Online/Offline) Performance Improvements: Standalone
     series accelerating CPU offlining and onlining, benefiting both general
     host operations and Orphaned VM physical CPU preservation.
  Because time ran short, Orphaned VMs will be moved to the first agenda
  item for our next meeting.

----->o-----
Action Items & Next Steps

Pasha:
* Merge PCI v10 into liveupdate/next right after the Linux 7.4 merge window.
* Split early freeze patches into a standalone series (separate from generic
  retrieve arguments).
* Move Orphaned VMs to the top of the agenda for the next meeting.

David M:
* Post the PCIe peer-to-peer DMA / bridge window & BAR preservation series.
* Prototype a standalone PCI core live update selftest kernel module.
* Incorporate Pasha's generic retrieve argument patches into the next tmpfs
  preservation series using the O_TMPFILE + linkat model.

Tarun:
* Post the minimal expandable serialization header + custom LUO preserve/
  retrieve argument patch series.
* Post the combined KVM VM + vCPU + guest_memfd preservation PoC series by
  the end of October.
* Continue investigating ZONE_NORMAL-to-CMA page migration for pinnable
  memory pressure.

Pratyush:
* Review Pasha's standalone early freeze patches on v1.
* Evaluate memfd pinning and fault-disabling changes to support sparse
  memfd preservation with KHO XArray.

Samiullah:
* Post IOMMU persistence v6 incorporating review feedback and LPC updates.
* Review the AMD and ARM IOMMU preservation RFC series on the mailing list.

Sourabh:
* Post the next revision of the PowerPC KHO series with real-mode
  kho_populate() mapping support.

Sagi:
* Review the EPT preservation logic in the Orphaned VMs RFC to integrate
  with TDX SEPT table preservation.

----->o-----

Next meeting will be on Monday, November 2 at 8am PST (UTC-8), everybody is
welcome!

Join Here: https://meet.google.com/rjn-dmzu-hgq

Please let me know if you'd like to propose additional topics for
discussion, thank you!

Best regards,
Pasha

