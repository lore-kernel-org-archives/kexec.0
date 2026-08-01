Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7534AC55172
	for <kexec@archiver.kernel.org>; Sat,  1 Aug 2026 12:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GBMKwQxu07dAahElgzkICs5Y0p256zctbXyzmgOcwEM=; b=ybVIjYXcruRP+agJ+hBhJGDqsw
	knwNt5HMFoq4HBjAbSTRNkdFy5PJ3Emw9CVW+88Iu8OAAMUrpCQghQyrhB+jF3yhv6pRsBDK4jgb3
	teIxRyWCnG0mNWfMxLJ+EfgKvMHyaRzXzVE7j+l4ITA72CtsqRBi2wXhm9YI7OHw0iFP/Mknh1GJ6
	LvFok1w2IayMm1ofDngZK33K9GZbkqwwPFMWIWAZC16fPLj4oKlRDZblq1UwuyEpNi2ddkaurk/EG
	5a19/jqX3+A7XiWkUdTnXVH2VN2Ho+45hwyaoqsvgYbZ9r7wMMfbDZAr6QQS1bQ3vEXPlV3KGWeyf
	rkmpQQ9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq8t4-0000000Eeg3-2oCG;
	Sat, 01 Aug 2026 12:32:22 +0000
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq8t2-0000000Eefh-1J9t
	for kexec@lists.infradead.org;
	Sat, 01 Aug 2026 12:32:21 +0000
Received: by mail-yx1-xb132.google.com with SMTP id 956f58d0204a3-6680ae2031fso1584711d50.3
        for <kexec@lists.infradead.org>; Sat, 01 Aug 2026 05:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1785587539; x=1786192339; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GBMKwQxu07dAahElgzkICs5Y0p256zctbXyzmgOcwEM=;
        b=QqnrlWNYFn2lJp1LzTK8l6OCnGMJQjZeZ2Tn6DK54aJrFfMOpbe/j4gvxv7YA4ZrdM
         pswxU/WBUn4xN01Kpak+GKg7aUnJhTcOsUtA4ULfaUiZvDc2EAajeGGx8yzwt6D+l1x/
         NQlMcPCbbSb2xkFvwkHHHogwpNm3Ug7DQdM01dgUsh98OGd/+2Pv/u8OIt3LibuDH5cT
         6jmasWIjFd3c2/X08ARt3sDPyWotdAA63l2JyVpjuG9ojq3+7w2neHV4ciuIfgP0Pg0s
         Lqnuw0p4tCf/fJv9b0/YA11iC7Q/5h2mDmF3cHj1ILCbu1VruKfjkIGnN3JEvHzHiDhm
         MFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785587539; x=1786192339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GBMKwQxu07dAahElgzkICs5Y0p256zctbXyzmgOcwEM=;
        b=ejjeCx8+ZsbT1I9w5roX4mKSfodbkgyOv3F1q1M2PbCeGz6E/SdXSMqAnHG3aaD3eb
         Zv8JRK0p6MdSGymlEUgQpvl+q78/AAmIIye8e8q3LHbuyNPsGJaF0C1oUFbiIpKAiIzo
         rq4PpVxFCAH/2OioLbXUsBbx497BI4yK/m0EGcEhXbnfFoT5h9XarMNS25zwAoyrJuEW
         dpEEqGNMJ2tiHXWFXlfHCZAzvOc3AmHJ/dnHZQANayNmRSFHCY8cxA8UBRtFr4RmUGqP
         R2D7FpCt81Y/WQ14/4Ly/s37TWNGpcrL4HdBExksfPuMkFR+f0wkdU0DCcQOZP8P8x0x
         wkkA==
X-Forwarded-Encrypted: i=1; AHgh+RoANijodLS9IoWpOCRVurqAxtZs2DTrPJt2Kwgwk5aQSY/Fqp22F3i0EoFyGlRxNLDvmRW7Fg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwunqAMsReIzpECe9FfIzbiOBkRjtL44etAQ2QtgjyFn9NfRYCl
	3yQS/NEaZUUYvDYUYUcyCSFS3mbH2fcNDbRECnctKvH74KvITf9XOTmWgpWIWrQEBc4=
