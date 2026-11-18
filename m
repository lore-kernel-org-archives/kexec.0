Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D164760A3831
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sY/Fo8hh;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BASzssFF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oogi1IuxljkWoCxT47fWoq1+fkqIxOYvkLnAyW3qmBw=; b=sY/Fo8hhZZCY+V3GCJ+W16/ZGj
	7S2o1tk+TCx8ikR7rJPAA+zrEC6gPe7enkZVZ6OrBjd6L5RHbVPqWgZbArR72+4tTUH8HfLo5EH3W
	4qZVA73UDt1JIFYg45nBtsKDn3it0fTE3gYOacTyjDcortf/orZMxYZvIG7HEhJzK2Xfw25aV4BLn
	erW1X8i7yVjaY6VykYADx/o86j8Z9pxrvqZqixqTX5Ku5C1hF2nd8mVOTZXJurMZlV4GzJVzN/1of
	5RjPYSbD9QWa3Sy2NhMVQ8x7XmxmvKCfaMl18l1gh3hZFOFnMedAXDrvFX3714iOGZdQYsxym2Ss4
	3xwzhY6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xToHE-0000000APur-2Jti;
	Wed, 18 Nov 2026 22:37:16 +0000
Received: from mail-oi1-x246.google.com ([2607:f8b0:4864:20::246])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xToHB-0000000APqq-11AG
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 22:37:14 +0000
Received: by mail-oi1-x246.google.com with SMTP id 5614622812f47-4c7f887ac6bso1889524b6e.3
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 14:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795041431; x=1795646231; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oogi1IuxljkWoCxT47fWoq1+fkqIxOYvkLnAyW3qmBw=;
        b=BASzssFFyo2SvBcoiI+0ugj0My0PIiDnb0+KR/pta/GApSgZespgtvpNDkebOKjGXN
         DAtk2xUxGeDxWbF35o0DQXPExMAH68N0j9sbS97vQi7I8jprikHsZyrt9PX29PlIQR3M
         eXHOx4gcsicjo/wfboKmFPTumvnFVU/sRxBZbT86k6Zj1JNHTZYvoQ+i2BAAgHawVa/r
         dHqKhyjoK7cy66cWCcEG4zD3aEG9NxBcd7JguW1JupgkeExl+At1lwvlcbNNst0IxEwt
         5kWoURxu4KemcWJCpC83H32U3iCIJfAxOed0i53Bjkah+1XxNXQ1ciQu2gDw8/gDgjVx
         8Dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795041431; x=1795646231;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oogi1IuxljkWoCxT47fWoq1+fkqIxOYvkLnAyW3qmBw=;
        b=buVJTokrzu2GkKn0IrLxahpSZSjVuaGyZYvgPYZPH8MRzwX7+aDIrSkZ+UwULWx/h0
         azLUejeUUxDJb1YIuV3JknvSf3bQqsmPDkHPOY2cjun1CWABQ2VChpYhRnc53TS9LhoQ
         jMZyCRTmwHp8NEMAmP7VLL78l0ypcZeGvsQgxzS1dlKnBQQB4/XzZ8rjEMx2edDgnLbS
         yRkwfbmG3mXssTNWGKK5iGYRSBbFowh5/nEkZwOSdObOd+RJlKgOhrboe9nHQBsaTaWx
         1P32qe7ehD9vp9925jjnVGvLuGDeW+mkMPEA//+ro0DMXti9F141xGj7nGiZ153iRWkF
         aj0w==
X-Gm-Message-State: APuU4Z+t5lfvnrpXi92EXbWt0ItnMY4E0GxuE5UNGwUwUOGF5omHbPM3
	Ksmk7n92WWqSjob+igSXD9K28RTIeOXiT7w+FpRfsxNQfnFbIKpGz3xplEVzWN1ZDQb01j3Q7kr
	R8sQWDrlc8dg3PmmsEZNMjvrvPZWrg8bWwvlTQBev9E3fpuaIIk7Eg6G9NBX8tNiqpCVvCLJ1K9
	/JDtr0PXdYPsAVydxTtpLLQwldzZPzbHrgFjD1Egr28GJsa+H+CVM=
X-Received: from ilse6.prod.google.com ([2002:a05:6e02:4a6:b0:53c:d564:3a52])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:6f81:b0:577:2888:47b3 with SMTP id 5614622812f47-57742e34681mr4186430b6e.44.1795041431054;
 Wed, 18 Nov 2026 14:37:11 -0800 (PST)
