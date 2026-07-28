Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56747C54F51
	for <kexec@archiver.kernel.org>; Tue, 28 Jul 2026 22:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b5W2sBTENi+WOUrZGfaki9B1D/ksXXAJzGZ/5VFVBZM=; b=kNCrulLj/7KC0g/V2EM2C3eueN
	ko+4ocQwro70nBp26gzNMp9OtHYqjw8knw4gBGIn0ToKOj0164K4ZGia789a5ZSXslDxdbI3J6M5U
	UIcYwmJLvqaWjvP0n+f8d+JfqyNkkAt3IswNci9fxEA7IMfxHFYZ7CkV0sNVdBi/LdxUhgAIUXj2o
	eVSiruziAExFZ9LsUvN7vh+3J/wZTnoMsjju3xM2o78arDjhy+b42bpWsAAs8LbBcpZLjq1keeL9+
	baNIkhRtIGXfga4jwr48yZ42Es6ddF/sAmk8gO1SgNR/EtSD5I0svUDXLZaMpq8v6yTjqK7Q1i53o
	j8IuKdZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woq0S-00000006Nzg-0odq;
	Tue, 28 Jul 2026 22:10:36 +0000
Received: from mail-pj1-x1047.google.com ([2607:f8b0:4864:20::1047])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woq0N-00000006Ntb-1I8A
	for kexec@lists.infradead.org;
	Tue, 28 Jul 2026 22:10:33 +0000
Received: by mail-pj1-x1047.google.com with SMTP id 98e67ed59e1d1-38dd87656d3so328191a91.2
        for <kexec@lists.infradead.org>; Tue, 28 Jul 2026 15:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785276630; x=1785881430; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b5W2sBTENi+WOUrZGfaki9B1D/ksXXAJzGZ/5VFVBZM=;
        b=uYiaBbFWYM73QV7LCfprK6U4Z2/MQCZ7C9HCP9lrbZwB6Dg5HCZRuG+QZ22P0pe4Bq
         5FRfiWP8og2ZneR2ZUuxUC2wjt5hQbdwC1sns7/FcxQk5pznKV1V7j5DxFnUj9ffuHpi
         PdywvwXSm+Vk8BHHkgMLwdhXsu1Owp3jnFzSGwUfZTAXczk8pgK6tzHcGPWBs4PpIERe
         4Q0D+7Xx8rdR2M+8x5huNbLkd0xp4F7U0NqYY6PlD940sjVvUJUq2e97xvdgicgzgKQe
         Gt1rBn4+xIwIrAlP8p/R5KKFkWjvAzW5w+qCZCVBUuHAXKNQz76ogZE/a29FDDJMIgVQ
         7ttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785276630; x=1785881430;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b5W2sBTENi+WOUrZGfaki9B1D/ksXXAJzGZ/5VFVBZM=;
        b=CBKBuZD3qXvJyHQHNWxUFrrg4le2/1u63f4NjTz7WB/nwcuCSn8MIIrGF8yP33NIgA
         RJhohJeRduJ+sDnIMLDC5VnDoj6fH5h+CtJKQcIkLEOL8BP5Z5Oqpvmgmj/adb4sr8kl
         QM/CzwAFT35n+Xbk+Lcgf6gkAUyW4IjIgqSEFUNzBLo6pRS0GoVvqQaVcpSdYZiqHzAr
         IXVcgFerqGpu1QzaqZjHFSkkfLpLQ4m4oeZI77CzvB6YvyugNfCE0hF5KuyP7FAT6VRE
         YufzK3v1FlPcnoecPHSRCCbTfcqbbtYeDsqnWsLQncLrTqoi4qouf3ocwp2LAIOeCpic
         9BoQ==
X-Gm-Message-State: AOJu0YyXbho6hKGrigMBI6kzNM7UQ1yCjKFItE4t7OYz7kbmpdjbXeF9
	Z+I1P1SrgIs9RV+LdKccwcwKSRacQf14C4IqOLY68bYJx3i+WaGhH0k1Z9a/ctb4aHWDDNxOnHv
	Nx00l9lZpC0+QgT6H+YIMu/nDPI8064Rr7BOeywS4iy3iIVm3syU6AoyMfK0i9TwkYP8TJUxAjT
	4WwdFUmzVau8D+e2WMu3ddjXqjqW+VVZHigNk7SocWuVwIuj7KH/Y=
X-Received: from pjqx19.prod.google.com ([2002:a17:90a:b013:b0:384:f6e1:ff81])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2f0b:b0:38e:7f34:b23d with SMTP id 98e67ed59e1d1-38f6a54897fmr4380325a91.35.1785276629379;
 Tue, 28 Jul 2026 15:10:29 -0700 (PDT)
