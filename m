Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF37BCC6B1A
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 16:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nMZY6hne5ICVXiyWI18wg5NrB0TiBOxG7wJ7j+K7UmM=; b=Z62VOj30FlRw+lPeXLY+2bwMQI
	yuhPP5GT7aE0bDsWNYYuzUOQp4PYx6Zp+BZSlv3xZZXbeCrGlluhLzTe93u0ghAh2/mqXq2HokhT6
	7S96yJ9JKuSBFHEETo8Mt/1SrJZ/Rge6uItZq25eNIddms+8GjD0sZjsNhtdcdlLdC4eotwtTRj94
	S6xfWbNiJqeBOUHeSewI1psVxpyoxW3mmDC81wEfeUE2YbppUV+xeuQmPNQkauETAlfdM/GxIOXBs
	IybJh6n6oBEadZOQxhLLGPdJBOM7SSyrd6rge6WcI5Iy/fIqebTsouUvkPKnrvsMBs9GzfyZtbP+B
	FCL2tmyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfK4-0000000DUnU-1DDq;
	Tue, 13 Oct 2026 16:25:52 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfK3-0000000DUkz-09hp
	for kexec@bombadil.infradead.org;
	Tue, 13 Oct 2026 16:25:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nMZY6hne5ICVXiyWI18wg5NrB0TiBOxG7wJ7j+K7UmM=; b=SKhTn5lHOK5HUxCUp3EUslNRuH
	qQjdlwiDkjKDQCYuhdr9bkI2Tx7WXglrpr4/TK67YyxZ1vhEGYhnoedCJ+r4qdvz8mAUOj4RM9vAS
	/sqfFzPD922nkEZgy6pzPvQzlDOY3oXE2G1FpP0fglnPwdV8GvytAbEP73+4cZQf0Op2c2yG7yv8m
	nflg+uw1CZiN/NZK/O3vMPOp1UttBNLPNVnRWzv2w8k8g02Pxh0SLLcJCxaeDQZi9Wx8ZgakH2CKF
	a2YMC6156IOCEg3HU6TNVFtY9F7Fw4f0BIkjJ7X8p08s9Oz9Ajdb1eGjj8dQ+dM+/fJsZO7QgHLB9
	5OQiiNPg==;
Received: from mail-pl1-x648.google.com ([2607:f8b0:4864:20::648])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGfJz-0000000FmJs-2gTs
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 16:25:49 +0000
Received: by mail-pl1-x648.google.com with SMTP id d9443c01a7336-2ccb687f82eso30880085ad.3
        for <kexec@lists.infradead.org>; Tue, 13 Oct 2026 09:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791908745; x=1792513545; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nMZY6hne5ICVXiyWI18wg5NrB0TiBOxG7wJ7j+K7UmM=;
        b=DV8brWFHdEtjzZlKLYL50tonkANgwpAGZFwosnzVhOSpM+BY3hJWKM27ptv4rwn97f
         5PFBoWdzsZJzklQhhJtz7fUbXBqKg6xoAbnW5kqTHgYQWZyxEokUhbHIU1W7hdaRXcWj
         sCJ5fgIK8d8+DiXVFu8Rp1BohG/ADvJ2vzUQEjpIN+MNNj4xONy5TNLQawF517ppSg7i
         Ad0R1GKxK4SbeFLJgWLvhh85yy1MgLG4deVVe025btWK7mO/EfhejPFfyt/vHkfeXLfs
         VpDd2nPUux/QKUBTMXdX5cmp0UGXvtz/ksj8oQDMXB6WxWp2uE8V8de6AfIE7lp5qBO/
         r6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791908745; x=1792513545;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nMZY6hne5ICVXiyWI18wg5NrB0TiBOxG7wJ7j+K7UmM=;
        b=K/9Y/FC0GSU7tzZTi0qOURJX91zv4DMdNyT9oRHYr5vbdEInmnmBcZkkcWGnb/dh9q
         yn+zBg1y9ZJyerkpTJcr02TdAdw31JhKIpDHcAngVvnBT+elh0TH39oFNqzN4cXXV1iy
         evSQqc6rkxBJMPRZpOes5Mzz9yT8+DwNG/2emaehE+zO9OuVFI2Ng0gF1lSBZ3lJa23L
         IeDFNYZCN4ubqqYl/b6tfyCx7T0eIag9mnlZbcE7oUPBKIxa5vtZrdYN0rBxfkdjAhEb
         mbh2hWHJMP+ELAR6gkTwJhQ7TsjBVIT9/B59nj15xX+N0D0FX80kSQRjK0pBVb1vZCRC
         RlmQ==
