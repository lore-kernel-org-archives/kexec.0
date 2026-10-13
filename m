Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C152CC6B1C
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 16:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yMN9BXHRpANo2zxDuLk7kDAodrYyScziqIAQD0PyUrY=; b=qEIREEwk8yp6/cs2PlDmpOWsKU
	LFlloNucWpAcdZClojbjV6hCSWXat/i+ryz3BOu0mal2iMIgBt8LwrlZHHF/72/Ronbdshmga2HYP
	qohDmH4UofzB+p8edWTFgonI4wys+4rVkMRkmvrDZUGDzUCVtTDKc5Cd3Dsb8idlC9pjdFv12Wkmz
	2zx0pmJ2MZtocX9wmsNsSmPOqF3XDGIXxnpb5sLycHigF1BmgZUkcKTXsjMGTRtS7Llx5nXsyf/ms
	kEwqtAYAWdZfSQtI2HGnzmGRvYV6oSAW1Sfip+vMDTwV7Gx2taZ1+DjxH46cEZ/lQJ7lCtlozsJHr
	uAubZ6ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfJy-0000000DUfp-1xS4;
	Tue, 13 Oct 2026 16:25:46 +0000
Received: from mail-pl1-x645.google.com ([2607:f8b0:4864:20::645])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfJu-0000000DUb5-0DFD
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 16:25:43 +0000
Received: by mail-pl1-x645.google.com with SMTP id d9443c01a7336-2cfa4e4684bso1045215ad.2
        for <kexec@lists.infradead.org>; Tue, 13 Oct 2026 09:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791908741; x=1792513541; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yMN9BXHRpANo2zxDuLk7kDAodrYyScziqIAQD0PyUrY=;
        b=Ws8ZFjZcNbzZzDy4L5So9EeSaVV/JXqLYjva4HYvCxWa1CgLRxuG4tPUSJKjCSbcz8
         Zqge2E01RcxtnyeKbghExDBwSTzsf4Hc6snv9op4HnjLuxRzQUfKqAZXesL2JSSBl9xD
         NZmHmfU/HmhYDqRK9Z25W3yu0et1KcEPsZUrqjdoCgFvNZKDrewmNerTUn47BbfPpR/i
         eDO+icEaZsAzJ9jqly7En8tpF063Bc3zTD8Um+sxEkrG1F7Y5Eac549eZrqcxYikZXOe
         Cf2B6yQeStDgu/zUpiGl5VH/w/HxACN7m9W7HYulZK+TuvzCGqj5qeQ+Fz53p0LLsXPe
         PBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791908741; x=1792513541;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yMN9BXHRpANo2zxDuLk7kDAodrYyScziqIAQD0PyUrY=;
        b=DsYhnuH6pm9rEoymW1Hc46+6vLxZt7vlIqRinA8EwamdJW9+tKij4+5GI+sNqUiRj7
         SrMsLlDBVwZ6LSDgYSnF+yLnYxsA6gAE7YI3ZcVn4heajE0qldfgUX5eTear7c/R5DPu
         uc707aSYJbhlR6GTNisL9KQ8KQbL7YJozpqKRz4abCg3fZzQW+MWpSTFHF1XQlj71FHm
         gY8GElrfqAsMehVjO7jJMviApZsUMADDxQCQ/jiZlF/krkz7kl+k1UlIQXP10iNerwG+
         LxdE2NkFpUWNmqL59hGMvhjgQh4lsv2CmRqElquNhL1bao89j3xZ4SFaduMlRwX61c++
         FZ5A==
X-Gm-Message-State: AFq9FYItswmp58BKzKWi9rLj4k/4SVtFBHpNn/SNLLnkdaVXqX4l1s7Y
	Jqnw7K5V896vkJxsfHRXTckiWw2GX5sxyB/rlfuOiM8yfTh8JCeQdsIbMMoTL/MNdQxTlwPsc6L
	YMnkCVeECcMpFcgJk2/LxJqD6jtQ0ziBV0UUW4VWm14oxg/nVFLDNhzFUnlBZ3o97yQCT3ZB8C3
	6pxth99+7iJdiJFUSaoN4VGqRXHJ2zxvkHevjV0YQEMKn90hCMgoQ=
X-Received: from plda4.prod.google.com ([2002:a17:902:ee84:b0:2e8:5201:ef23])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2305:b0:2e1:35f0:6822 with SMTP id d9443c01a7336-2e842820d14mr124713435ad.2.1791908740352;
 Tue, 13 Oct 2026 09:25:40 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:25:21 +0000
In-Reply-To: <20261013162529.1928093-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20261013162529.1928093-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013162529.1928093-6-dmatlack@google.com>
Subject: [PATCH v10 05/13] PCI: liveupdate: Auto-preserve upstream bridges
 across Live Update
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
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_092542_126689_5D48D0EB 
X-CRM114-Status: GOOD (  26.21  )
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

When a PCI device is preserved across a Live Update, all of its upstream
bridges up to the root port must also be preserved. This enables the PCI
core and any drivers bound to the bridges to manage bridges correctly
across a Live Update.

