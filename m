Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF7ECD5BB0
	for <kexec@archiver.kernel.org>; Fri, 22 May 2026 20:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dMXxmfHGErf7yBzoXqh/yDUR2jlzP0FOZNAJXyHr7Dw=; b=XxqcATse5NTi8YvBk8NkJFm4E3
	or/S1IVNLFTGe7818HxO+LuIBPqiRwee9nsLBRH7t8NemR8IzlXLn7cofdlKc+LxoYXZveN/FIm9S
	zR0MhbAchhdp89wzYYTUdF35jY3HjOrv8VxTr/iWbkJAuSKdCnLues4As5p192yCSvNJ8zH7Th3Qk
	rCY2CASUcZnbQK5/ZvACi0eMIPUkbj6QsCm8m78+sDqvPWX6iCCuu2G90cGb747r7UtZKPk7PvPXW
	nVr7vBsJ46gfbzrhIihhc5qbgvq4gFvsUSwzYVNdeiGlHgB9DnQrmoR/B0wqV9QrrThghGCOWxFto
	f7ZgST9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQWPv-0000000Brvx-0UX8;
	Fri, 22 May 2026 20:24:23 +0000
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQWPr-0000000BrqU-2Z9c
	for kexec@lists.infradead.org;
	Fri, 22 May 2026 20:24:20 +0000
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-365e70c39d0so7332462a91.0
        for <kexec@lists.infradead.org>; Fri, 22 May 2026 13:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779481459; x=1780086259; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dMXxmfHGErf7yBzoXqh/yDUR2jlzP0FOZNAJXyHr7Dw=;
        b=c5ZvppG4xN2arsGvK5EgYX6mFmMtAryBbIZSEjyv/mT9xM11u0GcUTSiootECnSzUw
         o6HClIpCl/+ZlzzcKz7ZOmOgGxKS7tzz8YAyFey9s3T34OkUNGJLlSnbLGXNnllJhkic
         I2xnSqCYnSRPtctvz46YDeIr7ZChZkzg9By6Oad3nm6eXVKjlSu3t8F0UMHf0x3tzJoX
         MazTmZWrBFAhjgSNiEiohag9wyDQGV7WdRmzkhVp6xySXrqUjaRoE3HKemWZzWs4GNF+
         AS/f315Gve38d1d0Mm4gDw8VDjG2yMBcZWgwWS5EHfMwNqHjbdi4kEfZ20k2now/qkAm
         pqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779481459; x=1780086259;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMXxmfHGErf7yBzoXqh/yDUR2jlzP0FOZNAJXyHr7Dw=;
        b=p9lKiCqrSUC/UwOsnx7LoHaE1va+mG4js9fUNFnJLOwVhIkBki+Hyhy3QpLIx2CktG
         W6y6b++Xbvs5W32XIkh5iR/WwJ0wQjksogk/j6jJlhHZN+ZpdUn5ONLH3U+95FdT7or2
         tXFxx1DE/+rhUOBJffN9+JMuUBXY9OVxgkxl2ImxHyYtHPf6VVBi9nMzk1iYxwlwVSkK
         WobQXWyiq1Wmh+Y0GjgXWGqHDTXt7Vor9ndHF8B0mfKR1vGA0Vb65Rc7B44ekPGC59Tz
         QfipToWPPgVmk8C+9eu5Kz183nU6bcsHd47MO+hkkVmXnq9lewEENURwOx/p36T+N+oN
         10/A==
X-Gm-Message-State: AOJu0YyqZFvxYdm0F9/WE6jNx0zWsz4vUNt4DhcVGZ4knP5k3iRpTnWb
	mxawIAqwEZibYVET0EajvFeJOvVPDuHmtkOumFcczWmZa+xLpkhUZIi9n66XGNZe2Q26qcKIAqy
	pGlWsSZefrTX94M7ZqikaE9kpjnMlQb2R5lkJ8nTV473sCpm+7EIWtsbRAffUzvm8R1FrkY7izX
	bHP82fCkRuCkTzq+Y+elxFK0gkJ7Lm5PPk9P5iCakngeIYP5w283c=
X-Received: from pjbsz6.prod.google.com ([2002:a17:90b:2d46:b0:369:4369:c7f9])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3807:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-36a6741dd88mr5140261a91.1.1779481458189;
 Fri, 22 May 2026 13:24:18 -0700 (PDT)
Date: Fri, 22 May 2026 20:24:05 +0000
In-Reply-To: <20260522202410.3104264-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260522202410.3104264-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522202410.3104264-8-dmatlack@google.com>
Subject: [PATCH v6 07/12] PCI: Refactor matching logic for pci_dev_acs_ops
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_132419_713508_81884B29 
X-CRM114-Status: GOOD (  14.70  )
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

