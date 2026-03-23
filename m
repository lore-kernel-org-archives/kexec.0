Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90276F532C0
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 23:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kmzYNzW0+Ct+eXaBxLnJaomUJdCksoGs2CQSxI1y3bk=; b=3KsFnyfmUjW06jmsY8pbjlFeNs
	EVsD9rWHmLIWboZMy4kIm9N8dZd2aotURbpcamGmwhAqkz2IO6/SKzSCJmHpoXmE+oO0niyMYtXCr
	YFpcUsq7mddbzS0rWZw6LsQ+L0pEk6ot9G3F3tTaTEccgbgFiraoi/D5+crJiLHrJGgXklnQZlMJl
	6hkFaaLPllHzuAx6ko/qmsOOfp+9gSZVLWLfQWEZrDniE/NNBx9PyfyRvkelk+qNDmuceV3wIZw75
	xZhfmmS9IMa53yLisMNXaMPJInJK58ePgN/3tY6HQnTbJUfzZYNZ+upChs/8mOtqHm9OdDeJRnIwK
	0F2rJ7gQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAd-00000000BST-22cs;
	Mon, 23 Mar 2026 23:58:55 +0000
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAb-00000000BO0-0Bi7
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 23:58:54 +0000
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-358df8fbd1cso1043023a91.0
        for <kexec@lists.infradead.org>; Mon, 23 Mar 2026 16:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310331; x=1774915131; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kmzYNzW0+Ct+eXaBxLnJaomUJdCksoGs2CQSxI1y3bk=;
        b=JVO4oK3yRtE69nbsEWoDPI0jT2cGsXSYsj3aVyJk39XNzrK/8XqoV4id6pILJBPthY
         5wo+T9tZIUhMb3wcD/3E/TEfSQopolHw9aBmaHFqEbBl7KeECWI0wd5FAkWtuzONFf+a
         NZnoDVvWdsPSnA+1fcDpYjtJtZ3yHXQgziiOVyLFgRO3RfJVSSMwZaYHShAJxaKuSDwV
         pvKxlsvSFp9KMlvczQsuIq/Qa6pxVbHleuRa1mkxpJ8pUZYaSS3if41HumSyOaN3UwDZ
         j0anUgHJr812puC3B9y5er69S8Mk/u+M5AxDPCpKhAYRSptVE/HbifIttigxLf569nVV
         cRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310331; x=1774915131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kmzYNzW0+Ct+eXaBxLnJaomUJdCksoGs2CQSxI1y3bk=;
        b=TouMCkg+xcW1eBtWE21f83o87gjpH+rG3GYtZI9ES5xJRMD/cKPczTexPR+D9tLfDN
         EHXUADAMAUQfsrVKFni4ZVboYgmnpx8Ebrzu9y8nHEW4LjLiZftkZ37sqxPhySSO9nsr
         EQg0VIqE3jrqdDbVsH+XqCDAqeh3OWLsQfhw3CI95RIIvmysWjuE3YQNCIifWwyP2HBC
         e80Xc0wuPFcCmmMVcys0Np4w71DZND4yJwSDuOylFAzUzPxK6fLYIgJualRPUBo9V4Qa
         tyAizjjchh7TgTYGP7av9glV57vLddn9Q2hY/hQ+x1go/eF67PfTgGHJHCEk8r+ukO97
         TG3w==
X-Forwarded-Encrypted: i=1; AJvYcCXD669NsHQx64hXZ7pHW/rmXsWhqU1NaPvnU60cz4ApfUVtRhXSscpuVeXFN6c5A4Os/nYzaQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxE/aBx4N9HSNc00xGVFjL4YqWGPPVnuuDkMYI6dn5G1mWuYdsA
	zzD0Zi5fInK7uYlVrRl0hCfFrtFZdi7RebMVAeFJhPoaG06YljD66229Gzd4zgNlPjHSM6idPo4
	hRlwjuPdzmntyZA==
X-Received: from pjbfv10.prod.google.com ([2002:a17:90b:e8a:b0:35b:939b:1e33])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:a82:b0:35b:e4d6:73cd with SMTP id 98e67ed59e1d1-35be4d6748bmr4279808a91.31.1774310331243;
 Mon, 23 Mar 2026 16:58:51 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:58:00 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-9-dmatlack@google.com>
