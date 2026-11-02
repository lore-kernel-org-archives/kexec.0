Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F8160E6020
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VHOHCNXR;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ddr/31d4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6CTI6wZf9fmjJK3hlmivlOQee38QTMnwowyyRsW/zh4=; b=VHOHCNXRWOFHNEnq+RYLzxY+AB
	GyS1JPF7QueXWQ39J1WtsAceUAr4R0Lb7FaBJ4ZfBib6AL2gC44ouZlTqPqiJaxpvGs034cbTO3kR
	yDdhGpavOLZeNb35S7to//Qy3gnU/c5R+BGO4AB7QJBCc0QcRVhN9L8vzmFGeLe++sKHddy0BVz6N
	CMXYp8JQ4CdSTdUD/5ws/y5uqPARJPUKy2vldCZtvjXtrlEsks8FQDKzzFZZvOUBDDJzAptU2K8mU
	BXLyYdDf7mA+rdBD1d7FY5AymJeNxRInBREj6euRzyNnE9Sxktz7/6EsyOFRD2Ps9W9z0Al2CAOmX
	jSGUSAfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu5v-0000000H9Xz-1LAL;
	Mon, 02 Nov 2026 15:37:11 +0000
Received: from mail-pl1-x648.google.com ([2607:f8b0:4864:20::648])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu5r-0000000H9T3-2IKV
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 15:37:09 +0000
Received: by mail-pl1-x648.google.com with SMTP id d9443c01a7336-2e8dd9b9743so38796035ad.1
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 07:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633827; x=1794238627; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6CTI6wZf9fmjJK3hlmivlOQee38QTMnwowyyRsW/zh4=;
        b=ddr/31d4ArZ0hZwZkO0lJBSG3dAeKHOSqQwiLUwG37NN4n63nbXw+KPmEVk4R6nqKr
         21q1mAh6HMC78croWt9Qqc7VHwjEnMMgkNT/t4kgJ6+xJExdXgkCW3HVkoAY5IT/+i2U
         N4RDSD801Q5uuAPwUpTnEqQXDt5oMkrVGIIVivGKmE2O01Ay/4rbAB3Ek1NrC0U5qYK9
         M5bxbzR3wL+8GJ0kyvElAOAhfIoF7Y6ALhZovfbMs0EtCYdUaUoesOK4fQqjj5+4gYNM
         27sQTznn2EQWcmXfTNfNWVmRfnlyEFs+tjSQfkjX2ISbITMEuEeB1BTLMvAUhbzY3x8l
         UG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633827; x=1794238627;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6CTI6wZf9fmjJK3hlmivlOQee38QTMnwowyyRsW/zh4=;
        b=PBcPsyWajZLFif6gB6sZSwp8NVb/zI6surI8DXew5CetpEsLucAA/64s77OfCprg4P
         fZwg9vPzpRgK7wbCOYc/FYMNVgrBU3a+jf87RJRL9z0iEDyODVBACTwZdzygvfKAH8zW
         ckdRPwV6QwKhrHH4iSVqp8zNGXl4UyRO4S/BXbBJomyovDniutmr+6EDXzliWmqy3Ipk
         /iKS1daFzvf2RC7i/96okuM/8xzWoy4GQpsdAFbM5Gq7Mrht6IQ/hrxR6UYSLQtt9sE5
         3dg1eLUA0GasunAl2OlMUInG0Pfe2cLTikX79ADEIuu03JnP6zUz3+Q0oKOyEh3Bsf94
         azww==
X-Gm-Message-State: APuU4Z+hneQvPQS4sGoDiuF0lbnLufWY/iOS9c/7m3cb8+3/I7/TQU1s
	fhkni9I+IC22Kub526KtcYp5LqS+mPDU8z4PuEdPMJdZ352e66SnzzNfh3bBEKU4odlMvLn4jIg
	x1rSq5It8FJ48W8KkflUFbOtDwiJcknIbRuZ4iEM6SYgVHTiCanaAjzEWtkSDqXnY8CG6AUI2oy
	QmnsPozYCMEEdfH4F6OtY0apGhsdI8+Ro6i4WtJmbf080yOQ==
X-Received: from plct12.prod.google.com ([2002:a17:902:d28c:b0:2e5:712c:5c7])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b2b:b0:2e9:60fb:5e2b
 with SMTP id d9443c01a7336-2eb364e5a41mr100336855ad.44.1793633826227; Mon, 02
 Nov 2026 07:37:06 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:35 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-7-vipinsh@google.com>
Subject: [PATCH v6 06/27] vfio: Add helpers to identify device files that can
 be preserved
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
X-CRM114-CacheID: sfid-20261102_073707_593379_A57DE203 
X-CRM114-Status: GOOD (  16.24  )
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

