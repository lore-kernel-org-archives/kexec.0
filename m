Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9627C4451B
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 16:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RbJ0Dq7r5q2pbKEUMnBVIvh0QCgrg4Tige0pOW6lYSw=; b=1Ko9qpPNcu5TBmwb+msc1UqhPs
	4nxE2sFMqJ8q4vE7RR29JZKXE2utneg8mOmGG7lGiOl3h3Q0g1f84DoQxZMqMol4YI1iZjhBqVKDv
	tDxvlozz//CUj2/WPY6E20gplwMQj1ryRdqxXVq9nIvfaCVYtKZ5RK4PC9+TD5OGtxTY7Kq9mbw9j
	Dc7qNorSPtsvh/aRmA0VFqD2x3eCllKmaLOR78RhTxkiA6aVs8wmzw8Rkvek2akX97MhQ63TIedHj
	HdcEm7g1ZATyxOeI31OkZEkH4q3UeHeHjwhaJVpye28/FCgbAQ4e31gIZN96JzQBC4Ay6b9kme1bH
	LHV1W6gQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wklDd-00000002iQD-3Dwl;
	Fri, 17 Jul 2026 16:15:21 +0000
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wklDb-00000002iPJ-0sJY
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 16:15:20 +0000
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-81e9f7491ffso101286497b3.0
        for <kexec@lists.infradead.org>; Fri, 17 Jul 2026 09:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784304917; x=1784909717; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RbJ0Dq7r5q2pbKEUMnBVIvh0QCgrg4Tige0pOW6lYSw=;
        b=ek4TxNlHn0SjRlUkRxN4OG/MVh9uqvlyv2+ndUxhoLTcSCtbjaOnRIEPdPJVucvzBr
         srRw/4XCWkrAkwJFzfSEOMVOrsRcwB62hTggHcugJn+DD6viyda9HxQEFHW0QEnTpsIq
         2om/53nd/mR3a2QDsxqdg4yJ3DaXM+syo5T8OFAWc3hHdWGk8xdcYR0nzUefC1HfCFkk
         JgZpjyJ384nCeIJdCYCL4xn6QeMLDTXCve6UAF8QaAfxsTUHGzB/VMyu5kXjGezVnb9u
         M4LL5kJwBjYj1PIW2R3JJ9Z2Bw7gE3xNrWQb9JhUHI5LT62D0xgIvgFgFhc7D1PlnC3c
         7olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784304917; x=1784909717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RbJ0Dq7r5q2pbKEUMnBVIvh0QCgrg4Tige0pOW6lYSw=;
        b=Y9D/9Ku0laoPPL/9oWEtJh4yYIxq911Q1bqGEPSHfvG0BBAFTu5tVTiEc2Um596wPR
         yvjbzZ9r4bduDXiDC2Z9npqjdiXDq9/euqv+u7VyXfuAr7k3p+ZIpDy5WnccQ5TxvxgY
         u/rAPqYe1H19sJFpRUMCRvOkvX+FlNL6CTr6/AmHnojGxNtvBZ9xpl/dZcfC67GPBvaH
         AR/W8iD7QRCy0HpMTrdgHzymG1ZJiZnFTAjfXg6mbfpp2V7wOFEQjbDnoCtWDCTT4TYo
         8i8hztiYSizCk1fPOfjG9yL0oKCeCZ3LRKOb5hDFxnnSf04zDxMBqMAOqp9w+oLKpDfF
         pe8g==
X-Forwarded-Encrypted: i=1; AHgh+RpVp6IzlI/urCdPibaiHVyy3rw5d4YbAMMuEMzjeuvwVLArGWuuvd9ujYe8NMNjPazThL2qEA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz4HWrp29SAB4FipifCEJN9FKDADUWmDTMLI7NoS0LGVkvFYY9y
	VOh3DnktoMFP6VLUwoh6DgBSTPCAnqf/vUi6yw4wE0U8QMiiKOeSIauspICbnZvWhqQ=
X-Gm-Gg: AfdE7ckI2abn3RLLr6iEi+U7MadIjLW16CeHCY0LNgIShEuBYYwqPd71sdswTs3Vp95
	cMUbX6vHR083Rbb77jsD2RnQwZAnUHL6ihYF632kaA2E/4s5xdfqD3ZMTiquk/cibldJy2XrWgD
	mogoycFAodoJj53epa29VvOMHFm9KUNcvCZfU1cEnuPrI8F1UnzBbKamhvetIwRYtSWo7cUtfZh
	+5oQvvNUGVSuib+hF8Z98D5nNnMI6oeJplKzd5/xaeXsNMczQ7V67SCtP9RgAyQow0H2XCZ0J+l
	Q+7589DNIq6K/31qTFhbeQ6200T8w42nloJj+yHsQGsp9XmcHZjTl07YnlJt+6WMYZusFFvb0es
	ZHq/qLG+QNMEQyatT3b4MoK7RjkBfJrT/tW+y6zcLtqCGDUCbAgSj575XVn/ovDe4SC0lzIkTn8
	22gWjYHz6CdxcRm0GtjXEIMSd8EOsmawWU1CN3e9rGVuV0kQfuoPrzotvRk3T9NFzatBO6rCOvG
	glgfjkZu4vJIo37/9+/jeWvPbxUHP5G
