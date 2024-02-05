Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED85C48298
	for <kexec@archiver.kernel.org>; Mon,  5 Feb 2024 12:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WGsU1MQZQRKhqxYopx1VYdRTJrzMfebrKvWypOY4dBw=; b=FclJ2i9F9VNUH9
	3ZQx5ebAxuCnVVGauOjt2IfoWmEE4FzP9TOfsR9LFmf0WEUdbkMaEs/U539YiJhaf3aTB/w6+4ESK
	gQKOUR2cd3AoigrM4fzZs0EiF20kE3yHY44X8xGKeuvu+2qbqL8jLHFZXNmbBW3QBwW9aRen8tvgK
	KJhfpmuUuuH3OoyKX1MYq6s+IEcjqZ2kWXkhfKfLEwiwXN0P1rgm4oQadRKZnrTOQ0DQ1K71LcaVR
	EJgNA+UvR2yjYHVRTVx7vW5+oS61Fsk7XuUxHuOXE06r4Ai7mdyUS5FP60JC1A90WSE0ass1SAgN+
	2cydGO8Dcfvqek3yJa2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxiL-000000036k1-15pi;
	Mon, 05 Feb 2024 12:04:41 +0000
Received: from smtp-fw-52004.amazon.com ([52.119.213.154])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxiH-000000036gt-3jFE
	for kexec@lists.infradead.org;
	Mon, 05 Feb 2024 12:04:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134678; x=1738670678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R61AUSOacFWGGPMbVgCPWnIrJ1KmkLbm3r8EEWKzIHg=;
  b=NHUEOT1l8blsUu0OOW4WtIE0a0UfsMyoeqWD2ILbjwx2aRsilVBvuSx0
   L3HTkEgdenVgGg0JInc0R6IvuYVXY+raoDEmt5lE/1HkHx0kdmberI1lH
   fyJafdVsV4P/H+vgUS6hHYkNDj+gESSjp5gDsWvlwrLRPeC/DtdeMlk2g
   Y=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="182633292"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:04:31 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:29990]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.14.129:2525] with esmtp (Farcaster)
 id 479437ca-efef-4c96-b04c-24208e90e4af; Mon, 5 Feb 2024 12:04:30 +0000 (UTC)
X-Farcaster-Flow-ID: 479437ca-efef-4c96-b04c-24208e90e4af
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:04:29 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:04:23 +0000
From: James Gowans <jgowans@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: Eric Biederman <ebiederm@xmission.com>, <kexec@lists.infradead.org>,
	"Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	<iommu@lists.linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>,
	<kvm@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, Alexander Graf <graf@amazon.com>, David Woodhouse
	<dwmw@amazon.co.uk>, "Jan H . Schoenherr" <jschoenh@amazon.de>, Usama Arif
	<usama.arif@bytedance.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	<madvenka@linux.microsoft.com>, <steven.sistare@oracle.com>,
	<yuleixzhang@tencent.com>
Subject: [RFC 10/18] iommu/intel: zap context table entries on kexec
Date: Mon, 5 Feb 2024 12:01:55 +0000
Message-ID: <20240205120203.60312-11-jgowans@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205120203.60312-1-jgowans@amazon.com>
References: <20240205120203.60312-1-jgowans@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [172.19.112.191]
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_040438_112287_40AE629B 
X-CRM114-Status: GOOD (  17.96  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

In the next commit the IOMMU shutdown function will be modified to not
actually shut down the IOMMU when doing a kexec. To prevent leaving DMA
mappings for non-persistent devices around during kexec we add a
function to the kexec flow which iterates though all IOMMU domains and
zaps the context entries for the devices belonging to those domain.

A list of domains for the IOMMU is added and maintained.
---
 drivers/iommu/intel/dmar.c  |  1 +
 drivers/iommu/intel/iommu.c | 34 ++++++++++++++++++++++++++++++----
 drivers/iommu/intel/iommu.h |  2 ++
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 23cb80d62a9a..00f69f40a4ac 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1097,6 +1097,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	iommu->segment = drhd->segment;
 
 	iommu->node = NUMA_NO_NODE;
+	INIT_LIST_HEAD(&iommu->domains);
 
 	ver = readl(iommu->reg + DMAR_VER_REG);
 	pr_info("%s: reg_base_addr %llx ver %d:%d cap %llx ecap %llx\n",
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2dd3f055dbce..315c6b7f901c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1831,6 +1831,7 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 		goto err_clear;
 	}
 	domain_update_iommu_cap(domain);
+	list_add(&domain->domains, &iommu->domains);
 
 	spin_unlock(&iommu->lock);
 	return 0;
@@ -3608,6 +3609,33 @@ static void intel_disable_iommus(void)
 		iommu_disable_translation(iommu);
 }
 
+void zap_context_table_entries(struct intel_iommu *iommu)
+{
+	struct context_entry *context;
+	struct dmar_domain *domain;
+	struct device_domain_info *device;
+	int bus, devfn;
+	u16 did_old;
+
+	list_for_each_entry(domain, &iommu->domains, domains) {
+		list_for_each_entry(device, &domain->devices, link) {
+			context = iommu_context_addr(iommu, device->bus, device->devfn, 0);
+			if (!context || !context_present(context))
+				continue;
+			context_domain_id(context);
+			context_clear_entry(context);
+			__iommu_flush_cache(iommu, context, sizeof(*context));
+			iommu->flush.flush_context(iommu,
+						   did_old,
+						   (((u16)bus) << 8) | devfn,
+						   DMA_CCMD_MASK_NOBIT,
+						   DMA_CCMD_DEVICE_INVL);
+			iommu->flush.flush_iotlb(iommu,	did_old, 0, 0,
+						 DMA_TLB_DSI_FLUSH);
+		}
+	}
+}
+
 void intel_iommu_shutdown(void)
 {
 	struct dmar_drhd_unit *drhd;
@@ -3620,10 +3648,8 @@ void intel_iommu_shutdown(void)
 
 	/* Disable PMRs explicitly here. */
 	for_each_iommu(iommu, drhd)
-		iommu_disable_protect_mem_regions(iommu);
-
-	/* Make sure the IOMMUs are switched off */
-	intel_disable_iommus();
+		zap_context_table_entries(iommu);
+	return
 
 	up_write(&dmar_global_lock);
 }
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index a2338e398ba3..4a2f163a86f3 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -600,6 +600,7 @@ struct dmar_domain {
 	spinlock_t lock;		/* Protect device tracking lists */
 	struct list_head devices;	/* all devices' list */
 	struct list_head dev_pasids;	/* all attached pasids */
+	struct list_head domains;	/* all struct dmar_domains on this IOMMU */
 
 	struct dma_pte	*pgd;		/* virtual address */
 	int		gaw;		/* max guest address width */
@@ -700,6 +701,7 @@ struct intel_iommu {
 	void *perf_statistic;
 
 	struct iommu_pmu *pmu;
+	struct list_head domains;	/* all struct dmar_domains on this IOMMU */
 };
 
 /* PCI domain-device relationship */
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
