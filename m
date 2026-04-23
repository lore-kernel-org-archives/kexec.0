Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33FCFDEE4D
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 21:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NDSmr3KzvFf45fqXLLacm4Nig+LS/n/kl38OHtIvfGo=; b=eX22NbCsfwxjcS051MRx0ekzgV
	Ie87N5wR+TZQMEw0FYGN/l6cbTCKvZNufWnT0ofpQ0Sc2zcP1aTy+xNJYc18IJtb7uZR2RELUrHy2
	TjJafcx4ss3PBgJwMxirsBSJxhproCARvCKHnZUyFFrceJM/UU96CpYlf5J4GQtCaMgdZ8AVRNe9C
	SiSRjHmgVebRXAOsi4JczgbXiZ6XvlCrkRGVNzYqFpXOTiaGM49r+2fKSL2i5hy7UCX5uzCSuYXt9
	9us0PD32QhYUEXwqeSPJytMs9bHTbVft1EP9Lc8g09hkbRoeVzhj38vP1b3wGm45Yb6l3eRhk+4vr
	gl853Xjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG1WP-0000000CLHi-461b;
	Thu, 23 Apr 2026 21:23:41 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG1WN-0000000CLE5-00lI
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 21:23:40 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2b242b9359aso70728565ad.0
        for <kexec@lists.infradead.org>; Thu, 23 Apr 2026 14:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776979418; x=1777584218; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NDSmr3KzvFf45fqXLLacm4Nig+LS/n/kl38OHtIvfGo=;
        b=iZb4DLzw5mTV6xIghe3mvW06LI1cCwUWj8KN9btDi0ujBqtFaZ237NV4Bxqt2+Hzgv
         5bbsXQC9q2tAY3pHpeaw1J1RkY5tl7Cj0grWNJ0O0vdz8t+yvbrpjzngHtWVOsr0/jAJ
         o9rSuP75hsQomGveOQYtc8i+iB2z5uqGCttOaS6g3+hwNehM3RLVZM31oGy22mZKOefj
         h13xzjqH7ZKyis42lSd0pYpzdPUdtni3MJfyozR6xlHfoNP6s5RZe/9A8sspf38Z6J7I
         nxk9zs6eIb7IS1Wv3tS0WSSCZ/7Ut39tUKdATwA6spC3YJgtB984BVw5HHwvezCPMmiB
         74Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979418; x=1777584218;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDSmr3KzvFf45fqXLLacm4Nig+LS/n/kl38OHtIvfGo=;
        b=ZMZVbC9L1B7aYVWcNImuUV9g3SkUTVdo6od0oyE0sb1X+rD7gWeLjDT7kyYYP/nEIR
         3G3HIHMgzalDGi1WuZiRsIz3o/GZ579Y41ncoDz8GPa//K0rLjR4ZNzaGHcTS1R6P3gQ
         6rOA3q0GPDxAvLqi78CrMwBxRrem/8xl5VBZM2dU+8fUw6Q6g1p1juCqF9jDy6NiWyQD
         Dm7m7L9+Z+nDSU+i3ZIafrwwH5OthF3iJsQW8GjuaLn831BvATkskg+jHODb4QzBhxvi
         eJ+MYpkgQaKPrxoPk7S+CD2dLJR7OT5aPMLltFNGR7GG3Tk80MUpm9Ib/LBtJ0x3Sh6y
         7qNw==
X-Forwarded-Encrypted: i=1; AFNElJ/cmCGvd+XJQ1fZznfeBaYw7rfkgpNicfk4SATL/W+MVMzHzyh0KqKKtNhk+K2dNiF8J512TQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxu/HoHHqKEOrYfh8ua94Yy7wn+G6PSfmJX3F/X1BGvad28oa5Y
	CdqesXztNYvUg7cI6SDAeLM4Ibll59BWNpLAMiq/k7Te2V0nz8N//BQ4KuUTgSU8owWqhTDhj4M
	hGh1T6cyyl5dexQ==
X-Received: from plov1.prod.google.com ([2002:a17:902:8d81:b0:2ae:c54f:d5ad])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ba94:b0:2b4:5c0d:314b with SMTP id d9443c01a7336-2b5f9f83342mr210260195ad.38.1776979417788;
 Thu, 23 Apr 2026 14:23:37 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:23:14 +0000
In-Reply-To: <20260423212316.3431746-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423212316.3431746-11-dmatlack@google.com>
Subject: [PATCH v4 10/11] PCI: liveupdate: Do not disable bus mastering on
 preserved devices during kexec
From: David Matlack <dmatlack@google.com>
To: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_142339_054020_585BD188 
X-CRM114-Status: GOOD (  17.98  )
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
 drivers/pci/pci-driver.c | 31 ++++++++++++++++++++++---------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 25c86cd4c173..2a4a139623a6 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -132,6 +132,10 @@
  *  * The PCI core inherits ARI Forwarding Enable on all bridges with downstream
  *    preserved devices to ensure that all preserved devices on the bridge's
  *    secondary bus are addressable after the Live Update.
+ *
+ *  * The PCI core does not disable bus mastering on outoing preserved devices
+ *    during kexec. This allows preserved devices to issue memory transactions
+ *    throughout the Live Update.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index d10ece0889f0..05584bc76332 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -531,6 +531,27 @@ static void pci_device_remove(struct device *dev)
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
+	if (pci_liveupdate_outgoing(pci_dev))
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
@@ -541,15 +562,7 @@ static void pci_device_shutdown(struct device *dev)
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
2.54.0.rc2.544.gc7ae2d5bb8-goog


