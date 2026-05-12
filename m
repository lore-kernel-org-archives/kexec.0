Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0430ECD4F3F
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 18:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+T00aeBm2op37uqoieTnlwhq01i0C6V7dLZN2p+Z22k=; b=0O91ViPqlehSoeK27q4u9oPxjw
	QzTRYrY2qqd7vEfiN3rnrIdKcqXbC6PwWeE/+o7u6rlXXEzqGZbpxQBHfusEnAefb5Cq5aFxhPMi9
	YKXkxv96zVpdWg1RM/Cb5CkHbGcXNmdkQ0iRsEYSlPUxL5JEmAvQKRYQrmEQHr7zB4oByq1INzWHW
	XvS59GFFVDAfYvA5EMdngoEVBzI2Rc1kIxp3GDlcvwqWTFfdqre8H/OiNoxy0gXcNUd+i5um9W2Gj
	BZiCxQKHUppa9RXXtlJ1DTVwQTtB7d9+T9fM1ssRR1egVVfjGWSu58bDZeeijwRZIa5my0rsxvYWZ
	WeQEgL6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMsAA-000000008kW-3ejo;
	Tue, 12 May 2026 18:49:02 +0000
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMsA8-000000008go-2bfm
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 18:49:01 +0000
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-c82751074c8so4191915a12.0
        for <kexec@lists.infradead.org>; Tue, 12 May 2026 11:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778611739; x=1779216539; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+T00aeBm2op37uqoieTnlwhq01i0C6V7dLZN2p+Z22k=;
        b=sFrXmzlrx9x9aoe0WRNZ5UHdRBdYyorCHFyfB0tJ3N1RdldUaILsZICE/ylwtMQtOV
         Ln9QWsPpNo0SmY6jRuTlkuIZh4HjCPQgEEzgN8uitjRtPa0m26UpjVp8elVilZejLYuy
         piB+FaxAVXIV2E8mgyf5d/pRjx0Np2JSopnXdrHxHUpSVj187u5qOJKgNmZBph2BItPS
         ryVt+lZIZV2vZ+bCdwUF1yfjeNsuK089gg72OAkn8NlROxtlNrjiEC5B+6aPN5Hfjlrz
         opRWne8R1HF3CBNji952GdOAm3U9K2pAnYtf9MvFG+ziITmotXoOZDKy69oaqFPmy2Ht
         JmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778611739; x=1779216539;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+T00aeBm2op37uqoieTnlwhq01i0C6V7dLZN2p+Z22k=;
        b=P82cyFQobTyCAC9Nt5IRitnwBpoyAH7GKVHMWhvzx8upG+wd6XykyGeGWvA1tRL+91
         70OwJNFcub8Tc036WDzUr/zdS3lbMXQMpIPpQJQYOFp+EY4eMoHC+7FbZlYzovCwvRaC
         eqsQ6/lxidoVY+qS8WbKLu554i1GiUHj3dpU/sPCQ/msQTn3zjhz3f789qHHJPtoknyZ
         kib5bs4UCJzfm+OlpC53TVp/Eb6B/msw5suVv/UoIhCqf4S4LSI8jIPHF7VPMG+hlrtU
         gMPpSWZunkBPgaIPtIBRurvl9CzSAy4A9jdkH2vrPTCzLV6RYuTXU0jBXZ/8vmcoYr8a
         WBxA==
X-Gm-Message-State: AOJu0YyEXfqyfJ/2cU+hZWlISs51Izm1zzBXowVZlCbbabMgyogp9QF/
	Z1vg7BlxFmuk1nQA/mWa4Ra84X5+G/1Z1Jfc35/LoGWg59OINTvh/E6W4sIwhBa9rw0u29AGuyG
	DSZe6M17Pa7K0FVml8Uo8Lz02IdcHxRaQkz7qZJviOTrGchRfWVvJbdfUrqddJWLkVWoceCOEpm
	zKxZXzAHrfKA3+9gnGZxOfQu9w4VPTAonXb53C0ACgNsZkKIFoCe4=
