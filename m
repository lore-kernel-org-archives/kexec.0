Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D755606EE98
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 00:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1Z7tBFsy;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GioDBSF0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=SqwfwAiEqbASiUZ5fLcpwdF4bH2r5Wh+f0RbnIc3OoY=; b=1Z7tBFsyqjvf3FSk78OOxTzvdh
	AasW0MTRlZUo4MAJx7QwRbhCa+aUkXu2XNDXhSq4Mv3k3rBmE2c1Wz8aWTz8tSHCCvPwB3HMBifkf
	y6bvV/rOfZds5r99l8ZrzD0rCLcVkyMGytMC9+o8N1C5plaSdJOXlf4zAVWya/xLlc8NqoGDkeBuF
	vyYrZQf1n3faKsAefl1P6jw0Yi3P/oy0sH7pb6Kk/pnUyx8u2dXRQIHSdl9H8XFb0vwSfDaoqxrVP
	OrXty8ri1u0uC8YlpvNTqzdE3F/KYys66r1cG6JK6MMSmIPRi5vAhxzkmVBXHsbTebpI8OL07d4LU
	c8Kz0KQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP82v-0000000Avm3-0fGh;
	Fri, 06 Nov 2026 00:43:09 +0000
Received: from mail-oi1-x246.google.com ([2607:f8b0:4864:20::246])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP82s-0000000AvgZ-1Jeg
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 00:43:07 +0000
Received: by mail-oi1-x246.google.com with SMTP id 5614622812f47-4ab4f652f9bso50411b6e.0
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 16:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925785; x=1794530585; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SqwfwAiEqbASiUZ5fLcpwdF4bH2r5Wh+f0RbnIc3OoY=;
        b=GioDBSF0mHaoEZbAH7cd89e6+bWNQP6twynG9qxitExzbsriYfnYX+YDG6fHWMHHdn
         q3BSwHIpoWvdqoDn16meE5A5Ekv+DPEEaGEQUJKH7z5XAZzRBFoBLnIPjDN8db+ZK5Uf
         Ri1oKTGUgcT9HOYXTc+EL83sFDTdm79gW75nnMZ1SH8YKCHMDERvQOXwuDskGxWTmyvb
         kn2/ip0UHOrAQY3CANKij8CpyaPimDscToBPP/W0IDOoCHvP1sdj77U6WjgpGpSeNMu+
         D+HFk9lkUX0jnKAfTK3GfsNPTqqmk6E1B1dnRt1CSZ6yWlv0nCkhsLqeamZ6xWb4E407
         t1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925785; x=1794530585;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SqwfwAiEqbASiUZ5fLcpwdF4bH2r5Wh+f0RbnIc3OoY=;
        b=epl0VVZwG7QBUXj19ju8RBaLhwbNCEYymDlmqGVWLS6XZpy78Qsm5OIZrbJVPxPUWw
         Wbit8TXd3w6o1izdfxBB0QrLSMSJRR5RRzgHmTWOcctuA0N+MDKYYfyUXdVgMPE+071Q
         huXbDYxxM+dZs2EnzIcR4ET20zWqylFEKRtplsqU3Pw+8ATLKsJVAgEpI/C5DIXqzjsj
         40asA92nNmjEgtsWDZ2WlZN7z/uSu8bHjGlXUDpEFtHnptzHd3CUigWbmJAHrFEJaQEM
         6d3kNXI6JhEjIU2c7uBjvxDnpXNxNvjZlCOCvGP/X/dpFnYdu3N4JFZxLndspLhMXde7
         lX1w==
X-Gm-Message-State: APuU4Z92vGznyoFUWTbnqDOKfQ+5I7tlHtmRves4rjRmLb8w/RPxWG21
	SQe79jgrRUUIzy39NB78AsmwYzeFekNk0DPCeOlJk2KPiVlzdnTKbBhKt8VW3MooGq9iry1hmgt
	NolySteRuSUtvD7UpwVKcYPFrhbNv7Jj6KyMNW/cQLvPzATzwei5LUJmXJysh8zJ/tjQkAi06Ys
	Mh6nvdDBnjE/xs4T1BFZ+hTgII1rql6DkxQo442tzpWDvvQ9yot9Y=
