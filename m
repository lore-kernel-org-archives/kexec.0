Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F31CC6B12
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 16:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rbdiAFt+Oje3uTZOnPEvaOqLxPnobGariVTCdptn2ik=; b=pr4x+XnABxEquv7JXJ93c5BBWC
	19N1j+ju+NAdwhKUQMsFZvkvJVB1ksOsp0uXcyO8xp4QDU6PdYNKn876o84BGkHCUARlSadNBOcFk
	q9wyLs76pZZxkLvsPTQr3O1SeBZDwfMper4bsoFnnVaWEvHqbcX27m7R0hlEj3LWCpPrF/uVrU6Jv
	LOjT/Uaw0r8K9gQpyCPbO2kDpp79s0VqCbTmDeZuABghhIS0jYT5mxj4UhkS+J2gZ1NQkSb1iBTcD
	lVEgP1m75jJnYohjVFcjPNC1ZShXeScaRqjb2eKf/I+dZzUncJwHPQtQvra9Qq9d8WHohwQ6oRj52
	Ii9pZQCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfKF-0000000DUtf-030X;
	Tue, 13 Oct 2026 16:26:03 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfK5-0000000DUo4-19uI
	for kexec@bombadil.infradead.org;
	Tue, 13 Oct 2026 16:26:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rbdiAFt+Oje3uTZOnPEvaOqLxPnobGariVTCdptn2ik=; b=lkD1Y850/D6q/ICls7ig+1/r4+
	4HaSbz0pyr1xiax34IkcQMg2E27qqo47PdEHmcfClisjfXbpQ3IfH+oRUTR9eZzk+7mu9Rh+53QTh
	b8jwxwBZshNvzG+t3d40CfoSPzrzV/DKLKlM5iyOyuhEkGeKrw5FtysR/J1b/tDCeCsC/1Ort0DEU
	n5SiCo9BMyWZn0z1tf+K5nlIFZXmvQeX2RJ23fYBEbebS1x/MeJrD3Sll9hLmfK3L2cyuAYql7gxg
	gbjRMgFqsqSexAgfUnEbRZDUA1YO9bsEO2GQggAii1tsGRN5PRQcAzy58zjh5l14jb5CYDhVqtaEw
	lWvtuMRw==;
Received: from mail-pj1-x1045.google.com ([2607:f8b0:4864:20::1045])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGfK2-0000000FmLy-1oFK
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 16:25:52 +0000
Received: by mail-pj1-x1045.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d5dbso3911252a91.1
        for <kexec@lists.infradead.org>; Tue, 13 Oct 2026 09:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791908748; x=1792513548; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rbdiAFt+Oje3uTZOnPEvaOqLxPnobGariVTCdptn2ik=;
        b=IEtigghcjf52cUgt7CFKBiP+qKlc/BVVNZ2FmTZOfwDzhUYnuvpXqt1VmFn1HnsozC
         ix615MgPzcaaFmVVMAKkTN2uy/Fx+Pp3prEI8h5FMSiqYxl9bLxyUcInmXssX9ifEYnc
         BXyI102R0SMm1ruV+fqgYFF/5HEuV9rJYogfcVOzlAkGGOZ9ZMQUGohxRPi9ojZ320+s
         OuLmX/wGoU7OdPqX2UwTEW3h6FXOBHkf3Qk0wt+46ARQ1ytzgK3ik73d3lEprafJU8d+
         yN7yLzr60ub1DKxHJBFbdnEAA4laEAvXtYQQniajX+1S4y+f4+iRK/bTbEBkju96Rtl2
         HZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791908748; x=1792513548;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rbdiAFt+Oje3uTZOnPEvaOqLxPnobGariVTCdptn2ik=;
        b=sZYBSb0S3qMQuEHmuuMsWY0JFuK0HJF/pqGD1nFBrdotEFPcXgYiDL5ofyeDL1O4N0
         VTpCMeNqptEwMMDJRSw3CWqj70nWlzlRXTxRWlYl90wr7UNLciLMZFHnWn6aB9OBii/V
         TBTwYz+fYLYPkDdlvLhOuBoFIXXIoEu5Xy7jZ7ffQrGqZIT0IsYGx+AmSxrgLZvR1OnI
         XbqMZ1cfeH54ny0mrlRNM5fcmU9yboBeLCLCMI7L5rpTy+5oL3EBpizRtI1xd0XA0omf
         Eh2uP3xr10q8clZG3W/AWJvtSJM1fQiHM7HHndFXwiKPxPDH/I0fhzY5hFaYcbveKxXl
         eW2A==
X-Gm-Message-State: AFq9FYKzNBUiLXLr6PY2FdczyL+5v6KRhdbKaJ7CsaYH9q2lgO82qwHg
	d7GJV1ljzumgcrBZA8cI/b0vzv5k6iAPBHvq4/IOaoVem/omnPlmrZbzQ/zzc5nrb+viZYcFTHF
	CDdc4YJyqocHiYaxP2HwviRqSYVY4aFSS3596YiRa5lrzI42wnrK5I/u0Rv9/6GUr7D+6PaJ8FJ
	Us5xQBc7ZAxdAvDEdsd1dImWFdqVZCSob44rYC84bwxJPpA9DOLcw=
