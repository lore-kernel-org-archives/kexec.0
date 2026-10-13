Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32659CC6B1C
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 16:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dIhOQAQQ+VMM6lVadofyWK2MAH+kCcuj1vkGtb5EfAU=; b=JFINB1MOdWjjbX3Kh2dYm9PZ7F
	yhkRBrbWeUo7HY1m0tVyqw5s8/RQXJNLaxxfeD4LEK9djhYl+XjQe0mxn+EbvQ82UqJnRXKz0BJvP
	aYbU2Oy6fZHknG2x74BuoR1EUNVeT0OdyRQg28kChNO2CatZIriGg6lzWklUZM0CcUIAjdLp798I4
	/8nDmyFujZqN1puPpExeGrjnwrIE9oTc3ryyi0nWi6pkMgVJ0Hv55D4YAspCNr2gf2GfEWgZ9yHrd
	jZKWNpuqm9bVVJ3vvte3quMgb7fkMaPIEsgt6VeUa/wy8XO023Da7qeqoUYWyG45/odYBrueQmuBo
	z9BmFq0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfK3-0000000DUm3-0eDT;
	Tue, 13 Oct 2026 16:25:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfK2-0000000DUkN-1Jio
	for kexec@bombadil.infradead.org;
	Tue, 13 Oct 2026 16:25:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dIhOQAQQ+VMM6lVadofyWK2MAH+kCcuj1vkGtb5EfAU=; b=kq7d0u9TDegqQPefZQCSqUHkWq
	m9IPt9pbTEj5Xm9H2RolWAF2/GqOiwNxnBRp9BhnqpCDgulRbrqWG3zGLwgTqOWoJ0nDn4t/D+Hfg
	n7vbK/F7mBswbv0zb3HaVY9UTufd1pk8nW8zEDgOxCDtvDUb1hjA9J0osXxbHhn217D66OQFBR4qj
	IphJrxicMCzPGgTXfUo1OQn/t+m4hw5NjzdA3yxLLOCN6Nxf9k/SgUO+hly+HZLNpDBPiKFOaSr7w
	bRk5qIm/SD17Qt+MQjO1aeavPC/MCHbQxfHXN1z7rTBINLT+tHK6WirF33Zp/NT28jrsP0MIUVSQ/
	AGcmTHpA==;
Received: from mail-pl1-x646.google.com ([2607:f8b0:4864:20::646])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGfJy-0000000FmJa-3fB6
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 16:25:49 +0000
Received: by mail-pl1-x646.google.com with SMTP id d9443c01a7336-2e827b3a6b4so46955755ad.2
        for <kexec@lists.infradead.org>; Tue, 13 Oct 2026 09:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791908745; x=1792513545; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dIhOQAQQ+VMM6lVadofyWK2MAH+kCcuj1vkGtb5EfAU=;
        b=vEdKH/oVYcdppNlGZ6PM7AhxAU8X3gjgQySmMVGFWBWuApJ+AIVn23UcYgI2/zmDeW
         xp57aqAfqY1B3YGvsv/P8wIhDn++uxnyMUhLmV8RSl810ihRm96R1AryTdqxbZY+e3bD
         f4JVxpGY1BLR27vrSn53DrEkabgspeYNAsglv8f+Ye4KDWlref2XdvPD79vilw/zwzoT
         PhyadBFeqYGB1zRQiGJfJZhv9RuUp0ClIEr+3sI3N5NflEa/THx/OLEP2EMCxuq798Vm
         EXsAXd21SQyqft1rMbmPRQ4LAggJJ8RucxuQ+vL9z1tDYK3HIAYJbi/zkrRFO4mHqLIE
         akkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791908745; x=1792513545;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dIhOQAQQ+VMM6lVadofyWK2MAH+kCcuj1vkGtb5EfAU=;
        b=oiqVRKjcf8k2kPt+zpYGQ98LRz/VM0kk/lH0BvzjCut7wsFSb5xtmDSF3RJU+Ref5C
         Xdn1Yrtz8g4XY2/08GkRljy3nFoUvmi90U0pFZd7hXeXwnZQQ++eSfZRMCusR2b/WdUp
         B71gc309+B9irQrxifXm0nkWgvupGRTfwlsKa6ZXeTGF5bvS+eKh2z9BXApzpvBKq4qn
         z6AltuW6DY+tubaNBMjPIo2Yt55cpdxDPqwSQR0j8P8OyDMfvl+4F4gdsDQJoW04MMh7
         J+zYL8l/ue3MVAoCKyuoZ7yprcf7C0R4h5JJxEfR+kBU3ejCrcImyFgxTuKVZ1lNiS2o
         WZSw==