X-Received: from ilbec12.prod.google.com ([2002:a05:6e02:470c:b0:53b:d168:b69])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:2218:b0:50a:7162:87df with SMTP id 5614622812f47-567e098e3f0mr811203b6e.2.1793925783998;
 Thu, 05 Nov 2026 16:43:03 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:07 +0000
In-Reply-To: <20261106004218.604799-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261106004218.604799-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106004218.604799-7-dmatlack@google.com>
Subject: [PATCH v2 06/17] PCI/ASPM: Save LTR state in the saved capability store
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
X-CRM114-CacheID: sfid-20261105_164306_363750_0353C2F7 
X-CRM114-Status: GOOD (  12.81  )
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

Save and restore the LTR maximum latency registers through the per-device
saved capability store instead of a private pci_cap_saved_state buffer.

Reserve the DWORD by its configuration space offset during device setup,
in pci_reserve_ltr_state(), and keep accessing the registers a DWORD at
a time because some devices only support DWORD access to them.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci.c       |  8 +-------
 drivers/pci/pci.h       |  1 +
 drivers/pci/pcie/aspm.c | 31 ++++++++++++++++---------------
 3 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6cf4a64cb7e6..29d9474db1ae 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3742,15 +3742,9 @@ int pci_add_ext_cap_save_buffer(struct pci_dev *dev, u16 cap, unsigned int size)
  */
 void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 {
-	int error;
-
 	pci_reserve_pcie_state(dev);
 	pci_reserve_pcix_state(dev);
-
-	error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_LTR,
-					    2 * sizeof(u16));
-	if (error)
-		pci_err(dev, "unable to allocate suspend buffer for LTR\n");
+	pci_reserve_ltr_state(dev);
 
 	pci_allocate_acs_save_buffer(dev);
 	pci_allocate_vc_save_buffers(dev);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 206e0d04e06e..0daa2439db5e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1151,6 +1151,7 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
 
 /* ASPM-related functionality we need even without CONFIG_PCIEASPM */
 void pci_save_ltr_state(struct pci_dev *dev);
+void pci_reserve_ltr_state(struct pci_dev *dev);
 void pci_restore_ltr_state(struct pci_dev *dev);
 void pci_configure_aspm_l1ss(struct pci_dev *dev);
 void pci_save_aspm_l1ss_state(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 02922b887ec6..39adf2cad331 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -30,8 +30,6 @@
 void pci_save_ltr_state(struct pci_dev *dev)
 {
 	int ltr;
-	struct pci_cap_saved_state *save_state;
-	u32 *cap;
 
 	if (!pci_is_pcie(dev))
 		return;
@@ -40,31 +38,34 @@ void pci_save_ltr_state(struct pci_dev *dev)
 	if (!ltr)
 		return;
 
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
-	if (!save_state) {
-		pci_err(dev, "no suspend buffer for LTR; ASPM issues possible after resume\n");
+	/* Some broken devices only support dword access to LTR */
+	pci_save_cap_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT);
+}
+
+void pci_reserve_ltr_state(struct pci_dev *dev)
+{
+	int ltr, rc;
+
+	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
+	if (!ltr)
 		return;
-	}
 
-	/* Some broken devices only support dword access to LTR */
-	cap = &save_state->cap.data[0];
-	pci_read_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, cap);
+	rc = pci_reserve_saved_cap(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, sizeof(u32));
+	if (rc)
+		pci_err(dev, "unable to reserve LTR save state (%pe)\n",
+			ERR_PTR(rc));
 }
 
 void pci_restore_ltr_state(struct pci_dev *dev)
 {
-	struct pci_cap_saved_state *save_state;
 	int ltr;
-	u32 *cap;
 
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
 	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
-	if (!save_state || !ltr)
+	if (!ltr)
 		return;
 
 	/* Some broken devices only support dword access to LTR */
-	cap = &save_state->cap.data[0];
-	pci_write_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, *cap);
+	pci_restore_cap_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT);
 }
 
 void pci_configure_aspm_l1ss(struct pci_dev *pdev)
-- 
2.56.0.455.g6c5a503b38-goog


