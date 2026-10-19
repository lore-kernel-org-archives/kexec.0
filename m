Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2D160A261E
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GZCtJkbX;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NTO5AdgR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=27szfxESPIZuT7PVf91SFMXZ+5PrRuOJzgCi66FtF/Q=; b=GZCtJkbXSVNAqhg1D3K2oScs9w
	IskOm9s0/iOLXDieSiZcFXmEsJFyCvIgidBn8lPow51y1BoRRJV62zecp+Jb+2QSeu6N11YBm8hxY
	GNZAZ8/zWu3DG5M5q58gdC0oVI6I2/VB4FO7VrfLiiziplCrsymumt4vIV3dWthSUuNcafQiV4D0x
	vK1cTBKHT5HzWztGxjUz53f+olqDYhoiwYq07Vf5qu5VCBsApJA2NCdun+nICp6rrwqftHy/r5pYZ
	+BCLIceC38XeSmzRN4puk91k60ML8zpLP3TSRtInf6f04VqNZOIj5X7EJfVCt8dU1UtKOlT203O3N
	zUX0allA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIuxE-00000008OBo-1Eoo;
	Mon, 19 Oct 2026 21:31:36 +0000
Received: from mail-pj1-x1045.google.com ([2607:f8b0:4864:20::1045])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIuxA-00000008O4t-0Nac
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 21:31:33 +0000
Received: by mail-pj1-x1045.google.com with SMTP id 98e67ed59e1d1-3aaf955db5fso4207001a91.0
        for <kexec@lists.infradead.org>; Mon, 19 Oct 2026 14:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792445490; x=1793050290; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=27szfxESPIZuT7PVf91SFMXZ+5PrRuOJzgCi66FtF/Q=;
        b=NTO5AdgRECyzHV4oUILkFWHN5OYgorxPqoXOZp+scGK2qWkMQRgQLSCITnhNnO3Cze
         8+HzrIHlmwqWHuWhaRTHPQI8sMAj2RGEeza/Kc2piqhDfMPooAZaPD80Em9kI4yGIltA
         HrGJJEJMIHBQbeZ03syjVKV02/Qz9DJr98qAUSTceZvbVxbqInLNjGAnEz4yrlg7iw9A
         TtS0bgse8Ll1sTP7vqE8hmzdViw0Ug4pQ2PQZHihKed+JOfd/rKcYl4X/YlsKWIJnegM
         OuF7iihbrOV4iZcC79jSBL9aRG7P6t347/BO73Z7QheSXEF8B18a7uBFIml+SSP+vsC+
         nyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445490; x=1793050290;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=27szfxESPIZuT7PVf91SFMXZ+5PrRuOJzgCi66FtF/Q=;
        b=YdkhvGyre7CnAH6ovganthnrTuE779cQsFfsohZmBxUCa7IZA3+IkdSnfLIkuwP3XN
         qCyDbxchmKThWF3K/tcO+Pt1ipMSXGo6al48CyQLPoNd1Q0cyKotcUmUmPY81v7EX7Cr
         oAz3eylRCjyIWnmglB3MlDhAytzRYlhfqCF+wj7yzjsDB6AL02w3I7f6OOYI0+cvbBIB
         paDKK+uBlG3w3rMgv1AS7tTMerBcD8MrP1jc63ShKbJZe2cjn3HOBk0V3yZ0l8hFFxRL
         KzwGPa7RVqAKIWBULnA63kntfuVpC/8yfjTnwVkY9K0klyDqQPuCXsJO5JF3w5Ch8b7p
         mdbw==
X-Gm-Message-State: AFq9FYJ/UXhjqxXRU4shkQwkux+CfA1ZSOl033c2tlSHoZwy7l3yoWDh
	sQRktna8vQ/fb/a8YujbK9hlNXYHXemkHRwq/RbwIPAb/iMxZ/L33sbqw1r6mUiAeAgYg3YX3lJ
	L6O7qXNFRUVQABr6tq/7TWWd16wK9L8bdXP5jx6K0n69+M8ZixCduEf6jpyYhazrrVYwMOfe0AC
	VeDpRUC2a68DrfvVZzrPGJ1hLbCOkeeEz02/B9PQQLmb8CpETL+IA=
