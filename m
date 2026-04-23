Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49A1FDEE51
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 21:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E/PZfm0ILlaeTWExhdrHJ+nS/9VkLe0d8hpRsDexX1A=; b=ssCPT9ByUE1YiXxkYJWB06VKx7
	YVUEhr+bSnXumlzULrqcYWtYIwNT+1GUQyt+RnO/34o4Gce3tZeomeEvGw5HpTMHZ3w2Gwu2B2cDL
	PRswqPbO6eCitKLJtnL53gqe+AUXnz95dd97ErspK7juIOCkHDEq6ZYCE9VKzYjqNIFBD08EG4Xzo
	wLfu9846nofRfLFAc2N+nV0syQWNhGpaHVXmHj8g2hQ572eCe56sPYHcpmiZxd4jGlptKEbOT6KsC
	voQu8nAEbFLeMVAzYIL9nTFPM12kTRQbYE4jtFNXwjLxcMWiLn7/7BBET0cS/vALwReZNxbO++jF2
	U8AvoZEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG1WN-0000000CLFP-2lbs;
	Thu, 23 Apr 2026 21:23:39 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG1WK-0000000CLBb-3CUq
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 21:23:38 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2b24af7ca99so96472695ad.1
        for <kexec@lists.infradead.org>; Thu, 23 Apr 2026 14:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776979416; x=1777584216; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/PZfm0ILlaeTWExhdrHJ+nS/9VkLe0d8hpRsDexX1A=;
        b=R3dneC21/LI6hpx4Gp3IX1J0BgqQF1FS3HVJ70HMMiTEtI28THFEEogzRPMFyZ/R2V
         UB4IM7vhIeTJzQzDfr72l5m1aAx4Nybr50n95Qh2WU8gTaPUS1sZrqKgGtxge0y33t8C
         u/59SVUoNEwYtrfwakzuABukZBLlNObEgRRekxZ8hPt/c/kfU5YFTcCLrzy5t26axpGZ
         aLp60bw1Vf51asv9d0MW65bKXQ3yw9Ljv12Zk+RrEEzlMpoklWxTXEbYtRv/RAkioo94
         iOFY/oNN3WPqPlxyJzh7YRLx9RZvntXpJ9+wP2PCO1RlWDFvfKemeK8LENVrKHkqMFyx
         9zsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979416; x=1777584216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/PZfm0ILlaeTWExhdrHJ+nS/9VkLe0d8hpRsDexX1A=;
        b=ZVwMc9RnjR7dswAOhv2br9aUU7AN674Nanyh68BI1oJWt9O99qXY0vrrhVZvqZ9IZW
         mGrhoXMY/5xxu5O4KeY0XZIP4YCD45qpcQ6wqRuNShCw62d2/AE/k/p4h2LZoley6F8K
         M/Z2rJgQQvxuYxpy3P6R6jVqN8esjmmJtfybD0NzENWb5tO3/tADxDrISYvvP0ltaE9Y
         7dVFR6+D5o0VVdAl7me2NHWQxxt79lsxgT0QbzJ5cYk8x51lf1hWKZQGO9uiJ+mPTaZv
         hnsYijVnfwgeC+MpXgdS9Rr2la9SKiUFunqL8uL+cuPq4hHuoViZdC7x7ebykMtNydAG
         6KJw==
X-Forwarded-Encrypted: i=1; AFNElJ/L/nBtiaKk1GkC/GQtMEiNYWUpfSCbH5lXNXEg8tJKry1r1BkTQ/aIVVPAUw/1A8wijBn/CA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy5WFOrXHLZc9wUPofXiOaICOXfPEF1CB/BpYSUAtGf/E+YA4m5
	RymxXrEXuE3Ay3eBrX38R5Rappq++ubeV1XIiBBqCbKZqcK5Jbaz/Ktku1vqRyIUwgZVbB3BwKB
	ak4bnP5iUK3nOLQ==
X-Received: from plav22.prod.google.com ([2002:a17:902:f0d6:b0:2b0:5380:49f1])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1a88:b0:2b2:5ec6:dcf6 with SMTP id d9443c01a7336-2b5f9e85f20mr294713095ad.8.1776979415642;
 Thu, 23 Apr 2026 14:23:35 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:23:13 +0000
In-Reply-To: <20260423212316.3431746-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423212316.3431746-10-dmatlack@google.com>
Subject: [PATCH v4 09/11] PCI: liveupdate: Inherit ARI Forwarding Enable on
 preserved bridges
From: David Matlack <dmatlack@google.com>
To: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_142336_822168_75C7BAE0 
X-CRM114-Status: GOOD (  13.06  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Inherit the ARI Forwarding Enable on preserved bridges and update
pci_dev->ari_enabled accordingly during a Live Update. This ensures that
the preserved devices on the bridge's secondary bus can be identified
with the same expanded 8-bit function number after a Live Update.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c |  4 ++++
 drivers/pci/pci.c        | 12 +++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 54a90ff02bdd..25c86cd4c173 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -128,6 +128,10 @@
  *  * The PCI core inherits all ACS flags enabled on incoming preserved devices
  *    rather than assigning new ones. This ensures that TLPs are routed the same
  *    way after Live Update and ensures that IOMMU groups do not change.
+ *
+ *  * The PCI core inherits ARI Forwarding Enable on all bridges with downstream
+ *    preserved devices to ensure that all preserved devices on the bridge's
+ *    secondary bus are addressable after the Live Update.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e615b7c3e430..b45539c55c7d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3498,8 +3498,9 @@ void pci_configure_ari(struct pci_dev *dev)
 {
 	u32 cap;
 	struct pci_dev *bridge;
+	u16 val = 0;
 
-	if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
+	if (!pci_is_pcie(dev) || dev->devfn)
 		return;
 
 	bridge = dev->bus->self;
@@ -3510,6 +3511,15 @@ void pci_configure_ari(struct pci_dev *dev)
 	if (!(cap & PCI_EXP_DEVCAP2_ARI))
 		return;
 
+	if (pci_liveupdate_incoming(bridge)) {
+		pcie_capability_read_word(bridge, PCI_EXP_DEVCTL2, &val);
+		bridge->ari_enabled = !!(val & PCI_EXP_DEVCTL2_ARI);
+		return;
+	}
+
+	if (pcie_ari_disabled)
+		return;
+
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
 		pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
 					 PCI_EXP_DEVCTL2_ARI);
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog


