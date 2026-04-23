Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972D5FDEE4E
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 21:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LW56WQ/GxI9kfbfGRUP82x0Orz5k50krThArcWSM6yc=; b=JYF8SeeZCx+eG5cJDSCa70N8y1
	9HjDuoC2wy378vVGg0szS0mYZK9ghcet9Tm/2DYh5dWU+sdIxbJl3FruI6aYtsUsm0tm7I1jqgfXH
	KSrH4kPkmpvVACYI47h7Q+u6LiihttV/U+15W9r7a762SIVC7eq4MwqnVVV1vv3FcpGU7C7Nx+q/z
	SrR8r+Pp3FwulLyrVtUSqw5sG54tKe8XR7wzlCIsLocsp6cuIf59X2DF/3lDDVP2/QPnfqI4+dV9c
	++aOqINfsXyMrndtuRVHHLDItLvcvLVs/8ziQXZcPSNFRu+hhwpTeZ6xR+/+sk8k23MFaTkOhP+wt
	lpSCBnrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG1WB-0000000CL3r-0Vkk;
	Thu, 23 Apr 2026 21:23:27 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG1W8-0000000CL2D-3XHq
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 21:23:25 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2b79f4b35b7so12205495ad.0
        for <kexec@lists.infradead.org>; Thu, 23 Apr 2026 14:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776979403; x=1777584203; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LW56WQ/GxI9kfbfGRUP82x0Orz5k50krThArcWSM6yc=;
        b=Xw+kZTsDmtaAlPQqs2IZ+CvW9VJVs8rRhtOocO04cRtb/uZBLPmpIt8V6qqfrE8MQ8
         cIF+SvPX03FQGq354KCLc0C1KtnzbP6SMxfrO9MuxpYTNEZ58fkjj7jpFfj4siB/hnPa
         UrrANCFNO6kn9OzqkoLVr7wBhPKqba3/hc9ElUxTFQaLcjGL80MXMOeT0LtLSkUHmCRs
         jd0bg6Fzci4IksgGJRLrdnM9qSVsU9kucTRPenLCY5xyl9+BwPuY/93ol9S0MgX5p2nE
         vEwFQZwXG4Cbuxw3agQqiwTUnAA9dIQ3xP2upf02P3fyHFXDlmO0bVrg3RJXaAmGI1sU
         wLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979403; x=1777584203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LW56WQ/GxI9kfbfGRUP82x0Orz5k50krThArcWSM6yc=;
        b=m2XuIAuvjjJsR3sbF6YAE1tPqFyMZwn1Yh7x1MSoI0l2SPIZpGrYtbQOhkZttIhvOg
         wLwTIFU9qmlqyAiDS8t3q9N9+OE5PGCKvcYvJtGqfRB5vz9cthS9HWq2d/GTPU591Thw
         cxQMatQMatSTzZls0ewyeXik7Hxq1WLop+HOWvCW7YqzvulH7vT8IzO3jdGHcTWRM3MD
         kjbdYdoBttpsNcEA5fb0QsbBqN8S0zlpme2HVuq6+JuMFbjaCCIXqlqiHxCMFbTmP4Ds
         0WuThJmpv1/FuKueSn2vu3wWcmRtDBFRp+ChhAKoRXRV9AeJ7N2jhsOYcz+TEr3Ze3Xh
         Q07Q==
X-Forwarded-Encrypted: i=1; AFNElJ9srsnpdW44o475RAwjLra8B9fCXU3KjpR3+oLHXp2S9jEewl6dQ0VUhsCJtUniMX1Ta+wqIw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yywj+uhMJf4N0BHEj6aeJyizUzAmyGB1R6lLXsG4j9mA3AqZxxy
	dOORzdoadDktOKl/ljHzqCeBbwtsVOFLprCtuMC2kc+daY4y3PkNct7KGJHM00FJyPcHIUDRmkJ
	gdBLeSr9/Al3QRA==
X-Received: from plai2.prod.google.com ([2002:a17:902:c942:b0:2b3:2649:c9c1])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:930b:b0:2b2:67ca:5fff with SMTP id d9443c01a7336-2b5f9fd24b7mr208541215ad.28.1776979403289;
 Thu, 23 Apr 2026 14:23:23 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:23:06 +0000
In-Reply-To: <20260423212316.3431746-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423212316.3431746-3-dmatlack@google.com>
Subject: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI devices
From: David Matlack <dmatlack@google.com>
To: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_142324_893605_988265AE 
X-CRM114-Status: GOOD (  25.63  )
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

Add APIs to allow drivers to notify the PCI core of which devices are
being preserved across a Live Update for the next kernel, i.e.
"outgoing" devices.

Drivers must notify the PCI core when devices are preserved so that the
PCI core can update its FLB data (struct pci_ser) and track the list of
outgoing devices. pci_liveupdate_preserve() notifies the PCI core that a
device must be preserved across Live Update. pci_liveupdate_unpreserve()
reverses this (cancels the preservation of the device).

This tracking ensures the PCI core is fully aware of which devices may
need special handling during shutdown and kexec, and so that it can be
handed off to the next kernel.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c    | 101 ++++++++++++++++++++++++++++++++++++
 include/linux/kho/abi/pci.h |   7 +--
 include/linux/pci.h         |  26 ++++++++++
 3 files changed, 131 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index d4fa61625d56..2dd8daa2f17c 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -43,6 +43,26 @@
  *
  *  * ``pci_liveupdate_register_flb(driver_file_handler)``
  *  * ``pci_liveupdate_unregister_flb(driver_file_handler)``
