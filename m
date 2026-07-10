Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CC9C44501
	for <kexec@archiver.kernel.org>; Fri, 10 Jul 2026 21:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kC0I5yGr+D5g0K5ia+KYUwEESYLYNJwODX2HQMDkX0U=; b=dU6tXTUqDqJu4HmdbKIdE6hVhm
	M+F/Mp5cVxOLiYJmMVRjtGu6e5bTKATtmjPIE+iqD0vJ1LCb9Iu9Qy7+4OyiAEpVfnMKXAMxHp76c
	NXSWnvYWirw3r9Lj3MQGft0WgxSJSsT6v8KrvoPMUebA4KRszqNfIiSf/+1cXMdr26O31z59pRpC7
	Hwjxt64z6sZO2wHcN6X1DVo643xc2kRuvZ3huRklIFdpjqQU90LsfJY3CyCT6r1dGfLO2VkLv7nvP
	qJhnBe2PK4bRpOuSsAP97kr7FcYCKxkk3matyJld7x2FNvef18/549Qs9dltwQjSJGBglt3lIKlmS
	0dIDsLPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIk1-00000005pZB-12dY;
	Fri, 10 Jul 2026 21:26:37 +0000
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIjw-00000005pSo-4Ak1
	for kexec@lists.infradead.org;
	Fri, 10 Jul 2026 21:26:34 +0000
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-8487eb67173so1396511b3a.2
        for <kexec@lists.infradead.org>; Fri, 10 Jul 2026 14:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783718792; x=1784323592; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kC0I5yGr+D5g0K5ia+KYUwEESYLYNJwODX2HQMDkX0U=;
        b=KhmxtOdnTWgTgp8qlRF9X1Glpk6aTUz3tIftelrU1qsyD4heMz3siqnSUsP0en4cU8
         2gXRHAOev/yqdgQzReBr1kVsSoVha2lXnnjzxyUn33l0StfAAsuiN6b6jucxbdNg114g
         Q/jNR3+N19WZ0DhTzqFCGoS7gqo+cV7NlYCT7+nKobV7sOSNx8/tRf7O6IVfN/YiCal4
         x4bS38hsKkz48Ce1pKuOFkwXQXh/HkX3tQ/Bdmii2P9Oe/q3vgoEdBkXgsYDlZdZkO0U
         woUW5+q9VnVH8WHOVI5YqI/qPATpa1MbhxxZwsRJgj7vbaNQDfkWvideuWB2o4PjR3Ig
         pCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718792; x=1784323592;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kC0I5yGr+D5g0K5ia+KYUwEESYLYNJwODX2HQMDkX0U=;
        b=CsSx9F9uSwl34G+Hlf+Z3eAOU2sgK+VJY7BBPXwGEwCMr3+OxAdi+QKWO+PBt3ph1j
         M/Zx82iOTssq36nLoDPOLAyztHH5eegoU1yJh7/l2TVQx+fgPBr26FnLagkxVaJmViRn
         T6cW+O5clVFkjlmyeWgRDUEMY44DlaA3GYYv+VyZB2z2IeDkk/xst7d+q/4x2bFVikgc
         +8/GbMsETkfkZCJER97U83tSDHwy4L3X7y2cNtEGB5wPATrNIPJOo0L/I3b0YaAhZfLI
         7e7eAZQGAj9b/yldz/4F6kO3bFkIfVGsdByZXYdzcWwQLiulHRrn2XQqFOZUPeE9f2+k
         fz3A==
X-Gm-Message-State: AOJu0Yxf5Cve7IMvJS/6AV3efP/mJugQVkD40VCqPuGwaeTFqmzkAPiD
	MHBPkg6xD6ddHUozaNVFu7NMi++hCxue8BYpnUkXtU4AvyT8Vs6vZKdf5hLD8zZsGrppn/wjyjK
	zwraVqbq+7+np4rm4rvYpEP3rw87GQrCgmIKHT4GUoWEyGH9/1/1sxHBQIIgVRzIb/IkH/5ytt0
	ip257uj1KCaD/0L+fUrtJ2HifdhrWDwzABR01E5jEJSXjuHNM9Pos=
