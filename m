Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB70C43458
	for <kexec@archiver.kernel.org>; Thu,  2 Jul 2026 17:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1ZpJWU7bWP3TnMKbhRD4tSanxWL1/wKELMMx2GijRAo=; b=XBQ5stL7gJmmTuyeglb7GJ+BFv
	TvJ+76K0ueWCOCnskslpoo42KuLPqdaqSbO72/j5keOvNo8x7s5d0vAtl94YPwKWts9ZN0jYdAs9i
	bIQjphP5nUBrVew3812USa/8xtuFN+LFlEvr9jD07bfyexkqHJFgNhkZntsJIlFBYIdbs5zlt4+nm
	hOeN8ZGXZLt6GX5WB4XcUDR2QIXmlDF16ypx/QHvrMAtj5zLP2u1PL1+1uwR28aMjF2odXbuCIhKg
	5aQE9hSBQXBbmsXsajgDH3tnMAO6CZEFFxa1JqJhexTxs/78f0BssAMhzoXI8kl1LbIK9maewC6nA
	7v6LobBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfLaY-00000005BOw-1s6i;
	Thu, 02 Jul 2026 17:52:38 +0000
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com ([52.13.214.179])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfLaU-00000005BNM-3Uh4
	for kexec@lists.infradead.org;
	Thu, 02 Jul 2026 17:52:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1783014754; x=1814550754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1ZpJWU7bWP3TnMKbhRD4tSanxWL1/wKELMMx2GijRAo=;
  b=QIwMCrHOtdupi7CXRGuESaeLc3Pw4NiTfYUjEdHAB8Lt2GijV1BJexT4
   9ID3XQwhuBdDc9eJkbjusXhWRihrJrDS4CH1j5U4xXuglSNj8U5QkjfIJ
   qgnD5UF0K5UFnvfvA/FTw86TzjKt6BQOdgAMCNUxCp31CaD77J2TpeCjX
   GVqL4QuQsHDN6TEYo/5b1gebMmBo1VUkW4uGLPM2i4j0QCS3Q3IOgFMrF
   oNvczgOp84EGN1uEmf/PKW3kWc/bk7qYV1GEXFnkyzaF2OCONhtLKhzVt
   tr7WFXzO2sZSWPy57+g7/JhngYEZJkEZkd52PY/5TSnSMothTMTqwhHsO
   g==;
X-CSE-ConnectionGUID: SR24hoQITuOMAJzVJBVdIA==
X-CSE-MsgGUID: ZJWhzoOhQFuQi+2qvaoZLg==
X-IronPort-AV: E=Sophos;i="6.25,144,1779148800"; 
   d="scan'208";a="22928692"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 17:52:29 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:14188]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.237:2525] with esmtp (Farcaster)
 id 625d448e-6f93-4707-9a43-6fd4341498e2; Thu, 2 Jul 2026 17:52:29 +0000 (UTC)
X-Farcaster-Flow-ID: 625d448e-6f93-4707-9a43-6fd4341498e2
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 2 Jul 2026 17:52:28 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 2 Jul 2026
 17:52:26 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Tejun Heo
	<tj@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, "David
 Matlack" <dmatlack@google.com>, Samiullah Khawaja <skhawaja@google.com>,
	Alexander Graf <graf@amazon.com>, <linux-mm@kvack.org>,
	<kexec@lists.infradead.org>, <nh-open-source@amazon.com>
Subject: [RFC PATCH 08/14] PCI/sysfs: migrate to device_sysfs_entry, defer physfn symlink
Date: Thu, 2 Jul 2026 19:51:08 +0200
Message-ID: <20260702175114.24659-4-sakacpav@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702175114.24659-1-sakacpav@amazon.de>
References: <20260702174033.32116-1-sakacpav@amazon.de>
 <20260702175114.24659-1-sakacpav@amazon.de>
MIME-Version: 1.0
X-Originating-IP: [172.19.96.155]
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_105234_983166_CBFA7552 
X-CRM114-Status: GOOD (  29.88  )
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

Migrate PCI's per-device sysfs to the declarative walker, and as
part of that wire the bus/type dispatch chain via two new struct
device_type hooks.

  - struct device_type grows .populate / .populate_all hooks
    consulted by device_ktype_populate_one /
    device_ktype_populate_all when the driver-core walker returns
    -ENOENT.

  - PCI's bus/type-owned per-device sysfs content (resource%u /
    resource%u_wc files plus the physfn back-symlink) becomes
    pci_sysfs_entries[] and is dispatched by the same walker.

  - Lazy populate skips eager pci_create_sysfs_dev_files() so VFs
    materialise their resource files only on first userspace
    access.

