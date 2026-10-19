Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9E60A3807
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 21:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4Cf+x7Tn;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=l+d+ytWU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C0Zll4v1/3YDrC6QBHjix9780IIPkFEga7v4jahmDjE=; b=4Cf+x7TnhuxPqNmLSsebjTT7MS
	A760OpESpgArwArrrBad+W8pj1HEWRSLALw/L0Z6g9RgdVmQH8mQ0DcPmaTHywC6MNB+hOB3V2Vxe
	8krvFE2usRDrb8zQbwQR9DaaKMsum1P/bCO8mUKnhg15sPrmnt5VCsdFvi+AsmWPjOl+ceNljgCaD
	VZsvkS/BU+uoHfeK46qSrA9F++1OGQ4o7P4gxBqtGBfYj7oagniKbzRyi7ZHIZsOUqce7Y0f3PC94
	dhgVFz/vtyM54esdG3CXHUpWGGOasmMRNDJux8qg/TGATmraQFzonT0YyKFp0mGbgGpV7OSzOvdsG
	9eYZtt5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIux6-00000008O3e-3Gnr;
	Mon, 19 Oct 2026 21:31:28 +0000
Received: from mail-pl1-x645.google.com ([2607:f8b0:4864:20::645])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIux0-00000008O10-3nLf
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 21:31:27 +0000
Received: by mail-pl1-x645.google.com with SMTP id d9443c01a7336-2e93e2f72bfso30484135ad.3
        for <kexec@lists.infradead.org>; Mon, 19 Oct 2026 14:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792445482; x=1793050282; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C0Zll4v1/3YDrC6QBHjix9780IIPkFEga7v4jahmDjE=;
        b=l+d+ytWU3Zg5HHBjcGU9DVkb4RO0bVTcV1JGeUb00epqsRi2ugHKQASCzmMaTAXx9p
         4Jm+HHNLPxMjZDGu7MnNlFQvIq+IZw6wO0GaUj4I+UxnSJWfPRrHGHvrsZIA56hnayo3
         R/j0g75vmbLvmV7RslMOgKVoV9HC6M+DSYDrbxgM4UHUe7qzmoyS9CDjNa71xRR/TS/j
         GwhqmQBrlGBHV8QEjzz/OJiRb2cOJlxcMeVQhVwG+MUQxupOSc7TzqArro5mVPQCE24E
         BDQ/5FyIsMvRnMsYbtHE3ZF+dYPjW08+lKTF0jS6Q3vK09X0QYiwcaNgULch2OKoMzFh
         A6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445482; x=1793050282;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C0Zll4v1/3YDrC6QBHjix9780IIPkFEga7v4jahmDjE=;
        b=Ws5cb6m4CqGjgiojPIVx20YXBtgfXvJPjX3vlLvLBylMOzAqbIAisDQlBHw1WWm0+F
         i1yiCkuStMeLa5CmQNc5zDuPqIpgKlxvtskozIfihpTtzoaLmFIr8Y5tvy8XAohTzAKv
         fyJugfn1N+hUETes8RYH9TiJlNUhdqxy1CbA2lnXTF9aywZal48mk7Sbn8cao8EpAmyt
         tW6OSFnCpK36DKrfVQAjEA+MAvCdUV34xj41BuWJRZ+Cc+iJMkRivUoc9r6NbeBmwyBq
         u2DSUz2sIF7XcddYuJtTGzC2kUPifLtqSZxQFf07O+InVXR3sYdvLaSDPw4qq6q7qy0s
         odyw==
X-Gm-Message-State: AFq9FYLxqmfXmUJi+YEX/nSlD90l9OvOZL0KaA6p0MXH/WwMerM1W3qv
	nDNEhy+i2w8S+GyoXYgfUUg7Pa3487YFiBEN9ntBa7Qzg7paoDl/SFtDktBh8CXvxsTZ7sleAZq
	rK3Gyb2xpdxrD9yLheVf7rpCoPMbhSmnmyvf0z2hel60j0rOrep/stHQZQbTQR4aUTnUsF3JyBp
	T5uMQEEwtBpLK2/cq1DJ6QqsEWtlUBUhG3di1GwR9VAv5MIj2Hwc0=
