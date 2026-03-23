Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFE1F532C1
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 23:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WDvzsZ/wW7otbfhEhu+LWvOHypwI+AXZcNsT2i6QVdU=; b=zatmiRnL7HgN/akrOMf4cp7JlI
	7fEyzBYU00Ba1ymwtGaU1MiI4rPyKYjlE4CcB0gxLcSndiT4oks0Ts0iEmKs+PGz9Ds5yEJamLUiD
	sUtLEixERg9X3QiiFcRUctmifajnuUfYLKr70DComwd2kX5ut/yjubtjx+ULzGXWb+IAKP64VK5Vs
	zZcvMEkAMlhFDRltVO2yHAoXmD1TqIzsND9gIM3VzZrLKFItLr+AL/ZJ+utF8OVZJ9QHeQEYIUG/e
	FAQK4/vtCTkfNv5F/Qxd76x+OL7Hufjz/f0WDIkNwpIgTZBvl6uNOHmLXDzBsjqkq2D6CemNUNKPs
	bmIUkXMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAp-00000000Bh3-1KSu;
	Mon, 23 Mar 2026 23:59:07 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAn-00000000Bdg-17ZV
	for kexec@bombadil.infradead.org;
	Mon, 23 Mar 2026 23:59:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WDvzsZ/wW7otbfhEhu+LWvOHypwI+AXZcNsT2i6QVdU=; b=ktnMmefYMuPsWhCM/kaVXyASK8
	qkK+bOOe95TowN4zpTH+m2gfUFLfXCXbIUvbAvS74b/8F4XC8dYlMYtkchmh/ADgKIBcDRHNOrx8H
	kLxuoZmSDNGM+7oOMzreL/8zGt9QepnjraAKGYjIgbS8W90fKKs/Xs98mk4QafWbd7+f4dZ6jvWQX
	rEpcjhrTZ1ya9Us5LnBs2Nc9k/6RGiMTsb66eQh1XxSUqyfIfxhn3YOoRAPeTj01iguFXELjrUBwE
	VtNNU03oYNvlr+h4wYx2+0O5qt/aqHaGAid/19GAAZ2LkeTQmHY8g3EtlHMb4lGhIshaYy/NOg5lf
	RBh3C8uA==;
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by casper.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAj-0000000D4yx-3HJl
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 23:59:04 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2b0565d77a6so10203135ad.2
        for <kexec@lists.infradead.org>; Mon, 23 Mar 2026 16:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310339; x=1774915139; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WDvzsZ/wW7otbfhEhu+LWvOHypwI+AXZcNsT2i6QVdU=;
        b=owVs4yK5X1ObBR560CcR/j7+QFwf7OdKiccm9ngowSmwtcepszVJfTAnI60VIGOmwW
         4TmXhJeCjYkpUpUGG+6wlww1t7wUuvAgrS+NGIDmx7vsbDujXxs7F6g2TlbpW9FZe1OD
         2PdIrekyJiZZmZ+xDxvJZCvFPOfTo1C0uV115wXNnYiDu4WOW2GLIeaCjE1bQ+lSMjxV
         LQpN9+Spqa9jsW4DR5PE2nX2v66/bufs/gBIqjU3mnjgHHEJlwzyqJ4nK84UwVGzjQSP
         Aph4fGGtaknqGPVexwFDqwN4r6qkCh9Foye4xBS0RNczJw6MwSIQ+vLNkOchED6cW3cX
         CoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310339; x=1774915139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDvzsZ/wW7otbfhEhu+LWvOHypwI+AXZcNsT2i6QVdU=;
        b=C98Q5R4vvx4kdGaLKUUrSPNE05KSHouFsAWWmPYMuj4fM4IjhartQA5+lbOUEbtYEd
         R756K27vRI6ImdKWM7PLc5W/Skhm/CFgrb2mqMQU/qBlCQGXGVqn/NlCh+AmRyfpHhLa
         ZNRjfJxKFw6mE9V6K3b8DsXGFmrSoVXkWxX5lTLKdR1TbhCwT2bKlKPX0QRFuC7UBrGC
         IiXqArx7Woj8wfKt6pHZp4E3+H2poS1zqzEJAiaZTUO+bmR11k6NlfYvyX1NtV1lKaxb
         EB2zRBqNniob9DakgNQlp1X4wRBkNNHW4QPfugPJSo/PFt9BH2IYHcyDEY44U4FAa+Ti
         TxGg==
X-Forwarded-Encrypted: i=1; AJvYcCWXSDgzmAtPXzkqFR2C3li9fwmn61wHfCCgLbRFdRCc6tlhFIygEk/f94adkWk6bn1ofBdVPg==@lists.infradead.org
X-Gm-Message-State: AOJu0YysmvttYUmK4hWAOKJPllPeJrOHuT5eq58TazbPpftQWuZ6DWfN
	TOfTYuaxL0wLr5vckvgI1yDrthx87D5a5Z3TcSBSBr8GgSQYHttAKjS7MCHfui/ULOtlU1QA7aZ
	mY427LKypyw1mDA==
