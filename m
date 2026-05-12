Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C0DCD4F3D
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 18:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T4K+3x46P5Tng2/W1DPr8N223Eo9F5ffuPNYieXQuRE=; b=0iwz14wldY7a4EyGe0mlr0MrF6
	Mx4UEefrtxM6jbPQl7D2P2Nm9yAI2eSypTZZBD9cxySmNBwzy23nIyYUEd25DM3OzDVs7/S8b/Lh0
	1zxrEoyutxzZoLWqHPNNUU9GWfOWkyIFDJcpTS5MclkPbxJZ0BkBwR/3l+h3zDFcNNMY5/DQqg729
	BTsXe3QDLqSvR2CaQNk8r85a0z+kdYSZfO7FAJY63zJtzbVzVjnjfN/3Zkk4jo1DImwL5oCDO1bL7
	a2+fzRCOPXswF0Wqmtam3xv4lw84bfbpjHbIbjZZTHEsbsaFaxa2Q4LVr35U4TbdRV+vhiRa13AqV
	LuMaqrrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMsA5-000000008dE-0MJk;
	Tue, 12 May 2026 18:48:57 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMsA2-000000008bN-3QFE
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 18:48:56 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2ba6fe41283so69143655ad.1
        for <kexec@lists.infradead.org>; Tue, 12 May 2026 11:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778611733; x=1779216533; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T4K+3x46P5Tng2/W1DPr8N223Eo9F5ffuPNYieXQuRE=;
        b=WbGODC4wxJk1uSovyGdgNNS9FBw9m+7KSBoQVdAiUPIgHpeOdjnOLFED6Bc0revBwJ
         v6qQ0azsc4Iiy1Wedyp8e/XuJC1D6bo8aAQmQFPD5Dkx57+ehWcdk/SKYo6YoLhIl+x/
         1iot11Fzt/7LkqSmqUyh2dYu62z+hN+RZ9k+saublOxMoxS9OKqYYTcsNfZhLR1CotPi
         MkI4F38/XdSG8I4EMoaTxSujNfW1+v82OcnRVzGwAjOtHdTl1mKcwnIrBfJFaVZYAqRR
         AA0VJv/O44dP/uvd0S7GoClKkYPMlXmoWBWbxKHAxHzOSphrb312uDW+iOb577N/Y7jo
         LLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778611733; x=1779216533;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T4K+3x46P5Tng2/W1DPr8N223Eo9F5ffuPNYieXQuRE=;
        b=UMuQxwET1GR0P4PGEvd0IZabNRJKAfpAOjIlMFGTS/mGq65Ku8zd4iRSj652K7u102
         LTxOiNDCaw7ZGI4grYxFH9rK7fPYmUT2fTQJGUnzQOPhbU9LuKTol4z+vssL4miaQujF
         xX2setu8cVWGo+7mJ4qseR8lkgAnDUNW2MGonVlrpwEXB55gU3F99FYDYZXX7A+zTGUZ
         kjdJ0ZYHYpDoJvLhEvDqOXXBJnIKUUkM2jpEFrmqZOn8Ptq3hDHHw9K7m27wJvzi3C4l
         oxmQD1Xlq/a87SEKyNQ/R/rXJUPNAJnWY9fGeg0h565cEFkNi/G32yiwrRtz2VScaKmG
         A/nA==
X-Gm-Message-State: AOJu0YzFyIKcmcEBcne/QqOb1wzB4U+AOlh75DAHgv0OStYo49Y4J1h6
	NBKEmaWegL3hL4kMGtBjHdX0ip+xBJ7Ija0k/qfudFiSYO5fVn67H4P/tOeVJLhxY9nZ29cMe5l
	B0Q7vOpvmrVPZt6yffVFChJybW7ecngPfMdM/RkX3PlUuA1FHUpSLan2gLjwXSneu0+lgI9ElbF
	Voljc6fQI9LPe+VnoYk7Uf8i+a4YXBJBV7wHWULKu0NzsGH5zjSHE=
