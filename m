Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F93CD343F
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 18:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zAKIEIbekI8e2jyBQPj/1aDykzqqCbaXW0rj6vQUpoI=; b=kSZhCOjsq3QochoW4v0uUf4ZLa
	LI9ffhrIBWcuGQRqeqihJ52lYH3UrVGvOqsrWjcgJq8F1/RjTX18Yc6xSGhAmv5aiY7ti6SgJbTLd
	7s1N3NbZr2uXkRnJ4vOm4dqVsu6qQhju8pyTCDaqMsI0hf1vls6lyB3nIvOwWeUIIFNs7RF7rlZca
	yrEBhFTgYMDn6orCGE+1MPKefhQAsWO/F2KdQqguYLyyqdpJG9C08bt5DaaEuHKm8mSjzhLiLB+7j
	MKA9wAsmoHyZaJ0okEDSO5dQIaLY9+as5O0x4aFYr5qNWJD/IT7k3N8xg6r9711VCzCXfLWKJ8b8r
	ZNpiCh7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMsAC-000000008np-4AE5;
	Tue, 12 May 2026 18:49:04 +0000
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMsA9-000000008hz-1g2h
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 18:49:02 +0000
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-837c4eb3bdfso3989867b3a.2
        for <kexec@lists.infradead.org>; Tue, 12 May 2026 11:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778611740; x=1779216540; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zAKIEIbekI8e2jyBQPj/1aDykzqqCbaXW0rj6vQUpoI=;
        b=cVSVsz1kejD5yMNdDQJIabSf3Nf4qS5Di+w+B8yYLAF8FuLw6DI74zb7TLpyseHuJc
         i5WcYva4+XjOvSINMMH4qnj/0V8KPZAQt/HSs+xFVFzFaNXuoxYpP+gclkkuwVUhEG5i
         xDnJc9h/c9DcwHPtsKqcHVCEgFLtSEng7ST7KctOJAk/v2ZWaBGaS7OCyG/xPk01M6+T
         RyS3fHFhKaYKN9q76zUDepGf2NwC9enCMtAD0HzpMMsttfW6Za092qKhZWFsIdph1jm9
         I53rXX9CRvi8GZN0Zr6jpMSFAv6QOu7ZktztfzNYOXKQeQKtE0SnqdsB0XI74q3uNjha
         JsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778611740; x=1779216540;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zAKIEIbekI8e2jyBQPj/1aDykzqqCbaXW0rj6vQUpoI=;
        b=FuxXuVZRa4IkcLgIqzZYTs6wAm5H4pWx11NJoyTAlIwfSQ+1thbTmIJQuqOmbwaGIL
         2tvWmVU/wLAeRVVKzwgekiNTvUU82dLQ8Up6wJ6jFStu5Mx4HsomvzYnp4Qn9OtK0HLf
         GfymUg3AkR0Kx+3WHuFGZ1b9BOoYiuvuoPxbSFQqUTBATsf053QJ0O2iiq0/+f6fqIe2
         HyJ22xhZfawKgnzH+lO+oRfz0YPpIaLoOvoZj7r0Tr9nQ5VqiqL0xHFO8t0z2F/kWCBY
         fDJwC6XYs5VoaDrOeDK8+ce3B0Jgp8AVVOlgdlFVPACcBwgg8at2XFJZtqGpLEHmge/Q
         /TyA==
X-Gm-Message-State: AOJu0YyKCIDLJPIgAJrG/r+scdIHOEvewZylE2alT+E4wOUTO2OcJv6L
	cqzKh7GFEBiVFdybNI5ApDy/uOAVRTnK/xW3tApqZtDfxoSP6ne+7KBxHk+ECNue8bgOAxCVXrL
	niXZiomgwV/d0SKS5+1gyGty9emF8X2vxW0YcilEjlIHokZwE0T08BL/aOI4ErUoY4t1sssrnfV
	nybHUfu4oyqeQl+ORZIBav5Fuf6ac+cbaev4d9VZDadL8eBaeSWko=
