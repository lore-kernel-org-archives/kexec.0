Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1851B606A9A6
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 22:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=owhlGOpx;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SCBX6tXA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=KVjRZjTDUQlUGtechd3ID8jkuJ5EsKID0iByl55GGz4=; b=owhlGOpxvHC3XR1RK9W5vsBm6K
	czCCh3l10DT+f5efZtZdSUhzeKRLJz/Z5wqT7DXC7ZeyLG32vFoljyEZjmMqhzTOpQA8jwmDVxtjk
	BM68NOjRYzlCxCQDjpnsdj5B7czRv6cWC/ZpUJbfDGN9YVtp9jxabbbykAOeBCq/uindR0w68iWkL
	U4bmaxL+auFXJG7Fpk4e9ZDULRV5C2UqaOpBuMbGdVkGlqDSJney+qtitoIYJxREq4VMHODZyU4J8
	FKFyGYyAtlyarAMyylirwNQSXU6rSW6UOe7qB/iK3m8un0OUa1hEuRo5ZpyGPH6wj53A+xwCxxllZ
	RfPMS/wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xToHP-0000000AQCz-2miu;
	Wed, 18 Nov 2026 22:37:27 +0000
Received: from mail-oi1-x248.google.com ([2607:f8b0:4864:20::248])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xToHI-0000000APzc-32NJ
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 22:37:22 +0000
Received: by mail-oi1-x248.google.com with SMTP id 5614622812f47-4c55ba309c2so1530009b6e.1
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 14:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795041439; x=1795646239; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KVjRZjTDUQlUGtechd3ID8jkuJ5EsKID0iByl55GGz4=;
        b=SCBX6tXA0JqcYFxDNfFdz8nAn0WJabFAeWfMBvPbw05TxX4TVuSpsJTOpDDBFr9u7H
         0WzFCm9fBOEL60fFCxDKZj4W6rpeijWOG5xUyZZr9tJ9Z53wFaUeD0aKcOFexP4Toso6
         7AMQpblIEi73QqMrVg9DDDMgNtHBCMHMDyCuwT3ol+FZcCN+4URg2e7kx+1SjeqGyvC7
         NQwJ4QQ/K5bcbP42Goa599aDa4C+bxCDhW7wwyFNimY/iLCOjCtV08j92YdRrwIlF+1u
         i9CCHItXxSuTs1t1ArwANZmIwUTD4V5L4QhjyCNWx5jZ2TVnvA+BAUi+d13VoUO+mJLd
         YQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795041439; x=1795646239;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KVjRZjTDUQlUGtechd3ID8jkuJ5EsKID0iByl55GGz4=;
        b=Q18g2sbJwScTHrsLta1QkfVOdKKLQKeNddBx6oZnjqVsEGff1GGv9ykS8NtzPaJotf
         CQt0uTtghkgpsD8j6jGHjmBYWbxYUv76eSpW3A+9PPMYwpQToktdbSDLSDHCwHAqKmIt
         5oApb26LsPW8LGLA/hw2Ex/lTqoZe9w/DNBX6hHolGo+Ogc9KB3/EsvQlamVcCvY0efH
         4Il88BKKs604jy6RD8EKWO8T42n0vAkryZzVF/YZYIIgTcu3b/aSZzt34KD4f7zCWaU/
         tNhtlYPZKMdtWNmi9OeE9eUzraW05jsusI6xaqBIC+TAZwS77iDTbkrEL7zGKpVQQSMV
         7n4g==
X-Gm-Message-State: APuU4Z9P1g3Y9o489IfJU7mvntbYEVC9J3x8DmEmXK6xJ7Np7d78tNVv
	ME2OjcuTHVla39GSMcMmoM7lvxCSTwqCCY+TJXGOH9RMdUkkoIH4zg7Gb3z9kl1vq/kqygVaX2a
	aDq/gao4Pb2VgJLVzU67pTmF7HWjhVwPlW/rR9t3eumZ1+7jqvm/w7kKkiifwAYevLT7l4YJIH5
	LMUXNWPDKKvPcWBRTOINPA6ad+swMPYGYRElAUWZ9MX/9h3JB4Jos=
