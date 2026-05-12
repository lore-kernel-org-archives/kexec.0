Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E09CD4F24
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 18:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TGo/6CdqO8ibA5eNqLaT5PlJcsuc1WV9zdpDClCuOsU=; b=XjLuudJRI6gU7oAQwRno4wNCXS
	V8sDP+T263FyjsDEfEeO68+e2KQ2yzLwx86Xf6YcXuJ5LEI/vb9ep+JpUoRi9O7yc6H0nv8a8h44C
	wlytfXBzyVPBrfz5qOcD5hLqeBgME4KNooDf44ddCmvS9E1X9LzpgMGmNYldYUxXNpZzeiVcZ8xO+
	sYNNrv0dP8KNmmbfE6foDdJTkFp6pr2vNnYOWy6J5NrmZn90beDHnlVCgoJfm5+YWFTqZqjSHmpM9
	p/Y8xRbakv9Pi++8mRDTX5UjQWRp49AQf0jLUzn7FTPKidjBcmzwDXtsqx/r8W/EFaa4SG5lafvHZ
	ZtmOvNPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMsAA-000000008jq-2kAt;
	Tue, 12 May 2026 18:49:02 +0000
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMsA6-000000008ec-48iP
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 18:49:00 +0000
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-36642d2f4deso8325901a91.3
        for <kexec@lists.infradead.org>; Tue, 12 May 2026 11:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778611737; x=1779216537; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TGo/6CdqO8ibA5eNqLaT5PlJcsuc1WV9zdpDClCuOsU=;
        b=GRoaRCMVbu3mI7tYtx37ZMfCLH4OX4AW5GxleHfqaOpQc9Dr74paxwEsaGweiqvnbS
         gVCH7TKn6s2iYg1p+b5X8NEfj2n50/1gvSqUr/SG200O77PyRhQMtb4Ekf//FcXhiqXf
         VfANTfU+lh1Sd4MNa/i9DSphBQ5USLqCHgNz+4Hu7q+j7Yj7sZYUuEGNpGF67AX6A5AT
         XHJUCHVuZQyHxhtL0ZSqejgBp897Qqmtme7sh+HtCWnLv12Aaz6z6E++HJxHhAg2fZpC
         xvsHX27dTNkjEdSaFmzVzVQ/2jMcC79N0PeNabiGf1DzNKDNU2zCy2SsFJWxoh7PRq+u
         HdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778611737; x=1779216537;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGo/6CdqO8ibA5eNqLaT5PlJcsuc1WV9zdpDClCuOsU=;
        b=TO+y1WkScA5m6DF+Z7Pw17C5+Mf4Owaz3HGQ/wXVwrQLhvMhw3L9oEBxHprNPqRAtz
         QvRuEyWMvpJ2XlCVa3n2wxUM0VqkROsf2PqT/a+bUGmXmLbw+g202ObS2JV6luOFZezY
         Tu/lxQLJ2RyGt7ZxQjueT3U01iypDW6aswU7pqKqUR7RkKIQDndwTyiOOOu+DDG5Asam
         iK3ehJIHkVJWVPTw5D1qjdq3NAAcbzWHfYws2OBN37CwSGt+3QRPxFRZr3I5AcCmwAzh
         uBXH0QZ5bFQVdnZw70INuXjAj7b7pbwwPgftd62cuz1nE+wk8XZA7OAit+58TvkBDQcM
         oB2w==
X-Gm-Message-State: AOJu0YzGMIxySGC2Ln8dSuLNFqV95Nsiasg9xefVoB8WCPIFceUQkjkg
	IAkQX8XEE+yTENACGJAioomIbuJI07jU59JzUlRWsjrW/JdvZy6EHSahX6ryfCCH+K4nCYtn++g
	4KIe6Y7jlY/osz/+SKpo57k/v7V92tj3eWmXLe0VRJHU5Rd5rOvJIvMLJEx56jsPyeVlYDwfjE2
	9aov//kqrmoR85NbnFXdbPg2/a6PhH2uCgteGju8AXyiXqB+zk54c=
X-Received: from pfblu4.prod.google.com ([2002:a05:6a00:7484:b0:82f:7d56:a149])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9995:b0:3ab:13f4:c71d with SMTP id adf61e73a8af0-3ad991e88d4mr5416489637.33.1778611737089;
 Tue, 12 May 2026 11:48:57 -0700 (PDT)
