Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578B760A4ADC
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 21:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YY1fna5K;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=T0Wjd9OI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lTYTkWMi5xcceVhwhueApgEoPQA4CpHfxU1jS/q1Tmw=; b=YY1fna5KkU1PT1IsBXeiWXXw9H
	7zxn8H2MxhUE72DEzY0lN+JMON5LVyWdD+nePNYWeYU7D1fdSgYSLV9s1VnS75DArk1vW/oOwJm3R
	NqNtQ4G+bPbaW1wmIj4+3dmwr3MsywbUPMPNnZDTv0NHInTTn7B1fuqUEdb3N4nNqjgKigPuCPX+S
	kIu5HmbouPWVsOEQtinm6hJbYCBSkfzYYm7IXxJrZj1R0s3OksZBpqGEO/bCSKyyMl5x4kEdzd0BL
	mXQePX/67E8g09ziXC/JvyQjYS97/nV+NGWozkvPx5SbeoS8PAD71H8UjfGmCUGyqG2pB+tRBYGDW
	af847WHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIuxA-00000008O6V-0LLU;
	Mon, 19 Oct 2026 21:31:32 +0000
Received: from mail-pg1-x545.google.com ([2607:f8b0:4864:20::545])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIux3-00000008O1Y-1oBd
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 21:31:30 +0000
Received: by mail-pg1-x545.google.com with SMTP id 41be03b00d2f7-cc7361c62b9so1641717a12.3
        for <kexec@lists.infradead.org>; Mon, 19 Oct 2026 14:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792445483; x=1793050283; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lTYTkWMi5xcceVhwhueApgEoPQA4CpHfxU1jS/q1Tmw=;
        b=T0Wjd9OIIY6IbjPWDQI4HQJDa3uLLlSLRuXcH5GVBQ3aF9kFJ51qZ/02s7jAgmLpGy
         YuZjWc3CsjdJ6eqbandgNFwOdMHjuHnf6GcXknkGrc4ab3j9wNpZEdUKqeHk1h1vr8+p
         ZvZtt4sw6F8a88GP2y0/++/quV5eoF/fmvlVfAVA/IKkW1UGFNEIdP5Dty3i0FATKDCv
         w8gVMbZlWJUPbDNynYgeR4oqfO8k5jUer+xzEwcL6ZiWTZJIRhyk53jbyaz4Bvyl12ds
         jAy1FmNov9CeW1qCsHQ/irthHnlUhinKBvAbz4+gYgJlIF0+bj9hlfWvB39YQ6hthkk6
         Gg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445483; x=1793050283;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lTYTkWMi5xcceVhwhueApgEoPQA4CpHfxU1jS/q1Tmw=;
        b=pVIvfYaTjx3/lW1sCwUQdvEsKYnTr3mwGDdgvL0yN7JJjE9b421FesgkBPg295WB+L
         XDdce0SUTOz1dTxs3skYjLcobF2fQ7wn3TT8u0DJA3g7OY4OZVyAAhHx/2P0P3ERGPF9
         lW7Bx5RkhkEaWvBDgp70p1CisJ7679EWY+xBIqpYi7Y4Sqb/i/N8R08cC3n8Sz28d17J
         QokIpaQ67CPURFS0VW4cZOl+fU61Z5rYfTXadXu5ixt2lnO99uusxwImPLbsFkk8lqtV
         3t+fcUp56oNPrttbzFCFUHut38pJHFLPypv4/BSlOr6ZxC46BJpdJudfODJpQRtv5eFk
         Ut6Q==
X-Gm-Message-State: AFq9FYJrXc3wgwOODzQMrExK5e1Fz8C3p+877CWn5H9uHhkAFzlGYnQi
	RwOFKsnIuqq/MTHeIsLUFw8NL8l5NtjvFsbnc1yPVyat3ATDXPnYV3HDSeFdAHU5tAYC5N6wznW
	78eIkFQG+TtDRrevZpxpTYgc3HQtsk7VTY2m09CkJFhYijp6oaOxH9MJJsKb3AvvYLjKZc3J5qM
	eVCfv+xqYv8fgJ14Qn2mEAXcDKDvec8uO4zc5IF1pNsCMzHxpysSI=