Date: Wed, 18 Nov 2026 22:36:54 +0000
In-Reply-To: <20261118223704.3286085-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261118223704.3286085-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118223704.3286085-4-dmatlack@google.com>
Subject: [PATCH v11 03/13] PCI: liveupdate: Track incoming preserved PCI devices
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
X-CRM114-CacheID: sfid-20261118_143713_342538_791AD870 
X-CRM114-Status: GOOD (  37.03  )
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

Identify devices that the previous kernel preserved across Live Update
("incoming" devices) when they are enumerated, and add
pci_liveupdate_finish() and pci_liveupdate_is_incoming() for drivers.

The previous kernel passes state about the devices it preserved across
kexec, and the PCI core needs this state to know which devices require
special handling.

Add pci_liveupdate_setup_device(), which is called during device setup
to fetch the serialized state (struct pci_ser) from the Live Update
Orchestrator. The first time this happens, pci_flb_retrieve() runs and
loads the struct pci_dev_ser entries into an xarray so that they can be
looked up efficiently.

If a device is found in the xarray, the PCI core stores a pointer to its
state in dev->liveupdate.incoming until the driver calls
pci_liveupdate_finish(). This pointer allows the PCI core and drivers to
apply Live Update-specific logic to incoming devices in subsequent
commits.

Drivers can check if a device is an incoming preserved device (e.g.
during probe) by calling pci_liveupdate_is_incoming().

Any error in pci_flb_retrieve() is fatal, since the previous kernel
handed off devices that are still performing DMA and this kernel cannot
safely take them over without their state. This includes the previous
kernel setting a bit in required_flags that this kernel does not know
how to handle, and struct pci_dev_ser entries that are smaller than
PCI_DEV_SER_MIN_SIZE. Fields appended to struct pci_dev_ser by the
previous kernel are ignored.

pci_flb_finish() panics if any preserved device was never finished,
since that means a driver failed to call pci_liveupdate_finish().

Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/liveupdate.c       | 261 +++++++++++++++++++++++++++++++--
 drivers/pci/liveupdate.h       |   5 +
 drivers/pci/probe.c            |   3 +
 include/linux/pci_liveupdate.h |  13 ++
 4 files changed, 273 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index d6f2ea4c23ce..b569093bea75 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -45,6 +45,11 @@
  * it (e.g. during enumeration), and pci_flb_finish() frees it once the PCI
  * core is done with it.
  *
+ * State handed over by the previous kernel is trusted. The PCI core validates
+ * it only far enough to detect an incompatible or corrupt handover, and makes
+ * no attempt to defend against deliberate modification, since a previous kernel
+ * able to corrupt preserved state is able to corrupt arbitrary memory anyway.
+ *
  * Call Flow
  * ---------
  *
@@ -69,14 +74,17 @@
  *
  *   # ---------------- kexec ----------------
  *
- *   # New kernel: the PCI core asks for the previous kernel's state
- *   liveupdate_flb_get_incoming()
- *     luo_flb_retrieve_one()             # first request only
- *       pci_flb_retrieve()               # previous kernel's struct pci_ser
+ *   # New kernel: PCI enumeration
+ *   pci_setup_device()
+ *     pci_liveupdate_setup_device()
+ *       liveupdate_flb_get_incoming()
+ *         luo_flb_retrieve_one()         # first request only
+ *           pci_flb_retrieve()           # previous kernel's struct pci_ser
  *
  *   # Userspace: ioctl(LIVEUPDATE_SESSION_FINISH)
  *   luo_file_finish_one()
  *     fh->ops->finish()                  # driver callback
+ *       pci_liveupdate_finish(dev)       # release this device's pci_dev_ser
  *     luo_flb_file_finish()
  *       liveupdate_flb_put_incoming()    # last incoming file only
  *         pci_flb_finish()               # free struct pci_ser
@@ -93,6 +101,20 @@
  * This allows the PCI core to keep its FLB data (struct pci_ser) up to date
  * with the list of **outgoing** preserved devices for the next kernel.
  *
+ * After kexec, whenever a device is enumerated, the PCI core looks it up in the
+ * incoming FLB data (struct pci_ser) to see if it is an **incoming** preserved
+ * device (i.e. preserved by the previous kernel).
+ *
+ * Drivers must notify the PCI core when an **incoming** device is done
+ * participating in the incoming Live Update with the following API:
+ *
+ *  * ``pci_liveupdate_finish(pci_dev)``
+ *
+ * The PCI core does not enforce any ordering of ``pci_liveupdate_finish()`` and
+ * ``pci_liveupdate_preserve()``, i.e., a PCI device can be **outgoing**
+ * (preserved for next kernel) and **incoming** (preserved by previous kernel)
+ * at the same time.
+ *
  * Restrictions
  * ============
  *