X-Received: from pldt15.prod.google.com ([2002:a17:903:40cf:b0:2b0:59ce:931b])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1c7:b0:2b0:5fa5:a68c with SMTP id d9443c01a7336-2b0826b9030mr140489925ad.9.1774310338569;
 Mon, 23 Mar 2026 16:58:58 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:58:04 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-13-dmatlack@google.com>
Subject: [PATCH v3 12/24] vfio/pci: Skip reset of preserved device after Live Update
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
X-CRM114-CacheID: sfid-20260323_235901_864146_57AE8833 
X-CRM114-Status: GOOD (  22.27  )
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

Do not reset the device when a Live Update preserved vfio-pci device is
retrieved and first enabled. vfio_pci_liveupdate_freeze() guarantees the
device is reset prior to Live Update, so there's no reason to reset it
again after Live Update.

Since VFIO normally uses the initial reset to detect if the device
supports function resets, pass that from the previous kernel via
struct vfio_pci_core_dev_ser.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c       | 31 ++++++++++++++++++++++----
 drivers/vfio/pci/vfio_pci_liveupdate.c |  4 ++++
 include/linux/kho/abi/vfio_pci.h       |  4 +++-
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index d7c472cf4729..849a3b57d56b 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -16,6 +16,7 @@
 #include <linux/file.h>
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
+#include <linux/kho/abi/vfio_pci.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
@@ -494,6 +495,30 @@ static const struct dev_pm_ops vfio_pci_core_pm_ops = {
 			   NULL)
 };
 
+static int vfio_pci_core_probe_reset(struct vfio_pci_core_device *vdev)
+{
+	int ret;
+
+	/*
+	 * This device was preserved by the previous kernel across a Live
+	 * Update, so it does not need to be reset and reset_works can be
+	 * inherited from the previous kernel.
+	 */
+	if (vdev->liveupdate_incoming_state) {
+		vdev->reset_works = vdev->liveupdate_incoming_state->reset_works;
+		return 0;
+	}
+
+	ret = pci_try_reset_function(vdev->pdev);
+
+	/* Bail if the device lock cannot be acquired. */
+	if (ret == -EAGAIN)
+		return ret;
+
+	vdev->reset_works = !ret;
+	return 0;
+}
+
 int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
@@ -514,12 +539,10 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (ret)
 		goto out_power;
 
-	/* If reset fails because of the device lock, fail this path entirely */
-	ret = pci_try_reset_function(pdev);
-	if (ret == -EAGAIN)
+	ret = vfio_pci_core_probe_reset(vdev);
+	if (ret)
 		goto out_disable_device;
 
-	vdev->reset_works = !ret;
 	pci_save_state(pdev);
 	vdev->pci_saved_state = pci_store_saved_state(pdev);
 	if (!vdev->pci_saved_state)
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 8d6681e1d328..874c821bf6eb 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -91,6 +91,9 @@
  *    kernel guarantees the these will not change across a kexec when a device
  *    is preserved.
  *
+ *  * Whether or not the device supports function resets. This is necessary to
+ *    avoid resetting the device after kexec to probe for reset support.
+ *
  * Since the kernel is not yet prepared to preserve all parts of the device and
  * its dependencies (such as DMA mappings), VFIO currently resets and restores
  * preserved devices back into an idle state during kexec, before handing off
@@ -162,6 +165,7 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 
 	ser->bdf = pci_dev_id(pdev);
 	ser->domain = pci_domain_nr(pdev->bus);
+	ser->reset_works = vdev->reset_works;
 
 	args->serialized_data = virt_to_phys(ser);
 	return 0;
diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
index 876aaf81dd92..c057794a044f 100644
--- a/include/linux/kho/abi/vfio_pci.h
+++ b/include/linux/kho/abi/vfio_pci.h
@@ -26,7 +26,7 @@
  * incrementing the version number in the VFIO_PCI_LUO_FH_COMPATIBLE string.
  */
 
-#define VFIO_PCI_LUO_FH_COMPATIBLE "vfio-pci-v1"
+#define VFIO_PCI_LUO_FH_COMPATIBLE "vfio-pci-v2"
 
 /**
  * struct vfio_pci_core_device_ser - Serialized state of a single VFIO PCI
@@ -34,10 +34,12 @@
  *
  * @domain: The device's PCI domain number (segment).
  * @bdf: The device's PCI bus, device, and function number.
+ * @reset_works: Non-zero if the device supports function resets.
  */
 struct vfio_pci_core_device_ser {
 	u32 domain;
 	u16 bdf;
+	u8 reset_works;
 } __packed;
 
 #endif /* _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H */
-- 
2.53.0.983.g0bb29b3bc5-goog


