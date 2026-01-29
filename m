Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F038D73E8E
	for <kexec@archiver.kernel.org>; Thu, 29 Jan 2026 21:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TvBnrq4VVaLn6O5AYPXHhriXtNBsa9110uSNH/MSfDg=; b=2WQz2wnqEql8HNSELlvxObsinT
	5LBk6l7d8qd/CS5xXpTSYItKFvJmwOWX3pw06Ti7gBk1uYtCjdYm7BlcynHk+lJduFmklWwhMMJ6d
	naur0TVV8d701jdC2GJNyz4Hw3KpAp4LnxZ9jlBDIdR6J9To5J5BHh/bSLWIaPJSGx9PbwY5mcKhv
	T6+INoD+6oyl2pIF7dBvjaTYvxFYRKm9qRUWnoC1L6kMg/dK2RJnu27gAMt8ncjqAjH0P35gk06y6
	LppXhBpAI9dhQZcwSINuJeQPg+f58BwQ/MXMV7VC0Wfd9V1hvh1ianvGWJ5byFmI0Bl4dDVzRvp6M
	AH1h55Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWS-00000000fID-0USe;
	Thu, 29 Jan 2026 21:25:52 +0000
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWO-00000000fDm-2Ydk
	for kexec@lists.infradead.org;
	Thu, 29 Jan 2026 21:25:49 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-34ac819b2f2so1604658a91.0
        for <kexec@lists.infradead.org>; Thu, 29 Jan 2026 13:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769721947; x=1770326747; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TvBnrq4VVaLn6O5AYPXHhriXtNBsa9110uSNH/MSfDg=;
        b=UkS7q3jAKFOeY6E4pSX+vPkm5yp0vkD/b458Zk0qV48BFgzlz+mwZ/3iP+EneSS14B
         /GQp9jjj6fXdeREUOEmrtqo3avPN91wQ/cmaTuYyb7wz1YCOUnLiZgpoaaZL6jOK2NT1
         liuf0Rk8M7SIo0J6CwHBfFEIYobviT8OLpt3247qGxHJkQK7amQdhdKjUvDP4LF3Frlo
         kWf1pu9OkXQX631wkKoPu+G+AGUkiOpX/JNHIQB+4Mjb/wdTJu/no8P+Pricllqeibxb
         kqUwA1bydlEC1Gt+YZy2TfhXo1K65BNsJGmDFEu2F+NTSYJxo0QOci6p4F1/rZDL2DaR
         35Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769721947; x=1770326747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvBnrq4VVaLn6O5AYPXHhriXtNBsa9110uSNH/MSfDg=;
        b=eDpli02AbTw157+lKhiuzypUzD/dXInlnT6N0/IZPDYCjKmZNnneumjoooXY/QAun8
         rpRCw50zhOLYBLRw69U7BFUAfEU3qyfA+QxfvB8q8qfnUhEZsxTzd0devGgz6JCUKVZd
         yVs1tDthrrxrZ7Z2Zqadh0oVV97zSp/CoU1ep3R2dwj4q2E66HThQjtbZk2EulU076R/
         ZAhENB3Ui3cOJ0J8xHd2i/l2PxzsQiv/207e2I2oBZJ33+ouyN451IQfzx9+z9YtTEgM
         hlBE61byNrcgViRCgIgnqJ6GND58vd24d8MI7L1eJvpIHnR6IGfW1gG7zXCvXjFGzueu
         QKaA==
X-Forwarded-Encrypted: i=1; AJvYcCWM+627P64B0yPLDWQBnl0LQVE2cC9JD8y78lmDx9lBWP1IKYm5CCaj5o/FByDJkq9FjJB/sw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy09OlwF0AaEPU+i/ChsFk0ZB+aC4+7pFVglwr5tT9skj9IH1qC
	Ypk+rQ/jDpIFKnCBLFJq9QORMz4bwtm82cFwsSLBYkZibkuHxEC7ZHnzp3W/aLl+Qw0QHS20V6A
	531TE6Ni03Ko5FQ==
X-Received: from pjbcp23.prod.google.com ([2002:a17:90a:fb97:b0:352:e9d7:ffd2])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d4d:b0:34c:9cec:dd83 with SMTP id 98e67ed59e1d1-3543b3d6641mr750618a91.27.1769721947474;
 Thu, 29 Jan 2026 13:25:47 -0800 (PST)
