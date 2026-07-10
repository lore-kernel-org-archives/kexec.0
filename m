Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F1CC44506
	for <kexec@archiver.kernel.org>; Fri, 10 Jul 2026 21:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8nXcm3EXUYcPcGCSx60NMKl0mL3TQCPUFy3rNzpS5dk=; b=hk8WNnNqE5+yMmS97R0dbMeQu/
	k07QnTtFAgK6lshl3Pd3w3DCSVraoqm8gurSBxZyBBmZzaHRK72LQfVmq/uRaffts+nP0d6WJO9AA
	l3iO1+EV/+WegVsyhJMAU2LeBe3zwy18X+HOyR1oLvHpkpno+LmDyyOo+hGZyy0VSHWezlU6y2HAH
	BFvCD5Wagu+d5aTnJevWppSvr30xwG0Avt5M4xyw+mdghWskMsLXhVyO6SWjnO67iMpWZSNk/ACp9
	kPCN8frft3AxnJEBB3ItGA9xpfG/jQh6VRmPTYB/eddlaJZEtFZmBtpcJRC/0QZLfYSYuOMz8xvWL
	XQQmJo0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIk1-00000005pYh-01pq;
	Fri, 10 Jul 2026 21:26:37 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIjv-00000005pQP-45s7
	for kexec@lists.infradead.org;
	Fri, 10 Jul 2026 21:26:33 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2cc8bde6318so23249505ad.3
        for <kexec@lists.infradead.org>; Fri, 10 Jul 2026 14:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783718791; x=1784323591; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8nXcm3EXUYcPcGCSx60NMKl0mL3TQCPUFy3rNzpS5dk=;
        b=LEo30o5CqEgKjh1UV24PuXn7aqX8xFWMKB9ZJOI8Ety8MUbiXyYjK9dXgJYL5j0HCm
         NOkLKGJEk+KSY5HFKcGyFTa6nAxAOyCDAR7QqVRwZImcR8uFu1TGF6AoZ6UMe95+losM
         +I1VspJatDf/PRsfPMj1LsDc4I48t+O4VQnj1JyzV9bVak7RlYR1/wpFYb2KLFs5nq4A
         fKjpeI7Bpvmd1+Q+U5OE2plHII6TWcjrO9MwAbVNrFa4Ex8fvId92mL3Nc3NwX4oLSS0
         LShA8VAB904oH2YmHKEh8KYGY8R56LcRk9fscH0KHREPWm+gvMNmaQRHYaq38GlqeKvz
         cDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718791; x=1784323591;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8nXcm3EXUYcPcGCSx60NMKl0mL3TQCPUFy3rNzpS5dk=;
        b=UWcRGjSWC89S6YKd5dmW78gJ6+iBDk5k/YVC0INcvcrurzllTypT9qnN8qDCF+B9dd
         d3b8BMdqw4Act0O+zpBdzF0iV7E1PFIMcG+jlNadfpEqYYvcBv2j3qIwHdM1mG60/yAO
         3Svhec0I1Tj7U0bbT9VrTrb9kU/bgVaW6il/6hRmp5/EOW85Rqlpi1BG9Qy1AYaNflQS
         S8Lu2+2+qF7yB/yLBeLyW7e0+jmB7GsEmW/9Aej7Mg6QVKbxIaYDCPJyZzRrhhx0DpzN
         p5ekATkYKtk5M8FXWJgLqk9yBKVclq26GbaYJwxPA0wZtVSKAJ83lAys9dWkfaXqq9Wr
         c8kA==
X-Gm-Message-State: AOJu0Yzp1Ft3BIhpw2wd020Sihkph/AkGrsB5B9pYSaBnITkNp3ILS/u
	lfjmL+2/xapW8O5qJoBDZ2Mxd+2k+emH0F75rkhm3iKmYPN6L/1o0FBw/NiWeMPklz0TqNwj94M
	HK6yAWusWRaGAeO2xw4p2JeUwtftuQrF3KjiWaCXGsswx24+PALtQ+r5i6UwFYtMd0qeqZxVqTN
	aseoqIOzcKcwXspdFctu2/8NAOSx9qYDXO0TCQg5TN1oK8YuEFT+E=
X-Received: from plal14.prod.google.com ([2002:a17:903:4e:b0:2cc:da2c:8084])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1c8:b0:2ca:ed41:d33d with SMTP id d9443c01a7336-2ce9f294803mr7037355ad.45.1783718790387;
 Fri, 10 Jul 2026 14:26:30 -0700 (PDT)
Date: Fri, 10 Jul 2026 21:26:12 +0000
In-Reply-To: <20260710212616.1351130-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710212616.1351130-10-dmatlack@google.com>
Subject: [PATCH v7 09/12] PCI: liveupdate: Inherit ARI Forwarding Enable on
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
X-CRM114-CacheID: sfid-20260710_142632_051030_85E6DE2C 
X-CRM114-Status: GOOD (  14.61  )
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
index a95bfe5eff77..74a11e520f0d 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -128,6 +128,10 @@
  *    way after Live Update and ensures that IOMMU groups do not change. Note
  *    that a device will use its inherited ACS flags for the lifetime of its
  *    struct pci_dev (i.e. even after pci_liveupdate_finish()).
+ *
+ *  * The PCI core inherits ARI Forwarding Enable on all bridges with downstream
+ *    preserved devices to ensure that all preserved devices on the bridge's
+ *    secondary bus are addressable after the Live Update.
  */
 
 #define pr_fmt(fmt) "PCI: " KBUILD_BASENAME ": " fmt
@@ -816,6 +820,20 @@ int pci_liveupdate_enable_acs(struct pci_dev *dev)
 	return 0;
 }
 
+int pci_liveupdate_configure_ari(struct pci_dev *dev)
+{
+	u16 val;
+
+	guard(rwsem_read)(&pci_liveupdate.rwsem);
+
+	if (!dev->liveupdate.incoming)
+		return -EINVAL;
+
+	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &val);
+	dev->ari_enabled = !!(val & PCI_EXP_DEVCTL2_ARI);
+	return 0;
+}
+
 /**
  * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
  * @dev: The PCI device to check
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index 4e8a01bcb4bb..6f21ec50927b 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -18,6 +18,7 @@ bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus, struct pci_dev *dev,
 void pci_liveupdate_scan_bridge_end(struct pci_dev *dev, int pass);
 void pci_liveupdate_init_acs(struct pci_dev *dev);
 int pci_liveupdate_enable_acs(struct pci_dev *dev);
+int pci_liveupdate_configure_ari(struct pci_dev *dev);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -46,6 +47,11 @@ static inline int pci_liveupdate_enable_acs(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
+
+static inline int pci_liveupdate_configure_ari(struct pci_dev *dev)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 739ecaab2e76..e0c133b66a35 100644
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
 
+	if (!pci_liveupdate_configure_ari(bridge))
+		return;
+
+	if (pcie_ari_disabled)
+		return;
+
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
 		pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
 					 PCI_EXP_DEVCTL2_ARI);
-- 
2.55.0.795.g602f6c329a-goog


