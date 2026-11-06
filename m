Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BB6606D82C
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 00:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yHPiYMsM;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FFVADn0z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fdvOmig1mqmuQ5cGPPo+aA7C4UMwvpl0I/Lv9SSRV3g=; b=yHPiYMsMKqY0MPy3P+DXrUtJnb
	dtJpWBO/wX0fA/2ftIU0X0ts7UAu1jfdYzV38ti1jp7Ho9QAlVwq07F5ERMJPdQE410jW84Foktsi
	hNTQyHXLUld6Fqdw9cXsgLu2bD4cCloK35OAkuhaZrTD9K9Pd0oPh7pYDsB4QoLE430OGLNb6MVHz
	VRDv4qUJQFEwSxSMZ6K2Nws/cxi993OjsicRo7wgtwu2lKG6AsHbUYDruNMl6hOcmEHTpHiyXRTcE
	I+fZNBiFyzNxlzxnSqhJwP83QH2Gsir/uCGqRmuk1c9OqpXE6+n8jEP69B+FsPLGeWRdL/9ZV4eI1
	hCuNZbfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP82r-0000000Avhp-3EFT;
	Fri, 06 Nov 2026 00:43:05 +0000
Received: from mail-oo1-xc46.google.com ([2607:f8b0:4864:20::c46])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP82p-0000000AveK-0gcw
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 00:43:04 +0000
Received: by mail-oo1-xc46.google.com with SMTP id 006d021491bc7-6f538c3453fso1448921eaf.1
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 16:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925782; x=1794530582; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fdvOmig1mqmuQ5cGPPo+aA7C4UMwvpl0I/Lv9SSRV3g=;
        b=FFVADn0zS8kgh3wl5aVfROdJsxlNz9PjYjI5kANCM2UtJldzqGn03LRKdLGttLRQGA
         u/8ikKo++AtCcrkBTGfY5hLMxv6jNvrj++rZgLdpbBSx1IQZ4cNZkoO0Fk5K4PaA/dcn
         SJFtx84ZxaQEtYZ82I+bCcMeP9tbChPG0aJR5uB8FaYyL7vdYqsb+ZH1QipVElGsHrTh
         8vIYCNBt4TiCH84AzR3Tr7flkL2J25hA+HwPY38GKLIONuE5YyBXLGweKm2S/K2BUF0H
         a8HrTJVchVckimyDXBnYK/CsVJKcoJtYWW9k+wLJ/fFBV1/fmjfaxH2HCXbmfuGDBLyE
         U1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925782; x=1794530582;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdvOmig1mqmuQ5cGPPo+aA7C4UMwvpl0I/Lv9SSRV3g=;
        b=USJCk49CZD37oOnBeFPr02vE5yKvVchY4N8wRN2OHUQPyW5sh2JPKLfpzASdOQqRZ6
         hJRbRed2bYG7ITM5Ukal0c7fTQWsc9iv+34U+fC2iXgqjbYVCvZJajyiLyyIYfTm5eDW
         U9Hmm0aMh0TruM1ko4CQ7p4R5Qlr57xGWaoJlaFELlb2qgg/U97vJmk34LPyrySZ6m18
         GKNneU6z/1g5/EEkozHuJjCMxRaLL9Df2BpY1rMRanNMW2AnXjIvqpq8jHKXwjR2uvA0
         hnG/gZaIpr5hfGVIwGEqRcYoOoAa6BRqAV1rzYN+UGdBIquDPUVxV40Yfqx0GX5GWDhL
         UKpQ==
X-Gm-Message-State: APuU4Z97sJrCPj1r9qxFj/siGxecS13GXmqBmtU9CL9pVDaa5cgxR5b2
	uETY8RMfXku/24NI3ejdoqLyrYhQbPNfTgVDiRviWIy00EiAmwvT70zFCV6tAif09CDlJM62zhu
	FR8WUtFyqRGAmJ32FylTTD5E5Mk7SdAQLGAn9yuboyuTtp/T2gAO5qVAokgHpccEANPk4Jlz9y0
	cvpMR32KIvwrI+QcTp8C/ouq8oI6dOJjLiSO1bSIff9RM00v2PlLM=
