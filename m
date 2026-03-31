Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D084F10F92E3
	for <kexec@archiver.kernel.org>; Tue, 31 Mar 2026 17:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QH40r46yvNyKpZfiIfskbaEYQxt02aHGlisfMow3fdk=; b=wCQqAcZoVyVrikQNxO4EItWo5k
	eS55883dj4LiQpJPpKvyqa21FUUQQaRb5uNlIE2XVTXsAK20YKnFUSRrr5YhtaiEICZhSbtv8ZTCr
	bgkPHsmJVAOBPnuXfOZOfmrNaCsgXCh3vV1xOfktFrDFi0SBX2GhoyETUGIHYumS/a7bzRq1w3Le8
	f2ZLjspD0sQ0oMUkGPGrx8G5ZglCMTHnLIsWdJ1l8jTahZmB6nw2KZ1LHg0bCPFWXmgEKgFlbjtl8
	ZXAmaEmWcGWekxBC+S/WtpUOqAq/vJKfj1BkZnWqO5KVcmiY4Hl2wC6BtyTu4CTNdrv8EJXidFIEn
	6n0yX7KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7cyF-0000000DLuu-1oQM;
	Tue, 31 Mar 2026 17:33:43 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7cy8-0000000DLuK-42yi
	for kexec@lists.infradead.org;
	Tue, 31 Mar 2026 17:33:38 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2b2591757fbso138775ad.0
        for <kexec@lists.infradead.org>; Tue, 31 Mar 2026 10:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774978415; x=1775583215; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QH40r46yvNyKpZfiIfskbaEYQxt02aHGlisfMow3fdk=;
        b=VRt2uO9CES94Fz+/YDa5BA28hmgFjuZ7H+qM9VfCbPZX9FXAKEa3/LjaKWWfYK0xVs
         f+Xcpue7ER7xAZ2ACUwJqZk2dv/KxlmSV+XSJBI8ELLUVm5WPiFjsysqpllHKsNd1WDR
         DYA4z/Zrx0Wu/Il/op/s6fxtMaC56ZHIXAGdaz2Y4fpCp2bqMvDx5WTvHfRU9AyTN9k3
         xr2cAmNVi9C4OuxwQu+o+ekoSKAWtNnYjann27DMizkgzDZj/Za0ZojdIhkneHcLGLYE
         7lliGhutCcw9SCakYvY1qYp8+1TOYvepjcetr7zpR9pfSLU2n0+qm6QGXJRuk5v34mKW
         oJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774978415; x=1775583215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QH40r46yvNyKpZfiIfskbaEYQxt02aHGlisfMow3fdk=;
        b=VkmDrYTgSr/ZPiqXUs4t1lK4P4Y61nOnGJf+turHZ5XNKzTnJjkfsrL1ZkZZEexe7u
         VEL2EPRxN586pxYc1jDtffxQIQkPwXQPK5tSNysrgtIoNp+0wqKqCl/rPVR6DfoqH5wj
         uAhXdGWa+OswDEAU8c8aZlIVG1UG4SLBDWSy1V2twUf4EfgFIIwbE+vhgWTG8I9zGasC
         U/Ojlgt9EJXm3UIm3UFjMgv5vShk1e57kTA/Ep7QeO3BOL/nkJGrJp3mI+959IB8cDmC
         eZDtkRZ5SXPoHREgzoopSRmYWm7bbquM0tQ5Zj4UX31rzAxMUH+mzeGKnIq2EcVQfrbJ
         ZJXg==
X-Forwarded-Encrypted: i=1; AJvYcCUsUuLGwf/Flo0ugLcP0nn5/4Nt88vSrDX94ErIstpGXwR/epBuYh1dBaEh0TJxgaqYR7uAKg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxNky1GyTfNQAILtmLmhGEPWSVvlIl9ufa+sMWfojodrIfQBTqy
	KndvWuvmFctCNHJ2rPGWa5xp/LC9IUFBTBrfhb8JdwVvtCqPEAvAEH6m7YsaT0xdsQ==
