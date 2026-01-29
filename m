Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0135D73E8C
	for <kexec@archiver.kernel.org>; Thu, 29 Jan 2026 21:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+aO6tJGKcRtg/TIeiT23MNEgzxzjjKFBFfPz6SwCjTg=; b=3UGVvnryRve4+9mpbeV328Idvj
	o4/a7V575a9akYDsBOQuxntypcH3FyMPAUZqndHF0hKlyigFlY3n2VzHxZDylAKhL/MXHRRSxLJ55
	CcPW44sH/QhfVGr+Ne3d53qRTbvYzzAe0s2wGqALXARHHkArbLGMvejOO0CGJnvx+KUSNUY2VDK2b
	3ahN/tfRyTJm6Uin1kgch0oVkgXVaUJsPxsUU64Cb0O3tLZoco3O48SUo8H5BK/iyAknxn0i9z8DY
	cd8Wj0BRxQRy+KaEIae2q0U9CbF+TWuEkdsM1C/sfrNXLX1G6eEA/vC8/a9JSqqpunh/hr/fbk9uU
	ewHa2MfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWR-00000000fHY-3Jev;
	Thu, 29 Jan 2026 21:25:51 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWO-00000000fCw-0iHA
	for kexec@lists.infradead.org;
	Thu, 29 Jan 2026 21:25:49 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2a7d7b87977so12683915ad.0
        for <kexec@lists.infradead.org>; Thu, 29 Jan 2026 13:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769721946; x=1770326746; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+aO6tJGKcRtg/TIeiT23MNEgzxzjjKFBFfPz6SwCjTg=;
        b=BLwd8PG3/23TH3vT4XwG5OFI44wh67juepg7Sw0vpCJOlWsC/wqTRreukvl0Q59b94
         rGdBEwOKu4chzf75wTKciLxGftlTvMGghJTc1c5nLdYJxhJH5uB/sYqJv+/PeBYPThpo
         lAlTZwOtTrz5clzSUDJeh9EOktQ3ddXnsNGyM1kJPkGnWR0EzxWNKson/ngxb3+bBrk7
         EYP/2lNkA87rvzyCgrff1Hh518H5wFR+HSPxgvIa0C4KjUErEgsNyTT8iY4oWaRYYt6R
         bzJePpSPiAtdmwTbubRg+dsxxluUEKbzB9Yj7YeL/Fhi0hYnVoHHLptFrVEGEwHxSSGh
         3Xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769721946; x=1770326746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+aO6tJGKcRtg/TIeiT23MNEgzxzjjKFBFfPz6SwCjTg=;
        b=fSzH5LLZQbmxYWGwHHt28orlluYH2Qw6HU0Z+GYU9yPiTd1vJ4yx7BTxLYoaw0ev8s
         3cVuyI1Z9wbGGHm4EXXgU4pA28z2tQro7b+GuJkWdrfgRcpByJEv7ZL95Va9N04xwkyF
         3uDzs1QxMhVmVK/6KonoMOh/SD0Eim47a1XHej+5HDIg2MR5w1f63hJqMPN/5xhuCcFy
         sKQq2oUo+awHQXDS3dP/J7zxrHAtCHUDEhX+FBMYuhOfLfBRqJ7uSllSKfm3eWMyt1dt
         f4BvoFNMkj9QgGA052WGW82nva++BVQLhG8vWI22o9GVujq2bFcPWuhhLQ5uem2YNxRP
         F+QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgfvqnGijM0LeWpdSWQqWKgt0jdVXF9/Gxt1IpYV2z2z+na8S0oXhcoNdMg1DTMHJ1r8LVsw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz9vAOGYcZho2QlPll1shl+ndDQHiYZ58ze0l4k9lBCmo9Flblj
	Mm//P4L7v3Yp9zwg/E59JgVTXdokyysKMTxVs3VIzNRTIjEaqF9KFeIg5jWRp2Lg2tzqPIwI5BR
	Qmaw+4uM4l4/CNg==
X-Received: from plrf4.prod.google.com ([2002:a17:902:ab84:b0:29d:5afa:2de])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c952:b0:295:3584:1bbd with SMTP id d9443c01a7336-2a8d8176d76mr6975245ad.41.1769721945885;
 Thu, 29 Jan 2026 13:25:45 -0800 (PST)
