Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34DF6083606
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 00:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Nnunw8s0;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=NeMxuYIi;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HDLlhV1m
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3JJl39F63y3SirttphQEe4w7X+WUU3z5RGbTvp5h2uY=; b=Nnunw8s0iVTdBRJRKt8yyZ1FFT
	IyZdWN4LPCJGLXdms1caLDAP/tOqBI/y9FeoN3JKfZ/kxT9Yb/qozbQMIF8p7lNUmhUXByqkWkOGd
	nID8H4HLLf8317jF5/WZFKX6OhdHgvzah4x5BQO1+bxq5UJIhpHPM/FVJZTW6SM3K1vHY0n643cl8
	gRZHaDxk1TGdNt4QuMaGqcQI9SYp9x5AEy1pL2jgyWTWarFAZX0yIkcfR0AsEwc2VgcQmWByHa43T
	F24RyuUMzzrbgneDS5mQ7QO/7WvNqVC0qu1Ob4J6NPdmG3vl2ZOSxF/xkZeR90rnlkuNSEd1oviYZ
	AFmjpjxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP83B-0000000Aw9n-1uAt;
	Fri, 06 Nov 2026 00:43:25 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP839-0000000Aw75-2Gke
	for kexec@bombadil.infradead.org;
	Fri, 06 Nov 2026 00:43:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3JJl39F63y3SirttphQEe4w7X+WUU3z5RGbTvp5h2uY=; b=NeMxuYIirr4KuyZTFExPc5bSys
	OmvLA3UxRe0LQgrmKk0x5XOe3nxOHiql9KDBtO75KoEXEXM7DvvOQSTgutTownk1l9OZ3Z1Xe/7pT
	EDuUqKys1kHI8gijWhSiQiJ6NoRT1j05npcz2cgkMjiB3EkNja9xo65gvhTfHBhjzCdxL14QadbKP
	BbRjiNjVkwFqQ2XvNs22qD4W5LB4O/XJiK/u7r8QBMFC630ZpbsePZDPQab7G1HUU7wfs0LZkV9A7
	WbqG+2wKdJrdQIEbtkEYWtU54qQzWsGU26wMWEEY7T1Ae/ZEjmecL7V2WiRBCj1cC3NXeBWc72iDb
	DHr5UA9g==;
Received: from mail-ot1-x347.google.com ([2607:f8b0:4864:20::347])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP833-00000003hb0-3psg
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 00:43:21 +0000
Received: by mail-ot1-x347.google.com with SMTP id 46e09a7af769-8490253aeb6so252944a34.0
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 16:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925796; x=1794530596; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3JJl39F63y3SirttphQEe4w7X+WUU3z5RGbTvp5h2uY=;
        b=HDLlhV1mWmjkVnrmIBA+E/jcfxsTp1l4ZAx2FzZjKjd9ONMGAnORIvQj/8YPheT/CR
         8Tm14t44VLF0kdcSFBapbMjr3rimfHZjiN+QM8g80sV/cyIW3A8cpaHIxap6SUl76izs
         51iLV1NmH7Zm/TMHkO1VtNsVNfYWm4K4XfdPenZhiW/cg4WmZ4FMaPdySZMLY0A/MqWj
         h+4ClxpWVOajr9a3Pl3a9rZNhzOPg3hDgmbAVNQjiyLyOjBw0YAlcxxU1vpdisAulTLa
         U90oOayfc5ZQP4VTcZ23fdG8NZ0CJDFkpiCrzqr6feexbjaKU3KTzcolQO3J1hOlytrv
         BUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925796; x=1794530596;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3JJl39F63y3SirttphQEe4w7X+WUU3z5RGbTvp5h2uY=;
        b=AqXoG2Bs7Dk44w10vYP1DjxGfPNYt11icv6Isw41kHmwzaSruSLF1AeZgY9tniIGFA
         T0VbI/AAzcfv36BhbBQXeG6c4FCEEYGMsiuFYM5rRcfgrNnAnSjmD4dtE5IWs4dPgUmv
         GpbRNFCbDZGMzAfAGqH7ypKt0Yg5Jo+W2jIVnjBduQKbs/avCnKFZpCU/dQ3YqxiU7nG
         JZgsaeT4o8y4qtBODvsB9/FRX6YTzV+eg9sBxuEWiaDNunk/inqv5hPnn7MwpNJ1cO96
         sKlJjjxrg24DO9dNbVH7BOsu3+zHN5xqNV2H/jGGArqhHDd/JmrPynnOao7NpJ93gg0+
         11NA==
