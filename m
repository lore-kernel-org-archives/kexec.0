Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB62CD5BBB
	for <kexec@archiver.kernel.org>; Fri, 22 May 2026 20:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SPpQo5/8o8XmqfCxBMhae2hXoPWQwl78O5LFi9BXZl8=; b=JdcwVCOWomTCTkV47E1HD8m7nb
	8Te9ddh+2MvNALcSv3JLyJnybrgxD93uexU6HbRju0ePxZwkm833HFPqQuVsOtgky+c430aV8ygnA
	6PZlyHpbeFN0shTRweU37vm5DzthXAMY9ghZzoPswYFzrvG/OiyS/upbtVBDKEjvab1deBaCDlgRn
	beJi2+uTFdgPR2Vp/vFTc0GloxNLtWtLveVv4GzI41HF9ITuXHB58+qHwws+HMzVUwSbs43y+yjUL
	qZz3oWKV1ehJKS7D0MLTawrj84G14OfkY3NSOrWPUkaPBt0gBDfWP1wMdZuQ38TFAfMTjJQ+hflLb
	2wdRRfKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQWPv-0000000BrwE-12hK;
	Fri, 22 May 2026 20:24:23 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQWPs-0000000Brrk-2LEu
	for kexec@lists.infradead.org;
	Fri, 22 May 2026 20:24:21 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2b4654f9bb6so79139975ad.2
        for <kexec@lists.infradead.org>; Fri, 22 May 2026 13:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779481459; x=1780086259; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SPpQo5/8o8XmqfCxBMhae2hXoPWQwl78O5LFi9BXZl8=;
        b=d38135nPMHtT/BjhNDgd94cYjOd9AOUD06yR+kOWv7zu/1YfGuWwNZHVk+YDglrm51
         ITyOwBBAutHLun8nDgol6I+8hZHizolsvo1xswFwNzRH66Rld6S9aRNwwf6YLIYpYvXI
         7hB2LU3Bu0AjgOISUksWKaoPeDA5+kkhXegQDGV9kteEPCN1oDggiimMRxv1LPsJuWLt
         7yKaEuJSSyjPpAMaoaB+HUAactNmPb37nQdezudmWLxLj/0sKWt/tz9FDg3yD1mvCjaQ
         MQIwviyCLvYp6C/KqOIfyrBuNkbtmY49oCxrV0MbLfOA3dhV8HRGoop7DbOizgOcuG5c
         LQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779481459; x=1780086259;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SPpQo5/8o8XmqfCxBMhae2hXoPWQwl78O5LFi9BXZl8=;
        b=Fr1dt6s4ZfSe1Fn4WIjtyCbUhrFIQWFXyb0pt+uCrN8iIKSs5u8kzsmWde8QfRjb25
         0E04oTxgGg0SuXlVOpCe3N4yvFdmWy7S/EqJKRfmkUTzFkmSLMnguRRsfONJDpwisnu7
         REq7zwBJZY5W83GKRytPLWiMLlI9es48eFoTYis343ZNZIg27GdBayCFPoXdJgSwcSos
         HtDQxcpCe7jac6WOXMCD28RoKWYsywvlB2wzQuEpUVt/dGEbyTc5C/+d7CMwcEB1CRnp
         OXQifvk2LoPjPZv5TTqO7QkNoDN7figrZDh6oZlS6PvidAgTnjBvTkre/ztlVSju/PHa
         vZHA==
X-Gm-Message-State: AOJu0YxYjgtRlGFFf+rDt505Qg3YD/SWWs4Owp6D4neV8wgGG98mTIhj
	oNgVwNvC67vquvjaoR0n+dXImpbVKoLTrHa4RgsHHCAmLQh+VkvBm+Uh80uTTCk7FHcg8kLv8Hv
	V7KgMfdCn2M0ElppThmsaTxBQuMuzqm1MILUoZc+ce6x1gc9O8pubIXeSdB/B+FX4B8RxbU84x3
	UmCCh2vnD1v0n4uK7jLMLzwL/Tn8zzyoPHhNq0Pxa9mPwVJsXYTwc=
X-Received: from plqu9.prod.google.com ([2002:a17:902:a609:b0:2bd:9b10:8067])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:354b:b0:2bc:db91:f5a7 with SMTP id d9443c01a7336-2beb0735023mr53621445ad.11.1779481459064;
 Fri, 22 May 2026 13:24:19 -0700 (PDT)
Date: Fri, 22 May 2026 20:24:06 +0000
In-Reply-To: <20260522202410.3104264-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260522202410.3104264-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522202410.3104264-9-dmatlack@google.com>
Subject: [PATCH v6 08/12] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
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
X-CRM114-CacheID: sfid-20260522_132420_613066_381B7A6A 
X-CRM114-Status: GOOD (  23.94  )
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

