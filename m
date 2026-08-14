Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEC3C5CFCF
	for <kexec@archiver.kernel.org>; Fri, 14 Aug 2026 15:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=86UK8C/44s//WP7keHPKgb58fEaGLPE6HLPpAhR5zNg=; b=1op09N1dwGXfnOG9IVbeVk0La4
	xXxk7Ya/RCfnB5oZ79SxHoefp3+6Pz/hl5C+l4fnN83ro4U8swHPklXe+nBJiwHAn2N1SrxELhCqb
	1MOPOjcSzrwDNlZUrF3de4O0t/tZW/ViVkAHVX7n/tvcO29HMMfbrk8l1n8gapBEaJ2PNWTavyrUB
	a2dhyWpCw8AOG/fKd42W+ZjKp6CERc2ocduElxULNz3AsSUosp+nLasxOrAw7WXJRQty4a8qqqQIS
	Payu4MXBeUkSQTfDPbt4et0FyAC303pNIkV9OdrlU9PPmMJbPIoRKk6ou8mYW4ZRHNV7nKkqdf6Zc
	euk6neHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wutT1-00000002pqo-2zqh;
	Fri, 14 Aug 2026 15:05:07 +0000
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wutSy-00000002pqM-07UP
	for kexec@lists.infradead.org;
	Fri, 14 Aug 2026 15:05:05 +0000
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-7ff05e5d009so12828657b3.1
        for <kexec@lists.infradead.org>; Fri, 14 Aug 2026 08:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1786719902; x=1787324702; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=86UK8C/44s//WP7keHPKgb58fEaGLPE6HLPpAhR5zNg=;
        b=lKZ+oiushJlh890oqG69rYtkH8tUeDRJHa/phv1RKM1jMdfCpnXwCSPDRz3AMuk2N+
         B3BWrJGvarNZVpZc62t6GQeO89b7HoyX1j31NGe7zvs6sV9J7YVa3Y9rqdp9W/oMkgPx
         xslGyoLTAQGiGyiXkDN1NhcW8A/l8NWkXy0IbMhLWnY66jIasY3xnrTuEpBD6YUJA8E8
         8eWswI5G3cqqLpFV3BhkQRe4CpEYLR+U1HTyzbhgvZHaWWZVEF2jKdDm4VmsiLgjo3rm
         wXevWod3UpVYyd0jSZMRSXFw43Ad9Jjnaq3nxPvubygH6cCP6yxh3g3CioFBP8+PSPAa
         O+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786719902; x=1787324702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=86UK8C/44s//WP7keHPKgb58fEaGLPE6HLPpAhR5zNg=;
        b=SZ9nTSoj3sokND+ZPB5kcAwTog+Lg7Q0cK/Ak9QypeFNK9G8YBT6Qr9w1R2QNfIGxc
         3fO76oU2KqOA3WlbAgAdHHm9ubcNj3cVCVk4ERyio5/N8D1o5pULljJLvWGo9Bzr+jQ9
         1N+9Sf0uJCnSBM8hkBzHQEX/e9D1t89Iqv87giz6++vCy2yPNzdouP4QeKHgy4MSD6iV
         YFjQVSPG9jfzAXH8gE5E868921BH/sP0PEbg9r/p4Zv+oMBkaNQdJHYf/ii3P+RW6r4T
         UD5CdkbEC4y0oPK3pD4B8G0YizBz58oIgGhsxlv3vC1jYJbZK/LG+RaoV6oaXz5fifXm
         E6hQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq7mqmale4PNgRSMllqCeskzZgycmf8YrLFEqMPOtjfqs+WzxC+u5JFChmR/K0H9xAW21L9Gg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxyWYnzBHTQMz/aFANIMrEz2zVs8yC6K+ZbojWb5AfbJYutO+r0
	fiiGa/7Mmp9u38vJDbxCQ0V8C1dULNo6JrR0zXxe4rNBInxWYey+4bTXo6k0h9TV/pI=
