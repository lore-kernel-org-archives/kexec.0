Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FE2C4828D
	for <kexec@archiver.kernel.org>; Mon,  5 Feb 2024 12:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vXJfVQTNxAC45JQCzDiwXWJ2a5RI9mR3M1LcSKjMmb0=; b=yKbBD+N1qnbR1I
	TZ8GMNr6lIcHiZdaipSbY72yrw7n/+54QKxUY6nn+V1Q9o6SyzFbuFVny7sURXpWX9VVpDK9IVQtY
	PLGLfQLmSCuW/nGT647MQtKS0AUgLGJdx/9iLsj6zqdF3LG3ZIZwTmqoIDzb0mt7ZDvwQIb+/BfGs
	PDWu6aSdLWiKklY+DuFsFUNuey/zVbA3hs1jrMwVVSpg2Tkd3ZZCIaBzunhS8MrHW9wemH65uZhzD
	rA6vA5Fab3yObZ+8CmgWBpy/lBrjdE5up9w3N9KL5g03lDSh7iVAQBn8nR+tXKgSXbOVTJJaeJzDi
	/idRh/t0p4RZBdxCo21g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxiM-000000036lR-3e7G;
	Mon, 05 Feb 2024 12:04:42 +0000
Received: from smtp-fw-80009.amazon.com ([99.78.197.220])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxiJ-000000036iU-1lJd
	for kexec@lists.infradead.org;
	Mon, 05 Feb 2024 12:04:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134680; x=1738670680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J/26rYh9SEOln6y0M0icroO5+g+Mdt4aS3KBehgGFN8=;
  b=jBgeXVbC7MQ7ZeIq302ImADqVc71l2YNCmbm/gxsDbKY2jZ4RtRubVSp
   BMrt66UyyL0Rk72Q8hIhiQAcndzT2dObMXoEZ8dAKfdA7IERIGzWm/p2L
   P8lNTmaiQmpbvrKZomnyha00s5pOWg0qd2QccLfBLKpD+5MDvaNB6k6aE
   c=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="63724561"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:04:38 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:15018]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.28.192:2525] with esmtp (Farcaster)
 id 82f5a304-b865-4a4d-9902-a5be57c26a04; Mon, 5 Feb 2024 12:04:36 +0000 (UTC)
X-Farcaster-Flow-ID: 82f5a304-b865-4a4d-9902-a5be57c26a04
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:04:36 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:04:30 +0000
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
Subject: [RFC 11/18] dma-iommu: Always enable deferred attaches for liveupdate
Date: Mon, 5 Feb 2024 12:01:56 +0000
Message-ID: <20240205120203.60312-12-jgowans@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205120203.60312-1-jgowans@amazon.com>
References: <20240205120203.60312-1-jgowans@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [172.19.112.191]
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_040439_531818_7F3B3DB6 
X-CRM114-Status: GOOD (  13.69  )
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

Seeing as translations are pre-enabled, all devices will be set for
deferred attach. The deferred attached actually has to be done when
doing DMA mapping for devices to work.

There may be a better way to do this be, for example, consulting the
context entry table and only deferring attach if there is a persisted
context table entry for this device.
---
 drivers/iommu/dma-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index e5d087bd6da1..76f916848f48 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1750,7 +1750,7 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 
 static int iommu_dma_init(void)
 {
-	if (is_kdump_kernel())
+	if (is_kdump_kernel() || liveupdate)
 		static_branch_enable(&iommu_deferred_attach_enabled);
 
 	return iova_cache_get();
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