The physfn symlink moves from per-device add to the wildcard row
on the VF; eager devices still see no change. Idempotent
re-creation is required by the VF lookup-then-readdir VFS order;
sysfs_kn_exists() provides the existence check.

No userspace ABI change.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: driver-core@lists.linux.dev
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: linux-api@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 drivers/base/core.c     |  10 ++-
 drivers/pci/iov.c       |   5 --
 drivers/pci/pci-sysfs.c | 149 ++++++++++++++++++++++++++++++++++++----
 drivers/pci/pci.h       |   5 ++
 drivers/pci/probe.c     |   4 +-
 include/linux/device.h  |  32 ++++++---
 6 files changed, 175 insertions(+), 30 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 15a2dcf922d4b..6c5d1bb66c8f4 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2811,9 +2811,9 @@ device_sysfs_entries_end(const struct device_sysfs_entry *entries)
 	return e;
 }
 
-static int device_sysfs_apply(struct device *dev,
-			     const struct device_sysfs_entry *entries,
-			     enum dev_sysfs_action action, const char *name)
+int device_sysfs_apply(struct device *dev,
+		      const struct device_sysfs_entry *entries,
+		      enum dev_sysfs_action action, const char *name)
 {
 	const struct device_sysfs_entry *e;
 
@@ -2983,6 +2983,8 @@ static int device_ktype_populate_one(struct kobject *kobj, const char *name)
 	}
 	ret = device_sysfs_apply(dev, ktype ? ktype->entries : NULL,
 				DEV_SYSFS_ADD_ONE, name);
+	if (ret == -ENOENT && dev->type && dev->type->populate)
+		ret = dev->type->populate(dev, name);
 out:
 	mutex_unlock(&dev->sysfs_lazy->lock);
 	return ret;
@@ -3011,6 +3013,8 @@ static void device_ktype_populate_all(struct kobject *kobj)
 
 	device_sysfs_apply(dev, ktype ? ktype->entries : NULL,
 			  DEV_SYSFS_ADD_ALL, NULL);
+	if (dev->type && dev->type->populate_all)
+		dev->type->populate_all(dev);
 
 
 	device_sysfs_set_populated(dev);
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 91ac4e37ecb9c..ec2fca8209593 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -212,16 +212,11 @@ int pci_iov_sysfs_link(struct pci_dev *dev,
 	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
 	if (rc)
 		goto failed;
-	rc = sysfs_create_link(&virtfn->dev.kobj, &dev->dev.kobj, "physfn");
-	if (rc)
-		goto failed1;
 
 	kobject_uevent(&virtfn->dev.kobj, KOBJ_CHANGE);
 
 	return 0;
 
-failed1:
-	sysfs_remove_link(&dev->dev.kobj, buf);
 failed:
 	return rc;
 }
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d37860841260c..5a779ebaee326 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1247,6 +1247,13 @@ static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
 	res_attr->attr.mode = 0600;
 	res_attr->size = pci_resource_len(pdev, num);
 	res_attr->private = (void *)(unsigned long)num;