@@ -140,13 +162,39 @@ struct pci_flb_outgoing {
 	struct kho_block_set block_set;
 };
 
+/**
+ * struct pci_flb_incoming - Incoming PCI FLB object
+ * @ser: The incoming struct pci_ser from the previous kernel.
+ * @xa: Xarray used to quickly lookup devices in @ser.
+ * @block_set: The KHO block set holding the incoming devices.
+ */
+struct pci_flb_incoming {
+	struct pci_ser *ser;
+	struct xarray xa;
+	struct kho_block_set block_set;
+};
+
+/*
+ * Bits in struct pci_ser::required_flags that this kernel knows how to handle.
+ * No flags are currently defined.
+ */
+#define PCI_SER_REQUIRED_FLAGS_SUPPORTED	0ULL
+
+/* PCI_LIVEUPDATE depends on 64BIT, so domain and bdf always fit. */
+static unsigned long pci_ser_xa_key(u32 domain, u16 bdf)
+{
+	return (unsigned long)domain << 16 | bdf;
+}
+
 /*
  * Panic if any struct pci_dev_ser in @block_set is still in use, i.e. some
- * driver failed to call pci_liveupdate_unpreserve(). This runs once the last
- * reference to the FLB is dropped, so no unpreserve can be in flight.
+ * driver failed to call pci_liveupdate_unpreserve() (outgoing) or
+ * pci_liveupdate_finish() (incoming). This runs once the last reference to the
+ * FLB is dropped, so no unpreserve or finish can be in flight.
  *
  * Report the devices from the FLB rather than by walking struct pci_dev, so
- * that devices that were destroyed while preserved are identified as well.
+ * that devices that never showed up after kexec, or that were destroyed while
+ * preserved, are identified as well.
  */
 static void pci_check_all_devices_released(struct pci_ser *ser,
 					   struct kho_block_set *block_set)
@@ -211,17 +259,78 @@ static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
 	kfree(outgoing);
 }
 