Date: Thu, 29 Jan 2026 21:24:52 +0000
In-Reply-To: <20260129212510.967611-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129212510.967611-6-dmatlack@google.com>
Subject: [PATCH v2 05/22] vfio/pci: Preserve vfio-pci device files across Live Update
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	"=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vipin Sharma <vipinsh@google.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260129_132548_241634_516C942C 
X-CRM114-Status: GOOD (  31.87  )
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

From: Vipin Sharma <vipinsh@google.com>

Implement the live update file handler callbacks to preserve a vfio-pci
device across a Live Update. Subsequent commits will enable userspace to
then retrieve this file after the Live Update.

Live Update support is scoped only to cdev files (i.e. not
VFIO_GROUP_GET_DEVICE_FD files).

State about each device is serialized into a new ABI struct
vfio_pci_core_device_ser. The contents of this struct are preserved
across the Live Update to the next kernel using a combination of
Kexec-Handover (KHO) to preserve the page(s) holding the struct and the
Live Update Orchestrator (LUO) to preserve the physical address of the
struct.

For now the only contents of struct vfio_pci_core_device_ser the
device's PCI segment number and BDF, so that the device can be uniquely
identified after the Live Update.

Require that userspace disables interrupts on the device prior to
freeze() so that the device does not send any interrupts until new
interrupt handlers have been set up by the next kernel.

Reset the device and restore its state in the freeze() callback. This
ensures the device can be received by the next kernel in a consistent
state. Eventually this will be dropped and the device can be preserved
across in a running state, but that requires further work in VFIO and
the core PCI layer.

Note that LUO holds a reference to this file when it is preserved. So
VFIO is guaranteed that vfio_df_device_last_close() will not be called
on this device no matter what userspace does.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/pci/vfio_pci.c            |  2 +-
 drivers/vfio/pci/vfio_pci_liveupdate.c | 84 +++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h       |  2 +
 drivers/vfio/vfio.h                    | 13 ----
 drivers/vfio/vfio_main.c               | 10 +--
 include/linux/kho/abi/vfio_pci.h       | 15 +++++
 include/linux/vfio.h                   | 28 +++++++++
 7 files changed, 129 insertions(+), 25 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 19e88322af2c..0260afb9492d 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -125,7 +125,7 @@ static int vfio_pci_open_device(struct vfio_device *core_vdev)
 	return 0;
 }
 
-static const struct vfio_device_ops vfio_pci_ops = {
+const struct vfio_device_ops vfio_pci_ops = {
 	.name		= "vfio-pci",
 	.init		= vfio_pci_core_init_dev,
 	.release	= vfio_pci_core_release_dev,
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index b84e63c0357b..f01de98f1b75 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -8,25 +8,104 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/kexec_handover.h>
 #include <linux/kho/abi/vfio_pci.h>
 #include <linux/liveupdate.h>
 #include <linux/errno.h>
+#include <linux/vfio.h>
 
 #include "vfio_pci_priv.h"
 
 static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
 					     struct file *file)
 {
-	return false;
+	struct vfio_device_file *df = to_vfio_device_file(file);
+
+	if (!df)
+		return false;
+
+	/* Live Update support is limited to cdev files. */
+	if (df->group)
+		return false;
+
+	return df->device->ops == &vfio_pci_ops;
 }
 
 static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 {
-	return -EOPNOTSUPP;
+	struct vfio_device *device = vfio_device_from_file(args->file);
+	struct vfio_pci_core_device_ser *ser;
+	struct vfio_pci_core_device *vdev;
+	struct pci_dev *pdev;
+
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+	pdev = vdev->pdev;
+
+	if (IS_ENABLED(CONFIG_VFIO_PCI_ZDEV_KVM))
+		return -EINVAL;
+
+	if (vfio_pci_is_intel_display(pdev))
+		return -EINVAL;
+
+	ser = kho_alloc_preserve(sizeof(*ser));
+	if (IS_ERR(ser))
+		return PTR_ERR(ser);
+
+	ser->bdf = pci_dev_id(pdev);
+	ser->domain = pci_domain_nr(pdev->bus);
+
+	args->serialized_data = virt_to_phys(ser);
+	return 0;
 }
 
 static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
 {
+	kho_unpreserve_free(phys_to_virt(args->serialized_data));
+}
+
+static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *args)
+{
+	struct vfio_device *device = vfio_device_from_file(args->file);
+	struct vfio_pci_core_device *vdev;
+	struct pci_dev *pdev;
+	int ret;
+
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+	pdev = vdev->pdev;
+
+	guard(mutex)(&device->dev_set->lock);
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
+	pci_dev_lock(pdev);
+
+	ret = pci_load_saved_state(pdev, vdev->pci_saved_state);
+	if (ret)
+		goto out;
+
+	/*
+	 * Reset the device and restore it back to its original state before
+	 * handing it to the next kernel.
+	 *
+	 * Eventually both of these should be dropped and the device should be
+	 * kept running with its current state across the Live Update.
+	 */
+	if (vdev->reset_works)
+		ret = __pci_reset_function_locked(pdev);
+
+	pci_restore_state(pdev);
+
+out:
+	pci_dev_unlock(pdev);
+	return ret;
 }
 
 static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