X-Received: from plbbi9.prod.google.com ([2002:a17:902:bf09:b0:2e3:c3e:def2])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e84a:b0:2e9:4b65:368e with SMTP id d9443c01a7336-2e9a6d1eaa1mr80079565ad.15.1792445481409;
 Mon, 19 Oct 2026 14:31:21 -0700 (PDT)
Date: Mon, 19 Oct 2026 21:30:45 +0000
In-Reply-To: <20261019213054.3157159-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261019213054.3157159-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019213054.3157159-2-dmatlack@google.com>
Subject: [PATCH 01/10] PCI: Factor out BAR sizing from pci_read_bases()
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
X-CRM114-CacheID: sfid-20261019_143122_943800_E33F7CB7 
X-CRM114-Status: GOOD (  11.92  )
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
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move the code that sizes the standard BARs and the Expansion ROM BAR,
including disabling decoding while sizing, out of pci_read_bases() and
into a new helper, pci_size_bases().

A subsequent commit will obtain the sizes of the BARs of devices
preserved across Live Update from the previous kernel instead of sizing
them, since sizing requires disabling decoding.

No functional change intended.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/probe.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index debe0ad1ef68..9187f1d91766 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -323,22 +323,11 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 	return (res->flags & IORESOURCE_MEM_64) ? 1 : 0;
 }
 
-static __always_inline void pci_read_bases(struct pci_dev *dev,
-					   unsigned int howmany, int rom)
+static void pci_size_bases(struct pci_dev *dev, unsigned int howmany, int rom,
+			   u32 *stdbars, u32 *rombar)
 {
-	u32 rombar, stdbars[PCI_STD_NUM_BARS];
-	unsigned int pos, reg;
 	u16 orig_cmd;
 
-	BUILD_BUG_ON(statically_true(howmany > PCI_STD_NUM_BARS));
-
-	if (dev->non_compliant_bars)
-		return;
-
-	/* Per PCIe r4.0, sec 9.3.4.1.11, the VF BARs are all RO Zero */
-	if (dev->is_virtfn)
-		return;
-
 	/* No printks while decoding is disabled! */
 	if (!dev->mmio_always_on) {
 		pci_read_config_word(dev, PCI_COMMAND, &orig_cmd);
@@ -350,11 +339,29 @@ static __always_inline void pci_read_bases(struct pci_dev *dev,
 
 	__pci_size_stdbars(dev, howmany, PCI_BASE_ADDRESS_0, stdbars);
 	if (rom)
-		__pci_size_rom(dev, rom, &rombar);
+		__pci_size_rom(dev, rom, rombar);
 
 	if (!dev->mmio_always_on &&
 	    (orig_cmd & PCI_COMMAND_DECODE_ENABLE))
 		pci_write_config_word(dev, PCI_COMMAND, orig_cmd);
+}
+
+static __always_inline void pci_read_bases(struct pci_dev *dev,
+					   unsigned int howmany, int rom)
+{
+	u32 rombar, stdbars[PCI_STD_NUM_BARS];
+	unsigned int pos, reg;
+
+	BUILD_BUG_ON(statically_true(howmany > PCI_STD_NUM_BARS));
+
+	if (dev->non_compliant_bars)
+		return;
+
+	/* Per PCIe r4.0, sec 9.3.4.1.11, the VF BARs are all RO Zero */
+	if (dev->is_virtfn)
+		return;
+
+	pci_size_bases(dev, howmany, rom, stdbars, &rombar);
 
 	for (pos = 0; pos < howmany; pos++) {
 		struct resource *res = &dev->resource[pos];
-- 
2.56.0.212.g129ede20d9-goog


