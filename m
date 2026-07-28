Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1465BC54F51
	for <kexec@archiver.kernel.org>; Tue, 28 Jul 2026 22:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kK9fmvYx94bqGyeMgzsYcbMKuj2faWTY3fQuvgNhZiw=; b=nkqeL/VymeEyNb/phYC6be8uBL
	Z8Pro2ngAQ7haaiFPqioE0aWlGcpIAAP2nqpDUDQbU47ayWgFuYR/NKQ0L5Ue9oPEoOP/3Ae08yHl
	J3fv5/F8PmKjlzFYlhI4ZyOhfJNVALUlGWY9i6wYcLZSYQyjWc6tdxMAOVAY1Vop3q4+JGWaDuPdl
	6utUQ0iGLQZ+s3rM7WHaC7VJe1QPu1SPCmCQ6TA6VHWZyNrf8Gw4PD4tT7yQ1R6H+pSg06dKn/9Op
	4sH+I1VjOuyi/2jopfZxo5NyZr4ko0YomMJkkHmJbAQMHdKTPZsD5adPo+8gMwBEYeNxtKmjb5E5F
	jRHPlOgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woq0V-00000006O41-1Cjh;
	Tue, 28 Jul 2026 22:10:39 +0000
Received: from mail-pg1-x547.google.com ([2607:f8b0:4864:20::547])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woq0N-00000006NuN-44zm
	for kexec@lists.infradead.org;
	Tue, 28 Jul 2026 22:10:34 +0000
Received: by mail-pg1-x547.google.com with SMTP id 41be03b00d2f7-caf5fa127d4so408111a12.0
        for <kexec@lists.infradead.org>; Tue, 28 Jul 2026 15:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785276630; x=1785881430; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kK9fmvYx94bqGyeMgzsYcbMKuj2faWTY3fQuvgNhZiw=;
        b=KyN3xpOaTUSn4fDnw4ORcA4wq9uRryW6RZYEGTRPZA0kzP6fHDYV0v9KWDXccXNsCE
         tj8MfrGF9F/YFPT3H6SAcCHLDeafM9V+ICxac+kOg6L4TGRckRqrtVbwLMNC3GH9EEly
         MsRmVXFZjxoL6+/b4j+69OJpDcaJLVLJA3d4v82AexNTJEy35zF910qEkdhYs2LS2E2r
         QzMrBzhZPBdvg3H5aXAg78zwcYfS1UkOSjy7Re3oHVp888FsAzIuiDZgfyQWs4i/nzpI
         oKoj6KGUgvm4yVqjjtl7pzi4TQGg+PC16zAH1PbQvylNyvaB2Sb9h4nS3Ix5JOHXRZ58
         LvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785276630; x=1785881430;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kK9fmvYx94bqGyeMgzsYcbMKuj2faWTY3fQuvgNhZiw=;
        b=XfAw2lcwN5aIMwt73h8j8rjBzpzHmAQD4ahWM4gDawpNJ04Q0Cd75Dn9Bmc4Aw41Uv
         ProUC2XF+7QpFOBDdrKbVjjZczZgB9xTMS0/Dq0bEipE7ylWXUp2aNAAac1AQFhCCDOt
         imVXuaH2QkFu+bGwDANmkzzAXJImiBF9XikjqjEbzMFxnHjbjmQy+veoHBj7NVSg4qtr
         RlC/r/Cz32ZYD5wQ0wMWjGgqBowhwhAPcohez1FzGDRQOowUQZ8hLjHdYF9InHoeEooB
         n09ASz43pTLdxhb5dXC1t+hBcnchgrurVObyM7QvnSk9blXqN7GNx0j6n6o1lBe9lwrw
         viCw==
X-Gm-Message-State: AOJu0YxUEK70y4TQ7Sv3vkZlw5Fstx27sTCZkfhx/yFlsBpMriFBzyph
	E2HaxIVr+3+mWjYXjeHU3EBjm9FWgGDMWq4YQvgMgw1OTgCnBzj1Buv2m+DOS17JJMMuF6u9c4U
	JWKJXZ0JeFdiLFcMLLPbMBQrlJl6oLzVQ9eyBzeqD16RDMRR4kEfhJx1k5f6N2KIr1Q66jFUH/B
	WJOjEuM7DNQBg6ZC8yThKWHP/HTm2/YJH79drDyz+UciKrcEfYXBs=
X-Received: from pfik11.prod.google.com ([2002:aa7:820b:0:b0:84e:40d2:2e74])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:39a9:b0:845:3914:f039 with SMTP id d2e1a72fcca58-84e93203c18mr4669411b3a.26.1785276630227;
 Tue, 28 Jul 2026 15:10:30 -0700 (PDT)
Date: Tue, 28 Jul 2026 22:10:05 +0000
In-Reply-To: <20260728221007.2098560-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260728221007.2098560-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728221007.2098560-12-dmatlack@google.com>
Subject: [PATCH v8 11/12] PCI: liveupdate: Do not disable bus mastering on
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
X-CRM114-CacheID: sfid-20260728_151032_032875_90F955BD 
X-CRM114-Status: GOOD (  17.30  )
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
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 11 +++++++++++
 drivers/pci/liveupdate.h |  6 ++++++
 drivers/pci/pci-driver.c |  7 +++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 65bcecb1b64e..32b73ebf71f7 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -132,6 +132,10 @@
  *  * The PCI core adopts ARI Forwarding Enable on all bridges with downstream
  *    preserved devices to ensure that all preserved devices on the bridge's
  *    secondary bus are addressable after the Live Update.
+ *
+ *  * The PCI core does not disable bus mastering on outgoing preserved devices
+ *    during kexec. This allows preserved devices to issue memory transactions
+ *    throughout the Live Update.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -879,6 +883,13 @@ int pci_liveupdate_adopt_ari(struct pci_dev *dev)
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
index 49d07fd02132..9c31fb60207d 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -20,6 +20,7 @@ void pci_liveupdate_scan_bridge_end(struct pci_dev *dev);
 void pci_liveupdate_cache_adopted_acs_controls(struct pci_dev *dev);
 int pci_liveupdate_enable_adopted_acs_controls(struct pci_dev *dev);
 int pci_liveupdate_adopt_ari(struct pci_dev *dev);
+bool pci_liveupdate_is_outgoing(struct pci_dev *dev);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -55,6 +56,11 @@ static inline int pci_liveupdate_adopt_ari(struct pci_dev *dev)
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
2.55.0.487.gaf234c4eb3-goog


