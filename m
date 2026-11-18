Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AC060A6F63
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 22:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qNnNYXJz;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NkJhfDJz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=BGyTYvu/JftJxBMsp5VYPQ/HUeGWqv9z5FyQtv5WTl8=; b=qNnNYXJzWJXZMaINh80XDPSZCI
	8m48HS0I5VKpWf2qfHNHQXjD9tTEvfnxBfH/l//9wI/19y7IC3XijlZVpuQB4a6GuXrAygnmCETPi
	5AT/nA1eWM/iQEgX5vkrm2InARlwezGKLTvDuu/3LfhmHq7wURXuwolo0m+q+KVlpVkpBqhatQDx2
	+Jhq9jCju6+geAF0mGO4YmqcU1x8PsZ+t5vWfPVYd866vhVOR6IBJNWb87Cdf9wjjNLsvA44VWYdR
	YLCQK8rtvjfAW/KhViMlTuyu0ChBASI0JMKAimtiNDylPoTYLYRD6YqzcAO129C19WsURELwlmjAC
	qCXFerZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xToHJ-0000000AQ32-374E;
	Wed, 18 Nov 2026 22:37:21 +0000
Received: from mail-oa1-x46.google.com ([2001:4860:4864:20::46])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xToHE-0000000APu6-2Ogu
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 22:37:18 +0000
Received: by mail-oa1-x46.google.com with SMTP id 586e51a60fabf-4a68926c8c4so1137281fac.0
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 14:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795041435; x=1795646235; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BGyTYvu/JftJxBMsp5VYPQ/HUeGWqv9z5FyQtv5WTl8=;
        b=NkJhfDJz8e1EAFgue2MohKB6SJ2qvOC4HtO9SCcMqZlSUTEp3phC6XcbamhwI2rEbT
         kxtM2LIcBjEQ9OAwE2WrBHK415GUd+3YuNu6OkxHi1p7WzFEN4K+6J7RjFz7hj2S0g41
         +CsNJoQVYn3YEuccFeQNh/GwYvBxH8MHhHeXfk81rvZmzJ8tOwU5nYP5CJCk4I3sDIdp
         yyEnbFqV92BvVIQfYLqVy84OEon1yaVAJo+yxGS6hvtnJTY0qhFkus3FW1n4u3tE6E/G
         XNVrT3aGHWKAgfoPHLywOBe+hk/5KJwQ8I5Sxbi84TxkmWENGJTMY6Kq3qYTs47Sbb9F
         2y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795041435; x=1795646235;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BGyTYvu/JftJxBMsp5VYPQ/HUeGWqv9z5FyQtv5WTl8=;
        b=G3DIkR8SVKwFAHIRMex6rwSFSvxg2hLayBT3rpbaupjyI9u8XMcglTNn++MlbeP3Cr
         TKexPPIc645Sqx3V2CLmAcsPmC2Q7tVEQJVZYNaAscSWNGxvgiBU5I8bIbMZfTNypU5f
         6TwqbIyEH5VUq9S2NE20hIKE0VRIBZCMLdM0O+n1ynh1QXOs9td1itRl4DIYFe6B133N
         2Crj/ai3BRUUW2cD5nzPqnIn+AO5jUXKlJVqUrkCYqS2IGcMn73UdcG0Jvwkd+fSWiHe
         FS/GKQPs6HSNo8/ZoHpse6+jSnu7AkMb2O0tvuhQkLgbA9qv2KxTK5CStmLPtgf+qHHF
         weVg==
X-Gm-Message-State: APuU4Z9uoAWeol30sIAcGnR6F6VJCYtsxx1HDmW0K1DOOB2A7/cQ6Xj2
	tOhluNINTyML4x99S456Fz3GlUgtsziGMGTZ6WUNMMGlywdOMVONDFFxdUygcZkY9ajoYtDxz5k
	PFrVPCFomrz5hPQcoxlrSfLHHM+Zta1epaZS39cS34At9IOlkrWijW2hr3SxdZwL6vps3p0dK+l
	MYF933YcegJT9XfXY1WhQNxgPlbl4n83l+2rgs+aN0EXuzqwzMyQU=
X-Received: from oackp8.prod.google.com ([2002:a05:6871:9e08:b0:49e:2cc3:427])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:687c:2c4a:b0:4b9:685c:1942 with SMTP id 586e51a60fabf-4b9685c2eb5mr1963935fac.41.1795041434805;
 Wed, 18 Nov 2026 14:37:14 -0800 (PST)
Date: Wed, 18 Nov 2026 22:36:57 +0000
In-Reply-To: <20261118223704.3286085-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261118223704.3286085-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118223704.3286085-7-dmatlack@google.com>
Subject: [PATCH v11 06/13] PCI: liveupdate: Preserve bus numbers during Live Update
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
X-CRM114-CacheID: sfid-20261118_143717_028209_0DF9D64E 
X-CRM114-Status: GOOD (  31.80  )
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

Keep the secondary and subordinate bus numbers that the previous kernel
programmed into bridges, rather than assigning new ones, if the previous
kernel preserved any device across a Live Update. Do this even when
pcibios_assign_all_busses() is true, e.g. with pci=assign-busses.

