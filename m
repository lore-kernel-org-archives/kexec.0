Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B61BC44507
	for <kexec@archiver.kernel.org>; Fri, 10 Jul 2026 21:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=92/0TGptvABo802k4Z/+83heETiRRWcuAF49mOH2xHs=; b=pSz1rka2G3B1DYJpP0R3s3EOnD
	Cdj5x64Z6h+i0FD2HzeU4EzNY6/fc+iUChfJAoeEanV5Ngcc/sUszoHIrZioX/zC0T9Qo1OqZq4FQ
	7us0B2uAR9CTaEVvJKZtaaQeNzgu1C250/PX7fm8cI5oC7pJX+YHUueQbr3IQGxhUAPZP4/juUwAP
	gbjdgta/Ox1AR2Izq97fjiZwdygN6Hufmbjw0rucsUjIdzuePWH3Tj7evy816ZvJdAeG8KxBK+wHO
	Y7lwTsquKkb5zMF6VbuF2DwaWxicmHfC/BeqcLLFD+YRbQAsWwqWd1vXSRyXqcZcT8DJAWBv2dvsK
	B4RiTBww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIjx-00000005pTl-1n6p;
	Fri, 10 Jul 2026 21:26:33 +0000
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIjt-00000005pO3-2zyO
	for kexec@lists.infradead.org;
	Fri, 10 Jul 2026 21:26:31 +0000
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-8485b7e18b4so2497257b3a.1
        for <kexec@lists.infradead.org>; Fri, 10 Jul 2026 14:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783718789; x=1784323589; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=92/0TGptvABo802k4Z/+83heETiRRWcuAF49mOH2xHs=;
        b=A7lkl69IGAMZy90DEpLTSefIqLDRNnFkcd2mwddoPTdPUrYOMmrEJJI/04dsi1W3Jy
         lABa6odFW8lNgvBDMP8oTEjLSPyZrvWxcrHNvJYMpOnL6fI0u6d2SyOBfEGuEwhfPWWg
         hGY1VWow9VGxqIhhfahx9F/FQFZ2Lpw85Ztl6xVnFgCQYF9xyRpUg1QViuQt/kbJcvRg
         NQgoT1Eof0PGCwQKnTZUqwY9wQLYdwsHY1wH+6EJ9eRKgCEUcRBNvmwkKBKroa7u7kj+
         He+Aqzs0nvSM72pVgW1StmYTHAVPZ8rrGkHtKSC2599l3RILLufP0fayety10ablUDOv
         LlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718789; x=1784323589;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=92/0TGptvABo802k4Z/+83heETiRRWcuAF49mOH2xHs=;
        b=kNUCoLmDk9tOtzZOWCyTn9mibcXVbdlJwi5542brfIX7SpUifQ43AdUi6qgGGhkGvT
         eX9lbqPliYj3LecCmxVBZYrvWyPFJIUdmbXtgiNmh9CyPOyIU0P+wuL4zk9sq68PK3k6
         ZT2374gPYjfwx8qjc9swx9linJi3pR1IRrReteQpl4lCyB0R2ICGc73+xdSxuqZhuqds
         UVZrlZcE3LuLpXe+UbdvmA3wui2cBr1aqOTvYbsLR1JViWtJUo/91UEfV3q8evXgwW+E
         pIU9+uSDxA2ooUTTEEe/fqisrlsQe7i6HtA/dO9KMeizGG7XlKn3VjDaK9BH1jIqlXAh
         fEhw==
X-Gm-Message-State: AOJu0YwmofAUSzzhl+bdbGUp6yX9sEi2nh/1wRAVoKCxBEl4AwdH+aOK
	WWi4V/wowbp40v7ONXsRSq7XGC7KeXGFrtIjM+iLsGcpa0Hkat1xWDHjpmuvjRaqgVO6OeXifRM
	6r8Vx49KFBrNX967opiEob1Mvo4jKZzMOhxPasFxZ6nV+s1QNYoxwJVjXMItFdypNqK9bhgZwlJ
	xU0LWQ+a+bewDR77lZ2NicuSV6QpzgS6jIKExGYeBxwB+v2iwh7rw=
X-Received: from pfn17.prod.google.com ([2002:a05:6a00:a211:b0:848:7bbd:284b])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:ab88:b0:848:2f84:f429 with SMTP id d2e1a72fcca58-8488976cfd4mr571193b3a.66.1783718788869;
 Fri, 10 Jul 2026 14:26:28 -0700 (PDT)
Date: Fri, 10 Jul 2026 21:26:10 +0000
In-Reply-To: <20260710212616.1351130-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710212616.1351130-8-dmatlack@google.com>
Subject: [PATCH v7 07/12] PCI: Refactor matching logic for pci_dev_acs_ops
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
X-CRM114-CacheID: sfid-20260710_142629_776951_6B3A2C25 
X-CRM114-Status: GOOD (  14.94  )
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

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/quirks.c | 51 ++++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f7846f..7ac39ec2843e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5374,9 +5374,6 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
  */
 static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
 {
-	if (!pci_quirk_intel_pch_acs_match(dev))
-		return -ENOTTY;
-
 	if (pci_quirk_enable_intel_lpc_acs(dev)) {
 		pci_warn(dev, "Failed to enable Intel PCH ACS quirk\n");
 		return 0;
@@ -5396,9 +5393,6 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	int pos;
 	u32 cap, ctrl;
 
-	if (!pci_quirk_intel_spt_pch_acs_match(dev))
-		return -ENOTTY;
-
 	pos = dev->acs_cap;
 	if (!pos)
 		return -ENOTTY;
@@ -5426,9 +5420,6 @@ static int pci_quirk_disable_intel_spt_pch_acs_redir(struct pci_dev *dev)
 	int pos;
 	u32 cap, ctrl;
 
-	if (!pci_quirk_intel_spt_pch_acs_match(dev))
-		return -ENOTTY;
-
 	pos = dev->acs_cap;
 	if (!pos)
 		return -ENOTTY;
@@ -5448,56 +5439,56 @@ static int pci_quirk_disable_intel_spt_pch_acs_redir(struct pci_dev *dev)
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
2.55.0.795.g602f6c329a-goog


