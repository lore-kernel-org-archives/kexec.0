Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC65AF532C2
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 23:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FxGJfmbE6y6D4fg7v0R8cmHFXmMbzFJlr4dbGGaFVKE=; b=DHqUH6LOyEBNSrO2mscPW2qlD4
	d36FHzPlLVvoZNmXnGL5lMH7pMGtbqaxdku70So3BKU4GiSJpFJqY8jUcToe9voAOYgmf3vmZ0pWD
	Tt5WD52bAlYu34dYj4PiVqUNHILwIxSIf19e6onBqkPDabqRV/Ti1ZT5qsFrlS3cnJsSfUnH/B+1H
	ym6tHtYK5mfITTU5yiC7oHx9iEOfffCPq51SQDpkng7svNzsDEl2TW2UsqPgKxeYnM0eiY0pmatWg
	A05BsgaS1bv8O9oy+8jPlF99jxPeghOIAQB29zRYponDsg7ZLWzUOO9EbhpC+S1Yi3gcPPreaYxFK
	/xfO8E6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAe-00000000BUn-3O66;
	Mon, 23 Mar 2026 23:58:56 +0000
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAc-00000000BPw-1yBA
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 23:58:55 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-35a1e725a8fso24244142a91.3
        for <kexec@lists.infradead.org>; Mon, 23 Mar 2026 16:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310333; x=1774915133; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FxGJfmbE6y6D4fg7v0R8cmHFXmMbzFJlr4dbGGaFVKE=;
        b=LmxalyB3z2rnqRKeo3M2uplMkbNQePCYLdUqoRlejQt4LuqUR7EurcgpcUlQiNnv1H
         bx8rwoJA1OFoUWhdffkgSZnhl91RS+SF/Qpjrg//6M5xgPJehLp4gA/e8fpzJlpFgBLc
         sxnzr6IxepFxmnaBRkg2drwffdZ5pKV0AzsMCb0ufx+6ltKq7eu9ZILAn98ko/nV4nni
         mKJF9/KeGFuxKHPOvcfpFEw6erywUpp8NTPJuO0DEvS3lLoXDBGl3HBNv69eG3dkU1cp
         ee3UWI8jkajeN8WUOS7STeeivRLYFAbX/VZkK65zazw5Q5Ee91dL9BMYsy0OkweRFonr
         1LcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310333; x=1774915133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FxGJfmbE6y6D4fg7v0R8cmHFXmMbzFJlr4dbGGaFVKE=;
        b=jaq6gLJdyl0mn1KOWKw/v5Kb2ZpeZ2soqvLbi9CpPRUmyA1RY5SJANDqWHRBgobjmm
         9a29cajZO5MP9tOl9zHsNrP2yRi626m1kDKa+qc2fnJ9XhGvs9KLjCjsDHIYtkPWfo9V
         9TmEYX9ZLSpzjqXLYMHq4W5Jtjn4m0W6JGHIC5j2L4vrfaJPVuj3GC5bKHXuIGnoJQNA
         jmGKWQzriyD0z9HUcK38iLWMULkeOPkK/1MKlgfuR/JSRnMgrlGmMqRopycr1rZFgDRj
         ljINyIPSwKb0arBb0aHPkgopEa3ZudoGjBKDEMz4vKpN+8M35M8O7QJaM1JgSg6Ue2vX
         IKuA==
X-Forwarded-Encrypted: i=1; AJvYcCWFuB1kN/eTjXaGx0ST+67ZUJNNO1m+sJnkqHL7xvfaxNG2K6uSpKgd5UFzw9wkOCN7u6EyQw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy1PA/88oU1GqweIeh0zJgI4/6bHQmCncl8AJpMq4bzV/8z0Z4T
	5Qz/1TVUeSMuq4/g9ghKWPaotWAY2grl+HmREOdUD+jSjNnJRhK40DhyS8cPB4DWrZgUIilX0c0
	LUKMbKtps/reChg==