Add two helpers needed by vfio-pci Live Update support:

1. vfio_file_is_bound_cdev(): checks whether a specific file is a VFIO
   cdev device file that has been bound to an iommufd. Only the bound
   cdev file keeps the device open; the device-level cdev_opened flag
   cannot distinguish between the bound cdev file and a second, unbound
   cdev file opened for the same device.

2. vfio_device_is_noiommu(): move the existing helper out of line and
   export it so vfio-pci can enforce that only devices in no-IOMMU mode
   are preserved across Live Update.

No functional change intended for existing callers.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/device_cdev.c | 20 ++++++++++++++++++++
 drivers/vfio/vfio.h        | 10 ----------
 drivers/vfio/vfio_main.c   | 18 ++++++++++++++++++
 include/linux/vfio.h       | 10 ++++++++++
 4 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 1d9515c967b0..23b229468151 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -200,6 +200,26 @@ void vfio_df_unbind_iommufd(struct vfio_device_file *df)
 	vfio_device_unblock_group(device);
 }
 
+/**
+ * vfio_file_is_bound_cdev - True if the file is a VFIO cdev file bound to an
+ *                           iommufd
+ * @file: File to check
+ *
+ * Return: True if @file is a VFIO cdev device file on which
+ * VFIO_DEVICE_BIND_IOMMUFD has succeeded, false otherwise.
+ */
+bool vfio_file_is_bound_cdev(struct file *file)
+{
+	struct vfio_device_file *df = file->private_data;
+
+	if (file->f_op != &vfio_device_fops)
+		return false;
+
+	/* Paired with smp_store_release() in vfio_df_ioctl_bind_iommufd() */
+	return !df->group && smp_load_acquire(&df->access_granted);
+}
+EXPORT_SYMBOL_GPL(vfio_file_is_bound_cdev);
+
 int vfio_df_ioctl_attach_pt(struct vfio_device_file *df,
 			    struct vfio_device_attach_iommufd_pt __user *arg)
 {
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 7728bc99b63d..12557d45dfee 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -185,16 +185,6 @@ static inline void vfio_group_cleanup(void)
 
 #endif /* CONFIG_VFIO_GROUP */
 
-static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
-{
-#if IS_ENABLED(CONFIG_VFIO_GROUP)
-	if (vdev->group && vdev->group->type == VFIO_NO_IOMMU)
-		return true;
-#endif
-
-	return IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) && vdev->noiommu;
-}
-
 #if IS_ENABLED(CONFIG_VFIO_CONTAINER)
 /**
  * struct vfio_iommu_driver_ops - VFIO IOMMU driver callbacks
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 73a5c4f3751c..291460102cd1 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1507,6 +1507,24 @@ struct vfio_device *vfio_device_from_file(struct file *file)
 }
 EXPORT_SYMBOL_GPL(vfio_device_from_file);
 
+/**
+ * vfio_device_is_noiommu - True if the VFIO device is registered in no-IOMMU
+ *                          mode
+ * @vdev: The VFIO device to check
+ *
+ * Return: True if @vdev is registered in no-IOMMU mode, false otherwise.
+ */
+bool vfio_device_is_noiommu(struct vfio_device *vdev)
+{
+#if IS_ENABLED(CONFIG_VFIO_GROUP)
+	if (vdev->group && vdev->group->type == VFIO_NO_IOMMU)
+		return true;
+#endif
+
+	return IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) && vdev->noiommu;
+}
+EXPORT_SYMBOL_GPL(vfio_device_is_noiommu);
+
 /**
  * vfio_file_is_valid - True if the file is valid vfio file
  * @file: VFIO group file or VFIO device file
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index de3fa6e6bf2a..3cfbf1d73479 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -380,6 +380,7 @@ bool vfio_file_is_valid(struct file *file);
 bool vfio_file_enforced_coherent(struct file *file);
 void vfio_file_set_kvm(struct file *file, struct kvm *kvm);
 struct vfio_device *vfio_device_from_file(struct file *file);
+bool vfio_device_is_noiommu(struct vfio_device *vdev);
 
 #define VFIO_PIN_PAGES_MAX_ENTRIES	(PAGE_SIZE/sizeof(unsigned long))
 
@@ -431,4 +432,13 @@ int vfio_virqfd_enable(void *opaque, int (*handler)(void *, void *),
 void vfio_virqfd_disable(struct virqfd **pvirqfd);
 void vfio_virqfd_flush_thread(struct virqfd **pvirqfd);
 
+#if IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV)
+bool vfio_file_is_bound_cdev(struct file *file);
+#else
+static inline bool vfio_file_is_bound_cdev(struct file *file)
+{
+	return false;
+}
+#endif /* IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV) */
+
 #endif /* VFIO_H */
-- 
2.56.0.317.g454f8302e1-goog


