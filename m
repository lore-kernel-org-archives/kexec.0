Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC0FFDEE53
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 21:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xzr76OgKRSVyLlNPZ4BBmoEisHfu3frnnsSEc+2qgNA=; b=eZYT0U91vtFccd/f++I7GKZjxi
	VeU5m3uYwVB8xLPXFanVzo1OPx96TmCxBPZk4qZMX2YYDikc7nE/ggR7l1IXTmaCjbGkYT4ksmgXj
	MEMuRpOqMP+J8XrDNfzzTaj/OZSdWs+jgQcwDVub/gltWmRVtVCr79bVzMP8j5e/OchJ9pNlG3Hqt
	axqUg9JMi+mWG5xcfmBxhkTDsu+cclWsnI0P4XPlRjBfepjbzL23Ofs56pXMY9rZujWzn7Wbp11LG
	a405zLVUDIhH/I+uNrb1UeZiRvqJbzgQVeWlKj6DQC8SrFqXgmPtmyJReSMG1E63liu52J/ADUky7
	XWmR29ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG1WL-0000000CLCr-1ain;
	Thu, 23 Apr 2026 21:23:37 +0000
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG1WJ-0000000CL9o-0VkC
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 21:23:36 +0000
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-c7993b17335so2082777a12.0
        for <kexec@lists.infradead.org>; Thu, 23 Apr 2026 14:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776979414; x=1777584214; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xzr76OgKRSVyLlNPZ4BBmoEisHfu3frnnsSEc+2qgNA=;
        b=Gg/o0Wt50/P87esBa4lfnUpVfkIewu64LIkI3FMZFCaXr7XyKFdzysRWkXOYWEYhJM
         qJpfK2KePg9lT80OqZxAbOh1mlwisxORTp70tdoKLME9NLwINOzffevFb6tLzWDZDv+g
         WHhCy9cXehgTkW/yVqv52amdUu4PME7yKWVxVfgETe1Cx+moBZWffPa5ZcswxRsKAJC0
         AITYXpCCmuvmBGJWceG/qhyab6/ODH914njgsHqi9IJef89o8ELvu1pB7mpJgA6T/IQI
         iGiy3f3Brdjx7kwxzZh+G20rYdveKL/++2kjrJFsvsB9XB4M59yY8eF+HGN8sHgDyTvb
         9iDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979414; x=1777584214;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xzr76OgKRSVyLlNPZ4BBmoEisHfu3frnnsSEc+2qgNA=;
        b=Q/NdiGqSaFkkigLWIRzpyXJO8dKQI3m08aRMQWLpvazjjv8lnSJCMcB5sBphQCrxUC
         94rC9iQX4Ci0eQTAxe7S7Ot3mN+4Jl/GcvlHfmt64PaeK8uK3U2eba608ok/eD4csHbp
         Qe31YiUOYDORF308i6fv8E3VDyJp3h59it6n02W5lRCuGUby2AWDIFhNJJQ2b0BjCJQ+
         DkzrBReQaC3TJIU+dG2+9/BPp8OroWyxbtJGgxDd9JJ3rftYLUSrdb3u7Buq5YYJnGlh
         rWXWu/yza//NQgFQOAvpxjT0/o3W8418JoiclIMEewKWzwQM0rbt6Jyb82R/MpPn/utT
         mcMg==
X-Forwarded-Encrypted: i=1; AFNElJ+AfoSPsf71ucxQtjMoykKNLG/NfGcjaMBxfMJCAhekdyf2U3dbgT8hztOcur6zYl2M/aydXQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzH4DGBX4E6KnCjrtPfipTa/XIMmqjFGzpWUQeK35YW8t5Gdhj+
	B+vJXk6D67P8CY5y11++xMwmUIGrwWpnj1rnXA+A+F6q8aSA3rzMSzaoRvnJpIYHHejLZQcXkkd
	1h+oLSZ9TmAZ4UQ==