X-Received: from pgbm24-n2.prod.google.com ([2002:a05:6a02:6198:20b0:cc7:c2bc:cc73])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4d06:b0:3a6:e159:a233 with SMTP id 98e67ed59e1d1-3aceefae03fmr7921990a91.43.1792445489657;
 Mon, 19 Oct 2026 14:31:29 -0700 (PDT)
Date: Mon, 19 Oct 2026 21:30:54 +0000
In-Reply-To: <20261019213054.3157159-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261019213054.3157159-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019213054.3157159-11-dmatlack@google.com>
Subject: [PATCH 10/10] PCI: liveupdate: Avoid enabling INTx on incoming devices
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	David Matlack <dmatlack@google.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_143132_202862_9F410971 
X-CRM114-Status: GOOD (  30.07  )
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
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Avoid clearing PCI_COMMAND_INTX_DISABLE on incoming preserved devices.
Pass whether INTx masking is broken on each preserved device to the
next kernel instead of probing it, and skip clearing
PCI_COMMAND_INTX_DISABLE in do_pci_enable_device() for incoming
devices.

Clearing PCI_COMMAND_INTX_DISABLE enables INTx on the device, even if
only temporarily. pci_intx_mask_broken() probes whether INTx masking
works by toggling PCI_COMMAND_INTX_DISABLE during enumeration, and
do_pci_enable_device() clears it when a device that is not using MSI or
MSI-X is enabled. A preserved device may assert INTx at any point
during the Live Update, before its driver in the next kernel has set up
interrupt handling, so enabling INTx could result in interrupts that
no handler claims, on a line that may be shared with other devices.

Pass the result of probing as a new bit in the probed results in
struct pci_dev_ser, PCI_DEV_SER_PROBED_BROKEN_INTX_MASKING, which
reflects struct pci_dev::broken_intx_masking. If the previous kernel
did not pass it, fall back to probing INTx masking.

Drivers bound to incoming devices are responsible for enabling INTx once
they are ready to handle it. pci_alloc_irq_vectors() already does so
with pci_intx() when it falls back to INTx, and vfio-pci clears
PCI_COMMAND_INTX_DISABLE itself in vfio_pci_core_enable().

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c    | 37 ++++++++++++++++++++++++++++++++++++-
 drivers/pci/liveupdate.h    |  6 ++++++
 drivers/pci/pci.c           |  8 ++++++++
 drivers/pci/probe.c         | 10 ++++++++++
 include/linux/kho/abi/pci.h |  3 +++
 5 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index ac4525568818..8a74762c3f7d 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -216,6 +216,11 @@
  *    bridge implements), since that would disrupt memory transactions
  *    targeting the device or devices below it. Instead, the previous kernel
  *    passes the results of probing in struct pci_dev_ser.