X-Gm-Message-State: AFq9FYJYxlkwfzviZRPV789s16j81dGMx9EFoZtCp4vI5d/NcUx+C0TJ
	hiI/Sli+KJ8oIsG1Z7ikSxYOIwkqmiIPekLA9U31wgNFR3wVyOxtb95pKmUa/6VQEJT5InhXgt/
	vZeWquBsqQaukun2olKrAGBpd0XV42kY0Wk1DDk/m0iADsMZ2PfQbtUDOgvkvfCKE4J6SBRO1tG
	5qAsELZQlOpdLn9zQk8Xp8UECgj6nY6GobtibJuQ4R+VKHBSclJnk=
X-Received: from plin4.prod.google.com ([2002:a17:903:3884:b0:2e2:c744:19ed])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:fc8d:b0:2e3:598:75b8 with SMTP id d9443c01a7336-2e842ab03ddmr108269245ad.27.1791908744336;
 Tue, 13 Oct 2026 09:25:44 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:25:24 +0000
In-Reply-To: <20261013162529.1928093-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20261013162529.1928093-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013162529.1928093-9-dmatlack@google.com>
Subject: [PATCH v10 08/13] PCI: Save and restore the ACS Control register and
 Egress Control Vector
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
X-CRM114-CacheID: sfid-20261013_172547_120155_10846BBB 
X-CRM114-Status: GOOD (  29.87  )
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

Save the ACS Control register and the ACS Egress Control Vector in
pci_save_state() and write them back in pci_restore_state(), instead of
recomputing the ACS controls from scratch with pci_enable_acs().

This makes ACS symmetric with the rest of a device's saved state. Today
pci_save_state() ignores ACS entirely and pci_restore_state() re-enables
the ACS controls from the kernel's current ACS policy. As a result, a
device can come out of a reset with different ACS controls than it went
in with, e.g. any controls programmed outside of pci_enable_acs() are
silently dropped.

Notably, this prepares the kernel to be able to adopt the ACS controls
established by a previous kernel across a Live Update rather than
assigning new ones through pci_enable_acs().

Save and restore the Egress Control Vector as well to keep it in sync
with the now-properly-restored Egress Control Enable bit in the ACS
control register. The kernel never enables Egress Controls or programs
the vector, but the firmware could have and they need to be kept in sync
to avoid changing how P2P traffic is routed.

The Egress Control Vector Size is a HwInit field of the ACS Capability
register, so read it directly from the device to size the save buffer
in pci_allocate_cap_save_buffers(), similar to how the VC capability
relies on its HwInit fields.

pci_enable_acs() runs when a driver binds to a device
(pci_dma_configure()), i.e. after pci_bus_add_device() has already saved
the device's state. Refresh the saved ACS state there as well, otherwise
a subsequent reset would revert ACS back to the configuration left
behind by firmware.

Devices that rely on device-specific quirks to enable an ACS equivalent
keep that configuration outside of the ACS Control register, so keep
configuring ACS from scratch for them. Do the same for devices that have
no saved ACS state at all.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci.c    | 146 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/pci/pci.h    |   5 ++
 drivers/pci/quirks.c |   7 +++
 3 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..944590fdef48 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1021,6 +1021,139 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 		caps->ctrl |= (dev->acs_capabilities & PCI_ACS_TB);
 }
 