Date: Tue, 28 Jul 2026 22:10:04 +0000
In-Reply-To: <20260728221007.2098560-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260728221007.2098560-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728221007.2098560-11-dmatlack@google.com>
Subject: [PATCH v8 10/12] PCI: liveupdate: Freeze preservation status during shutdown
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_151031_457843_18E90BE1 
X-CRM114-Status: GOOD (  15.61  )
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

Freeze a device's outgoing preservation status (preserved or not
preserved) during shutdown. This enables the PCI core and drivers to
safely make decisions based on the device's preservation status during
shutdown.

Note that pci_liveupdate_freeze() is triggered by the PCI core rather
than from drivers participating in Live Update so that all devices can
have their status frozen (i.e. prevent non-preserved devices from
getting preserved late).

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c       | 16 ++++++++++++++++
 drivers/pci/liveupdate.h       |  4 ++++
 drivers/pci/pci-driver.c       |  2 ++
 include/linux/pci_liveupdate.h |  3 +++
 4 files changed, 25 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 744513ee11ed..65bcecb1b64e 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -394,6 +394,11 @@ static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
 {
 	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
 
+	if (dev->liveupdate.frozen) {
+		pci_warn(dev, "Cannot unpreserve device after it is frozen!\n");
+		return -EINVAL;
+	}
+
 	if (!dev_ser) {
 		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
 		return -EINVAL;
@@ -447,6 +452,11 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
 		return -EINVAL;
 	}
 
+	if (dev->liveupdate.frozen) {
+		pci_warn(dev, "Cannot preserve device after it is frozen!\n");
+		return -EINVAL;
+	}
+
 	if (dev->liveupdate.outgoing) {
 		if (!dev->liveupdate.outgoing->refcount) {
 			pci_WARN(dev, 1, "Preserved device with 0 refcount!\n");
@@ -718,6 +728,12 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 		pci_WARN(dev, 1, "Destroying incoming-preserved device!\n");
 }
 
+void pci_liveupdate_freeze(struct pci_dev *dev)
+{
+	guard(rwsem_write)(&pci_liveupdate.rwsem);
+	dev->liveupdate.frozen = 1;
+}
+
 static int pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *dev)
 {
 	if (!dev->liveupdate.incoming) {
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index ccc23031e99d..49d07fd02132 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -13,6 +13,7 @@
 #ifdef CONFIG_PCI_LIVEUPDATE
 void pci_liveupdate_setup_device(struct pci_dev *dev);
 void pci_liveupdate_cleanup_device(struct pci_dev *dev);
+void pci_liveupdate_freeze(struct pci_dev *dev);
 bool pci_liveupdate_preserve_bus_numbers(struct pci_bus *bus,
 					 struct pci_dev *dev);
 void pci_liveupdate_scan_bridge_end(struct pci_dev *dev);
@@ -28,6 +29,9 @@ static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 {
 }
 
+static inline void pci_liveupdate_freeze(struct pci_dev *dev)
+{
+}
 static inline bool pci_liveupdate_preserve_bus_numbers(struct pci_bus *bus,
 						       struct pci_dev *dev)
 {
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index f36778e62ac1..51616e4327d3 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -21,6 +21,7 @@
 #include <linux/acpi.h>
 #include <linux/dma-map-ops.h>
 #include <linux/iommu.h>
+#include "liveupdate.h"
 #include "pci.h"
 #include "pcie/portdrv.h"
 
@@ -536,6 +537,7 @@ static void pci_device_shutdown(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = pci_dev->driver;
 
+	pci_liveupdate_freeze(pci_dev);
 	pm_runtime_resume(dev);
 
 	if (drv && drv->shutdown)
diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
index 04a2b2a3102a..31898685a406 100644
--- a/include/linux/pci_liveupdate.h
+++ b/include/linux/pci_liveupdate.h
@@ -24,6 +24,8 @@
  * @was_preserved: True if this struct pci_dev was preserved by the previous
  *                 kernel. Unlike @incoming, this field is not cleared after
  *                 the device is finished participating in Live Update.
+ * @frozen: True if the outgoing preservation status of this device is frozen
+ *          and thus cannot be changed.
  */
 struct pci_liveupdate {
 	struct pci_dev_ser *outgoing;
@@ -31,6 +33,7 @@ struct pci_liveupdate {
 	u16 acs_ctrl;
 	bool preserve_bus_numbers;
 	bool was_preserved;
+	bool frozen;
 };
 
 struct pci_dev;
-- 
2.55.0.487.gaf234c4eb3-goog