X-Received: from pfcs28.prod.google.com ([2002:a05:6a00:6fdc:b0:847:8189:3c6c])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:14ce:b0:848:2f73:8ff6 with SMTP id d2e1a72fcca58-84889770231mr613896b3a.63.1783718791956;
 Fri, 10 Jul 2026 14:26:31 -0700 (PDT)
Date: Fri, 10 Jul 2026 21:26:14 +0000
In-Reply-To: <20260710212616.1351130-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710212616.1351130-12-dmatlack@google.com>
Subject: [PATCH v7 11/12] PCI: liveupdate: Do not disable bus mastering on
 preserved devices during kexec
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
X-CRM114-CacheID: sfid-20260710_142633_039341_AE55DCDE 
X-CRM114-Status: GOOD (  16.35  )
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

Do not disable bus mastering on outgoing preserved devices during
pci_device_shutdown() for kexec.

Preserved devices must be allowed to perform memory transactions during
a Live Update to ensure continuous operation.  Clearing the bus
mastering bit would prevent these devices from issuing any memory
requests while the new kernel boots.

Because bridges upstream of preserved endpoint devices are also
automatically preserved, this change also avoids clearing bus mastering
on them. This is critical because clearing bus mastering on an upstream
bridge prevents the bridge from forwarding memory requests upstream (i.e.
it would prevent the endpoint device from accessing system RAM and doing
peer-to-peer transactions with devices not downstream of the bridge).

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 11 +++++++++++
 drivers/pci/liveupdate.h |  6 ++++++
 drivers/pci/pci-driver.c |  7 +++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 64052892ea84..5935e88de073 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -132,6 +132,10 @@
  *  * The PCI core inherits ARI Forwarding Enable on all bridges with downstream
  *    preserved devices to ensure that all preserved devices on the bridge's
  *    secondary bus are addressable after the Live Update.
+ *
+ *  * The PCI core does not disable bus mastering on outgoing preserved devices
+ *    during kexec. This allows preserved devices to issue memory transactions
+ *    throughout the Live Update.
  */
 
 #define pr_fmt(fmt) "PCI: " KBUILD_BASENAME ": " fmt
@@ -850,6 +854,13 @@ int pci_liveupdate_configure_ari(struct pci_dev *dev)
 	return 0;
 }
 
+bool pci_liveupdate_is_outgoing(struct pci_dev *dev)
+{
+	guard(rwsem_read)(&pci_liveupdate.rwsem);
+	pci_WARN_ONCE(dev, !dev->liveupdate.frozen, "Preservation status is unstable!\n");
+	return dev->liveupdate.outgoing;
+}
+
 /**
  * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
  * @dev: The PCI device to check
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index bcb0bc73d684..b266406aaac8 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -20,6 +20,7 @@ void pci_liveupdate_scan_bridge_end(struct pci_dev *dev, int pass);
 void pci_liveupdate_init_acs(struct pci_dev *dev);
 int pci_liveupdate_enable_acs(struct pci_dev *dev);
 int pci_liveupdate_configure_ari(struct pci_dev *dev);
+bool pci_liveupdate_is_outgoing(struct pci_dev *dev);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -57,6 +58,11 @@ static inline int pci_liveupdate_configure_ari(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
+
+static inline bool pci_liveupdate_is_outgoing(struct pci_dev *dev)
+{
+	return false;
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 51616e4327d3..47cb3dcaa927 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -546,11 +546,14 @@ static void pci_device_shutdown(struct device *dev)
 	/*
 	 * If this is a kexec reboot, turn off Bus Master bit on the
 	 * device to tell it to not continue to do DMA. Don't touch
-	 * devices in D3cold or unknown states.
+	 * devices being preserved for Live Update or in D3cold or
+	 * unknown states.
+	 *
 	 * If it is not a kexec reboot, firmware will hit the PCI
 	 * devices with big hammer and stop their DMA any way.
 	 */
-	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
+	if (kexec_in_progress && !pci_liveupdate_is_outgoing(pci_dev) &&
+	    pci_dev->current_state <= PCI_D3hot)
 		pci_clear_master(pci_dev);
 }
 
-- 
2.55.0.795.g602f6c329a-goog


