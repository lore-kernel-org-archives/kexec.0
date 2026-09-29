Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01183C9832A
	for <kexec@archiver.kernel.org>; Tue, 29 Sep 2026 07:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0QkpnEIdbuhsyhHvyTGjlw2S9g9xsutWV9HU9W/cLGk=; b=PFuGR0WigPHgX2ZB+KMviUWlz8
	Nkt9nbG8EsIk0Ay+TE9sKxHQ0zzbtKkC0QxCiUKgMVe1cvuzo7rS9iCb5bHeKPkISdzym1Dmnj86S
	jqnqueG+UiXZ574gV1mu8gsJyf8xeu9iyGhrYaDqfpr3M3KzogCr6B4VY/3+0yXHLJ2QQrzOg6Irx
	1WGoxnYPjZ0BTqL4o5XhFGwMgPz/49Q/M6/veO9NGh9J6d0YEbho+4CWRaqfwm4N/PXDgkTZE5fj7
	gWM04HNtaGaXxq3R15UZkYVHP0FvoRWAPPqo2fRgun8R+cu4p9FbguAjpI53wTpD9DOeBQ4xMZTpv
	JMox81yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBS85-00000002aDw-1Y7y;
	Tue, 29 Sep 2026 07:19:57 +0000
Received: from mail-pg1-x547.google.com ([2607:f8b0:4864:20::547])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBS83-00000002aCn-0JHL
	for kexec@lists.infradead.org;
	Tue, 29 Sep 2026 07:19:56 +0000
Received: by mail-pg1-x547.google.com with SMTP id 41be03b00d2f7-cc4c1fc9ceaso2260261a12.3
        for <kexec@lists.infradead.org>; Tue, 29 Sep 2026 00:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790666393; x=1791271193; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0QkpnEIdbuhsyhHvyTGjlw2S9g9xsutWV9HU9W/cLGk=;
        b=VkHygggvOYCvF85NfnIGuHPd8isfNZA8rGeM6g8beweiJ9uQCHyaAsWrjOpDfhEDnU
         s8glSYwHaJVA96iR+lTf5abjeP/ITQdPoecZFfk2ptN01SBpk6oYP340+HqKSR90mA6B
         SbpWQ5NZHmw2TDQE7cyoNVbPnimbucgvNTkyCVoFSrBvFIgpm09r1ngkphxjrATGBwFB
         uhKfweH9ae+up1Pvx8CbY6VnB+W9Jsd4REWtueHpbmzdVFsc3Ie2NUCNpZCWpCXpx7ob
         VYKjFdeqTL6NPBkT4GHucRjO8jfoYEQL1aQUdZ9lU4L3c80dsiLzyDJOtKjFa1cftAgD
         goQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790666393; x=1791271193;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0QkpnEIdbuhsyhHvyTGjlw2S9g9xsutWV9HU9W/cLGk=;
        b=uhX+FaiZA7RDKJAcygmYvS53tg0DfqrP5HxmWqrCi5DTLDLnCm/xkgg531Y6iQbevU
         0unfRKPyXZa28OOlcXXFFfLS0CyEjKaGgWp0jmBY3a4OG+SRMeDuNeEFLJ7yEQ24T6VR
         eLgAVCBZv+LM37Pzrp7QoHYLQrR8y1unapVz4VXY+81EozjbwPX+Y5Dbta25LQwwZvzo
         W9C5NuhpSBGWEC7/aXWWLeZMFgm9nN3EW/nLj+dNlG8c0ZRUVt9sutYIkppHsB1y8CnP
         W4a2WAcBlIdGVShijlOeYplvad0gmwBlTsff2TdL9ZuAmPL1MYiRDGhveUgaopWKEFcP
         Jnew==
