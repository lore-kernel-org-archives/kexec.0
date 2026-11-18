Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78DD60A3806
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2duGvKnQ;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cQvLm1R5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=lyFpCJSo1NpmbzJ5pa08ShNtxQ6yEXoI64gVpBlF4cE=; b=2duGvKnQ0UZcwqzTcQnTbTO+sz
	We5KzrQOIxbva7tRIPkzCD0CobsAyMRfvd1q6JkWJcioT97feNhiB7/MBKj22hLSUAdk4Z/5mMfHT
	lvKxXxPUEDpB9pAa2GVEJTE3CCuw5li9AGkCmo6qTdL65lo7Gm9FlzAwhK6Idw9ZXNE7XDXuGDPas
	OMfxp6fMIZx19DTY6pGTIh91cMeIY9NQnDg9LrevSIn99xiFAetdCtlAxrT+DnR+XwVFvmNOuZWxg
	PB67hbQm6XKPBsyOwKbAzFsP7Ubzyv+3WpV+TTgXSNReOHfFNWWAdjJptmo9KfqpjGlGBXsVbkK9q
	ibKve2mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xToHC-0000000APsR-1VIV;
	Wed, 18 Nov 2026 22:37:14 +0000
Received: from mail-oa1-x45.google.com ([2001:4860:4864:20::45])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xToH9-0000000APqQ-0tDh
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 22:37:12 +0000
Received: by mail-oa1-x45.google.com with SMTP id 586e51a60fabf-448d51840c4so1082085fac.1
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 14:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795041429; x=1795646229; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lyFpCJSo1NpmbzJ5pa08ShNtxQ6yEXoI64gVpBlF4cE=;
        b=cQvLm1R5WsB8S4Dtpoe7It6p4HoLqlCuKkKs5uzd/25Sz/XsfdpR9HtoTuCQQU972x
         FPmB1spDZ05QpTeJPu+tTGwf0RcRnC5vE+94hMUQV1dYwZuiSCflsniOEMW6IwxqxmRK
         EZHm/4LxKGnX+3coSd2ZYVRcdqs1IR3nBXRD9EhmdztN6EUzU8+BKbtqLnuyIwUKmleg
         EFTdLA8W21AHM+28RQ8cjZvHCUon31GR8qoTHXv+uNjKrPB1dNLK9lSThvxD+CsVC/OM
         Kwe5H+MCbTVUF97kcdVaG0OW+5GLFMtuo+4e0EuJu+BYoOucko2BCf2wZOtWfevGc4jq
         qHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795041429; x=1795646229;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lyFpCJSo1NpmbzJ5pa08ShNtxQ6yEXoI64gVpBlF4cE=;
        b=Oz9R245ynUuy1jcHvHqd3KqB1HfncKgc/5nIQGF1isFCAnGp12V8rsw/y369RuU22o
         9bYcgkVhdFxYLDNpPrXQNXyj3Hl4ROuMiePo5IjbIOWswZXd3G8fuEnc7xQZBfj0jFaC
         UYcgv49MD5A1ZanZXnkdtludv1W/7azx105FB1AM2SDWsIhu/nUX63sb2u1iI5p+0AY9
         kih4G46v5pE2BHwJ2H5H88jN3LmhObo5fVX4ZoMqp3ttX39Xk1BmDkYFUsj4pypBpsCF
         A0/vEpmW4/rObVUuCdaGwIj9igEpxW/IG6jFbuOC0mAt4Tnp3Qg/Wf7Gfm1Jvhva0Ipy
         jcfg==
X-Gm-Message-State: APuU4Z/UtRcyf97UBA1B5LxooeV2XrZpkdrttWalPvtly1Q4ojtHSU0E
	2qFpug0fIiZ9Q2yEbS6lqG0NbWuv9BANu6YCv+7Rk6bHLE++X3IhkGFyTXWb4JHetWDuMqdPlCI
	Qs3zEbg1AgXIjiEs8l62icMg1Z6kXeDqdN83ugnhVSJk0bW1P3iki8aSOWrYmrIiiickx7aM6G0
	dF+HkVeya4Paat9/Xuui+PjwwBfe9usB+Wyy6nk7XvYdb6NiIoLr8=
X-Received: from iobmr1-n2.prod.google.com ([2002:a05:6602:a541:20b0:9c0:11e6:874e])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1820:b0:4d6:9283:1bdf with SMTP id 5614622812f47-5773dc44fc4mr4277372b6e.60.1795041428577;
 Wed, 18 Nov 2026 14:37:08 -0800 (PST)
