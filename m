Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF2460A6F4C
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 22:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=g/ej1Ebj;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WwCEABfT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wAMMri541KJubVOMQzqlC8m9FrHJPC8q4xU1ogcuUXg=; b=g/ej1EbjJsnqH2Pvjr7kGBVzmu
	SEz0UVrQ2f8va9E8FcInjLSg4hClzGSc3oPpKNEON7YiF/tF8agjBb3SrE4yvMEVMKKLjW6qf7UmT
	BYxMcPrvNJ7uXxt2exoYMnhiFpRdO3z/AG7f1KrGntR6MPxYAyal+q8v3EEHPGNZK1DyrC2TfTjBi
	NQtQqUdKrmENn6QZWvVLY+73IHHlsXeFr2iRuIglj3jQrI7lp9pOUcHJLQvpt8jeIskyIrNz7Mokc
	pUcSLBjFZnuztOqqYIbjiZkeJrTMDUHsA0izRlN4ZPpHPM4WsNEwnxKAe/j26u1dCLmF1ff878mVO
	s8GJmL9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xToHK-0000000AQ40-0wPb;
	Wed, 18 Nov 2026 22:37:22 +0000
Received: from mail-oi1-x245.google.com ([2607:f8b0:4864:20::245])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xToHH-0000000APxr-0jxU
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 22:37:20 +0000
Received: by mail-oi1-x245.google.com with SMTP id 5614622812f47-4b37620eb73so2010329b6e.1
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 14:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795041438; x=1795646238; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wAMMri541KJubVOMQzqlC8m9FrHJPC8q4xU1ogcuUXg=;
        b=WwCEABfTjwdHMc+fUc3TCEsCUjwC6UAVsDg0cSbvTsD4xVu2VBkGnrSjCr3Cjn66vL
         QjGu7UmXjxKMQU0I1tq9sH0ytF1ixBgaJ3uI419d51hz8pGOgwUVKuHOY7yu6QHNvH0A
         Mr0bnlJ1y/7Xjgu8dEZQ60pVYLK0SILFWcjU7b+UM2zMMJHE/7z8jNODnkm7BbjYfMoj
         gpWBwxjNt9qoCyvKBccBrx1hoq65+0SnUeZy0BwMlCF7X61hoPfXHXzg76sKUxymvCT5
         0ovdDkpjqhCsa0rtXFPcA7NtmSFLgc1kYK61wo56MBvrCKykhWuuz4n13FXo1dtHx1GS
         1Onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795041438; x=1795646238;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wAMMri541KJubVOMQzqlC8m9FrHJPC8q4xU1ogcuUXg=;
        b=h01oegKmoiH1HRCEex9PaHBkKiWsCT/JFnsmCdPAE++jMSCnAB4KQs/F359CYfn1ds
         QcT1veMIdp2IrY32ezge7AyrtpITput6XUENUJ6cXOIgCFYmdxZGtVvItZuziHyJkVhi
         kAYhavZqTj6Dgu8Efki9UDEjbm1cxTNnfciuGhtHmjWQlgCWcVAGWE2ewKXGptGX1D4e
         hN4gl0w9w/a6HbiqtiDizXF4/ZQNLqv7cYkyOvqSNsOsrvR/rXOovEULPitwF47C2Tyh
         xRKQ/ON/qEislrIaPy4Arz/7fky8FC9V1dZ/6bp1YjCG2jKSfqKlYhQvbr8ze48rrwqX
         f20A==
X-Gm-Message-State: APuU4Z9gI2gdhTXsWkTAVLCMha5VX20+1FQ3H/+lEUR45zvnBA06jG1T
	et59xQv9kwgnRSJEEQmZfjkWY7ZLUhUmNeoHDltlsvCD1YrpsPJ9XFi6jPaUctz4mX3RIcTKdoj
	Vw71F6zcF+WOb0ENT/fXALsWBMMtZn5UIt672H2aGHIji+rPgrjx+ifxOHwINRrmGnywMiDY4g3
	lyOIW5Pr66yTMcJ9YWew6n1LbB7aH3CIFenYk/ndl3fhIrW0FWaRw=
X-Received: from japs5.prod.google.com ([2002:a02:cc85:0:b0:5fe:dbaf:f909])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1524:b0:4c3:6c2:4f29 with SMTP id 5614622812f47-57741d176e1mr4378785b6e.16.1795041437234;
 Wed, 18 Nov 2026 14:37:17 -0800 (PST)
