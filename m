Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62564C54F5D
	for <kexec@archiver.kernel.org>; Tue, 28 Jul 2026 22:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wIyl1z6VbEjbpTwDm7dyBOXwnjYP7h00s7jMGOKLSmY=; b=Kf02hcfjIfQqNWA8a3TgVkYzjs
	lUeutXUjPk8v06REQLfTKbJnZaUARpdu9ArvxSRK/M6zqyRxTeGVodrs1ZzyXQjLmOW3ZWJpTuxww
	KRYNf3GMoVAtbRgAQZ/0cuFA59GBSEFOj354QtKb/eQ7m96h0amuJXYUrTQGlyXpPYJcHHQTb5pii
	c9+H7OTGA026rPyIMvkUcL2xscBLUYBIIA7fGlsAlMK22d5wAlYA+g5+OvNMjpSx96lweGrZJCIPL
	ZFOrbjzi8wJA8bMxrFl2ohCzwuOWcL6d4eQXKUvz4P0Syh6jYI5r5ubnqtPEw4AIROqubgQVeqz4o
	Tqoj18Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woq0S-00000006NzJ-0AlZ;
	Tue, 28 Jul 2026 22:10:36 +0000
Received: from mail-pl1-x647.google.com ([2607:f8b0:4864:20::647])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woq0M-00000006Nsr-2XLP
	for kexec@lists.infradead.org;
	Tue, 28 Jul 2026 22:10:32 +0000
Received: by mail-pl1-x647.google.com with SMTP id d9443c01a7336-2cacd6d37edso4493295ad.0
        for <kexec@lists.infradead.org>; Tue, 28 Jul 2026 15:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785276629; x=1785881429; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wIyl1z6VbEjbpTwDm7dyBOXwnjYP7h00s7jMGOKLSmY=;
        b=jWn1r4NvACM5SyrvwM6lo/5quDF2Z2Za/yTePYitk3dX2n5lnm6czFFekT0koF8Mt9
         ME0V9CGawgb8n5Z0Gvo7XhFj+mdpPGn2ynQgLTP9gEp4mFcyL8U6LFIEXFLujheaKomP
         8PBADtMKOrgxgnj96bVc3FQkn5BwlMumtbYunu1pff1tvNhs5a3mBuOnX2Sz+vdJyVta
         Ni7t3xKlG8g/CjmnyWS5uMTLyeHD7/Q6LmqBj4SqVXzNZuspKyc/9unbmeGCgAL89JWH
         I83UsUqPeHzDckHwP8e8c0OFLWPKNWKND93pldpXmq08NtKP2HDgWzJtoFRO7GklKCQo
         B+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785276629; x=1785881429;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wIyl1z6VbEjbpTwDm7dyBOXwnjYP7h00s7jMGOKLSmY=;
        b=CFiEFLs8jazjgvQy0ix5cjTWtIj7jGLtYTJC8QWelRBs3oIfVraltGNRyrf3lb+abw
         EjBVtgj08vY9Qvo57Le2nCVn0InbqV6yzUqd560IGwZ0/icC7bKViGSkV8AcGdpmfKtT
         CRoNyfyxlzP70b0byuuuFkaygOquzbThNZ7yWjn9sCs33dBowl6AjiGEvlxEawdTBo1D
         zHRI4Ch5nwf4EhO5nlLTie0e2eWzS6oi3IDZi2lRKS0kChm5q3ChbRxPEdv52A0uyG1o
         Wf2x5RpK5utBZ8ARbc6Odhq/qs3f8UHTk5r+T0mg6a1NoyhuxbJPUp+fEgjZTfbyts+7
         Y+pQ==
X-Gm-Message-State: AOJu0Yx8FRtbgie7ZrRnRuTojfxnaH0VntRx1atdFz0Ezqnk2RAo86EH
	u88sBi12W8S8yE5LohCvwzQzFwbHNkOXw+/biF96zpkIAtk5X6d26vG6fh8EAsVLPCyCHDLMRvX
	LhB9UwtLjAw3nXVv9cBcDUaWP4uvld56fUIknX/qsOJDgKqZrjZ0nntEYxnyM1Kkn1nmJpZ/wtc
	e7TqERzvUM/kk5IOOExvR5kXyred2ul2rlZVqUbbsAhNwR1lAcRJI=