X-Received: from ilb5-n2.prod.google.com ([2002:a05:6e02:5305:20b0:53c:e043:6f2d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:13c4:b0:572:a102:ad54 with SMTP id 5614622812f47-5773d028248mr4248721b6e.40.1795041438457;
 Wed, 18 Nov 2026 14:37:18 -0800 (PST)
Date: Wed, 18 Nov 2026 22:37:00 +0000
In-Reply-To: <20261118223704.3286085-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261118223704.3286085-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118223704.3286085-10-dmatlack@google.com>
Subject: [PATCH v11 09/13] PCI: liveupdate: Adopt ACS controls in incoming
 preserved devices
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Alex Williamson <alex.williamson@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Down <chris@chrisdown.name>, Chris Li <chrisl@kernel.org>, 
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
X-CRM114-CacheID: sfid-20261118_143720_788216_3C564B10 
X-CRM114-Status: GOOD (  29.01  )
X-Spam-Score: -9.5 (---------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adopt Access Control Services (ACS) controls on all incoming preserved
devices (endpoints and upstream bridges) during a Live Update.

Adopting ACS controls avoids changing routing rules while memory
transactions are in flight from preserved devices. It also keeps IOMMU
groups from changing during or after Live Update.

The adopted controls are recorded by the pci_save_state() call in
pci_bus_add_device(), which runs before drivers bind, so they are
reapplied by pci_restore_state() if the device is reset. Allocate the
ACS save buffer for incoming preserved devices even if they match a
device-specific ACS quirk, since their adopted controls live in the ACS
capability, and panic if it could not be allocated.

To simplify ACS adoption, reject preserving any devices that require
quirks to enable ACS as those quirks would also have to take Live Update
into account. If such a quirk matches an incoming preserved device
anyway, e.g. because it was added in the new kernel, log a warning and
adopt the device's ACS controls regardless, rather than reprogram a
device in the path of a preserved device's memory transactions.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 75 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/liveupdate.h | 16 +++++++++
 drivers/pci/pci.c        | 13 +++++--
 3 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 00d6fa5236e9..b99a88c2c199 100644
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
@@ -174,6 +177,17 @@
  * bus, since the bus numbers of the failed bridge can no longer be read from
  * hardware and handing them to another bridge would let an unrelated device
  * inherit the BDF of a preserved device.
+ *
+ * Handling Preserved Devices
+ * ==========================
+ *
+ * The PCI core handles preserved devices differently in the following ways:
+ *
+ *  * The PCI core adopts all ACS controls enabled on incoming preserved devices
+ *    rather than assigning new ones, so TLP routing and IOMMU groups stay the
+ *    same after Live Update. Note that a device will use its adopted ACS
+ *    controls for the lifetime of its struct pci_dev (i.e. even after
+ *    pci_liveupdate_finish()).
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -189,6 +203,7 @@
 #include <linux/slab.h>
 
 #include "liveupdate.h"
+#include "pci.h"
 
 /**
  * struct pci_liveupdate_global - Global state for PCI Live Update support
@@ -540,6 +555,15 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
 		return -EINVAL;
 	}
 
+	/*
+	 * Do not preserve devices that rely on device-specific ACS equivalents
+	 * since that would complicate keeping ACS constant across Live Update.
+	 */
+	if (pci_need_dev_specific_enable_acs(dev)) {
+		pci_warn(dev, "Refusing to preserve device that relies on ACS quirks\n");
+		return -EINVAL;
+	}
+
 	if (dev_ser) {
 		/*
 		 * Endpoint devices can only be preserved once. Bridges are
@@ -816,6 +840,57 @@ void pci_liveupdate_finish(struct pci_dev *dev)
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
+ * Panics if the device has an ACS capability but no ACS save buffer, since the
+ * adopted controls would be lost on the first reset.
+ *
+ * Return: 0 if the ACS controls were adopted, or -EINVAL if the device was not
+ * preserved.
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
+	 * The previous kernel does not preserve devices that require
+	 * device-specific quirks to enable ACS, so the controls being adopted
+	 * live entirely in the ACS capability. If such a quirk matches anyway
+	 * (e.g. it was added in the current kernel), ignore it rather than
+	 * reprogram a device in the path of a preserved device's memory
+	 * transactions.
+	 */
+	if (pci_need_dev_specific_enable_acs(dev))
+		pci_warn(dev, "Ignoring device-specific ACS quirk, adopting ACS controls from previous kernel\n");
+
+	/*
+	 * The adopted controls must be captured in the ACS save buffer so that
+	 * they are reapplied if the device is later reset. Without it, e.g.
+	 * because it could not be allocated, the first reset would silently
+	 * drop them.
+	 */
+	if (dev->acs_cap && !pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ACS))
+		panic("%s: No ACS save buffer for preserved device\n",
+		      pci_name(dev));
+
+	return 0;
+}
+
 /**
  * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
  * @dev: The PCI device to check
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index e5d2a19d2ca2..c643f2664296 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -15,6 +15,12 @@ void pci_liveupdate_setup_device(struct pci_dev *dev);
 void pci_liveupdate_cleanup_device(struct pci_dev *dev);
 bool pci_liveupdate_preserve_bus_numbers(void);
 bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus, struct pci_dev *dev);
+int pci_liveupdate_adopt_acs(struct pci_dev *dev);
+
+static inline bool pci_liveupdate_was_incoming(struct pci_dev *dev)
+{
+	return dev->liveupdate.was_incoming;
+}
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -34,6 +40,16 @@ static inline bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus,
 {
 	return false;
 }
+
+static inline int pci_liveupdate_adopt_acs(struct pci_dev *dev)
+{
+	return -EINVAL;
+}
+
+static inline bool pci_liveupdate_was_incoming(struct pci_dev *dev)
+{
+	return false;
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index fc4307a2327d..ebc565b4780a 100644
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
@@ -1071,9 +1073,13 @@ static void pci_allocate_acs_save_buffer(struct pci_dev *dev)
 	/*
 	 * Devices that rely on device-specific quirks to enable an ACS
 	 * equivalent keep that configuration outside of the ACS Control
-	 * register, so they are configured from scratch on restore.
+	 * register, so they are configured from scratch on restore. The
+	 * exception is devices preserved across a Live Update, which always
+	 * adopt the ACS controls established by the previous kernel and need
+	 * the buffer to keep them across resets.
 	 */
-	if (pci_need_dev_specific_enable_acs(dev))
+	if (pci_need_dev_specific_enable_acs(dev) &&
+	    !pci_liveupdate_was_incoming(dev))
 		return;
 
 	/* dev->acs_cap is not set yet, pci_acs_init() runs later */
@@ -1170,6 +1176,9 @@ void pci_enable_acs(struct pci_dev *dev)
 	bool enable_acs = false;
 	int pos;
 
+	if (!pci_liveupdate_adopt_acs(dev))
+		return;
+
 	/* If an iommu is present we start with kernel default caps */
 	if (pci_acs_enable) {
 		if (pci_dev_specific_enable_acs(dev))
-- 
2.56.1.703.gf848ed807c-goog


