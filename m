Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A700C9830D
	for <kexec@archiver.kernel.org>; Fri, 25 Sep 2026 14:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZxNgNSJX4HyjFFXMdv8+7KY9lC6WrSxA50f2U6JT134=; b=cL+HhjiTahOxNwoShpQp7JdEga
	fS3NvBEA49nS4CCCI9fS5Wwi9WeQtqPU7ypNxqDlpV9FT+/YpFOvlzXs6Px74VSwR06TYJ8RWEz+7
	LXUFUcOg9b+b5mqd8GgJt/bhKjdPEcuVRumuq7sThIQc1AXC8pC13952HqmGuUtdcgo5xNJ6gLlkb
	5GuMi/l4BrgywzcNAPJNAbO2wdijmDjAHPkPLtT26TotOjDl4llQoCY76MdWuUXG5Lcwss3mllgoU
	mO3o/gnw4j9NxfQpNiefw+EN6qoB12iu6HMDtBeB/D/lV/raoLhQXijT9y1i2kUTa34v7zWHtVDSV
	v8WUbhfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA6wF-0000000DarB-1grm;
	Fri, 25 Sep 2026 14:30:11 +0000
Received: from mail-yx2-x0d.google.com ([2607:f8b0:4864:41::d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA6wB-0000000Dap5-1iMi
	for kexec@lists.infradead.org;
	Fri, 25 Sep 2026 14:30:09 +0000
Received: by mail-yx2-x0d.google.com with SMTP id 00721157ae682-8a860e5505aso8438967b3.1
        for <kexec@lists.infradead.org>; Fri, 25 Sep 2026 07:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1790346605; x=1790951405; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZxNgNSJX4HyjFFXMdv8+7KY9lC6WrSxA50f2U6JT134=;
        b=a+rRIa+QMg4I3T7b3k+9td7o4YLma/mxqadE2ZhSWi63HPzayuVtt1ZV83WNsk0wTR
         mLAeywJvoRfYdzzJdRzOg8a0yHLri36424q70SpNRd9NoLkdE1gB+DJ6r8pBTP9P3kTP
         O4Mh6RqsTtCfCu0M7Q3I+eYlRkfZJIOkyPgFVOl2x4fKMxYBhYlKww0kxyz8lsdz6GJ2
         Htkr39uT1Y7g4y7FQQEwgrmeeM1xS/UQoLMwR+eHcBjvO/p3ImR0IDbMQC678SLj8+AQ
         Cbkocq70XFbucS9GANNnk5wd0VP506QD6YIx/gFTxTGg3J+l4fvOWzhTkIqPvpVW0Tx1
         YwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790346605; x=1790951405;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZxNgNSJX4HyjFFXMdv8+7KY9lC6WrSxA50f2U6JT134=;
        b=kkHSEkyiiINIPN+EEcisOxw2WndatoaTwFnLMvqEOd2gIDZKmCqyzUJXf4z1e6p7/+
         ts8ksXvCnrynSJhYOLy5j1aol2DAJJ8S5dIQeyvJQaFq2sWK/TTG3SGWMWmJUHdqwH02
         urvt0ninGOH8mIWraINAy7Ty/WvrmXnrSiVOkHoCnjwK61oRijyBfHIVcqwyVy2wQ+Zc
         DYbUa5QHEsDfTk7vvHBewoFXT3sZlgn88FYRSRotG9ZqZk4ULKF9CPizmFlha1kyZzFl
         W29T8NqW6xs1u9NFd9IK1dIxVIVmwmSufqtsTdTgWbds5elP+bC6CrR1y1p7NrEhkbjD
         337w==
X-Forwarded-Encrypted: i=1; AKwUvBzz6b5XWteC/ozXn38ZUjk9tnstKlD4jum0PLKpUR6pT47nGrfZIcSKp+iLtrSfiChgDAta5g==@lists.infradead.org
X-Gm-Message-State: AFuF++mWkVdygGTvFSS76unitqndxGMxN7hR1j902V4iAn9Gq46zTWDT
	qxDPazpdjEe+3pgilv6kADUxoTzC5+IYB9fBvVuQloAtifDKMO0fBScr+J1bjmC4AeE=
X-Gm-Gg: AYBFou1N0zrVIGk71WZpChTWya4C+kPiL8TIKBgyDW3cTtt2mmi4TI1CiKluldNYRI3
	M2Uxl8cTse0RWy2iugFghW6ks3SVXkqx2EwNxxoqlNmKJHEk0Q8Rsnoe6jlt5LhmC938RWwEj1a
	l3cTXrEhLlumi5dkJNcVSCmr3U8xMXFSljONLjw9OZ6Mh3och1y2cBp51jeRxEgIssO7tB2UrLy
	YTV2pNHThQSZH66iOkc1K6kGIHvi71K6h55LIc2SciEbxX0g388vo/SO6F2a+FaVjVwUBdt9TCV
	s/XjrMQZwsMeAJ/NMpxiiapg9qgvN3FCK7lM3YU28y37uBEmrvXTfnM1/Yy9sttze+h67f14GP0
	MrPFofAUyxKNhpa6UG5o8XDK/3pfap29fqs1sCBPyB0+GzVqtgkdJH+qM9SxaP46M33GPne8KDW
	Cg9DDvF8yy5TLxif2SBLLmi4ksqY4BJHy5/eNepfB5DRzyJe5NeDRGDxjW+jeFLnBZQvTwQFedL
	QewMVgv7iNNkfayW9VHElnnFnQIA/mwslEGz4rVdXhpXa5e1laKC7IO6v2plHxkCLOwNY9/685S
	Gpz11+BOpD8pYfsgoVQ=
X-Received: by 2002:a05:690c:c4e5:b0:8a8:675b:2bc0 with SMTP id 00721157ae682-8a8675b2e50mr10279907b3.35.1790346605434;
        Fri, 25 Sep 2026 07:30:05 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a86102bbafsm8810897b3.39.2026.09.25.07.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 07:30:04 -0700 (PDT)
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
Subject: [Hypervisor Live Update] Notes from September 21, 2026
Date: Fri, 25 Sep 2026 10:29:43 -0400
Message-ID: <20260925143000.2729890-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_073007_548716_53F13573 
X-CRM114-Status: GOOD (  26.06  )
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

Here are the notes from our Hypervisor Live Update call held on September 21.
These notes are intended to bring those who could not attend up to speed
and to keep the momentum going between meetings.

----->o-----
LPC 2026 Microconference & BoF Planning

* Topic Adjustment (tmpfs vs. PCIe): Because the PCIe Live Update series is
  converging on the mailing list and close to landing, David Matlack and
  Pasha agreed to repurpose David's LPC microconference slot to discuss
  tmpfs file preservation, which requires broader architectural alignment.
  David will still prepare PCIe roadmap slides for anyone interested.

* Versioning & Compatibility BoF: Resolving cross-subsystem versioning and
  backward compatibility remains the top priority for LPC. Since a 15–20
  minute microconference slot will not be sufficient to settle all details,
  Pratyush Yadav will schedule a follow-up Live Update BoF session after
  Logan's talk (targeting Day 3, as Day 2 is fully booked with the KVM and
  Live Update tracks).

* Single Combined Overflow Session: To avoid splitting attendees across
  multiple rooms and times, the group will hold a single Live Update BoF
  focused primarily on versioning and compatibility, using any remaining
  time as overflow for tmpfs file preservation discussions.

----->o-----
PCIe Persistence

* PCI v9 Status: Bjorn Helgaas finished reviewing v8, and David Matlack
  posted v9 addressing all feedback. All major design questions raised on
  v8 have been resolved.

* Remaining Reviews: Three patches in v9 still need Reviewed-by tags:
  - Patches 6 and 9 were simplified based on Bjorn's feedback, so prior
    Reviewed-by tags were dropped; previous reviewers are asked to take
    another look.
  - Patch 8 is a new patch added per Bjorn's feedback to save and restore
    PCIe ACS controls.

* Landing Timeline: Pasha will wait a few days for Bjorn's final review
  tags before applying v9 to liveupdate/next, aiming to land the series
  within the next 1–2 weeks (ideally next week prior to 7.3-rc6) for
  Linux 7.4.

----->o-----
VFIO Persistence

* Status & Device Reset Discussion: Vipin Sharma is currently on parental
  leave (attending LPC and returning in October). Samiullah Khawaja noted
  that during end-to-end testing with IOMMU Phase 2, the current VFIO
  series resets the device during shutdown/freeze, whereas the PCI core
  does not.

* End-to-End Preservation: David Matlack clarified that the current VFIO
  series provides the mechanics for preserving the device file descriptor
  but does not yet preserve enough internal VFIO driver state to skip the
  reset. Avoiding the device reset to demonstrate continuous end-to-end
  DMA across kexec aligns with Alex Williamson's feedback and will be
  addressed in the next revision when Vipin returns.

----->o-----
IOMMU Persistence & LUO Core

* IOMMU v5 Status: Samiullah Khawaja posted v5 of the IOMMU persistence
  series addressing review feedback and corner cases. Baolu Lu raised a
  concern regarding keeping ATS state synchronized between the old and new
  kernels; because addressing this requires additional PCI core changes and
  complex IOMMU handling, it has been deferred to a follow-up series to
  keep v5's scope manageable.

* Phase 2 (Device Retrieval): Samiullah pushed an updated Phase 2 branch to
  GitHub reworking device retrieval, keeping it on GitHub for testing
  before posting an upstream RFC.

* LUO Documentation: Samiullah submitted a separate patch updating the
  in-tree LUO documentation, which Mike Rapoport has merged into the
  liveupdate tree.

----->o-----
tmpfs File Preservation

* Retrieve-into-FD Proposal: David Matlack presented his RFC series for
  preserving tmpfs files across kexec. During preserve, the kernel accepts
  a tmpfs FD and preserves only its underlying file contents (folios,
  seals, etc., reusing the shmem/memfd mechanics) without filesystem
  metadata (mounts, permissions, UID/GID, or timestamps). After kexec,
  userspace recreates its tmpfs mounts and empty files with desired
  permissions, then passes the newly opened tmpfs FD to LUO to backfill
  the preserved contents into it.

* Dependencies & Post-Preserve Updates: David noted that keeping
  preservation within a tmpfs file allows dependent subsystems (such as
  IOMMUFD mappings backed by tmpfs) to be preserved naturally. Pratyush
  added that converting files via splice breaks the live-update contract
  for post-preserve memory modifications (and future support for growing
  or shrinking files after preserve), as userspace would have to manually
  resynchronize changes.

* Design Options for LPC Discussion: The group identified four approaches
  to evaluate at LPC:
  1. No tmpfs support: Require userspace to migrate to memfd directly.
  2. Retrieve into an existing FD (David's proposal): Minimal code and UAPI
     footprint; Samiullah noted that backfilling state into a userspace-
     opened FD could also help non-anonymous files with specific paths or
     permissions (e.g., VFIO cdevs). However, Pasha raised concerns about
     breaking LUO's resource/session ownership model and cross-mount
     accounting, and Pratyush questioned whether the new UAPI is
     sufficiently generic.
  3. Mount + Selective File Preservation (Pratyush's proposal): Preserve a
     tmpfs mount FD (metadata only) and selective regular files within it
     using LUO's internal dependency tracking and relative paths. This
     avoids new ioctls and keeps resource creation in the kernel, though
     David questioned whether kernel mount management is necessary when
     userspace already manages mounts pre- and post-kexec.
  4. Zero-copy splice between tmpfs and memfd: Uses existing UAPI without
     expanding LUO's scope, though limited to isolated files without
     kernel dependencies or post-preserve modifications.

----->o-----
KHO & Scratch Memory

* Mainline & Rename Status: Pratyush Yadav reported that KHO extended
  scratch memory has been merged into mainline for Linux 7.3. He will post
  the follow-up series renaming "scratch memory" to "boot memory" (bootmem)
  after fixing minor typos reported by Sashiko.

* KHO XArray: The basic XArray data structure is implemented; wiring it
  into memfd and testing will resume after LPC preparations.

* Re-evaluating Pre-Reserved Scratch Memory: Pratyush, Samiullah, and Tarun
  Sahu discussed whether pre-reserved CMA-backed scratch memory can be
  eliminated in favor of relying entirely on dynamic extended scratch
  memory (potentially with a tiny early-boot bootstrap region). Pre-reserved
  scratch memory has caused recurring issues across architectures (PowerPC,
  LoongArch), NUMA accounting, and CMA compaction regressions. Guaranteeing
  reliability against memory fragmentation remains an open challenge;
  Samiullah documented the initial ideas for further discussion at LPC.

----->o-----
PowerPC & LoongArch KHO Support

* PowerPC NUMA Accounting Fix & v1: Sourabh Jain reported productive
  feedback on the PowerPC KHO RFC series. While testing with CONFIG_NUMA,
  he discovered a bug where global scratch size calculation inadvertently
  includes per-node reservations when the node ID is -1.

* Next Steps: Pratyush and Pasha recommended landing PowerPC KHO support
  using the current scratch model rather than blocking on long-term scratch
  redesigns. Sourabh is preparing a separate fix for the global vs. per-NUMA
  accounting bug and will follow up with v1 of the PowerPC KHO series.
  Pratyush will review the latest PowerPC and LoongArch patches on the list.

----->o-----
Orphaned VMs

* 47-Patch RFC Series Posted: Pasha posted the Orphaned Virtual Machines
  RFC series to the mailing list:

  https://lore.kernel.org/all/20260920193650.3373435-1-pasha.tatashin@soleen.com

  (The first 40 patches are on the list; patches 41–47 will follow once the
  24-hour mail server recipient limit resets.)

* Modular Architecture & Workstreams: The RFC provides a complete end-to-end
  implementation with regression tests, structured into layered components
  that can be developed and reviewed as independent workstreams:
  1. KHO/LUO: In-kernel vCPU FD and VM FD preservation (building on
     guest_memfd preservation).
  2. Physical CPU Preservation (cpu_preserve): Preserves physical CPUs
     across kexec so they appear offline to the host (also usable
     standalone to speed up host reboot by skipping SMP bringup).
  3. On-Core Scheduler (oncore): Schedules contexts onto preserved CPUs.
  4. KVM & Kernel Caretaker: Lightweight execution context across Intel
     VMX, AMD SVM, and ARM64 handling ~12 essential VM exit types during
     host reboot, with potential application to syscall-free userspace
     processes (e.g., network accelerators).

* Live Bare-Metal LLM Demo: Pasha demonstrated a live kexec reboot on a
  13th-gen Intel server (20 CPUs, 32 GB RAM) running an Orphaned VM
  executing a Llama LLM text-generation workload:
  - The guest generated ~48–56 tokens/sec prior to update, streaming output
    to a pre-faulted guest physical memory buffer monitored by the host
    (with all guest memory and EPT page tables pre-faulted).
  - Suspending the VM onto 4 preserved physical CPUs (leaving 16 online
    host CPUs) instantaneously transitioned the guest to the caretaker at
    ~22 tokens/sec.
  - Across the host kexec reboot, the VM continued generating tokens
    without interruption (advancing from ~3,000 to ~4,000 tokens during
    reboot) and seamlessly resumed full 20-CPU execution in the new kernel.
  - Pasha also demonstrated scaling to a single P-core vs. E-core and
    inspecting caretaker VM exit and stall counters via debugfs.

----->o-----
Action Items & Next Steps

Pasha:
* Send the remaining 7 patches (41–47) of the Orphaned VMs RFC series.
* Apply PCI v9 to liveupdate/next once Bjorn's remaining tags arrive.
* Include caretaker debugfs VM exit counters in the LPC live demo.
* Share access to the meeting recordings folder with Sourabh Jain.

David M:
* Prepare LPC slides for the tmpfs file preservation discussion (plus
  reference slides for the PCIe roadmap).
* Follow up on reviews for patches 6, 8, and 9 in PCI v9.

Pratyush:
* Schedule the LPC Live Update BoF session (versioning/compatibility and
  tmpfs overflow) after Logan's talk.
* Post the KHO scratch-to-bootmem rename series.
* Review the PowerPC and LoongArch KHO series and prepare Orphaned VM
  profiling material for LPC.

Samiullah:
* Share the design doc on dynamic/no-pre-reserved scratch memory with
  Pasha and the group.
* Continue gathering reviews on IOMMU v5 and testing Phase 2 retrieval.

Sourabh:
* Post the fix for KHO global vs. per-NUMA scratch memory accounting.
* Submit v1 of the PowerPC KHO support series.

The Group:
* Review patches 6, 8, and 9 of David Matlack's PCI v9 series.
* Review the Orphaned VMs RFC series ahead of LPC 2026.

----->o-----

Please note that there will be NO meeting on October 5 due to the Linux
Plumbers Conference (LPC 2026). The next meeting will be on Monday,
October 19 at 8am PDT (UTC-7), everybody is welcome!

Join Here: https://meet.google.com/rjn-dmzu-hgq

Please let me know if you'd like to propose additional topics for
discussion, thank you!

Best regards,
Pasha