X-Forwarded-Encrypted: i=1; AKwUvByn89Hd5upz0WVOb87Cfd9HZCQWcZZbQTPMVsTYdDw0V0M6pffigC3v9/xHrewEED0xmS041w==@lists.infradead.org
X-Gm-Message-State: AFuF++nEobyRG7Ny1GXhg+R+KVkF0DRli4fF81j68SWCOOuHJo8dTK6L
	bg95UeQ4Pt0t3favI8H10pami1fzJfHQwy8E4nj/xo+Tboopy9eHcfZmKrsKxATn1EU+RxVSejC
	XCw==
X-Received: from pgbgf2.prod.google.com ([2002:a05:6a02:2cc2:b0:cc1:cba6:484c])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7352:b0:3da:5eda:d167
 with SMTP id adf61e73a8af0-3de0e7136efmr15088339637.5.1790666393084; Tue, 29
 Sep 2026 00:19:53 -0700 (PDT)
Date: Tue, 29 Sep 2026 07:19:41 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929071950.2710070-1-praan@google.com>
Subject: [RFC PATCH v1 0/9] iommu/arm-smmu-v3: Implement Live Update support
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Nicolin Chen <nicolinc@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260929_001955_120302_43913578 
X-CRM114-Status: GOOD (  32.30  )
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

The IOMMU Live Update framework [1] preserves the IOMMU hardware state and
the translation (HWPTs) of devices assigned to userspace via iommufd/VFIO
across a kexec based Live Update, using KHO and the DMA allocation
preservation API [2]. This series implements the arm-smmu-v3 side of it,
allowing an SMMUv3 to keep translating the DMA of preserved devices,
without any disruption, while the kernel underneath is replaced.

We have an alignment session planned on IOMMU Live Update at LPC 2026 [3].

Design
======
The arm-smmu-v3 operates almost entirely out of in-memory data structures
(Stream Table, CD tables, page tables) that the HW registers point to.
Hence, a Live Update boils down to preserving these structures, keeping
the SMMU enabled across the kexec and having the incoming kernel take
them over without ever reprogramming anything that the HW is walking.

1. Preservation (outgoing kernel)
  a. .preserve (per SMMU): Serializes the SMMU identity (the MMIO base is
     used as the token, similar to VT-d), STRTAB_BASE_CFG and the Stream
     Table. A linear Stream Table is preserved as a whole, for a 2-level
     table the L1 table is preserved, along with an array of L2 tokens
     indexed by the L1 index.
  b. .preserve_device (per master): Preserves the L2 Stream Tables holding
     the STEs of the master, since .preserve only runs for the first
     preserved device. For an S1 domain, the CD table of the master
     (linear, or L1 + active L2 tables) is preserved too. SVA domains and
     masters with active PASIDs are rejected, matching the granularity of
     the core. The ASID/VMID tagging the translation is recorded in the
     attachment_id of the device state.
  c. For S2 and nested domains only the STE is needed. The page tables
     come from the preserved domain, and a guest-owned (nested) CD table
     lives in guest RAM, which is preserved with the guest memory anyway.
  d. The Event queue memory is preserved as well, as it stays enabled
     across the kexec. Only its preservation token is serialized; its
     base, size, PROD and CONS are left in the EVTQ registers.
  e. .unpreserve_device and .unpreserve undo the above. An L2 Stream
     Table is unpreserved once no preserved master uses it.

2. Shutdown (outgoing kernel)
Instead of clearing SMMUEN, .shutdown:
  a. Masks the SMMU interrupts and waits for a running EVTQ handler.
  b. Installs abort STEs for all the unpreserved masters and clears the L1
     descriptors of L2 tables that have no preserved stream.
  c. Issues CFGI_ALL + TLBI_{EL2,NSNH}_ALL.
  d. Disables the CMDQ and the PRIQ, leaving SMMUEN and EVTQEN set for the
     preserved devices.
If any of this fails, it falls back to the regular full disable.

