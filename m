Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E826606D809
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 00:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=R2RgY4lC;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HRFasOw2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=mFWOpusTgBwcgTKpEgyRpVaqUUx06BhmoFjl8K/HM58=; b=R2RgY4lCIe/pdI8W/DiS85M1o3
	6R0PcsOEeUiuWhWZ6ielPEorpA/LNSt65FQNIla8+pZh4kMPLabiB1VRKW29fsrVq7iYXxp8eia/+
	DvAnbJKNX7fGV8aclLT4sN/be+Nr5M3QF2j+rBvIucEw7ReBeio3wAOBngnc8h5Jp2sXukDLjOcEJ
	77cn9Re5vZvp0jLhR5ogWjOiqPq6mOnqXPFHlqaRl7E3L5b+G4jG7RifeIStrlChZqIPNtZOBApsE
	FfyUjtYcVTdiRbiAi+ba2CYME2Q/NxZBYwwbdShiuFx2DO7aqzyEkukyhuaP7KXEhKOQfrjadEQKG
	5LxEsY0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP835-0000000Aw3P-3dcK;
	Fri, 06 Nov 2026 00:43:19 +0000
Received: from mail-oi1-x245.google.com ([2607:f8b0:4864:20::245])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP830-0000000AvsK-1aHs
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 00:43:18 +0000
Received: by mail-oi1-x245.google.com with SMTP id 5614622812f47-4eb0b989f0eso197516b6e.0
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 16:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925792; x=1794530592; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mFWOpusTgBwcgTKpEgyRpVaqUUx06BhmoFjl8K/HM58=;
        b=HRFasOw2rzStud2/FyAPukW6s7TRuIucFixz9b9BUrT0U32Blu7TfgIwjhKTrjFobN
         idwPa896A+3l6Kw32z7QSpMNpkCEVUN+0hOamxaFKpxXNpFh74P9VAxY2plnvu9JekqR
         SGJi11a56RIAWk7OwbVlEveogFoEd1YmmYjR/vpdJeBgWkT8CWWjRCJOwFU760ds260/
         JenqjmDwkVM/aKG3IqylvtxXqv5qdqpC6so3botsjEsci9J8YjNKmV6VddoYNxBbV5+M
         mmVsOND6B+dudyvC24z/+/OMcRJXCLdx4sNPSh3/1ArHgFZzj0VMxNn2jzfs4CLIBCz1
         aODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925792; x=1794530592;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mFWOpusTgBwcgTKpEgyRpVaqUUx06BhmoFjl8K/HM58=;
        b=gkrLOSZott9XPOdW1OQwijR9ZcRJVXhY1CHov7nzmOTuxuAoSHqyjKywtS1WS8iD0k
         0JF2m5cS7dAHubXbYYRsBpKoBBlmYz/1TR7EuKPIaWi2rceiIae/cEMs01T+ygF7Eccx
         EZegenzF+ED82EkxH4pnNsRUFngqXF/KH//WjIULUhuk6K0gWD82y5xARY00DPF9I8t/
         11IOrtDcDxI0Z9l0HjASS0xSS3daymXufi06LOK8odGWYGM4gvShG0oUglOsuSL9y40D
         OpSBY73iAvkJ4uyyBfO8kn4XBtTn8BPsmsvM2MVPuhktzWGIR978YZ6zfsTzjujhaxxp
         oxJQ==
X-Gm-Message-State: APuU4Z9tCecEzUH0XIHEjAu6pys/2zKlebfDyyPe4fSxJMtx0Ee4yNoS
	/BAy8Rmpq3SGlu4Uy0DOqpO12MT8+FFGjANSp27gyMU46NrNkHTXLUsNDjBndAFdHxzww/3cwPS
	0nFFk5esJW5P0PWEah8gYcm64jM6StAuznkzSga2o2K0Zl7p/5gwDVkhagTlZkURLH/f5LBRETN
	wdXduHmgofKRLonJ4AOYNSQHoG3ydgZ8VWKLM2kNfMY1iUhta4ZzQ=
X-Received: from ilbeb27.prod.google.com ([2002:a05:6e02:461b:b0:520:6d86:da98])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1686:b0:546:306d:45eb with SMTP id 5614622812f47-567be662ce8mr2365687b6e.35.1793925791448;
 Thu, 05 Nov 2026 16:43:11 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:13 +0000
In-Reply-To: <20261106004218.604799-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261106004218.604799-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106004218.604799-13-dmatlack@google.com>
Subject: [PATCH v2 12/17] PCI: Save ACS state in the saved capability store
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Lukas Wunner <lukas@wunner.de>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_164314_584426_32B01AA4 
X-CRM114-Status: GOOD (  28.70  )
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