Date: Wed, 18 Nov 2026 22:36:59 +0000
In-Reply-To: <20261118223704.3286085-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261118223704.3286085-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118223704.3286085-9-dmatlack@google.com>
Subject: [PATCH v11 08/13] PCI: Save and restore the ACS Control register and
 Egress Control Vector
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
X-CRM114-CacheID: sfid-20261118_143719_265297_73855444 
X-CRM114-Status: GOOD (  28.42  )
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

Save the ACS Control register and the ACS Egress Control Vector in
pci_save_state() and write them back in pci_restore_state(), instead of
recomputing the ACS controls from scratch with pci_enable_acs().

This makes ACS symmetric with the rest of a device's saved state. Today
pci_save_state() ignores ACS entirely and pci_restore_state() re-enables
the ACS controls from the kernel's current ACS policy. As a result, a
device can come out of a reset with different ACS controls than it went
in with, e.g. any controls programmed outside of pci_enable_acs() are
silently dropped.

This also lets a later patch adopt the ACS controls established by a
previous kernel across a Live Update rather than assigning new ones
through pci_enable_acs().

Save and restore the Egress Control Vector as well to keep it in sync
with the Egress Control Enable bit in the ACS Control register, which is
now restored from saved state. The kernel never enables Egress Controls
or programs the vector, but the firmware could have and they need to be
kept in sync to avoid changing how P2P traffic is routed.

The Egress Control Vector Size is a HwInit field of the ACS Capability
register (PCIe r7.1, sec 7.7.12.2), so read it directly from the device
to size the save buffer in pci_allocate_cap_save_buffers(), similar to
how the VC capability relies on its HwInit fields.

pci_enable_acs() runs when a driver binds to a device
(pci_dma_configure()), i.e. after pci_bus_add_device() has already saved
the device's state. Refresh the saved ACS state there as well, otherwise
a subsequent reset would revert ACS back to the configuration left
behind by firmware.

Devices that rely on device-specific quirks to enable an ACS equivalent
keep that configuration outside of the ACS Control register, so don't
allocate an ACS save buffer for them. Keep configuring ACS from scratch
on restore for any device that has no saved ACS state.

Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Alex Williamson <alex.williamson@nvidia.com>
---
 drivers/pci/pci.c    | 152 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/pci/pci.h    |   5 ++
 drivers/pci/quirks.c |   7 ++
 3 files changed, 163 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba8144..fc4307a2327d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1021,6 +1021,145 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
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
+	/*
+	 * Devices that rely on device-specific quirks to enable an ACS
+	 * equivalent keep that configuration outside of the ACS Control
+	 * register, so they are configured from scratch on restore.
+	 */
+	if (pci_need_dev_specific_enable_acs(dev))
+		return;
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
+	if (dev->acs_cap)
+		save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ACS);
+
+	/*
+	 * Configure ACS from scratch for devices that have no saved ACS state,
+	 * e.g. devices that rely on device-specific quirks to enable an ACS
+	 * equivalent (see pci_allocate_acs_save_buffer()).
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
@@ -1057,6 +1196,15 @@ void pci_enable_acs(struct pci_dev *dev)
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
@@ -1825,6 +1973,7 @@ int pci_save_state(struct pci_dev *dev)
 	pci_save_aer_state(dev);
 	pci_save_ptm_state(dev);
 	pci_save_tph_state(dev);
+	pci_save_acs_state(dev);
 	return pci_save_vc_state(dev);
 }
 EXPORT_SYMBOL(pci_save_state);
@@ -1902,7 +2051,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_msi_state(dev);
 
 	/* Restore ACS and IOV configuration state */
-	pci_enable_acs(dev);
+	pci_restore_acs_state(dev);
 	pci_restore_iov_state(dev);
 
 	dev->state_saved = false;
@@ -3565,6 +3714,7 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 	if (error)
 		pci_err(dev, "unable to allocate suspend buffer for LTR\n");
 
+	pci_allocate_acs_save_buffer(dev);
 	pci_allocate_vc_save_buffers(dev);
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 77efa4c5c960..8fc4b18738bf 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1101,6 +1101,7 @@ void pci_acs_init(struct pci_dev *dev);
 void pci_enable_acs(struct pci_dev *dev);
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
+bool pci_need_dev_specific_enable_acs(struct pci_dev *dev);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
 int pci_dev_specific_disable_acs_redir(struct pci_dev *dev);
 void pci_disable_broken_acs_cap(struct pci_dev *pdev);
@@ -1111,6 +1112,10 @@ static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
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
index 0978be9c17db..7572b358b50f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5629,6 +5629,13 @@ static const struct pci_dev_acs_ops *pci_dev_acs_ops_get(struct pci_dev *dev)
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
2.56.1.703.gf848ed807c-goog


