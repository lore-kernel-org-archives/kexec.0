Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B299C44506
	for <kexec@archiver.kernel.org>; Fri, 10 Jul 2026 21:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=57QfbJnRLtEgyk7xuyEyKOzrYVcCZwar9BStEh/xugM=; b=BEZKfS5fbgeAUD5CdG2BCt46wH
	TcNysDq8ybqPDJSMpmH05MI6JiBPtLB0VLPCFv7w/ZwszN3WpWAF2hxaMsEh6JtFJSbg+HLUzfP3r
	bAn2NqA21T3xfhbeAb0JJVaxSmEg1+eouMaW2GQIJYoDnjy/haRKKgXhLxqcvP50Md77hdFjLL2U7
	7RnZjU7ThsdSDPdv+QXFhId1SpMJ2ej3pKhPRShNtDVKairzXHlqBeJeiZnm+ueQs6Gk/n8f9YDcb
	qYEdmDq23Ux1gYVS5JJRRq1uKmhE02DqzEin5Qg64X8upIgzN4FYKyAZ8yZvjtdvW/CiK/59r2WbJ
	xc2+MuLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIjw-00000005pRQ-1CZN;
	Fri, 10 Jul 2026 21:26:32 +0000
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIjt-00000005pNn-2HIM
	for kexec@lists.infradead.org;
	Fri, 10 Jul 2026 21:26:30 +0000
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-84865f326efso1439935b3a.0
        for <kexec@lists.infradead.org>; Fri, 10 Jul 2026 14:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783718788; x=1784323588; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=57QfbJnRLtEgyk7xuyEyKOzrYVcCZwar9BStEh/xugM=;
        b=fMQgAG5w++WMFqq/uUUlU8HPOgKFDq/6pMdWVVYlBZ968hhPMZvUyOLV44HooJ4XW+
         kY0l9MbNHtt5JSaLLglfiR27U6l+BkbcJ3/D0O4SFYDb60ai5Vr8B4gC6ZuzV/TlZ1bE
         UBTdkAhtMU6V9yTzNysbHJlN1RK7dfwTtV1pbvIvHhsTcDNbhQY/XYl4Uop61UrlSiaG
         y0hFd48O8S3pThsmAKOnNKQTrRzOVfDLLNUSU3RuJeRMN5GJRFO/+GaawN1zfJGNk/UH
         iDvIPuqTAzyMmj8HrI9t28bWLr+E+fuBYgKkrrK0wSzWR3yMKq39xzGdy7XJNWMDdCdD
         sGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718788; x=1784323588;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=57QfbJnRLtEgyk7xuyEyKOzrYVcCZwar9BStEh/xugM=;
        b=LJYdfXW7Q5ZZJMx3bF6Vj5taf+RgGhBRUpBqljo/GNqy1mAWkP9u2CTjHDmqaLXlXD
         e2jCEtSCkQ+7lyJwPvkR+JTUD2eYIxpvH/Ufgoy0TWvDDB0uYUXE0bz81K9qjFAUwal5
         B7PNNA0wV/dDU+TQN3NiECe2+ojlebT9/DLJTRvGeXuZMCVP0OwwODyFUdbp6eopzeyB
         FoGgixoAXzHtM8gSR/qlhbY+a+u4leyOgjBvj3T8iRfDbW3WRjdVSc2gR57Kyk1M8Zws
         RfQnPanyZaU+isjmFikvEf2X2XMzgpWxmR62eN1Imbb4ENHPUe982U1/eaxMNOAxtzMT
         6Jnw==
X-Gm-Message-State: AOJu0Yz6xyvJRrjo9Ny3AfZnF67QA3dKncBx7vCErWYosuDqg/MEB/mh
	2pItm8tPuOyZdXT7nw6ui5iL0UO9O8guPMpVGpmAslPWOohMl6hp+2+ztDq00sQny5Z/7m9DCVC
	U5YfghYjIr99Lq8huBjAwo6nIPyn1AgTOzcwqzntcxjkYgmOapGxboR/iCm/0NiKcLfF+VmSa9k
	YxD8QUvt9zE1dXQMDo31hQanaPdcsK0ZCZOEJvuYnFo4QciHTfcSs=
