Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E31CD6E45
	for <kexec@archiver.kernel.org>; Thu, 28 May 2026 00:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MlAphM6lIy04CUio1znmzudM4J3s/1bUFzd6ZYAVWN0=; b=DINY2kYdZYZzQ1Xxsx0VNf4ugJ
	LlJT2usNhdYl22NYpE5Ynz4OGyAHD+2GhVAdEbOnn/wW/l7WNr+OiihZSxMnpB2F6jcXBe+xF1/RN
	h1dTSN2CfNDg/X6V24EuhBeXfK7Nkt4Lx7UxLFiAfEPfiLOc3hYe2GgeOTHXRs22J9V+pEqFyzBo9
	XzLN/G2u+wk86tooqLCLd0iuxgjcm2lpknZraXgd/3rlAZrwLcv9wKzBqvIyQ6vzs8JiNvvS5qLsX
	kNCDR+I3PCqtqASCYxDyJWrry0/y/HClZkp66v1IA+eOlHv3WxukSN15opStFPtoxddYG41cUiDGc
	jH1MHiBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSOpK-00000004s1u-2kv7;
	Thu, 28 May 2026 00:42:22 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSOpI-00000004s0X-1apX;
	Thu, 28 May 2026 00:42:21 +0000
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 3F42520B7167; Wed, 27 May 2026 17:42:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3F42520B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779928928;
	bh=MlAphM6lIy04CUio1znmzudM4J3s/1bUFzd6ZYAVWN0=;
	h=From:To:Cc:Subject:Date:From;
	b=N2vAOfpASzX1EDjGy6YAAwkPynJ5GW9q35MDxfssI1LB5uZxHV5aX1fQgJFCn0lWS
	 FWP9njR85BuseWjwEiHUzAbNOhvtyBpu0fBVx/Pp2EtF+fHeg23fnp6RWXL6icFZ37
	 geNEFabO21Jp613vSD92tPBkmeBr1lm1Vy/xYD/U=
From: Jork Loeser <jloeser@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Jason Miu <jasonmiu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Baoquan He <bhe@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <kees@kernel.org>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Justinien Bouron <jbouron@amazon.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Pingfan Liu <piliu@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [RFC PATCH 00/20] mshv: enable kexec with Hyper-V donated pages and partitions
Date: Wed, 27 May 2026 17:41:42 -0700
Message-ID: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_174220_451036_7B7A3B11 
X-CRM114-Status: GOOD (  17.10  )
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

When Linux runs as an L1 Virtual Host (L1VH) under Hyper-V, the MSHV
root partition driver deposits pages to the hypervisor and creates
partitions for guest VMs. Prior patches enabled kexec for L1VH, but
only when no partitions had been created and no memory had been donated.

This series lifts that limitation. It uses KHO (Kexec Handover) to:

 - Track all pages deposited to the hypervisor in a KHO radix tree
   and preserve them across kexec so the new kernel knows which pages
   are owned by the hypervisor.

 - Freeze running partitions before kexec, record their IDs in the
   KHO FDT, and vacuum (tear down + reclaim memory) stale partitions
   after kexec.

 - In case of a crash, exclude hypervisor-owned pages from crash
   dump collection by passing the radix tree root PA via Hyper-V
   crash MSR P2 to the crash kernel.

Dependency on Pratyush's KHO series
===================================

Patches 1-12 are cherry-picked from Pratyush Yadav's v1 series
"kho: make boot time huge page allocation work nicely with KHO" [1],
which is still under discussion. This series uses functionality from
those patches -- specifically the meta-data page enumeration via table
callbacks and the restructured radix tree API. It also extends the
KHO radix tree with:

 - A freeze mechanism to lock the tree before serializing for kexec
   (patch 13).

 - A crash-kernel-safe variant that memremaps radix nodes for use
   outside the direct map (patch 14).

Patch overview
==============

Patches 1-12:  KHO radix tree and memblock changes (from [1])
Patch 13:      Radix tree freeze and del_key() error reporting
Patch 14:      Crash-kernel-safe radix tree presence check
Patch 15:      Page tracker using KHO radix tree for deposited pages
Patch 16:      Debugfs interface for page tracker
Patches 17-18: Crash MSR reshuffling + crash dump page exclusion
Patch 19:      Export kexec_in_progress for modules
Patch 20:      Freeze and vacuum partitions across kexec

Feedback
========

This is an RFC. I am looking for feedback on the overall approach as
well as the KHO changes (patches 13-14).

[1] https://lore.kernel.org/linux-mm/20260429133928.850721-1-pratyush@kernel.org/

Based-on: linux-next/master (next-20260527)

Jork Loeser (8):
  kho: add radix tree freeze and del_key() error reporting
  kho: Add crash-kernel-safe radix tree presence check
  mshv: Use page tracker to manage MSHV-owned pages and preserve with
    KHO
  mshv: Add debugfs interface to page tracker
  hyperv: Reserve crash MSR P2 for page preservation root PA
  mshv: Exclude Hyper-V donated pages from crash dump collection
  kexec: export kexec_in_progress for modules
  mshv: freeze and vacuum partitions across kexec

Pratyush Yadav (Google) (12):
  kho: generalize radix tree APIs
  kho: store incoming radix tree in kho_in
  kho: add a struct for radix callbacks
  kho: add callback for table pages
  kho: add data argument to radix walk callback
  kho: allow early-boot usage of the KHO radix tree
  kho: allow destroying KHO radix tree
  kho: add kho_radix_init_tree()
  memblock: introduce MEMBLOCK_KHO_SCRATCH_EXT
  kho: extended scratch
  kho: return virtual address of mem_map
  mm/hugetlb: make bootmem allocation work with KHO

 arch/arm64/hyperv/hv_core.c        |   6 +-
 arch/x86/hyperv/hv_init.c          |   4 +-
 drivers/hv/Kconfig                 |   3 +
 drivers/hv/Makefile                |   2 +-
 drivers/hv/hv_common.c             |   5 +-
 drivers/hv/hv_proc.c               |  32 +-
 drivers/hv/mshv_debugfs.c          |  99 +++++
 drivers/hv/mshv_page_preserve.c    | 557 ++++++++++++++++++++++++++
 drivers/hv/mshv_page_preserve.h    |  21 +
 drivers/hv/mshv_root.h             |   5 +
 drivers/hv/mshv_root_hv_call.c     |  12 +-
 drivers/hv/mshv_root_main.c        | 341 ++++++++++++++--
 include/linux/kexec_handover.h     |   1 +
 include/linux/kho_radix_tree.h     |  90 ++++-
 include/linux/memblock.h           |  14 +
 kernel/kexec_core.c                |   1 +
 kernel/liveupdate/kexec_handover.c | 605 +++++++++++++++++++++++------
 mm/hugetlb.c                       |  19 +-
 mm/memblock.c                      | 177 +++++++--
 mm/mm_init.c                       |   1 +
 20 files changed, 1767 insertions(+), 228 deletions(-)
 create mode 100644 drivers/hv/mshv_page_preserve.c
 create mode 100644 drivers/hv/mshv_page_preserve.h

--
2.43.0


