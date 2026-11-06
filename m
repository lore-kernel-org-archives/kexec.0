Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B857606D822
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 00:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xFcQ6QKi;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l4jxoucH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jmLjI9XOjWedNu4ucOWy6yZB8cv6/+TL9ec51bNxWwI=; b=xFcQ6QKitroQL7Xg/tXU5WDgCv
	lbAypE0E9w5RUlW2wpA/k+dK0oYSAeOTBB8jTbKz/ojc50/fMMx5x9lIC94XfgO/jK+EUay7q+4NN
	pVduTyFbAPF9KApqlU+V5RfW7GRqdXgHN+rYwc2TFkBZp6+X+fn7pv4vkMTfFWY+bevEBKQ5Ebp6U
	CXphFMQarZ7afZy4xStAkvkLu3JYBz5abDdgd4KI3odeXx382Ko0kyUsTfszjX4AqWwnk7btHK+dw
	kSV5zxAAuGGjV895P5xbJK8WhE6Yg+PD134+Lell58fG7GuKVwGdc0ivVXbH2W5JMR+fUZIhmv3iD
	HzCFiOxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP832-0000000AvxZ-20kR;
	Fri, 06 Nov 2026 00:43:16 +0000
Received: from mail-ot1-x345.google.com ([2607:f8b0:4864:20::345])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP82x-0000000AvoT-2kdr
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 00:43:14 +0000
Received: by mail-ot1-x345.google.com with SMTP id 46e09a7af769-83edc5c5ae9so131280a34.1
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 16:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925789; x=1794530589; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jmLjI9XOjWedNu4ucOWy6yZB8cv6/+TL9ec51bNxWwI=;
        b=l4jxoucHF+S4f1Lsl4QEcrZGb5u1eK5sW69rBzrPB1Hmxw6Ws7jpfuEuxEdKnO5vWf
         uQ4ywHJfeas3zsTQThr03p2cl1wJarrHJ8VhPJBGQ7w5zbCwhTucoYP+Jm/wFLzEDSGT
         RHJnUyhiPn2wnOQxVUGMTZaZguxnBsfS481dLvA7RBIUjSjz8w2eazqgM0XTAM/yym3p
         g/CuRzoYPBsN512ZEk1nUlKnA7RslzjBeitKfM4zkf4hd+HVJnodvmyLEFlIoIUShInE
         IhrSJX4M/7wpuRpB1m3qeaidsXbN/vvlf0l9JN8Dtd9x9yQgTIXWthiuCb6CR5pj8k9Q
         9NtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925789; x=1794530589;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jmLjI9XOjWedNu4ucOWy6yZB8cv6/+TL9ec51bNxWwI=;
        b=Bev6nCdKsFlDKpTyRWSF6QylnR4Skm9i3TTpAA7TJoZYUchPQ+Efti8xM7JpqKQQVz
         ILB7S+uTPNBQ0RUAYXX4UusT+RPudKLenOrJvW8VUG5Rro6iT+/ZlCsXM+iJwBD6acvb
         swVwxAGMB9N7HRk1CYBB4ui4KzkXVbp2kdP7jjbldOLjJxuSsXdNhGXcWg8tdMSl36X/
         JExa47XqUNopF3d8F6Nv/4waBlm++dxtlYB60lVMGn+pRDnW8Wt+B5RQ/AmNLmrUNiR5
         eqh45vTl9Q1ILOD3OwKWZoWdOSs3TSEc19OvkIPbRIzwkHxJ1/8f8f6wJlECl95LmJFL
         hRqw==
X-Gm-Message-State: APuU4Z/z/Jer+XaBJWo2L/k5afnQ6dcM1UKDEi26aUCTBHM3xTflUn/w
	TTjU5dPcj/qpCh1VCcwvtP3VAnTAMC0+S17EUNoprJpaCFcZTRlftIkHwW1rz3DiWE/3WM7wQ1D
	BaJcNWljIIbOpfwOufDCO6Qeeas9h8w9pVWt3ES0OnvgmAOkiRF8dWYtue6orF7ekBUcxqqTq61
	fsTn5yitLPH8suH3HqQ/eky85LhRcvmn/qfrCF03o3r6dpDIeon/8=
X-Received: from iofl4-n1.prod.google.com ([2002:a05:6602:8384:10b0:9e3:4909:2e0c])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:5394:b0:4d6:92b3:5c85 with SMTP id 5614622812f47-567e18964a2mr623375b6e.66.1793925788751;
 Thu, 05 Nov 2026 16:43:08 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:11 +0000
In-Reply-To: <20261106004218.604799-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261106004218.604799-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106004218.604799-11-dmatlack@google.com>
Subject: [PATCH v2 10/17] PCI/TPH: Save TPH state in the saved capability store
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
X-CRM114-CacheID: sfid-20261105_164311_727635_75EE6C17 
X-CRM114-Status: GOOD (  14.53  )
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