Notably, this will be used in subsequent commits to ensure that
preserved devices can continue performing memory transactions without a
disruption or change in routing.

To preserve bridges, the PCI core tracks the number of downstream
devices preserved under each bridge using a reference count in struct
pci_dev_ser. This allows a bridge to remain preserved until all its
downstream preserved devices are unpreserved or finish their
participation in the Live Update.

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 125 +++++++++++++++++++++++++++++----------
 include/linux/pci.h      |   3 +
 2 files changed, 96 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index d6b659b346bb..bffb3e1d8b2d 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -122,7 +122,6 @@
  * preserved. These may be relaxed in the future:
  *
  *  * The device cannot be a Virtual Function (VF).
- *  * The device cannot be behind a PCI-to-PCI bridge.
  *
  * Driver Binding
  * ==============
@@ -137,6 +136,18 @@
  * bound to the correct driver. The PCI core does not protect against a device
  * getting preserved by driver A in the outgoing kernel and then getting bound
  * to driver B in the incoming kernel.
+ *
+ * PCI-to-PCI Bridges
+ * ==================
+ *
+ * Any PCI-to-PCI bridges upstream of a preserved device are automatically
+ * preserved when the device is preserved. The PCI core keeps track of the
+ * number of downstream devices that are preserved under a bridge so that the
+ * bridge is only unpreserved once all downstream devices are unpreserved.
+ *
+ * This enables the PCI core and any drivers bound to the bridge to participate
+ * in the Live Update so that preserved endpoints can continue issuing memory
+ * transactions during the Live Update.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -425,55 +436,84 @@ static struct pci_dev_ser *pci_flb_alloc_dev_ser(struct pci_flb_outgoing *outgoi
 	return dev_ser;
 }
 