+/*
+ * Any failure here is fatal. The previous kernel handed over devices that are
+ * still performing DMA, and this kernel cannot identify them without this
+ * state. Continuing would let the PCI core reassign bus numbers and rebind
+ * drivers underneath live devices, so fail loudly instead of unwinding.
+ */
 static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
 {
+	struct pci_ser *ser = phys_to_virt(args->data);
+	struct pci_flb_incoming *incoming;
+	struct pci_dev_ser *dev_ser;
+	struct kho_block_set_it it;
+	int ret;
+
 	pr_debug("Retrieving struct pci_ser (0x%llx)\n", args->data);
-	args->obj = phys_to_virt(args->data);
+
+	if (ser->required_flags & ~PCI_SER_REQUIRED_FLAGS_SUPPORTED)
+		panic("Incoming PCI FLB requires unsupported features (0x%llx)\n",
+		      ser->required_flags & ~PCI_SER_REQUIRED_FLAGS_SUPPORTED);
+
+	/*
+	 * The previous kernel may have appended fields to struct pci_dev_ser,
+	 * which this kernel ignores, but every entry must be at least the
+	 * minimum size.
+	 */
+	if (ser->dev_ser_size < PCI_DEV_SER_MIN_SIZE)
+		panic("Incoming PCI FLB has unsupported struct pci_dev_ser size (%u)\n",
+		      ser->dev_ser_size);
+
+	incoming = kzalloc_obj(*incoming);
+	if (!incoming)
+		panic("Failed to allocate struct pci_flb_incoming\n");
+
+	incoming->ser = ser;
+	xa_init(&incoming->xa);
+
+	kho_block_set_init(&incoming->block_set, ser->dev_ser_size);
+	ret = kho_block_set_restore(&incoming->block_set, ser->devices);
+	if (ret)
+		panic("Failed to restore devices KHO block set (%d)\n", ret);
+
+	kho_block_set_it_init(&it, &incoming->block_set);
+	while ((dev_ser = kho_block_set_it_read_entry(&it))) {
+		unsigned long key;
+
+		if (!dev_ser->refcount)
+			continue;
+
+		key = pci_ser_xa_key(dev_ser->domain, dev_ser->bdf);
+		ret = xa_insert(&incoming->xa, key, dev_ser, GFP_KERNEL);
+		if (ret)
+			panic("Failed to insert PCI device %04x:%02x:%02x.%d into xarray (%d)\n",
+			      dev_ser->domain, PCI_BUS_NUM(dev_ser->bdf),
+			      PCI_SLOT(dev_ser->bdf), PCI_FUNC(dev_ser->bdf),
+			      ret);
+	}
+
+	args->obj = incoming;
 	return 0;
 }
 
 static void pci_flb_finish(struct liveupdate_flb_op_args *args)
 {
+	struct pci_flb_incoming *incoming = args->obj;
+
 	pr_debug("Finished struct pci_ser (0x%llx)\n", args->data);
-	kho_restore_free(args->obj);
+	pci_check_all_devices_released(incoming->ser, &incoming->block_set);
+
+	xa_destroy(&incoming->xa);
+	kho_block_set_destroy(&incoming->block_set);
+	kho_restore_free(incoming->ser);
+	kfree(incoming);
 }
 
 static struct liveupdate_flb_ops pci_liveupdate_flb_ops = {
@@ -423,6 +532,67 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
 
+static struct pci_flb_incoming *pci_liveupdate_flb_get_incoming(void)
+{
+	struct pci_flb_incoming *incoming = NULL;
+	int ret;
+
+	ret = liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **)&incoming);
+
+	/*
+	 * -EOPNOTSUPP (Live Update is not enabled), -ENODATA (no incoming FLB
+	 * data) and -ENOENT (no incoming FLB data matches
+	 * pci_liveupdate_flb.compatible) mean there is no incoming PCI state.
+	 *
+	 * Any other error means there is incoming PCI state but it could not be
+	 * retrieved (pci_flb_retrieve() returned an error or LUO failed to
+	 * acquire a reference to pci_liveupdate_flb_ops.owner), which is fatal.
+	 */
+	if (ret == -EOPNOTSUPP || ret == -ENODATA || ret == -ENOENT)
+		return NULL;
+
+	if (ret)
+		panic("Failed to retrieve incoming FLB data (%d)\n", ret);
+
+	return incoming;
+}
+
+static void pci_liveupdate_flb_put_incoming(void)
+{
+	liveupdate_flb_put_incoming(&pci_liveupdate_flb);
+}
+
+void pci_liveupdate_setup_device(struct pci_dev *dev)
+{
+	struct pci_flb_incoming *incoming;
+	struct pci_dev_ser *dev_ser;
+	unsigned long key;
+
+	guard(rwsem_write)(&pci_liveupdate.rwsem);
+
+	incoming = pci_liveupdate_flb_get_incoming();
+	if (!incoming)
+		return;
+
+	key = pci_ser_xa_key(pci_domain_nr(dev->bus), pci_dev_id(dev));
+	dev_ser = xa_load(&incoming->xa, key);
+
+	/*
+	 * This device was not preserved across Live Update, or it was preserved
+	 * but has already been probed and gone through pci_liveupdate_finish(),
+	 * e.g. due to removing and re-adding the device. Either way, it's not
+	 * treated as incoming-preserved.
+	 */
+	if (!dev_ser || !dev_ser->refcount) {
+		pci_liveupdate_flb_put_incoming();
+		return;
+	}
+
+	pci_info(dev, "Device was preserved by previous kernel across Live Update\n");
+	dev->liveupdate.incoming = dev_ser;
+	pci_liveupdate_flb_put_incoming();
+}
+
 void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 {
 	/*
@@ -432,7 +602,80 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 	 */
 	if (READ_ONCE(dev->liveupdate.outgoing))
 		pci_WARN(dev, 1, "Destroying outgoing-preserved device!\n");
+
+	if (READ_ONCE(dev->liveupdate.incoming))
+		pci_WARN(dev, 1, "Destroying incoming-preserved device!\n");
+}
+
+static void pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *dev)
+{
+	if (!dev->liveupdate.incoming) {
+		pci_warn(dev, "Cannot finish preserving an unpreserved device\n");
+		return;
+	}
+
+	if (dev->liveupdate.incoming->refcount != 1) {
+		pci_WARN(dev, 1, "Preserved device has a corrupted refcount!\n");
+		return;
+	}
+
+	/*
+	 * Drop the refcount so this device does not get treated as an incoming
+	 * device again, e.g. in case pci_liveupdate_setup_device() gets called
+	 * again because the device is hot-plugged.
+	 */
+	dev->liveupdate.incoming->refcount = 0;
+
+	pci_info(dev, "Device is finished participating in Live Update\n");
+	dev->liveupdate.incoming = NULL;
+	ser->nr_devices--;
+}
+
+/**
+ * pci_liveupdate_finish() - Finish the preservation of a PCI device
+ * @dev: The PCI device
+ *
+ * pci_liveupdate_finish() notifies the PCI core that a PCI device that was
+ * preserved across the previous Live Update has finished participating in Live
+ * Update. Drivers must call pci_liveupdate_finish() from their struct
+ * liveupdate_file_handler finish() callback, while the incoming struct pci_ser
+ * is still available.
+ */
+void pci_liveupdate_finish(struct pci_dev *dev)
+{
+	struct pci_flb_incoming *incoming;
+
+	guard(rwsem_write)(&pci_liveupdate.rwsem);
+
+	incoming = pci_liveupdate_flb_get_incoming();
+	if (!incoming) {
+		pci_warn(dev, "Cannot finish preserving device without incoming FLB\n");
+		return;
+	}
+
+	pci_liveupdate_finish_device(incoming->ser, dev);
+	pci_liveupdate_flb_put_incoming();
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_finish);
+
+/**
+ * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
+ * @dev: The PCI device to check
+ *
+ * Check if a device was preserved across Live Update by the previous kernel,
+ * i.e. the device is incoming-preserved. Note that a device is only considered
+ * incoming-preserved prior to pci_liveupdate_finish(). It is up to drivers to
+ * synchronize usage of pci_liveupdate_is_incoming() with their own call to
+ * pci_liveupdate_finish() to avoid acting on stale data.
+ *
+ * Return: True if the device is incoming-preserved, false otherwise.
+ */
+bool pci_liveupdate_is_incoming(struct pci_dev *dev)
+{
+	guard(rwsem_read)(&pci_liveupdate.rwsem);
+	return dev->liveupdate.incoming;
 }
