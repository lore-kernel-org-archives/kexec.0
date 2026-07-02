Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14388C43458
	for <kexec@archiver.kernel.org>; Thu,  2 Jul 2026 17:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wjDO069O5wPccgEOGkGQ3cuNvHu36V72pupN1KvsqHs=; b=I97WNvhw6sGNetmJqaXUhfOmj2
	fC1e297AVqHLi8i0dydG4vVngeilt/6yXbERVJ9q5+39L4dHi2h0keMcB/RBHshZrFJzJAgoFyw48
	hHzpvukqtAVfyvd9Fv+Wph9S01rMnnjhUDGVuYUiQdZKN45H19yTsmkXe87dH0tIgK/TJlzC5C94a
	z3JHAdcbw+ZCJvHtDzP4Z/V58kpgh9Bi04neLhPs4LfiaMslrew3hwnAH0LcR+MgPx+N/P6KabwLB
	RKC1Sx3dEPp55/Fkl1S6CBEW8/n+Vs0PUUBUo33cCiz8HHKQ5ZMDZqoSjGBDUxcek1ZMUroSda5+j
	cJJ6UoXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfLPA-000000059tX-3JuG;
	Thu, 02 Jul 2026 17:40:52 +0000
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com ([52.26.1.71])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfLP7-000000059rN-2DeJ
	for kexec@lists.infradead.org;
	Thu, 02 Jul 2026 17:40:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1783014049; x=1814550049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wjDO069O5wPccgEOGkGQ3cuNvHu36V72pupN1KvsqHs=;
  b=rJ6HYeFAQxPAxKfLjMAyaPeIMXrouBc6H65O5s+ukqBqUlFazBDHvPZD
   VdoCthhOF2buiu837nkXyF3YdHmsLNbX2QPwRQ/q5qh2X52HNy0KEXWdi
   t2sc24uXHW4ccCDxgQVbsC/UTSlcZ707YwoSLPfjMHJgmPhS0FIShGWsP
   45zV8hU64DdF0tOMghCaK2ftnBhk3QyZtN/nHAY/HXb0180eUw6R3Mo7v
   oKShKLLBMBiA4pwJb/LDllz83H2gr/abFbOvgaATPl1VItEHk7+H5YCyo
   dCaxd0+uy97TfiQjkgooznInhGTzZ6cgr7znkhv4Hh5xqRrpxDQAepdiW
   Q==;
X-CSE-ConnectionGUID: d8W885b8TJ649lrO3hVDrA==
X-CSE-MsgGUID: EDaTCzZzRXKJzEObOGELrw==
X-IronPort-AV: E=Sophos;i="6.25,144,1779148800"; 
   d="scan'208";a="22966156"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 17:40:48 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:31911]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.129:2525] with esmtp (Farcaster)
 id d2830d2f-e214-4b0f-b893-92eb1aebbcd0; Thu, 2 Jul 2026 17:40:48 +0000 (UTC)
X-Farcaster-Flow-ID: d2830d2f-e214-4b0f-b893-92eb1aebbcd0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 2 Jul 2026 17:40:48 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 2 Jul 2026
 17:40:45 +0000
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
Subject: [RFC PATCH 04/14] driver core: add struct sysfs_lazy_state and device_set_sysfs_lazy()
Date: Thu, 2 Jul 2026 19:40:23 +0200
Message-ID: <20260702174033.32116-5-sakacpav@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702174033.32116-1-sakacpav@amazon.de>
References: <20260702174033.32116-1-sakacpav@amazon.de>
MIME-Version: 1.0
X-Originating-IP: [172.19.96.155]
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_104049_633816_F304161F 
X-CRM114-Status: GOOD (  19.67  )
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

Add the per-device lazy-sysfs bookkeeping struct and accessors that
subsystems use to opt their devices into lazy population:

  - struct sysfs_lazy_state { mutex lock; bool populated;
    bool power_added; } in include/linux/device.h.
  - dev->sysfs_lazy pointer field on struct device. Non-NULL is the
    opt-in signal device_add() consults to mark the kobj's kernfs
    directory KERNFS_LAZY.
  - Public accessors device_is_sysfs_lazy(), device_sysfs_populated(),
    device_sysfs_set_populated().
    device_sysfs_populated() uses smp_load_acquire() to pair with
    device_sysfs_set_populated()'s smp_store_release(); this lets
    the lockless fast-path in device_ktype_populate_all() (added in
    the next commit) skip the mutex while still observing all
    kernfs_create_*() side-effects performed by populate_all under
    @lock. The canonical write is under @lock.
  - device_set_sysfs_lazy() allocates the bookkeeping; idempotent and
    must be called BEFORE device_add(). Freed by device_release().

device_add() consults dev->sysfs_lazy after kobject_add(); if set,
kernfs_set_lazy(dev->kobj.sd) gates kernfs lookups and readdirs to
device_ktype.populate / populate_all.  No driver-core attribute
content is yet routed through the walker - that lands in the next
commit.  No existing caller opts in here; the plumbing is in place
for subsystems that follow in this series.

The "blob whose pointer doubles as the opt-in signal" pattern
mirrors dev_iommu_get() in drivers/iommu/iommu.c.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: driver-core@lists.linux.dev
Cc: linux-api@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 drivers/base/core.c    | 74 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h | 28 ++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index bd2ddf2aab505..6d0d917d4b1ff 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2555,6 +2555,10 @@ static void device_release(struct kobject *kobj)
 	 */
 	devres_release_all(dev);
 
