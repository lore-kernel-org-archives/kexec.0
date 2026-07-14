Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1ECC4450B
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 15:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2EHEoo7An3D7oI8NS/D99aTdGzqKD9FxsvRgklpMZ9w=; b=GXRVK49E9nRXD+HbAmhrr/noKC
	p99CLtunmoVFTVzo08CWt/r2S/hlF0m2zjLaFPvx/J17EbWMWuW0qaIDvNrfoClzbsCKW1KPVuGts
	irvrUeyeasPatBFpRWP7mp7jG5cVDhqiLMyb9qiIy+neXNZR0+pLKM2Mj0h/mWTf7rY1RY4qgUsEC
	HmIRWIia+IbPiJXEAb8IQO0ZSk9OVR/Qu5mp2ipAuTc8awRIZWIY+uN18Rt6bC4RT6/SnJA4D0wqV
	L9z8m1r80KZ0UprK/L+o+iS7Dtl2W7m7PSakmVyFnFyEMHbFKPHXHgjzrJ/Fe3E+JfMqDjsvEaJT0
	KEwZaNtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjeqy-0000000CUEU-0dxC;
	Tue, 14 Jul 2026 15:15:24 +0000
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjeqv-0000000CUA2-1lm7
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 15:15:22 +0000
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-8485b7e18b4so7807863b3a.1
        for <kexec@lists.infradead.org>; Tue, 14 Jul 2026 08:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042120; x=1784646920; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2EHEoo7An3D7oI8NS/D99aTdGzqKD9FxsvRgklpMZ9w=;
        b=atLrUCVftcysjWUa+KqkEgW23NC9q92dkK0hLKAQ09VTFbunFwac8l6oSzh51A4ymF
         PAcWceME4CpsGmYJkDfRSWp6zRDbwiHW8rNvRYmbAXcM1/Ac+G5vBxWbBGBY74MdhGHN
         OHlY2f7O8Ll3MlJK41uu3NlmGRxRsOmEb2f4+6WsHjGGIbM7fj/OqD7vj5x9ApfSsijj
         oLv16XN2inncMtAIe6PXL9TmSa+NW9jk/xT/LACGwYYJOFu+NA6ddhflgvw8bP4s8wTe
         wxgKFSuDjqkb58B7wE3KkgAXQLzaygVTbODSzWdNETKd3qu1ndlRSKhsXe1oNXGVdxuF
         4mQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042120; x=1784646920;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2EHEoo7An3D7oI8NS/D99aTdGzqKD9FxsvRgklpMZ9w=;
        b=dHgFT9HHkLz0Wa3A/CPWH+eF99UuoH+9nomIzzw8fTmEi1E1RILf8Y7HoAI06iCCZp
         wP7jvL/KGV4HqIHZeMyma/t2iBExW7F2IaNlxU14ZRsQAzTKTCfJ9u4djKFtSiAx8+dN
         jjRJTzlhe2KSxRanihOobTTlpM2RCYYjZVNBjSgU+lCXTNiWXe5EOVLJ9qaC9+r5fqGp
         QWakuZivg77Da2ZtE0Pu/nL3jZoMJ9QcVNKFJIG4E8vJ03W9vCY2Bb9vJKQtcA3RSp+i
         /IK8I++odZnMzPMUD9H27y7fTPGp6LHjtb+K20l3N5GwavoCoZoYdIR2At0QUJNNXdXm
         QQXg==
X-Gm-Message-State: AOJu0YwPYyD5Ma0UehCQOZhJpQTGFVYEmgn7ddX0oVF0+bE74do9Ums/
	dCWDSdzFfUmG9powQXGeT+nL/eVlD4EaNSdtfP6rx+/FvJNNwUglGhzBEUBVxjOgenAnhZODFl0
	k6ejJsRkkqLSuD6ym5uIfnsf4AlAqKQgwwjVNcFmz2OsFdKUaEysmWguBpaDAsWXoiJjhIEdzsM
	bYhuiX+iDL7BRuqhx5nHJBFkLX4YgZ7iP4CeT/WCDPRDqjRA==
X-Received: from pfbdi5.prod.google.com ([2002:a05:6a00:4805:b0:848:4690:d658])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:c081:b0:84a:2d5c:528c
 with SMTP id d2e1a72fcca58-84a2d5c562cmr6425028b3a.61.1784042119955; Tue, 14
 Jul 2026 08:15:19 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:14:55 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-11-vipinsh@google.com>
Subject: [PATCH v5 10/20] vfio/pci: Retrieve preserved device files after Live Update
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
X-CRM114-CacheID: sfid-20260714_081521_476115_27FDF09D 
X-CRM114-Status: GOOD (  20.17  )
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

Enable userspace to retrieve preserved VFIO device files from VFIO after
a Live Update by implementing the retrieve(), can_finish() and finish()
file handler callbacks.

During retrieve, find the VFIO device using the BDF and domain
information from the serialized state, and open it using the new
vfio_device_liveupdate_cdev_open() API.

Disallow Live Update to finish if userspace hasn't opened the file
successfully or any error occurred during retrieve.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/vfio_pci_liveupdate.c | 64 +++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index e6eb7f6b53d7..4baac80d03f0 100644
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
@@ -93,6 +99,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/errno.h>
+#include <linux/file.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/vfio_pci.h>
 #include <linux/liveupdate.h>
@@ -223,13 +230,65 @@ static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *args)
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
+	vfio_device_put_registration(device);
+	return ret;
+
+}
+
+
+static bool vfio_pci_liveupdate_can_finish(struct liveupdate_file_op_args *args)
+{
+	struct vfio_device *device;
+
+	if (args->retrieve_status <= 0)
+		return false;
+
+	device = vfio_device_from_file(args->file);
+	guard(mutex)(&device->dev_set->lock);
+	return vfio_device_cdev_opened(device);
 }
 
 static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *args)
 {
+	struct vfio_device *device = vfio_device_from_file(args->file);
+
+	pci_liveupdate_finish(to_pci_dev(device->dev));
+	kho_restore_free(phys_to_virt(args->serialized_data));
 }
 
 static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
@@ -238,6 +297,7 @@ static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
 	.unpreserve = vfio_pci_liveupdate_unpreserve,
 	.freeze = vfio_pci_liveupdate_freeze,
 	.retrieve = vfio_pci_liveupdate_retrieve,
+	.can_finish = vfio_pci_liveupdate_can_finish,
 	.finish = vfio_pci_liveupdate_finish,
 	.owner = THIS_MODULE,
 };
-- 
2.55.0.795.g602f6c329a-goog