+EXPORT_SYMBOL_GPL(pci_liveupdate_is_incoming);
 
 /**
  * pci_liveupdate_register_flb() - Register a file handler with the PCI core
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index b2335581f8d0..eaaa3559fd77 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -11,8 +11,13 @@
 #include <linux/pci.h>
 
 #ifdef CONFIG_PCI_LIVEUPDATE
+void pci_liveupdate_setup_device(struct pci_dev *dev);
 void pci_liveupdate_cleanup_device(struct pci_dev *dev);
 #else
+static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
+{
+}
+
 static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 {
 }
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5c90383873a1..a70a6d2b6da5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2075,6 +2075,8 @@ int pci_setup_device(struct pci_dev *dev)
 	if (pci_early_dump)
 		early_dump_pci_device(dev);
 
+	pci_liveupdate_setup_device(dev);
+
 	/* Need to have dev->class ready */
 	dev->cfg_size = pci_cfg_space_size(dev);
 
@@ -2195,6 +2197,7 @@ int pci_setup_device(struct pci_dev *dev)
 	default:				    /* unknown header */
 		pci_err(dev, "unknown header type %02x, ignoring device\n",
 			dev->hdr_type);
+		pci_liveupdate_cleanup_device(dev);
 		pci_release_of_node(dev);
 		return -EIO;
 
diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
index 894052ad6961..710026ada2d5 100644
--- a/include/linux/pci_liveupdate.h
+++ b/include/linux/pci_liveupdate.h
@@ -16,9 +16,11 @@
 /**
  * struct pci_liveupdate - PCI Live Update state for a struct pci_dev
  * @outgoing: State preserved for the next kernel.
+ * @incoming: State preserved by the previous kernel.
  */
 struct pci_liveupdate {
 	struct pci_dev_ser *outgoing;
+	struct pci_dev_ser *incoming;
 };
 
 struct pci_dev;
@@ -28,6 +30,8 @@ int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh);
 void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh);
 int pci_liveupdate_preserve(struct pci_dev *dev);
 void pci_liveupdate_unpreserve(struct pci_dev *dev);
+void pci_liveupdate_finish(struct pci_dev *dev);
+bool pci_liveupdate_is_incoming(struct pci_dev *dev);
 #else
 static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
 {
@@ -46,6 +50,15 @@ static inline int pci_liveupdate_preserve(struct pci_dev *dev)
 static inline void pci_liveupdate_unpreserve(struct pci_dev *dev)
 {
 }
+
+static inline void pci_liveupdate_finish(struct pci_dev *dev)
+{
+}
+
+static inline bool pci_liveupdate_is_incoming(struct pci_dev *dev)
+{
+	return false;
+}
 #endif
 
 #endif /* LINUX_PCI_LIVEUPDATE_H */
-- 
2.56.1.703.gf848ed807c-goog