+/*
+ * Layout of the ACS save buffer. @ecv holds the ACS Egress Control Vector, if
+ * implemented, and is sized by pci_allocate_acs_save_buffer().
+ */
+struct pci_acs_saved_state {
+	u16 ctrl;
+	u32 ecv[];
+};
+
+/*
+ * Return the number of DWORDs in the ACS Egress Control Vector, or 0 if the
+ * device does not implement P2P Egress Control. The Egress Control Vector
+ * Size is HwInit, so it is read directly from the ACS Capability register.
+ */
+static unsigned int pci_acs_ecv_dwords(struct pci_dev *dev, int pos)
+{
+	unsigned int bits;
+	u16 cap;
+	u8 size;
+
+	pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
+	if (!(cap & PCI_ACS_EC))
+		return 0;
+
+	/* An Egress Control Vector Size of 0 means 256 bits */
+	pci_read_config_byte(dev, pos + PCI_ACS_EGRESS_BITS, &size);
+	bits = size ?: 256;
+
+	return DIV_ROUND_UP(bits, 32);
+}
+
+/*
+ * Return the number of Egress Control Vector DWORDs held in @save_state, as
+ * sized by pci_allocate_acs_save_buffer().
+ */
+static unsigned int
+pci_acs_saved_ecv_dwords(struct pci_cap_saved_state *save_state)
+{
+	return (save_state->cap.size -
+		offsetof(struct pci_acs_saved_state, ecv)) / sizeof(u32);
+}
+
+static void pci_allocate_acs_save_buffer(struct pci_dev *dev)
+{
+	size_t size;
+	int pos;
+
+	/* dev->acs_cap is not set yet, pci_acs_init() runs later */
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	if (!pos)
+		return;
+
+	size = struct_size_t(struct pci_acs_saved_state, ecv,
+			     pci_acs_ecv_dwords(dev, pos));
+	if (pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ACS, size))
+		pci_err(dev, "unable to allocate suspend buffer for ACS\n");
+}
+
+/**
+ * pci_save_acs_state - save the ACS Control register and Egress Control Vector
+ * @dev: the PCI device
+ *
+ * Record the ACS configuration currently programmed in hardware so that
+ * pci_restore_acs_state() can reapply it after a reset.
+ */
+static void pci_save_acs_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+	struct pci_acs_saved_state *acs;
+	unsigned int i, dwords;
+	int ecv_pos;
+
+	if (!dev->acs_cap)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ACS);
+	if (!save_state)
+		return;
+
+	acs = (struct pci_acs_saved_state *)save_state->cap.data;
+
+	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &acs->ctrl);
+
+	ecv_pos = dev->acs_cap + PCI_ACS_EGRESS_CTL_V;
+	dwords = pci_acs_saved_ecv_dwords(save_state);
+	for (i = 0; i < dwords; i++)
+		pci_read_config_dword(dev, ecv_pos + i * sizeof(u32),
+				      &acs->ecv[i]);
+}
+
+/**
+ * pci_restore_acs_state - restore the ACS Control register and Egress Control
+ *			   Vector
+ * @dev: the PCI device
+ */
+static void pci_restore_acs_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state = NULL;
+	struct pci_acs_saved_state *acs;
+	unsigned int i, dwords;
+	int ecv_pos;
+
+	if (dev->acs_cap && !pci_need_dev_specific_enable_acs(dev))
+		save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ACS);
+
+	/*
+	 * Devices that rely on device-specific quirks to enable an ACS
+	 * equivalent keep that configuration outside of the ACS Control
+	 * register, so there is nothing useful to restore for them. Configure
+	 * ACS from scratch instead, which also covers devices that have no
+	 * saved ACS state at all.
+	 */
+	if (!save_state) {
+		pci_enable_acs(dev);
+		return;
+	}
+
+	acs = (struct pci_acs_saved_state *)save_state->cap.data;
+
+	/*
+	 * Restore the Egress Control Vector before the ACS Control register.
+	 * The vector resets to zero, so enabling P2P Egress Control first
+	 * would briefly apply the reset vector instead of the saved one.
+	 */
+	ecv_pos = dev->acs_cap + PCI_ACS_EGRESS_CTL_V;
+	dwords = pci_acs_saved_ecv_dwords(save_state);
+	for (i = 0; i < dwords; i++)
+		pci_write_config_dword(dev, ecv_pos + i * sizeof(u32),
+				       acs->ecv[i]);
+
+	pci_write_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, acs->ctrl);
+}
+
 /**
  * pci_enable_acs - enable ACS if hardware support it
  * @dev: the PCI device
@@ -1057,6 +1190,15 @@ void pci_enable_acs(struct pci_dev *dev)
 	__pci_config_acs(dev, &caps, config_acs_param, 0, 0);
 
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, caps.ctrl);
+
+	/*
+	 * pci_enable_acs() runs when a driver binds to the device, i.e. after
+	 * pci_bus_add_device() has already saved the device's state. Refresh
+	 * the saved ACS state so that a subsequent reset restores the
+	 * configuration programmed here rather than the one left behind by
+	 * firmware.
+	 */
+	pci_save_acs_state(dev);
 }
 
 /**
@@ -1800,6 +1942,7 @@ int pci_save_state(struct pci_dev *dev)
 	pci_save_aer_state(dev);
 	pci_save_ptm_state(dev);
 	pci_save_tph_state(dev);
+	pci_save_acs_state(dev);
 	return pci_save_vc_state(dev);
 }
 EXPORT_SYMBOL(pci_save_state);
@@ -1877,7 +2020,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_msi_state(dev);
 
 	/* Restore ACS and IOV configuration state */
-	pci_enable_acs(dev);
+	pci_restore_acs_state(dev);
 	pci_restore_iov_state(dev);
 
 	dev->state_saved = false;
@@ -3532,6 +3675,7 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 	if (error)
 		pci_err(dev, "unable to allocate suspend buffer for LTR\n");
 
+	pci_allocate_acs_save_buffer(dev);
 	pci_allocate_vc_save_buffers(dev);
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc2..037c1674f164 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1095,6 +1095,7 @@ void pci_acs_init(struct pci_dev *dev);
 void pci_enable_acs(struct pci_dev *dev);
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
+bool pci_need_dev_specific_enable_acs(struct pci_dev *dev);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
 int pci_dev_specific_disable_acs_redir(struct pci_dev *dev);
 void pci_disable_broken_acs_cap(struct pci_dev *pdev);
@@ -1105,6 +1106,10 @@ static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
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
index 7aee30734303..e500c202d2ec 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5476,6 +5476,13 @@ static const struct pci_dev_acs_ops *pci_dev_acs_ops_get(struct pci_dev *dev)
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
-- 
2.56.0.385.gd3acb90ef8-goog


