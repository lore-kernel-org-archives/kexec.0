Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77587C4450D
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 15:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DHOmohYTYSD8/2ryEq7eNVyF04S9VyCIkpjOIEDjYJc=; b=b73T5ixKiPtINLUU0opN/KSHOR
	wQOD6veqC+hjAPyd9lr/qeYv7svivKfodIdLjGAHffjM/9g+wpIzH2L17xFf4gE3PabCEnvjcHRYa
	QVdOFOLnsd3m7KDRptlanvSJen9gyoWbQKGbFzoayJEkREAE8iupWefvpnBvvdaEQSpUhq5IJaVnl
	Oe5VE68HaJj3Kn0xAAurBnqzZJEfvrXRru2oYJBkdx3D7IzDwETU5ibwi5X6Vrfl+mIge11mBPzyO
	g3AwwNpGCZRg2ZExSStLtXquZLwblj8BCVGQzhJBSFdzcRcDEbzN/paK8n6tJou7KppWOUPeW4Q0U
	/qPORBxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjeqz-0000000CUGa-1m4A;
	Tue, 14 Jul 2026 15:15:25 +0000
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjeqw-0000000CUAw-2HSQ
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 15:15:23 +0000
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-847a00bcbd0so5876561b3a.0
        for <kexec@lists.infradead.org>; Tue, 14 Jul 2026 08:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042121; x=1784646921; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DHOmohYTYSD8/2ryEq7eNVyF04S9VyCIkpjOIEDjYJc=;
        b=P2xUCkvA182HP2QUAY8bwkUPXsmSBYRsafgA3FYwQL5OvGKeXrWG4Pl8oUPsa1vXOR
         YKJ3I02jG42HiA9eDBZatz9/+M1yQFg4MGpgrCxF+NwVG8dSaied57dsE2WiBQJFh3T9
         rns2fQF6REMp7CS6UPqtrWhc2Ee7Lesfcsvd1BBA4LD2S6fYZ0PJI91i6fIFaqLjgF0S
         FUMp/nTYSTr+1GDhZG2kWeeadPTS96cK0WDakI3QIu7e4E6n8KsAPNNvXlTfBj4xaW/S
         oWCbvolzMA6EvM7VJXjqY29NM2XGt4qoXH/dhrI1NPQaPWaEOkHSqsXqg772mVl4CCv0
         rpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042121; x=1784646921;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DHOmohYTYSD8/2ryEq7eNVyF04S9VyCIkpjOIEDjYJc=;
        b=KHfl3WNM6y6fRIFSu/7oeQ/3ubPWGJeCvpwrvwNywwuxsb0282d40KRCc4lUc5qdCI
         TPxhMZ5B0WtX86pIa01H/Q9uF/msHEJ5b5BfGOcHuF2+cufj6LtlI4qXfuPyl86ZAaPB
         Hg9KKiIk93Kcwu46k/L5E5EbIXsHQphTtL46LoTaXxbYs8MR/UfWPSUKrVtxU+CSDGtE
         eZ+UGMMzFPIY/z6NKmwTZD2ucoR+SgfCtqYQAiKrG5vovMFtdEYVKE3/4cuz1kPvSnsa
         ZjUfA2YBggV6+PLIQnwfHvUbkn6qzI3cci07hzfOWD+7TQhvj9jTk4aZ6mMNq7ZaZLHy
         rzaw==
X-Gm-Message-State: AOJu0YyiOHbVeSNNxLj6jkiU69O8fBnE5t1L+Dfim4d4dj46iiqf1q+6
	oGwm6nI/jeBHU9cqoZ/B+FMvZ4H23FEwkKCYndfne1bDmfODQvBAurUuSnE/H2g7RlK9tqU/w7c
	1rj2Y8AAs4gn+qahNgTw0ijgCboAYsiT+6SpLjWT1Fl8ls7poLb7VaJdsof6yNOXNUJrPOCv9dv
	UQ/TqIFmHlCw/RKHF43efufmju6GmpDJaSz7sM83voCY9BeA==
X-Received: from pfux16.prod.google.com ([2002:a05:6a00:bd0:b0:848:8b16:23d6])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d19:b0:848:76af:db37
 with SMTP id d2e1a72fcca58-84889611b82mr12946882b3a.7.1784042120956; Tue, 14
 Jul 2026 08:15:20 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:14:56 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-12-vipinsh@google.com>
Subject: [PATCH v5 11/20] vfio: Enforce preserved devices are retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD
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
X-CRM114-CacheID: sfid-20260714_081522_629965_93810E84 
X-CRM114-Status: GOOD (  16.67  )
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

From: David Matlack <dmatlack@google.com>

Enforce that files for incoming (preserved by previous kernel) VFIO
devices are retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD rather than by
opening the corresponding VFIO character device or via
VFIO_GROUP_GET_DEVICE_FD.

Both of these methods would result in VFIO initializing the device
without access to the preserved state of the device passed by the
previous kernel.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Co-developed-by: Vipin Sharma <vipinsh@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/device_cdev.c             |  8 ++++++++
 drivers/vfio/group.c                   |  9 +++++++++
 drivers/vfio/pci/vfio_pci_liveupdate.c |  6 ++++++
 drivers/vfio/vfio.h                    | 18 ++++++++++++++++++
 4 files changed, 41 insertions(+)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 970932f22ecb..0050f0fe456b 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -49,6 +49,14 @@ static int vfio_device_cdev_open(struct vfio_device *device, struct file **filep
 		}
 
 		*filep = file;
+	} else if (vfio_liveupdate_incoming_is_preserved(device)) {
+		/*
+		 * Since it is live update preserved device, it must be
+		 * retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD instead of
+		 * opening /dev/vfio/devices/vfioX.
+		 */
+		ret = -EBUSY;
+		goto err_free_device_file;
 	}
 
 	file->private_data = df;
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index b2299e5bc6df..62b4eaabc829 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -316,6 +316,15 @@ static int vfio_group_ioctl_get_device_fd(struct vfio_group *group,
 	if (IS_ERR(device))
 		return PTR_ERR(device);
 
+	/*
+	 * This device was preserved across a Live Update. Accessing it via
+	 * VFIO_GROUP_GET_DEVICE_FD is not allowed.
+	 */
+	if (vfio_liveupdate_incoming_is_preserved(device)) {
+		vfio_device_put_registration(device);
+		return -EBUSY;
+	}
+
 	fd = FD_ADD(O_CLOEXEC, vfio_device_open_file(device));
 	if (fd < 0)
 		vfio_device_put_registration(device);
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 4baac80d03f0..f0ea37d98696 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -47,6 +47,12 @@
  *   ...
  *   ioctl(session_fd, LIVEUPDATE_SESSION_FINISH, ...);
  *
+ * .. note::
+ *    After kexec, if a device was preserved by the previous kernel, attempting
+ *    to open a new file for the device via its character device
+ *    (``/dev/vfio/devices/X``) or via ``VFIO_GROUP_GET_DEVICE_FD`` will fail
+ *    with ``-EBUSY``.
+ *
  * Restrictions
  * ============
  *
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index e4b72e79b7e3..496180950eb6 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -11,6 +11,7 @@
 #include <linux/cdev.h>
 #include <linux/module.h>
 #include <linux/vfio.h>
+#include <linux/pci.h>
 
 struct iommufd_ctx;
 struct iommu_group;
@@ -461,4 +462,21 @@ static inline void vfio_device_debugfs_init(struct vfio_device *vdev) { }
 static inline void vfio_device_debugfs_exit(struct vfio_device *vdev) { }
 #endif /* CONFIG_VFIO_DEBUGFS */
 
+#ifdef CONFIG_VFIO_PCI_LIVEUPDATE
+static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
+{
+	struct device *d = device->dev;
+
+	if (dev_is_pci(d))
+		return pci_liveupdate_is_incoming(to_pci_dev(d));
+
+	return false;
+}
+#else
+static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
+{
+	return false;
+}
+#endif /* CONFIG_VFIO_PCI_LIVEUPDATE */
+
 #endif
-- 
2.55.0.795.g602f6c329a-goog


