Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF37CA5FA1
	for <kexec@archiver.kernel.org>; Tue, 29 Sep 2026 07:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aRnDa4vAhhdrCZggWPWQopoSXxq018MvNv/VSTy8Lhs=; b=P9JRfYVGaO8pfzl7G+xND2SuAV
	iL5Su1KydkzOIZZzGoiZ16UB08bUHUYaB5meKKtApTbBMxRV82UXIebseLOfoxr346obMs62U8BaI
	hYGec2jFg+9ckaYFuUuq4/napvVFZtrYSL4kJJES8K9mqcI+MLAXNV5afWZzcGJY9ODG0TUhpgBoR
	lfzFfGlvryt48F3Qm/rW/CwdKU38cLWUE4hOl4SZ2q2AxPSSkKT8RTbYDOx01ag98sSECLT1Psa7i
	2lb5Aq4v5Ygf6tH2rCd2meWiGQmomL5Z4H54+69mdMa1rEX0R6iycvIl9dTTpSZgICOW7VGoP8KsQ
	zRXXo4Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBS8d-00000002ahk-1ZRj;
	Tue, 29 Sep 2026 07:20:31 +0000
Received: from mail-pf1-x445.google.com ([2607:f8b0:4864:20::445])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBS8J-00000002aP6-2cFk
	for kexec@lists.infradead.org;
	Tue, 29 Sep 2026 07:20:12 +0000
Received: by mail-pf1-x445.google.com with SMTP id d2e1a72fcca58-86a2639398cso5573758b3a.3
        for <kexec@lists.infradead.org>; Tue, 29 Sep 2026 00:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790666410; x=1791271210; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aRnDa4vAhhdrCZggWPWQopoSXxq018MvNv/VSTy8Lhs=;
        b=HYzmlfZfGmPUDk/VXAYpCAfagC7geiG/EbkA2SHJelXjl0i26D6QKA5hmyqnTSrZVJ
         FIfdUW9nhTaCFHhuPm4QL/6ZsV/Vj6Ja6YML5k8HaYS0GcHGz3odV/pslGFfW4Bu846C
         eZXfR/0z/+EfzIsZB7DyR40kq1pNsyKsGG8gcv7u0wvNh8Sc8GNvoXtWn2eN7eSzXexZ
         cqixhOhj2HHYwLWQF0b/XjlrE3a5kIG2cvnHkbIPKTC8bCjaOGZsPBZwEgRhapz4S4X3
         mLliC6fs393ihSZFZla4h7VqLJMq/IfXocMGNp+gkZCnQgMCAvyt4UsDq/S7s0IB6r6Z
         KF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790666410; x=1791271210;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aRnDa4vAhhdrCZggWPWQopoSXxq018MvNv/VSTy8Lhs=;
        b=tyKLajIxxbX/KXSefAerfI6pxrPcEE5h9Utui9VLoIGlQ8wDqpaxzY5Gi0ItGIKhlB
         eQORvY04x0Tv8qWtCQGbDHzbm5GcluWLikzoQLarXDTm28xq4DmNbxNU+QHRUD5BOmRl
         GSBoXjAVudDnGWPlcB0Hiij/aGIwzUexdKeP+7dK6dAmcmLrNFXT9ZF5Y2aiToMOrSxL
         Dz2oeb2PTXRt6AWIrBkRJkwdDSrUL5vbVmaMa6NZ9o8gGuzzMd9OcWENcwtmgfchwNQd
         Ksn2OmfrJFwZa2GwPvbeY8ejlXUchGQHW+3zdrTbQWWBRm7JcT99o9vQU+uHgRA7L7DU
         roLQ==
X-Forwarded-Encrypted: i=1; AKwUvBx2MUu2T60PihMx0q4rJGPI/AKvacwrf5UmDZst3jeOdUBtloBKFXXUSZZuGxNG8Q9/DEP3pA==@lists.infradead.org
X-Gm-Message-State: AFuF++k8qJqd5vYb9FOg8Mh+e6bN5fThEKGwTgLQfpgRoDXQzuSKVN9a
	1PI8V3B8xUNv6ihq83QIuBjozYFNfaPEC2On/6PcWgj/C7luyFnA/oPJVMyLajZEJ1YpnavfgPX
	QGw==
X-Received: from pfbhu13.prod.google.com ([2002:a05:6a00:698d:b0:884:7cdd:23d1])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:94fb:b0:882:1d:c2ba
 with SMTP id d2e1a72fcca58-882001dcd3cmr5592982b3a.22.1790666410148; Tue, 29
 Sep 2026 00:20:10 -0700 (PDT)