X-Gm-Message-State: APuU4Z+G39KoEFUCY8Eaj2yrn8tMWN2E2TCNAy2vKiqJWkoFRmpzQt9+
	jOre+A1q5wKvIIaPtnCvR2snYpo9z5XgH5wE5SF1zjGIIVUWmLBTU0N7f3tkzRuheMv31nx2bue
	JFGL9pEZ7th3rBYZd8lISma4VmIcFaYzWVds1HrhZbam0n0jw4MRqgCBD67HgK+znyk6lNSyeqK
	0qwCfvDploYYBRJRFwjKJKrbva6l++4TWRT5QX0g8b2x/KND435eY=
X-Received: from ilbeb25.prod.google.com ([2002:a05:6e02:4619:b0:520:7cb4:c683])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:130a:b0:4d6:9293:9b56 with SMTP id 5614622812f47-567e19af850mr560176b6e.62.1793925795071;
 Thu, 05 Nov 2026 16:43:15 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:16 +0000
In-Reply-To: <20261106004218.604799-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261106004218.604799-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106004218.604799-16-dmatlack@google.com>
Subject: [PATCH v2 15/17] PCI: Save reserved capability registers in a single pass
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
X-CRM114-CacheID: sfid-20261106_004320_262075_AABF3E6B 
X-CRM114-Status: GOOD (  25.62  )
X-Spam-Score: -7.6 (-------)
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

Save every reserved capability register in pci_save_state() with one
walk of the reservation bitmap instead of a save function per
capability. Every capability now reserves its registers during device
setup, so the bitmap already records exactly which configuration space
DWORDs need to be read.

Delete pci_save_pcie_state(), pci_save_pcix_state(), pci_save_ltr_state(),
pci_save_aer_state(), pci_save_ptm_state(), pci_save_tph_state(),
pci_save_dpc_state() and pci_save_vc_state(), along with the PCI_VC_SAVE
arm of the Virtual Channel walker.

Keep pci_save_aspm_l1ss_state(), which also saves the parent's L1SS
registers into the parent's store, and call it from pci_save_state()
instead of the deleted pci_save_pcie_state(). Keep pci_save_acs_state()
too, but only for pci_enable_acs(), which refreshes the saved ACS
registers after a driver binds.

This is not a pure refactor in two places:

  - PCIe: pci_save_pcie_state() read each register with
    pcie_capability_read_word(), which returns 0 for registers the
    device does not implement. The walk reads the DWORD raw, so those
    slots now hold whatever the device returns. Restore still goes
    through pcie_capability_write_word(), which skips unimplemented
    registers.

  - L1SS on Downstream Ports: until now only the child saved a
    Downstream Port's L1SS registers, through
    pci_save_aspm_l1ss_state(). The walk now also saves them when the
    port itself is saved. Both read the same registers, and only the
    child's restore writes them back.

Every other capability already saved whole DWORDs, so its saved values
are unchanged. Capabilities whose save function had a runtime guard,
e.g. TPH only saved its registers while TPH was enabled, now get a few
extra configuration space reads; restore keeps those guards.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci.c        | 54 +++++++++++-----------------------------
 drivers/pci/pci.h        | 11 +-------
 drivers/pci/pcie/aer.c   | 13 +---------
 drivers/pci/pcie/aspm.c  | 17 +------------
 drivers/pci/pcie/dpc.c   |  8 ------
 drivers/pci/pcie/ptm.c   |  8 ------
 drivers/pci/saved-caps.c | 27 +++++++++++++++++---
 drivers/pci/tph.c        | 22 ----------------
 drivers/pci/vc.c         | 45 ++++++---------------------------
 9 files changed, 49 insertions(+), 156 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 402819ab046d..ab1e1d6847fc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1091,7 +1091,9 @@ static void pci_reserve_acs_state(struct pci_dev *dev)
  * @dev: the PCI device
  *
  * Record the ACS configuration currently programmed in hardware so that
