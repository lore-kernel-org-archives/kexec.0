Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B22C4450A
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 15:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H3w9lxehSFy6bEWUAEqWnKleB5eNdNwWh1m/SMhRNo4=; b=NER/z/FwFM7H129YgydXtQlCoS
	ytMxacDx7RGrcalF5/2xNuH7iRMIpFgeyucsQ4P1vw+zRakWdQ7aKYHydbKOtjvb587gkHu6+thiK
	uUmnfoUSzVryRuNim2rJZ9HViNtT7vWr0RqxJUed8mlw+uprjdCAbNH92DKJuZUEpVZTIFvqdA8eZ
	j5P6YY/mKTlmOCI+95ePV5vobbSC+KE/rmEo4KD/CnpJww0P9+bbBR0l0lDEymAlUmatqI4J6BCxe
	O2dsXo0blJKm0YcFOFKilIEzLCUIsEvMLi12cBgQ87D7fN1FOYleEqU4Bu+bI38njnRGdaUVBBrvo
	gnjicumw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjeqw-0000000CUC1-3GdS;
	Tue, 14 Jul 2026 15:15:22 +0000
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjeqs-0000000CU5i-0Iwz
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 15:15:19 +0000
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-848860def2cso4614497b3a.2
        for <kexec@lists.infradead.org>; Tue, 14 Jul 2026 08:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042117; x=1784646917; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H3w9lxehSFy6bEWUAEqWnKleB5eNdNwWh1m/SMhRNo4=;
        b=Pcb0Msl70jqKiwfQvZCSoUkZIC23ey8N8+8lMFmkaxZhJd6AM4mDj1wqk9qhz+uXQP
         cPBOiyLVBLnAdmTtxUBFACBU2bKFQKrQrarEUA7SjyHZp5aH9dwz/Si5Umla1oE+sRdC
         y7AWArzdPxUfUt6xvb2wzbkqX2gH/vBFG9pblZDECFZb8Wuk/U/nEbH19tmvU2uCOLMt
         kHD2+nvk/VeY6I4cRTyhB0nPHOoL1nWB6UmsIR/SD1Vf8zLJYdoVHF7hURkGNqNkuG1u
         n0ua5kEgm8rUEzG8jpi2YlxywLsvrRTxeEk48H0XrC5Vy7v5iA8cTFG/mDcMyHVPR0bW
         i9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042117; x=1784646917;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H3w9lxehSFy6bEWUAEqWnKleB5eNdNwWh1m/SMhRNo4=;
        b=U7hIaEvoDeHErI0WmXm7osntKEmxdXlwWsjscqKijYmMCU9PN/dvHVXcXyJcjK73GC
         K6IbIbBeu2B5tC3TGAlAXn5l3ZatubgD1EReHz+BBOgKgbIjEO9TxSaEQP/1CXeDQFRF
         VANNx4O0Pk5NmhnQ4UI0pl3M1Z5VWag7VYtOgreCQ3wpsQKNn/Xrf9FZVN8oYB+tAGL+
         iBwVw6El/yx4+XDrs1EHd1EyW9HAoLDHbUUJy0CaaYKmY+aGhHbAgY/uIXUCaZaiPq6t
         nwL2kCRwIPZ33A57BeBBe9Muah+4jz8M2ajY96X52qLonhBxmjVV6cft8amIEp3IdBRu
         sxKw==
X-Gm-Message-State: AOJu0YwinmslInHyRG9Y9pcic25h26x2ktM8KxIZt8XFZ3F9JxBHg1M9
	VwC82rQ8prR0s02cc4k2kY93f5QIucNEOGpI9fD/G2i9rGaglCzhFxO1/yrqNLC8M4MdWwCnDBX
	EobgPsha7fOFjIbSpc6HX6gvQHI/NLh5JCPxB+sIXWU55qLKr8gPOWwKfMxXX+6bJveVz/Iqujn
	k7d4Ab8jOdu1oz/UNjFAYJaPQCbYBSLzGdElXDuYCqgXUb1g==
X-Received: from pfez10.prod.google.com ([2002:aa7:888a:0:b0:848:492a:5b41])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:17a6:b0:847:980d:71f8
 with SMTP id d2e1a72fcca58-848896349ddmr12405772b3a.15.1784042115712; Tue, 14
 Jul 2026 08:15:15 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:14:51 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-7-vipinsh@google.com>
Subject: [PATCH v5 06/20] vfio/pci: Preserve vfio-pci device files across Live Update
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rientjes@google.com, rodrigo.vivi@intel.com, 
	rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vipinsh@google.com, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, 
	yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_081518_145762_D0F4870E 
X-CRM114-Status: GOOD (  39.96  )
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

Implement the Live Update file handler callbacks to preserve a vfio-pci
device across a Live Update. Subsequent commits will enable userspace to
then retrieve this file after the Live Update.

State about each device is serialized into a new ABI struct,
vfio_pci_core_device_ser. The contents of this struct are preserved
across the Live Update to the next kernel using a combination of
Kexec-Handover (KHO) to preserve the page(s) holding the struct, and
the Live Update Orchestrator (LUO) to preserve the physical address of
the struct.

For now, the only contents of struct vfio_pci_core_device_ser are the
device's PCI segment number and BDF, ensuring the device can be uniquely
identified after the Live Update.

Key design notes and constraints:

 * Device state before kexec: Userspace is required to disable
   interrupts on the device and ensure it is in the D0 power state.
   This ensures the device does not send any interrupts until new
   handlers are set up by the next kernel.

 * Device reset during freeze: The device is reset and its state
   is restored in the freeze() callback, ensuring the next kernel
   receives it in a consistent state. Eventually, this will be
   dropped so the device can be preserved in a running state, but
   that requires further work in VFIO and the core PCI layer.

 * FD usability after freeze: Once the device is frozen, the VFIO
   device FD becomes unusable (i.e., ioctls and memory accesses will
   return errors) because the device may have already been reset.
   If the freeze operation fails, userspace must close the FD and
   reinitialize the device.

 * Lifecycle: LUO holds a reference to this file while it is preserved.
   Therefore, VFIO is guaranteed that vfio_df_device_last_close() will
   not be called on this device until userspace has unpreserved the
   file via LUO.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/Kconfig               |   2 +-
 drivers/vfio/pci/vfio_pci_config.c     |   3 +
 drivers/vfio/pci/vfio_pci_core.c       |  15 ++
 drivers/vfio/pci/vfio_pci_liveupdate.c | 198 ++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h       |   9 ++
 include/linux/kho/abi/vfio_pci.h       |  15 ++
 include/linux/vfio_pci_core.h          |   3 +
 7 files changed, 242 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index c12d614fc6c4..d97c809599fa 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -45,7 +45,7 @@ config VFIO_PCI_IGD
 
 config VFIO_PCI_LIVEUPDATE
 	bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
-	depends on PCI_LIVEUPDATE
+	depends on PCI_LIVEUPDATE && VFIO_DEVICE_CDEV
 	help
 	  Support for preserving devices bound to vfio-pci across a Live
 	  Update. This option should only be enabled by developers working on
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index a10ed733f0e3..a51805515d30 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -406,6 +406,9 @@ bool __vfio_pci_memory_enabled(struct vfio_pci_core_device *vdev)
 	struct pci_dev *pdev = vdev->pdev;
 	u16 cmd = le16_to_cpu(*(__le16 *)&vdev->vconfig[PCI_COMMAND]);
 
