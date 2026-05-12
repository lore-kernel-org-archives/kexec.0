Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00452CD4F39
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 18:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dy/EdvVTTBqiefKlS8WatpbG3+QoYAqM6EFKsrFApM0=; b=1kvAuPg6jIOPj+30JGOI3yEEW9
	yL+ds0Pzq8BgNw1i5tRRWWslzOFgkvIJ5bqEP/+lHQ18n39NTAqX+kmFuAr1ornsG+n94h0tK50XB
	xsB48dH+1ptvIIWRq2dyNxIWn2tIEd7UbXDaKlofh//nYUkTEj3T3of8HGhAcgzNaDI4xNaydUtOU
	OW/FPQtR2bWgH9aBl3gzfdmxLlNz7IdRU6ZEHimeUQCXW2gcPFgsg3pogOK05lx7wFs+0HaSw8Due
	Faz7ww0qW8mORPlmoHE/HOLUaFSU2HVWsE7hTsnuGnW7qI9T2wO2clHri6ktMoXaN7TmuWoVpxri+
	HLdJXqkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMsA3-000000008cU-41LZ;
	Tue, 12 May 2026 18:48:55 +0000
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMsA1-000000008ar-0kUu
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 18:48:55 +0000
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-82f6a5b4f88so7387746b3a.2
        for <kexec@lists.infradead.org>; Tue, 12 May 2026 11:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778611732; x=1779216532; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dy/EdvVTTBqiefKlS8WatpbG3+QoYAqM6EFKsrFApM0=;
        b=ZfIZIBDAR57D9WwVuc55z5+ys7ont/MOCDLqob2t958ZFc3DYa+bZ4kPXyVIwB995r
         JgSI8CVae2SZ1/nhCHViLdFO3XT4JVayRkPsLaTv3rIeRqgv0wwCARtNXl3pla2SeP4c
         s24pvLrR5Z8Tu9Lp1HR4WgMGo8wJOx0t9NT6b79sGwvorBmKCVJtNrmaIKc+6eXirAiY
         /ePlP9ZtH1tM0FpxgDB1BR5ws0xL5NWgcXdV7J4a7Ss2EocybzhajbtdmWJUAufQIpko
         2Me0ralXVzy00u4VyK7t1M/pR58909zAfOqdVKsJpGpUH3prBOImGAIgsylVUkfRdSPd
         rMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778611732; x=1779216532;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dy/EdvVTTBqiefKlS8WatpbG3+QoYAqM6EFKsrFApM0=;
        b=id3BhwQZkI26ZoFXhQndLOPjMGa9Res34Kn1n3fIBOZdEhxQRaoYfK2Aqbr4aXrGZF
         nqi9YmZljXLdAafGEtKzVVg2oA6TmMrNTQL1J3OR/oh99W4sP7dJEt0YacHnr1jH0j8p
         +BOOZLAIuvFKOBqzNYGC11Wh291S7vFfXjNn2LpbkZ5rMXqM4+wpzJF8K48wfR/jMLN9
         GgE7vf+l3MqA7ygIqcrebwG9POtpttUEKO9rWAWlwzFEp0EE/qDG832gdByrSXrr9Blg
         bInR2EOCnsXJIb0Dc6uco21cVAMO5EQ0ind3QSKnWhSL+NclvymrcsiY2BtPSLsRnunK
         r1+g==
X-Gm-Message-State: AOJu0Yyg+KgrVPKnlw5tkEHC9aFA5fuWwqm4olMqTQM5YN92eJ9p/3e2
	FAiG2zeEBRJa6Jpg7q67x+P601Tpwd5IWNw1deXIS4NsGuR2STE88FKse4mUMy/QlypEJ5LK0Za
	keVe5Qq6z05War/5MYXMBL91w73ZHSOS47PdAK4dwYG4YBzSHsUXGJG0qul/5e9p7oZ1RrEqQoq
	BlqXHIZgMeRnhsw/xbQexqt+pnzJZbJO9r8w93k2u1zhHtXGxfwcQ=
X-Received: from pfblr27.prod.google.com ([2002:a05:6a00:739b:b0:82f:7220:86e7])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3689:b0:82a:6ef8:cb43 with SMTP id d2e1a72fcca58-83eebb5ee0cmr4631546b3a.19.1778611731916;
 Tue, 12 May 2026 11:48:51 -0700 (PDT)
