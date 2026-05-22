Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7CFCD5BB6
	for <kexec@archiver.kernel.org>; Fri, 22 May 2026 20:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5BsKApi6L+qeqFEzWFS09/i8PEXb73/HfwpwzmTZ0gY=; b=Dr+xjzGYc1djlKrO3ppDUPXE2H
	Vzs8V1kX7nRJ8LC5S2ln3vuK7EwBuW+curYbsfV92gACLWce1AePz4lLAIlEk+e3V9JyUjEqOacsP
	w0bAwa4s9GtrZDu/wFllp6NWDEieHVOoxK0fIO3YAIIyQpxItR8ovWX++PUs6LUpAzPkYepFf030G
	euwRufmlx2QLc5w65FNilJeYbAe5HeVRGDQiQFKu6CTnGbknV5u+5yOAZomX2a2jNVy/YrXHxHRGR
	k+YB9OMrZNZ2T2W2gMRKx4sUYhxO4GBnxkT5RmTsUete8fx3XYRggOmxY+4QvKwx38+8aWtqkjpCj
	+UUnDBwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQWPr-0000000Brqe-1FI2;
	Fri, 22 May 2026 20:24:19 +0000
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQWPn-0000000Bro4-3B3e
	for kexec@lists.infradead.org;
	Fri, 22 May 2026 20:24:17 +0000
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-82fa6c3a77cso4437624b3a.3
        for <kexec@lists.infradead.org>; Fri, 22 May 2026 13:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779481454; x=1780086254; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5BsKApi6L+qeqFEzWFS09/i8PEXb73/HfwpwzmTZ0gY=;
        b=UKDTz3y818Af2QtvVH4LUEuTIYBOekIF9QjvZp+MmgQoHyDsEVdCCEnSG7lTwIwVUK
         8GQG3xOvrAN2b2mRhNwQ9Eb8biNvk+wA7BsiuReVb2f3l0kvcZfFVuYERko45tInA+fi
         43cu1m3NQRYpo2cPd6w8BvBhIwBJ+WOztyYbV11pgE/f89H0CxdKydlgMiUpvHp5ndvs
         xeJwlLzL+/FSn531ADjtCxelz7lfYqdUif0U4pL6AOUDv0QFRrMKtbLgUkDOxDhVfWjS
         YNl1X9yWJTM4r/KU2yiqc8K7u+ZOFnqPAfIyqat7VKK3AJOcf7y3vKPjgoAbpeCagKgh
         txaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779481454; x=1780086254;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5BsKApi6L+qeqFEzWFS09/i8PEXb73/HfwpwzmTZ0gY=;
        b=E1CRMib8SwEg2y5t9/fnBMw8oX3yoDSZIVfc7CD1I3lQxswcdAkSMo+WG1XYFDrH4u
         s4Q8cahjKEWK84OY/flN0Ug+NavBwlBwrcHrzQxiih0+p4vGs+RR4yBQ0Ij7KLW7Wa1B
         y9JzBKd2qkg+SNi7FC6T+P9CW/OJ7nLTmzEiaG+id/fEQC/VLCrABjDCMMyJPiVFy4iz
         LcQ9kQWXOiHj/kXL9SK/Rntn7wlRfkS8PSE8loB8aI2zSzjbDc7wzmVUbnLu8pMWYcw0
         1F/cjgaJhiPA8DiLxFS/PX0gOLr+ve9ZQqfEqDuX+IHdIZCdCsTMaAFA9CVKm/h2PFrg
         6mvw==
X-Gm-Message-State: AOJu0YyaTe2x+GQp3mTD8kQ/kW6BLyZh72KOWb7Ea3osQeQhLHi7KHrX
	fN4kujSpAThwz2VUQqW2hHBmWQuXbvzmSNsBXWINCNuFAQ5VtxGMhtjcz8v34eX58Q9HrQ1oXkW
	tj0Wgcs0evMJzV84yEKjTjaWPgFwPdIjmUnqh65CVB7i9xdj4SvdLZnWc2JNvyYlsyjMnSTD3zK
	BE1PiFg6xsOmtqTQL7RdAZ8GRGBH2YuVR0NbdsDx2hnxzkhzbisRg=
X-Received: from pfbbk29.prod.google.com ([2002:aa7:831d:0:b0:83d:3c25:eb8b])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:44c7:b0:837:7e7d:3d9 with SMTP id d2e1a72fcca58-8415f3a3d22mr5271624b3a.44.1779481453749;
 Fri, 22 May 2026 13:24:13 -0700 (PDT)
