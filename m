Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F1B60A7F11
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zSK+MnXb;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kW9Emyg+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3L9pfGvMPznW7jp7Vs9w+wIM+Sxe1yFTij+KVLbvMwU=; b=zSK+MnXb803iHvDTyWd3ovMWiV
	RMJIQa/hBZ4fxymKy+RWzbiXzpjMHLCO3u7qN0vomAxjyDc2Whvf9UhBh5ZizbyC+8M6dkPhKQHCL
	nccEKupvI9x5RfQJPT9OKE/9F3sc0EbLI+EguCQCkf3e9KZAOm72rwtZZVvnyz8/4IdN2eDKjD8Gc
	zXEtyTrqvIAcWVP6ZP4CTi+9bJ2TumdQwACevX8XSnW+8Zc26wzMjNd4Bx7MXxiSj4euWWSezoj5O
	dfyLxWYzUSxut/pDdzEZO94HCxy7yVeEi7LaKrexgPwnWXjTZJJyO4th5yhYMtr4mPtEBtzzUvJuW
	QlrTylzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu60-0000000H9i9-3fF7;
	Mon, 02 Nov 2026 15:37:16 +0000
Received: from mail-pl1-x648.google.com ([2607:f8b0:4864:20::648])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu5w-0000000H9Yo-3dRl
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 15:37:15 +0000
Received: by mail-pl1-x648.google.com with SMTP id d9443c01a7336-2eb1f470a57so20749785ad.2
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 07:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633831; x=1794238631; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3L9pfGvMPznW7jp7Vs9w+wIM+Sxe1yFTij+KVLbvMwU=;
        b=kW9Emyg+A0buWZI/akpNgTDFFCz8Ka9oCPCpaHSC79LGUyClieSZ7XdaINl8sIsqjd
         8QtPnHRkuIh5hW28qL/Hn0EZMKLE7UEs1LUihGv5rUrMwpGTaN6yLbi9Kqu6QVqajeqt
         NSwktaWP35q97d0pMWQ4LR/rmEwSiuDBKG9a1dQxptdsTMygZqLMhe98D//7p3KRyqMw
         dgd+bzsIn2IJtFvHK7pTmrHJm47UPpX5pusM+72FdM687DRJfxe0KaAHHYiUQJRoafh/
         SDNnyKVPOp4ci+WB4oiwxDiiYi5ksEog8550LMuWmUSjnrXj8LTgwWHFSy0w4adf9XRw
         SI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633831; x=1794238631;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3L9pfGvMPznW7jp7Vs9w+wIM+Sxe1yFTij+KVLbvMwU=;
        b=Vq6WSiygQCxYaXAQ2J3gCG5m7CN7hPVhzcCiaguLDo3U+Gx6G3fzDVPnbdD3t+J+m/
         mY+W+sRzNLGwZQSILG2sbmglQU8tvCqKbXmV48JHqbrNE5pcji1LoPvWHg7wUNes0ZaS
         oO5+hnS/66laNmdpS7PN/dNPd6F3Rxtch7OWFYeoK31BeRyb/nHnFGTr/YE8qCoHxkUn
         QopsYbSdvkddzhpATopM+ypTMTttmU8UB1UtAGUIXyAN6IBTf2mXc4HInfvkKTfxuaY2
         8Azu3wpOdZ7zPrA0a2bSJ+tYRPgXoEIsoYjHq1V2xSqGwYu5hk2e/pRLU5plyVOOASd2
         4iGg==
X-Gm-Message-State: APuU4Z/s50aLiYkF+XZ1pyAMvP60N+ee6p46Qi7tO5mtlwc0a0KTLVur
	pu4R8mtvz7o1Yq4X8hle0uXKvK3G+vy4T4Yg1AlO/eiebuPGhSkcq76RrtpZ8OenXfbgbPos9ZJ
	W0yTNVLEWkE3VVgjlU6f01iyrbGce6bRda0V+b8JYCv6ryaC0vDIf3hGLO2VGKU+nhZrkI+j0pS
	YHOpXtI8WvwSXJNULL7E+cNOp9/CjSTFGguZRMMy5VqwZEaw==
X-Received: from plblf11.prod.google.com ([2002:a17:902:fb4b:b0:2ea:7f9c:2ce])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:124d:b0:2e3:1bb4:6121
 with SMTP id d9443c01a7336-2eb364deeadmr90939265ad.49.1793633830638; Mon, 02
 Nov 2026 07:37:10 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:39 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-11-vipinsh@google.com>
Subject: [PATCH v6 10/27] vfio: Add API to open cdev device for Live Update restore
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, 
	schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_073713_149876_D7CAB90A 
X-CRM114-Status: GOOD (  18.05  )
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

During Live Update restore, VFIO PCI driver needs to recreate the device
file context that was preserved before kexec and return it to the user.

Provide an API for VFIO Live Update to get VFIO device file. Use an
anonymous inode when creating the file, since the retrieved device file
is not opened through any particular cdev inode, and the cdev inode does
not matter in practice.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/device_cdev.c | 39 ++++++++++++++++++++++++++++++++++++--
 include/linux/vfio.h       |  6 ++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index d83e99137e1a..38e691eceab5 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2023 Intel Corporation.
  */
+#include <linux/anon_inodes.h>
 #include <linux/vfio.h>
 #include <linux/iommufd.h>
 
@@ -20,9 +21,10 @@ void vfio_init_device_cdev(struct vfio_device *device)
 	device->cdev.owner = THIS_MODULE;
 }
 
-static int vfio_device_cdev_open(struct vfio_device *device, struct file *file)
+static int vfio_device_cdev_open(struct vfio_device *device, struct file **filep)
 {
 	struct vfio_device_file *df;
+	struct file *file = *filep;
 	int ret;
 
 	/* Paired with the put in vfio_device_fops_release() */
@@ -40,6 +42,24 @@ static int vfio_device_cdev_open(struct vfio_device *device, struct file *file)
 		goto err_put_registration;
 	}
 
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
 	file->private_data = df;
 
 	/*
@@ -51,11 +71,26 @@ static int vfio_device_cdev_open(struct vfio_device *device, struct file *file)
 
 	return 0;
 
+err_free_device_file:
+	kfree(df);
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
 /*
  * device access via the fd opened by this function is blocked until
  * .open_device() is called successfully during BIND_IOMMUFD.
@@ -65,7 +100,7 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *file)
 	struct vfio_device *device = container_of(inode->i_cdev,
 						  struct vfio_device, cdev);
 
-	return vfio_device_cdev_open(device, file);
+	return vfio_device_cdev_open(device, &file);
 }
 
 static void vfio_df_get_kvm_safe(struct vfio_device_file *df)
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 1c1e41de49b3..f46796b6724c 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -434,11 +434,17 @@ void vfio_virqfd_flush_thread(struct virqfd **pvirqfd);
 
 #if IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV)
 bool vfio_file_is_bound_cdev(struct file *file);
+struct file *vfio_device_liveupdate_cdev_open(struct vfio_device *device);
 #else
 static inline bool vfio_file_is_bound_cdev(struct file *file)
 {
 	return false;
 }
+
+static inline struct file *vfio_device_liveupdate_cdev_open(struct vfio_device *device)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 #endif /* IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV) */
 
 struct vfio_device *vfio_find_device(const void *data, device_match_t match);
-- 
2.56.0.317.g454f8302e1-goog