-static void pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
-					     struct pci_dev *dev)
+static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
+					    struct pci_dev *dev)
 {
 	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
 
 	if (!dev_ser) {
 		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
-		return;
+		return -EINVAL;
 	}
 
+	if (!dev_ser->refcount) {
+		pci_WARN(dev, 1, "Preserved device has a 0 refcount!\n");
+		return -EINVAL;
+	}
+
+	if (--dev_ser->refcount)
+		return 0;
+
 	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
 	outgoing->ser->nr_devices--;
 	memset(dev_ser, 0, sizeof(*dev_ser));
 	dev->liveupdate.outgoing = NULL;
+	return 0;
+}
+
+static void pci_liveupdate_unpreserve_path(struct pci_flb_outgoing *outgoing,
+					   struct pci_dev *dev,
+					   struct pci_dev *end)
+{
+	for_each_pci_dev_in_path(dev) {
+		if (dev == end)
+			break;
+
+		if (pci_liveupdate_unpreserve_device(outgoing, dev))
+			return;
+	}
 }
 
 static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
 					  struct pci_dev *dev)
 {
-	struct pci_dev_ser *dev_ser;
-
 	if (dev->is_virtfn) {
 		pci_warn(dev, "Cannot preserve Virtual Functions\n");
 		return -EINVAL;
 	}
 
-	if (dev->liveupdate.outgoing) {
+	/*
+	 * Endpoint devices should not be preserved more than once.
+	 * Bridges are preserved once for every downstream device that
+	 * is preserved.
+	 */
+	if (dev->liveupdate.outgoing && !dev->subordinate) {
 		pci_warn(dev, "Device is already preserved\n");
 		return -EBUSY;
 	}
 
-	if (!pci_is_root_bus(dev->bus)) {
-		pci_warn(dev, "Cannot preserve devices behind bridges\n");
+	if (dev->liveupdate.outgoing && !dev->liveupdate.outgoing->refcount) {
+		pci_WARN(dev, 1, "Preserved device with 0 refcount!\n");
 		return -EINVAL;
 	}
 
-	dev_ser = pci_flb_alloc_dev_ser(outgoing);
-	if (IS_ERR(dev_ser))
-		return PTR_ERR(dev_ser);
+	if (!dev->liveupdate.outgoing) {
+		struct pci_dev_ser *dev_ser;
 
-	pci_info(dev, "Device will be preserved across next Live Update\n");
-	outgoing->ser->nr_devices++;
-	outgoing->ser->devices = kho_block_set_head_pa(&outgoing->block_set);
+		dev_ser = pci_flb_alloc_dev_ser(outgoing);
+		if (IS_ERR(dev_ser))
+			return PTR_ERR(dev_ser);
 
-	dev_ser->domain = pci_domain_nr(dev->bus);
-	dev_ser->bdf = pci_dev_id(dev);
-	dev_ser->refcount++;
+		pci_info(dev, "Device will be preserved across next Live Update\n");
+		outgoing->ser->nr_devices++;
+		outgoing->ser->devices = kho_block_set_head_pa(&outgoing->block_set);
+
+		dev_ser->domain = pci_domain_nr(dev->bus);
+		dev_ser->bdf = pci_dev_id(dev);
+		dev->liveupdate.outgoing = dev_ser;
+	}
 
-	dev->liveupdate.outgoing = dev_ser;
+	dev->liveupdate.outgoing->refcount++;
 	return 0;
 }
 
@@ -486,12 +526,16 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
  * pci_liveupdate_preserve() from their struct liveupdate_file_handler
  * preserve() callback to ensure the outgoing struct pci_ser is already set up.
  *
+ * pci_liveupdate_preserve() automatically preserves all bridges upstream of
+ * @dev.
+ *
  * Returns: 0 on success, <0 on failure.
  */
 int pci_liveupdate_preserve(struct pci_dev *dev)
 {
 	struct pci_flb_outgoing *outgoing = NULL;
-	int ret;
+	struct pci_dev *start = dev;
+	int ret = -ENODEV;
 
 	guard(rwsem_write)(&pci_liveupdate.rwsem);
 
@@ -499,7 +543,13 @@ int pci_liveupdate_preserve(struct pci_dev *dev)
 	if (IS_ERR(outgoing))
 		return PTR_ERR(outgoing);
 
-	ret = pci_liveupdate_preserve_device(outgoing, dev);
+	for_each_pci_dev_in_path(dev) {
+		ret = pci_liveupdate_preserve_device(outgoing, dev);
+		if (ret) {
+			pci_liveupdate_unpreserve_path(outgoing, start, dev);
+			break;
+		}
+	}
 
 	pci_liveupdate_flb_put_outgoing();
 	return ret;
@@ -515,6 +565,9 @@ EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
  * pci_liveupdate_unpreserve() from their struct liveupdate_file_handler
  * unpreserve() callback to ensure the outgoing struct pci_ser is already set
  * up.
+ *
+ * pci_liveupdate_unpreserve() automatically unpreserves all bridges upstream of
+ * @dev.
  */
 void pci_liveupdate_unpreserve(struct pci_dev *dev)
 {
@@ -528,7 +581,7 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
 		return;
 	}
 
-	pci_liveupdate_unpreserve_device(outgoing, dev);
+	pci_liveupdate_unpreserve_path(outgoing, dev, /*end=*/NULL);
 	pci_liveupdate_flb_put_outgoing();
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
@@ -618,28 +671,30 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 		pci_WARN(dev, 1, "Destroying incoming-preserved device!\n");
 }
 
-static void pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *dev)
+static int pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *dev)
 {
 	if (!dev->liveupdate.incoming) {
 		pci_warn(dev, "Cannot finish preserving an unpreserved device\n");
-		return;
+		return -EINVAL;
 	}
 
-	if (dev->liveupdate.incoming->refcount != 1) {
-		pci_WARN(dev, 1, "Preserved device has a corrupted refcount!\n");
-		return;
+	if (!dev->liveupdate.incoming->refcount) {
+		pci_WARN(dev, 1, "Preserved device has a 0 refcount!\n");
+		return -EINVAL;
 	}
 
 	/*
-	 * Drop the refcount so this device does not get treated as an incoming
-	 * device again, e.g. in case pci_liveupdate_setup_device() gets called
-	 * again because the device is hot-plugged.
+	 * Decrement the refcount so this device does not get treated as an
+	 * incoming device again, e.g. in case pci_liveupdate_setup_device()
+	 * gets called again because the device is hot-plugged.
 	 */
-	dev->liveupdate.incoming->refcount = 0;
+	if (--dev->liveupdate.incoming->refcount)
+		return 0;
 
 	pci_info(dev, "Device is finished participating in Live Update\n");
 	dev->liveupdate.incoming = NULL;
 	ser->nr_devices--;
+	return 0;
 }
 
 /**
@@ -651,6 +706,8 @@ static void pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *de
  * Update. Drivers must call pci_liveupdate_finish() from their struct
  * liveupdate_file_handler finish() callback to ensure the incoming struct
  * pci_ser is allocated.
+ *
+ * pci_liveupdate_finish() automatically finishes all bridges upstream of @dev.
  */
 void pci_liveupdate_finish(struct pci_dev *dev)
 {
@@ -664,7 +721,11 @@ void pci_liveupdate_finish(struct pci_dev *dev)
 		return;
 	}
 
-	pci_liveupdate_finish_device(incoming->ser, dev);
+	for_each_pci_dev_in_path(dev) {
+		if (pci_liveupdate_finish_device(incoming->ser, dev))
+			break;
+	}
+
 	pci_liveupdate_flb_put_incoming();
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_finish);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 76abe884e3dc..b35ac263c451 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -836,6 +836,9 @@ static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
 	return dev->bus->self;
 }
 
+#define for_each_pci_dev_in_path(dev) \
+	for (; dev; dev = pci_upstream_bridge(dev))
+
 #ifdef CONFIG_PCI_MSI
 static inline bool pci_dev_msi_enabled(struct pci_dev *pci_dev)
 {
-- 
2.56.0.385.gd3acb90ef8-goog


