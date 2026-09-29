Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38469CA5FA1
	for <kexec@archiver.kernel.org>; Tue, 29 Sep 2026 07:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OlVYV/o4fm3RCndKRXTcczL0qjVzCkXzkjMu/hurkAc=; b=qiV+V/zynuVk2O6cvhCUqfRL4E
	ZGIQB630AnGzlFBInOSUJE0cgLUFauxGKk5SoP1ZY7Bmu69mRS5c9v1QJJkCav4oSG9bpr+rQdwgk
	naMgS7Yu2yniMXIs80vpRM2C6DPOkeHPKIP7/Wt1nyk28HK1SZxqDdeHtmtW0ZuHFAO3u3JHedVyp
	UG5J5xr6m4AxOuiJEr5s0J80gAewECuMGRWT09OR0gGvvYlT3tmPicakjSxEN0zK1vcIXeQUcSjRd
	FVMCjzcZLz4dycvvgFAJ2phmsQRpcKZpU7G8q1STeQlTAyhvMSsjw3DmjImr95qKMLbbnfV9rY7Sh
	Upl4DUYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBS92-00000002azM-2g9k;
	Tue, 29 Sep 2026 07:20:56 +0000
Received: from mail-pl1-x645.google.com ([2607:f8b0:4864:20::645])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBS8O-00000002aW5-3QZ3
	for kexec@lists.infradead.org;
	Tue, 29 Sep 2026 07:20:18 +0000
Received: by mail-pl1-x645.google.com with SMTP id d9443c01a7336-2d55d8cd938so62449905ad.1
        for <kexec@lists.infradead.org>; Tue, 29 Sep 2026 00:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790666415; x=1791271215; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OlVYV/o4fm3RCndKRXTcczL0qjVzCkXzkjMu/hurkAc=;
        b=MLiIZ16TEYIBuf5yWT5sZ8a7A/XqCA8r4mcr9IPvwJEdYDhHxhlcT0zNFNk0StrXV9
         3wBbUCD82+5iqDF0VhXBWCMixjamMyOINp3kazcQ9yMjOmahewUd/NR+07xVNAkJeP9y
         cdBMwfbT/ZILQbn2Gls2eRa8WnI4o0YvkpzUjUL+NmhF0dD1Ju+hatd3GxQw7n0mxKJc
         JQBSzpMVGDzVy9m3d8lir8dSLWBeFUBpDnVe3D6+lcwRTVwVan/8X+DIOkxjfyNOdlIT
         He5aASKASvlRHJuhRZaM6f9dRqDv41k6huNebJNGoMdwAwdzo3eoMPKj/ypCA+085mPV
         Al/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790666415; x=1791271215;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OlVYV/o4fm3RCndKRXTcczL0qjVzCkXzkjMu/hurkAc=;
        b=otfcWrT/SgEydLb3FeuWojQXR+IJ9QyTrvcSKr75buoKAv75rm2SP8Kl2qzhKoFf/i
         uwuf0TH8baNFIrwDRT8v7uZJN0uxar6/uvRo7vofzZCy6jTikGyWifCp/qz9HY8VEwGB
         4onsQzyfj6qXP82ZzbOpLtl0+gFy9yLbphXrv9j470W1i+F0xnqvuYzpwCTsY70s3lgQ
         8qyFigovJebffWQ8DkvKsbnPVpWTriV05dVgRH8LTQDh39GVPZMcUmA2dHQYyUtRDZSy
         YhxFDWXthfeSRTh01NPW8XiXncY+r6XpfvdZXCzZZ10E/WRKKT0f+fFfCsqKZf7qbBTE
         gzGA==
X-Forwarded-Encrypted: i=1; AKwUvBzlzN0KjKY5cWZ9VwouqN/ETlHGrGaUgChCPMp3HAI/fFvDsxG1nLq8K8GpunDSn+EbH/S8/g==@lists.infradead.org
X-Gm-Message-State: AFq9FYKKKYk/q/bRsobRr6eKkLqnLDMU3z0aqxIuev6OLTjkizWhvwzZ
	pvfcF8cUX9OPzWVnfN7JfpgYGtDGVnnXAjKy15R4gTk4wgzLR3fJNEUT2paLiQgUARqyxeijzCG
	Xxw==
X-Received: from plmk4.prod.google.com ([2002:a17:903:1804:b0:2df:af7a:7386])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c1:b0:2dd:c100:9438
 with SMTP id d9443c01a7336-2df94c22bdfmr92863685ad.54.1790666415041; Tue, 29
 Sep 2026 00:20:15 -0700 (PDT)
