Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95839C48295
	for <kexec@archiver.kernel.org>; Mon,  5 Feb 2024 12:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eqEI0h4fRqUpp+PCxT4IPkCoqinQuBdUvnlVC2/LSQE=; b=aH5GUoXp8kOy/6
	HyBrJmEglSsDCXTJBqtTyGWvXbMnf4TIIkr/lHRlIWROnn1jHAQIrXXKByyIIBw9bzeolrESKiQ+o
	cWJ631/eN3c9tDsL3jkEHeheJjGDhAr5wN6z3e5lf3lnG3OPf/W2MTbb6uP5xBmCT/ZGea/S7lyND
	BVK44eDqlgwQsWd8q7ZBfQ6BwwgE12jFqdzRKh2ySZ9ds+TtNL9llrn50nnqKZgtmyHdNB6FRT05N
	SnPm8a0AykhA7iNTWbbY3pa31Q8Uygv72L0UqF8CzdcHmsQciD7mEZ+r2FvIk2QnO1dxBiXHXXwYo
	fg74r1tlj5Nl/rMQCtWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxkI-000000037dg-1Bh2;
	Mon, 05 Feb 2024 12:06:42 +0000
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxkG-000000037cB-0lBp
	for kexec@lists.infradead.org;
	Mon, 05 Feb 2024 12:06:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134800; x=1738670800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FiBUV1fiPqoy2U4uMejLoWWd/EiydMvzfGCqIJIuYJY=;
  b=DqplWJraTOeT5IdsJrnSe1aF3yYA2kZXGuAu0YCkNCmOMfyb1xU6/lcl
   dRf+Z7Jo/bcXfAPzs4KM/h4maq3JTpsT/GdGsMske2wnTn1bIEcz+4EwF
   4HBVSmtjsPXQYYT3dg2dEEXN4vQuYa934XQH+fKab7kFdWsVevyDAHLLo
   M=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="378967633"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:06:35 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:8094]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.45.85:2525] with esmtp (Farcaster)
 id 26f74936-a3bc-4ca0-9d65-59fbb5471a6c; Mon, 5 Feb 2024 12:06:32 +0000 (UTC)
X-Farcaster-Flow-ID: 26f74936-a3bc-4ca0-9d65-59fbb5471a6c
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:06:32 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:06:26 +0000
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
Subject: [RFC 18/18] vfio-pci: Assume device working after liveupdate
Date: Mon, 5 Feb 2024 12:02:03 +0000
Message-ID: <20240205120203.60312-19-jgowans@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205120203.60312-1-jgowans@amazon.com>
References: <20240205120203.60312-1-jgowans@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [172.19.112.191]
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_040640_435181_662C63E7 
X-CRM114-Status: GOOD (  14.27  )
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

When re-creating a VFIO device after liveupdate no desctructive actions
should be taken on it to avoid interrupting any ongoing DMA.
Specifically bus mastering should not be cleared and the device should
not be reset. Assume that reset works properly and skip over bus
mastering reset.

Ideally this would only be done for persistent devices but in this rough
RFC there currently is no mechanism at this point to easily tell if a
device is persisted or not.
---
 drivers/vfio/pci/vfio_pci_core.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 1929103ee59a..a7f56d43e0a4 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -480,19 +480,25 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 			return ret;
 	}
 
-	/* Don't allow our initial saved state to include busmaster */
-	pci_clear_master(pdev);
+	if (!liveupdate) {
+		/* Don't allow our initial saved state to include busmaster */
+		pci_clear_master(pdev);
+	}
 
 	ret = pci_enable_device(pdev);
 	if (ret)
 		goto out_power;
 
-	/* If reset fails because of the device lock, fail this path entirely */
-	ret = pci_try_reset_function(pdev);
-	if (ret == -EAGAIN)
-		goto out_disable_device;
+	if (!liveupdate) {
+		/* If reset fails because of the device lock, fail this path entirely */
+		ret = pci_try_reset_function(pdev);
+		if (ret == -EAGAIN)
+			goto out_disable_device;
 
-	vdev->reset_works = !ret;
+		vdev->reset_works = !ret;
+	} else {
+		vdev->reset_works = 1;
+	}
 	pci_save_state(pdev);
 	vdev->pci_saved_state = pci_store_saved_state(pdev);
 	if (!vdev->pci_saved_state)
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