Date: Wed, 18 Nov 2026 22:36:52 +0000
In-Reply-To: <20261118223704.3286085-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261118223704.3286085-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118223704.3286085-2-dmatlack@google.com>
Subject: [PATCH v11 01/13] PCI: liveupdate: Set up FLB handler for the PCI core
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Alex Williamson <alex.williamson@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Down <chris@chrisdown.name>, Chris Li <chrisl@kernel.org>, 
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
X-CRM114-CacheID: sfid-20261118_143711_313481_B5E90CEB 
X-CRM114-Status: GOOD (  36.51  )
X-Spam-Score: -9.5 (---------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-31.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set up a File-Lifecycle-Bound (FLB) handler so that the PCI core can
preserve its own state across a Live Update kexec.

Preserving a PCI device across kexec requires preserving two independent
sets of state:

 - Driver state, e.g. everything vfio-pci needs so that userspace can
   keep using the device in the new kernel. The driver preserves this
   itself and the PCI core is not involved.

 - PCI core state, e.g. which devices are preserved, so that the new
   kernel knows not to disturb them while they are still running and
   doing DMA. That is what this commit adds, serialized into struct
   pci_ser.

Userspace, not the kernel, decides which devices are preserved, and it
does so through the Live Update Orchestrator's (LUO) support for file
preservation: a driver exposes a file that represents a single PCI
device, and userspace preserves that device with
ioctl(LIVEUPDATE_SESSION_PRESERVE_FD) on that file. Binding preservation
to a file gives it proper lifecycle management, e.g. the preservation is
undone if userspace cancels it or goes away. How a driver exposes that
file is up to the driver and invisible to the PCI core (vfio-pci variant
drivers, the first intended use-case, use their per-device cdev).

LUO only knows that a file was preserved; it does not know that it
represents a PCI device, or which one. Bridging that gap, drivers
register their liveupdate_file_handler with the PCI core:

  pci_liveupdate_register_flb(driver_file_handler);
  pci_liveupdate_unregister_flb(driver_file_handler);

LUO then keeps a reference count on the PCI core's FLB for the files
preserved by that handler, and that reference count drives the lifetime
of struct pci_ser:

 - On the first preserved file, luo_flb_file_preserve_one() calls
   pci_flb_preserve(), which allocates struct pci_ser and preserves it
   with KHO.

 - On the last unpreserved file (i.e. preservation cancelled),
   liveupdate_flb_put_outgoing() calls pci_flb_unpreserve(), which
   unpreserves and frees struct pci_ser.

 - In the next kernel, pci_flb_retrieve() hands the PCI core the struct
   pci_ser built by the previous kernel, whenever the PCI core asks for
   it (e.g. during enumeration), and pci_flb_finish() frees it once the
   PCI core is done with it.

So the flow for preserving a device, once a driver has registered, looks
like this:

  ioctl(LIVEUPDATE_SESSION_PRESERVE_FD)
    luo_session_preserve_fd()
      luo_preserve_file()
        luo_flb_file_preserve()
          luo_flb_file_preserve_one()  # only on the first preserved file
            pci_flb_preserve()         # alloc + KHO-preserve pci_ser
        fh->ops->preserve()            # driver callback, e.g. vfio-pci

Note that struct pci_ser is deliberately not allocated when a driver
calls pci_liveupdate_register_flb(). A driver can be loaded for the
lifetime of the machine without ever preserving a device, and there is
no reason to allocate memory and hand it to the next kernel in that
case. Letting LUO own the lifetime also means the PCI core does not have
to duplicate LUO's reference counting and unwind logic for preservation
failures, session aborts and fd close, and the incoming side
(retrieve/finish) comes from the same object rather than requiring a
separate KHO FDT entry owned by the PCI core.

struct pci_ser begins with required_flags and optional_flags, rather
than a version number, so that the ABI can be extended without breaking
compatibility between kernels. A kernel that sets a bit in
required_flags requires the next kernel to understand the corresponding
feature, while bits in optional_flags can be safely ignored. The size of
each struct pci_dev_ser is recorded in struct pci_ser as well, so that
new fields can be appended to it.

Note: This commit only allocates struct pci_ser and preserves it across
Live Update. A subsequent commit adds pci_liveupdate_preserve(), the API
drivers call from their fh->ops->preserve() callback to tell the PCI
core exactly which devices are being preserved.

Note: There is no reason to check for kho_is_enabled() since it can be
assumed to return true. If KHO was not enabled then Live Update would
not be enabled and these routines would never run.

Note: PCI_LIVEUPDATE depends on 64BIT so that a device's domain and BDF
always fit in an unsigned long, which a subsequent commit uses as the
key when looking up incoming preserved devices.

Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/core-api/liveupdate.rst |   4 +
 MAINTAINERS                           |  13 ++
 drivers/pci/Kconfig                   |  14 ++
 drivers/pci/Makefile                  |   1 +
 drivers/pci/liveupdate.c              | 204 ++++++++++++++++++++++++++
 include/linux/kho/abi/pci.h           |  96 ++++++++++++
 include/linux/pci.h                   |   1 +
 include/linux/pci_liveupdate.h        |  30 ++++
 8 files changed, 363 insertions(+)
 create mode 100644 drivers/pci/liveupdate.c
 create mode 100644 include/linux/kho/abi/pci.h
 create mode 100644 include/linux/pci_liveupdate.h

diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index 5a292d0f3706..b3c689e633c1 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
+.. _luo:
+
 ========================
 Live Update Orchestrator
 ========================
@@ -18,6 +20,8 @@ LUO Preserving File Descriptors
 .. kernel-doc:: kernel/liveupdate/luo_file.c
    :doc: LUO File Descriptors
 
+.. _flb:
+
 LUO File Lifecycle Bound Global Data
 ====================================
 .. kernel-doc:: kernel/liveupdate/luo_flb.c
diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..639db5d00a80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21545,6 +21545,19 @@ L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/PCI/pci-error-recovery.rst
 
+PCI LIVE UPDATE
+M:	David Matlack <dmatlack@google.com>
+R:	Pasha Tatashin <pasha.tatashin@soleen.com>
+R:	Mike Rapoport <rppt@kernel.org>
+R:	Pratyush Yadav <pratyush@kernel.org>
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
index 0c7408509ba2..c37e68a6591a 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -271,6 +271,20 @@ config VGA_ARB_MAX_GPUS
 	  Reserves space in the kernel to maintain resource locking for
 	  multiple GPUS.  The overhead for each GPU is very small.
 
+config PCI_LIVEUPDATE
+	bool "PCI Live Update Support"
+	depends on PCI && LIVEUPDATE && 64BIT
+	help
+	  Enable PCI core support for preserving PCI devices across Live
+	  Update. This, in combination with support in a device's driver,
+	  enables PCI devices to run and perform memory transactions
+	  uninterrupted during a kexec for Live Update.
+
+	  Say Y if you use Live Update and need to preserve PCI devices
+	  across it.
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
index 000000000000..173433f64d00
--- /dev/null
+++ b/drivers/pci/liveupdate.c
@@ -0,0 +1,204 @@
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
+ * Preserving a device requires preserving two independent sets of state: the
+ * driver's own state, which the driver preserves with no involvement from the
+ * PCI core, and the PCI core's state about the device, which the next kernel
+ * needs so that enumeration does not disturb a device that is still running.
+ * The rest of this document describes the latter.
+ *
+ * :ref:`FLB <flb>` Data
+ * =====================
+ *
+ * Userspace decides which devices are preserved, using :ref:`LUO <luo>` file
+ * preservation: a driver exposes a file that represents a single PCI device,
+ * and userspace preserves the device with
+ * ``ioctl(LIVEUPDATE_SESSION_PRESERVE_FD)`` on that file. Binding preservation
+ * to a file gives it proper lifecycle management, e.g. the preservation is
+ * undone if userspace cancels it or goes away. How a driver exposes that file
+ * is up to the driver and invisible to the PCI core (vfio-pci variant drivers,
+ * the first intended use-case, use their per-device cdev).
+ *
+ * LUO only knows that a file was preserved; it does not know that the file
+ * represents a PCI device. Drivers therefore register their
+ * struct liveupdate_file_handler with the PCI core:
+ *
+ *  * ``pci_liveupdate_register_flb(driver_file_handler)``
+ *  * ``pci_liveupdate_unregister_flb(driver_file_handler)``
+ *
+ * LUO then keeps a reference count on the PCI core's FLB for the files
+ * preserved by that handler, and that reference count drives the lifetime of
+ * struct pci_ser: pci_flb_preserve() allocates and preserves it when the first
+ * file is preserved, and pci_flb_unpreserve() frees it when the last file is
+ * unpreserved. In the next kernel, pci_flb_retrieve() hands the PCI core the
+ * struct pci_ser built by the previous kernel, whenever the PCI core asks for
+ * it (e.g. during enumeration), and pci_flb_finish() frees it once the PCI
+ * core is done with it.
+ *
+ * Call Flow
+ * ---------
+ *
+ * ::
+ *
+ *   # Driver initialization
+ *   pci_liveupdate_register_flb(fh)
+ *
+ *   # Userspace: ioctl(LIVEUPDATE_SESSION_PRESERVE_FD, devfd)
+ *   luo_preserve_file()
+ *     luo_flb_file_preserve()
+ *       luo_flb_file_preserve_one()      # first preserved file only
+ *         pci_flb_preserve()             # alloc and preserve struct pci_ser
+ *     fh->ops->preserve()                # driver callback
+ *
+ *   # Userspace: preservation cancelled or session torn down
+ *   luo_file_unpreserve_files()
+ *     luo_flb_file_unpreserve()
+ *       liveupdate_flb_put_outgoing()    # last unpreserved file only
+ *         pci_flb_unpreserve()           # free struct pci_ser
+ *
+ *   # ---------------- kexec ----------------
+ *
+ *   # New kernel: the PCI core asks for the previous kernel's state
+ *   liveupdate_flb_get_incoming()
+ *     luo_flb_retrieve_one()             # first request only
+ *       pci_flb_retrieve()               # previous kernel's struct pci_ser
+ *
+ *   # Userspace: ioctl(LIVEUPDATE_SESSION_FINISH)
+ *   luo_file_finish_one()
+ *     fh->ops->finish()                  # driver callback
+ *     luo_flb_file_finish()
+ *       liveupdate_flb_put_incoming()    # last incoming file only
+ *         pci_flb_finish()               # free struct pci_ser
+ */
+
+#define pr_fmt(fmt) "PCI: liveupdate: " fmt
+
+#include <linux/io.h>
+#include <linux/kexec_handover.h>
+#include <linux/kho/abi/pci.h>
+#include <linux/kho_block.h>
+#include <linux/liveupdate.h>
+#include <linux/mm.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+
+/**
+ * struct pci_flb_outgoing - Outgoing PCI FLB object
+ * @ser: Pointer to the preserved struct pci_ser.
+ * @block_set: The KHO block set holding the outgoing devices.
+ */
+struct pci_flb_outgoing {
+	struct pci_ser *ser;
+	struct kho_block_set block_set;
+};
+
+static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
+{
+	struct pci_flb_outgoing *outgoing __free(kfree) = NULL;
+	struct pci_ser *ser;
+
+	outgoing = kzalloc_obj(*outgoing);
+	if (!outgoing)
+		return -ENOMEM;
+
+	ser = kho_alloc_preserve(sizeof(*ser));
+	if (IS_ERR(ser))
+		return PTR_ERR(ser);
+
+	ser->required_flags = 0;
+	ser->optional_flags = 0;
+	ser->dev_ser_size = sizeof(struct pci_dev_ser);
+	ser->nr_devices = 0;
+	ser->devices = 0;
+
+	outgoing->ser = ser;
+	kho_block_set_init(&outgoing->block_set, sizeof(struct pci_dev_ser));
+
+	args->obj = no_free_ptr(outgoing);
+	args->data = virt_to_phys(ser);
+	pr_debug("Preserved struct pci_ser (0x%llx)\n", args->data);
+	return 0;
+}
+
+static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
+{
+	struct pci_flb_outgoing *outgoing = args->obj;
+
+	pr_debug("Unpreserving struct pci_ser (0x%llx)\n", args->data);
+
+	WARN_ON(outgoing->ser->nr_devices);
+	kho_block_set_destroy(&outgoing->block_set);
+	kho_unpreserve_free(outgoing->ser);
+	kfree(outgoing);
+}
+
+static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
+{
+	pr_debug("Retrieving struct pci_ser (0x%llx)\n", args->data);
+	args->obj = phys_to_virt(args->data);
+	return 0;
+}
+
+static void pci_flb_finish(struct liveupdate_flb_op_args *args)
+{
+	pr_debug("Finished struct pci_ser (0x%llx)\n", args->data);
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
+ * Drivers that support preserving PCI devices across Live Update must call
+ * pci_liveupdate_register_flb() to register their
+ * struct liveupdate_file_handler with the PCI core, typically at module init,
+ * and always before any file managed by @fh can be preserved.
+ *
+ * Registering links the PCI core's FLB to @fh, so that LUO allocates the PCI
+ * core's outgoing struct pci_ser (via pci_flb_preserve()) when the first file
+ * managed by any registered handler is preserved, and frees it (via
+ * pci_flb_unpreserve()) when the last such file is unpreserved.
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
+ * pci_liveupdate_unregister_flb() - Unregister a file handler from the PCI core
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
index 000000000000..c2e3a5949f73
--- /dev/null
+++ b/include/linux/kho/abi/pci.h
@@ -0,0 +1,96 @@
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
+#include <linux/stddef.h>
+#include <linux/types.h>
+
+/**
+ * DOC: PCI File-Lifecycle Bound (FLB) Live Update ABI
+ *
+ * The PCI core preserves its state across kexec as Live Update
+ * File-Lifecycle Bound (FLB) data, identified by the compatible string
+ * ``"pci"`` and laid out as described by the structs below.
+ *
+ * This layout is a contract between kernels. Rather than being versioned, it
+ * is extended according to the following rules:
+ *
+ *  * Existing fields must never be moved, resized, removed, or have their
+ *    meaning changed. New fields may only be appended to the end of a struct.
+ *
+ *  * A bit set in ``pci_ser.required_flags`` marks a feature that the next
+ *    kernel must understand to safely take over the preserved devices. The
+ *    next kernel panics if it finds a bit it does not know how to handle.
+ *
+ *  * A bit set in ``pci_ser.optional_flags`` marks a feature that the next
+ *    kernel can safely ignore if it does not understand it.
+ *
+ *  * Fields appended to struct pci_ser must be accompanied by a flag that
+ *    indicates they are present, since the size of struct pci_ser is not
+ *    recorded.
+ *
+ *  * The size of each struct pci_dev_ser is recorded in
+ *    ``pci_ser.dev_ser_size`` and is never smaller than
+ *    ``PCI_DEV_SER_MIN_SIZE``. The next kernel ignores any fields beyond the
+ *    ones it knows about, and must handle entries that are smaller than its
+ *    own struct pci_dev_ser.
+ */
+
+#define PCI_LUO_FLB_COMPATIBLE "pci"
+
+/**
+ * struct pci_dev_ser - Serialized state about a single PCI device.
+ *
+ * @domain: The device's PCI domain number (segment).
+ * @bdf: The device's PCI bus, device, and function number.
+ * @refcount: Reference count used by the PCI core to keep track of whether it
+ *            is done using a device's struct pci_dev_ser. The value of the
+ *            reference count is equal to the number of preserved devices at or
+ *            below it in the PCI hierarchy when the struct pci_dev_ser is in
+ *            use, and 0 otherwise.
+ */
+struct pci_dev_ser {
+	u32 domain;
+	u16 bdf;
+	u16 refcount;
+} __packed;
+
+/*
+ * The size of struct pci_dev_ser when this ABI was introduced. Since fields
+ * can only be appended, every struct pci_dev_ser is at least this large.
+ */
+#define PCI_DEV_SER_MIN_SIZE offsetofend(struct pci_dev_ser, refcount)
+
+/**
+ * struct pci_ser - PCI Subsystem Live Update State
+ *
+ * This struct tracks state about all devices that are being preserved across
+ * a Live Update for the next kernel. It contains only state owned by the PCI
+ * core; the state a driver needs to resume its device is preserved separately
+ * by that driver.
+ *
+ * @required_flags: Features that the next kernel must support to take over
+ *                  the preserved devices. No flags are currently defined.
+ * @optional_flags: Features that the next kernel may ignore if it does not
+ *                  support them. No flags are currently defined.
+ * @dev_ser_size: The size in bytes of each struct pci_dev_ser in @devices.
+ * @nr_devices: The number of devices that were preserved.
+ * @devices: Physical address of the first KHO block containing pci_dev_ser.
+ */
+struct pci_ser {
+	u64 required_flags;
+	u64 optional_flags;
+	u32 dev_ser_size;
+	u32 nr_devices;
+	u64 devices;
+} __packed;
+
+#endif /* _LINUX_KHO_ABI_PCI_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index aa3765a20a96..2c15c2666970 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -43,6 +43,7 @@
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
2.56.1.703.gf848ed807c-goog


