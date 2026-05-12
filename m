Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F96CCD4F3D
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 18:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=suL1O4sFcS7rc/4d5OPs7kFFwy+U1yVMYGR9ND8RmlQ=; b=RXWK7z909VK4NmXF+CjPG5WvH4
	zAty94vfwzqPipYfR1Sg677dyibpMAg+K4UIstnQaU2tbU1faPJJBJSwGeUaxLkANTd515xZ+nqRx
	1nI3LwUVTiuMxHPvc/UAoiQ+T/g0WXnJoZOLYStqoLKWIMipKXF7GABANeME7klqrReIDXIupGtpL
	53NrjJTATs0QGMQ6btEFI99QUiJbNxaHDPzV5LgUvRzOPQbruuVvZD2y6sNUMleU6pHCnipfLS4rw
	13aO6+D425AZGiNPhIcuFH5uOy75cWde4H0+3qGoZw9IHHvZvZTz9Ll3YXAjcF8TZQx66d/VYlFph
	+6rEXThg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMsAA-000000008kA-3AvW;
	Tue, 12 May 2026 18:49:02 +0000
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMsA7-000000008fC-05KC
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 18:49:00 +0000
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-c828acf7c1dso3547624a12.3
        for <kexec@lists.infradead.org>; Tue, 12 May 2026 11:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778611738; x=1779216538; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=suL1O4sFcS7rc/4d5OPs7kFFwy+U1yVMYGR9ND8RmlQ=;
        b=sGZNFeyAhzUR0xK4PjSk1HZBgi7bQLEtL5OnrfThkN/ttMMv12CI4INhMwk2PsogPZ
         HW+sGSJy+ChaAfI7Ce6ubEJmPnQ3U5eXDaT+RuhwSn0wAqUBmCHeY4oJ4Ud005MFG899
         HdAzYGwfPILoyb7n/tlMWBd2NulD1n3WVVHDWfUhXl79i5zKhdwWoOIM7g5u23+S8lPj
         DnzokiwpgzaXuDueXh+MNfW/T9/cz7Qb+vX+J3hVeIXxjMMtly+BpbY62Hwk1NfvSLFx
         pARggHHf6s8y4pJ87E6GhVmMW5FDw5Pl6hBL330w+PZMS4Q+5qWhyVpv9ehi3bQ7/5Kc
         3+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778611738; x=1779216538;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=suL1O4sFcS7rc/4d5OPs7kFFwy+U1yVMYGR9ND8RmlQ=;
        b=MRLqZySkcJB9jDKig5VZ2dNGFgnZ8rsAn1O1/ef79UzPlo7QUxjsRiPq5rxahVmJqF
         WeY7BoBWKxHQv7PayYVdTd41rDRvFoCxMrY09yHA52FAGkMGnuEAgM+eyz1optsofn4p
         8a3ntGJ2tFQ5FxRG2mQoQbrTdbZIkf4qmyv8vd2K405C9EYUQMuugFCpMJs34mIwzf3x
         oxuvld5kzzGrs5mCKx/hPcuFyRexQddu1+X0WlbEOzozwUohy3Arq7/DGLEQp1LgkjJ1
         0FPyZlXXGqSmxp+3bde10DInE8MwC5ZBjt/e2dxPoxq/3N89MNxO6XOD3Uwk3ckr1vRd
         yPsQ==
X-Gm-Message-State: AOJu0Ywl5Exok+yTLauM/z1Hpf9GIzlAzEsB09AnvlfUpjsXpq0wq32z
	EmhOEGr8baWf9je4L0kb26zXQGh4ZS/j8ngkBof1niinJMRZjB37BcZE+iIXqbIyycYNYVKOrQI
	7Z+XywxRQpkfM+Q1OTkq5yEuM7g8NCoUi41hP6Nh/uox9+HcRiGup7yda63Z1afXhelNC7Ipgfy
	hHeRUac4KqdQBNJSEZt54VbdGk4e71AGFG6Wwl/SQlWMVi8N4FZcA=