@@ -42,6 +121,7 @@ static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
 	.can_preserve = vfio_pci_liveupdate_can_preserve,
 	.preserve = vfio_pci_liveupdate_preserve,
 	.unpreserve = vfio_pci_liveupdate_unpreserve,
+	.freeze = vfio_pci_liveupdate_freeze,
 	.retrieve = vfio_pci_liveupdate_retrieve,
 	.finish = vfio_pci_liveupdate_finish,
 	.owner = THIS_MODULE,
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 68966ec64e51..d3da79b7b03c 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -11,6 +11,8 @@
 /* Cap maximum number of ioeventfds per device (arbitrary) */
 #define VFIO_PCI_IOEVENTFD_MAX		1000
 
+extern const struct vfio_device_ops vfio_pci_ops;
+
 struct vfio_pci_ioeventfd {
 	struct list_head	next;
 	struct vfio_pci_core_device	*vdev;
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 50128da18bca..6b89edbbf174 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -16,17 +16,6 @@ struct iommufd_ctx;
 struct iommu_group;
 struct vfio_container;
 
-struct vfio_device_file {
-	struct vfio_device *device;
-	struct vfio_group *group;
-
-	u8 access_granted;
-	u32 devid; /* only valid when iommufd is valid */
-	spinlock_t kvm_ref_lock; /* protect kvm field */
-	struct kvm *kvm;
-	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
-};
-
 void vfio_device_put_registration(struct vfio_device *device);
 bool vfio_device_try_get_registration(struct vfio_device *device);
 int vfio_df_open(struct vfio_device_file *df);
@@ -34,8 +23,6 @@ void vfio_df_close(struct vfio_device_file *df);
 struct vfio_device_file *
 vfio_allocate_device_file(struct vfio_device *device);
 
-extern const struct file_operations vfio_device_fops;
-
 #ifdef CONFIG_VFIO_NOIOMMU
 extern bool vfio_noiommu __read_mostly;
 #else
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index f7df90c423b4..276f615f0c28 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1436,15 +1436,7 @@ const struct file_operations vfio_device_fops = {
 	.show_fdinfo	= vfio_device_show_fdinfo,
 #endif
 };
-
-static struct vfio_device *vfio_device_from_file(struct file *file)
-{
-	struct vfio_device_file *df = file->private_data;
-
-	if (file->f_op != &vfio_device_fops)
-		return NULL;
-	return df->device;
-}
+EXPORT_SYMBOL_GPL(vfio_device_fops);
 
 /**
  * vfio_file_is_valid - True if the file is valid vfio file
diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
index 37a845eed972..9bf58a2f3820 100644
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
+ * @bdf: The device's PCI bus, device, and function number.
+ * @domain: The device's PCI domain number (segment).
+ */
+struct vfio_pci_core_device_ser {
+	u16 bdf;
+	u16 domain;
+} __packed;
+
 #endif /* _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H */
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index e90859956514..9aa1587fea19 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -81,6 +81,34 @@ struct vfio_device {
 #endif
 };
 
+struct vfio_device_file {
+	struct vfio_device *device;
+	struct vfio_group *group;
+
+	u8 access_granted;
+	u32 devid; /* only valid when iommufd is valid */
+	spinlock_t kvm_ref_lock; /* protect kvm field */
+	struct kvm *kvm;
+	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
+};
+
+extern const struct file_operations vfio_device_fops;
+
+static inline struct vfio_device_file *to_vfio_device_file(struct file *file)
+{
+	if (file->f_op != &vfio_device_fops)
+		return NULL;
+
+	return file->private_data;
+}
+
+static inline struct vfio_device *vfio_device_from_file(struct file *file)
+{
+	struct vfio_device_file *df = to_vfio_device_file(file);
+
+	return df ? df->device : NULL;
+}
+
 /**
  * struct vfio_device_ops - VFIO bus driver device callbacks
  *
-- 
2.53.0.rc1.225.gd81095ad13-goog