X-Gm-Gg: AR+sD114+nlAtulMxikBfwcoE+dOmL4ek3LeRuZrqomgERwTUSqi/NamvSzu2/NIxrL
	6svjfe41ZUDyN9/pKhgyTxK9yhzBHYUhjAdg8swMfXuUozI9rUSRxBdSET2xSefRL6IZlQm77fn
	ip6q8dW7zHZkkU9EwKTSpvMGt0om1gf7te2YBT1uTErNHo58FH6GDeuvN/+HMceD69X+LJ3H6Wo
	+CWl6QEk1sGGZlb5VVVl6KCUMF4A3PxZLWJ9BU94mZrbeN2+vmmNQYnjUcmS4ViCBjD5Htg6V2b
	SHc90QPCAIceWj48y2PQIzGeM34GgXg+X8LrQligjBnkZPWLoXcYFiUgYGmjane2QuChRfUkdh0
	qBekLsOOTSrNQWYj68SU6Vd8FwLejWB3oGNQnB7Btz0J4/5+zkg6vg0Kmy6cgvEcn9KyTIP6V5+
	GPAitkfJD7Z1w5R9o9LHA0OZUVVs5Dp7e5hQSxjCw57myXpLXS9fRliRqoHLjxTCsT4BmVscE2M
	7R2ax5N6ma4asquG4chFpm8l40QCNstq6zMgSVVCH4VhQsCVBvFD5/1r4xNhBFu8GNHgUJpol3E
	fQ80HGVJXVaCvsp+
X-Received: by 2002:a05:690c:388:b0:81f:e85b:f9da with SMTP id 00721157ae682-83713575858mr25091967b3.33.1786719901568;
        Fri, 14 Aug 2026 08:05:01 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836c1778540sm14328757b3.29.2026.08.14.08.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 08:05:01 -0700 (PDT)
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
Subject: [Hypervisor Live Update] Notes from August 10, 2026
Date: Fri, 14 Aug 2026 11:04:53 -0400
Message-ID: <20260814150457.2268163-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260814_080504_109031_2403DADA 
X-CRM114-Status: GOOD (  18.27  )
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

Here are the notes from our Hypervisor Live Update call held on August 10.
These notes are intended to bring those who could not attend up to speed
and to keep the momentum going between meetings.

----->o-----
LPC 2026 Proposals & Microconference Planning

* CFP Closed: The Call for Proposals closed on August 7th with 13 submissions
  received for the Live Update Microconference.

* Review & Track Balancing: The organizers are reviewing submissions to
  prioritize key design discussions. Three topics (Orphaned VMs proposed by
  Pasha and Pratyush, and guest_memfd preservation proposed by Tarun) have
  been submitted to both Live Update and KVM tracks. Organizers will coordinate
  to balance the schedule and ensure appropriate track placement without
  duplicate sessions.

* Session Timing: The group discussed session lengths (considering a mix of
  lightning talks and longer interactive discussions). The Live Update
  microconference schedule is finalized with no overlap with the Networking
  track.

----->o-----
PCIe Persistence

* PCI v8 Status: David Matlack sent out the PCI v8 series two weeks ago,
  incorporating review feedback from Bjorn Helgaas on v7 and moving versioning
  out of the compatibility string into the first field of the pci_ser structure.

* Landing Strategy & Linux-next Soaking: Although too late for the 7.3 merge
  window, the group agreed to create a separate PCI branch and start soaking
  it in the Live Update tree (liveupdate/next) so dependent series (such as
  IOMMU) can base on official Linux-next, targeting Linux 7.4. Pasha will
  review and add Acked-by tags.

----->o-----
VFIO Persistence

* VFIO v6 Status: Vipin Sharma is preparing v6 rebased on top of David's
  PCI v8, targeting submission before our next meeting.

* Landing Tree: Awaiting feedback from Alex Williamson regarding the base
  landing tree. Pasha will follow up on the mailing list thread.

* Lockdep Investigation: Vipin will start a separate mailing list thread with
  a reproducer for the CPU hotplug / ATS lockdep warning to address it
  independently of the Live Update series.

* Testing & Review: Zhu Yanjun verified the VFIO live update test setup
  successfully in QEMU. Vipin requested code reviews from the group on
  David's patches within the VFIO series.

----->o-----
IOMMU Persistence

* IOMMU v4 Status: Samiullah Khawaja posted v4, incorporating Baolu Lu's
  review comments, refactoring code into live_update.c, fixing lifecycle bugs,
  and aligning compatibility string versioning with PCI.

* Landing Tree: Confirmed with maintainers (Will Deacon and Baolu Lu) that the
  series will land via the IOMMU tree (as noted in the cover letter).

* Ordering Guidelines: Samiullah will document in-tree guidelines for file
  preservation ordering dependencies (e.g., preserve() vs freeze()) in a
  future update.

----->o-----
KHO & LUO

* KHO Extended Scratch Memory: Pratyush Yadav's KHO extended scratch memory
  series (v4) has been soaking in Linux-next for a week and is on track for
  the 7.3 merge window.

* Scratch to Boot Memory Rename: Pratyush will now proceed with the follow-up
  rename of scratch memory to boot memory across the codebase.

