Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4894CC54F52
	for <kexec@archiver.kernel.org>; Tue, 28 Jul 2026 22:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bjiHFRrRxhVwa1Pq0hgmaBBv7pUGh9bn9sVXjLyQZnI=; b=ybhI9CYigZUVd3tYTkLYL/zgip
	NfVUQVipQaHMzu1vkG2uap2bJFuXyXpK5B7+kFDpsqO3NGgaIFPdso2RgccenLFgq4IsZ1nNI0v9I
	x328iAetXIhUSB/GzfE7W0Pz9e+r03hxxwuapPiRym1OGW9MGdpUBznY6QR3LuhGK+eBk1+dEsk3S
	1zuEqSWVvZzdH9DKRr2piEEsmpd/KsFRGMXQcAbUpbLeGKZsJWLfiT/FYpd2tgR+MAqiLDbDvpnyb
	MeGpHfoh7A28ly/bTS8PIgxdIN+Nrd2Oy7xo9ad+vCvYCJEZAZslbjUSl8EYn56WHEgQK0JxV6J/K
	rQeOlCvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woq0Q-00000006NxI-11zs;
	Tue, 28 Jul 2026 22:10:34 +0000
Received: from mail-pf1-x448.google.com ([2607:f8b0:4864:20::448])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woq0K-00000006Nqh-0xwE
	for kexec@lists.infradead.org;
	Tue, 28 Jul 2026 22:10:30 +0000
Received: by mail-pf1-x448.google.com with SMTP id d2e1a72fcca58-8486c3411c8so374825b3a.2
        for <kexec@lists.infradead.org>; Tue, 28 Jul 2026 15:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785276626; x=1785881426; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bjiHFRrRxhVwa1Pq0hgmaBBv7pUGh9bn9sVXjLyQZnI=;
        b=LAZlqmfHl6PhqQQcVwQ6R+dy0TRfX8fe+7iob/MVsHrf/2Sqag0IDx72kBOzNM9JWm
         vQ7kqaNiThjHnjs4+j7zJkAxUtqsobh6F+WhCJ/I3yNnlcXQW+mbU3DpkE0j3CLl3bZe
         529I93TfDQUasM2AHBP+o/30PUFq6QULGyjGmcRJv6Dc2s0MrAApHiMcUF1zEx9eREle
         Ggx6Hue/W1qSVnARkGX9UjOwQNLY/d66+sjh/GWpY2/U1avkwe9yrxRvyvp2NA7AXbX2
         kYnqRlVW4Rsev6P3SkKg7V63VoC8vMXh8OnbRe3lXk/zbO/iHlQrloV6vkRG0Gn4FTAR
         LLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785276626; x=1785881426;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bjiHFRrRxhVwa1Pq0hgmaBBv7pUGh9bn9sVXjLyQZnI=;
        b=F2nPcKWc9ZvPzyXbvTvwvEqKpzE+rFLVBe4fn6tq27e7Y8OMpkHX3uJWfM2I3oCQjp
         ZEpo5J7oJ4SKdxOgeTBMu2+oa7mHmt4hee5gwtKP8XtRYVjLwHr423ZGBMr+3tAi7A85
         ERvjWuKsW34WQMSE4V14huAnynSMWSDwg15Glk4aBwLCHaDi8MjikSJb9TrVVzETjjco
         yYBOIPd4u8ipGsMghItchVIzT9UeBj5ozgDvH7R7ZN/vqGwan0+sj/2trgj3tzvxd+no
         Q356rKIR1vwfOXPnfYGoweGwpWz/QV0PxbIf+IdrDZksBfrrfX4BvuqX3lxAY9KB6Xqz
         NA4w==
X-Gm-Message-State: AOJu0YyQ2itq6nriNpqK37kMCrIEf/P13svoTPwouxMRS34Mz4H7Pxv8
	Pae2n93WsbJirXjjNuNWK5gvaxlQ9WrRyiJklx4cJTxd8dw8M+mqG6mophmY4toazpSWwLdoyaU
	P2dSdDfEa3nqcidHS4g4nUPDNKQuKZDjl4NCFBlsoazrzhy2UN3VeiFHrm+s7eT+mz/X+afVzK1
	kXtMNT5ebA/Zn+CmApbkfwU098/thrFqt17QybDy5PFKbOmwNYQos=
X-Received: from pfhx33.prod.google.com ([2002:a05:6a00:18a1:b0:848:4f56:7671])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3a23:b0:84a:2fc1:da38 with SMTP id d2e1a72fcca58-84e933d61dbmr4308330b3a.58.1785276625807;
 Tue, 28 Jul 2026 15:10:25 -0700 (PDT)