Subject: [PATCH v3 08/24] vfio/pci: Retrieve preserved device files after Live Update
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_165853_097477_A7B07CD4 
X-CRM114-Status: GOOD (  29.48  )
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

Enable userspace to retrieve preserved VFIO device files from VFIO after
a Live Update by implementing the retrieve() and finish() file handler
callbacks.

Use an anonymous inode when creating the file, since the retrieved
device file is not opened through any particular cdev inode, and the
cdev inode does not matter in practice.

For now the retrieved file is functionally equivalent a opening the
corresponding VFIO cdev file. Subsequent commits will leverage the
preserved state associated with the retrieved file to preserve bits of
the device across Live Update.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/device_cdev.c             | 59 ++++++++++++++++++++++----
 drivers/vfio/pci/vfio_pci_liveupdate.c | 52 ++++++++++++++++++++++-
 drivers/vfio/vfio_main.c               | 13 ++++++
 include/linux/vfio.h                   | 11 +++++
 4 files changed, 124 insertions(+), 11 deletions(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 8ceca24ac136..edf322315a41 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2023 Intel Corporation.
  */
+#include <linux/anon_inodes.h>
 #include <linux/vfio.h>
 #include <linux/iommufd.h>
 
@@ -16,15 +17,10 @@ void vfio_init_device_cdev(struct vfio_device *device)
 	device->cdev.owner = THIS_MODULE;
 }
 
-/*
- * device access via the fd opened by this function is blocked until
- * .open_device() is called successfully during BIND_IOMMUFD.
- */
-int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
+static int vfio_device_cdev_open(struct vfio_device *device, struct file **filep)
 {
-	struct vfio_device *device = container_of(inode->i_cdev,
-						  struct vfio_device, cdev);
 	struct vfio_device_file *df;
+	struct file *file = *filep;
 	int ret;
 
 	/* Paired with the put in vfio_device_fops_release() */
@@ -37,22 +33,67 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
 		goto err_put_registration;
 	}
 
-	filep->private_data = df;
+	/*
+	 * Simulate opening the character device using an anonymous inode. The
+	 * returned file has the same properties as a cdev file (e.g. operations
+	 * are blocked until BIND_IOMMUFD is called).
+	 */
+	if (!file) {
+		file = anon_inode_getfile_fmode("[vfio-device-liveupdate]",
+						&vfio_device_fops, NULL,
+						O_RDWR, FMODE_PREAD | FMODE_PWRITE);
+
+		if (IS_ERR(file)) {
+			ret = PTR_ERR(file);
+			goto err_free_device_file;
+		}
+
+		*filep = file;
+	}
+
+	file->private_data = df;
 
 	/*
 	 * Use the pseudo fs inode on the device to link all mmaps
 	 * to the same address space, allowing us to unmap all vmas
 	 * associated to this device using unmap_mapping_range().
 	 */
-	filep->f_mapping = device->inode->i_mapping;
+	file->f_mapping = device->inode->i_mapping;
 
 	return 0;
 
+err_free_device_file:
+	kvfree(df);
 err_put_registration:
 	vfio_device_put_registration(device);
 	return ret;
 }
 
+struct file *vfio_device_liveupdate_cdev_open(struct vfio_device *device)
+{
+	struct file *file = NULL;
+	int ret;
+
+	ret = vfio_device_cdev_open(device, &file);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return file;
+}
+EXPORT_SYMBOL_GPL(vfio_device_liveupdate_cdev_open);
+
+/*
+ * device access via the fd opened by this function is blocked until
+ * .open_device() is called successfully during BIND_IOMMUFD.
+ */
+int vfio_device_fops_cdev_open(struct inode *inode, struct file *file)
+{
+	struct vfio_device *device = container_of(inode->i_cdev,
+						  struct vfio_device, cdev);
+
+	return vfio_device_cdev_open(device, &file);
+}
+
 static void vfio_df_get_kvm_safe(struct vfio_device_file *df)
 {
 	spin_lock(&df->kvm_ref_lock);
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index c4ebc7c486e5..4b83a02401aa 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -39,7 +39,13 @@
  *    preserved, so there is no way for the file to be destroyed or the device
  *    to be unbound from the vfio-pci driver while it is preserved.
  *
- * Retrieving the file after kexec is not yet supported.
+ * After kexec, the preserved VFIO device file can be retrieved from the session
+ * just like any other preserved file::
+ *
+ *   ioctl(session_fd, LIVEUPDATE_SESSION_RETRIEVE_FD, &arg);
+ *   device_fd = arg.fd;
+ *   ...
+ *   ioctl(session_fd, LIVEUPDATE_SESSION_FINISH, ...);
  *
  * Restrictions
  * ============
@@ -85,6 +91,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/file.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/vfio_pci.h>
 #include <linux/liveupdate.h>
@@ -180,13 +187,53 @@ static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *args)
 	return 0;
 }
 