X-Received: from iobmm28-n2.prod.google.com ([2002:a05:6602:711c:20b0:9e0:ee3f:c3a])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:290f:b0:6d3:abd1:9b87 with SMTP id 006d021491bc7-716d221fc2emr2597233eaf.45.1793925781387;
 Thu, 05 Nov 2026 16:43:01 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:05 +0000
In-Reply-To: <20261106004218.604799-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261106004218.604799-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106004218.604799-5-dmatlack@google.com>
Subject: [PATCH v2 04/17] PCI: Save PCIe state in the saved capability store
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
X-CRM114-CacheID: sfid-20261105_164303_225876_84495251 
X-CRM114-Status: GOOD (  27.59  )
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

Save and restore the PCIe capability control registers through the
per-device saved capability store instead of a private pci_cap_saved_state
buffer.

The private buffer is an opaque array of u16s whose layout is a contract
between pci_save_pcie_state() and pci_restore_pcie_state(). Anything else
that needs to touch the saved state has to know that contract, e.g.
pci_update_aspm_saved_state() patches the saved Link Control register with
a comment reminding the reader that cap[1] is LNKCTL. Indexing the saved
state by configuration space offset removes the coupling.

Describe the registers to save in pcie_saved_regs[] and drive the
reservation, save, and restore loops from it so that the three can no
longer disagree about which register is where. Reserve the registers in
pci_reserve_pcie_state(), named to match pci_save_pcie_state() and
pci_restore_pcie_state().

Reserve the registers based on pci_is_pcie() rather than
pci_find_capability(PCI_CAP_ID_EXP), so that a device whose capability
list is broken but whose pcie_cap a quirk has fixed up gets saved state
like any other PCIe device. Drop the save buffer that
quirk_intel_qat_vf_cap() builds by hand, since it is no longer needed.

Keep using pcie_capability_read_word() and pcie_capability_write_word() to
access the hardware so that registers the device does not implement are
skipped. Reserve space for all of the registers regardless; that is
harmless, since an unimplemented register reads back as zero and is
never written.

Make pci_save_pcie_state() void, so pci_save_state() no longer fails with
-ENOMEM when the PCIe save buffer is missing. A failure to allocate the
store is reported once during device setup instead.

No other functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci.c       | 92 +++++++++++++++++++++++------------------
 drivers/pci/pcie/aspm.c | 16 +++----
 drivers/pci/quirks.c    | 30 +-------------
 3 files changed, 59 insertions(+), 79 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 007f9bb289d5..fde1dcd99e94 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1795,7 +1795,20 @@ int pci_set_power_state_locked(struct pci_dev *dev, pci_power_t state)
 }
 EXPORT_SYMBOL(pci_set_power_state_locked);
 
-#define PCI_EXP_SAVE_REGS	7
+/*
+ * PCIe capability registers saved and restored by the PCI core. Registers a
+ * device does not implement are skipped by the pcie_capability_*() accessors,
+ * so space is reserved for all of them regardless of the device.
+ */
+static const u16 pcie_saved_regs[] = {
+	PCI_EXP_DEVCTL,
+	PCI_EXP_LNKCTL,
+	PCI_EXP_SLTCTL,
+	PCI_EXP_RTCTL,
+	PCI_EXP_DEVCTL2,
+	PCI_EXP_LNKCTL2,
+	PCI_EXP_SLTCTL2,
+};
 
 static struct pci_cap_saved_state *_pci_find_saved_cap(struct pci_dev *pci_dev,
 						       u16 cap, bool extended)
@@ -1819,41 +1832,47 @@ struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev, u16 cap)
 	return _pci_find_saved_cap(dev, cap, true);
 }
 
