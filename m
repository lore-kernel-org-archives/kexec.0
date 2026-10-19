Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650DE606A325
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=z5VborQK;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=f7jsEW6+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OlOiZMSQAlq56d5O025wMJ9SWaeJFCSne26CemMgHno=; b=z5VborQKvJOtlTp0gpn3tLvnyB
	vZh1HP/0TG2oeDZsWcz2+xpUCbGibiK9wuExjt/+qhxk0a1IFS+BzjQ7hEO26jPdyYNi58mFUkJrn
	LhfS6428r4cg2UhISfklzaSQ0AYCoEXjiWfsehFDeKQN4weSoACLTchZtbreqIR/E3fFgCNxJtF4Z
	kKWiwEJzSxiHh57Uze9aXSE35gGf4k5vbK/stEfzMvLR3BEp/tjbhmD5PCzJpNPYHzMLO8jacosSE
	vE+0vEhRGgJMbzuCCErWm8xlj2tg3I0K8MX9LlFM519R/0GUuz0BQ9mn1f2c5Pw21NikH6FOCRweV
	uj38bGAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIux8-00000008O4c-1gKe;
	Mon, 19 Oct 2026 21:31:30 +0000
Received: from mail-pl1-x648.google.com ([2607:f8b0:4864:20::648])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIux5-00000008O1g-0Elx
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 21:31:28 +0000
Received: by mail-pl1-x648.google.com with SMTP id d9443c01a7336-2e93f266d20so36194855ad.3
        for <kexec@lists.infradead.org>; Mon, 19 Oct 2026 14:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792445484; x=1793050284; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OlOiZMSQAlq56d5O025wMJ9SWaeJFCSne26CemMgHno=;
        b=f7jsEW6+hCnAnCCqDdCbC6ow9h9wWsfyOmKtYl3REbuAN/zAW2IaaI5f/SPwQOAWbh
         wgXElSik3EFu91a1ad3SxbS6xzCM/sM/pnlMQfr6ypt1XIvlPTOgycyFsmtmu2aQtW2G
         6GN6IDIG0BHUbIdyXfXLOQXU0OKXxR6+Ze8cBicbtlC0fyy9+yihiA6c149NJ3L0Cwop
         n0RK8DQYV3zdeaSXvzc6DBVY+iBHS+ZCfBPdgit9fe3NQr5BrVGABxjAYbf05+rYFvhe
         LLw338iCwhLaHV5q1+ptZVaiC9C3l3d9o3m63T0jDRj929qGLRL9kNgHmDZUSyi337gG
         oNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445484; x=1793050284;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OlOiZMSQAlq56d5O025wMJ9SWaeJFCSne26CemMgHno=;
        b=nc6YRQrD2p/WyAxoRCmEGEFv2vm/Y1xlmtxu/Vs8H+ygPuOvXpa3kX74MbCzJDInKU
         nn2foAIZg4m2A5DDKBMihVx9x7N5k9IH/9Z6HpEBZnKulQmaKZ+OoD1hy+jcaiU+aRYe
         y0eDzng6BFRYrBVtPuib9qbzO0QzJAnQCfrA72G9thbnnFGm9Pk142vOR51SlfWfqrYu
         ICA8SsaU49uUtLXm1CMa0btdVP1wTYzFdOuyJY7uoCLSur6m0R9TQhpNbOKuuwyA9Vf+
         YRkFQ+fEzjk4AHJZmI1Hm62POYD5BwHPQzL6AmU43Pwu02iUV3LPXL6iSvqinuja8S6O
         IMGA==
X-Gm-Message-State: AFq9FYKKVAGHq1zoUlW5/7c01ayvo0QsbcuxOMAL0UeL3HZwOsuLOF4R
	ZcTPEczrTHI0aNNt66AC2MeU9IYJk+m1jhgLlfQoeMfZ4vM+XES0QZ6cdPT9jN8oPQzcv59mINx
	bVEPpmJ9B3vuplG1jZ0NjTXoQR6+9ZvbBN6OMY5RVBJn1CuvanStxXoUDtlJUx9E+2rwUy+yop5
	yHyT7desmJunY3dyRIkCGn2HzSRNH+SvNsn4QJZfn3uj+6cSJCVes=