3. Restoration (incoming kernel)
  a. arm_smmu_init_strtab() takes over the preserved Stream Table instead
     of allocating a new one. The layout read back from STRTAB_BASE{,_CFG}
     is validated with the common kexec helpers from the kdump series [4]
     and the in-use ASIDs/VMIDs are reserved, such that new domains can
     never alias the preserved ones.
  b. arm_smmu_alloc_cd_tables() takes over the CD table of a restored
     master, validated with arm_smmu_kexec_check_ste_cdtab().
  c. arm_smmu_init_queues() adopts the preserved EVTQ, resuming from the
     live EVTQ_BASE/PROD/CONS, so any event recorded across the Live
     Update is left pending for the EVTQ handler of the incoming kernel.
  d. The stream tables and the EVTQ are restored with the managed (dmam_*)
     variants of [2] as they're devres allocations tied to the SMMU, while
     CD tables use the unmanaged (dma_*) variants, as their lifetime
     follows the master.

4. Hitless reset
When there's incoming preserved state for the SMMU (a failed restoration
fails the probe, so this implies a restored Stream Table),
arm_smmu_device_reset() shares the kdump adoption path, which already
solves the problem of a live Stream Table:
  a. SMMUEN and ATSCHK are retained, CR1/CR2/STRTAB_BASE are left alone,
     as updating them with SMMUEN=1 is CONSTRAINED UNPREDICTABLE.
  b. The CMDQ and the PRIQ (already disabled by the outgoing kernel) are
     reset as usual, while EVTQEN and the EVTQ registers are left alone
     for the adopted EVTQ.
  c. Any GERROR latched across the kexec is acked before the CMDQ is
     re-enabled.
  d. The interrupts are re-wired to the incoming kernel. The IRQs are
     masked, hence IRQ_CFGn can be reprogrammed with SMMUEN=1. The EVTQ
     thread is then woken up to handle the events already pending.
  e. CFGI_ALL and TLBI_NSNH_ALL/TLBI_EL2_ALL flush everything cached for
     the previous kernel. The preserved devices merely re-walk the
     preserved tables.

5. Hitless re-attach
The IOMMU core restores a preserved domain by allocating a new paging
domain around the preserved page table and attaching it to the restored
device [1]. A new domain comes with a new ASID/VMID though, while the
device is still doing DMA through the preserved CD/STE.