-static int pci_save_pcie_state(struct pci_dev *dev)
+static void pci_save_pcie_state(struct pci_dev *dev)
 {
-	int i = 0;
-	struct pci_cap_saved_state *save_state;
-	u16 *cap;
+	unsigned int i;
+	u16 val;
 
 	if (!pci_is_pcie(dev))
-		return 0;
+		return;
 
-	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
-	if (!save_state) {
-		pci_err(dev, "buffer not found in %s\n", __func__);
-		return -ENOMEM;
+	for (i = 0; i < ARRAY_SIZE(pcie_saved_regs); i++) {
+		pcie_capability_read_word(dev, pcie_saved_regs[i], &val);
+		pci_write_saved_cap_word(dev, dev->pcie_cap + pcie_saved_regs[i],
+					 val);
 	}
 
-	cap = (u16 *)&save_state->cap.data[0];
-	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &cap[i++]);
-	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &cap[i++]);
-	pcie_capability_read_word(dev, PCI_EXP_SLTCTL, &cap[i++]);
-	pcie_capability_read_word(dev, PCI_EXP_RTCTL,  &cap[i++]);
-	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &cap[i++]);
-	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &cap[i++]);
-	pcie_capability_read_word(dev, PCI_EXP_SLTCTL2, &cap[i++]);
-
 	pci_save_aspm_l1ss_state(dev);
 	pci_save_ltr_state(dev);
+}
 
-	return 0;
+static void pci_reserve_pcie_state(struct pci_dev *dev)
+{
+	unsigned int i;
+	int rc;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(pcie_saved_regs); i++) {
+		unsigned int off = dev->pcie_cap + pcie_saved_regs[i];
+
+		rc = pci_reserve_saved_cap(dev, off, sizeof(u16));
+		if (rc) {
+			pci_err(dev, "unable to reserve PCI Express save state (%pe)\n",
+				ERR_PTR(rc));
+			return;
+		}
+	}
 }
 
 static void pci_restore_pcie_state(struct pci_dev *dev)
 {
-	int i = 0;
-	struct pci_cap_saved_state *save_state;
-	u16 *cap;
+	unsigned int i;
 
 	/*
 	 * Restore max latencies (in the LTR capability) before enabling
@@ -1862,8 +1881,7 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 	pci_restore_ltr_state(dev);
 	pci_restore_aspm_l1ss_state(dev);
 
-	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
-	if (!save_state)
+	if (!pci_is_pcie(dev))
 		return;
 
 	/*
@@ -1873,14 +1891,13 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 	 */
 	pci_bridge_reconfigure_ltr(dev);
 
-	cap = (u16 *)&save_state->cap.data[0];
-	pcie_capability_write_word(dev, PCI_EXP_DEVCTL, cap[i++]);
-	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, cap[i++]);
-	pcie_capability_write_word(dev, PCI_EXP_SLTCTL, cap[i++]);
-	pcie_capability_write_word(dev, PCI_EXP_RTCTL, cap[i++]);
-	pcie_capability_write_word(dev, PCI_EXP_DEVCTL2, cap[i++]);
-	pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, cap[i++]);
-	pcie_capability_write_word(dev, PCI_EXP_SLTCTL2, cap[i++]);
+	for (i = 0; i < ARRAY_SIZE(pcie_saved_regs); i++) {
+		u16 reg = pcie_saved_regs[i];
+		u16 val;
+
+		if (pci_read_saved_cap_word(dev, dev->pcie_cap + reg, &val))
+			pcie_capability_write_word(dev, reg, val);
+	}
 }
 
 static int pci_save_pcix_state(struct pci_dev *dev)
@@ -1935,9 +1952,7 @@ int pci_save_state(struct pci_dev *dev)
 	}
 	dev->state_saved = true;
 
-	i = pci_save_pcie_state(dev);
-	if (i != 0)
-		return i;
+	pci_save_pcie_state(dev);
 
 	i = pci_save_pcix_state(dev);
 	if (i != 0)