Date: Tue, 29 Sep 2026 07:19:50 +0000
In-Reply-To: <20260929071950.2710070-1-praan@google.com>
Mime-Version: 1.0
References: <20260929071950.2710070-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929071950.2710070-10-praan@google.com>
Subject: [RFC PATCH v1 9/9] iommu/arm-smmu-v3: Adopt the Event queue across a
 Live Update
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
X-CRM114-CacheID: sfid-20260929_002016_891543_F2822472 
X-CRM114-Status: GOOD (  21.48  )
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

The SMMU may record events of the preserved devices across the kexec,
which the incoming kernel loses by resetting the EVTQ.

Preserve the EVTQ memory and leave the EVTQ enabled on shutdown. Only
store its preservation token in the ABI, as the incoming kernel reads the
base, size, PROD and CONS back from the EVTQ registers. Retain EVTQEN
across the reset and wake up the EVTQ thread to handle pending events.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c  | 108 +++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  39 +++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  10 ++
 include/linux/kho/abi/iommu.h                 |   2 +
 4 files changed, 143 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c
index c0772bcb8d3a..b7cacf48cf8b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c
@@ -403,11 +403,48 @@ static void arm_smmu_unpreserve_strtab_linear(struct arm_smmu_device *smmu,
 					    iommu_ser->smmuv3.l1_strtab_lu_state);
 }
 
