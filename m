Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21552FDEE52
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 21:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ys4uatxpJYM7Kl1KgUYRndxIbkLNusGMab4h1bmL7Us=; b=xZbNNx82rurw1zUgyU77vAB5UG
	Q8Hi8YPha8cPBqPXlpznzym2j8GzlXYUFRs+M3n5b9s+me7To+iCItdsrYiPxBk9H346m/TZmImd+
	ypj/n4erzH6Xpvl6cvCeTmAcigExuiFFOJ2bKRnN81KJuaGa/vadz1U8c/pqDE5PtnT+wUAHGaeJc
	NYjZzXIn4AT89KVuuwWca1KT3uWd3a5iNpA7c1MmECwYRUhIC3U3tBzOi4MrgrX/Dq6uIoM70mH7z
	YTeqPY2uBj2NRG2vx816A7wL42LJ0tbFbvwMsTTFbygzxB1x5bkLTqi2bFsXjCOMdiDmMFynLO5Ma
	xke6SQSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG1WJ-0000000CLB1-3aiM;
	Thu, 23 Apr 2026 21:23:35 +0000
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG1WH-0000000CL8O-2IiK
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 21:23:34 +0000
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-35fbb5779e8so8012729a91.3
        for <kexec@lists.infradead.org>; Thu, 23 Apr 2026 14:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776979412; x=1777584212; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ys4uatxpJYM7Kl1KgUYRndxIbkLNusGMab4h1bmL7Us=;
        b=clr4m108rB36ZS2B1bBH00aq0bLNJ5YuKgrQtufGbGx0DQS4AdIVp5lD7X5GLYb+XP
         suw1yPYiQdMfw3w5zzS/2YZdPM0CjE9u3NolOvKPBzMJFvqdvj/8h5egVdq4dSonzq3Q
         cAA8LPxKGnzhsLJRcpo6LYw9keJY8FX3GoYULgMtiH39aUSHAhwpqIRCZDHfvbgqcBuR
         1CA70pP162ETpFR2J0zIwf8mYLBN/aincU4CrDkvLEcuGWNd4ZD6jioUOId9eZTvcQHt
         yjV7Ect7/en/vf3Zvuww5GML0dQzQq3xlRlrz/9iKSgbVYaKvyrvS0Yldct5Z6Xu+/b/
         5IJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979412; x=1777584212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ys4uatxpJYM7Kl1KgUYRndxIbkLNusGMab4h1bmL7Us=;
        b=XHtYZlzFa9/zjk965kd7wnM1k9gb3DZPUboWl4Zun3+8iWNOYXgJx+4VJgy7b5tquj
         GMX1/4ueNBToitYNym5uDhJRvI374CT9qFkdqx8Za+5wTnDJP/HJtAG3Yp400UsAw3zv
         0Xq5OoBGDMNwc3Xd7mkX787QoccU52TL0Oj8nxWntvlVFHRM/shA0Il/xxV6TTObSICU
         AGrbBkRgvr3K97fp9TafkAyg250ZandQ+xgzEK7dzPmm1nfScuEMa6mgOGnf23D5NgbC
         6lDw4x30ay3u+fV8p9MmS6/m3U0mLAsfCbE5cpbFYw9xh+uVIA9nxUPUk9TuBVPtjS5n
         /klQ==
X-Forwarded-Encrypted: i=1; AFNElJ+281oayL70LfnTl+WDHPyMep3JIeRYH7SyEUvWYTkM8T37kHEezSAFqCOs+4aTDEolYSZcVw==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywiuv09MWWDlKDmZ9y5gNgxwkkvAI6SJHSAzEJLx+hEWURBdFTU
	KZch753O+cHoT9RV3QWXU1EnOD+9qQ5glqgbZCFAzwDdQB3Ugirfts2HzU+F15nTFGXYQIaI1HN
	YzwtWyL8pjdVn0Q==
X-Received: from pjbbj17.prod.google.com ([2002:a17:90b:891:b0:362:b5ab:9cd3])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:51a3:b0:362:bb93:f25e with SMTP id 98e67ed59e1d1-362bb93f462mr8872524a91.23.1776979412273;
 Thu, 23 Apr 2026 14:23:32 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:23:11 +0000
In-Reply-To: <20260423212316.3431746-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423212316.3431746-8-dmatlack@google.com>
Subject: [PATCH v4 07/11] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
From: David Matlack <dmatlack@google.com>
To: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_142333_588003_1BBBBC94 
X-CRM114-Status: GOOD (  13.53  )
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

Inherit Access Control Services (ACS) flags on all incoming preserved
devices (endpoints and upstream bridges) during a Live Update.

Inheriting ACS flags avoids changing routing rules while memory
transactions are in flight from preserved devices. This is also strictly
necessary to ensure that IOMMU group assignments do not change across
a Live Update for preserved devices, as changing ACS configurations can
split or merge IOMMU groups.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 10 ++++++++++
 drivers/pci/pci.c        | 10 +++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 88125f9a2c6b..a9a89f7bd3e5 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -118,6 +118,16 @@
  * This enables the PCI core and any drivers bound to the bridge to participate
  * in the Live Update so that preserved endpoints can continue issuing memory
  * transactions during the Live Update.
+ *
+ * Handling Preserved Devices
+ * ==========================
+ *
+ * The PCI core treats preserved devices differently than non-preserved devices.
+ * This section enumerates those differences.
+ *
+ *  * The PCI core inherits all ACS flags enabled on incoming preserved devices
+ *    rather than assigning new ones. This ensures that TLPs are routed the same
+ *    way after Live Update and ensures that IOMMU groups do not change.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8f7cfcc00090..e615b7c3e430 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1017,6 +1017,15 @@ void pci_enable_acs(struct pci_dev *dev)
 	bool enable_acs = false;
 	int pos;
 
+	/*
+	 * ACS flags must be inherited from the previous kernel during a Live
+	 * Update for preserved devices (which includes endpoints and any
+	 * upstream bridges) to avoid changing routing while memory transactions
+	 * are in flight.
+	 */
+	if (pci_liveupdate_incoming(dev))
+		return;
+
 	/* If an iommu is present we start with kernel default caps */
 	if (pci_acs_enable) {
 		if (pci_dev_specific_enable_acs(dev))
@@ -1041,7 +1050,6 @@ void pci_enable_acs(struct pci_dev *dev)
 			 PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC,
 			 ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC));
 	__pci_config_acs(dev, &caps, config_acs_param, 0, 0);
-
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, caps.ctrl);
 }
 
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog


