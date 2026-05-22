Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAFDCD5BB6
	for <kexec@archiver.kernel.org>; Fri, 22 May 2026 20:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n5gRktteoUb/1GJUOFc5t/RbM6I0eXe+lj3sebUBczU=; b=M4yb1Vn7KcRCBji11LUlLQGofZ
	Rlanxtf/G+TQlJ/UASYsz+HGW3xWQIIhcuv3Clyu8qTeBfZ8WXvugky6AbLn9lAK1jlq9Frj52CgC
	cE8C9G91yOAgu9OC5hUC5GtcN4CyoEjCRshzuSlyJsOfNeRDASfz0mD5hCp8vY4M+wT/5ROHTrsSU
	I6Xmll+IYvYlqGNROvsgPRa+qybhuITmMAm0Hrl92nqoMlnVxCpOsV3cWdCqhNS/jViW4HA6Q/ceP
	VTQunFbcMm/882FhkW6t254hkK1hiivxdll0IptUITz8u9mPeqL+n5685h8QEMYVpcn5HiUra2LTL
	a8y0sBhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQWPy-0000000Bs0w-35ij;
	Fri, 22 May 2026 20:24:26 +0000
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQWPu-0000000BruB-398G
	for kexec@lists.infradead.org;
	Fri, 22 May 2026 20:24:24 +0000
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-368b68a33adso11253636a91.1
        for <kexec@lists.infradead.org>; Fri, 22 May 2026 13:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779481461; x=1780086261; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n5gRktteoUb/1GJUOFc5t/RbM6I0eXe+lj3sebUBczU=;
        b=BAZVg1VgYDMWPG4w753H0FsTAlDsxx33lVDj6JzoEGADTPBa8me620LF5RkwPDdqAm
         XSq2kIyxjMyeZ0tv3fLCBzRETNJGk5+URV/CIxtMVN/a23INJqaHQZwK0OtxhwcuLWCy
         hd2wiH6DnaLaZnyg9Ec7bTCWyayfy+18iq/Y+GHwiB2cGUAD5hCP+3rpsHoUSVgmEOYu
         7D0gQBqqWhfdIgtIbqj4c9a7h1oA0C8H+lxWli0mjxF2SU+rheCJkMVeFnScm01pGRZ5
         NSmll71OddGoe5c1wgnGXwJ8C5a8BF/Avir708Ojs7A9DJXzu2moIU97eW95Ao1AzrPk
         nXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779481461; x=1780086261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5gRktteoUb/1GJUOFc5t/RbM6I0eXe+lj3sebUBczU=;
        b=AkWBrk+rJ+y3nw1wUB/jWbdaCWeJnwbshS4b8SwuLN99dSJ2xLRh3iH2nFcIuyYtm+
         BXFTSZG8LSEYjRJDiclMzsMIJI/+cIW+PM1yCZ/TJA5kaeKf9jMk4V2iUgMIhVK5Igjb
         c7FyHfEZM8F1IlqRt87YUJqientADcpKt7YYYnh5RMe00h9rn6fZm3B4obbb5sEbdf3Z
         hmB+JSBWQUn6PqwHfvPT6llcKA31kW4/ZPaNmaFSAZgkswSaUEsgIFdYoAXTH4s0jR3T
         RW5wLxf9qZ+YsquRAyC3RHvVF+aVrRPLxrZWni/tj3lNuzZHREHWTRLfz43lcgCINZHJ
         61Dw==
X-Gm-Message-State: AOJu0Yx5ZNub0O81kqxvXzh0LRDOLAgvHfSdPp4Y8TwgezFaa3Sa8Vn+
	bPUXwjAoPyV6r9AnKNwfhRkXt6firb5DJYAn4fKKFQYSDaEkQI1rg6cuQHCaqnwlH1aSMX0Hhpe
	5vrzHNxtFpYo3raGc2Rb3TRRhhNpYuuRylVbpyFPc0UfO7k/aNVVjZJbJzf4zhue3qttHfMzw3P
	gHNTgjSM0s7ayPX1Y5NZsHknzwah/GRzM9tFmqKP/Ay7HQA60Q6VU=
X-Received: from pjbtc4.prod.google.com ([2002:a17:90b:5404:b0:36a:81c9:4523])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3ecc:b0:369:d7c6:450a with SMTP id 98e67ed59e1d1-36a671e974emr5405438a91.0.1779481460825;
 Fri, 22 May 2026 13:24:20 -0700 (PDT)
Date: Fri, 22 May 2026 20:24:08 +0000
In-Reply-To: <20260522202410.3104264-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260522202410.3104264-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522202410.3104264-11-dmatlack@google.com>
Subject: [PATCH v6 10/12] PCI: liveupdate: Freeze preservation status during shutdown
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
X-CRM114-CacheID: sfid-20260522_132422_807086_6CB98AC4 
X-CRM114-Status: GOOD (  15.05  )
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

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c       | 16 ++++++++++++++++
 drivers/pci/liveupdate.h       |  5 +++++
 drivers/pci/pci-driver.c       |  2 ++
 include/linux/pci_liveupdate.h |  3 +++
 4 files changed, 26 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 701276ef6cfb..d404e64a4e55 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -297,6 +297,11 @@ static int pci_liveupdate_unpreserve_device(struct pci_ser *ser, struct pci_dev
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
@@ -380,6 +385,11 @@ static int __pci_liveupdate_preserve_device(struct pci_ser *ser, struct pci_dev
 
 static int pci_liveupdate_preserve_device(struct pci_ser *ser, struct pci_dev *dev)
 {
+	if (dev->liveupdate.frozen) {
+		pci_warn(dev, "Cannot preserve device after it is frozen!\n");
+		return -EINVAL;
+	}
+
 	if (dev->liveupdate.outgoing)
 		return pci_liveupdate_preserve_device_again(dev);
 
@@ -653,6 +663,12 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 	}
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
index 6f21ec50927b..bcb0bc73d684 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -13,6 +13,7 @@
 #ifdef CONFIG_PCI_LIVEUPDATE
 void pci_liveupdate_setup_device(struct pci_dev *dev);
 void pci_liveupdate_cleanup_device(struct pci_dev *dev);
+void pci_liveupdate_freeze(struct pci_dev *dev);
 bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus, struct pci_dev *dev,
 				      int pass);
 void pci_liveupdate_scan_bridge_end(struct pci_dev *dev, int pass);
@@ -28,6 +29,10 @@ static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 {
 }
 
+static inline void pci_liveupdate_freeze(struct pci_dev *dev)
+{
+}
+
 static inline bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus,
 						    struct pci_dev *dev,
 						    int pass)
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index d10ece0889f0..f7a5e65a7c75 100644
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
index 2446c6d237ca..150993405754 100644
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
 	bool inherit_buses;
 	bool was_preserved;
+	bool frozen;
 };
 
 struct pci_dev;
-- 
2.54.0.746.g67dd491aae-goog