Save and restore the ACS Control register and the ACS Egress Control
Vector through the per-device saved capability store instead of a
private pci_cap_saved_state buffer.

Rename pci_allocate_acs_save_buffer() to pci_reserve_acs_state(), to
match pci_save_acs_state() and pci_restore_acs_state().

Reserve the Egress Control Vector using the size the device reports in
its HwInit ACS Capability register during setup, as the save buffer was
sized before. Save or restore the vector only if all of it is reserved,
since its size is read from the device again each time.

pci_liveupdate_adopt_acs() checked for the ACS save buffer to make sure
adopted controls would survive a later reset. Check that the ACS
Control register has room in the store instead, which also fails if the
store could not be allocated.

No functional change intended for devices whose Egress Control Vector
size does not change after setup.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 15 +++----
 drivers/pci/pci.c        | 87 ++++++++++++++++++----------------------
 2 files changed, 46 insertions(+), 56 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 6f92d4ddca2b..8334e6fdd3ec 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -932,14 +932,15 @@ int pci_liveupdate_adopt_acs(struct pci_dev *dev)
 
 	/*
 	 * Adopting the previous kernel's controls depends on them being
-	 * captured in the ACS save buffer, so that they are reapplied if the
-	 * device is later reset. Without that buffer, e.g. because it could
-	 * not be allocated under memory pressure, the adopted controls would
-	 * be silently lost by the first reset. Program ACS from scratch
-	 * instead, which is a better outcome than leaving ACS disabled.
+	 * captured in the saved capability store, so that they are reapplied
+	 * if the device is later reset. Without room in the store, e.g.
+	 * because it could not be allocated under memory pressure, the adopted
+	 * controls would be silently lost by the first reset. Program ACS from
+	 * scratch instead, which is a better outcome than leaving ACS disabled.
 	 */
-	if (dev->acs_cap && !pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ACS)) {
-		pci_err(dev, "No ACS save buffer, not adopting ACS controls\n");
+	if (dev->acs_cap &&
+	    !pci_saved_cap_reserved(dev, dev->acs_cap + PCI_ACS_CTRL)) {
+		pci_err(dev, "No ACS save state, not adopting ACS controls\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 29d9474db1ae..977b7dbd19ce 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1023,15 +1023,6 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 		caps->ctrl |= (dev->acs_capabilities & PCI_ACS_TB);
 }
 
-/*
- * Layout of the ACS save buffer. @ecv holds the ACS Egress Control Vector, if
- * implemented, and is sized by pci_allocate_acs_save_buffer().
- */
-struct pci_acs_saved_state {
-	u16 ctrl;
-	u32 ecv[];
-};
-
 /*
  * Return the number of DWORDs in the ACS Egress Control Vector, or 0 if the
  * device does not implement P2P Egress Control. The Egress Control Vector
@@ -1055,30 +1046,44 @@ static unsigned int pci_acs_ecv_dwords(struct pci_dev *dev, int pos)
 }
 
 /*
- * Return the number of Egress Control Vector DWORDs held in @save_state, as
- * sized by pci_allocate_acs_save_buffer().
+ * Return the number of Egress Control Vector DWORDs that are reserved in the
+ * saved capability store, or 0 if the device does not implement P2P Egress
+ * Control or the vector was not reserved in full, e.g. because the device
+ * reports a different size than it did during setup.
  */
-static unsigned int
-pci_acs_saved_ecv_dwords(struct pci_cap_saved_state *save_state)
+static unsigned int pci_acs_saved_ecv_dwords(struct pci_dev *dev)
 {
-	return (save_state->cap.size -
-		offsetof(struct pci_acs_saved_state, ecv)) / sizeof(u32);
+	int pos = dev->acs_cap + PCI_ACS_EGRESS_CTL_V;
+	unsigned int i, dwords;
+
+	dwords = pci_acs_ecv_dwords(dev, dev->acs_cap);
+	for (i = 0; i < dwords; i++) {
+		if (!pci_saved_cap_reserved(dev, pos + i * sizeof(u32)))
+			return 0;
+	}
+
+	return dwords;
 }
 
-static void pci_allocate_acs_save_buffer(struct pci_dev *dev)
+static void pci_reserve_acs_state(struct pci_dev *dev)
 {
-	size_t size;
-	int pos;
+	unsigned int dwords;
+	int pos, rc;
 
 	/* dev->acs_cap is not set yet, pci_acs_init() runs later */
 	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
 	if (!pos)
 		return;
 
-	size = struct_size_t(struct pci_acs_saved_state, ecv,
-			     pci_acs_ecv_dwords(dev, pos));
-	if (pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ACS, size))
-		pci_err(dev, "unable to allocate suspend buffer for ACS\n");
+	rc = pci_reserve_saved_cap(dev, pos + PCI_ACS_CTRL, sizeof(u16));
+
+	dwords = pci_acs_ecv_dwords(dev, pos);
+	if (!rc && dwords)
+		rc = pci_reserve_saved_cap(dev, pos + PCI_ACS_EGRESS_CTL_V,
+					   dwords * sizeof(u32));
+	if (rc)
+		pci_err(dev, "unable to reserve ACS save state (%pe)\n",
+			ERR_PTR(rc));
 }
 
 /**
@@ -1090,27 +1095,19 @@ static void pci_allocate_acs_save_buffer(struct pci_dev *dev)
  */
 static void pci_save_acs_state(struct pci_dev *dev)
 {
-	struct pci_cap_saved_state *save_state;
-	struct pci_acs_saved_state *acs;
 	unsigned int i, dwords;
 	int ecv_pos;
 
-	if (!dev->acs_cap)
-		return;
-
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ACS);
-	if (!save_state)
+	if (!dev->acs_cap ||
+	    !pci_saved_cap_reserved(dev, dev->acs_cap + PCI_ACS_CTRL))
 		return;
 
-	acs = (struct pci_acs_saved_state *)save_state->cap.data;
-
-	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &acs->ctrl);
+	pci_save_cap_word(dev, dev->acs_cap + PCI_ACS_CTRL);
 
 	ecv_pos = dev->acs_cap + PCI_ACS_EGRESS_CTL_V;
