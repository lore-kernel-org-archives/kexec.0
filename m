Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D45606EEB7
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 00:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=prMuYG4R;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=K4nW2H//
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=iHjhOa1kArquGp6NzqJKIMKukUgu91Ev2XX32EWf/dM=; b=prMuYG4RaBSD0Hgjj2RR5nAMEA
	UeGsmod88DfhAafGJqZSe84ZdPXq4SiuUPEQqZZyZIyri0iTRokH6yfHWeOEpyRHtoNneiqSKgra1
	7lYXix4njFEcTczbpxPVkVxp5dtc6Sce6m2moMgHuNqtcWRoeDuPo/viExruhnH/4V0noaVDLc/c9
	fOL6z93fJsl2Lnw2PqO0ntTNt0kVT6zVY6qvDAw4aB/RqTOPexWF9Pn7W4681QSgE3nZoraF+Z9Lb
	DU1+dJKbCHt5G52lN4DN8c7J9MCVkxsYfPdTZJWBuemCkvNsYgiN+8UelTOCT99V91mg3gZBVvIHs
	jnBUcRdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP830-0000000Avvg-373u;
	Fri, 06 Nov 2026 00:43:14 +0000
Received: from mail-oi1-x247.google.com ([2607:f8b0:4864:20::247])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP82v-0000000AvlF-1azz
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 00:43:10 +0000
Received: by mail-oi1-x247.google.com with SMTP id 5614622812f47-4fb73e868aaso102421b6e.0
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 16:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925788; x=1794530588; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iHjhOa1kArquGp6NzqJKIMKukUgu91Ev2XX32EWf/dM=;
        b=K4nW2H//t4vDDzr4tOhJuDqTX3LKI3OufJlT6LR++vq0zdx8RVHE39WToSeKvUo50D
         yKcf/XJuHeaNWal2Wn7Kd1wivLwxQNvmkwdSBl/n+xrgGsYoBwz1N6jJkB4MuaNMYmyE
         WD1Kgb0F+BTJXP3n9DhTjxVrC7IJrokRbVE/rOkLftrV2d37nzYAu/zBNzgrJ1cpVQWj
         IYgWj6JxBmHOt5k1cNqOX47kq8QHWtf/lNJvtPo96TBbKgoKCw9ez/OM5wt6dvF2gftu
         uVvsIaZVGGFLjcTP0cHpM9VeuzrTxiNg9qWCt+1LLYfYhBHrfp4N80u6J5wo114LUhf5
         Hp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925788; x=1794530588;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iHjhOa1kArquGp6NzqJKIMKukUgu91Ev2XX32EWf/dM=;
        b=DTRQfaHt9xIIDVdvR3+IgsN2Kv5fSPAVCzE4duLzcj8jvIdogWsltUIFz6TKKwa/T0
         de/IkLc7HZwJ1KbC3NAHsODebc8o7/g7yoUmcX1Iu/iVbSrTnU96CoD2wCvl/kTTIUeu
         MrN471okwn7pwUYqeQZmh6sW9Cv2xmMCljnoeTHhvsiGw/ftPqrrhOvy5yU/Od2ovKTE
         RYS7Qe75NqV99tFgZB2w/ndCvu8kAObbzrCuZXM5pf9J/DKcT/P16YWi89lCFoRP5LA5
         RsoXpcK4fjX0G3ElguQLnuCgrX6WkiW4nWOzQQhMzorEHZ7rkN5w+QvByjxDR3MwPIPE
         VsGA==
X-Gm-Message-State: APuU4Z9HeAHDbQRu5EDrHeNinMQJO8s/LvKLcGGITTlhNQA9sWz/YbTV
	dRXpWZCGwDUDmrbGMBvKxYn2C3P+9y2LG7bOGfzJ1BIbFnraiKJ3U+1wYl6f4n5eC+kEbaJCoB3
	x7mApHaLV/kVTN+XmE3FyPmAOMP8miVwD/RVsV64wS4Mmovlgd5ufwbbviIWEamhghXlEi1jVVn
	R2VxG8tgq2Q03//i7Jo+NUhpyXa9l4LskbpO9LIOPkUwJpdKMWIvk=
