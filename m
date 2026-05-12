Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3727ACD343F
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 18:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mf7tBxAoZfUaNtQaP4XWMUKhokf1zfg+pw28xJapIfc=; b=fLBVs927lay2eqNB2ZOdezqzpR
	RC5/4jDGRExdE0BZrz8q10upPJZKCPo7r6m96U/oXHaPw+GoqIADKAuk7fUCCh88g5rGarZ7h4ZG5
	NgaDLeER5iEoUzfPqTcoK5s+1AxCxAQ8qsi6NgaAoHGb5KRN+YqlC0x9y9MgA2KmNb3K/3Rp1mC+t
	BdHFPuqQcxgDMMWzv8GEMcE33uvf/uFPvhuuzmg1GzIbBFZHaiXP/0vq30v2RPdQ7D4KI2u372bwL
	9h2HGCUV3gojSEYU4zo2ZNKD1+FCKJAkSi414qSPl0LUCmrg8yFWlVrj1dE66U4UMY/vhNMY/NDkh
	tEwZm/fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMsA8-000000008hE-1xKE;
	Tue, 12 May 2026 18:49:00 +0000
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMsA5-000000008cx-0yGl
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 18:48:58 +0000
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-c829586e894so1273829a12.2
        for <kexec@lists.infradead.org>; Tue, 12 May 2026 11:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778611736; x=1779216536; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mf7tBxAoZfUaNtQaP4XWMUKhokf1zfg+pw28xJapIfc=;
        b=SZiabtQzK9yvSpzkNWlegj0O1PQzumwVYBakKNe0qPhEwWxqcJz9IfQBNqj7yb6NQf
         18SHACkl8oex5caa5I+osD9GA+/fx3Y1MJTViotx623Uua5aLqxIQZ2wCiZX6chfldYD
         50eiXPr8fo8MQHUun5sqhNqgDVkkR4zrEXRygbTMfkQbn4StdmQZoA2eBM7sphpCcrJk
         MHb1SpNWPxAvby/T1+aCQUpMrjGO8INaHv3++/Q6vIMLTx07awgLH6Z0/mldIvI1aa9J
         3muAjHCNqTNVI3JTScerxk2J8J3tFPHlpK0WKxlxjAmXFg+c2gCYn/rc4du0U5YJC5vt
         OwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778611736; x=1779216536;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mf7tBxAoZfUaNtQaP4XWMUKhokf1zfg+pw28xJapIfc=;
        b=ZLUYD7dduDYXdLLdDdW22AGKR5lc8K5iUPNMvjDCsX3RTYEEbPiIcSud7a/+PI9fX1
         u4iN0bg34zjv0Jqfv5KPSuSHe0JhWu/xzRRWd5z4lM/cZqGG+biVbPYCLxDFAaRIp9fI
         7q2K2TeNsAQscaLTcPkL1KGklB92y9dpWHfDm3nBbDas1SD1Kh3dWvBjuZ3oJfdI1inr
         dj8XPhlppV69BNtgfFLvHHNFSU+I54E/qU9hXlGKh73/lgDPyYGittkgWQpONWP6cJZv
         op8F2KlqiCSP35Y3miBPm4k2na0E820MsKhMOW3iKBjbGv7l3kRG60pHV9KQ6mcW5pkO
         1bKA==
X-Gm-Message-State: AOJu0YwM+kmnOoq0BTtyKqawMFOYWBHl9mHMd6YUuFteGh1dSJK671/W
	d3sgvDHmeGOS+tvk5SeviscOvT5d74V3r88yRTRJOlK9BljowoRanUZPl7T7PeYK0lxYdU6AUcB
	ouMWJBiNWTwCxnRxof4tmZhGj+/iGk65hdVzJScc+50wxq2INC8ISY1RHY63nWwpufP7e+7kUyW
	Xz4IterjJl5415CnWxnha/sek71C2J/cxGCdbtzxxJAYh32HoFH3Y=
X-Received: from pfbem38.prod.google.com ([2002:a05:6a00:3766:b0:835:38e9:3254])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3386:b0:395:ce56:4448 with SMTP id adf61e73a8af0-3ad975a01camr4741664637.25.1778611735458;
 Tue, 12 May 2026 11:48:55 -0700 (PDT)