X-Received: from pgni18-n1.prod.google.com ([2002:a05:6a02:6a52:10b0:cd6:1e55:140d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3295:b0:3de:48ca:c578 with SMTP id adf61e73a8af0-3e225f843c1mr6648063637.33.1792445482515;
 Mon, 19 Oct 2026 14:31:22 -0700 (PDT)
Date: Mon, 19 Oct 2026 21:30:46 +0000
In-Reply-To: <20261019213054.3157159-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261019213054.3157159-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019213054.3157159-3-dmatlack@google.com>
Subject: [PATCH 02/10] PCI: liveupdate: Avoid sizing BARs of incoming devices
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
X-CRM114-CacheID: sfid-20261019_143127_257162_4DFFD6B5 
X-CRM114-Status: GOOD (  39.19  )
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
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Avoid sizing the BARs of incoming preserved devices during enumeration.
Instead, have the previous kernel pass the BAR masks in struct
pci_dev_ser and use those in place of sizing.

Sizing a BAR requires disabling decoding. While decoding is disabled,
the device does not respond to memory transactions targeting its BARs:
Posted Writes are silently dropped and Reads fail with Unsupported
Request. This would disrupt anything that keeps accessing a preserved
device across Live Update, such as P2PDMA from other preserved devices,
or MMIO from VMs whose vCPUs keep running during kexec.

Sizing is the only part of reading a BAR that requires writing to it.
The address and type of each BAR can be read from the device without
disturbing it. So pass only the result of sizing across Live Update:
for each BAR register, the value it returns when read after writing all
1s to it (its mask). Append the masks to struct pci_dev_ser and
advertise their presence with a new optional feature flag,
PCI_SER_OPTIONAL_BAR_MASKS. The next kernel then decodes the BARs as if
it had sized them, so the ABI does not depend on any kernel-internal
state such as IORESOURCE_* flags.

Compute the masks from the size of each resource in
pci_liveupdate_freeze(), once preservation status can no longer change
and just before kexec, rather than when the device is preserved. A BAR
can change size after the device is preserved, e.g. via Resizable BAR,
in which case the next kernel would decode the BAR with the wrong size.

Cache the optional features of the incoming FLB that this kernel
supports in struct pci_liveupdate_global when the FLB is retrieved, so
they can be checked without getting a reference to the incoming FLB,
and verify that the incoming struct pci_dev_ser entries are large
enough to contain the fields of those features.

If the previous kernel did not pass BAR masks, fall back to sizing the
BARs.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c    | 138 +++++++++++++++++++++++++++++++++++-
 drivers/pci/liveupdate.h    |   9 +++
 drivers/pci/probe.c         |  10 +++
 include/linux/kho/abi/pci.h |  25 ++++++-
 4 files changed, 178 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 6f92d4ddca2b..f48cab3cc232 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -197,6 +197,13 @@
  *  * The PCI core does not disable bus mastering on outgoing preserved devices
  *    during kexec. This allows preserved devices to issue memory transactions
  *    throughout the Live Update.
+ *
+ *  * The PCI core does not size the BARs of incoming preserved devices, since
+ *    sizing requires disabling decoding, which would disrupt memory
+ *    transactions targeting the device (e.g. P2PDMA, or MMIO from VMs whose
+ *    vCPUs keep running during kexec). Instead, the previous kernel passes the
+ *    size of each BAR in struct pci_dev_ser. Everything else about the BARs
+ *    (e.g. their addresses and types) is read from the device as usual.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -221,10 +228,14 @@
  * @had_incoming: True if the previous kernel preserved at least one PCI device.
  *                Set when the incoming FLB is retrieved and never cleared, so
  *                it stays true after Live Update finishes.
+ * @incoming_optional_flags: The optional features in the incoming FLB
+ *                           (struct pci_ser::optional_flags) that this kernel
+ *                           supports. Set when the incoming FLB is retrieved.
  */
 struct pci_liveupdate_global {
 	struct rw_semaphore rwsem;
 	bool had_incoming;
+	u64 incoming_optional_flags;
 };
 
 static struct pci_liveupdate_global pci_liveupdate = {
@@ -267,6 +278,26 @@ struct pci_flb_incoming {
  */
 #define PCI_SER_REQUIRED_FLAGS_SUPPORTED	0ULL
 
+/*
+ * Bits in struct pci_ser::optional_flags that this kernel knows how to handle.
+ * This kernel also provides all of them to the next kernel.
+ */
+#define PCI_SER_OPTIONAL_FLAGS_SUPPORTED	PCI_SER_OPTIONAL_BAR_MASKS
+
+/*
+ * The minimum size of struct pci_dev_ser given the optional features that are
+ * present in it.
+ */
+static u32 pci_dev_ser_min_size(u64 optional_flags)
+{
+	u32 size = PCI_DEV_SER_MIN_SIZE;
+
+	if (optional_flags & PCI_SER_OPTIONAL_BAR_MASKS)
+		size = max(size, offsetofend(struct pci_dev_ser, rom_mask));
+
+	return size;
+}
+
 /* PCI_LIVEUPDATE depends on 64BIT, so domain and bdf always fit. */
 static unsigned long pci_ser_xa_key(u32 domain, u16 bdf)
 {
@@ -287,7 +318,7 @@ static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
 		return PTR_ERR(ser);
 
 	ser->required_flags = 0;
-	ser->optional_flags = 0;
+	ser->optional_flags = PCI_SER_OPTIONAL_FLAGS_SUPPORTED;
 	ser->dev_ser_size = sizeof(struct pci_dev_ser);
 	ser->nr_devices = 0;
 	ser->devices = 0;
@@ -325,6 +356,7 @@ static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
 	struct pci_flb_incoming *incoming;
 	struct pci_dev_ser *dev_ser;
 	struct kho_block_set_it it;
+	u64 optional_flags;
 	int ret;
 
 	pr_debug("Retrieving struct pci_ser (0x%llx)\n", args->data);
@@ -333,12 +365,16 @@ static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
 		panic("Incoming PCI FLB requires unsupported features (0x%llx)\n",
 		      ser->required_flags & ~PCI_SER_REQUIRED_FLAGS_SUPPORTED);
 
+	/* Ignore any optional features that this kernel does not support. */
+	optional_flags = ser->optional_flags & PCI_SER_OPTIONAL_FLAGS_SUPPORTED;
+
 	/*
 	 * The previous kernel may have appended fields to struct pci_dev_ser,
 	 * which this kernel ignores, but every entry must be at least the
-	 * minimum size.
+	 * minimum size, including the fields of the optional features that
+	 * are present.
 	 */
-	if (ser->dev_ser_size < PCI_DEV_SER_MIN_SIZE)
+	if (ser->dev_ser_size < pci_dev_ser_min_size(optional_flags))
 		panic("Incoming PCI FLB has unsupported struct pci_dev_ser size (%u)\n",
 		      ser->dev_ser_size);
 
@@ -378,6 +414,8 @@ static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
 	if (!xa_empty(&incoming->xa))
 		pci_liveupdate.had_incoming = true;
 
+	pci_liveupdate.incoming_optional_flags = optional_flags;
+
 	args->obj = incoming;
 	return 0;
 }
@@ -541,6 +579,53 @@ static void pci_liveupdate_unpreserve_path(struct pci_flb_outgoing *outgoing,
 	}
 }
 
+/*
+ * Compute the value that the BAR backing resource @resno of @dev returns when
+ * read after writing all 1s to it, from the size of the resource.
+ */
+static u64 pci_liveupdate_bar_mask(struct pci_dev *dev, int resno)
+{
+	struct resource *res = &dev->resource[resno];
+	resource_size_t size = resource_size(res);
+
+	if (!res->flags || !size)
+		return 0;
+
+	/* Skip resources that are not decoded by the BAR. */
+	if (res->flags & IORESOURCE_PCI_EA_BEI)
+		return 0;
+
+	if (resno == PCI_ROM_RESOURCE && (res->flags & IORESOURCE_ROM_SHADOW))
+		return 0;
+
+	/* The size of a BAR is always a power of 2. */
+	pci_WARN_ONCE(dev, size & (size - 1),
+		      "%s %pR: Size is not a power of 2\n",
+		      pci_resource_name(dev, resno), res);
+
+	return ~((u64)size - 1);
+}
+
+static void pci_liveupdate_save_bar_masks(struct pci_dev *dev,
+					  struct pci_dev_ser *dev_ser)
+{
+	u64 mask;
+	int i;
+
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		mask = pci_liveupdate_bar_mask(dev, i);
+		dev_ser->bar_masks[i] = lower_32_bits(mask);
+
+		/* The upper half of a 64-bit BAR is in the next register. */
+		if ((dev->resource[i].flags & IORESOURCE_MEM_64) &&
+		    i + 1 < PCI_STD_NUM_BARS)
+			dev_ser->bar_masks[++i] = upper_32_bits(mask);
+	}
+
+	mask = pci_liveupdate_bar_mask(dev, PCI_ROM_RESOURCE);
+	dev_ser->rom_mask = lower_32_bits(mask);
+}
+
 static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
 					  struct pci_dev *dev)
 {
@@ -833,6 +918,14 @@ void pci_liveupdate_freeze(struct pci_dev *dev)
 {
 	guard(rwsem_write)(&pci_liveupdate.rwsem);
 	dev->liveupdate.frozen = true;
+
+	/*
+	 * Save the BAR masks of outgoing devices now that preservation status
+	 * is frozen, rather than when the devices are preserved, in case the
+	 * size of a BAR changes in between (e.g. via Resizable BAR).
+	 */
+	if (dev->liveupdate.outgoing)
+		pci_liveupdate_save_bar_masks(dev, dev->liveupdate.outgoing);
 }
 
 static int pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *dev)
@@ -984,6 +1077,45 @@ bool pci_liveupdate_is_outgoing(struct pci_dev *dev)
 	return dev->liveupdate.outgoing;
 }
 
