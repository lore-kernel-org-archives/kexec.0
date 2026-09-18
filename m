Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10790C982E0
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 20:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=siMAWwJv4yjE1eEtNkD6j1Z4yk/PjEJKUuLYDAAYM4E=; b=nNoPCqcX+JqdecybRschP/6wNW
	FbUDE5XgYfNNivG9zomYnDGcJXCHXFepmYyfqMcHUw8aDfmJ5QnHKfB/Re94eskVep5sAd7GQl26L
	HIhKdUtPMK7DXbwQT4t58wrURNtHQ1VWjOoWgJH/3aaJbFKgE1cgWkWLZsUOGfYM251uX33Obn4dV
	9bGaZjaAdw1MPBeBxGqbY8vhh9cWOxQsMRbm/A2574XCxDY/n+vsyT5EymLO///w2IBDM+DmihKwp
	DHCVd/uBFwrrF1kvbnmVtaXdQGsKmbU79R2WbiD6CXyJsJz27LUYgkJTdyVH1f3KaV2Mg6H9St5Xq
	G4/ZvOXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7erb-0000000FTax-0aIJ;
	Fri, 18 Sep 2026 20:07:15 +0000
Received: from mail-pl1-x645.google.com ([2607:f8b0:4864:20::645])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7erS-0000000FTP3-3Zno
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 20:07:09 +0000
Received: by mail-pl1-x645.google.com with SMTP id d9443c01a7336-2dc92350888so18274195ad.3
        for <kexec@lists.infradead.org>; Fri, 18 Sep 2026 13:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789762024; x=1790366824; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=siMAWwJv4yjE1eEtNkD6j1Z4yk/PjEJKUuLYDAAYM4E=;
        b=AwLsS0BAXNukd8F3XdQZgdRFrr4V8mUaO9V6kZOkqXPFh/4lYFamEZvDx2/iLwchI3
         QpS9f1calps0SWS3LnG/boxt15vvQk7RH/5jcSERaIaiALt4B7vo9xQZi4IXigFmEmxd
         HIeKI3Qim+V0A8rjtPFMAMqmUV5eoKT6A13QAy24K6e0FTbhaVU58RQg/rF5TCj074Hh
         GjpoLxlgySlKKHlx5yp+zY0+I9I0Q5iROL//qhlQK3fIOVJz90cPex3HWHe5edjN7TdQ
         AuRfnMuznSjW3DoJ7BgTcq0lIutPp5cN4LKCQYLbyLXBqPH7XLMSrBc+7rCoQ9gglJjT
         gJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789762024; x=1790366824;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=siMAWwJv4yjE1eEtNkD6j1Z4yk/PjEJKUuLYDAAYM4E=;
        b=YBSwqRQ2Y8PftLNmGxsq1lvakdHnxMIRPB77PkDLhhrPyN/B/iUk4unzLXsK4tgRq9
         wWfFn5Qyap+45eHKHGaPr1997FLCgiMeTe98x/frVJVogqH3gkaTnz9z2H552Z5E7ph5
         RQgVle6D5vXSIb5O05cWS6O5z7mEAlxUH4qvlr8zyLBPqUeY/k7mLkUebXyscvSDr1Mm
         HbBJ2ME1IshB5Z4rUWLp3XWF+WyB90F1zZdKNdgAFR6F/qf05SwCta7YeTfwnEzz0SPQ
         MF1DcLPyna60ruusMMbgWFTEHZ/ORZtE3s4KHy79XO6PuR62MDLoTRc4w1Wfo/JmZWJ7
         OBAQ==
X-Gm-Message-State: AFuF++mr3WtuVTRiVA6e4nuaPle+M84d70fvsp40pjf1j1Rhcg/ytQJJ
	0tZ+kWHu9bNJ8IEjytuUjy0uL3DGkpx7XQ8KiqKcZSC6HhEdZr6y4PZvQYsnoH0v+cH2HMrgbo1
	6jAmMPeSSlViYVmnfT8hCDKba/BoUMNHd8dH3w0Jie8GDCymVWJ8ktXpZfPa9NRUdWk6WfdZU4s
	KPRxCIxnlFpVx2Iv7Jga3ZibfK6D47x3Q7oMKKlLeAUaaNJzwvzpY=
X-Received: from pgbgf16.prod.google.com ([2002:a05:6a02:2cd0:b0:cc5:1124:470d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:7209:b0:2dd:c100:a5dd with SMTP id d9443c01a7336-2ddc100a681mr6689305ad.49.1789762023439;
 Fri, 18 Sep 2026 13:07:03 -0700 (PDT)
Date: Fri, 18 Sep 2026 20:06:38 +0000
In-Reply-To: <20260918200640.887030-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260918200640.887030-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918200640.887030-13-dmatlack@google.com>
Subject: [PATCH v9 12/13] PCI: liveupdate: Do not disable bus mastering on
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
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_130706_926055_59FAD74B 
X-CRM114-Status: GOOD (  16.50  )
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
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 11 +++++++++++
 drivers/pci/liveupdate.h |  6 ++++++
 drivers/pci/pci-driver.c |  7 +++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 496ba74c26ce..51695782ed42 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -193,6 +193,10 @@
  *  * The PCI core adopts ARI Forwarding Enable on all bridges with downstream
  *    preserved devices to ensure that all preserved devices on the bridge's
  *    secondary bus are addressable after the Live Update.
+ *
+ *  * The PCI core does not disable bus mastering on outgoing preserved devices
+ *    during kexec. This allows preserved devices to issue memory transactions
+ *    throughout the Live Update.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -950,6 +954,13 @@ int pci_liveupdate_adopt_ari(struct pci_dev *dev)
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
index 5aac19f7bee6..333ddd8f36c5 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -18,6 +18,7 @@ bool pci_liveupdate_preserve_bus_numbers(void);
 bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus, struct pci_dev *dev);
 int pci_liveupdate_adopt_acs(struct pci_dev *dev);
 int pci_liveupdate_adopt_ari(struct pci_dev *dev);
+bool pci_liveupdate_is_outgoing(struct pci_dev *dev);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -51,6 +52,11 @@ static inline int pci_liveupdate_adopt_ari(struct pci_dev *dev)
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
index dff60a03204f..c1ac2ef025e2 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -569,11 +569,14 @@ static void pci_device_shutdown(struct device *dev)
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
2.55.0.1082.g2b9226bbc0-goog


