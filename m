Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB2EC61DD3
	for <kexec@archiver.kernel.org>; Fri,  4 Sep 2026 02:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LxY6qhOONdJBthzGvWEGTMppcR7CBwrMwbeMuLpGO0o=; b=ZhuaX3iAo0Nzmmg7n4eal2qj17
	owc2eMKsoL9oqp+8Wr88qPGhxznaykwNPjkRGcg0ApVuILjRVmPQ0f50vJRr9BEzbvOfktzeA/Y/7
	/FpvqDpmqhV7YBbM3a9bpz/I1pHCC4wn7nrTfx3NeK6nuD5LPUeAIfZ2OTK1TngbENSfJaROyJnS/
	2LXplNlkgd+gm92o1yS6V4pIsoIxtgCbQbcdhIdhz657QuFD+dU0EdMT0IxvVjc4d4Mng4KLmUfyO
	I2oM7NTudl5RKqxnVNkvtOcXF4vznlAHevwhD26QG+WoScoGAEukMrxHm68cPnMb4fVwhOuSaMQP9
	T6IUEpzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2Jxl-00000000tOs-3R6x;
	Fri, 04 Sep 2026 02:47:33 +0000
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2Jxj-00000000tNv-2FrS
	for kexec@lists.infradead.org;
	Fri, 04 Sep 2026 02:47:32 +0000
Received: by mail-yx1-xb12e.google.com with SMTP id 956f58d0204a3-66f7f62e915so483220d50.3
        for <kexec@lists.infradead.org>; Thu, 03 Sep 2026 19:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1788490050; x=1789094850; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LxY6qhOONdJBthzGvWEGTMppcR7CBwrMwbeMuLpGO0o=;
        b=bZ9eFLs9iG83Q/mrBMnNQtZw8McATmXEaNh/tLmwSgGhQruy+hxXPRFrjoTDtT0vTd
         hQw5/7io2au2pW2nKZfxUR9Qj2JmadhDN9PH7v+aV05ttpw4n+jk1ditbyoRVMKO+WF9
         MGN5RBOAkd9G5sfeh4QadUdxrmGs/BWaMKBBo9t903CHhPDOSj7v7Gb2zrKz1eh+S8Ua
         ghl2pi4vQ71meD1OXZ4hCYwHVZpKRNrCzJGUyn/0S76/2gugQbhbiQn1wDKC3im/pStO
         MFHTWEjFOKqyoxhVTUQ70NoloGly5YgNMqc0zZAtebm4x8u4+ID9bJw9k7OYDmJqLsBF
         bjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788490050; x=1789094850;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LxY6qhOONdJBthzGvWEGTMppcR7CBwrMwbeMuLpGO0o=;
        b=MKBkCTxWvFo4gLNC3OxyS9YR30zEoxj6BMJ68bh4fyQvIQivZQYH7XK72DPSR7rWYJ
         xvDZDajRRpwWohi8aRjszpVI8TrbXrY5YVx0x4Q8uAJrI3GVEfFC6p2Nz+jOMdJiw4Un
         JM+RMxeKxNJOOPSDsqqLKyZh7La67uhYmHLFik8q5LydZA7/g1vRId7+vzQQFfywEUmG
         k8Hs+sgiswkyOIG8CgXRqj1bYMzqymCUQ8IKAgdG/bU/vkBAhIZJ8VSVsSWtial8x7Na
         fW4tSSTbjjoZisu93RYNiHLEI058C+qmIM4aDb//IPm4I0wJ4KsQ2oSW8ZD2MbAXwjLf
         IDHA==
X-Forwarded-Encrypted: i=1; AKwUvBxDEbALa97nU9xx8TBbt7Uwx12MFSXgOYBcADAZYQZlUml0+seDOvmIa5pXkY7rptH5AY/N7g==@lists.infradead.org
X-Gm-Message-State: AFuF++kmj7mXsxwqAMAFKeo/PqhZn/d7FaVYqqloVR8a6XMu4nkfKvGH
	tM3yhfQppfCAzbepeQtugqlsftdgreKPfRxBlvjXnWm6XtNlo1z0FFngwPH/SRJZapg=
X-Gm-Gg: AYBFou3gdS/roBg7WNKtEMT1LFoN+COZWw6DeVEr2nGez1RdWk8E1HDX1ke3vPKkWJX
	PrJBlo/7AAVckLbIuUHExVsS8j1t3yUuqz0/d562hD7WlaeR1trutAESFoHZpeVf0mmPZ2802XS
	6cXI/Ylgao/p0XgFfnSi10NLdVew3dKpxeQBqr8L07Xty9O/2ZRaEqiFuW2d0YkxjEvWCkiueeU
	Pgo0qxCz7I/IadHRQEEelC8LT0HFsJ7rLDAs1wYKlu9IsDKs0hN4pQfeJtgcUvFx4JR5I8tStX5
	JOpiWMVBhpDTXMfDM5eoG6/aVoHDVxxoorjZLRR6BnVdiRZby2sHbGd+yzlMFNSgoleDqvrLZT6
	cLoMttw0AzgH8eEB5Jf9fD6ClRMjChXv/60ff26tv3pDDxTrycEgMu3McNdLYRv0vqHuJbVD4Wz
	NH6mf9I8J26LyVn41aLaNiDF4LUyCOUZewQaMgq5ZhHcS05WwR1Plc0LZjyWj0sv1iqLzR2O4CC
	rGM+gl0MdyP+hGiclmAkThQj1m/5JGXpl0AYsWH3JRSUSyeKryMTOchmJbcTB901PF+T0KPdrPO
	tQSxtA==
