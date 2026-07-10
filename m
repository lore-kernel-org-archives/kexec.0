Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4456EC43458
	for <kexec@archiver.kernel.org>; Fri, 10 Jul 2026 21:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/hPVaDoRJAueZjNQ0NAjSyINZ2msgaXxj6lZgcfKzVg=; b=yZuNWAGs3fGojWPhpEoK0gFGds
	GyiqekhvoTJ7igo/qCJjoFueyHv7NMBeAJcBee2mivp8wzNd2+7LUNTKFtlx2JxCFRBaX9zsL/u/2
	01UEZIC/Ms+Vzv55WVyLeXwrd9576HNyi2flLDlxkKcDhgDdGSMXITpkUr0cGJM7UD3QV1doHxL1j
	FKEobA/4Rf4EhHTNi9QJNEJH03Hl5kL9hEJkcGM8fsYhf5mHsAtYWsBL2A6WDTIBc6XZh0cFfA7Xj
	o1WMbQJH8uRQqQmIL1wcVRHjKXSaePoUycAGXOmG/haRCISsng/Zdqq5gEJUA3umPAQLMoFl2u5qa
	AiiiK5kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIjx-00000005pTy-2LYU;
	Fri, 10 Jul 2026 21:26:33 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIjs-00000005pNN-2bq0
	for kexec@lists.infradead.org;
	Fri, 10 Jul 2026 21:26:31 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2cd01a14e81so17922305ad.1
        for <kexec@lists.infradead.org>; Fri, 10 Jul 2026 14:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783718788; x=1784323588; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/hPVaDoRJAueZjNQ0NAjSyINZ2msgaXxj6lZgcfKzVg=;
        b=j020FToq2De6G9rsGJCe2l5sLrqfbJHEi2b0jybzqRk4PksYyjCySHe+oNkXE6UiA8
         iFAvhQe5n6xD1ncH2SMqItkJ9onQs+YcrnZfJNVVCGyW6sJrNp0Ex7MGcnRQZ5z9YH8A
         ylaPkEmlTrKKL8sh6l2r3FJBFQBhMqeit2d7D+QVG9N68sfQdMkEhQe2sQ+ugGZFOKWw
         vHm4GC0UVsuCs/uDG+iXHlev0adaUCBNX7jH9JijqlwmBmIPReeFBvZKAqGK8k7QWfUj
         JAMdyBDYiUCOIDIAxy01ONlA/w9/3Mdf/MCX/ILx8Pjqb/ovw9a4PMfmxHeNE8MmI8so
         fIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718788; x=1784323588;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/hPVaDoRJAueZjNQ0NAjSyINZ2msgaXxj6lZgcfKzVg=;
        b=L7qiRDHw8gt5nP0TCTguZV5Zuax15Dw7T37UPTL/LAYByxTdWY6T8B/afkK80wCOUH
         /v3Qnzp1oQfzZOWPFI6I+2KJj4O+EoW6hW6nxsuSRruonlonbfmL3nEJb4FuAP9PSbGM
         BzmfLRtKLDiovgL+qxJixoT9Cg7FVaiXBSu41euRtJy5I7miAYspt6Kkexs7FTaUHtha
         YzPCLJvUW2KWtByJ5gkjxYYFI7YDlK6QZv2vSM/ePyiWMX76dF8kZa2jGBj1aBZ4js4k
         /m8DWOZg8BFkzsJeXVG3rSGak7pztIQYlF28MAatz5GISIDTncmqgVvoBSEb0P8jtSOn
         zK0g==
X-Gm-Message-State: AOJu0YysTwiBjRzjd8BLKwHiUEdbUccdD6ZQn7ns5hz0yhsw63CevpJA
	WqlD6mq8VBUNLrwJqO9KmHRCwDaox+OJN0dkUU9P32xc08G8bce1O25NcqZBoJhgB/3WIcA2/QS
	nDh+9qed1RgFBDFoINoBZ9Vt8JQY/1rU0bIjnvBrmjcYEWLYoce3lDlJxg09SnZA1RXw/CWKxTz
	k8x4tbAOQPpvf6rGy6++9FKrcL/5bnOeYxru6jQRcSvVz6LHB6qVY=
X-Received: from plhu3.prod.google.com ([2002:a17:903:1243:b0:2cc:c59c:76ac])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e94e:b0:2ca:bf68:2a54 with SMTP id d9443c01a7336-2ce9f021408mr7596855ad.22.1783718787297;
 Fri, 10 Jul 2026 14:26:27 -0700 (PDT)