Refactor the logic to match devices to pci_dev_acs_ops by factoring out
the loop and device matching into its own routine. This eliminates some
duplicate code between pci_dev_specific_enable_acs() and
pci_dev_specific_disable_acs_redir(), and will also be used in a
subsequent commit to check if a device requires device-specific
enable_acs() during a Live Update.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/quirks.c | 50 ++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index caaed1a01dc0..171caec2bc47 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5384,9 +5384,6 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
  */
 static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
 {
-	if (!pci_quirk_intel_pch_acs_match(dev))
-		return -ENOTTY;
-
 	if (pci_quirk_enable_intel_lpc_acs(dev)) {
 		pci_warn(dev, "Failed to enable Intel PCH ACS quirk\n");
 		return 0;
@@ -5406,9 +5403,6 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	int pos;
 	u32 cap, ctrl;
 
-	if (!pci_quirk_intel_spt_pch_acs_match(dev))
-		return -ENOTTY;
-
 	pos = dev->acs_cap;
 	if (!pos)
 		return -ENOTTY;
@@ -5436,9 +5430,6 @@ static int pci_quirk_disable_intel_spt_pch_acs_redir(struct pci_dev *dev)
 	int pos;
 	u32 cap, ctrl;
 
-	if (!pci_quirk_intel_spt_pch_acs_match(dev))
-		return -ENOTTY;
-
 	pos = dev->acs_cap;
 	if (!pos)
 		return -ENOTTY;
@@ -5458,22 +5449,25 @@ static int pci_quirk_disable_intel_spt_pch_acs_redir(struct pci_dev *dev)
 static const struct pci_dev_acs_ops {
 	u16 vendor;
 	u16 device;
+	bool (*match)(struct pci_dev *dev);
 	int (*enable_acs)(struct pci_dev *dev);
 	int (*disable_acs_redir)(struct pci_dev *dev);
 } pci_dev_acs_ops[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
+	    .match = pci_quirk_intel_pch_acs_match,
 	    .enable_acs = pci_quirk_enable_intel_pch_acs,
 	},
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
+	    .match = pci_quirk_intel_spt_pch_acs_match,
 	    .enable_acs = pci_quirk_enable_intel_spt_pch_acs,
 	    .disable_acs_redir = pci_quirk_disable_intel_spt_pch_acs_redir,
 	},
 };
 
-int pci_dev_specific_enable_acs(struct pci_dev *dev)
+static const struct pci_dev_acs_ops *pci_dev_acs_ops_get(struct pci_dev *dev)
 {
 	const struct pci_dev_acs_ops *p;
-	int i, ret;
+	int i;
 
 	for (i = 0; i < ARRAY_SIZE(pci_dev_acs_ops); i++) {
 		p = &pci_dev_acs_ops[i];
@@ -5481,33 +5475,29 @@ int pci_dev_specific_enable_acs(struct pci_dev *dev)
 		     p->vendor == (u16)PCI_ANY_ID) &&
 		    (p->device == dev->device ||
 		     p->device == (u16)PCI_ANY_ID) &&
-		    p->enable_acs) {
-			ret = p->enable_acs(dev);
-			if (ret >= 0)
-				return ret;
-		}
+		    p->match(dev))
+			return p;
 	}
 
+	return NULL;
+}
+
+int pci_dev_specific_enable_acs(struct pci_dev *dev)
+{
+	const struct pci_dev_acs_ops *p = pci_dev_acs_ops_get(dev);
+
+	if (p && p->enable_acs)
+		return p->enable_acs(dev);
+
 	return -ENOTTY;
 }
 
 int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
 {
-	const struct pci_dev_acs_ops *p;
-	int i, ret;
+	const struct pci_dev_acs_ops *p = pci_dev_acs_ops_get(dev);
 
-	for (i = 0; i < ARRAY_SIZE(pci_dev_acs_ops); i++) {
-		p = &pci_dev_acs_ops[i];
-		if ((p->vendor == dev->vendor ||
-		     p->vendor == (u16)PCI_ANY_ID) &&
-		    (p->device == dev->device ||
-		     p->device == (u16)PCI_ANY_ID) &&
-		    p->disable_acs_redir) {
-			ret = p->disable_acs_redir(dev);
-			if (ret >= 0)
-				return ret;
-		}
-	}
+	if (p && p->disable_acs_redir)
+		return p->disable_acs_redir(dev);
 
 	return -ENOTTY;
 }
-- 
2.54.0.746.g67dd491aae-goog


