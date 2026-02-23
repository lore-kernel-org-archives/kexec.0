Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CA5EEC2A3
	for <kexec@archiver.kernel.org>; Mon, 23 Feb 2026 22:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C8f6dXcdZJeSJ2qE0ghvpNFkqtAaZ6dotEKElaryP78=; b=MWUiLvKKZJBHvVef6wwFMMw9r3
	tSoDpMusG4iliG/tySe0kWmd4Ye6EuSwd8GUtXh/oVtwqi94CKdHDf2YKKcglRNPrpjhK7Jo3SJp8
	IGdi8dnKxV9/pYTTHtixMS+Pj95oXouxFEX0u7qXoFQjpp1YV4x1ZedyIZ95jhrfZ3qgMCdfME0RF
	MPNDHu2uRbdWCdNL/NWIcxFIqoSxQTXdrqHUpFn95hRJE2lb8DixEyL6U6jucSLWsWr3Xr1XUKRYD
	mezBeHBuRiNY64fe6a43xdm5imMxZ2BlplLJ7r32kMbH9X7QajPY7jWlINdaCKaqYD/YvEgB7NnmR
	QodxHBIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vueQR-000000017GR-1JPL;
	Mon, 23 Feb 2026 22:29:11 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vueQP-000000017Fs-19rs
	for kexec@lists.infradead.org;
	Mon, 23 Feb 2026 22:29:10 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2a76b39587aso30195ad.0
        for <kexec@lists.infradead.org>; Mon, 23 Feb 2026 14:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771885748; x=1772490548; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C8f6dXcdZJeSJ2qE0ghvpNFkqtAaZ6dotEKElaryP78=;
        b=DehOZ0el5vfGjpf6PRY299MeAnHFSRr9Xhzjevz/I0UiCExH33oYGbvpMkAOb3/sbU
         m82zKPSHpS1ts7RcybBsTLBXxfmuwzLmkcem12JVVq9JGpTumYVrDFsatxKU1eSAVw5l
         uF9qLXj8Cmg0dmkjYzg+sRJhR5vEU7W4s72CX3ayEXPAKM5CAKk74TExONGfixnhr/EH
         U2GtqCDEcUuMQX1Pm7zOytVbSjwnPBPvebl8PeQQsgOQDWJbT1TP/sEb4ORNbsFv5uiZ
         XnvesIFXi1meO6aZ5u50MlO5yUR6vXXXsAJBkEwdVfGUdBqEDyiU+fzb5EnmMR3BH0w2
         iReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771885748; x=1772490548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8f6dXcdZJeSJ2qE0ghvpNFkqtAaZ6dotEKElaryP78=;
        b=ksRPKar2nlxWmwfaJl4sEQ57hBLW0iS6FpIW1wQCbUK049w9APbVEN7lVLKNgHM97/
         ASEBOWmXKn7Z1a9tqdlyejvX/E7GS17x+QciM10104QkyZFz5SDpPqHLClTgYpd1ZI8O
         GrNLgdcwhUJBRx1MS2U9w4FWIZe8nHhk4KLNE1k8yI5bJ3b2KhntpVFPQKjWmDwg+N21
         e+mgTnOsXrfkHfmYEQoSOyNSC+SFBWIYwC+yRiM4psb0ZcNgIDeDVyZmlWSaOxWB7JbF
         EdkGtkGKbkF+bHAHTuXiq5ls6VzhyPkWWTpjJnbs0Hl6CsqHceceB3R4SYx2K5rf8Vb/
         Hs0A==
X-Forwarded-Encrypted: i=1; AJvYcCVKiS0BjI06Gn4v5TgDaVu5OGgVBDbW5SPuDiWJqRRmOngxdIENRmDPQ50knr1VvefCBkU2Ug==@lists.infradead.org
X-Gm-Message-State: AOJu0YwP8/wgMii64G+wi9BkorcRtScCQzgdJuXgl5amKLyyqEzvIRTJ
	pJ140EE3JOgPnrxkA0rkoHL64DvasRosXPbmPr6RHb2MwimA3lq5b/8srJhiOXIGpw==