X-Received: from pfbks2.prod.google.com ([2002:a05:6a00:4b82:b0:82f:b296:c01b])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:12e4:b0:82c:f035:6748 with SMTP id d2e1a72fcca58-83a5dd560e6mr29210159b3a.42.1778611739675;
 Tue, 12 May 2026 11:48:59 -0700 (PDT)
Date: Tue, 12 May 2026 18:48:45 +0000
In-Reply-To: <20260512184846.119396-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260512184846.119396-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512184846.119396-11-dmatlack@google.com>
Subject: [PATCH v5 10/11] PCI: liveupdate: Do not disable bus mastering on
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
X-CRM114-CacheID: sfid-20260512_114901_445935_2F1F1EF6 
X-CRM114-Status: GOOD (  19.09  )
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
a Live Update to minimize downtime and ensure continuous operation.
Clearing the bus mastering bit would prevent these devices from issuing
any memory requests while the new kernel boots.

Because bridges upstream of preserved endpoint devices are also
automatically preserved, this change also avoids clearing bus mastering
on them. This is critical because clearing bus mastering on an upstream
bridge prevents the bridge from forwarding memory requests upstream (i.e.
it would prevent the endpoint device from accessing system RAM and doing
peer-to-peer transactions with devices not downstream of the bridge).

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c |  4 ++++
 drivers/pci/liveupdate.h | 12 ++++++++++++
 drivers/pci/pci-driver.c | 31 ++++++++++++++++++++++---------
 3 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 825166a57913..6c4b57d8f780 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -136,6 +136,10 @@
  *  * The PCI core inherits ARI Forwarding Enable on all bridges with downstream
  *    preserved devices to ensure that all preserved devices on the bridge's
  *    secondary bus are addressable after the Live Update.
+ *
+ *  * The PCI core does not disable bus mastering on outgoing preserved devices
+ *    during kexec. This allows preserved devices to issue memory transactions
+ *    throughout the Live Update.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index 30deaa673efe..8ad404307a70 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -18,6 +18,13 @@ bool pci_liveupdate_inherit_buses(void);
 void pci_liveupdate_init_acs(struct pci_dev *dev);
 bool pci_liveupdate_inherit_acs(struct pci_dev *dev);
 bool pci_liveupdate_inherit_ari(struct pci_dev *dev);
+
+static inline bool pci_liveupdate_is_outgoing(struct pci_dev *dev)
+{
+	guard(read_lock)(&dev->liveupdate.lock);
+	pci_WARN_ONCE(dev, !dev->liveupdate.frozen, "Preservation status is unstable!\n");
+	return dev->liveupdate.outgoing;
+}
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -49,6 +56,11 @@ static inline bool pci_liveupdate_inherit_ari(struct pci_dev *dev)
 {
 	return false;
 }
+
+static inline bool pci_liveupdate_is_outgoing(struct pci_dev *dev)
+{
+	return false;
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index f7a5e65a7c75..b6c931ebd3be 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -532,6 +532,27 @@ static void pci_device_remove(struct device *dev)
 	pci_dev_put(pci_dev);
 }
 
+/*
+ * Disable bus mastering on the device so that it does not perform memory
+ * transactions during kexec.
+ *
+ * Don't touch devices that are being preserved across kexec for Live
+ * Update or that are in D3cold or unknown states.
+ */
+static void pci_clear_master_for_shutdown(struct pci_dev *pci_dev)
+{
+	if (!kexec_in_progress)
+		return;
+
+	if (pci_liveupdate_is_outgoing(pci_dev))
+		return;
+
+	if (pci_dev->current_state > PCI_D3hot)
+		return;
+
+	pci_clear_master(pci_dev);
+}
+
 static void pci_device_shutdown(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
@@ -543,15 +564,7 @@ static void pci_device_shutdown(struct device *dev)
 	if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
 
-	/*
-	 * If this is a kexec reboot, turn off Bus Master bit on the
-	 * device to tell it to not continue to do DMA. Don't touch
-	 * devices in D3cold or unknown states.
-	 * If it is not a kexec reboot, firmware will hit the PCI
-	 * devices with big hammer and stop their DMA any way.
-	 */
-	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
-		pci_clear_master(pci_dev);
+	pci_clear_master_for_shutdown(pci_dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.54.0.563.g4f69b47b94-goog