Date: Fri, 10 Jul 2026 21:26:08 +0000
In-Reply-To: <20260710212616.1351130-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710212616.1351130-6-dmatlack@google.com>
Subject: [PATCH v7 05/12] PCI: liveupdate: Keep bus numbers constant during
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
X-CRM114-CacheID: sfid-20260710_142628_673708_B0BF1ACD 
X-CRM114-Status: GOOD (  35.95  )
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
to enumerate devices below it until the Live Update is finished. This is
a safety measure to prevent topology conflicts.

Require that CONFIG_CARDBUS is not enabled to enable
CONFIG_PCI_LIVEUPDATE since inheriting bus numbers on PCI-to-CardBus
bridges requires additional work but is not a priority at the moment.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../admin-guide/kernel-parameters.txt         |   6 +-
 drivers/pci/Kconfig                           |   2 +-
 drivers/pci/liveupdate.c                      | 102 ++++++++++++++++++
 drivers/pci/liveupdate.h                      |  14 +++
 drivers/pci/probe.c                           |  17 ++-
 include/linux/pci_liveupdate.h                |   4 +
 6 files changed, 139 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4f65b2a37521..ed9eef8de64c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5105,7 +5105,11 @@ Kernel parameters
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
index 8af20f558086..16fbd4212e0f 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -273,7 +273,7 @@ config VGA_ARB_MAX_GPUS
 
 config PCI_LIVEUPDATE
 	bool "PCI Live Update Support"
-	depends on PCI && LIVEUPDATE && 64BIT
+	depends on PCI && LIVEUPDATE && 64BIT && !CARDBUS
 	help
 	  Enable PCI core support for preserving PCI devices across Live
 	  Update. This, in combination with support in a device's driver,
diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index a067632e70d1..b2b950d71657 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -86,6 +86,21 @@
  * bound to the correct driver. i.e. The PCI core does not protect against a
  * device getting preserved by driver A in the outgoing kernel and then getting
  * bound to driver B in the incoming kernel. This may change in the future.
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
+ * while there are preserved devices, its secondary and subordinate bus numbers
+ * will be cleared and devices below it will not be enumerated.
  */
 
 #define pr_fmt(fmt) "PCI: " KBUILD_BASENAME ": " fmt
@@ -436,6 +451,93 @@ static void pci_liveupdate_flb_put_incoming(void)
 	liveupdate_flb_put_incoming(&pci_liveupdate_flb);
 }
 
+/**
+ * pci_liveupdate_scan_bridge_begin() - Determine if a bridge should inherit bus numbers
+ * @bus: The parent bus of the bridge.
+ * @dev: The PCI bridge device.
+ * @pass: The scan pass (0 for first pass, 1 for second pass).
+ *
+ * This function is called by the PCI core when it begins scanning a bridge.
+ * It determines whether the bridge should inherit the secondary and subordinate
+ * bus numbers assigned to it by the previous kernel. This is necessary to
+ * keep bus numbers constant for preserved devices downstream of the bridge.
+ *
+ * Return: True if bus numbers should be inherited, false otherwise.
+ */
+bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus, struct pci_dev *dev,
+				      int pass)
+{
+	struct pci_dev *parent = bus->self;
+
+	/*
+	 * On the second pass, reuse the value that was set on the first pass
+	 * so that the passes are consistent with one another.
+	 */
+	if (pass)
+		return dev->liveupdate.inherit_buses;
+
+	/*
+	 * If the parent bridge is being forced to inherit its bus numbers
+	 * during this scan then this bridge must as well, otherwise the PCI
+	 * core could expand this bridge's reservation beyond its parent (which
+	 * cannot expand).
+	 */
+	if (parent && parent->liveupdate.inherit_buses) {
+		dev->liveupdate.inherit_buses = true;
+		return true;
+	}
+
+	/*
+	 * Otherwise, if there are any incoming preserved devices, force the
+	 * bus numbers to be inherited to avoid changing the bus numbers
+	 * assigned to those devices during enumeration.
+	 *
+	 * To keep things simple, inherit bus numbers on all bridges if any PCI
+	 * devices are incoming, to ensure that no bridge's reservation is
+	 * expanded to overlap with a preserved device downstream of a different
+	 * bridge.
+	 */
+	scoped_guard(rwsem_read, &pci_liveupdate.rwsem) {
+		struct pci_flb_incoming *incoming;
+
+		incoming = pci_liveupdate_flb_get_incoming();
+		if (!incoming) {
+			dev->liveupdate.inherit_buses = false;
+			return false;
+		}
+
+		/*
+		 * It is safe to sample incoming->ser->nr_devices and then
+		 * drop the rwsem since nr_devices will only decrease. Thus the
+		 * only "race" is that the current scan will be overly
+		 * conservative and force bus inheritance.
+		 */
+		dev->liveupdate.inherit_buses = !!incoming->ser->nr_devices;
+		pci_liveupdate_flb_put_incoming();
+	}
+
+	return dev->liveupdate.inherit_buses;
+}
+
+/**
+ * pci_liveupdate_scan_bridge_end() - Finish scanning a PCI bridge
+ * @dev: The PCI bridge device.
+ * @pass: The scan pass (0 for first pass, 1 for second pass).
+ *
+ * This function is called by the PCI core when it finishes scanning a bridge.
+ * It clears the inheritance status after the second pass so it can be
+ * re-evaluated on future scans.
+ */
+void pci_liveupdate_scan_bridge_end(struct pci_dev *dev, int pass)
+{
+	/*
+	 * Clear inherit_buses after the second pass so it can be re-evaluated
+	 * on future scans.
+	 */
+	if (pass)
+		dev->liveupdate.inherit_buses = false;
+}
+
 void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
 	struct pci_flb_incoming *incoming;
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index eaaa3559fd77..c763255a8de4 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -13,6 +13,9 @@
 #ifdef CONFIG_PCI_LIVEUPDATE
 void pci_liveupdate_setup_device(struct pci_dev *dev);
 void pci_liveupdate_cleanup_device(struct pci_dev *dev);
+bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus, struct pci_dev *dev,
+				      int pass);
+void pci_liveupdate_scan_bridge_end(struct pci_dev *dev, int pass);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -21,6 +24,17 @@ static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 {
 }
+
+static inline bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus,
+						    struct pci_dev *dev,
+						    int pass)
+{
+	return false;
+}
+
+static inline void pci_liveupdate_scan_bridge_end(struct pci_dev *dev, int pass)
+{
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5dc9d86e3597..165973bc92aa 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1397,6 +1397,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 				  int max, unsigned int available_buses,
 				  int pass)
 {
+	bool liveupdate, assign_new_buses = pcibios_assign_all_busses();
 	struct pci_bus *child;
 	u32 buses;
 	u16 bctl;
@@ -1406,6 +1407,10 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	u8 fixed_sec, fixed_sub;
 	int next_busnr;
 
+	liveupdate = pci_liveupdate_scan_bridge_begin(bus, dev, pass);
+	if (liveupdate)
+		assign_new_buses = false;
+
 	/*
 	 * Make sure the bridge is powered on to be able to access config
 	 * space of devices below it.
@@ -1449,8 +1454,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		goto out;
 	}
 
-	if ((secondary || subordinate) &&
-	    !pcibios_assign_all_busses() && !broken) {
+	if ((secondary || subordinate) && !assign_new_buses && !broken) {
 		unsigned int cmax, buses;
 
 		/*
@@ -1492,8 +1496,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		 * do in the second pass.
 		 */
 		if (!pass) {
-			if (pcibios_assign_all_busses() || broken)
-
+			if (assign_new_buses || broken)
 				/*
 				 * Temporarily disable forwarding of the
 				 * configuration cycles on all bridges in
@@ -1507,6 +1510,11 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 			goto out;
 		}
 
+		if (liveupdate) {
+			pci_err(dev, "Cannot reconfigure bridge during Live Update, skipping\n");
+			goto out;
+		}
+
 		/* Clear errors */
 		pci_write_config_word(dev, PCI_STATUS, 0xffff);
 
@@ -1567,6 +1575,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
 
 	pm_runtime_put(&dev->dev);
+	pci_liveupdate_scan_bridge_end(dev, pass);
 
 	return max;
 }
diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
index cfdc3d62ec02..2be98819e313 100644
--- a/include/linux/pci_liveupdate.h
+++ b/include/linux/pci_liveupdate.h
@@ -17,10 +17,14 @@
  * struct pci_liveupdate - PCI Live Update state for a struct pci_dev
  * @outgoing: State preserved for the next kernel.
  * @incoming: State preserved by the previous kernel.
+ * @inherit_buses: True if the PCI core should inherit the secondary and
+ *                 subordinate bus numbers assigned to this device due to
+ *                 an ongoing Live Update.
  */
 struct pci_liveupdate {
 	struct pci_dev_ser *outgoing;
 	struct pci_dev_ser *incoming;
+	bool inherit_buses;
 };
 
 struct pci_dev;
-- 
2.55.0.795.g602f6c329a-goog