X-Received: from pfbhm2.prod.google.com ([2002:a05:6a00:6702:b0:847:9cc9:a40d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:450f:b0:848:2f71:b65b with SMTP id d2e1a72fcca58-848897d5cc1mr570948b3a.70.1783718788088;
 Fri, 10 Jul 2026 14:26:28 -0700 (PDT)
Date: Fri, 10 Jul 2026 21:26:09 +0000
In-Reply-To: <20260710212616.1351130-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710212616.1351130-7-dmatlack@google.com>
Subject: [PATCH v7 06/12] PCI: liveupdate: Auto-preserve upstream bridges
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
X-CRM114-CacheID: sfid-20260710_142629_594724_FAA13DE1 
X-CRM114-Status: GOOD (  24.94  )
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

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c    | 136 +++++++++++++++++++++++++++++++-----
 include/linux/kho/abi/pci.h |   5 +-
 2 files changed, 122 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index b2b950d71657..7f7710cb1da0 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -101,6 +101,18 @@
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
 
 #define pr_fmt(fmt) "PCI: " KBUILD_BASENAME ": " fmt
@@ -316,28 +328,52 @@ static struct pci_dev_ser *pci_get_empty_or_append(struct pci_flb_outgoing *outg
 	return dev_ser;
 }
 
-static void pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing, struct pci_dev *dev)
+static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing, struct pci_dev *dev)
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
 }
 
-static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing, struct pci_dev *dev)
+static int pci_liveupdate_preserve_device_again(struct pci_dev *dev)
 {
-	struct pci_dev_ser *dev_ser;
+	if (!dev->liveupdate.outgoing->refcount) {
+		pci_WARN(dev, 1, "Preserved device with 0 refcount!\n");
+		return -EINVAL;
+	}
 
-	if (dev->liveupdate.outgoing)
+	/*
+	 * Endpoint devices should not be preserved more than once. Bridges are
+	 * preserved once for every downstream device that is preserved.
+	 */
+	if (!dev->subordinate)
 		return -EBUSY;
 
+	dev->liveupdate.outgoing->refcount++;
+	return 0;
+}
+
+static int __pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing, struct pci_dev *dev)
+{
+	struct pci_dev_ser *dev_ser;
+
 	dev_ser = pci_get_empty_or_append(outgoing);
 	if (IS_ERR(dev_ser))
 		return PTR_ERR(dev_ser);
@@ -354,6 +390,52 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing, str
 	return 0;
 }
 
