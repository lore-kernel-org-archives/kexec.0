Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D2DC982E8
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 20:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DtzV4A7ubsZUgCkixUUqpezuoGcnB31d+FYFVqWSkUU=; b=su2n7gWw4rEwdL+SRer10oKnmL
	5vIqHQZfk2NxMvxaeYmuuX2rcQH0rsMqfxzmmn8NPArjr9VEuRXFLFFWyvGmMCR4BCCAI36IYTmno
	kdith6HETZ4MiWKg0hy6aC2rPiWJ0W1SlwwhcxCiEME6pCs+beiLrN1yGOppNS4P8Y6ipjt2A+ln6
	JfarYEBrcUJZJiwrY7ss+0WHLLRME2Vj78xZTL78cWKWqERjDJfPWvRM8jOKl99Aw9xWOxpsn/hAK
	+6hnOQbR8rPCQ9CQyrogQLmCzC5L5B0DdI9s4vYzeW6zWOYGowzT/jeH41rwNNWy1Xg3wTtvqHmkF
	81gLcEOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7erW-0000000FTU8-13Pp;
	Fri, 18 Sep 2026 20:07:10 +0000
Received: from mail-pg1-x545.google.com ([2607:f8b0:4864:20::545])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7erS-0000000FTO7-03ox
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 20:07:07 +0000
Received: by mail-pg1-x545.google.com with SMTP id 41be03b00d2f7-cc1eb205d31so1456526a12.2
        for <kexec@lists.infradead.org>; Fri, 18 Sep 2026 13:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789762023; x=1790366823; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DtzV4A7ubsZUgCkixUUqpezuoGcnB31d+FYFVqWSkUU=;
        b=D2bI5LDLl8ANmxRievIz/9fP7HKXYjAP+ZM4P1sux3j08uGrC9QK+uC6lHN2JE53zj
         CbP3gDX+AP/wZsifGlqnIiH+GHSDwN/xB51gx10QYpDAC8YOY3iIz4hZi7xI0f0Lh7O3
         5IMK1edfyLu37m+1024hmdIIUeMvFWeRl3mHwTZ8Uymio1cME5WodQXtDLlQP/xdVbUQ
         pxaWxEATxjKHy0JOuEaOeZTKgurHyj421qI6Z3OrHn7oXdQfyq93H2vwpxVlvkB8Jcir
         Gd3d+H0RCgKgTOhpNeEhkbG3QHo6LSVOQuxyMbtE1g+2vBlsCvkJfc6SjXrbx6yY91+9
         XJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789762023; x=1790366823;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DtzV4A7ubsZUgCkixUUqpezuoGcnB31d+FYFVqWSkUU=;
        b=jK4C4hBfbldq7S85UONaJks4dWEjNkqQdWjI7pAuvVmyxWj7nGi1s5bT3UlCKjubc+
         1/6i1wXSu310oERA21oZUrsDvoxxbpeiZBXxGS0xClVA+FGEYwvERJj0r8+rAZqRPkk/
         mFabnXGll76wwkRYSwpveDp78RA4uQxAX1KCTbdEmgSnDC+sEhrBKfkLpIuXTV+/g8bW
         3R3T11ql/NmII8CCUmYMmRSjZLHxen2+RqMJWJsHP4Z18+FNB1qh4VNLMcXNuxfocLi0
         LazWCK9BpmLFPsFCTctMbbHsrgracRmISCrAtjxXO6R0W0eHdDcZl8a3b16L+z97Tb6m
         fDBg==
X-Gm-Message-State: AFuF++l29tLPedUOu/z2bqgZ3/WCYMhrAIrwuErFnSwhqht0FbWUkATf
	TrfW4rmJMYx2T5PR8V+BgUUpNsp6e4O6g0tCG272ojHcVvI4OI11W1k3mrcutbwE3g3tKpRs/1n
	tfITXLcuGtUbBp4Eg8JYh83KADbQwZBLlhXE5c8GAusRSv12A/oJF1DMlThMJrtlZhclUKMhDJA
	FDWu88R1cVoFPpTgssBSv5vIFx6J/HW3qpSX82cdh52qC4Y8Ldgqg=
X-Received: from pgvc3.prod.google.com ([2002:a65:6183:0:b0:cc4:56ea:7ae7])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:1b81:b0:3da:bea4:6215 with SMTP id adf61e73a8af0-3dd8c52948cmr7756540637.19.1789762022690;
 Fri, 18 Sep 2026 13:07:02 -0700 (PDT)