Date: Tue, 12 May 2026 18:48:36 +0000
In-Reply-To: <20260512184846.119396-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260512184846.119396-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512184846.119396-2-dmatlack@google.com>
Subject: [PATCH v5 01/11] PCI: liveupdate: Set up FLB handler for the PCI core
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
X-CRM114-CacheID: sfid-20260512_114853_239146_F3201793 
X-CRM114-Status: GOOD (  35.60  )
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

Set up a File-Lifecycle-Bound (FLB) handler for the PCI core to enable
it to participate in the preservation of PCI devices across Live Update.
Essentially, this commit enables the PCI core to allocate a struct
(struct pci_ser) and preserve it across a Live Update whenever at least
one device is preserved.

Preserving PCI devices across Live Update is built on top of the Live
Update Orchestrator's (LUO) support for file preservation. Drivers are
expected to expose a file to userspace to represent a single PCI device
and support preservation of that file. This is intended primarily to
support preservation of PCI devices bound to VFIO drivers.

This commit enables drivers to register their liveupdate_file_handler
with the PCI core so that the PCI core can do its own tracking and
enforcement of which devices are preserved.

  pci_liveupdate_register_flb(driver_file_handler);
  pci_liveupdate_unregister_flb(driver_file_handler);

When the first file (with a handler registered with the PCI core) is
preserved, the PCI core will be notified to allocate its tracking struct
(pci_ser). When the last file is unpreserved (i.e. preservation
cancelled) the PCI core will be notified to free struct pci_ser.

This struct is preserved across a Live Update using KHO and can be
fetched by the PCI core during early boot (e.g. during device
enumeration) so that it knows which devices were preserved.

Note: This commit only allocates struct pci_ser and preserves it across
Live Update. A subsequent commit will add an API for drivers to tell the
PCI core exactly which devices are being preserved.

Note: There is no reason to check for kho_is_enabled() since it can be
assumed to return true. If KHO was not enabled then Live Update would
not be enabled and these routines would never run.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 MAINTAINERS                    |  10 +++
 drivers/pci/Kconfig            |  14 +++
 drivers/pci/Makefile           |   1 +
 drivers/pci/liveupdate.c       | 153 +++++++++++++++++++++++++++++++++
 include/linux/kho/abi/pci.h    |  61 +++++++++++++
 include/linux/pci.h            |   1 +
 include/linux/pci_liveupdate.h |  30 +++++++
 7 files changed, 270 insertions(+)
 create mode 100644 drivers/pci/liveupdate.c
 create mode 100644 include/linux/kho/abi/pci.h
 create mode 100644 include/linux/pci_liveupdate.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..6c618830cf61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20530,6 +20530,16 @@ L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/PCI/pci-error-recovery.rst
 
+PCI LIVE UPDATE
+M:	David Matlack <dmatlack@google.com>
+L:	kexec@lists.infradead.org
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
+F:	drivers/pci/liveupdate.c
+F:	include/linux/kho/abi/pci.h
+F:	include/linux/pci_liveupdate.h
+
 PCI MSI DRIVER FOR ALTERA MSI IP
 L:	linux-pci@vger.kernel.org
 S:	Orphan
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 33c88432b728..08398cbe970c 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -328,6 +328,20 @@ config VGA_ARB_MAX_GPUS
 	  Reserves space in the kernel to maintain resource locking for
 	  multiple GPUS.  The overhead for each GPU is very small.
 
+config PCI_LIVEUPDATE
+	bool "PCI Live Update Support (EXPERIMENTAL)"
+	depends on PCI && LIVEUPDATE
+	help
+	  Enable PCI core support for preserving PCI devices across Live
+	  Update. This, in combination with support in a device's driver,
+	  enables PCI devices to run and perform memory transactions
+	  uninterrupted during a kexec for Live Update.
+
+	  This option should only be enabled by developers working on
+	  implementing this support.
+
+	  If unsure, say N.
+
 source "drivers/pci/hotplug/Kconfig"
 source "drivers/pci/controller/Kconfig"
 source "drivers/pci/endpoint/Kconfig"
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 41ebc3b9a518..e8d003cb6757 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_PROC_FS)		+= proc.o
 obj-$(CONFIG_SYSFS)		+= pci-sysfs.o slot.o
 obj-$(CONFIG_ACPI)		+= pci-acpi.o
 obj-$(CONFIG_GENERIC_PCI_IOMAP) += iomap.o
+obj-$(CONFIG_PCI_LIVEUPDATE)	+= liveupdate.o
 endif
 
 obj-$(CONFIG_OF)		+= of.o
diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
new file mode 100644
index 000000000000..dd2449e12b6d
--- /dev/null
+++ b/drivers/pci/liveupdate.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2026, Google LLC.
+ * David Matlack <dmatlack@google.com>
+ */
+
+/**
+ * DOC: PCI Live Update
+ *
+ * The PCI subsystem participates in the Live Update process to enable drivers
+ * to preserve their PCI devices across kexec.
+ *
+ * .. note::
+ *    The support for preserving PCI devices across Live Update is currently
+ *    *partial* and should be considered *experimental*. It should only be
+ *    used by developers working on the implementation for the time being.
+ *
+ *    To enable the support, enable ``CONFIG_PCI_LIVEUPDATE``.
+ *
+ * File-Lifecycle-Bound (FLB) Data
+ * ===============================
+ *
+ * PCI device preservation across Live Update is built on top of the Live Update
+ * Orchestrator's (LUO) support for file preservation across kexec. Drivers
+ * are expected to expose a file to represent a single PCI device and support
+ * preservation of that file with ``ioctl(LIVEUPDATE_SESSION_PRESERVE_FD)``.
+ * This allows userspace to control the preservation of devices and ensure
+ * proper lifecycle management while a device is preserved. The first intended
+ * use-case is preserving vfio-pci device files.
+ *
+ * The PCI core maintains its own state about what devices are being preserved
+ * across Live Update using a feature called File-Lifecycle-Bound (FLB) data in
+ * LUO.  Essentially, this allows the PCI core to allocate struct pci_ser when
+ * the first device (file) is preserved and free it when the last device (file)
+ * is unpreserved. After kexec, the PCI core can fetch the struct pci_ser (which
+ * was constructed by the previous kernel) from LUO at any time (e.g. during
+ * enumeration) so that it knows which devices were preserved.
+ *
+ * To enable the PCI core to be notified whenever a file representing a device
+ * is preserved, drivers must register their struct liveupdate_file_handler with
+ * the PCI core by using the following APIs:
+ *
+ *  * ``pci_liveupdate_register_flb(driver_file_handler)``
+ *  * ``pci_liveupdate_unregister_flb(driver_file_handler)``
+ */
+
+#define pr_fmt(fmt) "PCI: liveupdate: " fmt
+
+#include <linux/io.h>
+#include <linux/kexec_handover.h>
+#include <linux/kho/abi/pci.h>
+#include <linux/liveupdate.h>
+#include <linux/mutex.h>
+#include <linux/mm.h>
+#include <linux/pci.h>
+
+static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
+{
+	struct pci_dev *dev = NULL;
+	u32 max_nr_devices = 0;
+	struct pci_ser *ser;
+	unsigned long size;
+
+	/*
+	 * Allocate enough space to preserve all of the devices that are
+	 * currently present on the system. Extra padding can be added to this
+	 * in the future to increase the chances that there is enough room to
+	 * preserve devices that are not yet present on the system (e.g. VFs,
+	 * hot-plugged devices).
+	 */
+	for_each_pci_dev(dev)
+		max_nr_devices++;
+
+	size = struct_size_t(struct pci_ser, devices, max_nr_devices);
+
+	ser = kho_alloc_preserve(size);
+	if (IS_ERR(ser))
+		return PTR_ERR(ser);
+
+	pr_debug("Preserved struct pci_ser with room for %u devices\n",
+		 max_nr_devices);
+
+	ser->max_nr_devices = max_nr_devices;
+	ser->nr_devices = 0;
+
+	args->obj = ser;
+	args->data = virt_to_phys(ser);
+	return 0;
+}
+
+static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
+{
+	struct pci_ser *ser = args->obj;
+
+	WARN_ON_ONCE(ser->nr_devices);
+	kho_unpreserve_free(ser);
+
+	pr_debug("Unpreserved struct pci_ser\n");
+}
+
+static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
+{
+	args->obj = phys_to_virt(args->data);
+	return 0;
+}
+
+static void pci_flb_finish(struct liveupdate_flb_op_args *args)
+{
+	kho_restore_free(args->obj);
+}
+
+static struct liveupdate_flb_ops pci_liveupdate_flb_ops = {
+	.preserve = pci_flb_preserve,
+	.unpreserve = pci_flb_unpreserve,
+	.retrieve = pci_flb_retrieve,
+	.finish = pci_flb_finish,
+	.owner = THIS_MODULE,
+};
+
+static struct liveupdate_flb pci_liveupdate_flb = {
+	.ops = &pci_liveupdate_flb_ops,
+	.compatible = PCI_LUO_FLB_COMPATIBLE,
+};
+
+/**
+ * pci_liveupdate_register_flb() - Register a file handler with the PCI core
+ * @fh: The file handler to register.
+ *
+ * Drivers should call pci_liveupdate_register_flb() to register their
+ * struct liveupdate_file_handler with the PCI core. This enables the PCI core
+ * to allocate its outgoing struct pci_ser whenever the first device is
+ * preserved, and free it when the last device is unpreserved.
+ *
+ * Return: 0 on success, <0 on failure.
+ */
+int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
+{
+	pr_debug("Registering file handler \"%s\"\n", fh->compatible);
+	return liveupdate_register_flb(fh, &pci_liveupdate_flb);
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_register_flb);
+
+/**
+ * pci_liveupdate_unregister_flb() - Unregister a file handler with the PCI core
+ * @fh: The file handler to unregister.
+ */
+void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh)
+{
+	pr_debug("Unregistering file handler \"%s\"\n", fh->compatible);
+	liveupdate_unregister_flb(fh, &pci_liveupdate_flb);
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_unregister_flb);
diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
new file mode 100644
index 000000000000..6ebcf817fff4
--- /dev/null
+++ b/include/linux/kho/abi/pci.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2026, Google LLC.
+ * David Matlack <dmatlack@google.com>
+ */
+
+#ifndef _LINUX_KHO_ABI_PCI_H
+#define _LINUX_KHO_ABI_PCI_H
+
+#include <linux/bug.h>
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+/**
+ * DOC: PCI File-Lifecycle Bound (FLB) Live Update ABI
+ *
+ * This header defines the ABI for preserving core PCI state across kexec using
+ * Live Update File-Lifecycle Bound (FLB) data.
+ *
+ * This interface is a contract. Any modification to any of the serialization
+ * structs defined here constitutes a breaking change. Such changes require
+ * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE string.
+ */
+
+#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
+
+/**
+ * struct pci_dev_ser - Serialized state about a single PCI device.
+ *
+ * @domain: The device's PCI domain number (segment).
+ * @bdf: The device's PCI bus, device, and function number.
+ * @padding: Padding to naturally align struct pci_dev_ser.
+ */
+struct pci_dev_ser {
+	u32 domain;
+	u16 bdf;
+	u16 padding;
+} __packed;
+
+/**
+ * struct pci_ser - PCI Subsystem Live Update State
+ *
+ * This struct tracks state about all devices that are being preserved across
+ * a Live Update for the next kernel.
+ *
+ * @max_nr_devices: The length of the devices[] flexible array.
+ * @nr_devices: The number of devices that were preserved.
+ * @devices: Flexible array of pci_dev_ser structs for each device.
+ */
+struct pci_ser {
+	u32 max_nr_devices;
+	u32 nr_devices;
+	struct pci_dev_ser devices[];
+} __packed;
+
+/* Ensure all elements of devices[] are naturally aligned. */
+static_assert(offsetof(struct pci_ser, devices) % sizeof(unsigned long) == 0);
+static_assert(sizeof(struct pci_dev_ser) % sizeof(unsigned long) == 0);
+
+#endif /* _LINUX_KHO_ABI_PCI_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..8cadeeab86fd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -42,6 +42,7 @@
 #include <uapi/linux/pci.h>
 
 #include <linux/pci_ids.h>
+#include <linux/pci_liveupdate.h>
 
 #define PCI_STATUS_ERROR_BITS (PCI_STATUS_DETECTED_PARITY  | \
 			       PCI_STATUS_SIG_SYSTEM_ERROR | \
diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
new file mode 100644
index 000000000000..8ec98beefcb4
--- /dev/null
+++ b/include/linux/pci_liveupdate.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCI Live Update support (Public/Driver API)
+ *
+ * Copyright (c) 2026, Google LLC.
+ * David Matlack <dmatlack@google.com>
+ */
+#ifndef LINUX_PCI_LIVEUPDATE_H
+#define LINUX_PCI_LIVEUPDATE_H
+
+#include <linux/liveupdate.h>
+#include <linux/types.h>
+
+struct pci_dev;
+
+#ifdef CONFIG_PCI_LIVEUPDATE
+int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh);
+void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh);
+#else
+static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh)
+{
+}
+#endif
+
+#endif /* LINUX_PCI_LIVEUPDATE_H */
-- 
2.54.0.563.g4f69b47b94-goog