X-Received: from pjbca11.prod.google.com ([2002:a17:90a:f30b:b0:359:84f3:a9d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:384b:b0:35b:9ae3:9080 with SMTP id 98e67ed59e1d1-35bd2c62dc6mr13468908a91.14.1774310333147;
 Mon, 23 Mar 2026 16:58:53 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:58:01 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-10-dmatlack@google.com>
Subject: [PATCH v3 09/24] vfio/pci: Notify PCI subsystem about devices
 preserved across Live Update
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
X-CRM114-CacheID: sfid-20260323_165854_519204_9341DBA1 
X-CRM114-Status: GOOD (  18.98  )
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

Notify the PCI subsystem about devices vfio-pci is preserving across
Live Update by registering the vfio-pci liveupdate file handler with the
PCI subsystem's FLB handler.

Notably this will ensure that devices preserved through vfio-pci will
have their PCI bus numbers preserved across Live Update, allowing VFIO
to use BDF as a key to identify the device across the Live Update and
(in the future) allow the device to continue DMA operations across
the Live Update.

This also enables VFIO to detect that a device was preserved before
userspace first retrieves the file from it, which will be used in
subsequent commits.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/pci/vfio_pci_liveupdate.c | 44 +++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 4b83a02401aa..b960ec3ffbf2 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -67,6 +67,9 @@
  *    interrupts on the device will cause the ``reboot(LINUX_REBOOT_CMD_KEXEC)``
  *    syscall (to initiate the kexec) to fail.
  *
+ * In addition, the device must meet all of the restrictions imposed by the
+ * core PCI layer documented at :doc:`/PCI/liveupdate`.
+ *
  * Preservation Behavior
  * =====================
  *
@@ -136,23 +139,37 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 	struct vfio_pci_core_device_ser *ser;
 	struct vfio_pci_core_device *vdev;
 	struct pci_dev *pdev;
+	int ret;
 
 	vdev = container_of(device, struct vfio_pci_core_device, vdev);
 	pdev = vdev->pdev;
 
+	ret = pci_liveupdate_preserve(pdev);
+	if (ret)
+		return ret;
+
 	ser = kho_alloc_preserve(sizeof(*ser));
-	if (IS_ERR(ser))
-		return PTR_ERR(ser);
+	if (IS_ERR(ser)) {
+		ret = PTR_ERR(ser);
+		goto err_unpreserve;
+	}
 
 	ser->bdf = pci_dev_id(pdev);
 	ser->domain = pci_domain_nr(pdev->bus);
 
 	args->serialized_data = virt_to_phys(ser);
 	return 0;
+
+err_unpreserve:
+	pci_liveupdate_unpreserve(pdev);
+	return ret;
 }
 
 static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
 {
+	struct vfio_device *device = vfio_device_from_file(args->file);
+
+	pci_liveupdate_unpreserve(to_pci_dev(device->dev));
 	kho_unpreserve_free(phys_to_virt(args->serialized_data));
 }
 
@@ -213,6 +230,10 @@ static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
 	if (!device)
 		return -ENODEV;
 
+	ret = pci_liveupdate_retrieve(to_pci_dev(device->dev));
+	if (ret)
+		goto out;
+
 	file = vfio_device_liveupdate_cdev_open(device);
 	if (IS_ERR(file)) {
 		ret = PTR_ERR(file);
@@ -233,6 +254,9 @@ static bool vfio_pci_liveupdate_can_finish(struct liveupdate_file_op_args *args)
 
 static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *args)
 {
+	struct vfio_device *device = vfio_device_from_file(args->file);
+
+	pci_liveupdate_finish(to_pci_dev(device->dev));
 	kho_restore_free(phys_to_virt(args->serialized_data));
 }
 
@@ -257,13 +281,23 @@ int __init vfio_pci_liveupdate_init(void)
 	int ret;
 
 	ret = liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
-	if (ret && ret != -EOPNOTSUPP)
-		return ret;
+	if (ret)
+		goto err_return;
+
+	ret = pci_liveupdate_register_flb(&vfio_pci_liveupdate_fh);
+	if (ret)
+		goto err_unregister;
 
 	return 0;
+
+err_unregister:
+	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
+err_return:
+	return (ret == -EOPNOTSUPP) ? 0 : ret;
 }
 
 void vfio_pci_liveupdate_cleanup(void)
 {
-       liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
+	pci_liveupdate_unregister_flb(&vfio_pci_liveupdate_fh);
+	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
 }
-- 
2.53.0.983.g0bb29b3bc5-goog