Similar to the Intel driver reclaiming the preserved Domain ID, the
restored domain inherits the ASID/VMID of the live CD/STE on its first
attach (the ID was reserved in 3.a, so it's just handed over). The stage,
the page table root and the ID recorded in 1.b are cross-checked against
the live CD/STE, failing the attach if the restored domain isn't what the
HW is walking. With this, the CD/STE computed for the restored domain are
identical to the live ones and the re-attach is a no-op for the HW.

Relation to the kdump adoption series
=====================================
Nicolin's kdump series [4] factored the parsing and validation of the
previous kernel's SMMU tables into arm-smmu-v3-kexec.c with Live Update
in mind. This series builds on it: ARM_SMMU_V3_KEXEC is also enabled by
IOMMU_LIVEUPDATE, the restore paths use those helpers, the kdump reset
path is shared via arm_smmu_strtab_is_live(), and a small
arm_smmu_kexec_check_cdtab_l1_desc() helper is factored out of the ASID
scan to be shared with the CD table restoration.

Open issues and discussion points
=================================
1. Stage of the restored domain: The core restores a domain with
   iommu_paging_domain_alloc(), i.e. flags == 0, which gives an S1 domain
   on SMMUs supporting S1. This covers VFIO/iommufd paging HWPTs, but a
   preserved S2 (NEST_PARENT) domain can't be restored as such. The core
   has to preserve the allocation flags. For now, such a mismatch fails
   the attach instead of switching the device to a different translation.

2. Hitless domain replace: A restored domain is immutable (no map/unmap),
   so the VMM has to replace it with a new HWPT after the Live Update.
   With S1, the ASID and TTB0 live in different CD qwords, making the
   replace non-hitless today; [11] addresses it with a temporary ASID.
   S2 has the same problem with the VMID and S2TTB and needs a temporary
   VMID.

3. Queue drain: The shutdown doesn't drain the CMDQ before disabling it,
   as the final invalidations are synced, there are no other submitters
   left at shutdown and the incoming kernel invalidates everything again.
   However, the CMDQV VCMDQs assigned to guests may need to be quiesced,
   which is future work along with the ATS and PASID support.

4. RMR SIDs: The outgoing kernel parks the unpreserved RMR streams in
   abort, and the incoming kernel skips installing the RMR bypass STEs, as
   it does for kdump, since they're written assuming a Stream Table that
   isn't live yet.

5. A failed restoration fails the SMMU probe instead of falling back to a
   full reset (which would at least keep the system usable). Also, a
   partially restored CD table isn't unwound on failure yet.

6. PASID granularity, PRI and ATS state of the preserved PCI devices are
   not handled yet (e.g. arm_smmu_enable_pasid() at probe for a device
   that still has ATS enabled).

7. The kdump [4] and invalidation [5] series both define ARM_SMMU_OPT
   bit 5; this tree moves ARM_SMMU_OPT_KDUMP_ADOPT to bit 6.

Dependencies
============
This series depends on the following series, applied in this order on
top of v7.3-rc5:
 1. iommu/arm-smmu-v3: Invalidation rework (v7), by Jason [5]
 2. iommupt: Generic IOMMU page table for SMMUv3 (v2), by Jason [6]
 3. iommu/arm-smmu-v3: kdump Stream Table adoption (v10), by Nicolin [4]
 4. dma: DMA allocation preservation (RFC v2), by Samiullah [2]
 5. vfio/pci: Live Update preservation of VFIO cdev (v5), by Vipin [8]
 6. iommu: IOMMU Live Update state preservation (v5), by Samiullah [1]

The luo_file internal APIs [10] and the PCI Live Update series [7] are
already merged in linux-next.

The VFIO series is taken as carried in [9], along with a small build
fixup for the stack.

A tree with everything applied is available at:
https://github.com/pran005/linux/tree/arm-smmu-v3-liveupdate-rfc

[1] https://lore.kernel.org/all/20260921004834.2601285-1-skhawaja@google.com/
[2] https://lore.kernel.org/all/20260708234854.4044652-1-skhawaja@google.com/
[3] https://lpc.events/event/20/contributions/2612/
[4] https://lore.kernel.org/all/cover.1788130528.git.nicolinc@nvidia.com/
[5] https://lore.kernel.org/all/0-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com/
[6] https://lore.kernel.org/all/0-v2-563ee63886f0+1209-iommupt_armv8_jgg@nvidia.com/
[7] https://lore.kernel.org/all/20260918200640.887030-1-dmatlack@google.com/
[8] https://lore.kernel.org/kvm/20260714151505.3466855-1-vipinsh@google.com/
[9] https://github.com/samikhawaja/linux/tree/iommu/phase1-v5
[10] https://patch.msgid.link/20260723202912.1467112-2-skhawaja@google.com
[11] https://lore.kernel.org/all/20260925011308.3381953-1-skhawaja@google.com/

Pranjal Shrivastava (9):
  iommu/kho: Extend IOMMU KHO ABI for ARM SMMUv3
  iommu/arm-smmu-v3: Implement KHO preservation for STEs
  iommu/arm-smmu-v3: Implement CD Table preservation
  iommu/arm-smmu-v3: Implement Live Update Stream Table restoration
  iommu/arm-smmu-v3: Implement Live Update CD Table restoration
  iommu/arm-smmu-v3: Implement Live Update shutdown
  iommu/arm-smmu-v3: Retain SMMUEN across a Live Update restore
  iommu/arm-smmu-v3: Inherit the ASID/VMID of restored domains
  iommu/arm-smmu-v3: Adopt the Event queue across a Live Update

 drivers/iommu/arm/Kconfig                     |   2 +-
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c |  44 +-
 .../arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c  | 997 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 119 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  56 +
 include/linux/kho/abi/iommu.h                 |  38 +
 7 files changed, 1220 insertions(+), 37 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