-	dwords = pci_acs_saved_ecv_dwords(save_state);
+	dwords = pci_acs_saved_ecv_dwords(dev);
 	for (i = 0; i < dwords; i++)
-		pci_read_config_dword(dev, ecv_pos + i * sizeof(u32),
-				      &acs->ecv[i]);
+		pci_save_cap_dword(dev, ecv_pos + i * sizeof(u32));
 }
 
 /**
@@ -1120,14 +1117,9 @@ static void pci_save_acs_state(struct pci_dev *dev)
  */
 static void pci_restore_acs_state(struct pci_dev *dev)
 {
-	struct pci_cap_saved_state *save_state = NULL;
-	struct pci_acs_saved_state *acs;
 	unsigned int i, dwords;
 	int ecv_pos;
 
-	if (dev->acs_cap && !pci_need_dev_specific_enable_acs(dev))
-		save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ACS);
-
 	/*
 	 * Devices that rely on device-specific quirks to enable an ACS
 	 * equivalent keep that configuration outside of the ACS Control
@@ -1135,25 +1127,23 @@ static void pci_restore_acs_state(struct pci_dev *dev)
 	 * ACS from scratch instead, which also covers devices that have no
 	 * saved ACS state at all.
 	 */
-	if (!save_state) {
+	if (!dev->acs_cap || pci_need_dev_specific_enable_acs(dev) ||
+	    !pci_saved_cap_reserved(dev, dev->acs_cap + PCI_ACS_CTRL)) {
 		pci_enable_acs(dev);
 		return;
 	}
 
-	acs = (struct pci_acs_saved_state *)save_state->cap.data;
-
 	/*
 	 * Restore the Egress Control Vector before the ACS Control register.
 	 * The vector resets to zero, so enabling P2P Egress Control first
 	 * would briefly apply the reset vector instead of the saved one.
 	 */
 	ecv_pos = dev->acs_cap + PCI_ACS_EGRESS_CTL_V;
-	dwords = pci_acs_saved_ecv_dwords(save_state);
+	dwords = pci_acs_saved_ecv_dwords(dev);
 	for (i = 0; i < dwords; i++)
-		pci_write_config_dword(dev, ecv_pos + i * sizeof(u32),
-				       acs->ecv[i]);
+		pci_restore_cap_dword(dev, ecv_pos + i * sizeof(u32));
 
-	pci_write_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, acs->ctrl);
+	pci_restore_cap_word(dev, dev->acs_cap + PCI_ACS_CTRL);
 }
 
 /**
@@ -3745,8 +3735,7 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 	pci_reserve_pcie_state(dev);
 	pci_reserve_pcix_state(dev);
 	pci_reserve_ltr_state(dev);
-
-	pci_allocate_acs_save_buffer(dev);
+	pci_reserve_acs_state(dev);
 	pci_allocate_vc_save_buffers(dev);
 }
 
-- 
2.56.0.455.g6c5a503b38-goog


