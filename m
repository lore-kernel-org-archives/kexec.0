Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC23D73E91
	for <kexec@archiver.kernel.org>; Thu, 29 Jan 2026 21:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u1Z3QHTjPxpYvShlt2cO6c78554A0ZIR6ozbVe3TjI8=; b=TOBAFBMqGnLefzGYIa8C8nSK0f
	VWmA/4wC3YfLJL01Q2+d++nzX4nj0zuk/vGoAHdNimR32txdk0TVn3i0WW4TStwUttVjGZxLaaMpd
	AgLnBsD5kSKhki6EhRprIlSCTtu98OD36TvYng0W3dOtA1daBaG0dKQbfa7S3nMKjhvT3Sbb9GRt8
	BKaVBXqsdn2TUMao9eGRum6CYylppJuo3sLjpQHCKNTUR0ViRq1eg+ZeZbZbT/mPRM1k6BLG+4biw
	iObuh5axRPkAlZPhxRKx2VJ8GQHQBvmIS7iNitVKtT2sDpCI9O0cm2R8d+0tzJmixvBQ2KDNf5E64
	cFSXGu/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWO-00000000fDx-0bKw;
	Thu, 29 Jan 2026 21:25:48 +0000
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWJ-00000000fBa-3mDM
	for kexec@lists.infradead.org;
	Thu, 29 Jan 2026 21:25:44 +0000
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-34c7d0c5ed2so1215332a91.0
        for <kexec@lists.infradead.org>; Thu, 29 Jan 2026 13:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769721943; x=1770326743; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u1Z3QHTjPxpYvShlt2cO6c78554A0ZIR6ozbVe3TjI8=;
        b=ziAGKvQ+Rqb2RtuCSttKdbakHUeIFY/jus7dx5idl9R2Mr9Doknd9QurkzzN1X2DLg
         kfD7llnOjYte4cC1DdR4cLIJUNMDHZdArslf+MQzQqSPE/HO7YOlgyTS/iZ/6MttdNy2
         rxtGSvh7i1ZhKPDZ+B/ruEXS9PF0tIkmWHGOQv7BqTmt+2/sYeH/cHXSmybrq3RX9nZD
         83vvznQycJRPZpT2B17RMgYvjm3Jhdul3nWQbYr9SJcKvY3FCLADULpFGKTrIHg3Yv0P
         B/DiTma6DNVQbed+cn8auSNeEGMugrxOeujAC09GmaQYiQxFrip5M8zDcMGgz2ruPOFi
         n4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769721943; x=1770326743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1Z3QHTjPxpYvShlt2cO6c78554A0ZIR6ozbVe3TjI8=;
        b=Tx0KZKpkmlExVgM/XY6gDKFCEPsqTgi/lBcQCtQZ2ZeAcheCsL8ApR7ZmMe5XppheD
         fUnnCHz7kLaH4VJANl2ueSq5MlGQKOuHAXOEwKRSw/ATKwhLl7OXdNEQjzJx2++KvGCk
         xMunGqGB5Kq4elw0wcyaaXtFfI1itnwF/czSomOLkH9fYdNOeTGPcn+6vz8QPw45qOA4
         anqcEFPpqB+WoXnI3ukLU0DAwOrgJfc6JMuVZlfzxGjCsUwI6a3QWsuiMz0/L7OUAIRS
         Irp4Y+rtADoomABqoEAl29SxLg4615klnvPUuwUbcY7rQ94LOgT21xa1sENdNME+oD6S
         CBqg==
X-Forwarded-Encrypted: i=1; AJvYcCXzYwQ/Op/Ot53I1aqhxnoLwXr50N7EByyr+FvDXhQWgZc0NcLJpT726/EUMGZM/uaMuvpUpA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyFIBMLKBsrl6N6JxKQnZUrzyHoar5KbRq0OeNzK8IaJAnmn+Qo
	fxvyoTIBfGDvHEGVV8WmPzKPst9kMSN5VMgZr7l5oQhMT9Ms8Z7Fqh3dtemo8JEcpMwoP9d8nCV
	p1V9QGLobnC5kPA==
X-Received: from pjblb16.prod.google.com ([2002:a17:90b:4a50:b0:352:b92b:ef8])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:28c5:b0:343:684c:f8a0 with SMTP id 98e67ed59e1d1-3543b3ae12dmr762757a91.23.1769721942669;
 Thu, 29 Jan 2026 13:25:42 -0800 (PST)
Date: Thu, 29 Jan 2026 21:24:50 +0000
In-Reply-To: <20260129212510.967611-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129212510.967611-4-dmatlack@google.com>
Subject: [PATCH v2 03/22] PCI: Inherit bus numbers from previous kernel during
 Live Update
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	"=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vipin Sharma <vipinsh@google.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260129_132543_937877_95EE9942 
X-CRM114-Status: GOOD (  15.39  )
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

Inherit bus numbers from the previous kernel during a Live Update when
one or more PCI devices are being preserved. This is necessary so that
preserved devices can DMA through the IOMMU during a Live Update
(changing bus numbers would break IOMMU translation).

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/probe.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index af6356c5a156..ca6e5f79debb 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1351,6 +1351,20 @@ static bool pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub)
 	return true;
 }
 
+static bool pci_assign_all_busses(void)
+{
+	/*
+	 * During a Live Update where devices are preserved by the previous
+	 * kernel, inherit all bus numbers assigned by the previous kernel. Bus
+	 * numbers must remain stable for preserved devices so that they can
+	 * perform DMA during the Live Update uninterrupted.
+	 */
+	if (pci_liveupdate_incoming_nr_devices())
+		return false;
+
+	return pcibios_assign_all_busses();
+}
+
 /*
  * pci_scan_bridge_extend() - Scan buses behind a bridge
  * @bus: Parent bus the bridge is on
@@ -1378,6 +1392,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 				  int max, unsigned int available_buses,
 				  int pass)
 {
+	bool assign_all_busses = pci_assign_all_busses();
 	struct pci_bus *child;
 	int is_cardbus = (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS);
 	u32 buses, i, j = 0;
@@ -1424,7 +1439,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
 			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
 
-	if ((secondary || subordinate) && !pcibios_assign_all_busses() &&
+	if ((secondary || subordinate) && !assign_all_busses &&
 	    !is_cardbus && !broken) {
 		unsigned int cmax, buses;
 
@@ -1467,7 +1482,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		 * do in the second pass.
 		 */
 		if (!pass) {
-			if (pcibios_assign_all_busses() || broken || is_cardbus)
+			if (assign_all_busses || broken || is_cardbus)
 
 				/*
 				 * Temporarily disable forwarding of the
@@ -1542,7 +1557,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 							max+i+1))
 					break;
 				while (parent->parent) {
-					if ((!pcibios_assign_all_busses()) &&
+					if (!assign_all_busses &&
 					    (parent->busn_res.end > max) &&
 					    (parent->busn_res.end <= max+i)) {
 						j = 1;
-- 
2.53.0.rc1.225.gd81095ad13-goog