Inherit Access Control Services (ACS) flags on all incoming preserved
devices (endpoints and upstream bridges) during a Live Update.

Inheriting ACS flags avoids changing routing rules while memory
transactions are in flight from preserved devices. This is also strictly
necessary to ensure that IOMMU group assignments do not change across
a Live Update for preserved devices, as changing ACS configurations can
split or merge IOMMU groups.

Cache the inherited ACS controls established by the previous kernel in
struct pci_dev so that ACS controls do not change after a reset
(pci_restore_state() calls pci_enable_acs()).

To simplify ACS inheritance, reject preserving any devices that require
quirks to enable ACS as those quirks would also have to take Live Update
into account.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c       | 68 ++++++++++++++++++++++++++++++++++
 drivers/pci/liveupdate.h       | 11 ++++++
 drivers/pci/pci.c              |  5 +++
 drivers/pci/pci.h              |  5 +++
 drivers/pci/quirks.c           |  7 ++++
 include/linux/pci_liveupdate.h |  6 +++
 6 files changed, 102 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 4c79e19b7f98..a93b7ef065f2 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -71,6 +71,9 @@
  *
  *  * The device cannot be a Virtual Function (VF).
  *
+ *  * The device cannot require device-specific quirks to enable Access
+ *    Control Services (ACS).
+ *
  * Driver Binding
  * ==============
  *
@@ -113,6 +116,18 @@
  * This enables the PCI core and any drivers bound to the bridge to participate
  * in the Live Update so that preserved endpoints can continue issuing memory
  * transactions during the Live Update.
+ *
+ * Handling Preserved Devices
+ * ==========================
+ *
+ * The PCI core treats preserved devices differently than non-preserved devices.
+ * This section enumerates those differences.
+ *
+ *  * The PCI core inherits all ACS flags enabled on incoming preserved devices
+ *    rather than assigning new ones. This ensures that TLPs are routed the same
+ *    way after Live Update and ensures that IOMMU groups do not change. Note
+ *    that a device will use its inherited ACS flags for the lifetime of its
+ *    struct pci_dev (i.e. even after pci_liveupdate_finish()).
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -126,6 +141,7 @@
 #include <linux/pci.h>
 
 #include "liveupdate.h"
+#include "pci.h"
 
 /**
  * struct pci_liveupdate_global - Global state for PCI Live Update support
@@ -319,6 +335,16 @@ static int __pci_liveupdate_preserve_device(struct pci_ser *ser, struct pci_dev
 {
 	int i;
 
+	/*
+	 * Do not preserve devices that rely on device-specific ACS equivalents
+	 * (for now) since that would complicate keeping ACS constant across
+	 * Live Update.
+	 */
+	if (pci_need_dev_specific_enable_acs(dev)) {
+		pci_warn(dev, "Refusing to preserve device that relies on ACS quirks\n");
+		return -EINVAL;
+	}
+
 	if (ser->nr_devices == ser->max_nr_devices)
 		return -ENOSPC;
 
@@ -598,6 +624,7 @@ void pci_liveupdate_setup_device(struct pci_dev *dev)
 
 	pci_info(dev, "Device was preserved by previous kernel across Live Update\n");
 	dev->liveupdate.incoming = dev_ser;
