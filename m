Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743D6C44508
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 15:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/JxusoxEn+ehjTRVvbJo8Z2+RthtKj17Kn8IH4fWGXA=; b=VenB7TReICgMqMR2hxKo1rjdHp
	welUsbz6FTYNeIL37XuJmnq4kZl0i6CLRrAjv/GDpLHBdgQLhLcW4KEexH3Cjag7B7FxcmHtbxRcM
	1YiQEFZZXE1DnVq7Y6exdgElBD/e0clGZWapDhFEvzCcpPQgt8PVzOShk9sM9VphlSoD0FaomR/35
	wBqfCmWwBytRCPhl9Bj8Uuinx7fykK1ElZ02+dv4m0WKM3te+ocup9XdVgKmb+6ZBaJBZvlHT2mWc
	mx5iJDrU5firYrIWHru8JMQOccqrOGx5fsgacZSw/zDoKcPnCQHfaVuuhZTln79rgT00nkXoX1Mby
	0IYCU/rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjeqy-0000000CUEv-1Exw;
	Tue, 14 Jul 2026 15:15:24 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjeqx-0000000CUB8-0lpy
	for kexec@bombadil.infradead.org;
	Tue, 14 Jul 2026 15:15:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/JxusoxEn+ehjTRVvbJo8Z2+RthtKj17Kn8IH4fWGXA=; b=NhnPkfD9LfbwKviz47xTksH6Se
	8NwaxCpGekaYKSPGB13/vG/FRgXkczSO8C/AroJgzi2rRs9JRqNA0gktHEAmnEX47ZsjCSJt8Yv1v
	IfbtJ6yH2KxJ8/0Kr749+YhBgWO3LtSxVt0QyjkxRas/GWIBQTLt4t7PPsYsDKhw2zBVIEa8GXN9E
	NcT1I5O+LDjJRbEkYj9uZbDkEVJcBvRh9HfyUxBXC524oKJmOL2Q9O8Sp8TMIVlPwxvVzH2XEyAy2
	RyKnu+NSGhsGbQGKengI52LKui/ptZzd3uNiashjMnchCzTzXPcalMOwKghIYabJZOB1Ex5H2VkBH
	kYUxlwnA==;
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wjequ-0000000Cd2x-0rz2
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 15:15:22 +0000
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-848860def2cso4614520b3a.2
        for <kexec@lists.infradead.org>; Tue, 14 Jul 2026 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042117; x=1784646917; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/JxusoxEn+ehjTRVvbJo8Z2+RthtKj17Kn8IH4fWGXA=;
        b=IfaZWd4uqWgP3bUFF4p3K7g5rOcw3ZcgTw7r1BCwiuR9Wkh3/xkwa1MyP+EGzsjJyu
         73bEyerdlsQGY0KXG2TKR35uAxYvQGuAJDXQUslqTkEGxA2RFc3lN1PZfama8a4DrChn
         CkrSQy39D2kobFmvOPlLwDz2LBSn7j33ANXX0Svil331/HOD+dVZzz+fEllBpgBpzD+c
         K2sLpvayfcW63l6tVX4K1zpd87LWmrVkqr2g/r+5nvLmCKzoXmJ09po2rqCqf2G+qvOX
         51zM2c8gPOBOXGUFCNgErESWpBpAxaL94PtXAzNqKWUeBMesCOVIj8AX+F4nNNwIuHYe
         i4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042117; x=1784646917;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/JxusoxEn+ehjTRVvbJo8Z2+RthtKj17Kn8IH4fWGXA=;
        b=PnzL0tCadhzRKExA67dXPpPuUf7tegrPGZLG/AhxqL5G2C2nLbdhr+8xIAFHwcJPhP
         dou6H6ucIxLUZOqtpH/Tiy+2YefSf293nyJgu5vWw2g4mIEHNJMLwIXElR9fEl/UwOKh
         XA2hQqBRi2/SXmh+GkW6jvndINSpafImvWcSn2WmkpsaMda32tSgj45W5RzlBdkwpErw
         FrW5cNBDDoxk9GTSvkWiSt25BaVOucIET2WE990ipGIIkeZ1r6hXghYPc15LQ1iqONNQ
         3YKho8BlAnRhV9oFoPADMjiBkqeCScmkc2M9kItxhHIbmBWB3gDDnBY/LnoOy+aOViyo
         TclA==
X-Gm-Message-State: AOJu0YxIlw1gB/nrDdPPspUL8FBUNfaUw6m5eQmpU37HbDMJZa8z4a3l
	8jgk+hs6bkQNsfGiFx7BngLzH8sZ29Kk98xw4LevNaVyreKlvHMP8P/Bz4B8vSyGqfnB1/ab6K8
	FVpetJBq1Yk7AtKAoiT5DN33EU4st+Ncz8tWydAUO4eqZXt9one40xpLZ6B8mFtXxmMDncZdKPy
	Cx7AF68W4b2AXQikI5OYsjIxKBLICbfHJRi3kzNlrgDFkp8A==