X-Received: by 2002:a05:690e:1a1f:b0:66c:486c:aa1b with SMTP id 956f58d0204a3-66fb5aa022amr879870d50.38.1788490049588;
        Thu, 03 Sep 2026 19:47:29 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-87149315127sm9475207b3.10.2026.09.03.19.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 19:47:28 -0700 (PDT)
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
Subject: [Hypervisor Live Update] Notes from August 24, 2026
Date: Thu,  3 Sep 2026 22:47:07 -0400
Message-ID: <20260904024724.3815033-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260903_194731_617482_12BC49BA 
X-CRM114-Status: GOOD (  20.63  )
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

Here are the notes from our Hypervisor Live Update call held on August 24.
These notes are intended to bring those who could not attend up to speed
and to keep the momentum going between meetings.

----->o-----
LPC 2026 Proposals & Microconference Planning

* Status & Notifications: Review decisions and reply notifications have
  been sent out to all authors who submitted proposals to the Live Update
  Microconference. Attendees are requested to confirm their attendance and
  notify Pasha of any registration or travel issues for Prague.

* Session Timing & Format: The schedule is being finalized; time slots are
  expected to be 15–20 minutes total (including Q&A) given the large number
  of accepted topics. Presenters are encouraged to keep slide decks brief
  (2–3 slides) to maximize interactive discussion on technical hurdles and
  unblocking upstream progress.

* Orphaned VMs in KVM Track: Orphaned VM proposals were accepted into the
  KVM microconference, which takes place immediately prior to the Live
  Update track. Attendees are encouraged to participate in both tracks for
  comprehensive live update coverage.

----->o-----
PCIe Persistence

* Landing Plan: The PCIe Live Update series will be merged into the Live
  Update tree (liveupdate/next) right after the Linux 7.3 merge window
  closes, targeting Linux 7.4. David Matlack collected additional Reviewed-by
  tags from Samiullah Khawaja and Pranjal Shrivastava.

* Upstream Review: David followed up with Bjorn Helgaas to confirm the
  landing plan and request his Acked-by. If no reply is received by the end
  of the week, David will reach out internally.

* Structure Versioning: Cross-subsystem data structure versioning will be
  addressed as an independent follow-up rather than holding up the current
  PCI series.

----->o-----
VFIO Persistence

* VFIO v6 Status: Vipin Sharma was delayed due to personal commitments
  (relocating) and plans to post the v6 series next week.

* Subsystem Landing Path: Following consultation with Alex Williamson, it
  was confirmed that VFIO changes will go through the VFIO tree, using
  immutable branches for dependencies that touch core Live Update or core
  PCI.

* End-to-End Demonstration Strategy: Alex noted that because live update is
  marked experimental, seeing a working end-to-end demonstration would help
  build confidence and expedite reviews.

* No-IOMMU PoC: The current VFIO series performs a reset during freeze and
  does not yet preserve virtual config space or PCI restore state. In
  addition, full VFIO device retrieval post-kexec requires IOMMUFD support.
  Because IOMMUFD recently gained an upstream "no-IOMMU" mode, Vipin will
  build a working end-to-end proof of concept demonstrating continuous DMA
  across kexec on a separate repository branch, while posting the v6 series
  upstream.

----->o-----
IOMMU Persistence & LUO

* IOMMU v5 Status: Samiullah Khawaja is preparing v5 to incorporate review
  feedback regarding device removal, rescan, and rediscovery handling.

* Device Retrieval RFC: The Phase 2 implementation for device retrieval via
  IOMMUFD is functional on GitHub and will be posted as an RFC series
  shortly to begin upstream review.

* LUO Core v3: Samiullah posted v3 of the incoming and outgoing session
  management series (get_incoming / get_outgoing), including updated
  in-tree documentation.

----->o-----
PowerPC KHO Support

* RFC Patch Series: Sourabh Jain posted an RFC series enabling KHO on the
  PowerPC architecture.

* Memory Reservation Ordering: On PowerPC, Kdump memory reservation happens
  very early in arch code, whereas scratch memory reservation occurs later
  from generic code (start_kernel -> mm init). On the PowerPC Hash MMU,
  the crash kernel must reside entirely in low memory (below 4GB), which
  exhausts low memory and causes subsequent scratch memory reservation to
  fail. Consequently, the current RFC disables crash dump support when KHO is
  enabled.