X-Received: from pllx8.prod.google.com ([2002:a17:902:7c08:b0:2e8:31af:11b0])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f607:b0:2e9:8505:5471 with SMTP id d9443c01a7336-2e9a68343d5mr79186475ad.7.1792445483766;
 Mon, 19 Oct 2026 14:31:23 -0700 (PDT)
Date: Mon, 19 Oct 2026 21:30:47 +0000
In-Reply-To: <20261019213054.3157159-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261019213054.3157159-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019213054.3157159-4-dmatlack@google.com>
Subject: [PATCH 03/10] PCI: Factor out bridge window probing from pci_read_bridge_windows()
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	David Matlack <dmatlack@google.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_143127_268013_92AEC7CA 
X-CRM114-Status: GOOD (  12.92  )
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
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move the code that determines which windows a bridge implements, which
requires temporarily writing to the window registers, out of
pci_read_bridge_windows() and into a new helper,
pci_probe_bridge_windows(). Probe all windows before reading any of
them.

A subsequent commit will obtain which windows are implemented by bridges
preserved across Live Update from the previous kernel instead of probing
them, since probing can temporarily disable windows.

No functional change intended.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/probe.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3cb2e481eddf..473e4389ffae 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -520,19 +520,14 @@ static void pci_read_bridge_mmio_pref(struct pci_dev *dev, struct resource *res,
 	}
 }
 
-static void pci_read_bridge_windows(struct pci_dev *bridge)
+/*
+ * Determine which windows @bridge implements. This requires temporarily
+ * writing to the window registers of windows that read as zero.
+ */
+static void pci_probe_bridge_windows(struct pci_dev *bridge)
 {
-	u32 buses;
 	u16 io;
 	u32 pmem, tmp;
-	struct resource res;
-
-	pci_read_config_dword(bridge, PCI_PRIMARY_BUS, &buses);
-	res.flags = IORESOURCE_BUS;
-	res.start = FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
-	res.end = FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
-	pci_info(bridge, "PCI bridge to %pR%s\n", &res,
-		 bridge->transparent ? " (subtractive decode)" : "");
 
 	pci_read_config_word(bridge, PCI_IO_BASE, &io);
 	if (!io) {
@@ -540,12 +535,8 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
 		pci_read_config_word(bridge, PCI_IO_BASE, &io);
 		pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
 	}
-	if (io) {
+	if (io)
 		bridge->io_window = 1;
-		pci_read_bridge_io(bridge, &res, true);
-	}
-
-	pci_read_bridge_mmio(bridge, &res, true);
 
 	/*
 	 * DECchip 21050 pass 2 errata: the bridge may miss an address
@@ -582,8 +573,29 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
 		if (tmp)
 			bridge->pref_64_window = 1;
 	}
+}
+
+static void pci_read_bridge_windows(struct pci_dev *bridge)
+{
+	u32 buses;
+	struct resource res;
+
+	pci_read_config_dword(bridge, PCI_PRIMARY_BUS, &buses);
+	res.flags = IORESOURCE_BUS;
+	res.start = FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
+	res.end = FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
+	pci_info(bridge, "PCI bridge to %pR%s\n", &res,
+		 bridge->transparent ? " (subtractive decode)" : "");
+
+	pci_probe_bridge_windows(bridge);
+
+	if (bridge->io_window)
+		pci_read_bridge_io(bridge, &res, true);
+
+	pci_read_bridge_mmio(bridge, &res, true);
 
-	pci_read_bridge_mmio_pref(bridge, &res, true);
+	if (bridge->pref_window)
+		pci_read_bridge_mmio_pref(bridge, &res, true);
 }
 
 void pci_read_bridge_bases(struct pci_bus *child)
-- 
2.56.0.212.g129ede20d9-goog