@@ -3733,10 +3748,7 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 {
 	int error;
 
-	error = pci_add_cap_save_buffer(dev, PCI_CAP_ID_EXP,
-					PCI_EXP_SAVE_REGS * sizeof(u16));
-	if (error)
-		pci_err(dev, "unable to preallocate PCI Express save buffer\n");
+	pci_reserve_pcie_state(dev);
 
 	error = pci_add_cap_save_buffer(dev, PCI_CAP_ID_PCIX, sizeof(u16));
 	if (error)
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 95ac34a34bd5..02922b887ec6 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -324,26 +324,20 @@ static int policy_to_clkpm_state(struct pcie_link_state *link)
 
 static void pci_update_aspm_saved_state(struct pci_dev *dev)
 {
-	struct pci_cap_saved_state *save_state;
-	u16 *cap, lnkctl, aspm_ctl;
-
-	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
-	if (!save_state)
-		return;
+	u16 lnkctl, aspm_ctl;
 
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
 
 	/*
-	 * Update ASPM and CLKREQ bits of LNKCTL in save_state. We only
+	 * Update ASPM and CLKREQ bits of LNKCTL in the saved state. We only
 	 * write PCI_EXP_LNKCTL_CCC during enumeration, so it shouldn't
-	 * change after being captured in save_state.
+	 * change after being captured in the saved state.
 	 */
 	aspm_ctl = lnkctl & (PCI_EXP_LNKCTL_ASPMC | PCI_EXP_LNKCTL_CLKREQ_EN);
 	lnkctl &= ~(PCI_EXP_LNKCTL_ASPMC | PCI_EXP_LNKCTL_CLKREQ_EN);
 
-	/* Depends on pci_save_pcie_state(): cap[1] is LNKCTL */
-	cap = (u16 *)&save_state->cap.data[0];
-	cap[1] = lnkctl | aspm_ctl;
+	pci_write_saved_cap_word(dev, dev->pcie_cap + PCI_EXP_LNKCTL,
+				 lnkctl | aspm_ctl);
 }
 
 static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e500c202d2ec..9203ffb2ff72 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5512,10 +5512,9 @@ int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
  */
 static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
 {
-	int pos, i = 0, ret;
+	int pos, ret;
 	u8 next_cap;
-	u16 reg16, *cap;
-	struct pci_cap_saved_state *state;
+	u16 reg16;
 
 	/* Bail if the hardware bug is fixed */
 	if (pdev->pcie_cap || pci_find_capability(pdev, PCI_CAP_ID_EXP))
@@ -5546,10 +5545,6 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
 	pci_read_config_word(pdev, pos, &reg16);
 	if (reg16 == (0x0000 | PCI_CAP_ID_EXP)) {
 		u32 status;
-#ifndef PCI_EXP_SAVE_REGS
-#define PCI_EXP_SAVE_REGS     7
-#endif
-		int size = PCI_EXP_SAVE_REGS * sizeof(u16);
 
 		pdev->pcie_cap = pos;
 		pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
@@ -5561,27 +5556,6 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
 		ret = pci_read_config_dword(pdev, PCI_CFG_SPACE_SIZE, &status);
 		if ((ret != PCIBIOS_SUCCESSFUL) || (PCI_POSSIBLE_ERROR(status)))
 			pdev->cfg_size = PCI_CFG_SPACE_SIZE;
-
-		if (pci_find_saved_cap(pdev, PCI_CAP_ID_EXP))
-			return;
-
-		/* Save PCIe cap */
-		state = kzalloc(sizeof(*state) + size, GFP_KERNEL);
-		if (!state)
-			return;
-
-		state->cap.cap_nr = PCI_CAP_ID_EXP;
-		state->cap.cap_extended = 0;
-		state->cap.size = size;
-		cap = (u16 *)&state->cap.data[0];
-		pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap[i++]);
-		pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &cap[i++]);
-		pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &cap[i++]);
-		pcie_capability_read_word(pdev, PCI_EXP_RTCTL,  &cap[i++]);
-		pcie_capability_read_word(pdev, PCI_EXP_DEVCTL2, &cap[i++]);
-		pcie_capability_read_word(pdev, PCI_EXP_LNKCTL2, &cap[i++]);
-		pcie_capability_read_word(pdev, PCI_EXP_SLTCTL2, &cap[i++]);
-		hlist_add_head(&state->next, &pdev->saved_cap_space);
 	}
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
-- 
2.56.0.455.g6c5a503b38-goog


