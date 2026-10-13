Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6844CC6B19
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 16:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xeOaWY8G0RyJWpiIZt4rGXklqrMOz8YRWSRZ+Jyg5IA=; b=FJ6VoDp4JKPACQ6l25+5uYEHbN
	kCCx5/sJSLRO2LMsQCC6tsZj07XPae0ob0xK0FiSyYDFI9zLDQXcNW3YdPOLgPVdvNeH3JKsNyvs9
	lftnZG7GWZ141fJc/AHnkQVz7DS7oRf3NQ9o774nazPYzAbeF4xtnRCw+wL8BLC6kK9zj36c/Mv+2
	dSibU/uf2OE/U+UEtlidVyqCgazN5sUbWbPJRCctiv1U7PuzloAgkIo1kwNar8FddbLKM1JaccEiZ
	hRjtqRvuWASn+gSZfeUgJZZrYXUAzJD6xXvQaskfhc9SuOde+fEyTpEsgZLYeqt3Y0KmKR54vQsca
	JFibEQVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfK2-0000000DUli-47p0;
	Tue, 13 Oct 2026 16:25:50 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfK0-0000000DUi2-3j8r
	for kexec@bombadil.infradead.org;
	Tue, 13 Oct 2026 16:25:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xeOaWY8G0RyJWpiIZt4rGXklqrMOz8YRWSRZ+Jyg5IA=; b=apBFKD4nxHJmA5pTgdCoNKdK/w
	57Noekrr9/noKquo98CCwcpDwpPOlqQzyq+hiv5Ag0JY85nVAeCe7KAsCZb4KfCkUoN/tUSxzcBWs
	QgU1pl6Or/f4AwvnbXkCSCemJ8V7LN3rQAfljGkAAJ1ifjF8y8+OySQpAmACt5B8RKI5eVmcLSAf5
	PJ9Yw+ObH8rsBlnRJ3N5qzrIHZ/0RWfIm8SxE/eJYMIl1MmlEfDyTCCjAH+FhJnWSoI1TJaDr4S8+
	CwMjgGQnMDgqLpVyy0oO72wDu05wFpJPWVKR4n8oPB9ealkWRk/e+IRWRWBq3oQp9+XekFEfl2EdN
	+7ZH5v0Q==;
Received: from mail-pl1-x648.google.com ([2607:f8b0:4864:20::648])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGfJy-0000000FmJE-0miG
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 16:25:47 +0000
Received: by mail-pl1-x648.google.com with SMTP id d9443c01a7336-2e8ad8c5f80so35953835ad.0
        for <kexec@lists.infradead.org>; Tue, 13 Oct 2026 09:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791908744; x=1792513544; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xeOaWY8G0RyJWpiIZt4rGXklqrMOz8YRWSRZ+Jyg5IA=;
        b=fqcq50JKrICVJ/riUd0Y9mybLlmQEhLDEsykUh8zcS61Lv+xK/Y1cIjC51ZvdJO+Vd
         kd94CgrAmjhVR+EqG5strY9Rja/RgVBh3YV+m7wLw1KgFVnTaGHbP2F6aaj+vi0U5T6f
         l78RBs87/Us6blyzXoN/N0Zn7tlD4MGP3ZOGJoiJ80lyY6vNrnsOAe99hvYgUZmWAYWK
         XTWxn0A9PzvXFmFS2cBwHv+GlSAvpRJEK2OQmMuD2CulPgv4RQgPTrsXkFPCkz0WRk8S
         tKLWBDLc2CfjBZRLpwc+rTdYa9izpfoMiMVM85vxlWpoZPgewTeQxNYg9bZUG4Mhea9C
         iqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791908744; x=1792513544;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xeOaWY8G0RyJWpiIZt4rGXklqrMOz8YRWSRZ+Jyg5IA=;
        b=ex6Q/VbD5fDePhHsX0zVO0ph+Y7m/B+Oy6/uFU+Hh1KYytdgRNsUvWK1ISJW3a8INC
         lQy552jkfaqiFaa6tvW1Ai40YZ/g4i0JnyLalp+tMQmpBJpVTIVfcEQbZphEZw671vja
         I/inVvTmFMhleW6V29WSZastgLrQnvGeuoHPT9xP3u/CZLvxCiZyOhMayEOBaCNuJbRh
         4oN6+6KLPgX0dRVOC8X8jxHWyGIF6bCRbOF+bWoM1dJFGA1UqzPR+wUmIfQR7cphAmni
         KDju0FTHbGkjc7+2kxNDbHthCKn2qsJYtit050sIZfiHZRWUOatnAqYYE1AXOeR5jRko
         CsYg==