Date: Tue, 12 May 2026 18:48:42 +0000
In-Reply-To: <20260512184846.119396-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260512184846.119396-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512184846.119396-8-dmatlack@google.com>
Subject: [PATCH v5 07/11] PCI: liveupdate: Inherit ACS flags in incoming
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
X-CRM114-CacheID: sfid-20260512_114859_035435_188A1EA9 
X-CRM114-Status: GOOD (  20.84  )
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

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c       | 49 ++++++++++++++++++++++++++++++++++
 drivers/pci/liveupdate.h       | 11 ++++++++
 drivers/pci/pci.c              |  5 ++++
 include/linux/pci_liveupdate.h |  6 +++++
 4 files changed, 71 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index d8e06afde2c7..e3cd6d76636c 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -120,6 +120,18 @@
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
@@ -361,6 +373,16 @@ static int pci_liveupdate_preserve_device_new(struct pci_ser *ser, struct pci_de
 {
 	int i;
 
+	/*
+	 * Do not preserve a devices that rely on device-specific ACS
+	 * equivalents (for now) since that would complicate keeping ACS
+	 * flags constant across Live Update.
+	 */
+	if (dev->dev_flags & PCI_DEV_FLAGS_ACS_ENABLED_QUIRK) {
+		pci_warn(dev, "Refusing to preserve device that relies on ACS quirks\n");
+		return -EINVAL;
+	}
+
 	if (ser->nr_devices == ser->max_nr_devices)
 		return -ENOSPC;
 
@@ -571,6 +593,7 @@ void pci_liveupdate_setup_device(struct pci_dev *dev)
 	pci_info(dev, "Device was preserved by previous kernel across Live Update\n");
 	guard(write_lock)(&dev->liveupdate.lock);
 	dev->liveupdate.incoming = dev_ser;
+	dev->liveupdate.was_preserved = true;
 
 	/*
 	 * Hold the ref on the incoming FLB until pci_liveupdate_finish() so
@@ -671,6 +694,32 @@ void pci_liveupdate_finish(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_finish);
 
+void pci_liveupdate_init_acs(struct pci_dev *dev)
+{
+	guard(read_lock)(&dev->liveupdate.lock);
+
+	if (!dev->acs_cap || !dev->liveupdate.incoming)
+		return;
+
+	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &dev->liveupdate.acs_ctrl);
+}
+
+bool pci_liveupdate_inherit_acs(struct pci_dev *dev)
+{
+	guard(read_lock)(&dev->liveupdate.lock);
+
+	/*
+	 * Use liveupdate.was_preserved instead of liveupdate.incoming since the
+	 * device's ACS controls should not change even after the device is
+	 * finished participating in the Live Update.
+	 */
+	if (!dev->acs_cap || !dev->liveupdate.was_preserved)
+		return false;
+
+	pci_write_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, dev->liveupdate.acs_ctrl);
+	return true;
+}
+
 /**
  * pci_liveupdate_is_incoming() - Check if a device is incoming preserved
  * @dev: The PCI device to check
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index 0bd3e961d5c5..c0826ca717e3 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -14,6 +14,8 @@
 void pci_liveupdate_setup_device(struct pci_dev *dev);
 void pci_liveupdate_cleanup_device(struct pci_dev *dev);
 bool pci_liveupdate_inherit_buses(void);
+void pci_liveupdate_init_acs(struct pci_dev *dev);
+bool pci_liveupdate_inherit_acs(struct pci_dev *dev);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -27,6 +29,15 @@ static inline bool pci_liveupdate_inherit_buses(void)
 {
 	return false;
 }
+
+static inline void pci_liveupdate_init_acs(struct pci_dev *dev)
+{
+}
+
+static inline bool pci_liveupdate_inherit_acs(struct pci_dev *dev)
+{
+	return false;
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8f7cfcc00090..cd2c1f2ada92 100644
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
 
+	if (pci_liveupdate_inherit_acs(dev))
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
diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
index 1c2ee32ad058..34f9900c7d29 100644
--- a/include/linux/pci_liveupdate.h
+++ b/include/linux/pci_liveupdate.h
@@ -18,11 +18,17 @@
  * @lock: Lock used to protect members of struct pci_liveupdate.
  * @outgoing: State preserved for the next kernel.
  * @incoming: State preserved by the previous kernel.
+ * @acs_ctrl: ACS features established by the previous kernel.
+ * @was_preserved: True if this struct pci_dev was preserved by the previous
+ *                 kernel. Unlike @incoming, this field is not cleared after
+ *                 the device is finished participating in Live Update.
  */
 struct pci_liveupdate {
 	rwlock_t lock;
 	struct pci_dev_ser *outgoing;
 	struct pci_dev_ser *incoming;
+	u16 acs_ctrl;
+	unsigned int was_preserved:1;
 };
 
 struct pci_dev;
-- 
2.54.0.563.g4f69b47b94-goog