+ *
+ *  * The PCI core does not enable INTx (i.e. clear PCI_COMMAND_INTX_DISABLE)
+ *    on incoming preserved devices, neither while probing whether INTx masking
+ *    works nor when the device is enabled, since the device could then raise
+ *    interrupts before its driver is ready to handle them.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -650,7 +655,11 @@ static void pci_liveupdate_save_bar_masks(struct pci_dev *dev,
 static void pci_liveupdate_preserve_probed(struct pci_dev *dev,
 					   struct pci_dev_ser *dev_ser)
 {
-	u64 supported = 0, probed = 0;
+	u64 supported = PCI_DEV_SER_PROBED_BROKEN_INTX_MASKING;
+	u64 probed = 0;
+
+	if (dev->broken_intx_masking)
+		probed |= PCI_DEV_SER_PROBED_BROKEN_INTX_MASKING;
 
 	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
 		supported |= PCI_DEV_SER_PROBED_WINDOWS;
@@ -1213,6 +1222,32 @@ int pci_liveupdate_read_bridge_windows(struct pci_dev *bridge)
 	return 0;
 }
 
+/**
+ * pci_liveupdate_intx_mask_broken() - Get whether INTx masking is broken on an
+ *                                     incoming device
+ * @dev: The PCI device
+ *
+ * Get whether INTx masking is broken on @dev as determined by the previous
+ * kernel, so that INTx masking does not need to be probed.
+ *
+ * Return: 1 if INTx masking is broken, 0 if it is not, or -ENODATA if @dev is
+ * not incoming-preserved or the previous kernel did not pass whether INTx
+ * masking is broken on @dev.
+ */
+int pci_liveupdate_intx_mask_broken(struct pci_dev *dev)
+{
+	u64 probed;
+
+	guard(rwsem_read)(&pci_liveupdate.rwsem);
+
+	if (!pci_liveupdate_read_probed(dev,
+					PCI_DEV_SER_PROBED_BROKEN_INTX_MASKING,
+					&probed))
+		return -ENODATA;
+
+	return !!probed;
+}
+
 /*
  * Check if the windows of @bridge have been read from hardware. Outside of x86
  * that does not happen during scanning.
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index 98d23e217308..7f86cc85deee 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -22,6 +22,7 @@ bool pci_liveupdate_is_outgoing(struct pci_dev *dev);
 int pci_liveupdate_read_bar_masks(struct pci_dev *dev, unsigned int nr_bars,
 				  u32 *bar_masks, u32 *rom_mask);
 int pci_liveupdate_read_bridge_windows(struct pci_dev *bridge);
+int pci_liveupdate_intx_mask_broken(struct pci_dev *dev);
 void pci_liveupdate_claim_bus_resources(struct pci_bus *bus);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
@@ -74,6 +75,11 @@ static inline int pci_liveupdate_read_bridge_windows(struct pci_dev *bridge)
 	return -EINVAL;
 }
 
+static inline int pci_liveupdate_intx_mask_broken(struct pci_dev *dev)
+{
+	return -EINVAL;
+}
+
 static inline void pci_liveupdate_claim_bus_resources(struct pci_bus *bus)
 {
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 853c84a2c782..43af72d1e5c9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2184,6 +2184,14 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	if (dev->msi_enabled || dev->msix_enabled)
 		return 0;
 
+	/*
+	 * Leave INTx disabled on devices preserved across Live Update, since
+	 * the device could raise interrupts before its driver is ready. It is
+	 * up to the driver to enable INTx once it is ready.
+	 */
+	if (pci_liveupdate_is_incoming(dev))
+		return 0;
+
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (pin) {
 		pci_read_config_word(dev, PCI_COMMAND, &cmd);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a53d0077a08b..badce31b34f8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1976,6 +1976,16 @@ static u8 pci_hdr_type(struct pci_dev *dev)
 static int pci_intx_mask_broken(struct pci_dev *dev)
 {
 	u16 orig, toggle, new;
+	int ret;
+
+	/*
+	 * Toggling PCI_COMMAND_INTX_DISABLE could let a device preserved across
+	 * Live Update raise interrupts before its driver is ready, so use the
+	 * result determined by the previous kernel for those devices.
+	 */
+	ret = pci_liveupdate_intx_mask_broken(dev);
+	if (ret >= 0)
+		return ret;
 
 	pci_read_config_word(dev, PCI_COMMAND, &orig);
 	toggle = orig ^ PCI_COMMAND_INTX_DISABLE;
diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
index 84a1bf71eeca..badcf2f01be7 100644
--- a/include/linux/kho/abi/pci.h
+++ b/include/linux/kho/abi/pci.h
@@ -95,10 +95,13 @@ struct pci_dev_ser {
  *    window.
  *  * PCI_DEV_SER_PROBED_PREF_64_WINDOW: The bridge's prefetchable memory
  *    window is 64-bit.
+ *  * PCI_DEV_SER_PROBED_BROKEN_INTX_MASKING: INTx masking cannot be used on
+ *    the device, i.e. struct pci_dev::broken_intx_masking is set.
  */
 #define PCI_DEV_SER_PROBED_IO_WINDOW		BIT_ULL(0)
 #define PCI_DEV_SER_PROBED_PREF_WINDOW		BIT_ULL(1)
 #define PCI_DEV_SER_PROBED_PREF_64_WINDOW	BIT_ULL(2)
+#define PCI_DEV_SER_PROBED_BROKEN_INTX_MASKING	BIT_ULL(3)
 
 /*
  * The size of struct pci_dev_ser when this ABI was introduced. Since fields
-- 
2.56.0.212.g129ede20d9-goog