Save and restore the TPH Control register and Steering Tag table through
the per-device saved capability store instead of a private
pci_cap_saved_state buffer.

The Steering Tag table is variable length, so pci_tph_init() had to compute
a buffer size and both the save and restore loops had to walk that buffer
in step with configuration space. Reserve the table by offset instead so
that the loops can address the entries directly.

Reserve the registers in pci_reserve_tph_state(), called from
pci_tph_init(), and report a refused reservation. pci_tph_init() ignored
the return value of pci_add_ext_cap_save_buffer(), so a failed
allocation left TPH state unsaved without any message. An allocation
failure is now reported once by pci_saved_caps_finalize().

No other functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/tph.c | 54 +++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 655ffd60e62f..3ab8d5b2ab10 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -439,10 +439,7 @@ EXPORT_SYMBOL(pcie_enable_tph);
 
 void pci_restore_tph_state(struct pci_dev *pdev)
 {
-	struct pci_cap_saved_state *save_state;
 	int num_entries, i, offset;
-	u16 *st_entry;
-	u32 *cap;
 
 	if (!pdev->tph_cap)
 		return;
@@ -450,29 +447,19 @@ void pci_restore_tph_state(struct pci_dev *pdev)
 	if (!pdev->tph_enabled)
 		return;
 
-	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_TPH);
-	if (!save_state)
-		return;
-
 	/* Restore control register and all ST entries */
-	cap = &save_state->cap.data[0];
-	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, *cap++);
-	st_entry = (u16 *)cap;
+	pci_restore_cap_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL);
 	offset = PCI_TPH_BASE_SIZEOF;
 	num_entries = pcie_tph_get_st_table_size(pdev);
 	for (i = 0; i < num_entries; i++) {
-		pci_write_config_word(pdev, pdev->tph_cap + offset,
-				      *st_entry++);
+		pci_restore_cap_word(pdev, pdev->tph_cap + offset);
 		offset += sizeof(u16);
 	}
 }
 
 void pci_save_tph_state(struct pci_dev *pdev)
 {
-	struct pci_cap_saved_state *save_state;
 	int num_entries, i, offset;
-	u16 *st_entry;
-	u32 *cap;
 
 	if (!pdev->tph_cap)
 		return;
@@ -480,21 +467,14 @@ void pci_save_tph_state(struct pci_dev *pdev)
 	if (!pdev->tph_enabled)
 		return;
 
-	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_TPH);
-	if (!save_state)
-		return;
-
 	/* Save control register */
-	cap = &save_state->cap.data[0];
-	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, cap++);
+	pci_save_cap_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL);
 
 	/* Save all ST entries in extended capability structure */
-	st_entry = (u16 *)cap;
 	offset = PCI_TPH_BASE_SIZEOF;
 	num_entries = pcie_tph_get_st_table_size(pdev);
 	for (i = 0; i < num_entries; i++) {
-		pci_read_config_word(pdev, pdev->tph_cap + offset,
-				     st_entry++);
+		pci_save_cap_word(pdev, pdev->tph_cap + offset);
 		offset += sizeof(u16);
 	}
 }
@@ -506,16 +486,30 @@ void pci_no_tph(void)
 	pr_info("PCIe TPH is disabled\n");
 }
 
-void pci_tph_init(struct pci_dev *pdev)
+static void pci_reserve_tph_state(struct pci_dev *pdev)
 {
-	int num_entries;
-	u32 save_size;
+	unsigned int off, len;
+	int num_entries, rc;
+
+	off = pdev->tph_cap + PCI_TPH_CTRL;
+	rc = pci_reserve_saved_cap(pdev, off, sizeof(u32));
 
+	num_entries = pcie_tph_get_st_table_size(pdev);
+	if (!rc && num_entries) {
+		off = pdev->tph_cap + PCI_TPH_BASE_SIZEOF;
+		len = num_entries * sizeof(u16);
+		rc = pci_reserve_saved_cap(pdev, off, len);
+	}
+	if (rc)
+		pci_err(pdev, "unable to reserve TPH save state (%pe)\n",
+			ERR_PTR(rc));
+}
+
+void pci_tph_init(struct pci_dev *pdev)
+{
 	pdev->tph_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_TPH);
 	if (!pdev->tph_cap)
 		return;
 
-	num_entries = pcie_tph_get_st_table_size(pdev);
-	save_size = sizeof(u32) + num_entries * sizeof(u16);
-	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_TPH, save_size);
+	pci_reserve_tph_state(pdev);
 }
-- 
2.56.0.455.g6c5a503b38-goog