* Use Cases & Roadmap: Pasha noted that cloud hypervisor live update targets
  often do not configure Kdump or use firmware-assisted dump (FADump),
  making the initial series without concurrent Kdump sufficient as a baseline.
  Sourabh emphasized that enterprise environments will ultimately require
  both crash dumping (via high memory reservation on Radix MMU or FADump)
  and KHO to function together. Pasha will review the RFC patches.

----->o-----
Guest Memory (guest_memfd) & Compatibility Strategy

* Backward Compatibility Concerns: In upstream reviews of guest_memfd
  preservation, Sean Christopherson raised strong objections to merging KVM
  preservation without a clear backward compatibility plan (specifically for
  kernel rollbacks, where an older kernel must deserialize state preserved
  by a newer kernel). Sean cited Intel VMCS AR bytes handled via microcode
  as an example of maintaining architectural compatibility without breaking
  software contracts.

* Alignment & Roadmap: While Linux historically guarantees UAPI stability
  rather than in-kernel ABI stability, Sean is treating backward compatibility
  as a prerequisite for merging KVM changes. He also requested a clear
  roadmap for KVM state preservation (clarifying why VM file descriptors and
  VM type are preserved alongside guest_memfd) to ensure serialization
  structures are extensible upfront.

* Unified Versioning Proposal: Samiullah suggested using extensible structures
  with capability flags to decouple serialized formats from internal kernel
  layouts. David Matlack noted that Logan plans to post an upstream RFC thread
  proposing a unified versioning and backward compatibility model across
  subsystems (KVM, VFIO, PCI). David will invite Logan to present this model
  at our next biweekly meeting, and Sean will also be invited to align before
  LPC.

----->o-----
TDX Model Preservation

* Proof of Concept: Sagi Shahar demonstrated successful TDX model
  preservation across kexec: running a VM, executing a live update kexec,
  and subsequently launching and running a TD VM on the new kernel. Code
  cleanup is underway to share with the group.

----->o-----
Orphaned VMs & Development Environment

* Multi-Architecture: Pasha presented updated results
  from the Orphaned VM prototype
  (https://github.com/soleen/orphanvm), showing uninterrupted execution
  across kexec on ARM, Intel (Simics emulation), and AMD (QEMU emulation).

* Continuous Workload Results: A guest workload continuously writes to a
  2MB page while the host monitors write throughput across kexec:
  - ARM: ~3,715 loops/sec baseline -> ~5,000 loops/sec during kexec (throughput
    increases during reboot because host interrupts are quieted) -> ~4,700
    loops/sec after resuming under the new kernel.
  - Intel and AMD showed similar uninterrupted progress across reboot.

* Modular Architecture for LPC: Pasha will present an architectural breakdown
  at LPC to divide Orphaned VMs into reviewable upstream components (e.g.,
  separating physical core preservation from vCPU file descriptor
  preservation, an in-kernel caretaker thread, and suspending vCPUs when
  physical cores are not preserved).

* Emulated Devices: Addressing Tarun's analysis showing ~52 misconfiguration
  VM exits/sec from emulated devices during live update, Pasha clarified that
  emulated devices requiring host VMM MMIO handling are intentionally not
  supported in the initial Orphaned VM architecture; hardware offload (e.g.,
  smartNIC/accelerator) may be explored in the future.

* Repository Access: Pasha will send David Matlack an invitation to the
  private development repository.

----->o-----
Action Items & Next Steps

Pasha:
* Review Sourabh's PowerPC KHO RFC patches.
* Send David Matlack an invite to the orphanvm repository.
* Finalize the LPC Live Update microconference schedule and session timings.

David M:
* Follow up internally with Bjorn Helgaas on PCI v8 if no reply by end of week.
* Coordinate with Logan regarding the upstream versioning discussion thread
  and invite him to present at the next biweekly meeting.

Vipin:
* Build an end-to-end working demo of VFIO live update using IOMMUFD no-IOMMU
  mode on a separate branch.
* Submit VFIO v6 series upstream.

Samiullah:
* Post IOMMU v5 addressing device removal and rediscovery feedback.
* Submit Phase 2 device retrieval RFC series based on IOMMUFD.

Sourabh:
* Continue discussions on the PowerPC KHO RFC regarding memory ordering
  trade-offs and MMU constraints.

Logan:
* Post an upstream RFC/discussion thread on cross-subsystem versioning and
  backward compatibility.
* Present the proposed versioning model at the next biweekly meeting.

Tarun:
* Continue upstream alignment on guest_memfd and KVM preservation with
  Sean Christopherson.

Sagi:
* Clean up TDX model preservation code and share with the team.

The Group:
* Confirm LPC attendance and notify Pasha of any registration or travel
  issues.

----->o-----

Please note that there will be NO meeting on September 7 due to the US
Public Holiday (Labor Day). The next meeting will be on Monday,
September 21 at 8am PDT (UTC-7), everybody is welcome!

Join Here: https://meet.google.com/rjn-dmzu-hgq

Please let me know if you'd like to propose additional topics for
discussion, thank you!

Best regards,
Pasha

