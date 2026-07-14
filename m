Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D419FC4450E
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 15:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fk6o2vphXfQkoL1z/+pIbWzomzkKJfAmoavVaL/E+Fg=; b=Nqhjz4hguvchCrMyg3GIURkMWp
	DR01zAPMCDlUdDsWD+pSg75kZmHYRxDJug/ebYFx0Hp93KUWaWgynxruqrTeEh8a6ByrBsbdaaw8j
	OuQ0PF4WEwamO6bBJK836QUG7RRYfbwMDQoMEKdOe21D5c9eWVEKOZtN34VSlYCHQftCt1jBH6gUV
	9jB0C7b+NIEUrFACAllsYAQVNygjXTh4amPEf3t5DCvQ3LNIg0T4oET9hyVf6d8UaVdgIUNz/ih4j
	Q8uznd+THZP3YOR76+N6bv6XkjuxXzDKjQ1Eour7vzZRs3nq5JBVr9cP553n64Wx/a00MI7HEsUxg
	1r882GVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjeqz-0000000CUGi-2Bu6;
	Tue, 14 Jul 2026 15:15:25 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjeqy-0000000CUDo-28g8
	for kexec@bombadil.infradead.org;
	Tue, 14 Jul 2026 15:15:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fk6o2vphXfQkoL1z/+pIbWzomzkKJfAmoavVaL/E+Fg=; b=YMHCABDMHksiBhmY6GrEN3oJ/h
	X4ESGh/cc7vUaDNlbCRWKqkT6zuHJpwtrKgVrysTtLHcqk8d01Klo9Hw5moS29U/Ro4zLVfp9PmB3
	n9U2aziEZLgpc0NTH5fAqZJljm1shEmG4xFjpwJFEF4cUK5MjU5cxlpUuYVUPe0b5iyxSeXgw8WGf
	7ALPi2HKsmHhkTKjT1g6GJqbb0MenGSlZg94RT0dVGpZmdeFEMGth+ja5ZCt7UTDA7oAwzawNjKSJ
	DxrQK61Ph1OQsZiTerSH9ueGJvmVQi1mco8Xe+j1GpK6xLMZ/rpvr4r9AXSD03+zNzYC1ZWxrL2aZ
	oTwndrMg==;
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wjeqv-0000000Cd3F-3KHI
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 15:15:23 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-38dad28e86eso2428947a91.0
        for <kexec@lists.infradead.org>; Tue, 14 Jul 2026 08:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042119; x=1784646919; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fk6o2vphXfQkoL1z/+pIbWzomzkKJfAmoavVaL/E+Fg=;
        b=mvSVhSpMwPepio1uzXKCX4KaIMI9o3lQwqBrbV7Sode5nGmlwdG6WzklUlgbzqZdsW
         TkPlOayEN/dDhD2TYmMqgIxwnnXV6A/Xj9LljRplwWs563EyyteS4ctv4qCKBBjDNTcT
         qawfQn7UXzLOagtU7DgAneDP3LUnCsFL6tqqmlNXctRvXTIWsXAgVC6CFFIx9i+vc4S0
         iccIoTx0Jy72owOPUSSMfXbQoRbvKSbcCE/cOQQWhnFFBGPg4Xf9M73ugGVyE4gANftQ
         WUXmw+K6r0z7GZyr+3dydIZaH+4NnTrSMSp52TSlUzXSlTOL4MHwzOuBdGNwx/ZFafad
         bTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042119; x=1784646919;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fk6o2vphXfQkoL1z/+pIbWzomzkKJfAmoavVaL/E+Fg=;
        b=eSvL+RKfvl+OXGzHC3sRh3yqooFXoLgD5s1NUtigxLgzS97i5DnPrGkrsfsHRR5Z8y
         Ck2n2vJTqoGp/mUAefLZkyVzL+vihNKosSZR+35lAe8ZU47rMjprv8Q2rdTzIPxCr5ZI
         k/9t/YqtOm5IjqbmmHB0hkyH6ivs1D4W/XK7tiCPA69tFQLIeg9Ovlz7FFojXidwEkFt
         KE//J/Mc9ddHQcwGkqyWJrVxhULWQHSMqaDX700pTb1wQ3cL65T7SA/GMTgskjXDX0Pn
         C/Gtdi5Q/NF+26iO1V6OcI7GzN8wf6UO5erHB/aBjmJQKFnhIq2p2b6/emQClI/blUac
         WC4w==
X-Gm-Message-State: AOJu0Yz7f4vSAbN+ZCf8IoiQYXFQpGSVtPEEQT3Q75OicOTY6C2nyWgQ
	Xg0rHQL4YSzPtNMjEUGVi2+fVFrVGHnmc5czwzfTMKR4twnvS3imRLuwSZdj5Ux380r+ALByhT3
	HS9WujcKIIkqgKoLxJIdp3q8cOSabgJdjuXF41HayzURScyOzubuCrm4W7A6Kd4fElUeCLxA/Tp
	7RuAOvUag74kZewDpawwedctD3sKcguis+6RyUtUj9CZsOfQ==
X-Received: from pjyu5.prod.google.com ([2002:a17:90a:e005:b0:383:f7b7:fb7])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dc9:b0:381:528a:808a
 with SMTP id 98e67ed59e1d1-38dc7735977mr13456012a91.27.1784042118892; Tue, 14
 Jul 2026 08:15:18 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:14:54 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-10-vipinsh@google.com>
Subject: [PATCH v5 09/20] vfio: Add API to open cdev device for Live Update restore
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
X-CRM114-CacheID: sfid-20260714_161521_946461_D03ADE16 
X-CRM114-Status: GOOD (  18.61  )
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
 include/linux/vfio.h       |  9 +++++++++
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 2231423fe56d..970932f22ecb 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2023 Intel Corporation.
  */
+#include <linux/anon_inodes.h>
 #include <linux/vfio.h>
 #include <linux/iommufd.h>
 
@@ -16,9 +17,10 @@ void vfio_init_device_cdev(struct vfio_device *device)
 	device->cdev.owner = THIS_MODULE;
 }
 
-static int vfio_device_cdev_open(struct vfio_device *device, struct file *file)
+static int vfio_device_cdev_open(struct vfio_device *device, struct file **filep)
 {
 	struct vfio_device_file *df;
+	struct file *file = *filep;
 	int ret;
 
 	/* Paired with the put in vfio_device_fops_release() */
@@ -31,6 +33,24 @@ static int vfio_device_cdev_open(struct vfio_device *device, struct file *file)
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
@@ -42,11 +62,26 @@ static int vfio_device_cdev_open(struct vfio_device *device, struct file *file)
 
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
@@ -56,7 +91,7 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *file)
 	struct vfio_device *device = container_of(inode->i_cdev,
 						  struct vfio_device, cdev);
 
-	return vfio_device_cdev_open(device, file);
+	return vfio_device_cdev_open(device, &file);
 }
 
 static void vfio_df_get_kvm_safe(struct vfio_device_file *df)
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 42c3a9ae3a85..b896c64b11da 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -430,6 +430,15 @@ int vfio_virqfd_enable(void *opaque, int (*handler)(void *, void *),
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
 struct vfio_device *vfio_find_device(const void *data, device_match_t match);
 
 #endif /* VFIO_H */
-- 
2.55.0.795.g602f6c329a-goog