+static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing, struct pci_dev *dev)
+{
+	if (dev->liveupdate.outgoing)
+		return pci_liveupdate_preserve_device_again(dev);
+
+	return __pci_liveupdate_preserve_device(outgoing, dev);
+}
+
+#define for_each_pci_dev_in_path(_d, _start, _end) \
+	for ((_d) = (_start); (_d) != (_end); (_d) = (_d)->bus->self)
+
+static void __pci_liveupdate_unpreserve_path(struct pci_flb_outgoing *outgoing,
+					     struct pci_dev *start,
+					     struct pci_dev *end)
+{
+	struct pci_dev *dev;
+
+	for_each_pci_dev_in_path(dev, start, end) {
+		if (pci_liveupdate_unpreserve_device(outgoing, dev))
+			return;
+	}
+}
+
+static void pci_liveupdate_unpreserve_path(struct pci_flb_outgoing *outgoing,
+					   struct pci_dev *start)
+{
+	__pci_liveupdate_unpreserve_path(outgoing, start, /*end=*/NULL);
+}
+
+static int pci_liveupdate_preserve_path(struct pci_flb_outgoing *outgoing,
+					struct pci_dev *start)
+{
+	struct pci_dev *dev;
+	int ret;
+
+	for_each_pci_dev_in_path(dev, start, NULL) {
+		ret = pci_liveupdate_preserve_device(outgoing, dev);
+		if (ret) {
+			__pci_liveupdate_unpreserve_path(outgoing, start, dev);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * pci_liveupdate_preserve() - Preserve a PCI device across Live Update
  * @dev: The PCI device to preserve.
@@ -363,6 +445,9 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing, str
  * pci_liveupdate_preserve() from their struct liveupdate_file_handler
  * preserve() callback to ensure the outgoing struct pci_ser is already set up.
  *
+ * pci_liveupdate_preserve() automatically preserves all bridges upstream of
+ * @dev.
+ *
  * Returns: 0 on success, <0 on failure.
  */
 int pci_liveupdate_preserve(struct pci_dev *dev)
@@ -378,7 +463,7 @@ int pci_liveupdate_preserve(struct pci_dev *dev)
 	if (IS_ERR(outgoing))
 		return PTR_ERR(outgoing);
 
-	return pci_liveupdate_preserve_device(outgoing, dev);
+	return pci_liveupdate_preserve_path(outgoing, dev);
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
 
@@ -391,6 +476,9 @@ EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
  * pci_liveupdate_unpreserve() from their struct liveupdate_file_handler
  * unpreserve() callback to ensure the outgoing struct pci_ser is already set
  * up.
+ *
+ * pci_liveupdate_unpreserve() automatically unpreserves all bridges upstream of
+ * @dev.
  */
 void pci_liveupdate_unpreserve(struct pci_dev *dev)
 {
@@ -404,7 +492,7 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
 		return;
 	}
 
-	pci_liveupdate_unpreserve_device(outgoing, dev);
+	pci_liveupdate_unpreserve_path(outgoing, dev);
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
 
@@ -594,29 +682,41 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 	}
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
 	pci_liveupdate_flb_put_incoming();
+	return 0;
+}
+
+static void pci_liveupdate_finish_path(struct pci_ser *ser, struct pci_dev *start)
+{
+	struct pci_dev *dev;
+
+	for_each_pci_dev_in_path(dev, start, NULL) {
+		if (pci_liveupdate_finish_device(ser, dev))
+			return;
+	}
 }
 
 /**
@@ -628,6 +728,8 @@ static void pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *de
  * Update. Drivers must call pci_liveupdate_finish() from their struct
  * liveupdate_file_handler finish() callback to ensure the incoming struct
  * pci_ser is allocated.
+ *
+ * pci_liveupdate_finish() automatically finishes all bridges upstream of @dev.
  */
 void pci_liveupdate_finish(struct pci_dev *dev)
 {
@@ -641,7 +743,7 @@ void pci_liveupdate_finish(struct pci_dev *dev)
 		return;
 	}
 
-	pci_liveupdate_finish_device(incoming->ser, dev);
+	pci_liveupdate_finish_path(incoming->ser, dev);
 	pci_liveupdate_flb_put_incoming();
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_finish);
diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
index de549016807a..acf1b38dff02 100644
--- a/include/linux/kho/abi/pci.h
+++ b/include/linux/kho/abi/pci.h
@@ -23,7 +23,7 @@
  * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE string.
  */
 
-#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
+#define PCI_LUO_FLB_COMPATIBLE "pci-v2"
 
 /**
  * struct pci_dev_ser - Serialized state about a single PCI device.
@@ -32,7 +32,8 @@
  * @bdf: The device's PCI bus, device, and function number.
  * @refcount: Reference count used by the PCI core to keep track of whether it
  *            is done using a device's struct pci_dev_ser. The value of the
- *            refcount is equal to 1 when the struct pci_dev_ser is in use, and
+ *            refcount is equal to the number of preserved devices at or below
+ *            it in the PCI hierarchy when the struct pci_dev_ser is in use, and
  *            0 otherwise.
  */
 struct pci_dev_ser {
-- 
2.55.0.795.g602f6c329a-goog