+	if (vfio_pci_dev_is_frozen(vdev))
+		return false;
+
 	/*
 	 * Memory region cannot be accessed if device power state is D3.
 	 *
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index f31e59e5badb..c312b0eaf7d0 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1087,6 +1087,9 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
 	struct pci_dev *pdev = vdev->pdev;
 	int i, ret;
 
+	if (vfio_pci_dev_is_frozen(vdev))
+		return -EIO;
+
 	switch (info->index) {
 	case VFIO_PCI_CONFIG_REGION_INDEX:
 		info->offset = VFIO_PCI_INDEX_TO_OFFSET(info->index);
@@ -1513,6 +1516,9 @@ long vfio_pci_core_ioctl(struct vfio_device *core_vdev, unsigned int cmd,
 		container_of(core_vdev, struct vfio_pci_core_device, vdev);
 	void __user *uarg = (void __user *)arg;
 
+	if (vfio_pci_dev_is_frozen(vdev))
+		return -EIO;
+
 	switch (cmd) {
 	case VFIO_DEVICE_GET_INFO:
 		return vfio_pci_ioctl_get_info(vdev, uarg);
@@ -1567,6 +1573,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 	struct vfio_pci_core_device *vdev =
 		container_of(device, struct vfio_pci_core_device, vdev);
 
+	if (vfio_pci_dev_is_frozen(vdev))
+		return -EIO;
+
 	switch (flags & VFIO_DEVICE_FEATURE_MASK) {
 	case VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY:
 		return vfio_pci_core_pm_entry(vdev, flags, arg, argsz);
@@ -1591,6 +1600,9 @@ static ssize_t vfio_pci_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 	unsigned int index = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
 	int ret;
 
+	if (vfio_pci_dev_is_frozen(vdev))
+		return -EIO;
+
 	if (index >= VFIO_PCI_NUM_REGIONS + vdev->num_regions)
 		return -EINVAL;
 
@@ -1775,6 +1787,9 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 	u64 phys_len, req_len, pgoff, req_start;
 	void __iomem *bar_io;
 
+	if (vfio_pci_dev_is_frozen(vdev))
+		return -EIO;
+
 	index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
 
 	if (index >= VFIO_PCI_NUM_REGIONS + vdev->num_regions)
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 803528c9f1b2..e6eb7f6b53d7 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -6,28 +6,221 @@
  * David Matlack <dmatlack@google.com>
  */
 
+/**
+ * DOC: VFIO PCI Preservation via LUO
+ *
+ * VFIO PCI devices can be preserved over a kexec using the Live Update
+ * Orchestrator (LUO) file preservation. This allows userspace (such as a VMM)
+ * to transfer an in-use device to the next kernel.
+ *
+ * .. note::
+ *    The support for preserving VFIO PCI devices is currently *partial* and
+ *    should be considered *experimental*. It should only be used by developers
+ *    working on expanding the support for the time being.
+ *
+ *    To avoid accidental usage while the support is still experimental, this
+ *    support is hidden behind a default-disable config option
+ *    ``CONFIG_VFIO_PCI_LIVEUPDATE``. Once the kernel support has stabilized and
+ *    become complete, this option will be enabled by default when
+ *    ``CONFIG_VFIO_PCI`` and ``CONFIG_PCI_LIVEUPDATE`` are enabled.
+ *
+ * Usage Example
+ * =============
+ *
+ * VFIO PCI devices can be preserved across a kexec by preserving the file
+ * associated with the device in a LUO session::
+ *
+ *   device_fd = open("/dev/vfio/devices/vfioX");
+ *   ...
+ *   ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, { ..., device_fd, ...});
+ *
+ * .. note::
+ *    LUO will hold an extra reference to the device file for as long as it is
+ *    preserved, so there is no way for the file to be destroyed or the device
+ *    to be unbound from the vfio-pci driver while it is preserved.
+ *
+ * Retrieving the file after kexec is not yet supported.
+ *
+ * Restrictions
+ * ============
+ *
+ * The kernel imposes the following restrictions when preserving VFIO devices:
+ *
+ *  * The device must be bound to the ``vfio-pci`` driver.
+ *
+ *  * ``CONFIG_VFIO_PCI_ZDEV_KVM`` must not be enabled. This may be relaxed in
+ *    the future.
+ *
+ *  * The device must not be an Intel display device. This may be relaxed in
+ *    the future.
+ *
+ *  * The device file descriptor must be obtained by opening the VFIO character
+ *    device (``/dev/vfio/devices/vfioX``) and not via
+ *    ``VFIO_GROUP_GET_DEVICE_FD``.
+ *
+ *  * The device must meet following conditions prior to kexec without which the
+ *    ``reboot(LINUX_REBOOT_CMD_KEXEC)`` syscall (to initiate the kexec) will
+ *    fail.
+ *
+ *    - The device must have interrupt disabled.
+ *    - The device must be in D0 state.
+ *
+ * In addition, the device must meet all of the restrictions imposed by the
+ * core PCI layer documented at :doc:`/PCI/liveupdate`.
+ *
+ * Preservation Behavior
+ * =====================
+ *
+ * The eventual goal of this support is to avoid disrupting the workload, state,
+ * or configuration of each preserved device during a Live Update. This would
+ * include allowing the device to perform DMA to preserved memory buffers and
+ * perform P2P DMA to other preserved devices. However, there are many pieces
+ * that still need to land in the kernel.
+ *
+ * For now, VFIO only preserves the following state for devices:
+ *
+ *  * The PCI Segment, Bus, Device, and Function numbers of the device. The
+ *    kernel guarantees the these will not change across a kexec when a device
+ *    is preserved.
+ *
+ * Since the kernel is not yet prepared to preserve all parts of the device and
+ * its dependencies (such as DMA mappings), VFIO currently resets and restores
+ * preserved devices back into an idle state during kexec, before handing off
+ * control to the next kernel. This will be relaxed in future versions of the
+ * kernel once it is safe to allow the device to keep running across kexec.
+ */
+
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/errno.h>
+#include <linux/kexec_handover.h>
 #include <linux/kho/abi/vfio_pci.h>
 #include <linux/liveupdate.h>
 #include <linux/module.h>
