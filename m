Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757C0CD5BAC
	for <kexec@archiver.kernel.org>; Fri, 22 May 2026 20:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=07zUHNcjisF6FOuU9N0CtQnOBIzxNou2anoHgJH+mP8=; b=u/MxEGqu5TSqlZxWgUF4gy4g3k
	Dfzf4rUREcaEZXdszVSRNHWX7AYphP8DsuzGl3+JT+lIxmaO7QQwVhr21Eu1q1y3pzKG752Vt5cFm
	JlcYftaSqsd+mG3aUVdK5CpU4mX4BpyFKpq4/li++ayb0qz2hBc4UXy1Dlti/m13oz8WrZBWvfp6w
	qWaNOs3oIBD6gRlkPMvaK5+wGmXgzQhBRBRnle7BTxTBfqQ5dedBP60YNUEkjV6/SgF2yDmLcwT5C
	U5ekBtJb6UC3DUezZKdb3mXTsG8ghuUd+1J/SDRXXn043InevSA4tyvfweF2yPVhTEBFqN94efVms
	H7ArDRPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQWPy-0000000Bs0d-2QPk;
	Fri, 22 May 2026 20:24:26 +0000
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQWPt-0000000Brsq-194d
	for kexec@lists.infradead.org;
	Fri, 22 May 2026 20:24:22 +0000
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-c8525f0807aso719083a12.3
        for <kexec@lists.infradead.org>; Fri, 22 May 2026 13:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779481460; x=1780086260; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=07zUHNcjisF6FOuU9N0CtQnOBIzxNou2anoHgJH+mP8=;
        b=vZvDonz/UuUVk+90mUyQoVnmL2bjzYc3VM3ntLDvhVncvGHIuH22tb/4TbtAk9utua
         4roP3uMp+6ZkOmp5Oq5xzKSE4VyF13hw6c0uUZP5z3ddz+7Nm9w6z5zTjH5c3Lnet6qn
         sLsnutHQUxV7OzA43Hx0R3PJPgY3bGeoD1KDPI6zmhrzTKoikSJhmFcquWM6Ek0wwFSz
         27ddVIIbSlB1otD2WIVamo9J/ceVG2RKKoiRFcUzCQ+q7OINiELmSOl43cWgdq0VtuAn
         ZVpMUSI7sgVLQEbDYmeLn2Ti8au5ZCyD37Rs+t7mKiRTNbUZg1IBNKLBs0c62ZFRbffb
         g78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779481460; x=1780086260;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=07zUHNcjisF6FOuU9N0CtQnOBIzxNou2anoHgJH+mP8=;
        b=J+3ztn0mDa8QpfC+ngSU/3NvSZMEIl4LgasUVnYApdP4xSNVHW0KYRiN3SKs59W20f
         36PK/8UrF/bzlpkQrWuEVCJ3StcCTCwfOa5u1Jsu9P2ms+MC/Xn+6pQQw5p4TL2hJ7HE
         EZYV/OkTXUO4Db9zZCdAofbzPHozwIvUkJXxEhyBSrux0b1+llA4Q9XNenMdQtlFHp61
         Tvrbh7/p8/UsryoGpG0nfEnOp8NWggX6QgpTg18vbJf0XatWJS6St4kxdVKbPkP2CSZG
         o7N5GqfeOxjNjK2m5TUecZ0MaJ15jzx6IM0WsscN7m6otgphSttlaRK6IZZH6VcCTcO1
         Nu0g==
X-Gm-Message-State: AOJu0Yyp1lqc7G+LMVxsC21wiC3H79kF4hqiL1HfxowlVqEQvHy7jTNn
	utAY+V/KnYksgi3oovgETL9c2YP+uKMBngwVtNTay0B2X2pqvwUZiRW6jf0d8aUy4Bhcl67Uc9K
	G5QLW/SkYZparbOWoWLUJmS6sacoX1tLbhuK1NklecrUqmPFaQC/MKmw5bgorjWTRFfbfe3k43B
	cFNRW08DwfD0RvG3OQReSJxiiKnpKKxqV41+Lk262e41SJtJvPlXQ=
X-Received: from pgt6.prod.google.com ([2002:a63:1346:0:b0:c82:7a06:d5f5])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:d709:b0:3b3:c28:45b3 with SMTP id adf61e73a8af0-3b328e4f8d7mr5132386637.26.1779481459861;
 Fri, 22 May 2026 13:24:19 -0700 (PDT)
Date: Fri, 22 May 2026 20:24:07 +0000
In-Reply-To: <20260522202410.3104264-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260522202410.3104264-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522202410.3104264-10-dmatlack@google.com>
Subject: [PATCH v6 09/12] PCI: liveupdate: Inherit ARI Forwarding Enable on
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
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_132421_320160_B39B33F3 
X-CRM114-Status: GOOD (  14.59  )
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
 drivers/pci/liveupdate.c | 18 ++++++++++++++++++
 drivers/pci/liveupdate.h |  6 ++++++
 drivers/pci/pci.c        |  8 +++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index a93b7ef065f2..701276ef6cfb 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -128,6 +128,10 @@
  *    way after Live Update and ensures that IOMMU groups do not change. Note
  *    that a device will use its inherited ACS flags for the lifetime of its
  *    struct pci_dev (i.e. even after pci_liveupdate_finish()).
+ *
+ *  * The PCI core inherits ARI Forwarding Enable on all bridges with downstream
+ *    preserved devices to ensure that all preserved devices on the bridge's
+ *    secondary bus are addressable after the Live Update.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -756,6 +760,20 @@ int pci_liveupdate_enable_acs(struct pci_dev *dev)
 	return 0;
 }
 
+int pci_liveupdate_configure_ari(struct pci_dev *dev)
+{
+	u16 val;
+
+	guard(rwsem_read)(&pci_liveupdate.rwsem);
+
+	if (!dev->liveupdate.incoming)
+		return -EINVAL;
+
+	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &val);
+	dev->ari_enabled = !!(val & PCI_EXP_DEVCTL2_ARI);
+	return 0;
+}
+
 /**
  * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
  * @dev: The PCI device to check
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index 4e8a01bcb4bb..6f21ec50927b 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -18,6 +18,7 @@ bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus, struct pci_dev *dev,
 void pci_liveupdate_scan_bridge_end(struct pci_dev *dev, int pass);
 void pci_liveupdate_init_acs(struct pci_dev *dev);
 int pci_liveupdate_enable_acs(struct pci_dev *dev);
+int pci_liveupdate_configure_ari(struct pci_dev *dev);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -46,6 +47,11 @@ static inline int pci_liveupdate_enable_acs(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
+
+static inline int pci_liveupdate_configure_ari(struct pci_dev *dev)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 211df4618164..271da55af270 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3495,7 +3495,7 @@ void pci_configure_ari(struct pci_dev *dev)
 	u32 cap;
 	struct pci_dev *bridge;
 
-	if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
+	if (!pci_is_pcie(dev) || dev->devfn)
 		return;
 
 	bridge = dev->bus->self;
@@ -3506,6 +3506,12 @@ void pci_configure_ari(struct pci_dev *dev)
 	if (!(cap & PCI_EXP_DEVCAP2_ARI))
 		return;
 
+	if (!pci_liveupdate_configure_ari(bridge))
+		return;
+
+	if (pcie_ari_disabled)
+		return;
+
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
 		pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
 					 PCI_EXP_DEVCTL2_ARI);
-- 
2.54.0.746.g67dd491aae-goog


