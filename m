Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBBB606D80B
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 00:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JxvUcVqG;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QLMR+nb3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=L+Hzdt+LObwzKPIKo4htZh/cma3z4S09Q2AYbp2zhRQ=; b=JxvUcVqGkb3bBaQ7FSqAXAuKQC
	niAc9NIvzhz2BzPQf1KsgXDydS2ubmkXvfkwN9xyTqr1hCOOTX+19p30KvF7ELNCpTwirPQR3LDka
	IM8FWnulDfe3Uq3RWMb5j+8w3BhpzKEYTrcVBZgRXxJd3i8fMRWOmesNQhyPfVqGLTvybwbP1/mUf
	86KLGEcu6enrdwJYufrRZpkp6xIUNAB+Gw/n6AQKBE33zeHoeCUAaA5m5F3DJdCWZNpawLQqMebq5
	V77xLrzom/sTit40crWacCib6TQkzfejgPRsKBBF6Lz1GaUC2b0/khp0XuXkYT8ePjzFSakuKLHNV
	4JuGzmfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP82x-0000000AvqU-2a9g;
	Fri, 06 Nov 2026 00:43:11 +0000
Received: from mail-oi1-x246.google.com ([2607:f8b0:4864:20::246])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP82u-0000000Avjn-0reh
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 00:43:09 +0000
Received: by mail-oi1-x246.google.com with SMTP id 5614622812f47-4cc89e86e4dso86768b6e.2
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 16:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925787; x=1794530587; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L+Hzdt+LObwzKPIKo4htZh/cma3z4S09Q2AYbp2zhRQ=;
        b=QLMR+nb3+EK+BtHcRd+U0Akej/IESAy7GPCYdYB0CVPKI4mJOKd6VXqxNe8e5PU7jc
         obaG0+UAWh+f3wVdRc8tkOt6zqWkdqC1ZyNth4lxcfKTjK7qyoHHVpafvkm2P+iiAWHp
         gVKhG45XuWcxB4inhSjVupHSHXk6KKkzK7klyNR9QOpfW7+36Tmy8WNeiP3jGbljLE0u
         VM66Vf4U4CSY4zC1o4yFX7yOjwW2xhVxGc2cn4kxPrK1RxkbrzPwHVDurROvzd42Uyrp
         Dpi2U7CJh/3mCpCWU+KRXYfS0sHZPmMfEoW/aewoEOyx/YxZlXmRvvp2IAd+N2hrQLIt
         Li5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925787; x=1794530587;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L+Hzdt+LObwzKPIKo4htZh/cma3z4S09Q2AYbp2zhRQ=;
        b=Zj0bWNuUj0QaS/8TkUxtcYl8ngFANMQRnXFuLdLOFnCgixVMpGxHUXa1W2zmGh/w5H
         l+sr2Pn8ZaeNrQ4mtg0jsx6x0mwHi8TgENVDBf9Im064YrdBWw5lY/bv3iGkAvZxQHJv
         K8v7fHPfzGD2HR096shRNysBXtWHKR3chH+joNTOOZdTXgNVgqyPOaKI73w8DGahlOAC
         n7g4NyOJnKsFge8tAiaDAwrtuix764qPXp55mPOVfF03/iqrUzk15voZYFYZwRFhzPKK
         B0+UfVrpT9e4BZoMTKTePoNSSvfmRsd8Nuox53n+HQ7yT2OM+3kAdobRH4t0OUCPb5Up
         LQrg==
X-Gm-Message-State: APuU4Z+5990862mnsMJ2KWg6ohSJlrjvXV5G13kri+ARXfv5s0nkQeVy
	/8kbcuHMOhO7MwmqqVDaiX010Y/eFpOGV3LPXKH6R/JR5oy+hLPJ29WXhIyBdIaJE+thVB8Rb+D
	/wFjsOe4DYIVoDYLIeDvRgTlCwWLQ9qes7HwUq+ujyTcunUioO+muz+BXLt/pFIuqg1wRe510vv
	7U1AfUoS/80/nQdfGdJehFcSXAB5wMJWZw1SJgtrt75bVAWoP5uF4=
X-Received: from iozd24.prod.google.com ([2002:a05:6602:3298:b0:9c7:85f4:7637])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:23cf:b0:532:d9f5:1de6 with SMTP id 5614622812f47-567e182dc9fmr636250b6e.65.1793925786350;
 Thu, 05 Nov 2026 16:43:06 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:09 +0000
In-Reply-To: <20261106004218.604799-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261106004218.604799-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106004218.604799-9-dmatlack@google.com>
Subject: [PATCH v2 08/17] PCI/AER: Save AER state in the saved capability store
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
X-CRM114-CacheID: sfid-20261105_164308_257594_FFE5AF95 
X-CRM114-Status: GOOD (  17.02  )
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

Save and restore the AER mask, severity, capability and root command
registers through the per-device saved capability store instead of a
private pci_cap_saved_state buffer.