X-Received: from plbkf6.prod.google.com ([2002:a17:903:5c6:b0:2b9:53bb:4a09])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ed04:b0:2bc:78ec:54c0 with SMTP id d9443c01a7336-2bd27291c8emr1934145ad.31.1778611732668;
 Tue, 12 May 2026 11:48:52 -0700 (PDT)
Date: Tue, 12 May 2026 18:48:37 +0000
In-Reply-To: <20260512184846.119396-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260512184846.119396-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512184846.119396-3-dmatlack@google.com>
Subject: [PATCH v5 02/11] PCI: liveupdate: Track outgoing preserved PCI devices
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
X-CRM114-CacheID: sfid-20260512_114854_867002_AFDDA451 
X-CRM114-Status: GOOD (  31.40  )
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

Add APIs to allow drivers to notify the PCI core of which devices are
being preserved across a Live Update for the next kernel, i.e.
"outgoing" devices.

Drivers must notify the PCI core when devices are preserved so that the
PCI core can update its FLB data (struct pci_ser) and track the list of
outgoing devices. pci_liveupdate_preserve() notifies the PCI core that a
device must be preserved across Live Update. pci_liveupdate_unpreserve()
reverses this (cancels the preservation of the device).

This tracking ensures the PCI core is fully aware of which devices may
need special handling during shutdown and kexec, and so that it can be
handed off to the next kernel.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c       | 167 ++++++++++++++++++++++++++++++---
 drivers/pci/probe.c            |   3 +
 include/linux/kho/abi/pci.h    |   9 +-
 include/linux/pci.h            |   3 +
 include/linux/pci_liveupdate.h |  23 +++++
 5 files changed, 191 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index dd2449e12b6d..9c4582ecd55c 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -43,6 +43,26 @@
  *
  *  * ``pci_liveupdate_register_flb(driver_file_handler)``
  *  * ``pci_liveupdate_unregister_flb(driver_file_handler)``
+ *
+ * Device Tracking
+ * ===============
+ *
+ * Drivers must notify the PCI core when specific devices are preserved or
+ * unpreserved with the following APIs:
+ *
+ *  * ``pci_liveupdate_preserve(pci_dev)``
+ *  * ``pci_liveupdate_unpreserve(pci_dev)``
+ *
+ * This allows the PCI core to keep its FLB data (struct pci_ser) up to date
+ * with the list of **outgoing** preserved devices for the next kernel.
+ *
+ * Restrictions
+ * ============
+ *
+ * The PCI core enforces the following restrictions on which devices can be
+ * preserved. These may be relaxed in the future:
+ *
+ *  * The device cannot be a Virtual Function (VF).
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -55,13 +75,29 @@
 #include <linux/mm.h>
 #include <linux/pci.h>
 