- * pci_restore_acs_state() can reapply it after a reset.
+ * pci_restore_acs_state() can reapply it after a reset. pci_save_state()
+ * saves these registers along with every other reserved register, so this is
+ * only needed to refresh them outside of pci_save_state().
  */
 static void pci_save_acs_state(struct pci_dev *dev)
 {
@@ -1786,8 +1788,8 @@ int pci_set_power_state_locked(struct pci_dev *dev, pci_power_t state)
 EXPORT_SYMBOL(pci_set_power_state_locked);
 
 /*
- * PCIe capability registers saved and restored by the PCI core. Registers a
- * device does not implement are skipped by the pcie_capability_*() accessors,
+ * PCIe capability registers reserved and restored by the PCI core.
+ * pcie_capability_write_word() skips registers the device does not implement,
  * so space is reserved for all of them regardless of the device.
  */
 static const u16 pcie_saved_regs[] = {
@@ -1822,24 +1824,6 @@ struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev, u16 cap)
 	return _pci_find_saved_cap(dev, cap, true);
 }
 
-static void pci_save_pcie_state(struct pci_dev *dev)
-{
-	unsigned int i;
-	u16 val;
-
-	if (!pci_is_pcie(dev))
-		return;
-
-	for (i = 0; i < ARRAY_SIZE(pcie_saved_regs); i++) {
-		pcie_capability_read_word(dev, pcie_saved_regs[i], &val);
-		pci_write_saved_cap_word(dev, dev->pcie_cap + pcie_saved_regs[i],
-					 val);
-	}
-
-	pci_save_aspm_l1ss_state(dev);
-	pci_save_ltr_state(dev);
-}
-
 static void pci_reserve_pcie_state(struct pci_dev *dev)
 {
 	unsigned int i;
@@ -1890,17 +1874,6 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 	}
 }
 
-static void pci_save_pcix_state(struct pci_dev *dev)
-{
-	int pos;
-
-	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
-	if (!pos)
-		return;
-
-	pci_save_cap_word(dev, pos + PCI_X_CMD);
-}
-
 static void pci_reserve_pcix_state(struct pci_dev *dev)
 {
 	int pos, rc;
@@ -1942,14 +1915,15 @@ int pci_save_state(struct pci_dev *dev)
 	}
 	dev->state_saved = true;
 
-	pci_save_pcie_state(dev);
-	pci_save_pcix_state(dev);
-	pci_save_dpc_state(dev);
-	pci_save_aer_state(dev);
-	pci_save_ptm_state(dev);
-	pci_save_tph_state(dev);
-	pci_save_acs_state(dev);
-	pci_save_vc_state(dev);
+	pci_save_caps(dev);
+
+	/*
+	 * L1SS is the one capability whose state does not live entirely in
+	 * this device's store: an endpoint's L1 substates only take effect if
+	 * its upstream port is programmed to match, so the two are saved and
+	 * restored together.
+	 */
+	pci_save_aspm_l1ss_state(dev);
 
 	return 0;
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 7deaa8caf65e..5a03561515ee 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -265,6 +265,7 @@ void pci_saved_caps_finalize(struct pci_dev *dev);
 void pci_saved_caps_release(struct pci_dev *dev);
 int pci_reserve_saved_cap(struct pci_dev *dev, unsigned int off, unsigned int len);
 bool pci_saved_cap_reserved(struct pci_dev *dev, unsigned int off);
+void pci_save_caps(struct pci_dev *dev);
 void pci_save_cap_word(struct pci_dev *dev, unsigned int off);
 void pci_save_cap_dword(struct pci_dev *dev, unsigned int off);
 void pci_restore_cap_word(struct pci_dev *dev, unsigned int off);
@@ -359,7 +360,6 @@ void pci_vpd_init(struct pci_dev *dev);
 extern const struct attribute_group pci_dev_vpd_attr_group;
 
 /* PCI Virtual Channel */
-void pci_save_vc_state(struct pci_dev *dev);
 void pci_restore_vc_state(struct pci_dev *dev);
 void pci_reserve_vc_state(struct pci_dev *dev);
 
@@ -944,7 +944,6 @@ struct rcec_ea {
 #endif
 
 #ifdef CONFIG_PCIE_DPC
-void pci_save_dpc_state(struct pci_dev *dev);
 void pci_restore_dpc_state(struct pci_dev *dev);
 void pci_dpc_init(struct pci_dev *pdev);
 void dpc_process_error(struct pci_dev *pdev);
@@ -952,7 +951,6 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
 bool pci_dpc_recovered(struct pci_dev *pdev);
 unsigned int dpc_tlp_log_len(struct pci_dev *dev);
 #else
-static inline void pci_save_dpc_state(struct pci_dev *dev) { }
 static inline void pci_restore_dpc_state(struct pci_dev *dev) { }
 static inline void pci_dpc_init(struct pci_dev *pdev) { }
 static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
@@ -1077,25 +1075,21 @@ static inline int pci_resource_num_to_vf_bar(int resno)
 
 #ifdef CONFIG_PCIE_TPH
 void pci_restore_tph_state(struct pci_dev *dev);
-void pci_save_tph_state(struct pci_dev *dev);
 void pci_no_tph(void);
 void pci_tph_init(struct pci_dev *dev);
 #else
 static inline void pci_restore_tph_state(struct pci_dev *dev) { }
-static inline void pci_save_tph_state(struct pci_dev *dev) { }
 static inline void pci_no_tph(void) { }
 static inline void pci_tph_init(struct pci_dev *dev) { }
 #endif
 
 #ifdef CONFIG_PCIE_PTM
 void pci_ptm_init(struct pci_dev *dev);
-void pci_save_ptm_state(struct pci_dev *dev);
 void pci_restore_ptm_state(struct pci_dev *dev);
 void pci_suspend_ptm(struct pci_dev *dev);
 void pci_resume_ptm(struct pci_dev *dev);
 #else
 static inline void pci_ptm_init(struct pci_dev *dev) { }
-static inline void pci_save_ptm_state(struct pci_dev *dev) { }
 static inline void pci_restore_ptm_state(struct pci_dev *dev) { }
 static inline void pci_suspend_ptm(struct pci_dev *dev) { }
 static inline void pci_resume_ptm(struct pci_dev *dev) { }
@@ -1150,7 +1144,6 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
 
 /* ASPM-related functionality we need even without CONFIG_PCIEASPM */
-void pci_save_ltr_state(struct pci_dev *dev);
 void pci_reserve_ltr_state(struct pci_dev *dev);
 void pci_restore_ltr_state(struct pci_dev *dev);
 void pci_configure_aspm_l1ss(struct pci_dev *dev);
@@ -1360,7 +1353,6 @@ extern const struct attribute_group aer_attr_group;
 void pci_aer_clear_fatal_status(struct pci_dev *dev);
 int pci_aer_clear_status(struct pci_dev *dev);
 int pci_aer_raw_clear_status(struct pci_dev *dev);
-void pci_save_aer_state(struct pci_dev *dev);
 void pci_restore_aer_state(struct pci_dev *dev);
 #else
 static inline void pci_no_aer(void) { }
@@ -1369,7 +1361,6 @@ static inline void pci_aer_exit(struct pci_dev *d) { }
 static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
-static inline void pci_save_aer_state(struct pci_dev *dev) { }
 static inline void pci_restore_aer_state(struct pci_dev *dev) { }
 #endif
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 25436bcf9fb9..2ff3ad256929 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -353,7 +353,7 @@ int pci_aer_clear_status(struct pci_dev *dev)
 }
 
 /*
- * AER registers saved and restored by the PCI core. PCI_ERR_ROOT_COMMAND is
+ * AER registers reserved and restored by the PCI core. PCI_ERR_ROOT_COMMAND is
  * only implemented by Root Ports and Root Complex Event Collectors (PCIe
  * r6.0, sec 7.8.4.9) and so must come last.
  */
@@ -373,17 +373,6 @@ static unsigned int aer_nr_saved_regs(struct pci_dev *dev)
 	return ARRAY_SIZE(aer_saved_regs) - 1;
 }
 
-void pci_save_aer_state(struct pci_dev *dev)
-{
-	unsigned int i;
-
-	if (!dev->aer_cap)
-		return;
-
-	for (i = 0; i < aer_nr_saved_regs(dev); i++)
-		pci_save_cap_dword(dev, dev->aer_cap + aer_saved_regs[i]);
-}
-
 void pci_restore_aer_state(struct pci_dev *dev)
 {
 	unsigned int i;
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 2978fde87af6..9afa12771800 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -27,21 +27,6 @@
 
 #include "../pci.h"
 
-void pci_save_ltr_state(struct pci_dev *dev)
-{
-	int ltr;
-
-	if (!pci_is_pcie(dev))
-		return;
-
-	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
-	if (!ltr)
-		return;
-
-	/* Some broken devices only support dword access to LTR */
-	pci_save_cap_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT);
-}
-
 void pci_reserve_ltr_state(struct pci_dev *dev)
 {
 	int ltr, rc;
@@ -105,7 +90,7 @@ void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
 
 	/*
 	 * Save L1 substate configuration. The ASPM L0s/L1 configuration
-	 * in PCI_EXP_LNKCTL_ASPMC is saved by pci_save_pcie_state().
+	 * in PCI_EXP_LNKCTL_ASPMC is saved by pci_save_caps().
 	 */
 	pci_save_cap_dword(pdev, pdev->l1ss + PCI_L1SS_CTL2);
 	pci_save_cap_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1);
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 16203e9ef240..99dd6ebfbe4e 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -43,14 +43,6 @@ static const char * const rp_pio_error_string[] = {
 	"Memory Request Completion Timeout",		 /* Bit Position 18 */
 };
 
-void pci_save_dpc_state(struct pci_dev *dev)
-{
-	if (!dev->dpc_cap)
-		return;
-
-	pci_save_cap_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL);
-}
-
 void pci_restore_dpc_state(struct pci_dev *dev)
 {
 	if (!dev->dpc_cap)
diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index fc653d2d1ec5..a46ff85f22b7 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -98,14 +98,6 @@ void pci_ptm_init(struct pci_dev *dev)
 		dev->ptm_requester = 1;
 }
 
-void pci_save_ptm_state(struct pci_dev *dev)
-{
-	if (!dev->ptm_cap)
-		return;
-
-	pci_save_cap_dword(dev, dev->ptm_cap + PCI_PTM_CTRL);
-}
-
 void pci_restore_ptm_state(struct pci_dev *dev)
 {
 	if (!dev->ptm_cap)
diff --git a/drivers/pci/saved-caps.c b/drivers/pci/saved-caps.c
index 4647ce59ce74..a32563766763 100644
--- a/drivers/pci/saved-caps.c
+++ b/drivers/pci/saved-caps.c
@@ -81,9 +81,9 @@ bool pci_saved_cap_reserved(struct pci_dev *dev, unsigned int off)
  * @off: offset of the register in configuration space
  * @len: size of the register in bytes
  *
- * Reserve room to save the register at @off, which may then be saved with
- * pci_save_cap_word() and friends. Must be called during device setup, before
- * the store is finalized.
+ * Reserve room to save the register at @off, which pci_save_caps() then reads
+ * into the store. Must be called during device setup, before the store is
+ * finalized.
  *
  * Return: 0 on success, negative errno otherwise.
  */
@@ -122,6 +122,27 @@ int pci_reserve_saved_cap(struct pci_dev *dev, unsigned int off, unsigned int le
 	return 0;
 }
 
+/**
+ * pci_save_caps - save every reserved capability register
+ * @dev: the PCI device
+ *
+ * Read all of the configuration space DWORDs that capabilities reserved during
+ * device setup into the store. Values are kept in ascending offset order, the
+ * same order that for_each_set_bit() walks the reservation bitmap, so the
+ * destination slot advances in lockstep with the bitmap and needs no lookup.
+ */
+void pci_save_caps(struct pci_dev *dev)
+{
+	struct pci_saved_caps *caps = &dev->saved_caps;
+	unsigned int dword, i = 0;
+
+	if (!caps->dword_val)
+		return;
+
+	for_each_set_bit(dword, caps->dword_map, PCI_CFG_SPACE_EXP_DWORDS)
+		pci_read_config_dword(dev, dword * sizeof(u32), &caps->dword_val[i++]);
+}
+
 /**
  * pci_save_cap_dword - save a 32-bit capability register
  * @dev: the PCI device
diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 3ab8d5b2ab10..62aab2ac85b5 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -457,28 +457,6 @@ void pci_restore_tph_state(struct pci_dev *pdev)
 	}
 }
 
-void pci_save_tph_state(struct pci_dev *pdev)
-{
-	int num_entries, i, offset;
-
-	if (!pdev->tph_cap)
-		return;
-
-	if (!pdev->tph_enabled)
-		return;
-
-	/* Save control register */
-	pci_save_cap_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL);
-
-	/* Save all ST entries in extended capability structure */
-	offset = PCI_TPH_BASE_SIZEOF;
-	num_entries = pcie_tph_get_st_table_size(pdev);
-	for (i = 0; i < num_entries; i++) {
-		pci_save_cap_word(pdev, pdev->tph_cap + offset);
-		offset += sizeof(u16);
-	}
-}
-
 void pci_no_tph(void)
 {
 	pci_tph_disabled = true;
diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
index 7f8c1c29603a..432cd65f4954 100644
--- a/drivers/pci/vc.c
+++ b/drivers/pci/vc.c
@@ -19,12 +19,11 @@
 /* What to do with the registers of a VC capability */
 enum pci_vc_op {
 	PCI_VC_RESERVE,		/* Reserve room to save them */
-	PCI_VC_SAVE,		/* Copy them into the saved capabilities */
 	PCI_VC_RESTORE,		/* Write the saved capabilities back */
 };
 
 /**
- * pci_vc_do_word - Reserve, save, or restore a word
+ * pci_vc_do_word - Reserve or restore a word
  * @dev: device
  * @pos: config space position
  * @op: what to do with it
@@ -36,9 +35,6 @@ static int pci_vc_do_word(struct pci_dev *dev, int pos, enum pci_vc_op op)
 	switch (op) {
 	case PCI_VC_RESERVE:
 		return pci_reserve_saved_cap(dev, pos, sizeof(u16));
-	case PCI_VC_SAVE:
-		pci_save_cap_word(dev, pos);
-		break;
 	case PCI_VC_RESTORE:
 		if (!pci_saved_cap_reserved(dev, pos))
 			return -ENOENT;
@@ -51,7 +47,7 @@ static int pci_vc_do_word(struct pci_dev *dev, int pos, enum pci_vc_op op)
 }
 
 /**
- * pci_vc_do_dwords - Reserve, save, or restore a series of dwords
+ * pci_vc_do_dwords - Reserve or restore a series of dwords
  * @dev: device
  * @pos: starting config space position
  * @dwords: number of dwords
@@ -70,18 +66,14 @@ static int pci_vc_do_dwords(struct pci_dev *dev, int pos, int dwords,
 	/*
 	 * The device supplies the table offsets and sizes, so what it reports
 	 * now may not match what was reserved during setup, e.g. if it is no
-	 * longer responding. Save or restore all of the table, or none of it.
+	 * longer responding. Restore all of the table or none of it.
 	 */
 	for (i = 0; i < dwords; i++)
 		if (!pci_saved_cap_reserved(dev, pos + i * sizeof(u32)))
 			return -ENOENT;
 
-	for (i = 0; i < dwords; i++, pos += sizeof(u32)) {
-		if (op == PCI_VC_SAVE)
-			pci_save_cap_dword(dev, pos);
-		else
-			pci_restore_cap_dword(dev, pos);
-	}
+	for (i = 0; i < dwords; i++, pos += sizeof(u32))
+		pci_restore_cap_dword(dev, pos);
 
 	return 0;
 }
