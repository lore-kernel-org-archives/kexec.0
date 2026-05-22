Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10F6CD5BB1
	for <kexec@archiver.kernel.org>; Fri, 22 May 2026 20:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ELGOGHy4/KVLZOwsmSfN8vqnsYItcEyHVrWWGLC9A+w=; b=edvGqyTmdwYDtOUz3sC+HlxQDi
	ObXSRsDlleBvaKzSBTdELGrVBJmRzwz8M0jnqTMVK3xZWaw0An/CXHTS6b/V7Q2KL+LZQ1Ktx4ohN
	i6ajbF7yaEDjKOH1L163ud1Cj2d6YNeLrMq3WdJMdm8b5dxfFiop3LAu5hdlkHy6/R80dWezIhVT/
	za2+vFgh7n2qQ8UdLz6ql5lr9tmh1AstXyNT+Zd88HqE/3BXucs7qbpLonnwu3OJ8g4hEN1cpvJV1
	y06OjD36LX5xBY8BpqH5XXTfmEg439dU7FC5RBFH+q3HdSHs3AM502GXMHL+q5bkrmoPnlSQg/xLt
	EoeElvsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQWPy-0000000Bs1W-3kGc;
	Fri, 22 May 2026 20:24:26 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQWPv-0000000Brv7-11CX
	for kexec@lists.infradead.org;
	Fri, 22 May 2026 20:24:24 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2ba86e35aa1so125209975ad.1
        for <kexec@lists.infradead.org>; Fri, 22 May 2026 13:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779481462; x=1780086262; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ELGOGHy4/KVLZOwsmSfN8vqnsYItcEyHVrWWGLC9A+w=;
        b=h8aCCtjMhakdw7C9Q45TuIjWkmICS6HpID7Qktpj5SSfmzOo+dR8aNmuU7LSzjSU5f
         +drRs51wCIzAgSR/Rb7CBj16ohJzk4fcAYH3uYDYPn9Oaw8qYgMzIJAkYjhyJkugTJ+2
         bI3C2S55Yy101ZAsr2dgKeHbjrK4xf4eO4DZLYcS6yZwUoCk1ZDLsPa4XYr8ZVBCr+87
         XQxOzUtP6eHx+p80Epv04kVtTYWYUvy5ipGhBIhXFzXNfbZv3oUSZnDDy+RT2OiAVtG3
         w+tLmB2uUdPhdYLRrqpHbpW89Cw9398cjIl93aTNG6S9Xh81rjSMKYka+MJ/mukbG1u/
         qD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779481462; x=1780086262;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ELGOGHy4/KVLZOwsmSfN8vqnsYItcEyHVrWWGLC9A+w=;
        b=EngYMJXjojHYOT3RaYkHzbLo2drp6kwDBrRiEVhHfwOolBBUDWUm/tDOFGjMPvHM5t
         kWr0WTmRUWKiY8vmQdSmFpSB++G97kEMMZ+b2XgbU/NcFF8uSrAeSaRuWbVNMC9C75I5
         RAy4u+wa1mgliFLnrbtcg2trcudDosb7EBCefAHA9UMmPjca83Gh+VOKUH4fKOCy157Y
         9bJipvkWX+MFIc2C5mg2VYAJp8DCZnfZFoqxq6+T1D4WwcLQ0TDcjog5Q5AGZ6sZt/pR
         ezdlcFcVU7QUm9gGnLPUpTn6m5CGOnqgRi4bIlwIgRp1ae+HG7Y1vzjpbLvX3PiQM54n
         b5cQ==
X-Gm-Message-State: AOJu0YzfX0ZatqZE2wKCwwdxdFKP37ANNomAYzaGo67fSvPgQaM5IPMJ
	7eLY3Ib42shA6GyU1gbVxriZSZ7hbSfx4L1eGKUvrtG/SunxhudNe1lnkXuG6ezZBUUvbIbwhPg
	D1y5xUTPRXRxlADU9nUKlumR+UfzBjAihJNnr3MqLGgtirtPrg6KFtvlG/MhU0Zxid7h2QaCPHX
	mQztG8oXpmhy1ikqg+zbTHITYSSNl/98xKVQ6K7F3K8ju5h13IGqU=
X-Received: from plgm11.prod.google.com ([2002:a17:902:f64b:b0:2ae:c50f:f4ec])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2b0e:b0:2bc:7c62:187 with SMTP id d9443c01a7336-2beb06133f5mr57599895ad.29.1779481461788;
 Fri, 22 May 2026 13:24:21 -0700 (PDT)
Date: Fri, 22 May 2026 20:24:09 +0000
In-Reply-To: <20260522202410.3104264-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260522202410.3104264-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522202410.3104264-12-dmatlack@google.com>
Subject: [PATCH v6 11/12] PCI: liveupdate: Do not disable bus mastering on
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
X-CRM114-CacheID: sfid-20260522_132423_328788_C8C76B89 
X-CRM114-Status: GOOD (  16.53  )
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

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 11 +++++++++++
 drivers/pci/liveupdate.h |  6 ++++++
 drivers/pci/pci-driver.c |  7 +++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index d404e64a4e55..a6f2790bc1bf 100644
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
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -790,6 +794,13 @@ int pci_liveupdate_configure_ari(struct pci_dev *dev)
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
index f7a5e65a7c75..0b1f8d01d7a5 100644
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
2.54.0.746.g67dd491aae-goog