X-Received: from pgbcp14.prod.google.com ([2002:a05:6a02:400e:b0:c96:c217:cd27])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3993:b0:3c0:9c19:65a8 with SMTP id adf61e73a8af0-3c8ba62a17dmr5198004637.64.1785276628580;
 Tue, 28 Jul 2026 15:10:28 -0700 (PDT)
Date: Tue, 28 Jul 2026 22:10:03 +0000
In-Reply-To: <20260728221007.2098560-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260728221007.2098560-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728221007.2098560-10-dmatlack@google.com>
Subject: [PATCH v8 09/12] PCI: liveupdate: Adopt ARI Forwarding Enable on
 preserved bridges
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_151031_439831_28A896BF 
X-CRM114-Status: GOOD (  17.83  )
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

Adopt the ARI Forwarding Enable bit on preserved bridges and update
pci_dev->ari_enabled accordingly during a Live Update. This ensures that
the preserved devices on the bridge's secondary bus can be identified
with the same expanded 8-bit function number after a Live Update.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 30 ++++++++++++++++++++++++++++++
 drivers/pci/liveupdate.h |  6 ++++++
 drivers/pci/pci.c        |  8 +++++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index fb602dd3933e..744513ee11ed 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -128,6 +128,10 @@
  *    way after Live Update and ensures that IOMMU groups do not change. Note
  *    that a device will use its adopted ACS controls for the lifetime of its
  *    struct pci_dev (i.e. even after pci_liveupdate_finish()).
+ *
+ *  * The PCI core adopts ARI Forwarding Enable on all bridges with downstream
+ *    preserved devices to ensure that all preserved devices on the bridge's
+ *    secondary bus are addressable after the Live Update.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -833,6 +837,32 @@ int pci_liveupdate_enable_adopted_acs_controls(struct pci_dev *dev)
 	return 0;
 }
 
+/**
+ * pci_liveupdate_adopt_ari() - Adopt ARI configuration
+ * @dev: The PCI device to adopt ARI configuration for
+ *
+ * For devices preserved across a Live Update, read the ARI state from
+ * hardware and adopt it. This ensures the device continues to use the ARI
+ * configuration established by the previous kernel.
+ *
+ * Return: 0 on success, or -EINVAL if the device was not preserved.
+ */
+int pci_liveupdate_adopt_ari(struct pci_dev *dev)
+{
+	u16 val;
+
+	guard(rwsem_read)(&pci_liveupdate.rwsem);
+
+	if (!dev->liveupdate.incoming)
+		return -EINVAL;
+
+	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &val);
+
+	/* Safe to modify dev->ari_enabled bitfield during enumeration. */
+	dev->ari_enabled = !!(val & PCI_EXP_DEVCTL2_ARI);
+	return 0;
+}
+
 /**
  * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
  * @dev: The PCI device to check
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index ac5b8bf2edf5..ccc23031e99d 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -18,6 +18,7 @@ bool pci_liveupdate_preserve_bus_numbers(struct pci_bus *bus,
 void pci_liveupdate_scan_bridge_end(struct pci_dev *dev);
 void pci_liveupdate_cache_adopted_acs_controls(struct pci_dev *dev);
 int pci_liveupdate_enable_adopted_acs_controls(struct pci_dev *dev);
+int pci_liveupdate_adopt_ari(struct pci_dev *dev);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -45,6 +46,11 @@ static inline int pci_liveupdate_enable_adopted_acs_controls(struct pci_dev *dev
 {
 	return -EINVAL;
 }
+
+static inline int pci_liveupdate_adopt_ari(struct pci_dev *dev)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 22001bdf4c97..6922f361a89e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3528,7 +3528,7 @@ void pci_configure_ari(struct pci_dev *dev)
 	u32 cap;
 	struct pci_dev *bridge;
 
-	if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
+	if (!pci_is_pcie(dev) || dev->devfn)
 		return;
 
 	bridge = dev->bus->self;
@@ -3539,6 +3539,12 @@ void pci_configure_ari(struct pci_dev *dev)
 	if (!(cap & PCI_EXP_DEVCAP2_ARI))
 		return;
 
+	if (!pci_liveupdate_adopt_ari(bridge))
+		return;
+
+	if (pcie_ari_disabled)
+		return;
+
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
 		pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
 					 PCI_EXP_DEVCTL2_ARI);
-- 
2.55.0.487.gaf234c4eb3-goog