Date: Fri, 22 May 2026 20:24:00 +0000
In-Reply-To: <20260522202410.3104264-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260522202410.3104264-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522202410.3104264-3-dmatlack@google.com>
Subject: [PATCH v6 02/12] PCI: liveupdate: Track outgoing preserved PCI devices
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
X-CRM114-CacheID: sfid-20260522_132415_807080_72A56B54 
X-CRM114-Status: GOOD (  34.99  )
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
 drivers/pci/liveupdate.c       | 167 +++++++++++++++++++++++++++++++++
 drivers/pci/liveupdate.h       |  21 +++++
 drivers/pci/probe.c            |   2 +
 include/linux/kho/abi/pci.h    |   9 +-
 include/linux/pci.h            |   3 +
 include/linux/pci_liveupdate.h |  21 +++++
 6 files changed, 220 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pci/liveupdate.h

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 737e7b9366db..065d5af822f7 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -36,6 +36,26 @@
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
@@ -48,6 +68,21 @@
 #include <linux/mm.h>
 #include <linux/pci.h>
 
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
 static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
 {
 	struct pci_dev *dev = NULL;
@@ -115,6 +150,138 @@ static struct liveupdate_flb pci_liveupdate_flb = {
 	.compatible = PCI_LUO_FLB_COMPATIBLE,
 };
 
+static struct pci_ser *pci_liveupdate_flb_get_outgoing(void)
+{
+	struct pci_ser *ser = NULL;
+	int ret;
+
+	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&ser);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (!ser)
+		return ERR_PTR(-ENOENT);
+
+	return ser;
+}
+
+static void pci_liveupdate_unpreserve_device(struct pci_ser *ser, struct pci_dev *dev)
+{
+	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
+
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
+
+static int pci_liveupdate_preserve_device(struct pci_ser *ser, struct pci_dev *dev)
+{
+	int i;
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
+	struct pci_ser *ser = NULL;
+
+	if (dev->is_virtfn)
+		return -EINVAL;
+
+	guard(rwsem_write)(&pci_liveupdate.rwsem);
+
+	ser = pci_liveupdate_flb_get_outgoing();
+	if (IS_ERR(ser))
+		return PTR_ERR(ser);
+
+	return pci_liveupdate_preserve_device(ser, dev);
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
+	struct pci_ser *ser = NULL;
+
+	guard(rwsem_write)(&pci_liveupdate.rwsem);
+
+	ser = pci_liveupdate_flb_get_outgoing();
+	if (IS_ERR(ser)) {
+		pci_warn(dev, "Cannot unpreserve device without outgoing Live Update state\n");
+		return;
+	}
+
+	pci_liveupdate_unpreserve_device(ser, dev);
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
+
+void pci_liveupdate_cleanup_device(struct pci_dev *dev)
+{
+	/*
+	 * It should be safe to READ_ONCE() outside of the rwsem during cleanup
+	 * since there should no longer be any references to @dev on the system.
+	 */
+	if (READ_ONCE(dev->liveupdate.outgoing)) {
+		pci_WARN(dev, 1, "Destroying outgoing-preserved device!\n");
+		pci_liveupdate_unpreserve(dev);
+	}
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
index b63cd0c310bc..b88109a8dfe4 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -24,6 +24,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/bitfield.h>
 #include <trace/events/pci.h>
+#include "liveupdate.h"
 #include "pci.h"
 
 static struct resource busn_resource = {
@@ -2490,6 +2491,7 @@ static void pci_release_dev(struct device *dev)
 
 	pci_dev = to_pci_dev(dev);
 	pci_release_capabilities(pci_dev);
+	pci_liveupdate_cleanup_device(pci_dev);
 	pci_release_of_node(pci_dev);
 	pcibios_release_device(pci_dev);
 	pci_bus_put(pci_dev->bus);
diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
index 6ebcf817fff4..85def616703d 100644
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
+ *            refcount is equal to 1 when the struct pci_dev_ser is in use, and
+ *            0 otherwise.
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
index 8ec98beefcb4..cfcfbfa73af7 100644
--- a/include/linux/pci_liveupdate.h
+++ b/include/linux/pci_liveupdate.h
@@ -8,14 +8,26 @@
 #ifndef LINUX_PCI_LIVEUPDATE_H
 #define LINUX_PCI_LIVEUPDATE_H
 
+#include <linux/kho/abi/pci.h>
 #include <linux/liveupdate.h>
 #include <linux/types.h>
+#include <linux/spinlock_types.h>
+
+/**
+ * struct pci_liveupdate - PCI Live Update state for a struct pci_dev
+ * @outgoing: State preserved for the next kernel.
+ */
+struct pci_liveupdate {
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
2.54.0.746.g67dd491aae-goog