Preserved devices must be allowed to continue performing memory
transactions across a Live Update, so the kernel cannot change the
fabric topology. Changing the bus numbers of a bridge changes the
Requester IDs of the devices below it, which would require disabling and
flushing any in-flight memory transactions first.

Apply the policy globally rather than only to the paths that contain
preserved devices. Bus numbers have to be preserved above a preserved
device anyway, since an upstream bridge cannot expand its window. A
global policy matches the scope of pcibios_assign_all_busses(), and
gives an answer that cannot change part way through the two passes of a
bridge scan.

Bridges that do not have bus numbers are still assigned new ones, so
hot-adding a bridge keeps working, both during and after a Live Update.
The two-pass bridge scan guarantees such bridges are only assigned bus
numbers above those already claimed by preserved bridges.

The exception is a bridge that was preserved but comes up without a
valid bus number configuration, e.g. because it was reset during kexec.
Refuse to assign it new bus numbers, since that would silently change
the BDF of every preserved device in its hierarchy. Also refuse to
assign bus numbers to the other bridges on the same bus, since the bus
numbers of the failed bridge can no longer be read from hardware and
handing them out would let an unrelated device inherit the BDF of a
preserved device.

Make PCI_LIVEUPDATE depend on !CARDBUS, since preserving bus numbers on
CardBus bridges is not implemented.

Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 +-
 drivers/pci/Kconfig                           |  2 +-
 drivers/pci/liveupdate.c                      | 81 +++++++++++++++++++
 drivers/pci/liveupdate.h                      | 13 +++
 drivers/pci/probe.c                           | 11 ++-
 include/linux/pci_liveupdate.h                |  5 ++
 6 files changed, 112 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd9..d1ef1c93ec96 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5129,7 +5129,11 @@ Kernel parameters
 				explicitly which ones they are.
 		assign-busses	[X86] Always assign all PCI bus
 				numbers ourselves, overriding
-				whatever the firmware may have done.
+				whatever the firmware may have done. Ignored
+				if the previous kernel preserved any PCI
+				device across a Live Update, since bus
+				numbers must not change while those devices
+				are doing DMA.
 		usepirqmask	[X86] Honor the possible IRQ mask stored
 				in the BIOS $PIR table. This is needed on
 				some systems with broken BIOSes, notably
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index c37e68a6591a..f043776910fb 100644
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
index ad2bb73e1d05..00d6fa5236e9 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -148,6 +148,32 @@
  * This lets the PCI core keep the bridges above preserved devices forwarding
  * their memory transactions, without changes in routing, throughout the Live
  * Update.
+ *
+ * BDF Stability
+ * =============
+ *
+ * The PCI core guarantees that preserved devices can be identified by the same
+ * bus, device, and function numbers for as long as they are preserved
+ * (including across kexec). To accomplish this, the PCI core keeps the
+ * secondary and subordinate bus numbers that the previous kernel programmed
+ * into bridges, if the previous kernel preserved any device. This is true even
+ * if the kernel would otherwise reassign all bus numbers, e.g. with
+ * pci=assign-busses. The PCI core trusts the bus numbers programmed by the
+ * previous kernel.
+ *
+ * Bridges that do not have bus numbers are assigned new ones as usual, so
+ * hot-adding a bridge keeps working, both during and after a Live Update. The
+ * two-pass bridge scan ensures such bridges are only assigned bus numbers above
+ * those already claimed by preserved bridges.
+ *
+ * If a preserved bridge comes up without a valid bus number configuration, e.g.
+ * because it was reset during kexec, the PCI core refuses to assign it new bus
+ * numbers and does not enumerate anything below it. Assigning new bus numbers
+ * would silently change the BDF of every preserved device in its hierarchy. The
+ * PCI core also stops assigning bus numbers to the other bridges on the same
+ * bus, since the bus numbers of the failed bridge can no longer be read from
+ * hardware and handing them to another bridge would let an unrelated device
+ * inherit the BDF of a preserved device.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -168,9 +194,13 @@
  * struct pci_liveupdate_global - Global state for PCI Live Update support
  * @rwsem: Reader/writer semaphore used to protect the incoming and outgoing
  *         FLBs, and the references to them in struct pci_dev.
+ * @had_incoming: True if the previous kernel preserved at least one PCI device.
+ *                Set when the incoming FLB is retrieved and never cleared, so
+ *                it stays true after Live Update finishes.
  */
 struct pci_liveupdate_global {
 	struct rw_semaphore rwsem;
+	bool had_incoming;
 };
 
 static struct pci_liveupdate_global pci_liveupdate = {
@@ -341,6 +371,9 @@ static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
 			      ret);
 	}
 
+	if (!xa_empty(&incoming->xa))
+		pci_liveupdate.had_incoming = true;
+
 	args->obj = incoming;
 	return 0;
 }
@@ -629,6 +662,52 @@ static void pci_liveupdate_flb_put_incoming(void)
 	liveupdate_flb_put_incoming(&pci_liveupdate_flb);
 }
 
