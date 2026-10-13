Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC669CC6B1E
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 16:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7MskRkxPSFzbqMyyuEL+532dIkv44I1UDvOc3a8yN8g=; b=IqeXzypPSHLeE1G+5Z7DCoFRGE
	ex/xfRVLX4hY6DTfrNESpqqBLiBEBUWOV02dzUSEhw/TsTxl+RkXW8u33l5f6jw+D4z4NTx3NtWzv
	EKtgM4j5Ll6IYd1pexIrlT37n64xS0h6IvlrvpM0BOE8TX/8d5jwANRq+6XgYOBT3LGszWEyvUOmM
	7Ltd754pz2t1MJLYA3c9pJc9gL7H4LbehldolM6LxaxSfSSeyMPViSKnZIcwtc7Gj8GtDlObU6iMj
	U2qqsXQg1ZBRC89pO1/EK2CnOUSQ3WusLG4LH5lbG+MucvJa4cvWu8ow53/050GSJBpSLhiFWfBm7
	ep9NtU5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfKI-0000000DUwb-283B;
	Tue, 13 Oct 2026 16:26:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfK6-0000000DUoY-1fcu
	for kexec@bombadil.infradead.org;
	Tue, 13 Oct 2026 16:26:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7MskRkxPSFzbqMyyuEL+532dIkv44I1UDvOc3a8yN8g=; b=gK5f7trLwFwHITUIHMLXhbDIYS
	U4cw6S6HJyPEN9kuXaFvyxB59nkDOFf0suxvMZuE/zreiGE3wSuxDM5Op1oI44QQk+g5rR2+qMFKO
	DCpet3iknZ1hyLP8Sz7USYeNsFJTXbTE+xOYu5x+IaBekjrP7nU5yOH4jsRrxfdL6KM1za6bT+n7d
	Ds1BQR3xnzWgXwLaF06pHlxoII/6FtYgrhi8XrpAVVloRn+3jVLsPUjajbiAq3h6Ybax8rMrQRItN
	mQ1ZUTvP6ODD3ZN2TQtMIFtZE/9yQqGGPzraW0yMqVSK2htKYI8fL40cAQ4K4hkjZ0pl/sXd0qtV2
	q3IOPVRw==;
Received: from mail-pl1-x646.google.com ([2607:f8b0:4864:20::646])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGfK2-0000000FmM7-3nSV
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 16:25:53 +0000
Received: by mail-pl1-x646.google.com with SMTP id d9443c01a7336-2cec4226c70so39841045ad.1
        for <kexec@lists.infradead.org>; Tue, 13 Oct 2026 09:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791908749; x=1792513549; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7MskRkxPSFzbqMyyuEL+532dIkv44I1UDvOc3a8yN8g=;
        b=uc/Jtz/P89ONP+Oqjo0MH6nG2FboXaPVP4K5eGPhtu61Mj5z93dybmWMaY5TI71piI
         WI6Q88ydIHeBBo+tioYEfLqRNEbZf8HN+v7/y8yK8Iu/gBiNtNcJIt5cm/Zj2LGM/hu6
         1syHEbzcSrbYoYgrZG50fZAPUsawIW/wgJ1FB6yBPCMleGYwGexIe5jGrSi87Oi/QVyT
         dQiUjC/zOo0/votkLdexqd8tAPptkSYC1gFJI2TnxRGSM6atSJX/DSoK+HSPc2FUzb5e
         XMRzqzh7n9qtluAMHkJri9VIkfnWygaOhPTfPPb3t4jw7b3IAZjPOsH5TZQV4sMI8D+Z
         1uXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791908749; x=1792513549;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7MskRkxPSFzbqMyyuEL+532dIkv44I1UDvOc3a8yN8g=;
        b=Q6zLS0yDMXdvrkaTf6ixUeIf1HQdX3bGQiSJ3uMhia2fs6BBaYwtXZa/SDuJXvMYfp
         TnnDVfXGCdTtgvtniOAwmtJchW9vKLkAKNCo4HhLuGXU6Mz5ksSVoc1kmeUoRedo43Wi
         75mAvIfSzQIf9SImmWdSfUvGID04F3WGWha/UorA2Dy+dGoIv1eVctmsHJ4lsv80ovLP
         xsg4ZHOW2ZGv4Tc9LlGqAPDiOaTu2hyCBEq0LbgRe8gWpAfdCDvRKnkqe2owGjvMt0Qb
         4uNTO1ngZHexVxUJvCA69jnEHxr4UMkvLyqjQMZRTQ3XixXVqkekXiB1sP+wsQWpeBKQ
         oeYA==