X-Received: from pfnc7.prod.google.com ([2002:aa7:81c7:0:b0:83e:d99d:7c4b])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:94c7:b0:3a2:d68d:9e6f with SMTP id adf61e73a8af0-3aad44508e5mr15994706637.33.1778611738764;
 Tue, 12 May 2026 11:48:58 -0700 (PDT)
Date: Tue, 12 May 2026 18:48:44 +0000
In-Reply-To: <20260512184846.119396-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260512184846.119396-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512184846.119396-10-dmatlack@google.com>
Subject: [PATCH v5 09/11] PCI: liveupdate: Freeze preservation status during shutdown
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
X-CRM114-CacheID: sfid-20260512_114900_671083_F5B984E6 
X-CRM114-Status: GOOD (  16.07  )
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
index 6ab03bd548b3..825166a57913 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -334,6 +334,11 @@ static int pci_liveupdate_unpreserve_device(struct pci_ser *ser, struct pci_dev
 
 	guard(write_lock)(&dev->liveupdate.lock);
 
+	if (dev->liveupdate.frozen) {
+		pci_WARN(dev, 1, "Cannot unpreserve device after it is frozen!\n");
+		return -EINVAL;
+	}
+
 	dev_ser = dev->liveupdate.outgoing;
 	if (!dev_ser) {
 		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
@@ -420,6 +425,11 @@ static int pci_liveupdate_preserve_device(struct pci_ser *ser, struct pci_dev *d
 {
 	guard(write_lock)(&dev->liveupdate.lock);
 
+	if (dev->liveupdate.frozen) {
+		pci_WARN(dev, 1, "Cannot preserve device after it is frozen!\n");
+		return -EINVAL;
+	}
+
 	if (dev->liveupdate.outgoing)
 		return pci_liveupdate_preserve_device_existing(dev);
 	else
@@ -625,6 +635,12 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 		pci_liveupdate_flb_put_incoming();
 }
 
+void pci_liveupdate_freeze(struct pci_dev *dev)
+{
+	guard(write_lock)(&dev->liveupdate.lock);
+	dev->liveupdate.frozen = 1;
+}
+
 static int __pci_liveupdate_finish_device(struct pci_dev *dev)
 {
 	guard(write_lock)(&dev->liveupdate.lock);
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index fd7693c7ddd2..30deaa673efe 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -13,6 +13,7 @@
 #ifdef CONFIG_PCI_LIVEUPDATE
 void pci_liveupdate_setup_device(struct pci_dev *dev);
 void pci_liveupdate_cleanup_device(struct pci_dev *dev);
+void pci_liveupdate_freeze(struct pci_dev *dev);
 bool pci_liveupdate_inherit_buses(void);
 void pci_liveupdate_init_acs(struct pci_dev *dev);
 bool pci_liveupdate_inherit_acs(struct pci_dev *dev);
@@ -26,6 +27,10 @@ static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 {
 }
 
+static inline void pci_liveupdate_freeze(struct pci_dev *dev);
+{
+}
+
 static inline bool pci_liveupdate_inherit_buses(void)
 {
 	return false;
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
index 34f9900c7d29..7e4ac7a0f4fc 100644
--- a/include/linux/pci_liveupdate.h
+++ b/include/linux/pci_liveupdate.h
@@ -22,6 +22,8 @@
  * @was_preserved: True if this struct pci_dev was preserved by the previous
  *                 kernel. Unlike @incoming, this field is not cleared after
  *                 the device is finished participating in Live Update.
+ * @frozen: True if the outgoing preservation status of this device is frozen
+ *          and thus cannot be changed.
  */
 struct pci_liveupdate {
 	rwlock_t lock;
@@ -29,6 +31,7 @@ struct pci_liveupdate {
 	struct pci_dev_ser *incoming;
 	u16 acs_ctrl;
 	unsigned int was_preserved:1;
+	unsigned int frozen:1;
 };
 
 struct pci_dev;
-- 
2.54.0.563.g4f69b47b94-goog


