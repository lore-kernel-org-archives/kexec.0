Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8C3CC6B1A
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 16:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fNADI9rSGSIXIntWZRaMsSHiModR/dpkujIQp/j5Buc=; b=NzanOD6zhdKUZ5wk2r88wnTzHk
	2AnlN/tb8+pIha43hEvvqf3SBRWqrknMa7Z87HWEf01oZG5e6tF/+mSjcpk05269eZ+JqIaQrrsVb
	79Og6hQJZDOBYAXGvppuPxeHkL962zW/b5mpTIiz+cphkv6g5c+aiaril9mO8b+lHZUN5VIM/pWkq
	jyp9+bX7R3JnT4xzLBQY36WXryA+PhADLo1sxiOaZbIJj3CZwTSJffyzFirVwkEnK32oGXr16tIhz
	im2ZA8ZQAg8z0INtTLmKP6ehz8i+AWw2Hyp2FRXyTyoCJ4weGdP3BCfay5JnypJgGn3M540+O6VJH
	iXK8FP9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfK0-0000000DUin-2pzV;
	Tue, 13 Oct 2026 16:25:48 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfJw-0000000DUdQ-2WbW
	for kexec@bombadil.infradead.org;
	Tue, 13 Oct 2026 16:25:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fNADI9rSGSIXIntWZRaMsSHiModR/dpkujIQp/j5Buc=; b=Ytyu6uTY88XKi9bIHgWgvIoySG
	qHoqahWfaVLIjCsoO6Y41qXvNg5SitSSZYIwBRy+0bO3Jgkw45i7iucIwzdwZNqlxJuU1TTKvGCBT
	l90JmyKHg/ImyRGGT83rzjlWfnLjTgFh8hzgof02PY89WikXidzqvPCZmtmPLpgWD/DHBcoMOqJUf
	I4bKbi84f2pNAcN80RxQi/nBVFDxD9vHcI6o+ZoJsRWsFeBfPKGMepxJfMhMowC9IxrAI869NvbbM
	R85/ApI1HBV5rM9DTN5owWxdZWGClRpT0ATm8agJVhnksDGG7AxCC3LBy0CTVZ0pAFeaU850Dmj8o
	Od7OZKKA==;
Received: from mail-pl1-x648.google.com ([2607:f8b0:4864:20::648])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGfJs-0000000FmGx-0Hyo
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 16:25:43 +0000
Received: by mail-pl1-x648.google.com with SMTP id d9443c01a7336-2e651510a5dso27150485ad.1
        for <kexec@lists.infradead.org>; Tue, 13 Oct 2026 09:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791908737; x=1792513537; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fNADI9rSGSIXIntWZRaMsSHiModR/dpkujIQp/j5Buc=;
        b=q6oBsKeVLbWkFJOreouN2FbtAw7ftqT7XXj7OsBvGaOxCUFc1tAujQBaqEJzAjVG1h
         gH43tF0HcNsz1tHLzFz2fiayJThfN9jflI0i2vF4ynjYfHN79h/wsJ2sMqrrpeRja5TJ
         hpzQnRWUc4eJHXdF8FIhGpw7FbZ5Z8WjQ2TSgZ9RWZAe0kIUr8efkZdfoMZYaViTJ2+L
         BzzYvYJYHNsGn8iajBLwVGMJ5+d39IZincMJaKkgEvgdWDLP9jB3drnX/kVGxHg/T+Zo
         D5RF+GKl4nWQTJTlTCfyJG9a/fzbrKXPYVzW1ouj/FOfdSphQ+/pfFG7IuhPmH3FxeSD
         eT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791908737; x=1792513537;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fNADI9rSGSIXIntWZRaMsSHiModR/dpkujIQp/j5Buc=;
        b=xrVaQMX/jLjnlM704RlftapLwrA+EPQxKhRdsIGLGUUlOHfcz9NscMR0JTFGMVM+3q
         szycfvWMjNn8g4F+kGr3igx6I6giHP1NzWoMSu/ZDTGmHaskFifo3erWarbaAVd7/7EX
         V8VB+C+BRsep2Dvif7Dr3h2Fw/UEzIrTxKnadz1W7lvEQZGD4/qaDp1wMVFWcIguONkl
         7Ce6YPqoRtSWp7AmcxVIFG1FYFzg/CJIKoe6hDZ/5tdho4d2drPeLou/mJx/ywbPxVtj
         hS+CzTXpW5e3lL6LztbefMCmFj2/xC/KhsliTeFpnKsTXunsLI3iVHuo72nXUmzMrcXm
         E/4A==