+/**
+ * struct pci_flb_outgoing - Outgoing PCI FLB object
+ * @ser: The outgoing struct pci_ser for the next kernel.
+ * @lock: Lock used to protect against changes to @ser.
+ */
+struct pci_flb_outgoing {
+	struct pci_ser *ser;
+	struct mutex lock;
+};
+
 static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
 {
+	struct pci_flb_outgoing *outgoing;
 	struct pci_dev *dev = NULL;
 	u32 max_nr_devices = 0;
-	struct pci_ser *ser;
 	unsigned long size;
 
+	outgoing = kmalloc_obj(*outgoing);
+	if (!outgoing)
+		return -ENOMEM;
+
+	mutex_init(&outgoing->lock);
+
 	/*
 	 * Allocate enough space to preserve all of the devices that are
 	 * currently present on the system. Extra padding can be added to this
@@ -74,27 +110,30 @@ static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
 
 	size = struct_size_t(struct pci_ser, devices, max_nr_devices);
 
-	ser = kho_alloc_preserve(size);
-	if (IS_ERR(ser))
-		return PTR_ERR(ser);
+	outgoing->ser = kho_alloc_preserve(size);
+	if (IS_ERR(outgoing->ser)) {
+		kfree(outgoing);
+		return PTR_ERR(outgoing->ser);
+	}
 
 	pr_debug("Preserved struct pci_ser with room for %u devices\n",
 		 max_nr_devices);
 
-	ser->max_nr_devices = max_nr_devices;
-	ser->nr_devices = 0;
+	outgoing->ser->max_nr_devices = max_nr_devices;
+	outgoing->ser->nr_devices = 0;
 
-	args->obj = ser;
-	args->data = virt_to_phys(ser);
+	args->obj = outgoing;
+	args->data = virt_to_phys(outgoing->ser);
 	return 0;
 }
 
 static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
 {
-	struct pci_ser *ser = args->obj;
+	struct pci_flb_outgoing *outgoing = args->obj;
 
-	WARN_ON_ONCE(ser->nr_devices);
-	kho_unpreserve_free(ser);
+	WARN_ON_ONCE(outgoing->ser->nr_devices);
+	kho_unpreserve_free(outgoing->ser);
+	kfree(outgoing);
 
 	pr_debug("Unpreserved struct pci_ser\n");
 }
@@ -123,6 +162,112 @@ static struct liveupdate_flb pci_liveupdate_flb = {
 	.compatible = PCI_LUO_FLB_COMPATIBLE,
 };
 
+/**
+ * pci_liveupdate_preserve() - Preserve a PCI device across Live Update
+ * @dev: The PCI device to preserve.
+ *
+ * pci_liveupdate_preserve() notifies the PCI core that a PCI device should be
+ * preserved across the next Live Update. Drivers must call
+ * pci_liveupdate_preserve() from their struct liveupdate_file_handler
+ * preserve() callback to ensure the outgoing struct pci_ser is allocated.
+ *
+ * Returns: 0 on success, <0 on failure.
+ */
+int pci_liveupdate_preserve(struct pci_dev *dev)
+{
+	struct pci_flb_outgoing *outgoing = NULL;
+	struct pci_ser *ser;
+	int i, ret;
+
+	if (dev->is_virtfn)
+		return -EINVAL;
+
+	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&outgoing);
+	if (ret)
+		return ret;
+
+	if (!outgoing)
+		return -ENOENT;
+
+	guard(mutex)(&outgoing->lock);
+	ser = outgoing->ser;
+
+	guard(write_lock)(&dev->liveupdate.lock);
+
+	if (dev->liveupdate.outgoing)
+		return -EBUSY;
+
+	if (ser->nr_devices == ser->max_nr_devices)
+		return -ENOSPC;
+
+	for (i = 0; i < ser->max_nr_devices; i++) {
+		/*
+		 * Start searching at index ser->nr_devices. This should result
+		 * in a constant time search under expected conditions (devices
+		 * are not getting unpreserved).
+		 */
+		int index = (ser->nr_devices + i) % ser->max_nr_devices;
+		struct pci_dev_ser *dev_ser = &ser->devices[index];
+
+		if (dev_ser->refcount)
+			continue;
+
+		pci_info(dev, "Device will be preserved across next Live Update\n");
+		ser->nr_devices++;
+
+		dev_ser->domain = pci_domain_nr(dev->bus);
+		dev_ser->bdf = pci_dev_id(dev);
+		dev_ser->refcount = 1;
+
+		dev->liveupdate.outgoing = dev_ser;
+		return 0;
+	}
+
+	return -ENOSPC;
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
+
+/**
+ * pci_liveupdate_unpreserve() - Cancel preservation of a PCI device
+ * @dev: The PCI device to preserve.
+ *
+ * pci_liveupdate_unpreserve() notifies the PCI core that a PCI device should no
+ * longer be preserved across the next Live Update. Drivers must call
+ * pci_liveupdate_unpreserve() from their struct liveupdate_file_handler
+ * unpreserve() callback to ensure the outgoing struct pci_ser is allocated.
+ */
+void pci_liveupdate_unpreserve(struct pci_dev *dev)
+{
+	struct pci_flb_outgoing *outgoing = NULL;
+	struct pci_dev_ser *dev_ser;
+	struct pci_ser *ser;
+	int ret;
+
+	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&outgoing);
+
+	if (ret || !outgoing) {
+		pci_warn(dev, "Cannot unpreserve device without outgoing Live Update state\n");
+		return;
+	}
+
+	guard(mutex)(&outgoing->lock);
+	ser = outgoing->ser;
+
+	guard(write_lock)(&dev->liveupdate.lock);
+
+	dev_ser = dev->liveupdate.outgoing;
+	if (!dev_ser) {
+		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
+		return;
+	}
+
+	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
+	ser->nr_devices--;
+	memset(dev_ser, 0, sizeof(*dev_ser));
+	dev->liveupdate.outgoing = NULL;
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
+
 /**
  * pci_liveupdate_register_flb() - Register a file handler with the PCI core
  * @fh: The file handler to register.
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b63cd0c310bc..54ae32cb0000 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2522,6 +2522,9 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 	spin_lock_init(&dev->pcie_cap_lock);
 #ifdef CONFIG_PCI_MSI
 	raw_spin_lock_init(&dev->msi_lock);
+#endif
+#ifdef CONFIG_PCI_LIVEUPDATE
+	rwlock_init(&dev->liveupdate.lock);
 #endif
 	return dev;
 }
diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
index 6ebcf817fff4..807fe0e6538f 100644
--- a/include/linux/kho/abi/pci.h
+++ b/include/linux/kho/abi/pci.h
@@ -23,19 +23,22 @@
  * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE string.
  */
 
-#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
+#define PCI_LUO_FLB_COMPATIBLE "pci-v2"
 
 /**
  * struct pci_dev_ser - Serialized state about a single PCI device.
  *
  * @domain: The device's PCI domain number (segment).
  * @bdf: The device's PCI bus, device, and function number.
- * @padding: Padding to naturally align struct pci_dev_ser.
+ * @refcount: Reference count used by the PCI core to keep track of whether it
+ *            is done using a device's struct pci_dev_ser. The value of the
+ *            refcount is equal to the number of devices preserved at or below
+ *            this device in the PCI hierarchy.
  */
 struct pci_dev_ser {
 	u32 domain;
 	u16 bdf;
-	u16 padding;
+	u16 refcount;
 } __packed;
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8cadeeab86fd..a7c3722b1e77 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -594,6 +594,9 @@ struct pci_dev {
 	u8		tph_mode;	/* TPH mode */
 	u8		tph_req_type;	/* TPH requester type */
 #endif
+#ifdef CONFIG_PCI_LIVEUPDATE
+	struct pci_liveupdate liveupdate;
+#endif
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
index 8ec98beefcb4..0803d44becd5 100644
--- a/include/linux/pci_liveupdate.h
+++ b/include/linux/pci_liveupdate.h
@@ -8,14 +8,28 @@
 #ifndef LINUX_PCI_LIVEUPDATE_H
 #define LINUX_PCI_LIVEUPDATE_H
 
+#include <linux/kho/abi/pci.h>
 #include <linux/liveupdate.h>
 #include <linux/types.h>
+#include <linux/spinlock_types.h>
+
+/**
+ * struct pci_liveupdate - PCI Live Update state for a struct pci_dev
+ * @lock: Lock used to protect members of struct pci_liveupdate.
+ * @outgoing: State preserved for the next kernel.
+ */
+struct pci_liveupdate {
+	rwlock_t lock;
+	struct pci_dev_ser *outgoing;
+};
 
 struct pci_dev;
 
 #ifdef CONFIG_PCI_LIVEUPDATE
 int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh);
 void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh);
+int pci_liveupdate_preserve(struct pci_dev *dev);
+void pci_liveupdate_unpreserve(struct pci_dev *dev);
 #else
 static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
 {
@@ -25,6 +39,15 @@ static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh
 static inline void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh)
 {
 }
+
+static inline int pci_liveupdate_preserve(struct pci_dev *dev)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void pci_liveupdate_unpreserve(struct pci_dev *dev)
+{
+}
 #endif
 
 #endif /* LINUX_PCI_LIVEUPDATE_H */
-- 
2.54.0.563.g4f69b47b94-goog