+
+	/* Idempotent: skip if a concurrent populate already created this slot. */
+	if (sysfs_kn_exists(&pdev->dev.kobj, res_attr->attr.name)) {
+		kfree(res_attr);
+		return 0;
+	}
+
 	retval = sysfs_create_bin_file(&pdev->dev.kobj, res_attr);
 	if (retval) {
 		kfree(res_attr);
@@ -1264,8 +1271,6 @@ static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
 /**
  * pci_create_resource_files - create resource files in sysfs for @dev
  * @pdev: dev in question
- *
- * Walk the resources in @pdev creating files for each resource available.
  */
 static int pci_create_resource_files(struct pci_dev *pdev)
 {
@@ -1283,21 +1288,65 @@ static int pci_create_resource_files(struct pci_dev *pdev)
 		if (!pci_resource_len(pdev, i))
 			continue;
 
-		retval = pci_create_attr(pdev, i, 0);
+		/* Skip slots already materialised by populate_one(). */
+		if (!pdev->res_attr[i]) {
+			retval = pci_create_attr(pdev, i, 0);
+			if (retval) {
+				pci_remove_resource_files(pdev);
+				return retval;
+			}
+		}
 		/* for prefetchable resources, create a WC mappable file */
-		if (!retval && arch_can_pci_mmap_wc() &&
-		    pdev->resource[i].flags & IORESOURCE_PREFETCH)
+		if (arch_can_pci_mmap_wc() &&
+		    pdev->resource[i].flags & IORESOURCE_PREFETCH &&
+		    !pdev->res_attr_wc[i]) {
 			retval = pci_create_attr(pdev, i, 1);
-		if (retval) {
-			pci_remove_resource_files(pdev);
-			return retval;
+			if (retval) {
+				pci_remove_resource_files(pdev);
+				return retval;
+			}
 		}
 	}
 	return 0;
 }
+
+/*
+ * Resolve "resourceN" / "resourceN_wc" and create the single file.
+ * Returns -ENOENT for unrelated names or out-of-range/empty BARs so
+ * the walker continues to the next entry.
+ */
+static int pci_create_resource_file_by_name(struct pci_dev *pdev,
+					     const char *name)
+{
+	unsigned int num;
+	int wc = 0;
+	int n = 0;
+
+	if (sscanf(name, "resource%u%n", &num, &n) != 1)
+		return -ENOENT;
+	if (name[n]) {
+		if (strcmp(name + n, "_wc"))
+			return -ENOENT;
+		wc = 1;
+	}
+
+	if (num >= PCI_STD_NUM_BARS || !pci_resource_len(pdev, num))
+		return -ENOENT;
+
+	if (wc && (!arch_can_pci_mmap_wc() ||
+		   !(pdev->resource[num].flags & IORESOURCE_PREFETCH)))
+		return -ENOENT;
+
+	return pci_create_attr(pdev, num, wc);
+}
 #else /* !(defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)) */
 int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
 void __weak pci_remove_resource_files(struct pci_dev *dev) { return; }
+static int pci_create_resource_file_by_name(struct pci_dev *pdev,
+					     const char *name)
+{
+	return -ENOENT;
+}
 #endif
 
 /**
@@ -1661,26 +1710,88 @@ static const struct attribute_group pci_dev_resource_resize_group = {
 	.is_visible = resource_resize_is_visible,
 };
 
+/* Per-device PCI sysfs catalogue. */
+
+/* physfn back-symlink - SR-IOV VF only. */
+
+#ifdef CONFIG_PCI_IOV
+
+static bool pci_applies_to_virtfn(struct device *dev)
+{
+	return to_pci_dev(dev)->is_virtfn;
+}
+
+static int pci_create_physfn_link(struct device *dev, const char *name)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (device_is_sysfs_lazy(dev))
+		lockdep_assert_held(&dev->sysfs_lazy->lock);
+
+	if (sysfs_kn_exists(&dev->kobj, "physfn"))
+		return 0;
+
+	return sysfs_create_link(&dev->kobj, &pdev->physfn->dev.kobj, "physfn");
+}
+
+#endif /* CONFIG_PCI_IOV */
+
+/* resource%u[_wc] family - wildcard row, create() dispatches on @name. */
+
+static int pci_create_resource(struct device *dev, const char *name)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (device_is_sysfs_lazy(dev))
+		lockdep_assert_held(&dev->sysfs_lazy->lock);
+
+	if (!name)
+		return pci_create_resource_files(pdev);
+
+	return pci_create_resource_file_by_name(pdev, name);
+}
+
+static void pci_remove_resource(struct device *dev)
+{
+	pci_remove_resource_files(to_pci_dev(dev));
+}
+
+static const struct device_sysfs_entry pci_sysfs_entries[] = {
+#ifdef CONFIG_PCI_IOV
+	{
+		.name		= "physfn",
+		.applies_to	= pci_applies_to_virtfn,
+		.create	= pci_create_physfn_link,
+	},
+#endif
+	{
+		/* wildcard: "resource%u" / "resource%u_wc" family */
+		.create	= pci_create_resource,
+		.remove		= pci_remove_resource,
+	},
+	{ }, /* sentinel: .create == NULL */
+};
+
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
 	if (!sysfs_initialized)
 		return -EACCES;
 
-	return pci_create_resource_files(pdev);
+	return device_sysfs_apply(&pdev->dev, pci_sysfs_entries,
+				 DEV_SYSFS_ADD_ALL, NULL);
 }
 
 /**
- * pci_remove_sysfs_dev_files - cleanup PCI specific sysfs files
+ * pci_remove_sysfs_dev_files - cleanup PCI sysfs files for @pdev
  * @pdev: device whose entries we should free
- *
- * Cleanup when @pdev is removed from sysfs.
  */
 void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 {
 	if (!sysfs_initialized)
 		return;
 
-	pci_remove_resource_files(pdev);
+	device_sysfs_apply(&pdev->dev, pci_sysfs_entries,
+			  DEV_SYSFS_REMOVE_ALL, NULL);
 }
 
 static int __init pci_sysfs_init(void)