+/**
+ * pci_liveupdate_preserve_bus_numbers() - Check whether to keep bus numbers
+ *
+ * Bus numbers are preserved on every bridge, for the lifetime of the kernel, if
+ * the previous kernel preserved any device. The incoming FLB is retrieved while
+ * setting up the first device, before any bridge is scanned, so the answer does
+ * not change during enumeration. See "BDF Stability" in the PCI Live Update
+ * documentation.
+ *
+ * Return: True if the PCI core should keep the bus numbers that the previous
+ * kernel programmed into bridges, false otherwise.
+ */
+bool pci_liveupdate_preserve_bus_numbers(void)
+{
+	return pci_liveupdate.had_incoming;
+}
+
+/**
+ * pci_liveupdate_refuse_bus_numbers() - Check for unsafe bus number assignment
+ * @bus: The PCI bus the bus numbers would be assigned from.
+ * @dev: The PCI bridge device the bus numbers would be assigned to.
+ *
+ * A bridge that was preserved by the previous kernel but came up without a
+ * valid bus number configuration has no child bus after the first pass of the
+ * bridge scan. Bus numbers must not be assigned from @bus while such a bridge
+ * is on it, including to the failed bridge itself. See "BDF Stability" in the
+ * PCI Live Update documentation.
+ *
+ * Return: True if @dev must not be assigned bus numbers, false otherwise.
+ */
+bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus, struct pci_dev *dev)
+{
+	struct pci_dev *bridge;
+
+	for_each_pci_bridge(bridge, bus) {
+		if (!bridge->liveupdate.was_incoming || bridge->subordinate)
+			continue;
+
+		pci_err(dev, "Not assigning bus numbers, preserved bridge %s lost its bus number configuration\n",
+			pci_name(bridge));
+		return true;
+	}
+
+	return false;
+}
+
 void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
 	struct pci_flb_incoming *incoming;
@@ -657,6 +736,8 @@ void pci_liveupdate_setup_device(struct pci_dev *dev)
 
 	pci_info(dev, "Device was preserved by previous kernel across Live Update\n");
 	dev->liveupdate.incoming = dev_ser;
+	dev->liveupdate.was_incoming = true;
+
 	pci_liveupdate_flb_put_incoming();
 }
 
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index eaaa3559fd77..e5d2a19d2ca2 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -13,6 +13,8 @@
 #ifdef CONFIG_PCI_LIVEUPDATE
 void pci_liveupdate_setup_device(struct pci_dev *dev);
 void pci_liveupdate_cleanup_device(struct pci_dev *dev);
+bool pci_liveupdate_preserve_bus_numbers(void);
+bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus, struct pci_dev *dev);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -21,6 +23,17 @@ static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 {
 }
+
+static inline bool pci_liveupdate_preserve_bus_numbers(void)
+{
+	return false;
+}
+
+static inline bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus,
+						     struct pci_dev *dev)
+{
+	return false;
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a70a6d2b6da5..222ad696a158 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1400,6 +1400,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 				  int max, unsigned int available_buses,
 				  int pass)
 {
+	bool preserve_bus_numbers = !pcibios_assign_all_busses() ||
+				    pci_liveupdate_preserve_bus_numbers();
 	struct pci_bus *child;
 	u32 buses;
 	u16 bctl;
@@ -1452,8 +1454,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		goto out;
 	}
 
-	if ((secondary || subordinate) &&
-	    !pcibios_assign_all_busses() && !broken) {
+	if ((secondary || subordinate) && preserve_bus_numbers && !broken) {
 		unsigned int cmax, buses;
 
 		/*
@@ -1495,8 +1496,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		 * do in the second pass.
 		 */
 		if (!pass) {
-			if (pcibios_assign_all_busses() || broken)
-
+			if (!preserve_bus_numbers || broken)
 				/*
 				 * Temporarily disable forwarding of the
 				 * configuration cycles on all bridges in
@@ -1510,6 +1510,9 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 			goto out;
 		}
 
+		if (pci_liveupdate_refuse_bus_numbers(bus, dev))
+			goto out;
+
 		/* Clear errors */
 		pci_write_config_word(dev, PCI_STATUS, 0xffff);
 
diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
index 710026ada2d5..d45a5b524909 100644
--- a/include/linux/pci_liveupdate.h
+++ b/include/linux/pci_liveupdate.h
@@ -17,10 +17,15 @@
  * struct pci_liveupdate - PCI Live Update state for a struct pci_dev
  * @outgoing: State preserved for the next kernel.
  * @incoming: State preserved by the previous kernel.
+ * @was_incoming: True if this struct pci_dev was incoming-preserved when it was
+ *                set up, i.e. it was matched to state preserved by the previous
+ *                kernel. Unlike @incoming, this is never cleared, so it stays
+ *                true after the device finishes participating in Live Update.
  */
 struct pci_liveupdate {
 	struct pci_dev_ser *outgoing;
 	struct pci_dev_ser *incoming;
+	bool was_incoming;
 };
 
 struct pci_dev;
-- 
2.56.1.703.gf848ed807c-goog


