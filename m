Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC42C60A2600
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 21:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CpyseyqA;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fa6+QBWP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rccGvdC4VDGY+kjlq/11HJtI0x1dTEfzAQPx1OmbdOk=; b=CpyseyqAEJU8iHBoFMF8qiQWcd
	+//YNHpUl5biVNPYV49GGXHWojd49C5ydZMI/w4pjg1+yDdWNR+r45J5NO8EL6eGCWSIxpFBjzSA1
	RPDLqROlf5XrtTKMYJR0rwprD+2AmurrfZ6nDqYgdU2HpJEGNw+41QbwdGcDXw9jx8mesD6D2OuTP
	lpBAHWW6UyzYQ+IHONfD80tdUqBnOpgZp+Rj7qdVeSIEXC+ST0YUUntnfjTNPUZluoPYoHQk9y1ss
	MxrREQqBqNzmFcZbJ4ZfdlVIMydCbcZBQBiF2M9azBHq+Of5pwOqb/wK1IlAGBAiIC0syILL42u2b
	Wnsv8bzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIux9-00000008O6G-2x1z;
	Mon, 19 Oct 2026 21:31:31 +0000
Received: from mail-pl1-x647.google.com ([2607:f8b0:4864:20::647])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIux5-00000008O1q-3GVk
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 21:31:30 +0000
Received: by mail-pl1-x647.google.com with SMTP id d9443c01a7336-2e869e00005so27544865ad.2
        for <kexec@lists.infradead.org>; Mon, 19 Oct 2026 14:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792445486; x=1793050286; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rccGvdC4VDGY+kjlq/11HJtI0x1dTEfzAQPx1OmbdOk=;
        b=fa6+QBWPbwjcYB5XHzTm3HneeM4xEsrDqyogGhhBqhLYmd5NxWKg4Z98++Emuarjoh
         7XyBMKW2KINPWsWKlKTC59N8sFc58QEtyGVqy2+0yht2zOw3RUndkexpANalUCMalzkQ
         v13rWzlm5wWBjoy6KTJBioi3szo8xiMBcggne5NkOx6mPGJtMO6B2DC365J5ctuE5Rmx
         5yQxcoZuONBNnp1/JrP0MKTgsDiemh/diaA5nvoPdTT+aSk3JsqVpWn2+cxN7ok/rw6p
         +bI0vx78CuyfHla3DFf6QTx6c1pcaEB8/htjCMQ2ABHQ5MYF9mnp2DhYbpqR9DjwllJx
         gZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445486; x=1793050286;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rccGvdC4VDGY+kjlq/11HJtI0x1dTEfzAQPx1OmbdOk=;
        b=MulyXyOeOosq/WyzLdjiGhjrQByR606Gvt8F7hSjI0QSmE8WCjGke510vpP24xFtC0
         4wfgsxVmZ+zBh3sdTrhx+s2QxgaLfO1yT9oTxJ5gvXyvAiut3GSZH1jKzS2BfgogugY2
         E7eTMK3kSVqfAHNCVjw5wY8zNmWgzE3x8vneqsB6vCTDCpsFRbZmnSygdN95M9/KR/xU
         f5pMNzeodnumVrqjQgLN5RUHWiyejr47M5GY/DUtkFR0uWWKvzhnpZNxqKk/G6/oTyyr
         XQMzSjOtWHzWaV4Oy4eu4gUHB1rIY1zlFzgkXjgCdx+REm9c29EQWQq7bOrDo8IVv5x8
         B+Ow==
X-Gm-Message-State: AFq9FYLYQQSUpLDZ0oc+mikcAC/hRrNL28Hm1qHz50cWkC7UuPPiuRLM
	xKwje7CCn8bO5YXQkCSjfRPa+xwKXT4AI75ce3+mVssshsbmDB9NZb140RvELtnq2SLD+MwVStU
	S2dInA1w3U2bQZfAanellqOo+WruS5IJlWo9MNZLn5go+BNu5pjnnXQUjBOjaJbEevGki4Mm7/3
	GQ/Ec1ce5F75MZQyQP4C6YN4PHahfReiuPWWG/1P6E3FrqdPYPthM=