+static int match_device(struct device *dev, const void *arg)
+{
+	struct vfio_device *device = container_of(dev, struct vfio_device, device);
+	const struct vfio_pci_core_device_ser *ser = arg;
+	struct pci_dev *pdev;
+
+	pdev = dev_is_pci(device->dev) ? to_pci_dev(device->dev) : NULL;
+	if (!pdev)
+		return false;
+
+	return ser->bdf == pci_dev_id(pdev) && ser->domain == pci_domain_nr(pdev->bus);
+}
+
 static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
 {
-	return -EOPNOTSUPP;
+	struct vfio_pci_core_device_ser *ser;
+	struct vfio_device *device;
+	struct file *file;
+	int ret = 0;
+
+	ser = phys_to_virt(args->serialized_data);
+
+	device = vfio_find_device(ser, match_device);
+	if (!device)
+		return -ENODEV;
+
+	file = vfio_device_liveupdate_cdev_open(device);
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		goto out;
+	}
+
+	args->file = file;
+out:
+	/* Drop the reference from vfio_find_device() */
+	put_device(&device->device);
+	return ret;
+}
+
+static bool vfio_pci_liveupdate_can_finish(struct liveupdate_file_op_args *args)
+{
+	return args->retrieve_status > 0;
 }
 
 static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *args)
 {
+	kho_restore_free(phys_to_virt(args->serialized_data));
 }
 
 static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
@@ -195,6 +242,7 @@ static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
 	.unpreserve = vfio_pci_liveupdate_unpreserve,
 	.freeze = vfio_pci_liveupdate_freeze,
 	.retrieve = vfio_pci_liveupdate_retrieve,
+	.can_finish = vfio_pci_liveupdate_can_finish,
 	.finish = vfio_pci_liveupdate_finish,
 	.owner = THIS_MODULE,
 };
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 8b222f71bbab..e5886235cad4 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -13,6 +13,7 @@
 #include <linux/cdev.h>
 #include <linux/compat.h>
 #include <linux/device.h>
+#include <linux/device/class.h>
 #include <linux/fs.h>
 #include <linux/idr.h>
 #include <linux/iommu.h>
@@ -1766,6 +1767,18 @@ int vfio_dma_rw(struct vfio_device *device, dma_addr_t iova, void *data,
 }
 EXPORT_SYMBOL(vfio_dma_rw);
 
+struct vfio_device *vfio_find_device(const void *data, device_match_t match)
+{
+	struct device *device;
+
+	device = class_find_device(vfio.device_class, NULL, data, match);
+	if (!device)
+		return NULL;
+
+	return container_of(device, struct vfio_device, device);
+}
+EXPORT_SYMBOL_GPL(vfio_find_device);
+
 /*
  * Module/class support
  */
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index e9d3ddb715c5..7384965d15d7 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -393,4 +393,15 @@ int vfio_virqfd_enable(void *opaque, int (*handler)(void *, void *),
 void vfio_virqfd_disable(struct virqfd **pvirqfd);
 void vfio_virqfd_flush_thread(struct virqfd **pvirqfd);
 
+#if IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV)
+struct file *vfio_device_liveupdate_cdev_open(struct vfio_device *device);
+#else
+static inline struct file *vfio_device_liveupdate_cdev_open(struct vfio_device *device)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+#endif /* IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV) */
+
+struct vfio_device *vfio_find_device(const void *data, device_match_t match);
+
 #endif /* VFIO_H */
-- 
2.53.0.983.g0bb29b3bc5-goog


