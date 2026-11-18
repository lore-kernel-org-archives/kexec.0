Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B036606A997
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 22:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bh20tY+M;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YTyjsUSj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xKsd+4T8Z5gmC4mac6DyE/MToWM5vKEbChkw2+nF2a0=; b=bh20tY+MuGd6YLvX8LPjjbg5rH
	fGeaChdA+LZVPTNwQs+9FJmsbd7dfjIM5LoidNaf4Mq6Abjq/IXYcF5ChrCSk/ZIvBIsglMTUlmj9
	p+HFzG+pZLuYd+xsz6/2bWsZnoCS3X8KM3g8nRe+AkCra/7gIemEaxsEkdFAvJZtAbOYmIbzpGCrF
	O1P68Akl34hXAUIVXGUUEbfsmQ8gdj2Fje8N3aF4mMtGIi6F6zq/3XehbXnkuNnaLt+JcqZGnCLmc
	vIzskQfRnwYp81L+Q2dEDexAVRWYZrPMTGff5YYNH/Axi3+jP/WQu/XQGV0ex+isU9Tdh3dOvUYm8
	M9wiejcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xToHP-0000000AQDM-3qur;
	Wed, 18 Nov 2026 22:37:27 +0000
Received: from mail-oi1-x248.google.com ([2607:f8b0:4864:20::248])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xToHJ-0000000AQ1h-21Hr
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 22:37:23 +0000
Received: by mail-oi1-x248.google.com with SMTP id 5614622812f47-4b37620eb73so2010402b6e.1
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 14:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795041440; x=1795646240; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xKsd+4T8Z5gmC4mac6DyE/MToWM5vKEbChkw2+nF2a0=;
        b=YTyjsUSjmTWEcQyFXOm+55foR3Kygh0pSd00Wl3bbe+4OxKtD0uYBaVfhc7kcNoWC6
         /cyBgp/uMgtDk3zxn1kgvDT4BthvRqasbCzPWnhMAl4xI6A7O/rio3rjcnMofJCALshp
         T2z8SUzlsY0bQ2JezuMxk3oXDrBaTz9xNc/A8d5YN/o7wDnZZMfHgS8ADX7Bkv/qbgxx
         5JcRPc6+TuS+flHhlnG3jYxPeCu+v0DIYm4Frq20MQEgqhPQ/m/dqTqgg4LFoIRqGSyQ
         JvqdtM8hUwBQRe7Dh3WMZ+22RwigXmm9VeWhv5qXDBuuAkIw32PFFCenzlZsvr/1/zsK
         sUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795041440; x=1795646240;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xKsd+4T8Z5gmC4mac6DyE/MToWM5vKEbChkw2+nF2a0=;
        b=fgLt53r+3AVoZTX3zWwGS6bOKHZOam3TD9RMa+lH0yF+aIWYGEl6vnGVpUmbxT7Rts
         lOoeJecRYjv+6JRFRrbK3elfkvu27ecQ7uQizwVKgtx8wm+1yjqDTGPLFf/DldDWDC5a
         a4WvO+WlSPZPIKM5/Z9DUDjLpQcTk4qX8lcNAhUYIDhm8wQdwm0Rc2BP1FI2XE9k1TAe
         wtRRrSitj8u1+DQtda1VUjS7nVN+KaP7vQcpJaSEE+e/YxCP+xJDtY23TeFEHNzpuUg2
         KdBKLEzyh82a2bIdhJScrosetdFe/jtE8b+xL0Za6gCDVJqB/8fnhyZn2EczvJjDTLbH
         ECqA==
X-Gm-Message-State: APuU4Z9b5F+QPlGaQPKBzxwpfLNEFLx1eqVvtdiz00F8azPgDvAqJ53l
	4riNkhPRYNR7mHOrNlKJ03dpRfeQG/wC2kodoP5vfgLAOxJvi3bm3puIKijQWqkBeVeD8+BQJ9C
	21JKGvgG1+RtynCD8nVEUPqIX5vMvIl3k4GMmgzhET9re/SVBpE1ODgJf1/5mbbuDS6u9g/2V8y
	THFRMdXfDMzTNNGUg6KmaMnTmzXsJaUCzk9aPtTDPf3PAu8E7gGco=
X-Received: from jaac16-n1.prod.google.com ([2002:a05:6638:c750:10b0:61b:3a7f:4e5e])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:6f81:b0:577:2888:47b3 with SMTP id 5614622812f47-57742e34681mr4186856b6e.44.1795041439732;
 Wed, 18 Nov 2026 14:37:19 -0800 (PST)
Date: Wed, 18 Nov 2026 22:37:01 +0000
In-Reply-To: <20261118223704.3286085-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261118223704.3286085-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118223704.3286085-11-dmatlack@google.com>
Subject: [PATCH v11 10/13] PCI: liveupdate: Adopt ARI Forwarding Enable on
 preserved bridges
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Alex Williamson <alex.williamson@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Down <chris@chrisdown.name>, Chris Li <chrisl@kernel.org>, 
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
X-CRM114-CacheID: sfid-20261118_143721_575870_BCA550DB 
X-CRM114-Status: GOOD (  19.72  )
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adopt the ARI Forwarding Enable bit on preserved bridges and update
pci_dev->ari_enabled accordingly during a Live Update. This ensures that
the preserved devices on the bridge's secondary bus can be identified
with the same expanded 8-bit function number after a Live Update.

Adopt the bit even if pci=noari is passed, and document this in
kernel-parameters.txt. The previous kernel may have enabled ARI
Forwarding, and the preserved devices below the bridge rely on it.

pci_liveupdate_adopt_ari() updates the bridge's ari_enabled the same way,
and from the same context, as pci_configure_ari() already does when it
enables or disables ARI Forwarding on the bridge.

Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 ++-
 drivers/pci/liveupdate.c                      | 36 +++++++++++++++++++
 drivers/pci/liveupdate.h                      |  6 ++++
 drivers/pci/pci.c                             |  8 ++++-
 4 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d1ef1c93ec96..cfa5f18a6fb5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5239,7 +5239,10 @@ Kernel parameters
 				off: Turn realloc off
 				on: Turn realloc on
 		realloc		same as realloc=on
-		noari		do not use PCIe ARI.
+		noari		do not use PCIe ARI. Bridges above devices
+				preserved across a Live Update keep the ARI
+				Forwarding Enable setting from the previous
+				kernel.
 		noats		[PCIE, Intel-IOMMU, AMD-IOMMU]
 				do not use PCIe ATS (and IOMMU device IOTLB).
 		pcie_scan_all	Scan all possible PCIe devices.  Otherwise we
diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index b99a88c2c199..a45ad86370d5 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -188,6 +188,11 @@
  *    same after Live Update. Note that a device will use its adopted ACS
  *    controls for the lifetime of its struct pci_dev (i.e. even after
  *    pci_liveupdate_finish()).
+ *
+ *  * The PCI core adopts ARI Forwarding Enable on bridges above incoming
+ *    preserved devices, even with pci=noari, until all preserved devices below
+ *    the bridge have finished. This keeps the preserved devices on the bridge's
+ *    secondary bus addressable with the same function numbers.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -891,6 +896,37 @@ int pci_liveupdate_adopt_acs(struct pci_dev *dev)
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
index c643f2664296..e1c1d2fa00e4 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -16,6 +16,7 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev);
 bool pci_liveupdate_preserve_bus_numbers(void);
 bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus, struct pci_dev *dev);
 int pci_liveupdate_adopt_acs(struct pci_dev *dev);
+int pci_liveupdate_adopt_ari(struct pci_dev *dev);
 
 static inline bool pci_liveupdate_was_incoming(struct pci_dev *dev)
 {
@@ -46,6 +47,11 @@ static inline int pci_liveupdate_adopt_acs(struct pci_dev *dev)
 	return -EINVAL;
 }
 
+static inline int pci_liveupdate_adopt_ari(struct pci_dev *dev)
+{
+	return -EINVAL;
+}
+
 static inline bool pci_liveupdate_was_incoming(struct pci_dev *dev)
 {
 	return false;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ebc565b4780a..b5b578355a1b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3748,7 +3748,7 @@ void pci_configure_ari(struct pci_dev *dev)
 	u32 cap;
 	struct pci_dev *bridge;
 
-	if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
+	if (!pci_is_pcie(dev) || dev->devfn)
 		return;
 
 	bridge = dev->bus->self;
@@ -3759,6 +3759,12 @@ void pci_configure_ari(struct pci_dev *dev)
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
2.56.1.703.gf848ed807c-goog