* KHO XArray: Pratyush is developing the initial skeleton for KHO XArray, which
  will provide the foundation for removing freezing requirements in shmem and
  guest_memfd.

* LoongArch KHO Support: George Guo submitted a new version passing the KHO FDT
  pointer via a new EFI GUID. Ard Biesheuvel provided an Ack for this approach,
  establishing a clean, generic method for LoongArch and any architecture
  using EFI.

----->o-----
PowerPC KHO Support

* PowerPC Enablement: Sourabh Jain (IBM kexec/kdump maintainer) joined the
  meeting to discuss enabling KHO on PowerPC.

* Memory Reservation & Discovery: Sourabh reported scratch memory allocation
  failures when Kdump (3GB) was configured. Pasha clarified that scratch memory
  does not require low memory allocation. Pratyush clarified that KHO scratch
  discovery (kho_populate()) must run very early right after memblock
  initialization to activate scratch-only mode before any memory allocations
  (including Kdump) occur. Cold-boot reservation (kho_memory_init()) happens
  later after mm_init().

* Next Steps: Standalone KHO tests pass on PowerPC without Kdump. The group
  recommended submitting the initial PowerPC KHO series with Kdump mutually
  excluded or documented in the cover letter, followed by investigating early
  virtual mapping / Kdump co-existence. Sourabh will participate regularly
  in future meetings.

----->o-----
Guest Memory (guest_memfd)

* guest_memfd v4 Status: Tarun Sahu addressed review feedback from Ackerley
  Tng. Test cases will be split across separate commits within the test file.
  The initiate_shared flag is replaced by checking kvm_arch_has_private_mem()
  to verify whether confidential guest memory is supported.

* Freezing Removal: Removing the freezing requirement will be addressed as a
  follow-up feature using KHO XArray and will not block the initial guest_memfd
  landing.

* Module Loading Requirement: The group discussed handling un-loaded modules
  during live update retrieval (missing file handlers currently cause
  retrieval to fail for all sessions). The team agreed that for hypervisor
  environments, all required modules (e.g. KVM) must be loaded prior to
  session retrieval. Tarun will update the LUO documentation to explicitly
  state this requirement.

----->o-----
HugeTLB

* HugeTLB preservation remains on hold pending the landing of extended scratch
  memory and progress on KHO XArray.

----->o-----
Orphaned VMs & Development Environment

* Multi-Architecture Environment: Pasha presented updates on the open-source
  development environment (https://github.com/soleen/orphanvm). It now supports
  Intel (Simics full hardware emulation), AMD (QEMU full emulation), and ARM
  (QEMU with GICv3 full emulation), completing live updates across kexec in
  under 10 seconds.

* vCPU Aliveness Test: A guest test workload performing continuous computations
  and memory writes was added to allow the host to monitor vCPU aliveness and
  state during CPU offline/online cycles without making syscalls.

* VM Exits: Tarun has collected VM exit trace data during live update and will
  analyze it to present findings at the next meeting or LPC.

----->o-----
Action Items & Next Steps

Pasha:
* Review and add Acked-by to PCI v8; coordinate branch in liveupdate tree for
  Linux-next.
* Follow up on the VFIO landing tree thread with Alex Williamson.
* Coordinate with LPC KVM and Live Update microconference organizers on talk
  selections and session durations.

David M:
* Follow up with Bjorn Helgaas on remaining PCI v8 review tags.

Vipin:
* Post separate thread and reproducer for CPU hotplug/ATS lockdep issue.
* Rebase and send VFIO v6 before next meeting.

Samiullah:
* Document in-tree guidelines for file preservation ordering dependencies.
* Coordinate IOMMU v4 series landing via IOMMU tree.

Pratyush:
* Implement KHO scratch to boot memory rename.
* Review LoongArch EFI GUID KHO patch series.
* Continue development on KHO XArray skeleton.

Tarun:
* Post guest_memfd preservation v5 with split test commits and
  kvm_arch_has_private_mem() check.
* Update LUO documentation clarifying that all preserved modules must be
  loaded prior to session retrieval.
* Analyze VM exit trace data for discussion at the next meeting / LPC.

Sourabh:
* Post initial PowerPC KHO enablement series and test updates (with Kdump
  mutual exclusion / caveats documented in cover letter).

----->o-----

Next meeting will be on Monday, August 24 at 8am PDT (UTC-7), everybody is
welcome!

Join Here: https://meet.google.com/rjn-dmzu-hgq

Please let me know if you'd like to propose additional topics for
discussion, thank you!

Best regards,
Pasha

