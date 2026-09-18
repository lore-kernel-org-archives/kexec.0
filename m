Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FA8C982E9
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 20:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9BR71s6OXVqtI8pG8LyTaxh9Qe5FvWSAHHddp0nR9J8=; b=rTwJJOacyDmOLDS0Oiy3tvquwK
	8KDRpF9mSGtzCndE9B54tIlmM9km1n33jtCJUykipyIJ2y7m0KoxpQz3DbRM0duAbLdhEbbmGBQSP
	ejs1dirpAIqY1YC2WrK72NcuJhelWBaScT3wWfOq3vaS5gUHUMxK+1dC/qjQBwPRg8xqYCwsnCvxR
	BCohyD2t976nOOaTIRslsONTSZGEvCBn+Z9zSpfrMU2HMpILMnJ/eRSh8zpHZivHFklbC/ZP5zWpP
	GTY1sfGrVBKsvOJrkUfSocPuAdeDzrJHzGx4EX3qese5yjOEbIRAMEVkLNrFfIzEz/j8aoTp2OTwZ
	33WgExUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7erW-0000000FTUb-1tAo;
	Fri, 18 Sep 2026 20:07:10 +0000
Received: from mail-pl1-x646.google.com ([2607:f8b0:4864:20::646])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7erP-0000000FTN5-2YCp
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 20:07:07 +0000
Received: by mail-pl1-x646.google.com with SMTP id d9443c01a7336-2db3d832827so14516355ad.2
        for <kexec@lists.infradead.org>; Fri, 18 Sep 2026 13:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789762022; x=1790366822; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9BR71s6OXVqtI8pG8LyTaxh9Qe5FvWSAHHddp0nR9J8=;
        b=oIqXoWgHhttke7fgE9NTlR9a4np+XbqUl7thzG651ejrkYrTtpXLbqKIgGhjcqHF0J
         EoKt4xkRtKwvq4evoYEiM5P8ZNTNF5ODvKpLyoFp1mEk5m3mx1HL/jZZU4E9LEfXTUQP
         vgzWr2DD5RbiFAB+uErq0ZNZyhWhk2seyRRPtBIphaMjrl8NRV4YPcwXQvhIFXf6VnSd
         U1AEI9EyR6q9jvrACHPWxHVLA+gdybgm9PlGF7NqZIo0s+QHTTU+I68fWRJV7fpbHQV2
         mJ5ZSl50RqQU7TABkH5o69A4a+sTIRz+Jielkzrj7uPakf8UP4tM0SvjrhrBaGkv9Hbj
         GsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789762022; x=1790366822;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9BR71s6OXVqtI8pG8LyTaxh9Qe5FvWSAHHddp0nR9J8=;
        b=xIzGAiBLl8/nQ6Y9g80yOILpn3WUECeE7Sm0IrLl6WsHxlCBoSN7yGxFkdpxvLQgyV
         vNKc79ma0+Rd5dBxDncgBwWcrwJr88CmSEvRvNSgLzCMTPYiZQXBP4cYeBpuJrJUf0GY
         BWlNvT69ANZ/LB9AJfAA6HkMotl6OX1PuRYwGvyA5fc5rSM+WCZQxksWMJhKS8ozA0J4
         RfTLPLDVNLk+MOHSjDhYGgL1aggq66Lkx6NFIsPeiax289CXwgROkP6Sr32yBbb1gTLO
         mtoNdXpPhL4VtqZlE12DeYtWJb69EelYl7V0vRrEWUSRIjXf7x8XAYiDV2Brg8/9kZp7
         lqhQ==
X-Gm-Message-State: AFuF++lJkFRS8ZGJiruVmhx29RuHTElIvD1iPpyagMNUmPVljOl7F+on
	/plj4lsMK93odOi4C99ivZe3t5Ou4UKV7my32wsWIXKAuBKzmaI9GLFvVYTIuUdtkKi0uSQ+YA5
	e5SJOGiR7+Qjsnzkpi6eYinxdlkR2ge9yeNrAcVr6yOOcuzPRMPR9hMVl4naObryi7xnpD2hDBq
	qiFHJZ2Tfpzzw7lIeakYhPj1TYr23p2hvLI4fPESJrEKcncFD8xac=
X-Received: from pldv5.prod.google.com ([2002:a17:902:ca85:b0:2d9:e5f:1d26])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ab8f:b0:2dd:c100:a5ea with SMTP id d9443c01a7336-2ddc100a6aemr7241285ad.62.1789762021877;
 Fri, 18 Sep 2026 13:07:01 -0700 (PDT)
Date: Fri, 18 Sep 2026 20:06:36 +0000
In-Reply-To: <20260918200640.887030-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260918200640.887030-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918200640.887030-11-dmatlack@google.com>
Subject: [PATCH v9 10/13] PCI: liveupdate: Adopt ARI Forwarding Enable on
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
X-CRM114-CacheID: sfid-20260918_130703_707482_5433B352 
X-CRM114-Status: GOOD (  17.04  )
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

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 30 ++++++++++++++++++++++++++++++
 drivers/pci/liveupdate.h |  6 ++++++
 drivers/pci/pci.c        |  8 +++++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 0145399b3834..3c9a10a892fc 100644
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
@@ -904,6 +908,32 @@ int pci_liveupdate_adopt_acs(struct pci_dev *dev)
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
+	if (!dev->liveupdate.incoming)
+		return -EINVAL;
+
+	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &val);
+
+	/* Safe to modify dev->ari_enabled bitfield during enumeration. */
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
index 47d8229115b8..0ae405b86b2f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3625,7 +3625,7 @@ void pci_configure_ari(struct pci_dev *dev)
 	u32 cap;
 	struct pci_dev *bridge;
 
-	if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
+	if (!pci_is_pcie(dev) || dev->devfn)
 		return;
 
 	bridge = dev->bus->self;
@@ -3636,6 +3636,12 @@ void pci_configure_ari(struct pci_dev *dev)
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
2.55.0.1082.g2b9226bbc0-goog