X-Received: from pgbda7.prod.google.com ([2002:a05:6a02:2387:b0:c79:9058:b77e])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6da2:b0:3a0:b781:4c8b with SMTP id adf61e73a8af0-3a0b78155d5mr25116879637.2.1776979414052;
 Thu, 23 Apr 2026 14:23:34 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:23:12 +0000
In-Reply-To: <20260423212316.3431746-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423212316.3431746-9-dmatlack@google.com>
Subject: [PATCH v4 08/11] PCI: liveupdate: Require preserved devices are in
 immutable singleton IOMMU groups
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
X-CRM114-CacheID: sfid-20260423_142335_175897_59168A4B 
X-CRM114-Status: GOOD (  19.14  )
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

Restrict support for preserving PCI devices across Live Update to
devices in immutable singleton IOMMU groups. A device's group is
considered immutable if all bridges upstream from the device up to the
root port have the required ACS features enabled.

Since ACS flags are inherited across a Live Update for preserved devices
and all the way up to the root port, the preserved device should be in a
singleton IOMMU group after kexec in the new kernel.

This change should still permit all the current use-cases for PCI device
preservation across Live Update, since it is intended to be used in
Cloud enviroments which should have the required ACS features enabled
for virtualization purposes.

If a device is part of a multi-device IOMMU group, preserving it will
now fail with an error. This restriction may be lifted in the future if
support for preserving multi-device groups is desired.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/iommu/iommu.c    | 35 +++++++++++++++++++++++++++++++++++
 drivers/pci/liveupdate.c |  6 ++++++
 include/linux/iommu.h    |  7 +++++++
 3 files changed, 48 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 61c12ba78206..782e73a9d45f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1664,6 +1664,41 @@ struct iommu_group *pci_device_group(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(pci_device_group);
 
+bool pci_device_group_immutable_singleton(struct pci_dev *dev)
+{
+	struct iommu_group *group;
+	struct group_device *d;
+	struct pci_bus *bus;
+	int nr_devices = 0;
+
+	group = iommu_group_get(&dev->dev);
+	if (!group)
+		return false;
+
+	mutex_lock(&group->mutex);
+
+	for_each_group_device(group, d)
+		nr_devices++;
+
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+
+	if (nr_devices != 1)
+		return false;
+
+	for (bus = dev->bus; !pci_is_root_bus(bus); bus = bus->parent) {
+		if (!bus->self)
+			continue;
+
+		if (!pci_acs_path_enabled(bus->self, NULL, REQ_ACS_FLAGS))
+			return false;
+
+		break;
+	}
+
+	return true;
+}
+
 /* Get the IOMMU group for device on fsl-mc bus */
 struct iommu_group *fsl_mc_device_group(struct device *dev)
 {
diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index a9a89f7bd3e5..54a90ff02bdd 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -133,6 +133,7 @@
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
 
 #include <linux/io.h>
+#include <linux/iommu.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/pci.h>
 #include <linux/liveupdate.h>
@@ -359,6 +360,11 @@ int pci_liveupdate_preserve(struct pci_dev *dev)
 	if (dev->is_virtfn)
 		return -EINVAL;
 
+	if (!pci_device_group_immutable_singleton(dev)) {
+		pci_warn(dev, "Device preservation limited to immutable singleton iommu groups\n");
+		return -EINVAL;
+	}
+
 	if (dev->liveupdate_outgoing)
 		return -EBUSY;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e587d4ac4d33..6f5d1dec3f89 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1096,6 +1096,8 @@ extern struct iommu_group *generic_device_group(struct device *dev);
 struct iommu_group *fsl_mc_device_group(struct device *dev);
 extern struct iommu_group *generic_single_device_group(struct device *dev);
 
+bool pci_device_group_immutable_singleton(struct pci_dev *dev);
+
 /**
  * struct iommu_fwspec - per-device IOMMU instance data
  * @iommu_fwnode: firmware handle for this device's IOMMU
@@ -1528,6 +1530,11 @@ static inline int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 static inline void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 {
 }
+
+static inline bool pci_device_group_immutable_singleton(struct pci_dev *dev)
+{
+	return false;
+}
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IRQ_MSI_IOMMU
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog


