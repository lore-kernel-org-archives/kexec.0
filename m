Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E749FD73E87
	for <kexec@archiver.kernel.org>; Thu, 29 Jan 2026 21:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3umikqL/So8idv3VwvFYaIe6+4TeFw4VgnmENinGbaA=; b=PKCRLkWZlLxQVyNSnnJXagkayY
	DcWVFMLumUWMg0kcDqDjA4aLBxo+qC3DLAGPU6p7wJZV8BJe1vh+TcUbdZ1/36V5nx/I87+e/rbou
	NE6AHUt7Pp4dsZNfUQxfZ180+OVeh909qJfJ52sXDx8pHJ76ZqDSnjJpGQlxTcDPaPwGwdCbPaOsH
	4O28vPGl/xr8DRAzCgx0dCeGyDBPTACIr20INt/4pLtP4U7UaIvnCDq3eqifvY02SfdsgmegIS/UI
	kfyBTL6T2feOHws56PF+yiJV311y+CqlekQfsboAAPpq0ZSW9K6XN0vwvqi1rdgn6jlDpVmoxyPhR
	KFl6xgRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWc-00000000fQD-2oAw;
	Thu, 29 Jan 2026 21:26:02 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWR-00000000fGz-45oC
	for kexec@lists.infradead.org;
	Thu, 29 Jan 2026 21:25:58 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2a76f2d7744so12727895ad.3
        for <kexec@lists.infradead.org>; Thu, 29 Jan 2026 13:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769721951; x=1770326751; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3umikqL/So8idv3VwvFYaIe6+4TeFw4VgnmENinGbaA=;
        b=QjHLkppm6Ze06mQ3IpysheYaCMd78xTGjMxPPb96k/Kl1SIJJTq3NorYUvsOa+xpYB
         DuKKNdJ/F4UpxYZAohPvENZSxBQ7MZ7gm7ynQG+zuIi9pmsBBKCh3jcqkTnkih8c+NTS
         k6nrhZ4CjixzRoAxBrDHisbtPQg26KILQE8EgLOpziP3uCJbZh60uXXNp/7WQW0WGj5g
         orJd0lC3b+b37lc6Q8qWYquwJ0WRUqHxyXUnoUk8l7/zJb308y7RY38APymOIlcDRoTH
         COnM7ODyNERjQxHchP0tpeP9IF/ez4BoNhVgxzNJTBZ3HLcTpdGsNHe6uItU8i7UF3uj
         SPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769721951; x=1770326751;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3umikqL/So8idv3VwvFYaIe6+4TeFw4VgnmENinGbaA=;
        b=RQzjUFvLzSfAN7A8SwNq1TBttXCxMXoreUoSCoFJl8SqpLXbAck4ttQ8l/oXmEg+dT
         t6KbJRQ84zhv3lrcZfffo3Zx6ZeY/Qy6KNhT8fWrk3+QS98IU4TAHsiEt5B135p9XI2w
         Z8KSnvtD6v9e3tfDqbbC8odt8S3/typ0bfiX60+FMsIOct3xOY0u55b9kyg2DBfSCyOP
         cCcNJnwN+BBvSImVM11ALqXsFXGXFvytkUIl/aQnAzl8puDPo1J3nyBW+XfVryEM17W8
         PlKDDOMANgRYL2HWd9A6ITI7EchTx+UxEY9M+NAK7k75nWJyOxOT9pSK3u/YJXDSV1ff
         Z6ww==
X-Forwarded-Encrypted: i=1; AJvYcCX4yn5KJPl5qxU2KCMg8I7u3B5fjix6dVoCagDBWkMNtnrnalwEeMWTDUpPya3siVV0CdktJQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxV/7p+zE4XPyw1F+aqsACFx075x1X1+9aOk1kSDB+t6ubzbrl9
	Cf0HG15Lu+1IBvu5M6jZqW3z3YMwEAKJnOA4h8hl9g9xJHJhTjV4a36uQ+K7gM6a4kOmLdpOtOs
	QWULIO3xVDuw/3Q==
X-Received: from plrf5.prod.google.com ([2002:a17:902:ab85:b0:2a7:6c0c:5916])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c952:b0:295:3584:1bbd with SMTP id d9443c01a7336-2a8d8176d76mr6976645ad.41.1769721950767;
 Thu, 29 Jan 2026 13:25:50 -0800 (PST)
Date: Thu, 29 Jan 2026 21:24:55 +0000
In-Reply-To: <20260129212510.967611-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129212510.967611-9-dmatlack@google.com>
Subject: [PATCH v2 08/22] vfio: Enforce preserved devices are retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD
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
X-CRM114-CacheID: sfid-20260129_132552_017030_621FB1A8 
X-CRM114-Status: GOOD (  15.40  )
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

Enforce that files for incoming (preserved by previous kernel) VFIO
devices are retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD rather than by
opening the corresponding VFIO character device or via
VFIO_GROUP_GET_DEVICE_FD.

Both of these methods would result in VFIO initializing the device
without access to the preserved state of the device passed by the
previous kernel.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/device_cdev.c |  4 ++++
 drivers/vfio/group.c       |  9 +++++++++
 include/linux/vfio.h       | 18 ++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 935f84a35875..355447e2add3 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -57,6 +57,10 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
 	struct vfio_device *device = container_of(inode->i_cdev,
 						  struct vfio_device, cdev);
 
+	/* Device file must be retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD */
+	if (vfio_liveupdate_incoming_is_preserved(device))
+		return -EBUSY;
+
 	return __vfio_device_fops_cdev_open(device, filep);
 }
 
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index d47ffada6912..63fc4d656215 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -311,6 +311,15 @@ static int vfio_group_ioctl_get_device_fd(struct vfio_group *group,
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
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index dc592dc00f89..0921847b18b5 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -16,6 +16,7 @@
 #include <linux/cdev.h>
 #include <uapi/linux/vfio.h>
 #include <linux/iova_bitmap.h>
+#include <linux/pci.h>
 
 struct kvm;
 struct iommufd_ctx;
@@ -431,4 +432,21 @@ static inline int __vfio_device_fops_cdev_open(struct vfio_device *device,
 
 struct vfio_device *vfio_find_device(const void *data, device_match_t match);
 
+#ifdef CONFIG_LIVEUPDATE
+static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
+{
+	struct device *d = device->dev;
+
+	if (dev_is_pci(d))
+		return to_pci_dev(d)->liveupdate_incoming;
+
+	return false;
+}
+#else
+static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
+{
+	return false;
+}
+#endif
+
 #endif /* VFIO_H */
-- 
2.53.0.rc1.225.gd81095ad13-goog