@@ -1835,3 +1946,15 @@ const struct attribute_group *pci_dev_attr_groups[] = {
 #endif
 	NULL,
 };
+
+int pci_dev_type_populate_one(struct device *dev, const char *name)
+{
+	return device_sysfs_apply(dev, pci_sysfs_entries,
+				 DEV_SYSFS_ADD_ONE, name);
+}
+
+void pci_dev_type_populate_all(struct device *dev)
+{
+	device_sysfs_apply(dev, pci_sysfs_entries,
+			  DEV_SYSFS_ADD_ALL, NULL);
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e543a2..9c884a158184c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -395,6 +395,8 @@ static inline int pci_no_d1d2(struct pci_dev *dev)
 #ifdef CONFIG_SYSFS
 int pci_create_sysfs_dev_files(struct pci_dev *pdev);
 void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
+int pci_dev_type_populate_one(struct device *dev, const char *name);
+void pci_dev_type_populate_all(struct device *dev);
 extern const struct attribute_group *pci_dev_groups[];
 extern const struct attribute_group *pci_dev_attr_groups[];
 extern const struct attribute_group *pcibus_groups[];
@@ -403,6 +405,9 @@ extern const struct attribute_group pci_doe_sysfs_group;
 #else
 static inline int pci_create_sysfs_dev_files(struct pci_dev *pdev) { return 0; }
 static inline void pci_remove_sysfs_dev_files(struct pci_dev *pdev) { }
+static inline int pci_dev_type_populate_one(struct device *dev,
+					    const char *name) { return -ENOENT; }
+static inline void pci_dev_type_populate_all(struct device *dev) { }
 #define pci_dev_groups NULL
 #define pci_dev_attr_groups NULL
 #define pcibus_groups NULL
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b63cd0c310bc0..ff7e6016c896f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2499,7 +2499,9 @@ static void pci_release_dev(struct device *dev)
 }
 
 static const struct device_type pci_dev_type = {
-	.groups = pci_dev_attr_groups,
+	.groups		= pci_dev_attr_groups,
+	.populate	= pci_dev_type_populate_one,
+	.populate_all	= pci_dev_type_populate_all,
 };
 
 struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
diff --git a/include/linux/device.h b/include/linux/device.h
index c0a2ee429280c..948c3ea8055e5 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -118,14 +118,27 @@ struct device_sysfs_entry {
 	void (*remove)(struct device *dev);
 };
 
-/*
- * The type of device, "struct device" is embedded in. A class
- * or bus can contain devices of different types
- * like "partitions" and "disks", "mouse" and "event".
- * This identifies the device type and carries type-specific
- * information, equivalent to the kobj_type of a kobject.
- * If "name" is specified, the uevent will contain it in
- * the DEVTYPE variable.
+int device_sysfs_apply(struct device *dev,
+		      const struct device_sysfs_entry *entries,
+		      enum dev_sysfs_action action, const char *name);
+
+/**
+ * struct device_type - The type of device, embedded in struct device.
+ * @name:     if set, appears in the DEVTYPE uevent variable.
+ * @groups:   attribute groups always present on devices of this type.
+ * @uevent:   type-specific uevent handler (may set DEVTYPE or other).
+ * @devnode:  populate /dev node metadata (mode, uid, gid).
+ * @release:  release callback run after the last reference drops.
+ * @pm:       dev_pm_ops vector for devices of this type.
+ * @populate: lazy ADD_ONE for type-owned synthetic attrs/symlinks.
+ *            Called from kernfs populate; device_lock NOT held; may
+ *            sleep. Returns -ENOENT for unknown names.
+ * @populate_all: readdir-time counterpart; best-effort, retry-safe.
+ *
+ * A class or bus can contain devices of different types like
+ * "partitions" and "disks", "mouse" and "event". This identifies
+ * the device type and carries type-specific information, equivalent
+ * to the kobj_type of a kobject.
  */
 struct device_type {
 	const char *name;
@@ -136,6 +149,9 @@ struct device_type {
 	void (*release)(struct device *dev);
 
 	const struct dev_pm_ops *pm;
+
+	int  (*populate)(struct device *dev, const char *name);
+	void (*populate_all)(struct device *dev);
 };
 
 /**
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