X-Gm-Message-State: AFq9FYIe0kdAVSq6PrtGxOK5QdxHUQylHOP2gQt+dGZd7CNen4XRv7y7
	iFVabqE2Km75MgLji8Ko8kkVwqeMN9FWJgHGBOlXsIT7B9ZncN87XhRTdHdMWfxoWN8A1TO6+pj
	3k39Zjp0jbr8nc6KRbjnwK9nd2fAkAqc7izeqYqsgNgTW/71onZly4gDanUoUpD8Tn4Iou2lSh8
	xS5YJIzDFnsMBzrQrihTtMW0Ml3DYyBnCSfYtdl1uhasg0wQ6j7sk=
X-Received: from pllt11.prod.google.com ([2002:a17:902:dccb:b0:2e5:b835:73c5])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:41d2:b0:2e4:cc75:2707 with SMTP id d9443c01a7336-2e84280e7a2mr118758025ad.7.1791908743529;
 Tue, 13 Oct 2026 09:25:43 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:25:23 +0000
In-Reply-To: <20261013162529.1928093-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20261013162529.1928093-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013162529.1928093-8-dmatlack@google.com>
Subject: [PATCH v10 07/13] PCI: Refactor matching logic for pci_dev_acs_ops
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
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_172546_317596_CB2DF882 
X-CRM114-Status: GOOD (  16.83  )
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
the device matching loop into its own routine, pci_dev_acs_ops_get().
This eliminates duplicate code between pci_dev_specific_enable_acs() and
pci_dev_specific_disable_acs_redir(), and will also be used in a
subsequent commit to check if a device requires device-specific
enable_acs() during a Live Update.

No functional change intended.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/quirks.c | 51 ++++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de9bbccda21f..7aee30734303 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5377,9 +5377,6 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
  */
 static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
 {
-	if (!pci_quirk_intel_pch_acs_match(dev))
-		return -ENOTTY;
-
 	if (pci_quirk_enable_intel_lpc_acs(dev)) {
 		pci_warn(dev, "Failed to enable Intel PCH ACS quirk\n");
 		return 0;
@@ -5399,9 +5396,6 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	int pos;
 	u32 cap, ctrl;
 
-	if (!pci_quirk_intel_spt_pch_acs_match(dev))
-		return -ENOTTY;
-
 	pos = dev->acs_cap;
 	if (!pos)
 		return -ENOTTY;
@@ -5429,9 +5423,6 @@ static int pci_quirk_disable_intel_spt_pch_acs_redir(struct pci_dev *dev)
 	int pos;
 	u32 cap, ctrl;
 
-	if (!pci_quirk_intel_spt_pch_acs_match(dev))
-		return -ENOTTY;
-
 	pos = dev->acs_cap;
 	if (!pos)
 		return -ENOTTY;
@@ -5451,56 +5442,56 @@ static int pci_quirk_disable_intel_spt_pch_acs_redir(struct pci_dev *dev)
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
 		if ((p->vendor == dev->vendor ||
 		     p->vendor == (u16)PCI_ANY_ID) &&
 		    (p->device == dev->device ||
-		     p->device == (u16)PCI_ANY_ID) &&
-		    p->enable_acs) {
-			ret = p->enable_acs(dev);
-			if (ret >= 0)
-				return ret;
+		     p->device == (u16)PCI_ANY_ID)) {
+			if (!p->match || p->match(dev))
+				return p;
 		}
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
2.56.0.385.gd3acb90ef8-goog