+#include <linux/vfio.h>
 
 #include "vfio_pci_priv.h"
 
 static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
 					     struct file *file)
 {
-	return false;
+	struct vfio_device *device = vfio_device_from_file(file);
+	struct vfio_pci_core_device *vdev;
+	struct pci_dev *pdev;
+
+	if (!device)
+		return false;
+
+	/* Live Update support is limited to cdev files. */
+	if (!vfio_device_cdev_opened(device))
+		return false;
+
+	if (device->ops != &vfio_pci_ops)
+		return false;
+
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+	pdev = vdev->pdev;
+
+	/*
+	 * Don't support specialized vfio-pci devices for now since they haven't
+	 * been tested.
+	 */
+	if (IS_ENABLED(CONFIG_VFIO_PCI_ZDEV_KVM) || vfio_pci_is_intel_display(pdev))
+		return false;
+
+	/* Only non-VFs are supported for now. */
+	if (pdev->is_virtfn)
+		return false;
+
+	return true;
 }
 
 static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 {
-	return -EOPNOTSUPP;
+	struct vfio_device *device = vfio_device_from_file(args->file);
+	struct vfio_pci_core_device_ser *ser;
+	struct vfio_pci_core_device *vdev;
+	struct pci_dev *pdev;
+	int ret;
+
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+	pdev = vdev->pdev;
+
+	ret = pci_liveupdate_preserve(pdev);
+	if (ret)
+		return ret;
+
+	ser = kho_alloc_preserve(sizeof(*ser));
+	if (IS_ERR(ser)) {
+		ret = PTR_ERR(ser);
+		goto err_unpreserve;
+	}
+
+	ser->bdf = pci_dev_id(pdev);
+	ser->domain = pci_domain_nr(pdev->bus);
+
+	args->serialized_data = virt_to_phys(ser);
+	return 0;
+
+err_unpreserve:
+	pci_liveupdate_unpreserve(pdev);
+	return ret;
 }
 
 static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
 {
+	struct vfio_device *device = vfio_device_from_file(args->file);
+
+	pci_liveupdate_unpreserve(to_pci_dev(device->dev));
+	kho_unpreserve_free(phys_to_virt(args->serialized_data));
+}
+
+static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *args)
+{
+	struct vfio_device *device = vfio_device_from_file(args->file);
+	struct vfio_pci_core_device *vdev;
+	struct pci_dev *pdev;
+
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+	pdev = vdev->pdev;
+
+	guard(mutex)(&device->dev_set->lock);
+	guard(mutex)(&vdev->igate);
+	guard(rwsem_write)(&vdev->memory_lock);
+
+	/*
+	 * Userspace must disable interrupts on the device prior to freeze so
+	 * that the device does not send any interrupts until new interrupt
+	 * handlers have been established by the next kernel.
+	 */
+	if (vdev->irq_type != VFIO_PCI_NUM_IRQS) {
+		pci_err(pdev, "Freeze failed! Interrupts are still enabled.\n");
+		return -EINVAL;
+	}
+
+	if (pdev->current_state != PCI_D0) {
+		pci_err(pdev, "Freeze failed! Device not in D0 state.\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Reset is a temporary measure to provide kernel after kexec a clean
+	 * device while VFIO live update work is under development and not
+	 * fully supported. It will go away once continuous DMA support is
+	 * added to device preservation.
+	 */
+	vfio_pci_zap_bars(vdev);
+	vfio_pci_dma_buf_move(vdev, true);
+	vfio_pci_core_try_reset(vdev);
+	pci_write_config_word(pdev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
+	/*
+	 * Userspace cannot use the FD correctly now irrespective of liveupdate
+	 * freeze failing or succeeding. They will have to reinitialize the VFIO
+	 * device to continue using it as reset might have loaded default PCI
+	 * state. Disable ioctl, read, write and mmap access to the device.
+	 */
+	smp_store_release(&vdev->liveupdate_frozen, true);
+	return 0;
 }
 
 static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
@@ -43,6 +236,7 @@ static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
 	.can_preserve = vfio_pci_liveupdate_can_preserve,
 	.preserve = vfio_pci_liveupdate_preserve,
 	.unpreserve = vfio_pci_liveupdate_unpreserve,
+	.freeze = vfio_pci_liveupdate_freeze,
 	.retrieve = vfio_pci_liveupdate_retrieve,
 	.finish = vfio_pci_liveupdate_finish,
 	.owner = THIS_MODULE,
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 5d2ad128523d..4b65753e8936 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -145,6 +145,11 @@ static inline void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev,
 #ifdef CONFIG_VFIO_PCI_LIVEUPDATE
 int __init vfio_pci_liveupdate_init(void);
 void vfio_pci_liveupdate_cleanup(void);
+static inline bool vfio_pci_dev_is_frozen(struct vfio_pci_core_device *vdev)
+{
+	/* Written in VFIO PCI Liveupdate during freeze() event */
+	return smp_load_acquire(&vdev->liveupdate_frozen);
+}
 #else
 static inline int vfio_pci_liveupdate_init(void)
 {
@@ -154,6 +159,10 @@ static inline int vfio_pci_liveupdate_init(void)
 static inline void vfio_pci_liveupdate_cleanup(void)
 {
 }
+static inline bool vfio_pci_dev_is_frozen(struct vfio_pci_core_device *vdev)
+{
+	return false;
+}
 #endif /* CONFIG_VFIO_PCI_LIVEUPDATE */
 
 #endif
diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
index 67e8199eec59..229a13ac1e52 100644
--- a/include/linux/kho/abi/vfio_pci.h
+++ b/include/linux/kho/abi/vfio_pci.h
@@ -9,6 +9,9 @@
 #ifndef _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
 #define _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
 
+#include <linux/compiler.h>
+#include <linux/types.h>
+
 /**
  * DOC: VFIO PCI Live Update ABI
  *
@@ -25,4 +28,16 @@
 
 #define VFIO_PCI_LUO_FH_COMPATIBLE "vfio-pci-v1"
 
+/**
+ * struct vfio_pci_core_device_ser - Serialized state of a single VFIO PCI
+ * device.
+ *
+ * @domain: The device's PCI domain number (segment).
+ * @bdf: The device's PCI bus, device, and function number.
+ */
+struct vfio_pci_core_device_ser {
+	u32 domain;
+	u16 bdf;
+} __packed;
+
 #endif /* _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H */
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 5fc6ce4dd786..adc5d05456bd 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -143,6 +143,9 @@ struct vfio_pci_core_device {
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
 	struct list_head	dmabufs;
+#ifdef CONFIG_VFIO_PCI_LIVEUPDATE
+	bool			liveupdate_frozen;
+#endif
 };
 
 enum vfio_pci_io_width {
-- 
2.55.0.795.g602f6c329a-goog