X-Received: by 2002:a05:690c:692:b0:81e:8b74:b35c with SMTP id 00721157ae682-81ef28050cbmr11065817b3.36.1784304916395;
        Fri, 17 Jul 2026 09:15:16 -0700 (PDT)
Received: from soleen.c.googlers.com.com (138.200.150.34.bc.googleusercontent.com. [34.150.200.138])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef40179absm13642147b3.6.2026.07.17.09.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:15:15 -0700 (PDT)
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
Subject: [Hypervisor Live Update] Notes from July 13, 2026
Date: Fri, 17 Jul 2026 12:15:11 -0400
Message-ID: <20260717161512.3141871-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_091519_274696_07822C6B 
X-CRM114-Status: GOOD (  15.14  )
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

Here are the notes from our Hypervisor Live Update call held on July 13.
These notes are intended to bring those who could not attend up to speed
and to keep the momentum going between meetings.

----->o-----
LPC 2026 Call for Proposals & Registration

The Call for Proposals for the Live Update Microconference at LPC 2026
in Prague remains open. Please submit your topics and abstracts before
the July 24th deadline. Pre-registration is currently open for content
submitters. General registration will open on July 24th; early
registration is highly encouraged as capacity is limited.

https://lore.kernel.org/all/ahcc3Qyuy7Oy03Iq@plex

----->o-----
VFIO Persistence

* VFIO v5 Status: Vipin Sharma's v5 series is ready, rebased on top of
  David Matlack's PCI v7. It is expected to be posted to the mailing
  list shortly.

* Finish Call Cleanup: The group discussed Vipin's proposal to clean up
  KHO state and reset the device if a finish call fails. The consensus
  is to keep it simple for the initial version: if retrieve/finish
  fails, return false and leak the resources. This is safer than
  attempting a partial or unsafe cleanup.

----->o-----
PCIe Persistence

* PCI v7: David Matlack sent out the v7 PCI series. Key changes include
  moving to a KHO block allocation model (instead of guessing max
  devices), which allows dynamic allocation. Additionally, retrieve
  failures are now treated as fatal (triggering kernel panic) to avoid
  memory corruption in dependent subsystems.
* Landing Strategy: The initial series will likely go through the PCI
  tree (pending discussion with Bjorn) to establish maintainership.
* Next Steps: David's PCI series will be applied to the next branch once
  the FLB fixes land, allowing him to rebase (v8).

----->o-----
IOMMU Persistence

* IOMMU v4 Status: Samiullah Khawaja is working on v4, incorporating
  feedback and KUnit tests. Landing is blocked on the PCIe and VFIO
  series.
* Retry Logic: Samiullah proposed allowing retries for file handlers
  (e.g., under memory pressure). The group agreed retries should be
  allowed on a case-by-case basis for specific recoverable errors,
  rather than as a generic mechanism. Samiullah will propose a patch
  series for this.

----->o-----
KHO, LUO & Selftests

* LoongArch KHO Support: v3 was posted by George Guo using device tree.
  The implementation needs refinement. The team is waiting for LoongArch
  maintainers to clarify their preferred boot protocol (command line vs.
  device tree) and confirm real use cases.
* KHO Scratch Extension & Rename: Pratyush Yadav sent v3 for scratch
  extension. He is working on v4 to address feedback and simplify
  conflict resolution with the MM tree. The rename of scratch/boot
  memory will follow the extension landing.
* LUO Fixes: David Matlack's FLB fixes (PATCH 0/2) have been applied to
  liveupdate/next.
* Selftests: Mike Rapoport's end-to-end test VM infrastructure (v4) has
  been applied.
* KHO Component Splitting: Pasha still plans to split KHO into
  components, pending discussion with Mike.
* Directory Location: The group agreed KHO Red X3 will remain in the KHO
  directory to maintain binary format stabilization guarantees.

----->o-----
Guest Memory (guest_memfd)

* guest_memfd Preservation: Tarun Sahu posted v3 and is working on v4.
* In-Host Migration: The team discussed implications of supporting
  multiple files per inode (needed for in-host migration, where a new VM
  starts before the old one dies). Currently guest_memfd operations are
  per-inode, posing corruption risks if accessed simultaneously. For
  now, this scenario might be marked as incompatible with live update if
  resolution is too complex.
* Submission Standard: Pasha reminded contributors to include cover
  letters with their patch series.

----->o-----
HugeTLB

* Status: On hold. Pratyush needs to land the extended scratch and KHO
  Xarray before resuming work on HugeTLB.

----->o-----
Action Items & Next Steps

Pasha:
* Review PCI v7 series.
* Consult with Mike on KHO component splitting.

David M:
* Rebase PCI series on top of liveupdate/next (v8).
* Consult with Bjorn on PCI landing tree strategy.

Pratyush:
* Follow up with LoongArch maintainers regarding boot protocol and use
  cases.
* Work on KHO scratch extension v4 and subsequent rename.

Vipin:
* Submit VFIO v5.

Samiullah:
* Work on IOMMU v4.

Tarun:
* Post Guestmemfd v4 (include cover letters).

Jork:
* Discuss resource accounting and session handover (systemd integration)
  with Luke.

----->o-----

Next meeting will be on Monday, July 27 at 8am PDT (UTC-7), everybody is
welcome!

Join Here: https://meet.google.com/rjn-dmzu-hgq

Please let me know if you'd like to propose additional topics for
discussion, thank you!

Best regards,
Pasha