X-Gm-Message-State: AFq9FYJ66zczfi9g1xyhBClN30M35AeiQ9O2jAB9acceZcuBFVUyOA8l
	Ge22iN/4KTjYKF7eefrZ4Z9YIUOKWS2h4l5/j63toGT4LDtktj16YJeKtpgZaEF5WC5OOZEFDVa
	rdbXJqTYfSt3kTogvIcPIxuXXjCc0tkxjcEUo20JMWUXPEuKqSwI+6d3P/1ytVLSMC+SvzK88Cb
	e4sGhg4tur05DSKhk27KOF79xMLrurri1FwjG7sXd01lNHPKqyGno=
X-Received: from pgbbq21.prod.google.com ([2002:a05:6a02:455:b0:cc7:d0a5:4738])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e54a:b0:2e6:dbf:c4a8 with SMTP id d9443c01a7336-2e842ab60d3mr118783575ad.12.1791908736252;
 Tue, 13 Oct 2026 09:25:36 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:25:18 +0000
In-Reply-To: <20261013162529.1928093-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20261013162529.1928093-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013162529.1928093-3-dmatlack@google.com>
Subject: [PATCH v10 02/13] PCI: liveupdate: Track outgoing preserved PCI devices
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
X-CRM114-CacheID: sfid-20261013_172540_269526_4E42DDDF 
X-CRM114-Status: GOOD (  32.70  )
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
need special handling during shutdown and kexec, and so the list of
preserved devices can be handed off to the next kernel.

For now, the API only supports preserving non-VF devices on a root bus
(not behind an PCI-to-PCI bridges).

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c       | 211 +++++++++++++++++++++++++++++++++
 drivers/pci/liveupdate.h       |  21 ++++
 drivers/pci/probe.c            |   2 +
 include/linux/pci.h            |   3 +
 include/linux/pci_liveupdate.h |  21 ++++
 5 files changed, 258 insertions(+)
 create mode 100644 drivers/pci/liveupdate.h

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 5f065dccbd7b..22d5d177e104 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -59,6 +59,7 @@
  *       luo_flb_file_preserve_one()      # first preserved file only
  *         pci_flb_preserve()             # alloc and preserve struct pci_ser
  *     fh->ops->preserve()                # driver callback
+ *       pci_liveupdate_preserve(dev)     # record this device in struct pci_ser
  *
  *   # Userspace: preservation cancelled or session torn down
  *   luo_file_unpreserve_files()