X-Gm-Message-State: AFq9FYIOwXBc1MxdAO7IxA0nddSMeNVU/bffMQspgIPSo19Ph6cfuEs6
	ztafEUeKsEsn9BQ2QuCH1Ypk5iB3jXWLBfj3G2ibm1gXFz2YvSD5ks0RfZD+o5XfYaf12XC/6w1
	EDy6mFuIsNdKwoX6SnrOdJPxrpxsvmYqFE+5BUBFbwQycQoq6Lx2wd6GMin9S4ca672gvh8k3G6
	N2xWRRrh42f1p4IUN7Vuni4K4rzoJYainbIQaZSLVtHurAGfM2xYw=
X-Received: from plgt1.prod.google.com ([2002:a17:902:e841:b0:2e4:cc48:2a25])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3550:b0:2e5:cb9d:3207 with SMTP id d9443c01a7336-2e842805bcdmr115538865ad.1.1791908745197;
 Tue, 13 Oct 2026 09:25:45 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:25:25 +0000
In-Reply-To: <20261013162529.1928093-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20261013162529.1928093-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013162529.1928093-10-dmatlack@google.com>
Subject: [PATCH v10 09/13] PCI: liveupdate: Adopt ACS controls in incoming
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
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_172547_848229_5FC639AB 
X-CRM114-Status: GOOD (  25.01  )
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

Adopt Access Control Services (ACS) controls on all incoming preserved
devices (endpoints and upstream bridges) during a Live Update.

Inheriting ACS flags avoids changing routing rules while memory
transactions are in flight from preserved devices. This is also strictly
necessary to ensure that IOMMU group assignments do not change during or
after Live Update.

The adopted controls are recorded by the pci_save_state() call in
pci_bus_add_device(), which runs before drivers bind, so they are
automatically reapplied by pci_restore_state() if the device is reset.
If that save buffer could not be allocated there is nowhere to record
the adopted controls, and they would be silently lost by the first
reset. Program ACS from scratch in that case, which is a better outcome
than leaving ACS disabled.

To simplify ACS inheritance, reject preserving any devices that require
quirks to enable ACS as those quirks would also have to take Live Update
into account.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 78 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/liveupdate.h |  6 ++++
 drivers/pci/pci.c        |  5 +++
 3 files changed, 89 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 8d5ad26e948c..1d2324d339da 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -123,6 +123,9 @@
  *
  *  * The device cannot be a Virtual Function (VF).
  *
+ *  * The device cannot require device-specific quirks to enable Access
+ *    Control Services (ACS).
+ *
  * Driver Binding
  * ==============
  *
@@ -174,6 +177,18 @@
  * bus, since the bus numbers of the failed bridge can no longer be read from
  * hardware and handing them to another bridge would let an unrelated device
  * inherit the BDF of a preserved device.
+ *
+ * Handling Preserved Devices
+ * ==========================
+ *
+ * The PCI core treats preserved devices differently than non-preserved devices.
+ * This section enumerates those differences.
+ *
+ *  * The PCI core adopts all ACS controls enabled on incoming preserved devices
+ *    rather than assigning new ones. This ensures that TLPs are routed the same
+ *    way after Live Update and ensures that IOMMU groups do not change. Note
+ *    that a device will use its adopted ACS controls for the lifetime of its
+ *    struct pci_dev (i.e. even after pci_liveupdate_finish()).
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -189,6 +204,7 @@
 #include <linux/slab.h>
 
 #include "liveupdate.h"