X-Received: from jabfi10.prod.google.com ([2002:a05:6638:630a:b0:61a:c6d0:4104])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4f66:b0:4b2:8d7b:41b8 with SMTP id 5614622812f47-567e1440ea0mr750093b6e.18.1793925787537;
 Thu, 05 Nov 2026 16:43:07 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:10 +0000
In-Reply-To: <20261106004218.604799-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261106004218.604799-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106004218.604799-10-dmatlack@google.com>
Subject: [PATCH v2 09/17] PCI/PTM: Save PTM state in the saved capability store
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
X-CRM114-CacheID: sfid-20261105_164309_545291_C92A91DF 
X-CRM114-Status: GOOD (  13.55  )
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

Save and restore the PTM Control register through the per-device saved
capability store instead of a private pci_cap_saved_state buffer.

Reserve the register in pci_reserve_ptm_state(), called from
pci_ptm_init(), and report a refused reservation. pci_ptm_init() ignored
the return value of pci_add_ext_cap_save_buffer(), so a failed
allocation left PTM state unsaved without any message. An allocation
failure is now reported once by pci_saved_caps_finalize().

No other functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pcie/ptm.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index bd3bd39f6372..fc653d2d1ec5 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -34,6 +34,16 @@ static struct pci_dev *pci_upstream_ptm(struct pci_dev *dev)
 	return NULL;
 }
 
+static void pci_reserve_ptm_state(struct pci_dev *dev)
+{
+	int rc;
+
+	rc = pci_reserve_saved_cap(dev, dev->ptm_cap + PCI_PTM_CTRL, sizeof(u32));
+	if (rc)
+		pci_err(dev, "unable to reserve PTM save state (%pe)\n",
+			ERR_PTR(rc));
+}
+
 /*
  * Find the PTM Capability (if present) and extract the information we need
  * to use it.
@@ -53,7 +63,7 @@ void pci_ptm_init(struct pci_dev *dev)
 
 	dev->ptm_cap = ptm;
 	atomic_set(&dev->ptm_enable_cnt, 0);
-	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_PTM, sizeof(u32));
+	pci_reserve_ptm_state(dev);
 
 	pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
 	dev->ptm_granularity = FIELD_GET(PCI_PTM_GRANULARITY_MASK, cap);
@@ -90,36 +100,18 @@ void pci_ptm_init(struct pci_dev *dev)
 
 void pci_save_ptm_state(struct pci_dev *dev)
 {
-	u16 ptm = dev->ptm_cap;
-	struct pci_cap_saved_state *save_state;
-	u32 *cap;
-
-	if (!ptm)
+	if (!dev->ptm_cap)
 		return;
 
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
-	if (!save_state)
-		return;
-
-	cap = (u32 *)&save_state->cap.data[0];
-	pci_read_config_dword(dev, ptm + PCI_PTM_CTRL, cap);
+	pci_save_cap_dword(dev, dev->ptm_cap + PCI_PTM_CTRL);
 }
 
 void pci_restore_ptm_state(struct pci_dev *dev)
 {
-	u16 ptm = dev->ptm_cap;
-	struct pci_cap_saved_state *save_state;
-	u32 *cap;
-
-	if (!ptm)
-		return;
-
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
-	if (!save_state)
+	if (!dev->ptm_cap)
 		return;
 
-	cap = (u32 *)&save_state->cap.data[0];
-	pci_write_config_dword(dev, ptm + PCI_PTM_CTRL, *cap);
+	pci_restore_cap_dword(dev, dev->ptm_cap + PCI_PTM_CTRL);
 }
 
 /* Enable PTM in the Control register if possible */
-- 
2.56.0.455.g6c5a503b38-goog