X-Gm-Gg: ATEYQzyP6pZkGSdrekpUgGyacnxWue6QRAIRAt8hIJ2aPMDO/N5Uzy8EWccBe+92EE4
	g/GxMMVZ0Mn/Glq6QC5yyn2axIDcO2aX3Jl2nrXtvqrDulhHL7BCuCWvdwXdC6p+/t45coIdzDZ
	HjP3e87KiGZhDd61flax8nrkHj42i5Rf7QiEZkBFiXreVGskkrxg4H9D6epxXSJFkxjDgrG89ib
	BE+A2+LkvQc4nRk5ufJamgZgImUGEJK8zfkjidcP/K0TrszU6rF7C1kVLVa/3UepBzOco0i6oyC
	63v4Pb9SCpTgrRfWfteAvly0o24BGO0MfZZI8yrZbkCa0dgrQWnAmgMX3DBcz/3hqyyWY+Y9O+a
	7inpv598UZfHlWmguW0S87dMXXu/TQoCV758jApyZI7KI9BY7pBV16sjFGEeOTlXXZWMEkETniQ
	i9caOwNsOiYuEAkueJSq7sVN9pD64mIwbOxDTEU775clRTeIb5LneLHHkMo3k0/A==
X-Received: by 2002:a17:903:907:b0:2ae:ca87:b1c2 with SMTP id d9443c01a7336-2b268dcc4f0mr525705ad.8.1774978414532;
        Tue, 31 Mar 2026 10:33:34 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76916baab6sm9360457a12.2.2026.03.31.10.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 10:33:33 -0700 (PDT)
Date: Tue, 31 Mar 2026 17:33:29 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, 
	Askar Safin <safinaskar@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Rientjes <rientjes@google.com>, Feng Tang <feng.tang@linux.alibaba.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Kees Cook <kees@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Li RongQing <lirongqing@baidu.com>, 
	Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v3 02/24] PCI: Add API to track PCI devices preserved
 across Live Update
Message-ID: <acwEMNUIj3IfTpPG@google.com>
References: <20260323235817.1960573-1-dmatlack@google.com>
 <20260323235817.1960573-3-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260323235817.1960573-3-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260331_103337_040040_7B328469 
X-CRM114-Status: GOOD (  34.06  )
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