X-Received: from plok11.prod.google.com ([2002:a17:903:3bcb:b0:2e9:5b68:4b7d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e949:b0:2e2:d02d:a173 with SMTP id d9443c01a7336-2e9a6f59777mr77394715ad.49.1792445485578;
 Mon, 19 Oct 2026 14:31:25 -0700 (PDT)
Date: Mon, 19 Oct 2026 21:30:49 +0000
In-Reply-To: <20261019213054.3157159-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261019213054.3157159-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019213054.3157159-6-dmatlack@google.com>
Subject: [PATCH 05/10] PCI: Skip programming bridge windows that are already programmed
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
X-CRM114-CacheID: sfid-20261019_143127_920751_1CD9BC12 
X-CRM114-Status: GOOD (  18.14  )
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

Skip updating the window registers of a bridge in
pci_setup_bridge_io(), pci_setup_bridge_mmio(), and
pci_setup_bridge_mmio_pref() if they already contain the values being
written (ignoring the read-only low bits of the base and limit
registers).

pci_setup_bridge_io() and pci_setup_bridge_mmio_pref() temporarily
disable the I/O and prefetchable memory windows while updating them,
since the base and limit of each window are split across multiple
registers. This happens even if the window is not changing, e.g. for
every bridge whose windows were assigned by firmware and claimed, since
__pci_bus_assign_resources_one() calls pci_setup_bridge() on every
bridge that is not yet enabled during enumeration.
pci_setup_bridge_mmio() updates the memory window with a single write,
but skip unchanged writes there too for consistency.

This prevents disabling the windows of bridges preserved across Live
Update during enumeration, which would disrupt memory transactions
targeting preserved devices below them, such as P2PDMA from other
preserved devices, or MMIO from VMs whose vCPUs keep running during
kexec.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/setup-bus.c | 52 ++++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index e8c94aa1d3c1..4bec76950f46 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -799,8 +799,8 @@ static void pci_setup_bridge_io(struct pci_dev *bridge)
 	struct pci_bus_region region;
 	unsigned long io_mask;
 	u8 io_base_lo, io_limit_lo;
-	u16 l;
-	u32 io_upper16;
+	u16 l, cur_l, l_mask;
+	u32 io_upper16, cur_io_upper16;
 
 	io_mask = PCI_IO_RANGE_MASK;
 	if (bridge->io_window_1k)
@@ -823,6 +823,18 @@ static void pci_setup_bridge_io(struct pci_dev *bridge)
 		io_upper16 = 0;
 		l = 0x00f0;
 	}
+
+	/*
+	 * Leave the I/O range alone if it is already programmed as needed,
+	 * rather than temporarily disabling it below. The low bits of the I/O
+	 * Base and Limit registers are read-only.
+	 */
+	pci_read_config_word(bridge, PCI_IO_BASE, &cur_l);
+	pci_read_config_dword(bridge, PCI_IO_BASE_UPPER16, &cur_io_upper16);
+	l_mask = ((u8)io_mask << 8) | (u8)io_mask;
+	if (!((cur_l ^ l) & l_mask) && cur_io_upper16 == io_upper16)
+		return;
+
 	/* Temporarily disable the I/O range before updating PCI_IO_BASE */
 	pci_write_config_dword(bridge, PCI_IO_BASE_UPPER16, 0x0000ffff);
 	/* Update lower 16 bits of I/O base/limit */
@@ -836,7 +848,7 @@ static void pci_setup_bridge_mmio(struct pci_dev *bridge)
 	struct resource *res;
 	const char *res_name;
 	struct pci_bus_region region;
-	u32 l;
+	u32 l, cur_l;
 
 	/* Set up the top and bottom of the PCI Memory segment for this bus */
 	res = &bridge->resource[PCI_BRIDGE_MEM_WINDOW];
@@ -849,6 +861,12 @@ static void pci_setup_bridge_mmio(struct pci_dev *bridge)
 	} else {
 		l = 0x0000fff0;
 	}
+
+	/* The low bits of the Memory Base and Limit registers are read-only */
+	pci_read_config_dword(bridge, PCI_MEMORY_BASE, &cur_l);
+	if (!((cur_l ^ l) & 0xfff0fff0))
+		return;
+
 	pci_write_config_dword(bridge, PCI_MEMORY_BASE, l);
 }
 
@@ -857,14 +875,7 @@ static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
 	struct resource *res;
 	const char *res_name;
 	struct pci_bus_region region;
-	u32 l, bu, lu;
-
-	/*
-	 * Clear out the upper 32 bits of PREF limit.  If
-	 * PCI_PREF_BASE_UPPER32 was non-zero, this temporarily disables
-	 * PREF range, which is ok.
-	 */
-	pci_write_config_dword(bridge, PCI_PREF_LIMIT_UPPER32, 0);
+	u32 l, bu, lu, cur_l, cur_bu, cur_lu;
 
 	/* Set up PREF base/limit */
 	bu = lu = 0;
@@ -882,6 +893,25 @@ static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
 	} else {
 		l = 0x0000fff0;
 	}
+
+	/*
+	 * Leave the PREF range alone if it is already programmed as needed,
+	 * rather than temporarily disabling it below. The low bits of the
+	 * Prefetchable Memory Base and Limit registers are read-only.
+	 */
+	pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &cur_l);
+	pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32, &cur_bu);
+	pci_read_config_dword(bridge, PCI_PREF_LIMIT_UPPER32, &cur_lu);
+	if (!((cur_l ^ l) & 0xfff0fff0) && cur_bu == bu && cur_lu == lu)
+		return;
+
+	/*
+	 * Clear out the upper 32 bits of PREF limit.  If
+	 * PCI_PREF_BASE_UPPER32 was non-zero, this temporarily disables
+	 * PREF range, which is ok.
+	 */
+	pci_write_config_dword(bridge, PCI_PREF_LIMIT_UPPER32, 0);
+
 	pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, l);
 
 	/* Set the upper 32 bits of PREF base & limit */
-- 
2.56.0.212.g129ede20d9-goog