Date: Tue, 29 Sep 2026 07:19:48 +0000
In-Reply-To: <20260929071950.2710070-1-praan@google.com>
Mime-Version: 1.0
References: <20260929071950.2710070-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929071950.2710070-8-praan@google.com>
Subject: [RFC PATCH v1 7/9] iommu/arm-smmu-v3: Retain SMMUEN across a Live
 Update restore
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
X-CRM114-CacheID: sfid-20260929_002011_692107_7640823A 
X-CRM114-Status: GOOD (  16.64  )
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

arm_smmu_device_reset() clears SMMUEN and rewrites CR1, CR2 and
STRTAB_BASE, aborting the DMA of the preserved devices. The kdump adoption
path already avoids this for a live Stream Table.

Introduce arm_smmu_strtab_is_live() and route a Live Update restore
through the kdump reset path. Also ack a stale GERROR, since the outgoing
kernel masked the interrupts, and skip installing the RMR bypass STEs.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 29 ++++++++++++++-------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3cf97f451b64..54c97ebc15b2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5048,6 +5048,13 @@ static void arm_smmu_write_strtab(struct arm_smmu_device *smmu)
 	writel_relaxed(reg, smmu->base + ARM_SMMU_STRTAB_BASE_CFG);
 }
 
+/* Adopted by kdump or restored by LU (a failed restore fails the probe) */
+static bool arm_smmu_strtab_is_live(struct arm_smmu_device *smmu)
+{
+	return (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) ||
+	       iommu_get_preserved_data(smmu->base_phys, IOMMU_ARM_SMMUV3);
+}
+
 static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 {
 	int ret;
@@ -5064,10 +5071,11 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	 * According to spec, updating STRTAB_BASE/CR1/CR2 when CR0_SMMUEN=1 is
 	 * CONSTRAINED UNPREDICTABLE. So, skip those register updates and rely
 	 * on the adopted stream table from the crashed kernel.
+	 * Same for a Live Update restore.
 	 */
-	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) {
-		dev_info(smmu->dev,
-			 "kdump: retaining SMMUEN for in-flight DMA\n");
+	if (arm_smmu_strtab_is_live(smmu)) {
+		dev_info(smmu->dev, "%s: retaining SMMUEN for in-flight DMA\n",
+			 is_kdump_kernel() ? "kdump" : "live update");
 		enables = reg & ~(CR0_CMDQEN | CR0_EVTQEN | CR0_PRIQEN);
 		goto reset_queues;
 	}
@@ -5103,7 +5111,7 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	arm_smmu_write_strtab(smmu);
 
 reset_queues:
-	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) {
+	if (arm_smmu_strtab_is_live(smmu)) {
 		/*
 		 * Disable queues since arm_smmu_device_disable() was skipped.
 		 * CR0 fields are independent per spec, so the queue enable bits
@@ -5122,8 +5130,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	 * errors would be visible. Ack everything prior to re-enabling the CMDQ
 	 * as a stale CMDQ_ERR would halt the CMDQ and new command will timeout.
 	 * Acking SFM_ERR is defined too, although it would not exit the SFM.
+	 * Same for a Live Update, as the outgoing kernel masked the interrupts.
 	 */
-	if (is_kdump_kernel()) {
+	if (is_kdump_kernel() || arm_smmu_strtab_is_live(smmu)) {
 		u32 gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
 		u32 gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
 
@@ -5193,10 +5202,10 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	}
 
 	/*
-	 * In a kdump adopt case, retain the crashed kernel's ATS-check policy
-	 * captured above rather than forcing it on.
+	 * In a kdump adopt or a Live Update restore case, retain the previous
+	 * kernel's ATS-check policy captured above rather than forcing it on.
 	 */
-	if (!(smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) &&
+	if (!arm_smmu_strtab_is_live(smmu) &&
 	    (smmu->features & ARM_SMMU_FEAT_ATS)) {
 		enables |= CR0_ATSCHK;
 		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
@@ -5722,8 +5731,10 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
 	 * Kdump adoption keeps the crashed kernel's table live. Rewriting the
 	 * adopted STE here could expose an in-flight fetch to a transient V=0
 	 * entry, or change Cfg=translate to Cfg=bypass. Must skip here.
+	 * Same for a Live Update restore.
+	 * TODO: Re-install the bypass STEs of the unpreserved RMR SIDs.
 	 */
-	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT)
+	if (arm_smmu_strtab_is_live(smmu))
 		return;
 
 	INIT_LIST_HEAD(&rmr_list);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


