Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDF3CC6B1C
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 16:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GUqD4Ux5OAYgjaajPXSrWaI1PYIhs/xbAlAZjVaS8QQ=; b=iGQSGjdldQW1xPE9qPY9yJyrI0
	UfIV59caMTpb+QqaIs7aj3JDacIiSwirHJT8Tyl7v9HhzukTKRTly6xoITk3CDap7mOIIBahzAO8O
	EJPMa+DJGrCcDZMJW3Y0NB7yC+FjfTIpkdbyEuJjoIw6oqZmUD0d0U1nbTyqOQA52jO157Fw+4f3m
	moXoXRyklZ7Lc/d+Xxi+p3sTL2F3PTlP68XCXEU697gVbWSM8CZ6vgkjbaZz3vTAE3RRA4mKxHE83
	jg4086+QktAj+RCYlGZlasYsdLuALnLA2Ev3w6SopunoQzG3qgoVmkzO2r0yzXBUKWIe2DnXng09l
	f5P4T0iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfKF-0000000DUtu-0s04;
	Tue, 13 Oct 2026 16:26:03 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfK7-0000000DUoh-1Idq
	for kexec@bombadil.infradead.org;
	Tue, 13 Oct 2026 16:26:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GUqD4Ux5OAYgjaajPXSrWaI1PYIhs/xbAlAZjVaS8QQ=; b=APdy0XUCg6vRAEByVitRJUico9
	4TINeg8mTDU2CWi8rbLw9C8a2MttwHOeLhQZRqSzAgkTIKHb4g9BjecREGJ48LTSIU5i6hpRIz/lA
	Lx777inPtHti2vCSnRW4m6vnn+zxDbDSzyo3dtDjXsL4feaFXw+wdmZf6IywnvKdi8cIgTxJFQ93p
	+Yuokxc6OKn8aEUNwS4yomuotMqZnimZeg6ccoPS/nNboMQEd4u47+cNW/1JQKP8azi3UNhUchb5c
	xOZr+uoL5NZgT1czdPSfzK/ZKLGZIsmei8fw+3Y//W7LzD2AYVQ8C2OgqxRF5iJiLV6oNuiWh0rt1
	LFVz4/Iw==;
Received: from mail-pl1-x645.google.com ([2607:f8b0:4864:20::645])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGfK4-0000000FmNQ-20Es
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 16:25:54 +0000
Received: by mail-pl1-x645.google.com with SMTP id d9443c01a7336-2e61a48d5b7so35566265ad.1
        for <kexec@lists.infradead.org>; Tue, 13 Oct 2026 09:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791908750; x=1792513550; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GUqD4Ux5OAYgjaajPXSrWaI1PYIhs/xbAlAZjVaS8QQ=;
        b=wcg1TQ1mihKToyKSBEi9T4LLrHzzwA7+n5DeMElQBi9j+vkIxpaEYKmiI/5Q2cHMgp
         05NfuDmVM/p/rDDbWmthHm+cQH7iJHBgvG2SCu7t0idz0y92Q2OBRcfEa3kO81xNhVIJ
         wDi90MMZlRtQxpaPam5KrX0LY0iqrwHKuaUvhSj5xm0zELDrudVr18jjeNbDjzrkcyOP
         9SvTZ/9m4GSOhDdxUw3hNtnWFvBpAOggwVlloSoa8GAU7FHMAjRb+Syy/DpAGQ5YplIC
         5TpP/wOgctEv1snQPwBPEphZTECDiQQcB2/AHcZ34VuzTzIgrpjrix9LitS+Ly7NTz9S
         EavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791908750; x=1792513550;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GUqD4Ux5OAYgjaajPXSrWaI1PYIhs/xbAlAZjVaS8QQ=;
        b=wtvReyY6LP/KvDhtvH7jV5hGAvOR/rtBKsPzSXEV1sDJm5tU3YUuMSo0qs4P50YGBl
         NSAbXA13WbWBs1Aax5azyuC/Y59CHofFGuYPfUrKdBdtXynHVkWdCMYv7HS1e/T2aIYo
         LcCTg6/ByXahnGx9BA0kXiGm0v5uKy2EE8bsW4GEs4g2z7NTRrz0aCh3EzpqzfOpAalH
         Xi455Z0Kb7/+PTNkABAGBiQtnVeNjS9G8VWpFZ/8sfa9nelsp6JqRJbggdrawVKWePv+
         6ce3HueauSxVgIP8tkkp8fOo+/JNHkXZLqz/eexBNQGGKuK76tVoSHw00/LIYVSAgWbR
         qRtg==
X-Gm-Message-State: AFq9FYLk8xwG1utEipbQTdIzdAhzZsaCg7rP+/7ZMOzvFqZSmv0wOWc+
	S+uZIMkMoJlBcrzG0imnHXkQJ8b1cTOR8jAdbW4LqqHRGbh7rMfkgujy9oBrbB2c9KzRzzLPe6y
	i1Ib1DhYMD9e9Lj/F1co2q7fud4+oU01offOvAp0N9HLUDUS4mG2V/RRyZ9sVmETpsKdVuOgjcR
	VPmR19fJYA6s6wQ0TepS6stghXGgL65YlIznlYq3neMczXmGg7hb8=
X-Received: from plbg2.prod.google.com ([2002:a17:902:d1c2:b0:2e8:31af:11b0])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2305:b0:2dd:ad73:5b56 with SMTP id d9443c01a7336-2e842cd12bamr86769775ad.17.1791908749286;
 Tue, 13 Oct 2026 09:25:49 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:25:28 +0000
In-Reply-To: <20261013162529.1928093-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20261013162529.1928093-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013162529.1928093-13-dmatlack@google.com>
Subject: [PATCH v10 12/13] PCI: liveupdate: Do not disable bus mastering on
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
X-CRM114-CacheID: sfid-20261013_172552_608520_0C1B71C8 
X-CRM114-Status: GOOD (  17.72  )
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
index 38b7815fe7d4..6f92d4ddca2b 100644
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
@@ -973,6 +977,13 @@ int pci_liveupdate_adopt_ari(struct pci_dev *dev)
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
2.56.0.385.gd3acb90ef8-goog


