Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEDF60A7F05
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rYCXSPXP;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dPTm+ije
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=uG7rE7VtaZNVuMuLVIq/vVqSMDnx3FJ/eSjGr3CevQ8=; b=rYCXSPXPwFF6HC+ketaMIT+C+e
	IRptn+cLDdurQNqeqNJH6tPVf325JfhIYQTZUlm54PHXy+BMyJnb7i7oM61eHV9KVar/Rv58QJTAr
	AS2eEkfIVfXet4CobJKnaHum2MnBvc5hD9Sn+a13TcUdqM+dZ1A5xUqP7SzIbO/vos2mVOaHMkhHH
	tcQrnwZkUDzXhSMpWokgeu/noZGBTG0A00dhQJXcTOVb4QcBua+ykKRSn3z+8oz+zFioB/Mtc6Ib8
	0QgtwxHABJfgW8l3dejG6sde3tLh7f8eSW4ZJRqnftIEmXJ5YF8Zcv8uQqdEpLlsVxdSdgm8Z0Odo
	ld+z2KLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu60-0000000H9hM-2i3D;
	Mon, 02 Nov 2026 15:37:16 +0000
Received: from mail-pl1-x646.google.com ([2607:f8b0:4864:20::646])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu5v-0000000H9WH-0JOX
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 15:37:13 +0000
Received: by mail-pl1-x646.google.com with SMTP id d9443c01a7336-2e93f67358eso35402195ad.1
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 07:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633829; x=1794238629; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uG7rE7VtaZNVuMuLVIq/vVqSMDnx3FJ/eSjGr3CevQ8=;
        b=dPTm+ijeaSSbEmko0Xx7vVted7O0q0zFfTvWti16uH1VfjaQOPce96wLQPeydSzJAS
         Lg0/1iy1wjExfxTt056teWvO0WuL/RY/qzU7jXZVLAnRRwpC03grxs0wkjMvA/TqkV5k
         PaTRLdKC74aq9re87KJFzMHiK0Z+KBZ1eWs6KkcnUvdxrnikdcHAbCturd1eLYuMj5tN
         MUQQAKYEs2yxN5ljCaWqQJdM6F5pB6C7eK3VFw6qVBYyb1mQi901D23tqm5sxL3JB2wo
         2u1Zf0cS+nNzD0Yv62y/rYE3398PFqyDhPTpL5FK+YNea6TOzL0tl00LVEy3hHiXNGIl
         P+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633829; x=1794238629;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uG7rE7VtaZNVuMuLVIq/vVqSMDnx3FJ/eSjGr3CevQ8=;
        b=yxBoazW/Av575XzZl7mOHpVMEn4/u+yYC2rhyUIAcFgCLEXIvS8zeSlNFjq2wYtLuB
         5TI+2WYHXUefyMRGK+T+5FKIjeuNDqn2Ss1pLOJ2ClWTdydvirD7/tGx+S4yKDPVaqNV
         stOOq7fzpilwGYwRNxzOtVxHusYRkFBKswhhmG1Hcny4+75xkQckE4Cia7vEUXT3JdHG
         IHpixwTYikUkMLiY6G//UqzUo07u+6eGc+L3C346F37lig82a9bUmHale9rnr65t4tQz
         dEXDbAVFChNoMa352s0h+fC3xcusQPLFRSgBFiO359lVGuXIYzmZBt1umJBFYRC+Y6e6
         OHyA==
X-Gm-Message-State: APuU4Z8hQdZxvS8faKtspPFM2XyE4UbdRe7nqJjiXwPC8qSr3HuApWoC
	ccb7YSENTxHOQwHrvWyPxi27u72vgTMKto04TXGw2v5RLrdtXpkwWGgDYn5AiJ6ISxhX7mp93B6
	MQ12oDwPxdxw4zKDaTbcUzBHXelO5cLx70qI++9TXrR+dZWYrNwgPbv2WO0IsRhT0notQo1bbhc
	NqXNqblvW4xatmUlOZ311TkEe1Uqz/BoE2gYYz8t12M+YFVw==
X-Received: from plct12.prod.google.com ([2002:a17:902:d28c:b0:2e5:712c:5c7])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea02:b0:2e9:2a1a:8b69
 with SMTP id d9443c01a7336-2eb364f1986mr88587545ad.55.1793633828399; Mon, 02
 Nov 2026 07:37:08 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:37 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-9-vipinsh@google.com>
Subject: [PATCH v6 08/27] vfio: Introduce vfio_find_device() helper
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
X-CRM114-CacheID: sfid-20261102_073711_299687_6EDC714F 
X-CRM114-Status: GOOD (  19.66  )
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
index 291460102cd1..00b3bc0c5339 100644
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
@@ -383,17 +384,20 @@ static int __vfio_register_dev(struct vfio_device *device,
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
@@ -1845,6 +1849,58 @@ int vfio_dma_rw(struct vfio_device *device, dma_addr_t iova, void *data,
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
index 3cfbf1d73479..1c1e41de49b3 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -441,4 +441,6 @@ static inline bool vfio_file_is_bound_cdev(struct file *file)
 }
 #endif /* IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV) */
 
+struct vfio_device *vfio_find_device(const void *data, device_match_t match);
+
 #endif /* VFIO_H */
-- 
2.56.0.317.g454f8302e1-goog