+	if (dev->sysfs_lazy)
+		mutex_destroy(&dev->sysfs_lazy->lock);
+	kfree(dev->sysfs_lazy);
+
 	kfree(dev->dma_range_map);
 	kfree(dev->driver_override.name);
 
@@ -2588,6 +2592,67 @@ static void device_get_ownership(const struct kobject *kobj, kuid_t *uid, kgid_t
 		dev->class->get_ownership(dev, uid, gid);
 }
 
+/*
+ * True once populate_all has completed; lockless.  False for non-lazy.
+ *
+ * Memory-ordering: pairs with device_sysfs_set_populated()'s
+ * smp_store_release().  smp_load_acquire ensures any kernfs_create_*()
+ * side-effects performed by populate_all under sysfs_lazy.lock become
+ * visible to readers that observe @populated == true.  The kernfs
+ * lookup path also takes kernfs_rwsem(read) which provides an
+ * independent memory-barrier; the explicit acquire here is belt-and-
+ * braces for callers that may bypass kernfs (e.g. internal sysfs_*
+ * helpers and the KUnit suite).
+ */
+bool device_sysfs_populated(const struct device *dev)
+{
+	return dev->sysfs_lazy &&
+	       smp_load_acquire(&dev->sysfs_lazy->populated);
+}
+
+/*
+ * Latch @dev as fully populated. Caller holds @dev->sysfs_lazy->lock.
+ *
+ * Memory-ordering: smp_store_release() publishes all kernfs_create_*()
+ * side-effects performed under sysfs_lazy.lock to lockless readers
+ * via device_sysfs_populated()'s smp_load_acquire().
+ */
+void device_sysfs_set_populated(struct device *dev)
+{
+	smp_store_release(&dev->sysfs_lazy->populated, true);
+}
+
+/**
+ * device_set_sysfs_lazy - opt @dev into lazy sysfs (call before device_add())
+ * @dev: device to opt in
+ *
+ * Allocates @dev->sysfs_lazy.  Idempotent: a second call on a
+ * device that already opted in is a no-op.  Must be called before
+ * device_add().  After device_add() returns, eager attribute creation
+ * is skipped and walker dispatch lazily materializes attributes on
+ * first sysfs lookup or readdir.
+ *
+ * Return:
+ * * %0       - on success (or if already opted in).
+ * * %-ENOMEM - allocation failure.
+ */
+int device_set_sysfs_lazy(struct device *dev)
+{
+	struct sysfs_lazy_state *lazy;
+
+	if (dev->sysfs_lazy)
+		return 0;
+
+	lazy = kzalloc_obj(*lazy);
+	if (!lazy)
+		return -ENOMEM;
+
+	mutex_init(&lazy->lock);
+	dev->sysfs_lazy = lazy;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(device_set_sysfs_lazy);
+
 static const struct kobj_type device_ktype = {
 	.release	= device_release,
 	.sysfs_ops	= &dev_sysfs_ops,
@@ -3642,6 +3707,15 @@ int device_add(struct device *dev)
 	error = device_add_class_symlinks(dev);
 	if (error)
 		goto SymlinkError;
+	/*
+	 * device_set_sysfs_lazy() only allocates ->sysfs_lazy_state for
+	 * non-namespaced devices, and device_is_sysfs_lazy() guards opt-in
+	 * here, so kernfs_set_lazy() should always succeed.  WARN_ON catches
+	 * a regression in those preconditions.
+	 */
+	if (device_is_sysfs_lazy(dev))
+		WARN_ON(kernfs_set_lazy(dev->kobj.sd));
+
 	error = device_add_attrs(dev);
 	if (error)
 		goto AttrsError;
diff --git a/include/linux/device.h b/include/linux/device.h
index 9c8fde6a3d866..39e08e8c950c6 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -45,6 +45,18 @@ struct fwnode_handle;
 struct iommu_group;
 struct dev_pin_info;
 struct dev_iommu;
+/**
+ * struct sysfs_lazy_state - per-device lazy sysfs population state
+ * @lock: serialises populate callbacks (held across device_sysfs_apply())
+ * @populated: full-populate latch
+ * @power_added: dpm_sysfs_add() latch
+ */
+struct sysfs_lazy_state {
+	struct mutex	lock;
+	bool		populated;
+	bool		power_added;
+};
+
 struct msi_device_data;
 
 /**
@@ -739,9 +751,25 @@ struct device {
 	bool			dma_iommu:1;
 #endif
 
+	/* Lazy-sysfs opt-in (NULL = eager). Set via device_set_sysfs_lazy(). */
+	struct sysfs_lazy_state	*sysfs_lazy;
+
 	DECLARE_BITMAP(flags, DEV_FLAG_COUNT);
 };
 
+/**
+ * device_is_sysfs_lazy - true if @dev opted into lazy sysfs
+ * @dev: device to query
+ */
+static inline bool device_is_sysfs_lazy(const struct device *dev)
+{
+	return !!dev->sysfs_lazy;
+}
+
+bool device_sysfs_populated(const struct device *dev);
+void device_sysfs_set_populated(struct device *dev);
+int device_set_sysfs_lazy(struct device *dev);
+
 #define __create_dev_flag_accessors(accessor_name, flag_name) \
 static inline bool dev_##accessor_name(const struct device *dev) \
 { \
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