X-Gm-Message-State: AFq9FYL9OXJUNkUP16C26m2/H3yg9fr6J3SzFAX9tSc7c9PqICbsgjQe
	82n+NzGCCcbjlPaFPbP/N3D+szQA4Rze/TgTC2I+zjsZUzPQ30g3anNrBXAG1gBZ5ojXvXPub+d
	BVvKQSL6tkeSFyJeaa8jAwjcd3PAShPNmxFxy2W1gBtUE5GVn03Z6tpdA1Wf9fACSXZHL7f8n9w
	/PTHMFIE201VuCxn3mbvWNcroPY85JeLU9Eg8y0Q5uvSnESQ8SjRI=
X-Received: from plbjk21.prod.google.com ([2002:a17:903:3315:b0:2e3:1af5:b57b])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:fc4f:b0:2dd:c0ff:e726 with SMTP id d9443c01a7336-2e842dff5damr107249425ad.56.1791908748449;
 Tue, 13 Oct 2026 09:25:48 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:25:27 +0000
In-Reply-To: <20261013162529.1928093-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20261013162529.1928093-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013162529.1928093-12-dmatlack@google.com>
Subject: [PATCH v10 11/13] PCI: liveupdate: Freeze preservation status during shutdown
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
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_172551_085209_BCF85602 
X-CRM114-Status: GOOD (  15.58  )
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
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c       | 16 ++++++++++++++++
 drivers/pci/liveupdate.h       |  5 +++++
 drivers/pci/pci-driver.c       |  2 ++
 include/linux/pci_liveupdate.h |  3 +++
 4 files changed, 26 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index e640794cc8e6..38b7815fe7d4 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -499,6 +499,11 @@ static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
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
@@ -565,6 +570,11 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
 		return -EINVAL;
 	}
 
+	if (dev->liveupdate.frozen) {
+		pci_warn(dev, "Cannot preserve device after it is frozen!\n");
+		return -EINVAL;
+	}
+
 	if (!dev->liveupdate.outgoing) {
 		struct pci_dev_ser *dev_ser;
 
@@ -815,6 +825,12 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 		pci_WARN(dev, 1, "Destroying incoming-preserved device!\n");
 }
 
+void pci_liveupdate_freeze(struct pci_dev *dev)
+{
+	guard(rwsem_write)(&pci_liveupdate.rwsem);
+	dev->liveupdate.frozen = true;
+}
+
 static int pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *dev)
 {
 	if (!dev->liveupdate.incoming) {
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index 90b2754ecc0c..5aac19f7bee6 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -13,6 +13,7 @@
 #ifdef CONFIG_PCI_LIVEUPDATE
 void pci_liveupdate_setup_device(struct pci_dev *dev);
 void pci_liveupdate_cleanup_device(struct pci_dev *dev);
+void pci_liveupdate_freeze(struct pci_dev *dev);
 bool pci_liveupdate_preserve_bus_numbers(void);
 bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus, struct pci_dev *dev);
 int pci_liveupdate_adopt_acs(struct pci_dev *dev);
@@ -26,6 +27,10 @@ static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 {
 }
 
+static inline void pci_liveupdate_freeze(struct pci_dev *dev)
+{
+}
+
 static inline bool pci_liveupdate_preserve_bus_numbers(void)
 {
 	return false;
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e16aa59dd7ac..dff60a03204f 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -21,6 +21,7 @@
 #include <linux/acpi.h>
 #include <linux/dma-map-ops.h>
 #include <linux/iommu.h>
+#include "liveupdate.h"
 #include "pci.h"
 #include "pcie/portdrv.h"
 
@@ -559,6 +560,7 @@ static void pci_device_shutdown(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = pci_dev->driver;
 
+	pci_liveupdate_freeze(pci_dev);
 	pm_runtime_resume(dev);
 
 	if (drv && drv->shutdown)
diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
index d45a5b524909..bb79348769b7 100644
--- a/include/linux/pci_liveupdate.h
+++ b/include/linux/pci_liveupdate.h
@@ -21,11 +21,14 @@
  *                set up, i.e. it was matched to state preserved by the previous
  *                kernel. Unlike @incoming, this is never cleared, so it stays
  *                true after the device finishes participating in Live Update.
+ * @frozen: True if the outgoing preservation status of this device is frozen
+ *          and thus cannot be changed.
  */
 struct pci_liveupdate {
 	struct pci_dev_ser *outgoing;
 	struct pci_dev_ser *incoming;
 	bool was_incoming;
+	bool frozen;
 };
 
 struct pci_dev;
-- 
2.56.0.385.gd3acb90ef8-goog