+/**
+ * pci_liveupdate_read_bar_masks() - Get the BAR masks of an incoming device
+ * @dev: The PCI device
+ * @nr_bars: The number of standard BARs to get masks for
+ * @bar_masks: Array of @nr_bars entries to fill with the standard BAR masks
+ * @rom_mask: Filled with the Expansion ROM BAR mask, if not NULL
+ *
+ * Get the BAR masks passed by the previous kernel, i.e. the values that the
+ * BARs of @dev return when read after writing all 1s to them, so that the BARs
+ * do not need to be sized.
+ *
+ * Return: 0 on success, or <0 if @dev is not incoming-preserved or the
+ * previous kernel did not pass BAR masks.
+ */
+int pci_liveupdate_read_bar_masks(struct pci_dev *dev, unsigned int nr_bars,
+				  u32 *bar_masks, u32 *rom_mask)
+{
+	struct pci_dev_ser *dev_ser;
+	unsigned int i;
+
+	guard(rwsem_read)(&pci_liveupdate.rwsem);
+
+	dev_ser = dev->liveupdate.incoming;
+	if (!dev_ser)
+		return -EINVAL;
+
+	if (!(pci_liveupdate.incoming_optional_flags &
+	      PCI_SER_OPTIONAL_BAR_MASKS))
+		return -EOPNOTSUPP;
+
+	for (i = 0; i < nr_bars; i++)
+		bar_masks[i] = dev_ser->bar_masks[i];
+
+	if (rom_mask)
+		*rom_mask = dev_ser->rom_mask;
+
+	return 0;
+}
+
 /**
  * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
  * @dev: The PCI device to check
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index 333ddd8f36c5..80749f14beea 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -19,6 +19,8 @@ bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus, struct pci_dev *dev)
 int pci_liveupdate_adopt_acs(struct pci_dev *dev);
 int pci_liveupdate_adopt_ari(struct pci_dev *dev);
 bool pci_liveupdate_is_outgoing(struct pci_dev *dev);
+int pci_liveupdate_read_bar_masks(struct pci_dev *dev, unsigned int nr_bars,
+				  u32 *bar_masks, u32 *rom_mask);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -57,6 +59,13 @@ static inline bool pci_liveupdate_is_outgoing(struct pci_dev *dev)
 {
 	return false;
 }
+
+static inline int pci_liveupdate_read_bar_masks(struct pci_dev *dev,
+						unsigned int nr_bars,
+						u32 *bar_masks, u32 *rom_mask)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9187f1d91766..3cb2e481eddf 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -328,6 +328,16 @@ static void pci_size_bases(struct pci_dev *dev, unsigned int howmany, int rom,
 {
 	u16 orig_cmd;
 
+	/*
+	 * Sizing BARs requires disabling decoding, which would disrupt memory
+	 * transactions targeting devices preserved across Live Update (e.g.
+	 * P2PDMA, or MMIO from VMs whose vCPUs keep running during kexec), so
+	 * use the BAR masks passed by the previous kernel for those devices.
+	 */
+	if (!pci_liveupdate_read_bar_masks(dev, howmany, stdbars,
+					   rom ? rombar : NULL))
+		return;
+
 	/* No printks while decoding is disabled! */
 	if (!dev->mmio_always_on) {
 		pci_read_config_word(dev, PCI_COMMAND, &orig_cmd);
diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
index c2e3a5949f73..5fa2ecfe5b6d 100644
--- a/include/linux/kho/abi/pci.h
+++ b/include/linux/kho/abi/pci.h
@@ -8,8 +8,10 @@
 #ifndef _LINUX_KHO_ABI_PCI_H
 #define _LINUX_KHO_ABI_PCI_H
 
+#include <linux/bits.h>
 #include <linux/bug.h>
 #include <linux/compiler.h>
+#include <linux/pci_regs.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
 
@@ -56,11 +58,24 @@
  *            reference count is equal to the number of preserved devices at or
  *            below it in the PCI hierarchy when the struct pci_dev_ser is in
  *            use, and 0 otherwise.
+ * @bar_masks: The value each standard BAR register returns when read after
+ *             writing all 1s to it, i.e. the mask that encodes the size of the
+ *             BAR. Only the address bits are meaningful. A 64-bit BAR uses two
+ *             entries, like it uses two registers. 0 if the BAR is not
+ *             implemented. Used by the next kernel instead of sizing the BARs,
+ *             which requires disabling decoding and would disrupt memory
+ *             transactions targeting the device.
+ * @rom_mask: Same as @bar_masks, but for the Expansion ROM BAR.
+ *
+ * Each field after @refcount is only present if the ``PCI_SER_OPTIONAL_*``
+ * flag that covers it is set in ``pci_ser.optional_flags``.
  */
 struct pci_dev_ser {
 	u32 domain;
 	u16 bdf;
 	u16 refcount;
+	u32 bar_masks[PCI_STD_NUM_BARS];
+	u32 rom_mask;
 } __packed;
 
 /*
@@ -80,7 +95,7 @@ struct pci_dev_ser {
  * @required_flags: Features that the next kernel must support to take over
  *                  the preserved devices. No flags are currently defined.
  * @optional_flags: Features that the next kernel may ignore if it does not
- *                  support them. No flags are currently defined.
+ *                  support them (``PCI_SER_OPTIONAL_*``).
  * @dev_ser_size: The size in bytes of each struct pci_dev_ser in @devices.
  * @nr_devices: The number of devices that were preserved.
  * @devices: Physical address of the first KHO block containing pci_dev_ser.
@@ -93,4 +108,12 @@ struct pci_ser {
 	u64 devices;
 } __packed;
 
+/*
+ * Bits in struct pci_ser::optional_flags. If a bit is set, @dev_ser_size is
+ * large enough to contain the fields of struct pci_dev_ser that it covers:
+ *
+ *  * PCI_SER_OPTIONAL_BAR_MASKS: @bar_masks and @rom_mask
+ */
+#define PCI_SER_OPTIONAL_BAR_MASKS	BIT_ULL(0)
+
 #endif /* _LINUX_KHO_ABI_PCI_H */
-- 
2.56.0.212.g129ede20d9-goog