@@ -250,13 +242,13 @@ static void pci_vc_restore_res_ctrl(struct pci_dev *dev, int pos, int res)
 }
 
 /**
- * pci_vc_do_saved_caps - Reserve, save, or restore VC state
+ * pci_vc_do_saved_caps - Reserve or restore VC state
  * @dev: device
  * @pos: starting position of VC capability (VC/VC9/MFVC)
  * @op: what to do with the registers found along the way
  *
- * Walking Virtual Channel config space is complicated, so reserving, saving
- * and restoring it are all driven from one function to reduce code and
+ * Walking Virtual Channel config space is complicated, so reserving and
+ * restoring it are both driven from one function to reduce code and
  * guarantee that they agree on which registers are involved.
  *
  * Return: 0 on success, negative errno otherwise.
@@ -387,27 +379,6 @@ static struct {
 		{ PCI_EXT_CAP_ID_VC, "VC" },
 		{ PCI_EXT_CAP_ID_VC9, "VC9" } };
 
-/**
- * pci_save_vc_state - Save VC state to the saved capability store
- * @dev: device
- *
- * For each type of VC capability, VC/VC9/MFVC, find the capability and
- * save it to the previously reserved capability store.
- */
-void pci_save_vc_state(struct pci_dev *dev)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(vc_caps); i++) {
-		int pos = pci_find_ext_capability(dev, vc_caps[i].id);
-
-		if (!pos)
-			continue;
-
-		pci_vc_do_saved_caps(dev, pos, PCI_VC_SAVE);
-	}
-}
-
 /**
  * pci_restore_vc_state - Restore VC state from the saved capability store
  * @dev: device
-- 
2.56.0.455.g6c5a503b38-goog


