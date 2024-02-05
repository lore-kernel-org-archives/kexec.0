Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32009C48291
	for <kexec@archiver.kernel.org>; Mon,  5 Feb 2024 12:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eYR+w9IHO8SsldkCshXhKm3ye0hI8szQaxldfnoiug4=; b=PthdStjztNjfx5
	wlchcEI+NeJFwaKHwDRRi92mhch9VU1F/H+8JFxO8Np81kx6Tcmij9z9qHqpFUGWZrazg3xe5Ogqd
	JvTgVYMahYi6TaMHzWf7ws7oZaT/5E0e9xqNMsHQgb2oiDV5u1+0mxIUyHvA2NavP4lpJH3THi7eF
	7rezw3N5//GQl8JMMfXyvDm14LPOe72sQP/38tTK7ycTyeNyhR2Yq/zGdaIWbKeuMyVrNXSu3WNg8
	j6tpTrSBn3qk2FY3UpmpdRGs8FHULupVMWjuWlPKWAraWIOeYdTUq0tel+HRn+CPkQCQqDxoUcj8O
	LH97BXnELsJTynAnN3lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxjn-000000037QH-3WnQ;
	Mon, 05 Feb 2024 12:06:11 +0000
Received: from smtp-fw-52003.amazon.com ([52.119.213.152])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxjk-000000037Lt-0j3i
	for kexec@lists.infradead.org;
	Mon, 05 Feb 2024 12:06:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134768; x=1738670768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nHBURAsv2kVj18uGoBS/ynF5eAKuZbHIuIE7fti0DT8=;
  b=fdATPymAWKxJZFbuoV56eBtdniUaAPbsA2o9Y8yitgk92pBu67iHZ+JX
   59VZvl1uUIlzI15bOVv9eLdXQgWP7aPn/kNtip0vPHXSkMpfG3MyF4X85
   u0DCbD5z4Au2d1ycG6u4BBNqF2nwv9qaQvpdc0EoMpt9Dw/vd9T+uTpYm
   o=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="635764854"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:06:02 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:50504]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.28.192:2525] with esmtp (Farcaster)
 id a892883c-e384-427e-8387-b1c5e5820895; Mon, 5 Feb 2024 12:05:50 +0000 (UTC)
X-Farcaster-Flow-ID: a892883c-e384-427e-8387-b1c5e5820895
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:05:49 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:05:43 +0000
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
Subject: [RFC 15/18] pkernfs: register device memory for IOMMU domain pgtables
Date: Mon, 5 Feb 2024 12:02:00 +0000
Message-ID: <20240205120203.60312-16-jgowans@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205120203.60312-1-jgowans@amazon.com>
References: <20240205120203.60312-1-jgowans@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [172.19.112.191]
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_040608_514697_61487A61 
X-CRM114-Status: GOOD (  13.18  )
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

Similarly to the root/context pgtables, the IOMMU driver also does
phys_to_virt when walking the domain pgtables. To make this work
properly the physical memory needs to be mapped in at the correct place
in the direct map. Register a memory device to support this.

The alternative would be to wrap all of the phys_to_virt functions in
something which is pkernfs aware.
---
 fs/pkernfs/iommu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/pkernfs/iommu.c b/fs/pkernfs/iommu.c
index 5d0b256e7dd8..073b9dd48237 100644
--- a/fs/pkernfs/iommu.c
+++ b/fs/pkernfs/iommu.c
@@ -9,6 +9,7 @@ void pkernfs_get_region_for_ppts(struct file *ppts, struct pkernfs_region *pkern
 	struct pkernfs_inode *pkernfs_inode;
 	unsigned long *mappings_block_vaddr;
 	unsigned long inode_idx;
+	int rc;
 
 	/*
 	 * For a pkernfs region block, the "mappings_block" field is still
@@ -22,7 +23,20 @@ void pkernfs_get_region_for_ppts(struct file *ppts, struct pkernfs_region *pkern
 	mappings_block_vaddr = (unsigned long *)pkernfs_addr_for_block(NULL,
 			pkernfs_inode->mappings_block);
 	set_bit(0, mappings_block_vaddr);
-	pkernfs_region->vaddr = mappings_block_vaddr;
+
+	dev_set_name(&pkernfs_region->dev, "vfio-ppt-%s", pkernfs_inode->filename);
+	rc = device_register(&pkernfs_region->dev);
+	if (rc)
+		pr_err("device_register failed: %i\n", rc);
+
+	pkernfs_region->pgmap.range.start = pkernfs_base +
+		(pkernfs_inode->mappings_block * PMD_SIZE);
+	pkernfs_region->pgmap.range.end =
+		pkernfs_region->pgmap.range.start + PMD_SIZE - 1;
+	pkernfs_region->pgmap.nr_range = 1;
+	pkernfs_region->pgmap.type = MEMORY_DEVICE_GENERIC;
+	pkernfs_region->vaddr =
+		devm_memremap_pages(&pkernfs_region->dev, &pkernfs_region->pgmap);
 	pkernfs_region->paddr = pkernfs_base + (pkernfs_inode->mappings_block * (2 << 20));
 }
 void pkernfs_alloc_iommu_root_pgtables(struct pkernfs_region *pkernfs_region)
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