X-Gm-Gg: ATEYQzwc2lTYPWOT8fVBOVpm4Y2LFk42iV3FD4rXNE2WgECV3XaXPVCxbMBuwHHAfna
	ZYgbwYUtidI4OkNrT6b5rkISfmmmkRolcwf9rjivwQ6UTZK7K058bfI4uoVZDv5pT63q6ccMyV7
	blOq3lzI3LD72jIiNDobOcS/Ti2+D/ZMrquQoazj8Y5+taErDzqgUIG8m7LOIdg8C67JWOgZYIG
	GHPmmyLhKBsAwIzp5H3JwQYWZYBVBXczdkva99ZklJD5ZtGZK+0PGElVh5yEE3xdPa2+nXR+a+5
	xi6mquLik1AtHz+Tm9QS0fk1fSleMAwGpkGqwASaQRyeJZMUiOyNeTn7Il2+scnFF4f0tD7wfRW
	t9kLVhZiw1CO2oGkup1uHqy2pCtr1p6IWcXCihebH4MbSVHwLi6KoQt9pmZ1FzskripU5MemIcM
	n5MuF8amafyqQjn19UXYgSF8JGB3jpPVfgTAzyrb5ru+eGykKTFDSCGzvmHDs9pQ==
X-Received: by 2002:a17:902:ec89:b0:2a9:5ef5:399b with SMTP id d9443c01a7336-2ada3497c30mr138295ad.19.1771885747713;
        Mon, 23 Feb 2026 14:29:07 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8ba11bsm8507152b3a.50.2026.02.23.14.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:29:07 -0800 (PST)
Date: Mon, 23 Feb 2026 22:29:03 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vipin Sharma <vipinsh@google.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 05/22] vfio/pci: Preserve vfio-pci device files across
 Live Update
Message-ID: <qshnqqtfg7clbcqoq45ei55wt6xt4z4xtwv5ehjyjxwq47cwng@n3vd3lxigcs6>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-6-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260129212510.967611-6-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260223_142909_358533_3C4F3F09 
X-CRM114-Status: GOOD (  29.64  )
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