Date: Fri, 18 Sep 2026 20:06:37 +0000
In-Reply-To: <20260918200640.887030-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260918200640.887030-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918200640.887030-12-dmatlack@google.com>
Subject: [PATCH v9 11/13] PCI: liveupdate: Freeze preservation status during shutdown
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
X-CRM114-CacheID: sfid-20260918_130706_075142_B206FE69 
X-CRM114-Status: GOOD (  14.27  )
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

Freeze a device's outgoing preservation status (preserved or not
preserved) during shutdown. This enables the PCI core and drivers to
safely make decisions based on the device's preservation status during
shutdown.

Note that pci_liveupdate_freeze() is triggered by the PCI core rather
than from drivers participating in Live Update so that all devices can
have their status frozen (i.e. prevent non-preserved devices from
getting preserved late).

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c       | 16 ++++++++++++++++
 drivers/pci/liveupdate.h       |  5 +++++
 drivers/pci/pci-driver.c       |  2 ++
 include/linux/pci_liveupdate.h |  3 +++
 4 files changed, 26 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 3c9a10a892fc..496ba74c26ce 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -481,6 +481,11 @@ static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
 {
 	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
 
+	if (dev->liveupdate.frozen) {
+		pci_warn(dev, "Cannot unpreserve device after it is frozen!\n");
+		return -EINVAL;
+	}
+
 	if (!dev_ser) {
 		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
 		return -EINVAL;
@@ -547,6 +552,11 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
 		return -EINVAL;
 	}
 
+	if (dev->liveupdate.frozen) {
+		pci_warn(dev, "Cannot preserve device after it is frozen!\n");
+		return -EINVAL;
+	}
+
 	if (!dev->liveupdate.outgoing) {
 		struct pci_dev_ser *dev_ser;
 
@@ -797,6 +807,12 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 		pci_WARN(dev, 1, "Destroying incoming-preserved device!\n");
 }
 
+void pci_liveupdate_freeze(struct pci_dev *dev)
+{
+	guard(rwsem_write)(&pci_liveupdate.rwsem);
+	dev->liveupdate.frozen = true;
+}
+
 static int pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *dev)
 {
 	if (!dev->liveupdate.incoming) {
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index 90b2754ecc0c..5aac19f7bee6 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -13,6 +13,7 @@
 #ifdef CONFIG_PCI_LIVEUPDATE
 void pci_liveupdate_setup_device(struct pci_dev *dev);
 void pci_liveupdate_cleanup_device(struct pci_dev *dev);
+void pci_liveupdate_freeze(struct pci_dev *dev);
 bool pci_liveupdate_preserve_bus_numbers(void);
 bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus, struct pci_dev *dev);
 int pci_liveupdate_adopt_acs(struct pci_dev *dev);
@@ -26,6 +27,10 @@ static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 {
 }
 
+static inline void pci_liveupdate_freeze(struct pci_dev *dev)
+{
+}
+
 static inline bool pci_liveupdate_preserve_bus_numbers(void)
 {
 	return false;
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e16aa59dd7ac..dff60a03204f 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -21,6 +21,7 @@
 #include <linux/acpi.h>
 #include <linux/dma-map-ops.h>
 #include <linux/iommu.h>
+#include "liveupdate.h"
 #include "pci.h"
 #include "pcie/portdrv.h"
 
@@ -559,6 +560,7 @@ static void pci_device_shutdown(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = pci_dev->driver;
 
+	pci_liveupdate_freeze(pci_dev);
 	pm_runtime_resume(dev);
 
 	if (drv && drv->shutdown)
diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
index d45a5b524909..bb79348769b7 100644
--- a/include/linux/pci_liveupdate.h
+++ b/include/linux/pci_liveupdate.h
@@ -21,11 +21,14 @@
  *                set up, i.e. it was matched to state preserved by the previous
  *                kernel. Unlike @incoming, this is never cleared, so it stays
  *                true after the device finishes participating in Live Update.
+ * @frozen: True if the outgoing preservation status of this device is frozen
+ *          and thus cannot be changed.
  */
 struct pci_liveupdate {
 	struct pci_dev_ser *outgoing;
 	struct pci_dev_ser *incoming;
 	bool was_incoming;
+	bool frozen;
 };
 
 struct pci_dev;
-- 
2.55.0.1082.g2b9226bbc0-goog


