Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA3B606EEB9
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 00:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WRf143Rc;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CWbf0rjK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ddBqCr/aEaadxkJlxFoZmLz139RBeJBOYwKmQVBOEIY=; b=WRf143RckbvAaCNQUliSq/6Ird
	pcQ2vuisfH9kaej66DtXmnee5CYwoi9+y4u0eovtv50wUi4AKuw5b0JUh/i9PRfKYvwzAoLbmD5AT
	lIOIVx8tR/6O+NoF3d/jyqBGvU3wH8CpVvrW0gMBRJvtZA8V+hPr6AqgwvRUzfL8W0SJ6X6RyDeX8
	M43ZxLSIezW3rHan5dhUxlhGrKBpDMi47fQUbZGx6OCjVe8Xf7P+FQFFzS/N03ID96HNoM0JPE5Yt
	9g0zy/eekn5Y4gvoiVBg+EINP/ih4MA2jkkL54bSbv+L80FS8TkMHRrDL6Qo3lMuG9Jf3Cyp7fUPL
	bj4Qf5qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP82x-0000000Avq7-1RMy;
	Fri, 06 Nov 2026 00:43:11 +0000
Received: from mail-ot1-x348.google.com ([2607:f8b0:4864:20::348])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP82t-0000000AviW-0BaN
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 00:43:08 +0000
Received: by mail-ot1-x348.google.com with SMTP id 46e09a7af769-851f7cdfaefso153951a34.3
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 16:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925785; x=1794530585; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ddBqCr/aEaadxkJlxFoZmLz139RBeJBOYwKmQVBOEIY=;
        b=CWbf0rjKzMoKgquyy5A81SdaAzZMZkrylI893gQkc3mwFZR65Y1Y4HcGJvN6fVDbLx
         pUWzJVaegBSF2r6PEsjJiNSAHsUSHTm7U6f5A6bp436MrirAF4s0mYwUpE7w8CT/KDV0
         +qmRTspoPe60dsfwxTefIBykfs2eDgeV0F7X7YrGpx54FODJFszyhow7S1tHAnt1xC6M
         Z2tzupOcMnSiSH2S1l2mziEzCZoAdTscBwErhwrs/sIo6Vzq2inutFLjXsccSUavOqN8
         fxRt5pg5SsU4pzuRR7w6bhy9UsriKb9yUazfIHofF3yGhvB1W8WmYTM7mbjwroLyIq6O
         jRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925785; x=1794530585;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ddBqCr/aEaadxkJlxFoZmLz139RBeJBOYwKmQVBOEIY=;
        b=iejEpHqkJLKFvKJ7nkjWeqwu+Zyu88yrkdXAIbi3tDfpI952sBnMHTqvfVxJMqi3y9
         mCK7pCsYuhZvfZ2bxR4e2kJiIldQ7O8kXWocyMKEhj9hrKN/zzhZ9oUoEx6A51VysM82
         Ov78hmzyWe5fVVbgjTCt96MPnlvWhPpdv+JN1IRzZliQHDTrSS7uSjtll5H9IxATP+TV
         yKa5cCT+E5Fsa/up+HfK37+olWCAOvcgXjTB7PBkjkfsBu569w23fJiFK+YqGDdDXfoO
         YPfRkI98AGlzhwr5y0izvZW70GdwMYnrHOwhR6H6cnZOULxDmfKz+0EULvjBcZyB4Uum
         q9RA==
X-Gm-Message-State: APuU4Z+07Htf1ynhlHtiPrqpAzqPfzZwNvJkUOvkUDi4vAGPKgW2G2Zk
	3a7uMr7UWBSF37g8F/C8aXAP27TDpwGY0J31Iy2zi4bl1G7WnOJGuz7g0r0hv+PRIOmJbHqMcId
	rws30Al4bByb1VX5YbhOQ3HxeWrKCiEo7jMMLfMKDpYoF1RMLVMByTofcw8IvDsvnkq3+wZrQu3
	f6q1wDYVBRd8DZ5c2B0oVxFXowJ+6BvgBhnm37QN1BTNjB7q4Zkss=
X-Received: from iobmm23-n1.prod.google.com ([2002:a05:6602:7117:10b0:9ca:dec8:c75d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1987:b0:4f3:68d6:f131 with SMTP id 5614622812f47-567e099488cmr858385b6e.2.1793925785214;
 Thu, 05 Nov 2026 16:43:05 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:08 +0000
In-Reply-To: <20261106004218.604799-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261106004218.604799-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106004218.604799-8-dmatlack@google.com>
Subject: [PATCH v2 07/17] PCI/ASPM: Save L1SS state in the saved capability store
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
X-CRM114-CacheID: sfid-20261105_164307_098771_6A9A858A 
X-CRM114-Status: GOOD (  15.73  )
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

Save and restore the L1 PM Substates control registers through the
per-device saved capability store instead of a private pci_cap_saved_state
buffer.

pci_restore_aspm_l1ss_state() needs both the Upstream and Downstream
Port's saved L1SS configuration, and had to fetch two buffers and decode
each by index. Read the saved values by configuration space offset
instead, which names the register at every use. Add
pci_read_saved_l1ss_ctl() to read one device's pair, so that the Port
and the device below it are read the same way.

Reserve PCI_L1SS_CTL1 and PCI_L1SS_CTL2 with a single request in
pci_reserve_aspm_l1ss_state(), since they are adjacent DWORDs. Skip the
reservation when the device has no L1SS capability, which
pci_add_ext_cap_save_buffer() did implicitly.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pcie/aspm.c | 63 ++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 39adf2cad331..2978fde87af6 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -68,24 +68,29 @@ void pci_restore_ltr_state(struct pci_dev *dev)
 	pci_restore_cap_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT);
 }
 
-void pci_configure_aspm_l1ss(struct pci_dev *pdev)
+static void pci_reserve_aspm_l1ss_state(struct pci_dev *pdev)
 {
 	int rc;
 
-	pdev->l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
-
-	rc = pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_L1SS,
-					 2 * sizeof(u32));
+	/* PCI_L1SS_CTL1 and PCI_L1SS_CTL2 are adjacent DWORDs */
+	rc = pci_reserve_saved_cap(pdev, pdev->l1ss + PCI_L1SS_CTL1, 2 * sizeof(u32));
 	if (rc)
-		pci_err(pdev, "unable to allocate ASPM L1SS save buffer (%pe)\n",
+		pci_err(pdev, "unable to reserve ASPM L1SS save state (%pe)\n",
 			ERR_PTR(rc));
 }
 
+void pci_configure_aspm_l1ss(struct pci_dev *pdev)
+{
+	pdev->l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
+	if (!pdev->l1ss)
+		return;
+
+	pci_reserve_aspm_l1ss_state(pdev);
+}
+
 void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
 {
 	struct pci_dev *parent = pdev->bus->self;
-	struct pci_cap_saved_state *save_state;
-	u32 *cap;
 
 	/*
 	 * If this is a Downstream Port, we never restore the L1SS state
@@ -102,32 +107,32 @@ void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
 	 * Save L1 substate configuration. The ASPM L0s/L1 configuration
 	 * in PCI_EXP_LNKCTL_ASPMC is saved by pci_save_pcie_state().
 	 */
-	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
-	if (!save_state)
-		return;
-
-	cap = &save_state->cap.data[0];
-	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL2, cap++);
-	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1, cap++);
+	pci_save_cap_dword(pdev, pdev->l1ss + PCI_L1SS_CTL2);
+	pci_save_cap_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1);
 
 	/*
 	 * Save parent's L1 substate configuration so we have it for
 	 * pci_restore_aspm_l1ss_state(pdev) to restore.
 	 */
-	save_state = pci_find_saved_ext_cap(parent, PCI_EXT_CAP_ID_L1SS);
-	if (!save_state)
-		return;
+	pci_save_cap_dword(parent, parent->l1ss + PCI_L1SS_CTL2);
+	pci_save_cap_dword(parent, parent->l1ss + PCI_L1SS_CTL1);
+}
 
-	cap = &save_state->cap.data[0];
-	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, cap++);
-	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, cap++);
+/*
+ * Read a device's saved L1 substate configuration.
+ *
+ * Return: true if both registers had a saved value, false otherwise.
+ */
+static bool pci_read_saved_l1ss_ctl(struct pci_dev *dev, u32 *ctl1, u32 *ctl2)
+{
+	return pci_read_saved_cap_dword(dev, dev->l1ss + PCI_L1SS_CTL1, ctl1) &&
+	       pci_read_saved_cap_dword(dev, dev->l1ss + PCI_L1SS_CTL2, ctl2);
 }
 
 void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)
 {
-	struct pci_cap_saved_state *pl_save_state, *cl_save_state;
 	struct pci_dev *parent = pdev->bus->self;
-	u32 *cap, pl_ctl1, pl_ctl2, pl_l1_2_enable;
+	u32 pl_ctl1, pl_ctl2, pl_l1_2_enable;
 	u32 cl_ctl1, cl_ctl2, cl_l1_2_enable;
 	u16 clnkctl, plnkctl;
 
@@ -142,18 +147,10 @@ void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)
 	if (!pdev->l1ss || !parent->l1ss)
 		return;
 
-	cl_save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
-	pl_save_state = pci_find_saved_ext_cap(parent, PCI_EXT_CAP_ID_L1SS);
-	if (!cl_save_state || !pl_save_state)
+	if (!pci_read_saved_l1ss_ctl(pdev, &cl_ctl1, &cl_ctl2) ||
+	    !pci_read_saved_l1ss_ctl(parent, &pl_ctl1, &pl_ctl2))
 		return;
 
-	cap = &cl_save_state->cap.data[0];
-	cl_ctl2 = *cap++;
-	cl_ctl1 = *cap;
-	cap = &pl_save_state->cap.data[0];
-	pl_ctl2 = *cap++;
-	pl_ctl1 = *cap;
-
 	/* Make sure L0s/L1 are disabled before updating L1SS config */
 	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &clnkctl);
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &plnkctl);
-- 
2.56.0.455.g6c5a503b38-goog