Date: Tue, 12 May 2026 18:48:40 +0000
In-Reply-To: <20260512184846.119396-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260512184846.119396-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512184846.119396-6-dmatlack@google.com>
Subject: [PATCH v5 05/11] PCI: liveupdate: Keep bus numbers constant during
 Live Update
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
X-CRM114-CacheID: sfid-20260512_114857_332873_BE3A0D0A 
X-CRM114-Status: GOOD (  29.94  )
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

During a Live Update, preserved devices must be allowed to continue
performing memory transactions so the kernel cannot change the fabric
topology, including bus numbers, since that would require disabling
and flushing any memory transactions first.

To keep bus numbers constant, always inherit the secondary and
subordinate bus numbers assigned to bridges during scanning, instead of
assigning new ones, if any PCI devices are being preserved. Note that
the kernel inherits bus numbers even on bridges without any downstream
endpoints that were preserved. This avoids accidentally assigning a
bridge a new window that overlaps with a preserved device that is
downstream of a different bridge.

If a bridge is scanned with a broken topology or has no bus numbers
set during a Live Update, refuse to assign it new bus numbers and refuse
to enumerate devices below it. This is a safety measure to prevent
topology conflicts.

Require that CONFIG_CARDBUS is not enabled to enable
CONFIG_PCI_LIVEUPDATE since inheriting bus numbers on PCI-to-CardBus
bridges requires additional work but is not a priority at the moment.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 +-
 drivers/pci/Kconfig                           |  2 +-
 drivers/pci/liveupdate.c                      | 60 +++++++++++++++++++
 drivers/pci/liveupdate.h                      |  6 ++
 drivers/pci/probe.c                           | 21 +++++--
 5 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4d0f545fb3ec..a64af71c2705 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5138,7 +5138,11 @@ Kernel parameters
 				explicitly which ones they are.
 		assign-busses	[X86] Always assign all PCI bus
 				numbers ourselves, overriding
-				whatever the firmware may have done.
+				whatever the firmware may have done. Ignored
+				during a Live Update, where the kernel must
+				inherit the PCI topology (including bus numbers)
+				to avoid interrupting ongoing memory
+				transactions of preserved devices.
 		usepirqmask	[X86] Honor the possible IRQ mask stored
 				in the BIOS $PIR table. This is needed on
 				some systems with broken BIOSes, notably
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index eea0a6cd388a..aa665231921c 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -330,7 +330,7 @@ config VGA_ARB_MAX_GPUS
 
 config PCI_LIVEUPDATE
 	bool "PCI Live Update Support (EXPERIMENTAL)"
-	depends on PCI && LIVEUPDATE && 64BIT
+	depends on PCI && LIVEUPDATE && 64BIT && !CARDBUS
 	help
 	  Enable PCI core support for preserving PCI devices across Live
 	  Update. This, in combination with support in a device's driver,
diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index d77e64906a25..558fbaec8ddd 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -93,6 +93,21 @@
  * bound to the correct driver. i.e. The PCI core does not protect against a
  * device getting preserved by driver A in the outgoing kernel and then getting
  * bound to driver B in the incoming kernel.
+ *
+ * BDF Stability
+ * =============
+ *
+ * The PCI core guarantees that preserved devices can be identified by the same
+ * bus, device, and function numbers for as long as they are preserved
+ * (including across kexec). To accomplish this, the PCI core always inherits
+ * the secondary and subordinate bus numbers assigned to bridges during scanning
+ * if any device is preserved. This is true even on architectures that always
+ * assign new bus numbers during scanning. The kernel assumes the previous
+ * kernel established a sane bus topology across kexec.
+ *
+ * If a misconfigured or unconfigured bridge is encountered during enumeration
+ * while there are preserved devices, itss secondary and subordinate bus numbers
+ * will be cleared and devices below it will not be enumerated.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -107,6 +122,20 @@
 
 #include "liveupdate.h"
 
+/*
+ * During a Live Update, preserved devices are allowed to continue performing
+ * memory transactions. The kernel must not change the fabric topology,
+ * including bus numbers, since that would require disabling and flushing any
+ * memory transactions first.
+ *
+ * To keep things simple, inherit the secondary and subordinate bus numbers on
+ * _all_ bridges if _any_ PCI devices are preserved (i.e.  even bridges without
+ * any downstream endpoints that were preserved).  This avoids accidentally
+ * assigning a bridge a new window that overlaps with a preserved device that is
+ * downstream of a different bridge.
+ */
+static atomic_t inherit_buses;
+
 /**
  * struct pci_flb_outgoing - Outgoing PCI FLB object
  * @ser: The outgoing struct pci_ser for the next kernel.
@@ -132,6 +161,29 @@ static unsigned long pci_ser_xa_key(u32 domain, u16 bdf)
 	return domain << 16 | bdf;
 }
 
+bool pci_liveupdate_inherit_buses(void)
+{
+	return atomic_read(&inherit_buses);
+}
+
+static void pci_set_liveupdate_inherit_buses(bool enable)
+{
+	/* Ensure updates to inherit_buses do not race with rescans */
+	pci_lock_rescan_remove();
+
+	/*
+	 * Increment/decrement instead of setting directly to true/false so that
+	 * pci_liveupdate_inherit_buses() returns true if any device is outgoing
+	 * preserved or incoming preserved.
+	 */
+	if (enable)
+		atomic_inc(&inherit_buses);
+	else
+		atomic_dec(&inherit_buses);
+
+	pci_unlock_rescan_remove();
+}
+
 static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
 {
 	struct pci_flb_outgoing *outgoing;
@@ -171,6 +223,8 @@ static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
 
 	args->obj = outgoing;
 	args->data = virt_to_phys(outgoing->ser);
+
+	pci_set_liveupdate_inherit_buses(true);
 	return 0;
 }
 
@@ -178,6 +232,8 @@ static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
 {
 	struct pci_flb_outgoing *outgoing = args->obj;
 
+	pci_set_liveupdate_inherit_buses(false);
+
 	WARN_ON_ONCE(outgoing->ser->nr_devices);
 	kho_unpreserve_free(outgoing->ser);
 	kfree(outgoing);
@@ -215,6 +271,8 @@ static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
 	}
 
 	args->obj = incoming;
+
+	pci_set_liveupdate_inherit_buses(true);
 	return 0;
 }
 
@@ -222,6 +280,8 @@ static void pci_flb_finish(struct liveupdate_flb_op_args *args)
 {
 	struct pci_flb_incoming *incoming = args->obj;
 
+	pci_set_liveupdate_inherit_buses(false);
+
 	xa_destroy(&incoming->xa);
 	kho_restore_free(incoming->ser);
 	kfree(incoming);
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index eaaa3559fd77..0bd3e961d5c5 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -13,6 +13,7 @@
 #ifdef CONFIG_PCI_LIVEUPDATE
 void pci_liveupdate_setup_device(struct pci_dev *dev);
 void pci_liveupdate_cleanup_device(struct pci_dev *dev);
+bool pci_liveupdate_inherit_buses(void);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -21,6 +22,11 @@ static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 {
 }
+
+static inline bool pci_liveupdate_inherit_buses(void)
+{
+	return false;
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b5fdc5017f92..08ea9324647b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1375,6 +1375,14 @@ bool pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub)
 	return true;
 }
 
+static bool pci_should_assign_new_buses(void)
+{
+	if (pci_liveupdate_inherit_buses())
+		return false;
+
+	return pcibios_assign_all_busses();
+}
+
 /*
  * pci_scan_bridge_extend() - Scan buses behind a bridge
  * @bus: Parent bus the bridge is on
@@ -1402,6 +1410,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 				  int max, unsigned int available_buses,
 				  int pass)
 {
+	const bool assign_new_buses = pci_should_assign_new_buses();
 	struct pci_bus *child;
 	u32 buses;
 	u16 bctl;
@@ -1454,8 +1463,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		goto out;
 	}
 
-	if ((secondary || subordinate) &&
-	    !pcibios_assign_all_busses() && !broken) {
+	if ((secondary || subordinate) && !assign_new_buses && !broken) {
 		unsigned int cmax, buses;
 
 		/*
@@ -1497,8 +1505,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		 * do in the second pass.
 		 */
 		if (!pass) {
-			if (pcibios_assign_all_busses() || broken)
-
+			if (assign_new_buses || broken)
 				/*
 				 * Temporarily disable forwarding of the
 				 * configuration cycles on all bridges in
@@ -1512,6 +1519,12 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 			goto out;
 		}
 
+		if (pci_liveupdate_inherit_buses()) {
+			pci_err(dev, "Cannot reconfigure bridge during Live Update!\n");
+			pci_err(dev, "Downstream devices will not be enumerated!\n");
+			goto out;
+		}
+
 		/* Clear errors */
 		pci_write_config_word(dev, PCI_STATUS, 0xffff);
 
-- 
2.54.0.563.g4f69b47b94-goog