+static size_t arm_smmu_evtq_size(struct arm_smmu_device *smmu)
+{
+	return ((1 << smmu->evtq.q.llq.max_n_shift) * EVTQ_ENT_DWORDS) << 3;
+}
+
+/* The EVTQ stays enabled across the kexec */
+static int arm_smmu_preserve_evtq(struct arm_smmu_device *smmu,
+				  struct iommu_hw_ser *iommu_ser)
+{
+	struct arm_smmu_queue *q = &smmu->evtq.q;
+
+	iommu_ser->smmuv3.evtq_lu_state = 0;
+	if (!(smmu->features & ARM_SMMU_FEAT_EVTQ))
+		return 0;
+
+	return dmam_preserve_coherent_allocation(smmu->dev, q->base,
+						 arm_smmu_evtq_size(smmu),
+						 q->base_dma,
+						 &iommu_ser->smmuv3.evtq_lu_state);
+}
+
+static void arm_smmu_unpreserve_evtq(struct arm_smmu_device *smmu,
+				     struct iommu_hw_ser *iommu_ser)
+{
+	struct arm_smmu_queue *q = &smmu->evtq.q;
+
+	if (!iommu_ser->smmuv3.evtq_lu_state)
+		return;
+
+	dmam_unpreserve_coherent_allocation(smmu->dev, q->base,
+					    arm_smmu_evtq_size(smmu),
+					    q->base_dma,
+					    iommu_ser->smmuv3.evtq_lu_state);
+	iommu_ser->smmuv3.evtq_lu_state = 0;
+}
+
 int arm_smmu_preserve(struct iommu_device *iommu,
 		      struct iommu_hw_ser *iommu_ser)
 {
 	struct arm_smmu_device *smmu =
 		container_of(iommu, struct arm_smmu_device, iommu);
+	int ret;
 
 	/* Basic info */
 	iommu_ser->smmuv3.phys_addr = smmu->base_phys;
@@ -416,11 +453,20 @@ int arm_smmu_preserve(struct iommu_device *iommu,
 	iommu_ser->smmuv3.strtab_base_cfg =
 		readl_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE_CFG);
 
+	ret = arm_smmu_preserve_evtq(smmu, iommu_ser);
+	if (ret) {
+		dev_err(smmu->dev, "EVTQ preservation failed\n");
+		return ret;
+	}
+
 	/* We always implements 2-level when supported by HW */
 	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
-		return arm_smmu_preserve_strtab_2lvl(smmu, iommu_ser);
+		ret = arm_smmu_preserve_strtab_2lvl(smmu, iommu_ser);
 	else
-		return arm_smmu_preserve_strtab_linear(smmu, iommu_ser);
+		ret = arm_smmu_preserve_strtab_linear(smmu, iommu_ser);
+	if (ret)
+		arm_smmu_unpreserve_evtq(smmu, iommu_ser);
+	return ret;
 }
 
 void arm_smmu_unpreserve(struct iommu_device *iommu,
@@ -433,6 +479,7 @@ void arm_smmu_unpreserve(struct iommu_device *iommu,
 		arm_smmu_unpreserve_strtab_2lvl(smmu, iommu_ser);
 	else
 		arm_smmu_unpreserve_strtab_linear(smmu, iommu_ser);
+	arm_smmu_unpreserve_evtq(smmu, iommu_ser);
 }
 
 static void arm_smmu_liveupdate_clear_l1_std(struct arm_smmu_device *smmu,
@@ -545,12 +592,12 @@ int arm_smmu_liveupdate_shutdown(struct arm_smmu_device *smmu)
 	 * TODO: Quiesce the CMDQV VCMDQs assigned to guests.
 	 */
 
-	/* Disable the queues, leaving SMMUEN set for the preserved masters */
+	/* The incoming kernel resets the CMDQ and PRIQ and adopts the EVTQ */
 	cr0 = readl_relaxed(smmu->base + ARM_SMMU_CR0);
-	cr0 &= ~(CR0_CMDQEN | CR0_EVTQEN | CR0_PRIQEN);
+	cr0 &= ~(CR0_CMDQEN | CR0_PRIQEN);
 	ret = arm_smmu_write_reg_sync(smmu, cr0, ARM_SMMU_CR0, ARM_SMMU_CR0ACK);
 	if (ret)
-		dev_err(smmu->dev, "failed to disable queues\n");
+		dev_err(smmu->dev, "failed to disable CMDQ/PRIQ\n");
 	return ret;
 }
 
@@ -696,6 +743,57 @@ int arm_smmu_liveupdate_restore_strtab(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+/* Adopt the live EVTQ. Returns -ENOENT if it wasn't preserved */
+int arm_smmu_liveupdate_restore_evtq(struct arm_smmu_device *smmu)
+{
+	u64 base = readq_relaxed(smmu->base + ARM_SMMU_EVTQ_BASE);
+	u32 log2size = FIELD_GET(Q_BASE_LOG2SIZE, base);
+	struct arm_smmu_queue *q = &smmu->evtq.q;
+	struct iommu_hw_ser *iommu_ser;
+
+	iommu_ser = iommu_get_preserved_data(smmu->base_phys, IOMMU_ARM_SMMUV3);
+	if (!iommu_ser || !iommu_ser->smmuv3.evtq_lu_state)
+		return -ENOENT;
+
+	if (log2size > q->llq.max_n_shift) {
+		dev_err(smmu->dev, "preserved EVTQ is larger than supported\n");
+		return -EINVAL;
+	}
+	q->llq.max_n_shift = log2size;
+
+	q->base = dmam_restore_coherent_allocation(smmu->dev,
+			arm_smmu_evtq_size(smmu), &q->base_dma, GFP_KERNEL,
+			iommu_ser->smmuv3.evtq_lu_state);
+	if (!q->base)
+		return -ENOMEM;
+
+	if (q->base_dma != (base & Q_BASE_ADDR_MASK)) {
+		dev_err(smmu->dev, "EVTQ_BASE doesn't match the preserved EVTQ\n");
+		return -EINVAL;
+	}
+
+	q->prod_reg = smmu->page1 + ARM_SMMU_EVTQ_PROD;
+	q->cons_reg = smmu->page1 + ARM_SMMU_EVTQ_CONS;
+	q->ent_dwords = EVTQ_ENT_DWORDS;
+	q->q_base = base;
+
+	q->llq.prod = readl_relaxed(q->prod_reg);
+	q->llq.cons = readl_relaxed(q->cons_reg);
+
+	dev_info(smmu->dev, "restored preserved evtq (%u entries)\n",
+		 1 << q->llq.max_n_shift);
+	return 0;
+}
+
+/* A failed EVTQ restore fails the probe, so a preserved EVTQ implies live */
+bool arm_smmu_liveupdate_evtq_is_live(struct arm_smmu_device *smmu)
+{
+	struct iommu_hw_ser *iommu_ser;
+
+	iommu_ser = iommu_get_preserved_data(smmu->base_phys, IOMMU_ARM_SMMUV3);
+	return iommu_ser && iommu_ser->smmuv3.evtq_lu_state;
+}
+
 int arm_smmu_liveupdate_restore_cd_tables(struct arm_smmu_master *master)
 {
 	struct arm_smmu_device *smmu = master->smmu;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b371ea6b6009..5f9f8bfac668 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4683,10 +4683,13 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 
 	/* evtq */
 	if (smmu->features & ARM_SMMU_FEAT_EVTQ) {
-		ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q, smmu->page1,
-					      ARM_SMMU_EVTQ_PROD,
-					      ARM_SMMU_EVTQ_CONS,
-					      EVTQ_ENT_DWORDS, "evtq");
+		ret = arm_smmu_liveupdate_restore_evtq(smmu);
+		if (ret == -ENOENT)
+			ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q,
+						      smmu->page1,
+						      ARM_SMMU_EVTQ_PROD,
+						      ARM_SMMU_EVTQ_CONS,
+						      EVTQ_ENT_DWORDS, "evtq");
 		if (ret)
 			return ret;
 	}
@@ -5080,9 +5083,15 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	 * Same for a Live Update restore.
 	 */
 	if (arm_smmu_strtab_is_live(smmu)) {
+		u32 qens = CR0_CMDQEN | CR0_EVTQEN | CR0_PRIQEN;
+
 		dev_info(smmu->dev, "%s: retaining SMMUEN for in-flight DMA\n",
 			 is_kdump_kernel() ? "kdump" : "live update");
-		enables = reg & ~(CR0_CMDQEN | CR0_EVTQEN | CR0_PRIQEN);
+
+		/* An adopted EVTQ keeps running */
+		if (arm_smmu_liveupdate_evtq_is_live(smmu))
+			qens &= ~CR0_EVTQEN;
+		enables = reg & ~qens;
 		goto reset_queues;
 	}
 
@@ -5173,12 +5182,15 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 
 	/* Event queue */
 	if (smmu->features & ARM_SMMU_FEAT_EVTQ) {
-		writeq_relaxed(smmu->evtq.q.q_base,
-			       smmu->base + ARM_SMMU_EVTQ_BASE);
-		writel_relaxed(smmu->evtq.q.llq.prod,
-			       smmu->page1 + ARM_SMMU_EVTQ_PROD);
-		writel_relaxed(smmu->evtq.q.llq.cons,
-			       smmu->page1 + ARM_SMMU_EVTQ_CONS);
+		/* An adopted EVTQ resumes from its live BASE/PROD/CONS */
+		if (!arm_smmu_liveupdate_evtq_is_live(smmu)) {
+			writeq_relaxed(smmu->evtq.q.q_base,
+				       smmu->base + ARM_SMMU_EVTQ_BASE);
+			writel_relaxed(smmu->evtq.q.llq.prod,
+				       smmu->page1 + ARM_SMMU_EVTQ_PROD);
+			writel_relaxed(smmu->evtq.q.llq.cons,
+				       smmu->page1 + ARM_SMMU_EVTQ_CONS);
+		}
 
 		enables |= CR0_EVTQEN;
 		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
@@ -5228,6 +5240,11 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		return ret;
 	}
 
+	/* Handle the events recorded across the Live Update */
+	if (arm_smmu_liveupdate_evtq_is_live(smmu) &&
+	    (smmu->combined_irq || smmu->evtq.q.irq))
+		irq_wake_thread(smmu->combined_irq ?: smmu->evtq.q.irq, smmu);
+
 	/* Enable the SMMU interface */
 	enables |= CR0_SMMUEN;
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1b33f713f3b7..3a67ba685ef5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1214,6 +1214,8 @@ void arm_smmu_unpreserve(struct iommu_device *iommu,
 int arm_smmu_liveupdate_shutdown(struct arm_smmu_device *smmu);
 int arm_smmu_liveupdate_restore_strtab(struct arm_smmu_device *smmu);
 int arm_smmu_liveupdate_restore_cd_tables(struct arm_smmu_master *master);
+int arm_smmu_liveupdate_restore_evtq(struct arm_smmu_device *smmu);
+bool arm_smmu_liveupdate_evtq_is_live(struct arm_smmu_device *smmu);
 int arm_smmu_liveupdate_attach_restored(struct arm_smmu_master *master,
 					struct arm_smmu_domain *smmu_domain);
 #else
@@ -1229,6 +1231,14 @@ static inline int arm_smmu_liveupdate_restore_cd_tables(struct arm_smmu_master *
 {
 	return 0;
 }
+static inline int arm_smmu_liveupdate_restore_evtq(struct arm_smmu_device *smmu)
+{
+	return -ENOENT;
+}
+static inline bool arm_smmu_liveupdate_evtq_is_live(struct arm_smmu_device *smmu)
+{
+	return false;
+}
 static inline int
 arm_smmu_liveupdate_attach_restored(struct arm_smmu_master *master,
 				    struct arm_smmu_domain *smmu_domain)
diff --git a/include/linux/kho/abi/iommu.h b/include/linux/kho/abi/iommu.h
index 397fdb0449a6..4e8cc32c3136 100644
--- a/include/linux/kho/abi/iommu.h
+++ b/include/linux/kho/abi/iommu.h
@@ -208,12 +208,14 @@ struct iommu_intel_ser {
  * @l2_strtab_lu_states_phys: Physical pointer to an array of u64 LU state tokens
  *                            indexed by L1 index, 0 for L2 tables that aren't
  *                            preserved (0 if linear)
+ * @evtq_lu_state: Live update state token for the Event queue (0 if not preserved)
  */
 struct iommu_smmuv3_hw_ser {
 	u64 phys_addr;
 	u64 strtab_base_cfg;
 	u64 l1_strtab_lu_state;
 	u64 l2_strtab_lu_states_phys;
+	u64 evtq_lu_state;
 } __packed;
 
 /**
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