X-Received: from pfbcr14.prod.google.com ([2002:a05:6a00:f0e:b0:84a:2de2:315f])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:94f5:b0:82f:2b0:2809
 with SMTP id d2e1a72fcca58-84889637281mr13764500b3a.1.1784042116875; Tue, 14
 Jul 2026 08:15:16 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:14:52 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-8-vipinsh@google.com>
Subject: [PATCH v5 07/20] vfio: Introduce vfio_find_device() helper
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
X-CRM114-CacheID: sfid-20260714_161520_506225_6954B15B 
X-CRM114-Status: GOOD (  19.43  )
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

Introduce vfio_find_device() to discover a registered vfio_device from
vfio_device_class matching user-provided criteria.

To ensure safe lifecycle handling, vfio_find_device() acquires a
registration reference (device->refcount) via
vfio_device_try_get_registration() rather than relying solely on
device.kref taken in class_find_device(). Holding only kref allows
vendor modules to unload while external callers hold device pointers,
leading to a kernel panic on release. Callers must release the device
via vfio_device_put_registration().

Additionally, move refcount_set() prior to vfio_device_add() in
__vfio_register_dev() so device->refcount is initialized before the
device is published to class lookups, avoiding registration data races.

On vfio_device_add() failure, the error path drops the initial
registration reference and waits for completion to drain any reference
taken by a concurrent lookup before returning the error to the driver.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/vfio_main.c | 64 +++++++++++++++++++++++++++++++++++++---
 include/linux/vfio.h     |  2 ++
 2 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 2437af031169..e91fd83dc58d 100644
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
@@ -359,17 +360,20 @@ static int __vfio_register_dev(struct vfio_device *device,
 		goto err_out;
 	}
 
-	ret = vfio_device_add(device);
-	if (ret)
-		goto err_out;
-
 	/* Refcounting can't start until the driver calls register */
 	refcount_set(&device->refcount, 1);
 
+	ret = vfio_device_add(device);
+	if (ret)
+		goto err_add;
+
 	vfio_device_group_register(device);
 	vfio_device_debugfs_init(device);
 
 	return 0;
+err_add:
+	vfio_device_put_registration(device);
+	wait_for_completion(&device->comp);
 err_out:
 	vfio_device_remove_group(device);
 	return ret;
@@ -1797,6 +1801,58 @@ int vfio_dma_rw(struct vfio_device *device, dma_addr_t iova, void *data,
 }
 EXPORT_SYMBOL(vfio_dma_rw);
 
+struct vfio_device_match_data {
+	const void *data;
+	device_match_t match;
+};
+
+static int vfio_device_match_fn(struct device *dev, const void *data)
+{
+	struct vfio_device *vdev = container_of(dev, struct vfio_device, device);
+	const struct vfio_device_match_data *mdata = data;
+
+	if (mdata->match(dev, mdata->data)) {
+		if (vfio_device_try_get_registration(vdev))
+			return 1;
+	}
+	return 0;
+}
+
+/**
+ * vfio_find_device - Find a registered VFIO device matching search criteria
+ * @data: Context data passed to the @match function
+ * @match: Device match callback function
+ *
+ * Finds a registered VFIO device in the vfio_device_class matching the search
+ * criteria specified by @match.
+ *
+ * On success, this function acquires a registration reference on the matched
+ * device via vfio_device_try_get_registration(). This pins the device and
+ * prevents its vendor driver module from unloading or unbinding while the
+ * reference is held.
+ *
+ * Return: Pointer to the matching vfio_device on success, or NULL if no
+ * matching device is found. The caller MUST release the acquired registration
+ * reference using vfio_device_put_registration() when finished with the device.
+ */
+struct vfio_device *vfio_find_device(const void *data, device_match_t match)
+{
+	struct vfio_device_match_data mdata = { .data = data, .match = match };
+	struct device *device;
+
+	device = class_find_device(&vfio_device_class, NULL, &mdata, vfio_device_match_fn);
+	if (!device)
+		return NULL;
+
+	/*
+	 * Drop standard kref reference. Caller holds reference from
+	 * vfio_device_try_get_registration().
+	 */
+	put_device(device);
+	return container_of(device, struct vfio_device, device);
+}
+EXPORT_SYMBOL_GPL(vfio_find_device);
+
 /*
  * Module/class support
  */
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index cf0d941d0410..42c3a9ae3a85 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -430,4 +430,6 @@ int vfio_virqfd_enable(void *opaque, int (*handler)(void *, void *),
 void vfio_virqfd_disable(struct virqfd **pvirqfd);
 void vfio_virqfd_flush_thread(struct virqfd **pvirqfd);
 
+struct vfio_device *vfio_find_device(const void *data, device_match_t match);
+
 #endif /* VFIO_H */
-- 
2.55.0.795.g602f6c329a-goog