Describe the registers in aer_saved_regs[] and drive the reservation, save,
and restore loops from it. Previously the three had to be kept in the same
order by hand, and pci_aer_init() encoded the register count as a bare 4 or
5.

Reserve the registers in pci_reserve_aer_state(), called from
pci_aer_init(), and report a refused reservation. pci_aer_init() ignored
the return value of pci_add_ext_cap_save_buffer(), so a failed
allocation left AER state unsaved without any message. An allocation
failure is now reported once by pci_saved_caps_finalize().

No other functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pcie/aer.c | 85 +++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d8dcd238fda1..25436bcf9fb9 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -352,54 +352,68 @@ int pci_aer_clear_status(struct pci_dev *dev)
 	return pci_aer_raw_clear_status(dev);
 }
 
-void pci_save_aer_state(struct pci_dev *dev)
+/*
+ * AER registers saved and restored by the PCI core. PCI_ERR_ROOT_COMMAND is
+ * only implemented by Root Ports and Root Complex Event Collectors (PCIe
+ * r6.0, sec 7.8.4.9) and so must come last.
+ */
+static const u16 aer_saved_regs[] = {
+	PCI_ERR_UNCOR_MASK,
+	PCI_ERR_UNCOR_SEVER,
+	PCI_ERR_COR_MASK,
+	PCI_ERR_CAP,
+	PCI_ERR_ROOT_COMMAND,
+};
+
+static unsigned int aer_nr_saved_regs(struct pci_dev *dev)
 {
-	int aer = dev->aer_cap;
-	struct pci_cap_saved_state *save_state;
-	u32 *cap;
+	if (pcie_cap_has_rtctl(dev))
+		return ARRAY_SIZE(aer_saved_regs);
 
-	if (!aer)
-		return;
+	return ARRAY_SIZE(aer_saved_regs) - 1;
+}
 
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ERR);
-	if (!save_state)
+void pci_save_aer_state(struct pci_dev *dev)
+{
+	unsigned int i;
+
+	if (!dev->aer_cap)
 		return;
 
-	cap = &save_state->cap.data[0];
-	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, cap++);
-	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_SEVER, cap++);
-	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, cap++);
-	pci_read_config_dword(dev, aer + PCI_ERR_CAP, cap++);
-	if (pcie_cap_has_rtctl(dev))
-		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, cap++);
+	for (i = 0; i < aer_nr_saved_regs(dev); i++)
+		pci_save_cap_dword(dev, dev->aer_cap + aer_saved_regs[i]);
 }
 
 void pci_restore_aer_state(struct pci_dev *dev)
 {
-	int aer = dev->aer_cap;
-	struct pci_cap_saved_state *save_state;
-	u32 *cap;
+	unsigned int i;
 
-	if (!aer)
+	if (!dev->aer_cap)
 		return;
 
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ERR);
-	if (!save_state)
-		return;
+	for (i = 0; i < aer_nr_saved_regs(dev); i++)
+		pci_restore_cap_dword(dev, dev->aer_cap + aer_saved_regs[i]);
+}
 
-	cap = &save_state->cap.data[0];
-	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, *cap++);
-	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_SEVER, *cap++);
-	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, *cap++);
-	pci_write_config_dword(dev, aer + PCI_ERR_CAP, *cap++);
-	if (pcie_cap_has_rtctl(dev))
-		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, *cap++);
+static void pci_reserve_aer_state(struct pci_dev *dev)
+{
+	unsigned int i;
+	int rc;
+
+	for (i = 0; i < aer_nr_saved_regs(dev); i++) {
+		unsigned int off = dev->aer_cap + aer_saved_regs[i];
+
+		rc = pci_reserve_saved_cap(dev, off, sizeof(u32));
+		if (rc) {
+			pci_err(dev, "unable to reserve AER save state (%pe)\n",
+				ERR_PTR(rc));
+			return;
+		}
+	}
 }
 
 void pci_aer_init(struct pci_dev *dev)
 {
-	int n;
-
 	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
 	if (!dev->aer_cap)
 		return;
@@ -415,14 +429,7 @@ void pci_aer_init(struct pci_dev *dev)
 	ratelimit_state_init(&dev->aer_info->nonfatal_ratelimit,
 			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
 
-	/*
-	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
-	 * PCI_ERR_COR_MASK, and PCI_ERR_CAP.  Root and Root Complex Event
-	 * Collectors also implement PCI_ERR_ROOT_COMMAND (PCIe r6.0, sec
-	 * 7.8.4.9).
-	 */
-	n = pcie_cap_has_rtctl(dev) ? 5 : 4;
-	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR, sizeof(u32) * n);
+	pci_reserve_aer_state(dev);
 
 	/*
 	 * Advisory Non-Fatal Errors are masked by default (PCIe r7.0, sec
-- 
2.56.0.455.g6c5a503b38-goog