Date: Thu, 29 Jan 2026 21:24:53 +0000
In-Reply-To: <20260129212510.967611-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129212510.967611-7-dmatlack@google.com>
Subject: [PATCH v2 06/22] vfio/pci: Retrieve preserved device files after Live Update
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
X-CRM114-CacheID: sfid-20260129_132548_663971_9C103C4C 
X-CRM114-Status: GOOD (  23.14  )
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
 drivers/vfio/device_cdev.c             | 21 ++++++---
 drivers/vfio/pci/vfio_pci_liveupdate.c | 60 +++++++++++++++++++++++++-
 drivers/vfio/vfio_main.c               | 13 ++++++
 include/linux/vfio.h                   | 12 ++++++
 4 files changed, 98 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 8ceca24ac136..935f84a35875 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -16,14 +16,8 @@ void vfio_init_device_cdev(struct vfio_device *device)
 	device->cdev.owner = THIS_MODULE;
 }
 
-/*
- * device access via the fd opened by this function is blocked until
- * .open_device() is called successfully during BIND_IOMMUFD.
- */
-int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
+int __vfio_device_fops_cdev_open(struct vfio_device *device, struct file *filep)
 {
-	struct vfio_device *device = container_of(inode->i_cdev,
-						  struct vfio_device, cdev);
 	struct vfio_device_file *df;
 	int ret;
 
@@ -52,6 +46,19 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
 	vfio_device_put_registration(device);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(__vfio_device_fops_cdev_open);
+
+/*
+ * device access via the fd opened by this function is blocked until
+ * .open_device() is called successfully during BIND_IOMMUFD.
+ */
+int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
+{
+	struct vfio_device *device = container_of(inode->i_cdev,
+						  struct vfio_device, cdev);
+
+	return __vfio_device_fops_cdev_open(device, filep);
+}
 
 static void vfio_df_get_kvm_safe(struct vfio_device_file *df)
 {
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index f01de98f1b75..7f4117181fd0 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -8,6 +8,8 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/anon_inodes.h>
+#include <linux/file.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/vfio_pci.h>
 #include <linux/liveupdate.h>
@@ -108,13 +110,68 @@ static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *args)
 	return ret;
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
+	int ret;
+
+	ser = phys_to_virt(args->serialized_data);
+
+	device = vfio_find_device(ser, match_device);
+	if (!device)
+		return -ENODEV;
+
+	/*
+	 * Simulate opening the character device using an anonymous inode. The
+	 * returned file has the same properties as a cdev file (e.g. operations
+	 * are blocked until BIND_IOMMUFD is called).
+	 */
+	file = anon_inode_getfile_fmode("[vfio-device-liveupdate]",
+					&vfio_device_fops, NULL,
+					O_RDWR, FMODE_PREAD | FMODE_PWRITE);
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		goto out;
+	}
+
+	ret = __vfio_device_fops_cdev_open(device, file);
+	if (ret) {
+		fput(file);
+		goto out;
+	}
+
+	args->file = file;
+
+out:
+	/* Drop the reference from vfio_find_device() */
+	put_device(&device->device);
+
+	return ret;
+}
+
+static bool vfio_pci_liveupdate_can_finish(struct liveupdate_file_op_args *args)
+{
+	return args->retrieved;
 }
 
 static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *args)
 {
+	kho_restore_free(phys_to_virt(args->serialized_data));
 }
 
 static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
@@ -123,6 +180,7 @@ static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
 	.unpreserve = vfio_pci_liveupdate_unpreserve,
 	.freeze = vfio_pci_liveupdate_freeze,
 	.retrieve = vfio_pci_liveupdate_retrieve,
+	.can_finish = vfio_pci_liveupdate_can_finish,
 	.finish = vfio_pci_liveupdate_finish,
 	.owner = THIS_MODULE,
 };
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 276f615f0c28..89c5feef75d5 100644
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
@@ -1758,6 +1759,18 @@ int vfio_dma_rw(struct vfio_device *device, dma_addr_t iova, void *data,
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
index 9aa1587fea19..dc592dc00f89 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -419,4 +419,16 @@ int vfio_virqfd_enable(void *opaque, int (*handler)(void *, void *),
 void vfio_virqfd_disable(struct virqfd **pvirqfd);
 void vfio_virqfd_flush_thread(struct virqfd **pvirqfd);
 
+#if IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV)
+int __vfio_device_fops_cdev_open(struct vfio_device *device, struct file *filep);
+#else
+static inline int __vfio_device_fops_cdev_open(struct vfio_device *device,
+					       struct file *filep)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV) */
+
+struct vfio_device *vfio_find_device(const void *data, device_match_t match);
+
 #endif /* VFIO_H */
-- 
2.53.0.rc1.225.gd81095ad13-goog