+	dev->liveupdate.was_preserved = true;
 
 	/*
 	 * Hold the ref on the incoming FLB until pci_liveupdate_finish() so
@@ -688,6 +715,47 @@ void pci_liveupdate_finish(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_finish);
 
+void pci_liveupdate_init_acs(struct pci_dev *dev)
+{
+	guard(rwsem_read)(&pci_liveupdate.rwsem);
+
+	if (!dev->acs_cap || !dev->liveupdate.incoming)
+		return;
+
+	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &dev->liveupdate.acs_ctrl);
+}
+
+int pci_liveupdate_enable_acs(struct pci_dev *dev)
+{
+	u16 acs_ctrl = dev->liveupdate.acs_ctrl;
+	u16 acs_cap = dev->acs_cap;
+
+	/*
+	 * Use liveupdate.was_preserved instead of liveupdate.incoming since the
+	 * device's ACS controls should not change even after the device is
+	 * finished participating in the Live Update.
+	 */
+	if (!dev->liveupdate.was_preserved)
+		return -EINVAL;
+
+	/*
+	 * The previous kernel should not have preserved any devices that
+	 * require device-specific quirks to enable ACS, but if such a device is
+	 * detected, log a big warning and fall back to the normal enable ACS
+	 * path.
+	 */
+	if (pci_need_dev_specific_enable_acs(dev)) {
+		pci_warn(dev, "Device-specific quirk required to enable ACS!\n");
+		WARN_ON_ONCE(true);
+		return -EINVAL;
+	}
+
+	if (acs_cap)
+		pci_write_config_word(dev, acs_cap + PCI_ACS_CTRL, acs_ctrl);
+
+	return 0;
+}
+
 /**
  * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
  * @dev: The PCI device to check
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index c763255a8de4..4e8a01bcb4bb 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -16,6 +16,8 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev);
 bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus, struct pci_dev *dev,
 				      int pass);
 void pci_liveupdate_scan_bridge_end(struct pci_dev *dev, int pass);
+void pci_liveupdate_init_acs(struct pci_dev *dev);
+int pci_liveupdate_enable_acs(struct pci_dev *dev);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -35,6 +37,15 @@ static inline bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus,
 static inline void pci_liveupdate_scan_bridge_end(struct pci_dev *dev, int pass)
 {
 }
+
+static inline void pci_liveupdate_init_acs(struct pci_dev *dev)
+{
+}
+
+static inline int pci_liveupdate_enable_acs(struct pci_dev *dev)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8f7cfcc00090..211df4618164 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -33,6 +33,7 @@
 #include <asm/dma.h>
 #include <linux/aer.h>
 #include <linux/bitfield.h>
+#include "liveupdate.h"
 #include "pci.h"
 
 DEFINE_MUTEX(pci_slot_mutex);
@@ -1017,6 +1018,9 @@ void pci_enable_acs(struct pci_dev *dev)
 	bool enable_acs = false;
 	int pos;
 
+	if (!pci_liveupdate_enable_acs(dev))
+		return;
+
 	/* If an iommu is present we start with kernel default caps */
 	if (pci_acs_enable) {
 		if (pci_dev_specific_enable_acs(dev))
@@ -3657,6 +3661,7 @@ void pci_acs_init(struct pci_dev *dev)
 
 	pci_read_config_word(dev, pos + PCI_ACS_CAP, &dev->acs_capabilities);
 	pci_disable_broken_acs_cap(dev);
+	pci_liveupdate_init_acs(dev);
 }
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e543a..b55f3deddd57 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1062,6 +1062,7 @@ void pci_acs_init(struct pci_dev *dev);
 void pci_enable_acs(struct pci_dev *dev);
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
+bool pci_need_dev_specific_enable_acs(struct pci_dev *dev);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
 int pci_dev_specific_disable_acs_redir(struct pci_dev *dev);
 void pci_disable_broken_acs_cap(struct pci_dev *pdev);
@@ -1072,6 +1073,10 @@ static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
 {
 	return -ENOTTY;
 }
+static inline bool pci_need_dev_specific_enable_acs(struct pci_dev *dev)
+{
+	return false;
+}
 static inline int pci_dev_specific_enable_acs(struct pci_dev *dev)
 {
 	return -ENOTTY;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 171caec2bc47..59b0b19c3783 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5482,6 +5482,13 @@ static const struct pci_dev_acs_ops *pci_dev_acs_ops_get(struct pci_dev *dev)
 	return NULL;
 }
 
+bool pci_need_dev_specific_enable_acs(struct pci_dev *dev)
+{
+	const struct pci_dev_acs_ops *p = pci_dev_acs_ops_get(dev);
+
+	return p && p->enable_acs;
+}
+
 int pci_dev_specific_enable_acs(struct pci_dev *dev)
 {
 	const struct pci_dev_acs_ops *p = pci_dev_acs_ops_get(dev);
diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
index 2be98819e313..2446c6d237ca 100644
--- a/include/linux/pci_liveupdate.h
+++ b/include/linux/pci_liveupdate.h
@@ -17,14 +17,20 @@
  * struct pci_liveupdate - PCI Live Update state for a struct pci_dev
  * @outgoing: State preserved for the next kernel.
  * @incoming: State preserved by the previous kernel.
+ * @acs_ctrl: ACS features established by the previous kernel.
  * @inherit_buses: True if the PCI core should inherit the secondary and
  *                 subordinate bus numbers assigned to this device due to
  *                 an ongoing Live Update.
+ * @was_preserved: True if this struct pci_dev was preserved by the previous
+ *                 kernel. Unlike @incoming, this field is not cleared after
+ *                 the device is finished participating in Live Update.
  */
 struct pci_liveupdate {
 	struct pci_dev_ser *outgoing;
 	struct pci_dev_ser *incoming;
+	u16 acs_ctrl;
 	bool inherit_buses;
+	bool was_preserved;
 };
 
 struct pci_dev;
-- 
2.54.0.746.g67dd491aae-goog


