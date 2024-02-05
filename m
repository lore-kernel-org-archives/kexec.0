Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770CFC4828D
	for <kexec@archiver.kernel.org>; Mon,  5 Feb 2024 12:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vhrEbTLHwfER9clNxj6gLeh9j4fUj1X/mTFMyxRC6Xk=; b=pKwYnuUcG2K6v9
	FM3NED4dUVje/+L72uUcHlSPmkZXPAkonsxYbAzNqC+kZu7XtHbi/ZFtsWACQKjtBhcTYV4B88SMh
	sWmqEq90gXF1PqsTX2j8NxZGhVtjtkIZWGh+vbeq9wKkMrba7eOoOSWCzxeh6LndZbOxM27/4aYzu
	X3KGf8drhv/PhneWU4sSBm1dqw+RuyCHe+oT0TmhMK6SiEvXtMruX8tVe92qAPWUeYrOeJ6SShpnb
	bgH1gQ/Vj7q1bACGbfMVY5jz45mHKjuk6ezy1QlqwgBc1NKqwHKkSqdH6AnI7Les2ZUF69LeHbcCd
	ql0fDIjxdlGN7H7dUnKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxjj-000000037M2-0Jl6;
	Mon, 05 Feb 2024 12:06:07 +0000
Received: from smtp-fw-52004.amazon.com ([52.119.213.154])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxjg-000000037Kw-1nos
	for kexec@lists.infradead.org;
	Mon, 05 Feb 2024 12:06:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134765; x=1738670765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PZz9j1l+xmnCAt/gSMnG+c7uMbg+JDxTUK6mJnmY1gY=;
  b=EywkZ7fINIMUY/2tN9n7MFAb0T18hEP31HO8IxhveOGhJH3sa05dWqFh
   coiXD8Zckk5WX3vBORsjQwIrfWx4Nb5ub6x1lhj8NciceWTpP2y4JQDtQ
   qRFLvb/M/pLYQnRXw/BxamCSR6Essvn+Ne6oZRuzI6InFuzSlqd17JaDi
   o=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="182633597"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:06:04 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:57869]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.28.144:2525] with esmtp (Farcaster)
 id 1dbb430b-a9a2-4718-957f-9c92058f05d9; Mon, 5 Feb 2024 12:06:02 +0000 (UTC)
X-Farcaster-Flow-ID: 1dbb430b-a9a2-4718-957f-9c92058f05d9
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:06:02 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:05:56 +0000
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
Subject: [RFC 17/18] pci: Don't clear bus master is persistence enabled
Date: Mon, 5 Feb 2024 12:02:02 +0000
Message-ID: <20240205120203.60312-18-jgowans@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205120203.60312-1-jgowans@amazon.com>
References: <20240205120203.60312-1-jgowans@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [172.19.112.191]
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_040604_654567_99AD4170 
X-CRM114-Status: GOOD (  13.02  )
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

In order for persistent devices to continue to DMA during kexec the bus
mastering capability needs to remain on. Do not disable bus mastering if
pkernfs is enabled, indicating that persistent devices are enabled.

Only persistent devices should have bus mastering left on during kexec
but this serves as a rough approximation of the functionality needed for
this pkernfs RFC.
---
 drivers/pci/pci-driver.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 51ec9e7e784f..131127967811 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/mempolicy.h>
+#include <linux/pkernfs.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
@@ -519,7 +520,8 @@ static void pci_device_shutdown(struct device *dev)
 	 * If it is not a kexec reboot, firmware will hit the PCI
 	 * devices with big hammer and stop their DMA any way.
 	 */
-	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
+	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot)
+			&& !pkernfs_enabled())
 		pci_clear_master(pci_dev);
 }
 
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
