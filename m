Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFBFD73E87
	for <kexec@archiver.kernel.org>; Thu, 29 Jan 2026 21:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ha2krivTi79qOGY9TNrpoF2Kn7NOugjkcaAbsESD6eI=; b=ETdS/axFEHewO4+kkTj9Pvtr5m
	38I4b6mBJaxk1db8r1YVMjrR+ywhwTTOUPaJxLxAM3fwxEflOwTHYnhszhBrPGusnZ/HDT4Gq4GCk
	s+4AEOg09SIssBEC/52Uj3+036QOZf9bznWEawfaHdvqm9ar37x+dQXADnY+grkc8XrQO8X8P/0UH
	ZkBF+VOrzM5CWvUAf91xOTji8g73tsGMwrL0ktsbqA+ThfjHO+Ngusw4sJnZ6yejVPeCZl+OFlHfg
	iWlsfDi7lxQk079EgusZWmJ07EXCp5fvnxYDfXBz1/uQu5YS+dYG4CSUkRLf9QQ5vsgofBnfWO+2c
	TajEOLUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWd-00000000fRt-3riU;
	Thu, 29 Jan 2026 21:26:03 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWX-00000000fJI-3zXb
	for kexec@lists.infradead.org;
	Thu, 29 Jan 2026 21:26:01 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2a773db3803so16090725ad.1
        for <kexec@lists.infradead.org>; Thu, 29 Jan 2026 13:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769721954; x=1770326754; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha2krivTi79qOGY9TNrpoF2Kn7NOugjkcaAbsESD6eI=;
        b=iFRPt8rDdg7SL8wvE3PDfEowkn2V9XBhd3ASDHBf+EsnNI+85zzeRyN7sYPCFt3TZG
         tV7AxBbPd94aBieKsoOE/gUADmN1l9LS7xfYQK0j69O+v3x/Z3DYtNf0JOgwJ9pDqXyT
         2YhIGj4drFbg3O7IPjcgrRsQObIFK6WHxvOVzWe7n4TLlQCNwrXSNXZMZTQI4/hngDBl
         Fh8XBFCvakS2Tvi3zbrmTKF2rt5R44kmat5ShyGdsoO+Z9IBFU8IP37MBbF15su5qdk1
         p524wUGZwv7u8fcjUoUtIdNteDvjLR276nkarQYBUlEj5Br5pIbU7g4kFAexXnzo6par
         Rr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769721954; x=1770326754;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha2krivTi79qOGY9TNrpoF2Kn7NOugjkcaAbsESD6eI=;
        b=TsBmjzFOSeiU1VBgkiCH1QQ1Y/UuQjdM6dwZJnEv58+tEJrKoltWGQ3qcV6wfGQKVi
         pjbVqnATl3KXSvkWkAa6PqD8q1U/BZytqb/KHt59GRAxgVRE48vFbEvf9ccHlzQRNbT2
         2m6CT1S0/hrjM4jYkEwPXODX4OdDoTCFuc9MMGKUN5t8GVIGmBg9W1T1rZW83KTeZqv1
         bboNlOePvnln7DAI4s7qVLc2UY9/CLHvogLwHhOYOzOc96AW34iQsLNXRIQ4XgJttZxR
         gANuG1ZTgRT4L3MVVgul0aPz1Hn087ZEm0e9B6aq4o8snr7wqKFIWv5c1pFekyl7llAr
         li9g==
X-Forwarded-Encrypted: i=1; AJvYcCWgpQsqhIS9eYPyp7Fpb8dYO7s8eYdLQI4fn4l7oNXK8qdVN2G4QH/wRD+2BK8CNwt0OtmiHg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyAdH1hYHaHCPNj5kl79KIyy1hKLMj3jWTgBtf8Xys14bFYi6nH
	jpBKZq7bzZk0VXyDPPqEqXWB06UNleKyyhsbCqF+6fD1imMJsAsUCR/BG0AwJrejn2tvV79U38R
	5I2/t3b4v4ZP3aQ==
X-Received: from plba14.prod.google.com ([2002:a17:903:100e:b0:29f:1fb1:be7e])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d4c9:b0:2a7:99c9:1086 with SMTP id d9443c01a7336-2a8d9a56c95mr4558805ad.47.1769721953965;
 Thu, 29 Jan 2026 13:25:53 -0800 (PST)
Date: Thu, 29 Jan 2026 21:24:57 +0000
In-Reply-To: <20260129212510.967611-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129212510.967611-11-dmatlack@google.com>
Subject: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after Live Update
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
X-CRM114-CacheID: sfid-20260129_132558_045591_B23ACB17 
X-CRM114-Status: GOOD (  18.55  )
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
 drivers/vfio/pci/vfio_pci_core.c       | 22 +++++++++++++++++-----
 drivers/vfio/pci/vfio_pci_liveupdate.c |  1 +
 include/linux/kho/abi/vfio_pci.h       |  2 ++
 include/linux/vfio_pci_core.h          |  1 +
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index b01b94d81e28..c9f73f597797 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -515,12 +515,24 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (ret)
 		goto out_power;
 
-	/* If reset fails because of the device lock, fail this path entirely */
-	ret = pci_try_reset_function(pdev);
-	if (ret == -EAGAIN)
-		goto out_disable_device;
+	if (vdev->liveupdate_incoming_state) {
+		/*
+		 * This device was preserved by the previous kernel across a
+		 * Live Update, so it does not need to be reset.
+		 */
+		vdev->reset_works = vdev->liveupdate_incoming_state->reset_works;
+	} else {
+		/*
+		 * If reset fails because of the device lock, fail this path
+		 * entirely.
+		 */
+		ret = pci_try_reset_function(pdev);
+		if (ret == -EAGAIN)
+			goto out_disable_device;
+
+		vdev->reset_works = !ret;
+	}
 
-	vdev->reset_works = !ret;
 	pci_save_state(pdev);
 	vdev->pci_saved_state = pci_store_saved_state(pdev);
 	if (!vdev->pci_saved_state)
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 1ad7379c70c4..c52d6bdb455f 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -57,6 +57,7 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 
 	ser->bdf = pci_dev_id(pdev);
 	ser->domain = pci_domain_nr(pdev->bus);
+	ser->reset_works = vdev->reset_works;
 
 	args->serialized_data = virt_to_phys(ser);
 	return 0;
diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
index 9bf58a2f3820..6c3d3c6dfc09 100644
--- a/include/linux/kho/abi/vfio_pci.h
+++ b/include/linux/kho/abi/vfio_pci.h
@@ -34,10 +34,12 @@
  *
  * @bdf: The device's PCI bus, device, and function number.
  * @domain: The device's PCI domain number (segment).
+ * @reset_works: Non-zero if the device supports function resets.
  */
 struct vfio_pci_core_device_ser {
 	u16 bdf;
 	u16 domain;
+	u8 reset_works;
 } __packed;
 
 #endif /* _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H */
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 350c30f84a13..95835298e29e 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 #include <linux/uuid.h>
 #include <linux/notifier.h>
+#include <linux/kho/abi/vfio_pci.h>
 
 #ifndef VFIO_PCI_CORE_H
 #define VFIO_PCI_CORE_H
-- 
2.53.0.rc1.225.gd81095ad13-goog