On Thu, Jan 29, 2026 at 09:24:52PM +0000, David Matlack wrote:
>From: Vipin Sharma <vipinsh@google.com>
>
>Implement the live update file handler callbacks to preserve a vfio-pci
>device across a Live Update. Subsequent commits will enable userspace to
>then retrieve this file after the Live Update.
>
>Live Update support is scoped only to cdev files (i.e. not
>VFIO_GROUP_GET_DEVICE_FD files).
>
>State about each device is serialized into a new ABI struct
>vfio_pci_core_device_ser. The contents of this struct are preserved
>across the Live Update to the next kernel using a combination of
>Kexec-Handover (KHO) to preserve the page(s) holding the struct and the
>Live Update Orchestrator (LUO) to preserve the physical address of the
>struct.
>
>For now the only contents of struct vfio_pci_core_device_ser the
>device's PCI segment number and BDF, so that the device can be uniquely
>identified after the Live Update.
>
>Require that userspace disables interrupts on the device prior to
>freeze() so that the device does not send any interrupts until new
>interrupt handlers have been set up by the next kernel.
>
>Reset the device and restore its state in the freeze() callback. This
>ensures the device can be received by the next kernel in a consistent
>state. Eventually this will be dropped and the device can be preserved
>across in a running state, but that requires further work in VFIO and
>the core PCI layer.
>
>Note that LUO holds a reference to this file when it is preserved. So
>VFIO is guaranteed that vfio_df_device_last_close() will not be called
>on this device no matter what userspace does.
>
>Signed-off-by: Vipin Sharma <vipinsh@google.com>
>Co-developed-by: David Matlack <dmatlack@google.com>
>Signed-off-by: David Matlack <dmatlack@google.com>
>---
> drivers/vfio/pci/vfio_pci.c            |  2 +-
> drivers/vfio/pci/vfio_pci_liveupdate.c | 84 +++++++++++++++++++++++++-
> drivers/vfio/pci/vfio_pci_priv.h       |  2 +
> drivers/vfio/vfio.h                    | 13 ----
> drivers/vfio/vfio_main.c               | 10 +--
> include/linux/kho/abi/vfio_pci.h       | 15 +++++
> include/linux/vfio.h                   | 28 +++++++++
> 7 files changed, 129 insertions(+), 25 deletions(-)
>
>diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>index 19e88322af2c..0260afb9492d 100644
>--- a/drivers/vfio/pci/vfio_pci.c
>+++ b/drivers/vfio/pci/vfio_pci.c
>@@ -125,7 +125,7 @@ static int vfio_pci_open_device(struct vfio_device *core_vdev)
> 	return 0;
> }
>
>-static const struct vfio_device_ops vfio_pci_ops = {
>+const struct vfio_device_ops vfio_pci_ops = {
> 	.name		= "vfio-pci",
> 	.init		= vfio_pci_core_init_dev,
> 	.release	= vfio_pci_core_release_dev,
>diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
>index b84e63c0357b..f01de98f1b75 100644
>--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
>+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
>@@ -8,25 +8,104 @@
>
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
>+#include <linux/kexec_handover.h>
> #include <linux/kho/abi/vfio_pci.h>
> #include <linux/liveupdate.h>
> #include <linux/errno.h>
>+#include <linux/vfio.h>
>
> #include "vfio_pci_priv.h"
>
> static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
> 					     struct file *file)
> {
>-	return false;
>+	struct vfio_device_file *df = to_vfio_device_file(file);
>+
>+	if (!df)
>+		return false;
>+
>+	/* Live Update support is limited to cdev files. */
>+	if (df->group)
>+		return false;
>+
>+	return df->device->ops == &vfio_pci_ops;
> }
>
> static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
> {
>-	return -EOPNOTSUPP;
>+	struct vfio_device *device = vfio_device_from_file(args->file);
>+	struct vfio_pci_core_device_ser *ser;
>+	struct vfio_pci_core_device *vdev;
>+	struct pci_dev *pdev;
>+
>+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
>+	pdev = vdev->pdev;
>+
>+	if (IS_ENABLED(CONFIG_VFIO_PCI_ZDEV_KVM))
>+		return -EINVAL;
>+
>+	if (vfio_pci_is_intel_display(pdev))
>+		return -EINVAL;
>+
>+	ser = kho_alloc_preserve(sizeof(*ser));
>+	if (IS_ERR(ser))
>+		return PTR_ERR(ser);
>+
>+	ser->bdf = pci_dev_id(pdev);
>+	ser->domain = pci_domain_nr(pdev->bus);
>+
>+	args->serialized_data = virt_to_phys(ser);
>+	return 0;
> }
>
> static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
> {
>+	kho_unpreserve_free(phys_to_virt(args->serialized_data));
>+}
>+
>+static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *args)
>+{
>+	struct vfio_device *device = vfio_device_from_file(args->file);
>+	struct vfio_pci_core_device *vdev;
>+	struct pci_dev *pdev;
>+	int ret;
>+
>+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
>+	pdev = vdev->pdev;
>+
>+	guard(mutex)(&device->dev_set->lock);
>+
>+	/*
>+	 * Userspace must disable interrupts on the device prior to freeze so
>+	 * that the device does not send any interrupts until new interrupt
>+	 * handlers have been established by the next kernel.
>+	 */
>+	if (vdev->irq_type != VFIO_PCI_NUM_IRQS) {
>+		pci_err(pdev, "Freeze failed! Interrupts are still enabled.\n");
>+		return -EINVAL;
>+	}
>+
>+	pci_dev_lock(pdev);
>+
>+	ret = pci_load_saved_state(pdev, vdev->pci_saved_state);
>+	if (ret)
>+		goto out;
>+
>+	/*
>+	 * Reset the device and restore it back to its original state before
>+	 * handing it to the next kernel.
>+	 *
>+	 * Eventually both of these should be dropped and the device should be
>+	 * kept running with its current state across the Live Update.
>+	 */
>+	if (vdev->reset_works)
>+		ret = __pci_reset_function_locked(pdev);
>+
>+	pci_restore_state(pdev);
>+
>+out:
>+	pci_dev_unlock(pdev);
>+	return ret;
> }
>
> static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
>@@ -42,6 +121,7 @@ static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
> 	.can_preserve = vfio_pci_liveupdate_can_preserve,
> 	.preserve = vfio_pci_liveupdate_preserve,
> 	.unpreserve = vfio_pci_liveupdate_unpreserve,
>+	.freeze = vfio_pci_liveupdate_freeze,
> 	.retrieve = vfio_pci_liveupdate_retrieve,
> 	.finish = vfio_pci_liveupdate_finish,
> 	.owner = THIS_MODULE,
>diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
>index 68966ec64e51..d3da79b7b03c 100644
>--- a/drivers/vfio/pci/vfio_pci_priv.h
>+++ b/drivers/vfio/pci/vfio_pci_priv.h
>@@ -11,6 +11,8 @@
> /* Cap maximum number of ioeventfds per device (arbitrary) */
> #define VFIO_PCI_IOEVENTFD_MAX		1000
>
>+extern const struct vfio_device_ops vfio_pci_ops;
>+
> struct vfio_pci_ioeventfd {
> 	struct list_head	next;
> 	struct vfio_pci_core_device	*vdev;
>diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
>index 50128da18bca..6b89edbbf174 100644
>--- a/drivers/vfio/vfio.h
>+++ b/drivers/vfio/vfio.h
>@@ -16,17 +16,6 @@ struct iommufd_ctx;
> struct iommu_group;
> struct vfio_container;
>
>-struct vfio_device_file {
>-	struct vfio_device *device;
>-	struct vfio_group *group;
>-
>-	u8 access_granted;
>-	u32 devid; /* only valid when iommufd is valid */
>-	spinlock_t kvm_ref_lock; /* protect kvm field */
>-	struct kvm *kvm;
>-	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
>-};
>-
> void vfio_device_put_registration(struct vfio_device *device);
> bool vfio_device_try_get_registration(struct vfio_device *device);
> int vfio_df_open(struct vfio_device_file *df);
>@@ -34,8 +23,6 @@ void vfio_df_close(struct vfio_device_file *df);
> struct vfio_device_file *
> vfio_allocate_device_file(struct vfio_device *device);
>
>-extern const struct file_operations vfio_device_fops;
>-
> #ifdef CONFIG_VFIO_NOIOMMU
> extern bool vfio_noiommu __read_mostly;
> #else
>diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
>index f7df90c423b4..276f615f0c28 100644
>--- a/drivers/vfio/vfio_main.c
>+++ b/drivers/vfio/vfio_main.c
>@@ -1436,15 +1436,7 @@ const struct file_operations vfio_device_fops = {
> 	.show_fdinfo	= vfio_device_show_fdinfo,
> #endif
> };
>-
>-static struct vfio_device *vfio_device_from_file(struct file *file)
>-{
>-	struct vfio_device_file *df = file->private_data;
>-
>-	if (file->f_op != &vfio_device_fops)
>-		return NULL;
>-	return df->device;
>-}
>+EXPORT_SYMBOL_GPL(vfio_device_fops);
>
> /**
>  * vfio_file_is_valid - True if the file is valid vfio file
>diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
>index 37a845eed972..9bf58a2f3820 100644
>--- a/include/linux/kho/abi/vfio_pci.h
>+++ b/include/linux/kho/abi/vfio_pci.h
>@@ -9,6 +9,9 @@
> #ifndef _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
> #define _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
>
>+#include <linux/compiler.h>
>+#include <linux/types.h>
>+
> /**
>  * DOC: VFIO PCI Live Update ABI
>  *
>@@ -25,4 +28,16 @@
>
> #define VFIO_PCI_LUO_FH_COMPATIBLE "vfio-pci-v1"
>
>+/**
>+ * struct vfio_pci_core_device_ser - Serialized state of a single VFIO PCI
>+ * device.
>+ *
>+ * @bdf: The device's PCI bus, device, and function number.
>+ * @domain: The device's PCI domain number (segment).
>+ */
>+struct vfio_pci_core_device_ser {
>+	u16 bdf;
>+	u16 domain;
>+} __packed;
>+
> #endif /* _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H */
>diff --git a/include/linux/vfio.h b/include/linux/vfio.h
>index e90859956514..9aa1587fea19 100644
>--- a/include/linux/vfio.h
>+++ b/include/linux/vfio.h
>@@ -81,6 +81,34 @@ struct vfio_device {
> #endif
> };
>
>+struct vfio_device_file {
>+	struct vfio_device *device;
>+	struct vfio_group *group;
>+
>+	u8 access_granted;
>+	u32 devid; /* only valid when iommufd is valid */
>+	spinlock_t kvm_ref_lock; /* protect kvm field */
>+	struct kvm *kvm;
>+	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
>+};
>+
>+extern const struct file_operations vfio_device_fops;
>+
>+static inline struct vfio_device_file *to_vfio_device_file(struct file *file)
>+{
>+	if (file->f_op != &vfio_device_fops)
>+		return NULL;
>+
>+	return file->private_data;
>+}
>+
>+static inline struct vfio_device *vfio_device_from_file(struct file *file)
>+{
>+	struct vfio_device_file *df = to_vfio_device_file(file);
>+
>+	return df ? df->device : NULL;
>+}
>+
> /**
>  * struct vfio_device_ops - VFIO bus driver device callbacks
>  *
>-- 
>2.53.0.rc1.225.gd81095ad13-goog
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