+#include "pci.h"
 
 /**
  * struct pci_liveupdate_global - Global state for PCI Live Update support
@@ -520,6 +536,16 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
 		return -EINVAL;
 	}
 
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
 	/*
 	 * Endpoint devices should not be preserved more than once.
 	 * Bridges are preserved once for every downstream device that
@@ -844,6 +870,58 @@ void pci_liveupdate_finish(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_finish);
 
+/**
+ * pci_liveupdate_adopt_acs() - Adopt ACS controls
+ * @dev: The PCI device to adopt ACS controls for
+ *
+ * For devices preserved across a Live Update, leave the ACS controls
+ * established by the previous kernel alone instead of programming new ones.
+ * The adopted controls are recorded by the pci_save_state() call in
+ * pci_bus_add_device(), so they are reapplied by pci_restore_state() if the
+ * device is subsequently reset.
+ *
+ * Return: 0 on success, or -EINVAL if the device was not preserved, requires
+ * device-specific quirks, or has nowhere to record the adopted controls.
+ */
+int pci_liveupdate_adopt_acs(struct pci_dev *dev)
+{
+	/*
+	 * Check if the device was preserved over a previous Live Update (even
+	 * if it has already gone through pci_liveupdate_finish()). This ensures
+	 * that the device continues to use the ACS controls established by the
+	 * previous kernel.
+	 */
+	if (!dev->liveupdate.was_incoming)
+		return -EINVAL;
+
+	/*
+	 * The previous kernel should not have preserved any devices that
+	 * require device-specific quirks to enable ACS, but if such a device is
+	 * detected (e.g. new device-specific ACS quirk in the current kernel),
+	 * log a big warning and fall back to the normal enable ACS path.
+	 */
+	if (pci_need_dev_specific_enable_acs(dev)) {
+		pci_warn(dev, "Device-specific quirk required to enable ACS!\n");
+		WARN_ON_ONCE(true);
+		return -EINVAL;
+	}
+
+	/*
+	 * Adopting the previous kernel's controls depends on them being
+	 * captured in the ACS save buffer, so that they are reapplied if the
+	 * device is later reset. Without that buffer, e.g. because it could
+	 * not be allocated under memory pressure, the adopted controls would
+	 * be silently lost by the first reset. Program ACS from scratch
+	 * instead, which is a better outcome than leaving ACS disabled.
+	 */
+	if (dev->acs_cap && !pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ACS)) {
+		pci_err(dev, "No ACS save buffer, not adopting ACS controls\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
  * @dev: The PCI device to check
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index e5d2a19d2ca2..d4721ffcecb2 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -15,6 +15,7 @@ void pci_liveupdate_setup_device(struct pci_dev *dev);
 void pci_liveupdate_cleanup_device(struct pci_dev *dev);
 bool pci_liveupdate_preserve_bus_numbers(void);
 bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus, struct pci_dev *dev);
+int pci_liveupdate_adopt_acs(struct pci_dev *dev);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -34,6 +35,11 @@ static inline bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus,
 {
 	return false;
 }
+
+static inline int pci_liveupdate_adopt_acs(struct pci_dev *dev)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 944590fdef48..650d7f92f93a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -35,6 +35,8 @@
 #include <linux/aer.h>
 #include <linux/bitfield.h>
 #include <linux/suspend.h>
+
+#include "liveupdate.h"
 #include "pci.h"
 
 DEFINE_MUTEX(pci_slot_mutex);
@@ -1164,6 +1166,9 @@ void pci_enable_acs(struct pci_dev *dev)
 	bool enable_acs = false;
 	int pos;
 
+	if (!pci_liveupdate_adopt_acs(dev))
+		return;
+
 	/* If an iommu is present we start with kernel default caps */
 	if (pci_acs_enable) {
 		if (pci_dev_specific_enable_acs(dev))
-- 
2.56.0.385.gd3acb90ef8-goog