X-Gm-Gg: AR+sD10WiV8isjevF/tPfl1Ti50d40Xn2yVIhgA/vcBLu3Y7SfIOlzdxMzKKPs6+uED
	OkFoUjtlQTmwKfyvo8iDab/pEQnISSk3FaP0xkTAOXKD4ZejwLitV49Wb0FlT7mAozmw8rwFkXt
	wuGgURU3MTT3e3tuWudfgf9mMC2X6dVQktKHue+Z52tSblCW/7/Px+gkYEvTFwArOvP4Kg5ouxl
	QN5CcJYA2EJEi0OLP24Pq37DosUOGizVXrzYeUGBuIU/LBxEAB8zAVPq+HCIDKG5WRa0I1das4g
	RTOfCo+mEv859VA0wBuoh897wpls4Lq994+g0VxuwpO5EzWewxMQVhtsHdoGkUb1Z/OIOZxJxic
	GYzVxLMijxyX1rLsOulq01gTNKofYhO5p8F/J+9zSUV7xYoomXfsqeMn2M0yajOgAj5TGawe2Zp
	GtfRwdwdhTLVtNnfxuy6ghULe9qfcddwNSisD/K2riiOcBFle6Hbeczizi2kzYa70TMCGivuFLk
	RQXpSmXwcUYmhEaCB+TrxYV6tRDDHIdK42TrVKIc99Z5LZkhyJ3U05KbGLaT86LeqjIaFmDClfD
	hrbRlSY=
X-Received: by 2002:a05:690c:6604:b0:812:be92:6ea6 with SMTP id 00721157ae682-81fd4b909d3mr37800897b3.28.1785587538894;
        Sat, 01 Aug 2026 05:32:18 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fccf9555dsm24556607b3.20.2026.08.01.05.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 05:32:18 -0700 (PDT)
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
	linux-mm@kvack.org,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [Hypervisor Live Update] Notes from July 27, 2026
Date: Sat,  1 Aug 2026 08:32:07 -0400
Message-ID: <20260801123213.2259109-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260801_053220_389816_7D4426FD 
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

Here are the notes from our Hypervisor Live Update call held on July 27.
These notes are intended to bring those who could not attend up to speed
and to keep the momentum going between meetings.

----->o-----
LPC 2026 Call for Proposals & Registration

* Deadline Extension: The Call for Proposals deadline for all LPC 2026
  microconferences in Prague has been extended to August 7th.

  https://lore.kernel.org/all/ahcc3Qyuy7Oy03Iq@plex

* KVM Track Load Balancing: Due to a strong number of proposals for the
  Live Update Microconference, the team discussed moving select topics
  to the KVM track to balance the schedule. Orphaned VM topics (proposed
  by Pasha and Pratyush) and potentially guest_memfd preservation will
  be submitted to both tracks. Pratyush will coordinate with organizers
  of both tracks to ensure talks are accepted in one track rather than
  duplicated.

----->o-----
PCIe Persistence

* PCI v8 Status: David Matlack is preparing the v8 PCI series, targeting
  submission by Tuesday/Wednesday before leaving for vacation.

* Versioning in Structure: Versioning is being moved out of the compatibility
  string (which will remain a constant string like "pci") and into the first
  field of the pci_ser structure. Because retrieve failures in the PCI core
  are fatal and require a kernel panic to prevent memory corruption in
  dependent subsystems (such as IOMMU), embedding the version in the struct
  allows the kernel to reliably distinguish between missing FLB data and an
  incompatible version.

* Reviews & Landing Strategy: Bjorn Helgaas provided review comments and
  Reviewed-by tags on several patches, including feedback on structuring
  and naming for the bus number preservation patch. David will reply to the
  v7 cover letter to propose merging the initial series through the Live
  Update tree due to dependencies in liveupdate/next.

----->o-----
VFIO Persistence

* VFIO v5/v6 Status: Vipin Sharma sent out VFIO v5 on July 14th and is
  working on v6 to address review comments, targeting submission in 2-3
  weeks.

* Lockdep Investigation: A lockdep warning reported during testing was
  investigated and determined to be unrelated to Live Update (involving CPU
  hotplug locks during boot group operations and ATS). Vipin will start a
  separate mailing list thread with a reproducer to discuss the lockdep
  issue independently so it does not block the VFIO series.

* Landing Strategy: Vipin requested guidance on the base tree for landing
  initial VFIO patches. Pasha will reply on the cover letter thread to
  initiate discussion with Alex Williamson and maintainers.

----->o-----
IOMMU Persistence