@@ -79,6 +80,27 @@
  *     luo_flb_file_finish()
  *       liveupdate_flb_put_incoming()    # last incoming file only
  *         pci_flb_finish()               # free struct pci_ser
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
+ *  * The device cannot be behind a PCI-to-PCI bridge.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -93,6 +115,21 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 
+#include "liveupdate.h"
+
+/**
+ * struct pci_liveupdate_global - Global state for PCI Live Update support
+ * @rwsem: Reader/writer semaphore used to protect the incoming and outgoing
+ *         FLBs, and the references to them in struct pci_dev.
+ */
+struct pci_liveupdate_global {
+	struct rw_semaphore rwsem;
+};
+
+static struct pci_liveupdate_global pci_liveupdate = {
+	.rwsem = __RWSEM_INITIALIZER(pci_liveupdate.rwsem),
+};
+
 /**
  * struct pci_flb_outgoing - Outgoing PCI FLB object
  * @ser: Pointer to the preserved struct pci_ser.
@@ -173,6 +210,180 @@ static struct liveupdate_flb pci_liveupdate_flb = {
 	.compatible = PCI_LUO_FLB_COMPATIBLE,
 };
 
+static void pci_liveupdate_flb_put_outgoing(void)
+{
+	liveupdate_flb_put_outgoing(&pci_liveupdate_flb);
+}
+
+static struct pci_flb_outgoing *pci_liveupdate_flb_get_outgoing(void)
+{
+	struct pci_flb_outgoing *outgoing = NULL;
+	int ret;
+
+	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&outgoing);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (!outgoing)
+		return ERR_PTR(-ENOENT);
+
+	return outgoing;
+}
+
+static struct pci_dev_ser *pci_flb_alloc_dev_ser(struct pci_flb_outgoing *outgoing)
+{
+	struct pci_dev_ser *dev_ser;
+	struct kho_block_set_it it;
+	u64 count = 0;
+	int err;
+
+	kho_block_set_it_init(&it, &outgoing->block_set);
+
+	/* Try to find an existing, previously unpreserved, entry. */
+	while ((dev_ser = kho_block_set_it_read_entry(&it))) {
+		if (!dev_ser->refcount)
+			return dev_ser;
+
+		count++;
+	}
+
+	/* Otherwise grow the block set and reserve a new entry. */
+	err = kho_block_set_grow(&outgoing->block_set, count + 1);
+	if (err)
+		return ERR_PTR(err);
+
+	if (!count)
+		kho_block_set_it_init(&it, &outgoing->block_set);
+
+	/* This should always succeed since kho_block_set_grow() succeeded. */
+	dev_ser = kho_block_set_it_reserve_entry(&it);
+	if (WARN_ON_ONCE(!dev_ser))
+		return ERR_PTR(-ENOSPC);
+
+	return dev_ser;
+}
+
+static void pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
+					     struct pci_dev *dev)
+{
+	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
+
+	if (!dev_ser) {
+		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
+		return;
+	}
+
+	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
+	outgoing->ser->nr_devices--;
+	memset(dev_ser, 0, sizeof(*dev_ser));
+	dev->liveupdate.outgoing = NULL;
+}
+
+static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
+					  struct pci_dev *dev)
+{
+	struct pci_dev_ser *dev_ser;
+
+	if (dev->is_virtfn) {
+		pci_warn(dev, "Cannot preserve Virtual Functions\n");
+		return -EINVAL;
+	}
+
+	if (dev->liveupdate.outgoing) {
+		pci_warn(dev, "Device is already preserved\n");
+		return -EBUSY;
+	}
+
+	if (!pci_is_root_bus(dev->bus)) {
+		pci_warn(dev, "Cannot preserve devices behind bridges\n");
+		return -EINVAL;
+	}
+
+	dev_ser = pci_flb_alloc_dev_ser(outgoing);
+	if (IS_ERR(dev_ser))
+		return PTR_ERR(dev_ser);
+
+	pci_info(dev, "Device will be preserved across next Live Update\n");
+	outgoing->ser->nr_devices++;
+	outgoing->ser->devices = kho_block_set_head_pa(&outgoing->block_set);
+
+	dev_ser->domain = pci_domain_nr(dev->bus);
+	dev_ser->bdf = pci_dev_id(dev);
+	dev_ser->refcount++;
+
+	dev->liveupdate.outgoing = dev_ser;
+	return 0;
+}
+
+/**
+ * pci_liveupdate_preserve() - Preserve a PCI device across Live Update
+ * @dev: The PCI device to preserve.
+ *
+ * pci_liveupdate_preserve() notifies the PCI core that a PCI device should be
+ * preserved across the next Live Update. Drivers are expected to call
+ * pci_liveupdate_preserve() from their struct liveupdate_file_handler
+ * preserve() callback to ensure the outgoing struct pci_ser is already set up.
+ *
+ * Returns: 0 on success, <0 on failure.
+ */
+int pci_liveupdate_preserve(struct pci_dev *dev)
+{
+	struct pci_flb_outgoing *outgoing = NULL;
+	int ret;
+
+	guard(rwsem_write)(&pci_liveupdate.rwsem);
+
+	outgoing = pci_liveupdate_flb_get_outgoing();
+	if (IS_ERR(outgoing))
+		return PTR_ERR(outgoing);
+
+	ret = pci_liveupdate_preserve_device(outgoing, dev);
+
+	pci_liveupdate_flb_put_outgoing();
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
+
+/**
+ * pci_liveupdate_unpreserve() - Cancel preservation of a PCI device
+ * @dev: The PCI device to unpreserve.
+ *
+ * pci_liveupdate_unpreserve() notifies the PCI core that a PCI device should no
+ * longer be preserved across the next Live Update. Drivers are expected to call
+ * pci_liveupdate_unpreserve() from their struct liveupdate_file_handler
+ * unpreserve() callback to ensure the outgoing struct pci_ser is already set
+ * up.
+ */
+void pci_liveupdate_unpreserve(struct pci_dev *dev)
+{
+	struct pci_flb_outgoing *outgoing = NULL;
+
+	guard(rwsem_write)(&pci_liveupdate.rwsem);
+
+	outgoing = pci_liveupdate_flb_get_outgoing();
+	if (IS_ERR(outgoing)) {
+		pci_warn(dev, "Cannot unpreserve device without outgoing Live Update state\n");
+		return;
+	}
+
+	pci_liveupdate_unpreserve_device(outgoing, dev);
+	pci_liveupdate_flb_put_outgoing();
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
+
+void pci_liveupdate_cleanup_device(struct pci_dev *dev)
+{
+	/*
+	 * It should be safe to READ_ONCE() outside of the rwsem during cleanup
+	 * since there should no longer be any references to @dev on the system.
+	 *
+	 * This should never happen in practice. Drivers should block removal
+	 * while a device is preserved.
+	 */
+	if (READ_ONCE(dev->liveupdate.outgoing))
+		pci_WARN(dev, 1, "Destroying outgoing-preserved device!\n");
+}
+
 /**
  * pci_liveupdate_register_flb() - Register a file handler with the PCI core
  * @fh: The file handler to register.
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
new file mode 100644
index 000000000000..b2335581f8d0
--- /dev/null
+++ b/drivers/pci/liveupdate.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCI Live Update support (core API)
+ *
+ * Copyright (c) 2026, Google LLC.
+ * David Matlack <dmatlack@google.com>
+ */
+#ifndef DRIVERS_PCI_LIVEUPDATE_H
+#define DRIVERS_PCI_LIVEUPDATE_H
+
+#include <linux/pci.h>
+
+#ifdef CONFIG_PCI_LIVEUPDATE
+void pci_liveupdate_cleanup_device(struct pci_dev *dev);
+#else
+static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
+{
+}
+#endif
+
+#endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5af..2a37e5d3e8e3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -24,6 +24,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/bitfield.h>
 #include <trace/events/pci.h>
+#include "liveupdate.h"
 #include "pci.h"
 
 static struct resource busn_resource = {
@@ -2485,6 +2486,7 @@ static void pci_release_dev(struct device *dev)
 
 	pci_dev = to_pci_dev(dev);
 	pci_release_capabilities(pci_dev);
+	pci_liveupdate_cleanup_device(pci_dev);
 	pci_release_of_node(pci_dev);
 	pcibios_release_device(pci_dev);
 	pci_bus_put(pci_dev->bus);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 95b723aecb08..76abe884e3dc 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -599,6 +599,9 @@ struct pci_dev {
 	u8		tph_mode;	/* TPH mode */
 	u8		tph_req_type;	/* TPH requester type */
 #endif
+#ifdef CONFIG_PCI_LIVEUPDATE
+	struct pci_liveupdate liveupdate;
+#endif
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
index 8ec98beefcb4..894052ad6961 100644
--- a/include/linux/pci_liveupdate.h
+++ b/include/linux/pci_liveupdate.h
@@ -8,14 +8,26 @@
 #ifndef LINUX_PCI_LIVEUPDATE_H
 #define LINUX_PCI_LIVEUPDATE_H
 
+#include <linux/kho/abi/pci.h>
 #include <linux/liveupdate.h>
+#include <linux/spinlock_types.h>
 #include <linux/types.h>
 
+/**
+ * struct pci_liveupdate - PCI Live Update state for a struct pci_dev
+ * @outgoing: State preserved for the next kernel.
+ */
+struct pci_liveupdate {
+	struct pci_dev_ser *outgoing;
+};
+
 struct pci_dev;
 
 #ifdef CONFIG_PCI_LIVEUPDATE
 int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh);
 void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh);
+int pci_liveupdate_preserve(struct pci_dev *dev);
+void pci_liveupdate_unpreserve(struct pci_dev *dev);
 #else
 static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
 {
@@ -25,6 +37,15 @@ static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh
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
2.56.0.385.gd3acb90ef8-goog