X-Received: from pfbdu1.prod.google.com ([2002:a05:6a00:2b41:b0:82f:5b50:db30])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:8012:b0:82c:d986:e917 with SMTP id d2e1a72fcca58-83eebbaf559mr4596279b3a.22.1778611737978;
 Tue, 12 May 2026 11:48:57 -0700 (PDT)
Date: Tue, 12 May 2026 18:48:43 +0000
In-Reply-To: <20260512184846.119396-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260512184846.119396-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512184846.119396-9-dmatlack@google.com>
Subject: [PATCH v5 08/11] PCI: liveupdate: Inherit ARI Forwarding Enable on
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
X-CRM114-CacheID: sfid-20260512_114859_069022_A7EE300F 
X-CRM114-Status: GOOD (  14.48  )
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

Inherit the ARI Forwarding Enable on preserved bridges and update
pci_dev->ari_enabled accordingly during a Live Update. This ensures that
the preserved devices on the bridge's secondary bus can be identified
with the same expanded 8-bit function number after a Live Update.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 18 ++++++++++++++++++
 drivers/pci/liveupdate.h |  6 ++++++
 drivers/pci/pci.c        |  8 +++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index e3cd6d76636c..6ab03bd548b3 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -132,6 +132,10 @@
  *    way after Live Update and ensures that IOMMU groups do not change. Note
  *    that a device will use its inherited ACS flags for the lifetime of its
  *    struct pci_dev (i.e. even after pci_liveupdate_finish()).
+ *
+ *  * The PCI core inherits ARI Forwarding Enable on all bridges with downstream
+ *    preserved devices to ensure that all preserved devices on the bridge's
+ *    secondary bus are addressable after the Live Update.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -720,6 +724,20 @@ bool pci_liveupdate_inherit_acs(struct pci_dev *dev)
 	return true;
 }
 
+bool pci_liveupdate_inherit_ari(struct pci_dev *dev)
+{
+	u16 val;
+
+	guard(read_lock)(&dev->liveupdate.lock);
+
+	if (!dev->liveupdate.incoming)
+		return false;
+
+	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &val);
+	dev->ari_enabled = !!(val & PCI_EXP_DEVCTL2_ARI);
+	return true;
+}
+
 /**
  * pci_liveupdate_is_incoming() - Check if a device is incoming preserved
  * @dev: The PCI device to check
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index c0826ca717e3..fd7693c7ddd2 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -16,6 +16,7 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev);
 bool pci_liveupdate_inherit_buses(void);
 void pci_liveupdate_init_acs(struct pci_dev *dev);
 bool pci_liveupdate_inherit_acs(struct pci_dev *dev);
+bool pci_liveupdate_inherit_ari(struct pci_dev *dev);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -38,6 +39,11 @@ static inline bool pci_liveupdate_inherit_acs(struct pci_dev *dev)
 {
 	return false;
 }
+
+static inline bool pci_liveupdate_inherit_ari(struct pci_dev *dev)
+{
+	return false;
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index cd2c1f2ada92..7e9768dfe092 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3495,7 +3495,7 @@ void pci_configure_ari(struct pci_dev *dev)
 	u32 cap;
 	struct pci_dev *bridge;
 
-	if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
+	if (!pci_is_pcie(dev) || dev->devfn)
 		return;
 
 	bridge = dev->bus->self;
@@ -3506,6 +3506,12 @@ void pci_configure_ari(struct pci_dev *dev)
 	if (!(cap & PCI_EXP_DEVCAP2_ARI))
 		return;
 
+	if (pci_liveupdate_inherit_ari(bridge))
+		return;
+
+	if (pcie_ari_disabled)
+		return;
+
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
 		pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
 					 PCI_EXP_DEVCTL2_ARI);
-- 
2.54.0.563.g4f69b47b94-goog