Date: Tue, 28 Jul 2026 22:10:00 +0000
In-Reply-To: <20260728221007.2098560-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260728221007.2098560-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728221007.2098560-7-dmatlack@google.com>
Subject: [PATCH v8 06/12] PCI: liveupdate: Auto-preserve upstream bridges
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
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_151028_432655_F854C12A 
X-CRM114-Status: GOOD (  27.71  )
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
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c    | 110 ++++++++++++++++++++++++++++--------
 include/linux/kho/abi/pci.h |   5 +-
 include/linux/pci.h         |   3 +
 3 files changed, 93 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index d312381c9e10..08e5ff8c1fe7 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -70,7 +70,6 @@
  * preserved. These may be relaxed in the future:
  *
  *  * The device cannot be a Virtual Function (VF).
- *  * The device cannot be behind a PCI-to-PCI bridge.
  *
  * Driver Binding
  * ==============
@@ -102,6 +101,18 @@
  * If a misconfigured or unconfigured bridge is encountered during enumeration
  * while there are preserved devices, its secondary and subordinate bus numbers
  * will be cleared and devices below it will not be enumerated.
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
@@ -358,20 +369,42 @@ static struct pci_dev_ser *pci_flb_alloc_dev_ser(struct pci_flb_outgoing *outgoi
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
+	}
+
+	if (!dev_ser->refcount) {
+		pci_WARN(dev, 1, "Preserved device has a 0 refcount!\n");
+		return -EINVAL;
 	}
 
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
@@ -385,13 +418,23 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
 	}
 
 	if (dev->liveupdate.outgoing) {
-		pci_warn(dev, "Device is already preserved\n");
-		return -EBUSY;
-	}
+		if (!dev->liveupdate.outgoing->refcount) {
+			pci_WARN(dev, 1, "Preserved device with 0 refcount!\n");
+			return -EINVAL;
+		}
 
-	if (!pci_is_root_bus(dev->bus)) {
-		pci_warn(dev, "Cannot preserve devices behind bridges\n");
-		return -EINVAL;
+		/*
+		 * Endpoint devices should not be preserved more than once.
+		 * Bridges are preserved once for every downstream device that
+		 * is preserved.
+		 */
+		if (!dev->subordinate) {
+			pci_warn(dev, "Device is already preserved\n");
+			return -EBUSY;
+		}
+
+		dev->liveupdate.outgoing->refcount++;
+		return 0;
 	}
 
 	dev_ser = pci_flb_alloc_dev_ser(outgoing);
@@ -419,12 +462,16 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
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
 
@@ -432,7 +479,13 @@ int pci_liveupdate_preserve(struct pci_dev *dev)
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
@@ -448,6 +501,9 @@ EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
  * pci_liveupdate_unpreserve() from their struct liveupdate_file_handler
  * unpreserve() callback to ensure the outgoing struct pci_ser is already set
  * up.
+ *
+ * pci_liveupdate_unpreserve() automatically unpreserves all bridges upstream of
+ * @dev.
  */
 void pci_liveupdate_unpreserve(struct pci_dev *dev)
 {
@@ -461,7 +517,7 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
 		return;
 	}
 
-	pci_liveupdate_unpreserve_device(outgoing, dev);
+	pci_liveupdate_unpreserve_path(outgoing, dev, /*end=*/NULL);
 	pci_liveupdate_flb_put_outgoing();
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
@@ -631,28 +687,30 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
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
@@ -664,6 +722,8 @@ static void pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *de
  * Update. Drivers must call pci_liveupdate_finish() from their struct
  * liveupdate_file_handler finish() callback to ensure the incoming struct
  * pci_ser is allocated.
+ *
+ * pci_liveupdate_finish() automatically finishes all bridges upstream of @dev.
  */
 void pci_liveupdate_finish(struct pci_dev *dev)
 {
@@ -677,7 +737,11 @@ void pci_liveupdate_finish(struct pci_dev *dev)
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
diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
index d4881c2d2fc9..aecace02d8ac 100644
--- a/include/linux/kho/abi/pci.h
+++ b/include/linux/kho/abi/pci.h
@@ -24,7 +24,7 @@
  */
 
 #define PCI_LUO_FLB_COMPATIBLE "pci"
-#define PCI_LUO_FLB_VERSION 1
+#define PCI_LUO_FLB_VERSION 2
 
 /**
  * struct pci_dev_ser - Serialized state about a single PCI device.
@@ -33,7 +33,8 @@
  * @bdf: The device's PCI bus, device, and function number.
  * @refcount: Reference count used by the PCI core to keep track of whether it
  *            is done using a device's struct pci_dev_ser. The value of the
- *            refcount is equal to 1 when the struct pci_dev_ser is in use, and
+ *            refcount is equal to the number of preserved devices at or below
+ *            it in the PCI hierarchy when the struct pci_dev_ser is in use, and
  *            0 otherwise.
  */
 struct pci_dev_ser {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b41dd572a2d6..6267c83813d5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -829,6 +829,9 @@ static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
 	return dev->bus->self;
 }
 
+#define for_each_pci_dev_in_path(dev) \
+	for (; dev; dev = pci_upstream_bridge(dev))
+
 #ifdef CONFIG_PCI_MSI
 static inline bool pci_dev_msi_enabled(struct pci_dev *pci_dev)
 {
-- 
2.55.0.487.gaf234c4eb3-goog