On Mon, Mar 23, 2026 at 11:57:54PM +0000, David Matlack wrote:
>Add an API to enable the PCI subsystem to participate in a Live Update
>and track all devices that are being preserved by drivers. Since this
>support is still under development, hide it behind a new Kconfig
>PCI_LIVEUPDATE that is marked experimental.
>
>This API will be used in subsequent commits by the vfio-pci driver to
>preserve VFIO devices across Live Update.
>
>Signed-off-by: David Matlack <dmatlack@google.com>
>---
> drivers/pci/Kconfig         |  11 ++
> drivers/pci/Makefile        |   1 +
> drivers/pci/liveupdate.c    | 380 ++++++++++++++++++++++++++++++++++++
> drivers/pci/pci.h           |  14 ++
> drivers/pci/probe.c         |   2 +
> include/linux/kho/abi/pci.h |  62 ++++++
> include/linux/pci.h         |  41 ++++
> 7 files changed, 511 insertions(+)
> create mode 100644 drivers/pci/liveupdate.c
> create mode 100644 include/linux/kho/abi/pci.h
>
>diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>index e3f848ffb52a..05307d89c3f4 100644
>--- a/drivers/pci/Kconfig
>+++ b/drivers/pci/Kconfig
>@@ -334,6 +334,17 @@ config VGA_ARB_MAX_GPUS
> 	  Reserves space in the kernel to maintain resource locking for
> 	  multiple GPUS.  The overhead for each GPU is very small.
>
>+config PCI_LIVEUPDATE
>+	bool "PCI Live Update Support (EXPERIMENTAL)"
>+	depends on PCI && LIVEUPDATE
>+	help
>+	  Support for preserving PCI devices across a Live Update. This option
>+	  should only be enabled by developers working on implementing this
>+	  support. Once enough support as landed in the kernel, this option
>+	  will no longer be marked EXPERIMENTAL.
>+
>+	  If unsure, say N.
>+
> source "drivers/pci/hotplug/Kconfig"
> source "drivers/pci/controller/Kconfig"
> source "drivers/pci/endpoint/Kconfig"
>diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
>index 41ebc3b9a518..e8d003cb6757 100644
>--- a/drivers/pci/Makefile
>+++ b/drivers/pci/Makefile
>@@ -16,6 +16,7 @@ obj-$(CONFIG_PROC_FS)		+= proc.o
> obj-$(CONFIG_SYSFS)		+= pci-sysfs.o slot.o
> obj-$(CONFIG_ACPI)		+= pci-acpi.o
> obj-$(CONFIG_GENERIC_PCI_IOMAP) += iomap.o
>+obj-$(CONFIG_PCI_LIVEUPDATE)	+= liveupdate.o
> endif
>
> obj-$(CONFIG_OF)		+= of.o
>diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
>new file mode 100644
>index 000000000000..bec7b3500057
>--- /dev/null
>+++ b/drivers/pci/liveupdate.c
>@@ -0,0 +1,380 @@
>+// SPDX-License-Identifier: GPL-2.0
>+
>+/*
>+ * Copyright (c) 2026, Google LLC.
>+ * David Matlack <dmatlack@google.com>
>+ */
>+
>+/**
>+ * DOC: PCI Live Update
>+ *
>+ * The PCI subsystem participates in the Live Update process to enable drivers
>+ * to preserve their PCI devices across kexec.
>+ *
>+ * Device preservation across Live Update is built on top of the Live Update
>+ * Orchestrator (LUO) support for file preservation across kexec. Userspace
>+ * indicates that a device should be preserved by preserving the file associated
>+ * with the device with ``ioctl(LIVEUPDATE_SESSION_PRESERVE_FD)``.
>+ *
>+ * .. note::
>+ *    The support for preserving PCI devices across Live Update is currently
>+ *    *partial* and should be considered *experimental*. It should only be
>+ *    used by developers working on the implementation for the time being.
>+ *
>+ *    To enable the support, enable ``CONFIG_PCI_LIVEUPDATE``.
>+ *
>+ * Driver API
>+ * ==========
>+ *
>+ * Drivers that support file-based device preservation must register their
>+ * ``liveupdate_file_handler`` with the PCI subsystem by calling
>+ * ``pci_liveupdate_register_flb()``. This ensures the PCI subsystem will be
>+ * notified whenever a device file is preserved so that ``struct pci_ser``
>+ * can be allocated to track all preserved devices. This struct is an ABI
>+ * and is eventually handed off to the next kernel via Kexec-Handover (KHO).
>+ *
>+ * In the "outgoing" kernel (before kexec), drivers should then notify the PCI
>+ * subsystem directly whenever the preservation status for a device changes:
>+ *
>+ *  * ``pci_liveupdate_preserve(pci_dev)``: The device is being preserved.
>+ *
>+ *  * ``pci_liveupdate_unpreserve(pci_dev)``: The device is no longer being
>+ *    preserved (preservation is cancelled).
>+ *
>+ * In the "incoming" kernel (after kexec), drivers should notify the PCI
>+ * subsystem with the following calls:
>+ *
>+ *  * ``pci_liveupdate_retrieve(pci_dev)``: The device file is being retrieved
>+ *    by userspace.
>+ *
>+ *  * ``pci_liveupdate_finish(pci_dev)``: The device is done participating in
>+ *    Live Update. After this point the device may no longer be even associated
>+ *    with the same driver.
>+ *
>+ * Incoming/Outgoing
>+ * =================
>+ *
>+ * The state of each device's participation in Live Update is stored in
>+ * ``struct pci_dev``:
>+ *
>+ *  * ``liveupdate_outgoing``: True if the device is being preserved in the
>+ *    outgoing kernel. Set in ``pci_liveupdate_preserve()`` and cleared in
>+ *    ``pci_liveupdate_unpreserve()``.
>+ *
>+ *  * ``liveupdate_incoming``: True if the device is preserved in the incoming
>+ *    kernel. Set during probing when the device is first created and cleared
>+ *    in ``pci_liveupdate_finish()``.
>+ *
>+ * Restrictions
>+ * ============
>+ *
>+ * Preserved devices currently have the following restrictions. Each of these
>+ * may be relaxed in the future.
>+ *
>+ *  * The device must not be a Virtual Function (VF).
>+ *
>+ *  * The device must not be a Physical Function (PF).
>+ *
>+ * Preservation Behavior
>+ * =====================
>+ *
>+ * The kernel preserves the following state for devices preserved across a Live
>+ * Update:
>+ *
>+ *  * The PCI Segment, Bus, Device, and Function numbers assigned to the device
>+ *    are guaranteed to remain the same across Live Update.
>+ *
>+ * This list will be extended in the future as new support is added.
>+ *
>+ * Driver Binding
>+ * ==============
>+ *
>+ * It is the driver's responsibility for ensuring that preserved devices are not
>+ * released or bound to a different driver for as long as they are preserved. In
>+ * practice, this is enforced by LUO taking an extra referenced to the preserved
>+ * device file for as long as it is preserved.
>+ *
>+ * However, there is a window of time in the incoming kernel when a device is
>+ * first probed and when userspace retrieves the device file with
>+ * ``LIVEUPDATE_SESSION_RETRIEVE_FD`` when the device could be bound to any
>+ * driver.
>+ *
>+ * It is currently userspace's responsibility to ensure that the device is bound
>+ * to the correct driver in this window.
>+ */
>+
>+#include <linux/bsearch.h>
>+#include <linux/io.h>
>+#include <linux/kexec_handover.h>
>+#include <linux/kho/abi/pci.h>
>+#include <linux/liveupdate.h>
>+#include <linux/mutex.h>
>+#include <linux/mm.h>
>+#include <linux/pci.h>
>+#include <linux/sort.h>
>+
>+#include "pci.h"
>+
>+static DEFINE_MUTEX(pci_flb_outgoing_lock);
>+
>+static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
>+{
>+	struct pci_dev *dev = NULL;
>+	int max_nr_devices = 0;
>+	struct pci_ser *ser;
>+	unsigned long size;
>+
>+	/*
>+	 * Don't both accounting for VFs that could be created after this
>+	 * since preserving VFs is not supported yet. Also don't account
>+	 * for devices that could be hot-plugged after this since preserving
>+	 * hot-plugged devices across Live Update is not yet an expected
>+	 * use-case.
>+	 */
>+	for_each_pci_dev(dev)
>+		max_nr_devices++;
>+
>+	size = struct_size_t(struct pci_ser, devices, max_nr_devices);
>+
>+	ser = kho_alloc_preserve(size);
>+	if (IS_ERR(ser))
>+		return PTR_ERR(ser);
>+
>+	ser->max_nr_devices = max_nr_devices;
>+
>+	args->obj = ser;
>+	args->data = virt_to_phys(ser);
>+	return 0;
>+}
>+
>+static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
>+{
>+	struct pci_ser *ser = args->obj;
>+
>+	WARN_ON_ONCE(ser->nr_devices);
>+	kho_unpreserve_free(ser);
>+}
>+
>+static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
>+{
>+	args->obj = phys_to_virt(args->data);
>+	return 0;
>+}
>+
>+static void pci_flb_finish(struct liveupdate_flb_op_args *args)
>+{
>+	kho_restore_free(args->obj);
>+}
>+
>+static struct liveupdate_flb_ops pci_liveupdate_flb_ops = {
>+	.preserve = pci_flb_preserve,
>+	.unpreserve = pci_flb_unpreserve,
>+	.retrieve = pci_flb_retrieve,
>+	.finish = pci_flb_finish,
>+	.owner = THIS_MODULE,
>+};
>+
>+static struct liveupdate_flb pci_liveupdate_flb = {
>+	.ops = &pci_liveupdate_flb_ops,
>+	.compatible = PCI_LUO_FLB_COMPATIBLE,
>+};
>+
>+#define INIT_PCI_DEV_SER(_dev) {		\
>+	.domain = pci_domain_nr((_dev)->bus),	\
>+	.bdf = pci_dev_id(_dev),		\
>+}
>+
>+static int pci_dev_ser_cmp(const void *__a, const void *__b)
>+{
>+	const struct pci_dev_ser *a = __a, *b = __b;
>+
>+	return cmp_int((u64)a->domain << 16 | a->bdf,
>+		       (u64)b->domain << 16 | b->bdf);
>+}
>+
>+static struct pci_dev_ser *pci_ser_find(struct pci_ser *ser,
>+					struct pci_dev *dev)
>+{
>+	const struct pci_dev_ser key = INIT_PCI_DEV_SER(dev);
>+
>+	return bsearch(&key, ser->devices, ser->nr_devices,
>+		       sizeof(key), pci_dev_ser_cmp);
>+}
>+
>+static void pci_ser_delete(struct pci_ser *ser, struct pci_dev *dev)
>+{
>+	struct pci_dev_ser *dev_ser;
>+	int i;
>+
>+	dev_ser = pci_ser_find(ser, dev);
>+
>+	/*
>+	 * This should never happen unless there is a kernel bug or
>+	 * corruption that causes the state in struct pci_ser to get
>+	 * out of sync with struct pci_dev.
>+	 */
>+	if (pci_WARN_ONCE(dev, !dev_ser, "Cannot find preserved device!"))
>+		return;
>+
>+	for (i = dev_ser - ser->devices; i < ser->nr_devices - 1; i++)
>+		ser->devices[i] = ser->devices[i + 1];
>+
>+	ser->nr_devices--;
>+}
>+
>+int pci_liveupdate_preserve(struct pci_dev *dev)
>+{
>+	struct pci_dev_ser new = INIT_PCI_DEV_SER(dev);
>+	struct pci_ser *ser;
>+	int i, ret;
>+
>+	/* SR-IOV is not supported yet. */
>+	if (dev->is_virtfn || dev->is_physfn)
>+		return -EINVAL;

This check for "is_physfn" is new in this version of the series,
previously it was only checking for is_virtfn. If I understand
correctly, this means a PF device that has SRIOV capability will not be
presereved. Shouldn't we be able to preserve such PFs without preserving
the underlying VFs and SRIOV bits?
>+
>+	guard(mutex)(&pci_flb_outgoing_lock);
>+
>+	if (dev->liveupdate_outgoing)
>+		return -EBUSY;
>+
>+	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&ser);
>+	if (ret)
>+		return ret;
>+
>+	if (ser->nr_devices == ser->max_nr_devices)
>+		return -E2BIG;
>+
>+	for (i = ser->nr_devices; i > 0; i--) {
>+		struct pci_dev_ser *prev = &ser->devices[i - 1];
>+		int cmp = pci_dev_ser_cmp(&new, prev);
>+
>+		/*
>+		 * This should never happen unless there is a kernel bug or
>+		 * corruption that causes the state in struct pci_ser to get out
>+		 * of sync with struct pci_dev.
>+		 */
>+		if (WARN_ON_ONCE(!cmp))
>+			return -EBUSY;
>+
>+		if (cmp > 0)
>+			break;
>+
>+		ser->devices[i] = *prev;
>+	}
>+
>+	ser->devices[i] = new;
>+	ser->nr_devices++;
>+	dev->liveupdate_outgoing = true;
>+	return 0;
>+}
>+EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
>+
>+void pci_liveupdate_unpreserve(struct pci_dev *dev)
>+{
>+	struct pci_ser *ser;
>+	int ret;
>+
>+	/* This should never happen unless the caller (driver) is buggy */
>+	if (WARN_ON_ONCE(!dev->liveupdate_outgoing))
>+		return;
>+
>+	guard(mutex)(&pci_flb_outgoing_lock);
>+
>+	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&ser);
>+
>+	/* This should never happen unless there is a bug in LUO */
>+	if (WARN_ON_ONCE(ret))
>+		return;
>+
>+	pci_ser_delete(ser, dev);
>+	dev->liveupdate_outgoing = false;
>+}
>+EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
>+
>+static int pci_liveupdate_flb_get_incoming(struct pci_ser **serp)
>+{
>+	int ret;
>+
>+	ret = liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **)serp);
>+
>+	/* Live Update is not enabled. */
>+	if (ret == -EOPNOTSUPP)
>+		return ret;
>+
>+	/* Live Update is enabled, but there is no incoming FLB data. */
>+	if (ret == -ENODATA)
>+		return ret;
>+
>+	/*
>+	 * Live Update is enabled and there is incoming FLB data, but none of it
>+	 * matches pci_liveupdate_flb.compatible.
>+	 *
>+	 * This could mean that no PCI FLB data was passed by the previous
>+	 * kernel, but it could also mean the previous kernel used a different
>+	 * compatibility string (i.e.a different ABI). The latter deserves at
>+	 * least a WARN_ON_ONCE() but it cannot be distinguished from the
>+	 * former.
>+	 */
>+	if (ret == -ENOENT) {
>+		pr_info_once("PCI: No incoming FLB data detected during Live Update");
>+		return ret;
>+	}
>+
>+	/*
>+	 * There is incoming FLB data that matches pci_liveupdate_flb.compatible
>+	 * but it cannot be retrieved. Proceed with standard initialization as
>+	 * if there was not incoming PCI FLB data.
>+	 */
>+	WARN_ONCE(ret, "PCI: Failed to retrieve incoming FLB data during Live Update");
>+	return ret;
>+}
>+
>+u32 pci_liveupdate_incoming_nr_devices(void)
>+{
>+	struct pci_ser *ser;
>+
>+	if (pci_liveupdate_flb_get_incoming(&ser))
>+		return 0;
>+
>+	return ser->nr_devices;
>+}
>+
>+void pci_liveupdate_setup_device(struct pci_dev *dev)
>+{
>+	struct pci_ser *ser;
>+
>+	if (pci_liveupdate_flb_get_incoming(&ser))
>+		return;
>+
>+	if (!pci_ser_find(ser, dev))
>+		return;
>+
>+	dev->liveupdate_incoming = true;
>+}
>+
>+int pci_liveupdate_retrieve(struct pci_dev *dev)
>+{
>+	if (!dev->liveupdate_incoming)
>+		return -EINVAL;
>+
>+	return 0;
>+}
>+EXPORT_SYMBOL_GPL(pci_liveupdate_retrieve);
>+
>+void pci_liveupdate_finish(struct pci_dev *dev)
>+{
>+	dev->liveupdate_incoming = false;
>+}
>+EXPORT_SYMBOL_GPL(pci_liveupdate_finish);
>+
>+int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
>+{
>+	return liveupdate_register_flb(fh, &pci_liveupdate_flb);
>+}
>+EXPORT_SYMBOL_GPL(pci_liveupdate_register_flb);
>+
>+void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh)
>+{
>+	liveupdate_unregister_flb(fh, &pci_liveupdate_flb);
>+}
>+EXPORT_SYMBOL_GPL(pci_liveupdate_unregister_flb);
>diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>index 13d998fbacce..979cb9921340 100644
>--- a/drivers/pci/pci.h
>+++ b/drivers/pci/pci.h
>@@ -1434,4 +1434,18 @@ static inline int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int inde
> 	(PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
> 	 PCI_CONF1_EXT_REG(reg))
>
>+#ifdef CONFIG_PCI_LIVEUPDATE
>+void pci_liveupdate_setup_device(struct pci_dev *dev);
>+u32 pci_liveupdate_incoming_nr_devices(void);
>+#else
>+static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
>+{
>+}
>+
>+static inline u32 pci_liveupdate_incoming_nr_devices(void)
>+{
>+	return 0;
>+}
>+#endif
>+
> #endif /* DRIVERS_PCI_H */
>diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>index bccc7a4bdd79..c60222d45659 100644
>--- a/drivers/pci/probe.c
>+++ b/drivers/pci/probe.c
>@@ -2064,6 +2064,8 @@ int pci_setup_device(struct pci_dev *dev)
> 	if (pci_early_dump)
> 		early_dump_pci_device(dev);
>
>+	pci_liveupdate_setup_device(dev);
>+
> 	/* Need to have dev->class ready */
> 	dev->cfg_size = pci_cfg_space_size(dev);
>
>diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
>new file mode 100644
>index 000000000000..7764795f6818
>--- /dev/null
>+++ b/include/linux/kho/abi/pci.h
>@@ -0,0 +1,62 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+
>+/*
>+ * Copyright (c) 2025, Google LLC.
>+ * David Matlack <dmatlack@google.com>
>+ */
>+
>+#ifndef _LINUX_KHO_ABI_PCI_H
>+#define _LINUX_KHO_ABI_PCI_H
>+
>+#include <linux/bug.h>
>+#include <linux/compiler.h>
>+#include <linux/types.h>
>+
>+/**
>+ * DOC: PCI File-Lifecycle Bound (FLB) Live Update ABI
>+ *
>+ * This header defines the ABI for preserving core PCI state across kexec using
>+ * Live Update File-Lifecycle Bound (FLB) data.
>+ *
>+ * This interface is a contract. Any modification to any of the serialization
>+ * structs defined here constitutes a breaking change. Such changes require
>+ * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE string.
>+ */
>+
>+#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
>+
>+/**
>+ * struct pci_dev_ser - Serialized state about a single PCI device.
>+ *
>+ * @domain: The device's PCI domain number (segment).
>+ * @bdf: The device's PCI bus, device, and function number.
>+ * @reserved: Reserved (to naturally align struct pci_dev_ser).
>+ */
>+struct pci_dev_ser {
>+	u32 domain;
>+	u16 bdf;
>+	u16 reserved;
>+} __packed;
>+
>+/**
>+ * struct pci_ser - PCI Subsystem Live Update State
>+ *
>+ * This struct tracks state about all devices that are being preserved across
>+ * a Live Update for the next kernel.
>+ *
>+ * @max_nr_devices: The length of the devices[] flexible array.
>+ * @nr_devices: The number of devices that were preserved.
>+ * @devices: Flexible array of pci_dev_ser structs for each device. Guaranteed
>+ *           to be sorted ascending by domain and bdf.
>+ */
>+struct pci_ser {
>+	u64 max_nr_devices;
>+	u64 nr_devices;
>+	struct pci_dev_ser devices[];
>+} __packed;
>+
>+/* Ensure all elements of devices[] are naturally aligned. */
>+static_assert(offsetof(struct pci_ser, devices) % sizeof(unsigned long) == 0);
>+static_assert(sizeof(struct pci_dev_ser) % sizeof(unsigned long) == 0);
>+
>+#endif /* _LINUX_KHO_ABI_PCI_H */
>diff --git a/include/linux/pci.h b/include/linux/pci.h
>index 1c270f1d5123..27ee9846a2fd 100644
>--- a/include/linux/pci.h
>+++ b/include/linux/pci.h
>@@ -40,6 +40,7 @@
> #include <linux/resource_ext.h>
> #include <linux/msi_api.h>
> #include <uapi/linux/pci.h>
>+#include <linux/liveupdate.h>
>
> #include <linux/pci_ids.h>
>
>@@ -591,6 +592,10 @@ struct pci_dev {
> 	u8		tph_mode;	/* TPH mode */
> 	u8		tph_req_type;	/* TPH requester type */
> #endif
>+#ifdef CONFIG_PCI_LIVEUPDATE
>+	unsigned int	liveupdate_incoming:1;	/* Preserved by previous kernel */
>+	unsigned int	liveupdate_outgoing:1;	/* Preserved for next kernel */
>+#endif
> };
>
> static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
>@@ -2871,4 +2876,40 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
> 	WARN_ONCE(condition, "%s %s: " fmt, \
> 		  dev_driver_string(&(pdev)->dev), pci_name(pdev), ##arg)
>
>+#ifdef CONFIG_PCI_LIVEUPDATE
>+int pci_liveupdate_preserve(struct pci_dev *dev);
>+void pci_liveupdate_unpreserve(struct pci_dev *dev);
>+int pci_liveupdate_retrieve(struct pci_dev *dev);
>+void pci_liveupdate_finish(struct pci_dev *dev);
>+int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh);
>+void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh);
>+#else
>+static inline int pci_liveupdate_preserve(struct pci_dev *dev)
>+{
>+	return -EOPNOTSUPP;
>+}
>+
>+static inline void pci_liveupdate_unpreserve(struct pci_dev *dev)
>+{
>+}
>+
>+static inline int pci_liveupdate_retrieve(struct pci_dev *dev)
>+{
>+	return -EOPNOTSUPP;
>+}
>+
>+static inline void pci_liveupdate_finish(struct pci_dev *dev)
>+{
>+}
>+
>+static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
>+{
>+	return -EOPNOTSUPP;
>+}
>+
>+static inline void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh)
>+{
>+}
>+#endif
>+
> #endif /* LINUX_PCI_H */
>-- 
>2.53.0.983.g0bb29b3bc5-goog
>