* IOMMU v4 Status: Samiullah Khawaja plans to post v4 this week. Changes
  include lifecycle edge-case fixes identified by Sashiko, refactoring to
  separate non-live-update functions, and adopting the constant compatibility
  string with private struct versioning (matching PCI v8).

* Recoverable Error Retry Logic: Samiullah noted that retry logic for
  recoverable errors is not required for Phase 1 and will be deferred until
  needed by subsequent patch series.

* Dependency Ordering Documentation: In response to Pratyush's question
  regarding file preservation ordering, Pasha and Samiullah reaffirmed that
  LUO does not enforce a hardcoded preservation sequence. Any ordering
  restrictions imposed by file handlers (e.g., preserving during preserve
  rather than freeze) are strictly for optimization or immutability reasons.
  Samiullah will explicitly document these guidelines in-tree. Future
  evolution may only relax ordering requirements, never make them stricter.

----->o-----
KHO & LUO

* KHO Scratch Extension v4: Pratyush Yadav posted v4 of the KHO scratch
  extension series on Friday. Feedback from Sashiko was primarily on
  pre-existing issues; Pratyush aims to land the series in the current
  merge window.

* LoongArch KHO Support: Pratyush followed up with the LoongArch developer
  regarding boot protocol preferences and maintainer feedback; awaiting
  further updates.

----->o-----
Guest Memory (guest_memfd) & HugeTLB

* guest_memfd v4 Status: Tarun Sahu is ready with v4 and plans to post it
  this week. The update integrates negative tests, including verifying
  allocation failures when guest_memfd is frozen during preservation and
  ensuring guest_memfd without required flags is not preserved.

* IOMMU Interaction & Freezing: The group discussed how IOMMU DMA pinning
  interacts with shared guest_memfd preservation. Unlike regular shmem/mmfd
  where sealing prevents hole-punching (fallocate), guest_memfd currently
  relies on freezing during preservation. The team agreed on a phased
  approach:
  1. Proceed with the current guest_memfd v4 series as-is (using freezing),
     with a cover letter note clarifying that IOMMU support for guest_memfd
     will be addressed in a later phase.
  2. Pratyush will explore removing the freezing requirement for mmfd and
     guest_memfd in favor of dynamic updates to serialization structures.
  3. Implement IOMMU support for guest_memfd once the freezing/updating
     model is finalized.

* HugeTLB: On hold pending landing of the extended scratch memory series
  and removal of freezing.

----->o-----
Orphaned VMs & Development Environment

* Prototype & Repository: Pasha presented an update and demo on Orphaned VMs
  (allowing VMs to survive host kexec/reboot without stopping vCPUs). He
  published an open-source development environment repository:

  https://github.com/soleen/orphanvm

* NanoVM & Simics: The repository includes a lightweight C-based VMM
  (nanovm) that demonstrates end-to-end live update across kexec. Pasha is
  running it under Simics, which provides full hardware emulation of Intel
  VTX virtualization instructions (unlike QEMU full emulation), booting the
  host VM in ~6 seconds and nested guest VM in ~5 seconds (real time). This
  provides a clean, bare-metal-like environment to study vCPU state and VM
  exits during reboot.

----->o-----
Action Items & Next Steps

Pasha:
* Reply on the VFIO cover letter thread regarding the landing tree strategy
  with maintainers.
* Coordinate with LPC KVM and Live Update microconference organizers regarding
  track placement for Orphaned VM and guest_memfd topics.

David M:
* Post PCI v8 series.
* Reply to the PCI v7 cover letter proposing merging the initial series
  through the Live Update tree.

Vipin:
* Start a separate mailing list thread with a reproducer for the lockdep
  issue independent of the VFIO live update series.
* Continue work on VFIO v6.

Samiullah:
* Post IOMMU v4 series.
* Document in-tree guidelines for file preservation ordering dependencies
  and optimization/immutability requirements.

Pratyush:
* Follow up with LoongArch maintainers regarding KHO boot protocol support.
* Submit LPC talk proposal to the KVM track and coordinate with organizers.
* Continue work on removing freezing requirements for shmem/guest_memfd.

Tarun:
* Post guest_memfd preservation v4 (including cover letter note regarding
  future IOMMU support).

----->o-----

Next meeting will be on Monday, August 10 at 8am PDT (UTC-7), everybody is
welcome!

Join Here: https://meet.google.com/rjn-dmzu-hgq

Please let me know if you'd like to propose additional topics for
discussion, thank you!

Best regards,
Pasha