X-Received: from plbl17.prod.google.com ([2002:a17:902:eb11:b0:2e3:1b6e:33bb])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1d4f:b0:3a4:a592:4cfa with SMTP id 98e67ed59e1d1-3ab3a79d9f8mr10690339a91.45.1791908745986;
 Tue, 13 Oct 2026 09:25:45 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:25:26 +0000
In-Reply-To: <20261013162529.1928093-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20261013162529.1928093-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013162529.1928093-11-dmatlack@google.com>
Subject: [PATCH v10 10/13] PCI: liveupdate: Adopt ARI Forwarding Enable on
 preserved bridges
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
X-CRM114-CacheID: sfid-20261013_172550_581897_49EDEE55 
X-CRM114-Status: GOOD (  20.47  )
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

Adopt the ARI Forwarding Enable bit on preserved bridges and update
pci_dev->ari_enabled accordingly during a Live Update. This ensures that
the preserved devices on the bridge's secondary bus can be identified
with the same expanded 8-bit function number after a Live Update.

pci_liveupdate_adopt_ari() updates the bridge's ari_enabled the same way,
and from the same context, as pci_configure_ari() already does when it
enables or disables ARI Forwarding on the bridge.

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 35 +++++++++++++++++++++++++++++++++++
 drivers/pci/liveupdate.h |  6 ++++++
 drivers/pci/pci.c        |  8 +++++++-
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 1d2324d339da..e640794cc8e6 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -189,6 +189,10 @@
  *    way after Live Update and ensures that IOMMU groups do not change. Note
  *    that a device will use its adopted ACS controls for the lifetime of its
  *    struct pci_dev (i.e. even after pci_liveupdate_finish()).
+ *
+ *  * The PCI core adopts ARI Forwarding Enable on all bridges with downstream
+ *    preserved devices to ensure that all preserved devices on the bridge's
+ *    secondary bus are addressable after the Live Update.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -922,6 +926,37 @@ int pci_liveupdate_adopt_acs(struct pci_dev *dev)
 	return 0;
 }
 
+/**
+ * pci_liveupdate_adopt_ari() - Adopt ARI configuration
+ * @dev: The PCI device to adopt ARI configuration for
+ *
+ * For devices preserved across a Live Update, read the ARI state from
+ * hardware and adopt it. This ensures the device continues to use the ARI
+ * configuration established by the previous kernel.
+ *
+ * Return: 0 on success, or -EINVAL if the device was not preserved.
+ */
+int pci_liveupdate_adopt_ari(struct pci_dev *dev)
+{
+	u16 val;
+
+	guard(rwsem_read)(&pci_liveupdate.rwsem);
+
+	/*
+	 * Unlike ACS, only adopt ARI while the bridge is incoming-preserved.
+	 * Once all devices below the bridge have finished, recomputing ARI
+	 * Forwarding Enable yields the same result for the same device, and
+	 * must be allowed to change if a different device is hot-plugged.
+	 */
+	if (!dev->liveupdate.incoming)
+		return -EINVAL;
+
+	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &val);
+
+	dev->ari_enabled = !!(val & PCI_EXP_DEVCTL2_ARI);
+	return 0;
+}
+
 /**
  * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
  * @dev: The PCI device to check
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index d4721ffcecb2..90b2754ecc0c 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -16,6 +16,7 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev);
 bool pci_liveupdate_preserve_bus_numbers(void);
 bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus, struct pci_dev *dev);
 int pci_liveupdate_adopt_acs(struct pci_dev *dev);
+int pci_liveupdate_adopt_ari(struct pci_dev *dev);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -40,6 +41,11 @@ static inline int pci_liveupdate_adopt_acs(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
+
+static inline int pci_liveupdate_adopt_ari(struct pci_dev *dev)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 650d7f92f93a..e5b960ca26e6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3705,7 +3705,7 @@ void pci_configure_ari(struct pci_dev *dev)
 	u32 cap;
 	struct pci_dev *bridge;
 
-	if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
+	if (!pci_is_pcie(dev) || dev->devfn)
 		return;
 
 	bridge = dev->bus->self;
@@ -3716,6 +3716,12 @@ void pci_configure_ari(struct pci_dev *dev)
 	if (!(cap & PCI_EXP_DEVCAP2_ARI))
 		return;
 
+	if (!pci_liveupdate_adopt_ari(bridge))
+		return;
+
+	if (pcie_ari_disabled)
+		return;
+
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
 		pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
 					 PCI_EXP_DEVCTL2_ARI);
-- 
2.56.0.385.gd3acb90ef8-goog