+ *
+ * Device Tracking
+ * ===============
+ *
+ * Drivers must notify the PCI core when specific devices are preserved or
+ * unpreserved with the following APIs:
+ *
+ *  * ``pci_liveupdate_preserve(pci_dev)``
+ *  * ``pci_liveupdate_unpreserve(pci_dev)``
+ *
+ * This allows the PCI core to keep it's FLB data (struct pci_ser) up to date
+ * with the list of **outgoing** preserved devices for the next kernel.
+ *
+ * Restrictions
+ * ============
+ *
+ * The PCI core enforces the following restrictions on which devices can be
+ * preserved. These may be relaxed in the future:
+ *
+ *  * The device cannot be a Virtual Function (VF).
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -57,6 +77,8 @@
 #include <linux/pci.h>
 #include <linux/sort.h>
 
+static DEFINE_MUTEX(pci_flb_outgoing_lock);
+
 static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
 {
 	struct pci_dev *dev = NULL;
@@ -124,6 +146,85 @@ static struct liveupdate_flb pci_liveupdate_flb = {
 	.compatible = PCI_LUO_FLB_COMPATIBLE,
 };
 
+int pci_liveupdate_preserve(struct pci_dev *dev)
+{
+	struct pci_ser *ser;
+	int i, ret;
+
+	guard(mutex)(&pci_flb_outgoing_lock);
+
+	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&ser);
+	if (ret)
+		return ret;
+
+	if (!ser)
+		return -ENOENT;
+
+	if (dev->is_virtfn)
+		return -EINVAL;
+
+	if (dev->liveupdate_outgoing)
+		return -EBUSY;
+
+	if (ser->nr_devices == ser->max_nr_devices)
+		return -ENOSPC;
+
+	for (i = 0; i < ser->max_nr_devices; i++) {
+		/*
+		 * Start searching at index ser->nr_devices. This should result
+		 * in a constant time search under expected conditions (devices
+		 * are not getting unpreserved).
+		 */
+		int index = (ser->nr_devices + i) % ser->max_nr_devices;
+		struct pci_dev_ser *dev_ser = &ser->devices[index];
+
+		if (dev_ser->refcount)
+			continue;
+
+		pci_info(dev, "Device will be preserved across next Live Update\n");
+		ser->nr_devices++;
+
+		dev_ser->domain = pci_domain_nr(dev->bus);
+		dev_ser->bdf = pci_dev_id(dev);
+		dev_ser->refcount = 1;
+
+		dev->liveupdate_outgoing = dev_ser;
+		return 0;
+	}
+
+	return -ENOSPC;
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
+
+void pci_liveupdate_unpreserve(struct pci_dev *dev)
+{
+	struct pci_dev_ser *dev_ser;
+	struct pci_ser *ser = NULL;
+	int ret;
+
+	guard(mutex)(&pci_flb_outgoing_lock);
+
+	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&ser);
+
+	if (ret || !ser) {
+		pci_warn(dev, "Cannot unpreserve device without outgoing Live Update state\n");
+		return;
+
+	}
+
+	dev_ser = dev->liveupdate_outgoing;
+	if (!dev_ser) {
+		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
+		return;
+	}
+
+	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
+	ser->nr_devices--;
+	memset(dev_ser, 0, sizeof(*dev_ser));
+	dev->liveupdate_outgoing = NULL;
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
+
 int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
 {
 	pr_debug("Registering file handler \"%s\"\n", fh->compatible);
diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
index 5c0e92588c00..5b4c8d9e462c 100644
--- a/include/linux/kho/abi/pci.h
+++ b/include/linux/kho/abi/pci.h
@@ -23,19 +23,20 @@
  * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE string.
  */
 
-#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
+#define PCI_LUO_FLB_COMPATIBLE "pci-v2"
 
 /**
  * struct pci_dev_ser - Serialized state about a single PCI device.
  *
  * @domain: The device's PCI domain number (segment).
  * @bdf: The device's PCI bus, device, and function number.
- * @reserved: Reserved (to naturally align struct pci_dev_ser).
+ * @refcount: Reference count used by the PCI core to keep track of whether it
+ *            is done using a device's struct pci_dev_ser.
  */
 struct pci_dev_ser {
 	u32 domain;
 	u16 bdf;
-	u16 reserved;
+	u16 refcount;
 } __packed;
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d70080babd52..eb94cbd8ab9d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -41,6 +41,7 @@
 #include <linux/msi_api.h>
 #include <uapi/linux/pci.h>
 #include <linux/liveupdate.h>
+#include <linux/kho/abi/pci.h>
 
 #include <linux/pci_ids.h>
 
@@ -594,6 +595,9 @@ struct pci_dev {
 	u8		tph_mode;	/* TPH mode */
 	u8		tph_req_type;	/* TPH requester type */
 #endif
+#ifdef CONFIG_PCI_LIVEUPDATE
+	struct pci_dev_ser *liveupdate_outgoing; /* State preserved for next kernel */
+#endif
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
@@ -2880,6 +2884,14 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 #ifdef CONFIG_PCI_LIVEUPDATE
 int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh);
 void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh);
+
+int pci_liveupdate_preserve(struct pci_dev *dev);
+void pci_liveupdate_unpreserve(struct pci_dev *dev);
+
+static inline struct pci_dev_ser *pci_liveupdate_outgoing(struct pci_dev *dev)
+{
+	return dev->liveupdate_outgoing;
+}
 #else
 static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
 {
@@ -2889,6 +2901,20 @@ static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh
 static inline void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh)
 {
 }
+
+static inline int pci_liveupdate_preserve(struct pci_dev *dev)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void pci_liveupdate_unpreserve(struct pci_dev *dev)
+{
+}
+
+static inline struct pci_dev_ser *pci_liveupdate_outgoing(struct pci_dev *dev)
+{
+	return NULL;
+}
 #endif
 
 #endif /* LINUX_PCI_H */
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog


