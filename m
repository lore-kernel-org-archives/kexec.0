Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AC9C4450B
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 15:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OET28Pw7Tm9U8SptXyUJqzCGyMYvQ/PVMzqx3Tt4yN8=; b=3ZhHxsHG9bH6wW1lTSMFBH2kxI
	vji4VaGs1tsLs6Y5iwhnbb5TB47olPzHRWbwxv9BIoOs4mrOPajYti/lM/yVnJzJQRV/0CzSH3uTp
	29Ew0+VZghTv10LEwcFyccACHMYpSFafmZgKQ9Lp9oLE0pDlqrCZRZ0Nx4+u7t444hLF0gUEecmlh
	mVe7m/yCNf9FGXcuVqMGrHFaRwVD4FVJ7Py6ZzC7JEdpnPUVQ2SzSSUBUQ9p5Ge1diE3F/aDoe4Ii
	OCVPrMliJAqxN/0QjhqJbnkzwni538MJF/blbWYetYj9vKXxcL7S7M4YvWiXSM4JBXDDhsUMzK8DQ
	VqsLImXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjeqp-0000000CU3O-0PmW;
	Tue, 14 Jul 2026 15:15:15 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjeqm-0000000CU1x-1yGf
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 15:15:13 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2cacd6d37edso63564995ad.0
        for <kexec@lists.infradead.org>; Tue, 14 Jul 2026 08:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042111; x=1784646911; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OET28Pw7Tm9U8SptXyUJqzCGyMYvQ/PVMzqx3Tt4yN8=;
        b=KsxyBldjlJu6wlxfUo6anRwj681EsWA3iS5Dpgf+uwXfNdnJoitistT1KKpQBkuzTN
         OBkwvhG8JO2AlBGf/QQmnMEFYm+EeAfBJ3iuFIWGf5lwMlSQPZL4mmOyySWMRrpY+z2+
         SRTcAjcGTJQQT2Ogo4QlkAWXfqwqnIQJDOxyUxfkEV+HDfAxrDlcZbJ1GpnWNey7EVwY
         IKz648XePDU+QirfOi2DIQO2pMwDO/MP2UGODraQexKHNHcZ7y7krSY7ptDGfQlUIogv
         hJhDR2woDGGpiyHr2+X53QXWjVl9jTG9bAsM9YSNDA+wMXvDaB/Gkm5VIdnbb0bQM22r
         j3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042111; x=1784646911;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OET28Pw7Tm9U8SptXyUJqzCGyMYvQ/PVMzqx3Tt4yN8=;
        b=ffKM1yF5/5zYeeanVAM7fA95s+VmrdpQ7B2EYH9eOs6K0xaxqEGYifxf38PPfSakWt
         EXq3bVNRvnwTc0eQ7kRv9LJ30s4Boz7AHkP0zBSPEVGLw9ieLin0Q3kGBK2kS+6B0Tt7
         7wpBwRp4eK34suxkjtMH9RUSKoltQdydLGqUa7AqeC80J9dyaeTAeRFjA2+Jr9kdGmXa
         jePrJ+NZKbpQvO7qKdI32X8HYEtwdtK9ocRTdf3myvE2IVE+GNq9pHNfqEbz9gjfr+6o
         SS2FClT7hG2rucojSVrBQ6+BfqsSL0FqZBA+4l/hkU1ai3pt5B0TrCqCZLi0BPyOHjbc
         i+Fg==
X-Gm-Message-State: AOJu0YyudqyXoPSb1RZXhGPYL3mOU6KTsHmipMc0Gzj3lB5cz2BKt6y0
	UUuIgBKYjB1hEJ/S8a8oPfTv26xoKZo9Cd5B3125wCxjcvUSL21UKnn65/yLBa/7FDS4NN+N4t2
	GzIh5C4ULmDoqatLFmyFiJhzLknivVps1aHHu3ysh8o9Kq8HupoyIOMpv6pZ6CNe+NuCDWirFKP
	dFPXYq26S6p5Uyg7mj3rvUp8KiGTiNEiKq4vji7KsAdfnQKg==
X-Received: from pldu11.prod.google.com ([2002:a17:903:108b:b0:2c7:e06e:86f6])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b85:b0:2c9:ae0b:61e3
 with SMTP id d9443c01a7336-2ce9e9a6ed8mr116458815ad.2.1784042110624; Tue, 14
 Jul 2026 08:15:10 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:14:46 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-2-vipinsh@google.com>
Subject: [PATCH v5 01/20] vfio/pci: Factor out the reset logic in VFIO PCI
 device close path
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rientjes@google.com, rodrigo.vivi@intel.com, 
	rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vipinsh@google.com, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, 
	yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_081512_519399_723153B7 
X-CRM114-Status: GOOD (  18.53  )
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

vfio_pci_core_disable() is a very long function doing multiple things
like exiting runtime power management, setting device to D0 power,
clearing bus master, clearing irqs, freeing eventfds, releasing device
regions, unmapping PCI bars, and performing device/bus resets.

The upcoming VFIO Liveupdate feature will also need to utilize same
reset logic.

Extract device reset code to a new helper function,
vfio_pci_core_try_reset(), and update vfio_pci_core_disable() to use
this new function.

No functional change intended.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 100 ++++++++++++++++---------------
 1 file changed, 53 insertions(+), 47 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index a28f1e99362c..3c8b990ee92f 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -623,9 +623,60 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_enable);
 
-void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
+static void vfio_pci_core_try_reset(struct vfio_pci_core_device *vdev)
 {
+	struct pci_dev *pdev = vdev->pdev;
 	struct pci_dev *bridge;
+
+	vdev->needs_reset = true;
+
+	/*
+	 * If we have saved state, restore it.  If we can reset the device,
+	 * even better.  Resetting with current state seems better than
+	 * nothing, but saving and restoring current state without reset
+	 * is just busy work.
+	 */
+	if (pci_load_and_free_saved_state(pdev, &vdev->pci_saved_state)) {
+		pci_info(pdev, "%s: Couldn't reload saved state\n", __func__);
+
+		if (!vdev->reset_works)
+			return;
+
+		pci_save_state(pdev);
+	}
+
+	/*
+	 * Disable INTx and MSI, presumably to avoid spurious interrupts
+	 * during reset.  Stolen from pci_reset_function()
+	 */
+	pci_write_config_word(pdev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
+
+	/*
+	 * Try to get the locks ourselves to prevent a deadlock. The
+	 * success of this is dependent on being able to lock the device,
+	 * which is not always possible.
+	 * We can not use the "try" reset interface here, which will
+	 * overwrite the previously restored configuration information.
+	 */
+	if (vdev->reset_works) {
+		bridge = pci_upstream_bridge(pdev);
+		if (bridge && !pci_dev_trylock(bridge))
+			goto out_restore_state;
+		if (pci_dev_trylock(pdev)) {
+			if (!__pci_reset_function_locked(pdev))
+				vdev->needs_reset = false;
+			pci_dev_unlock(pdev);
+		}
+		if (bridge)
+			pci_dev_unlock(bridge);
+	}
+
+out_restore_state:
+	pci_restore_state(pdev);
+}
+
+void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
+{
 	struct pci_dev *pdev = vdev->pdev;
 	struct vfio_pci_dummy_resource *dummy_res, *tmp;
 	struct vfio_pci_ioeventfd *ioeventfd, *ioeventfd_tmp;
@@ -700,54 +751,9 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 		kfree(dummy_res);
 	}
 
-	vdev->needs_reset = true;
-
 	vfio_pci_zdev_close_device(vdev);
 
-	/*
-	 * If we have saved state, restore it.  If we can reset the device,
-	 * even better.  Resetting with current state seems better than
-	 * nothing, but saving and restoring current state without reset
-	 * is just busy work.
-	 */
-	if (pci_load_and_free_saved_state(pdev, &vdev->pci_saved_state)) {
-		pci_info(pdev, "%s: Couldn't reload saved state\n", __func__);
-
-		if (!vdev->reset_works)
-			goto out;
-
-		pci_save_state(pdev);
-	}
-
-	/*
-	 * Disable INTx and MSI, presumably to avoid spurious interrupts
-	 * during reset.  Stolen from pci_reset_function()
-	 */
-	pci_write_config_word(pdev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
-
-	/*
-	 * Try to get the locks ourselves to prevent a deadlock. The
-	 * success of this is dependent on being able to lock the device,
-	 * which is not always possible.
-	 * We can not use the "try" reset interface here, which will
-	 * overwrite the previously restored configuration information.
-	 */
-	if (vdev->reset_works) {
-		bridge = pci_upstream_bridge(pdev);
-		if (bridge && !pci_dev_trylock(bridge))
-			goto out_restore_state;
-		if (pci_dev_trylock(pdev)) {
-			if (!__pci_reset_function_locked(pdev))
-				vdev->needs_reset = false;
-			pci_dev_unlock(pdev);
-		}
-		if (bridge)
-			pci_dev_unlock(bridge);
-	}
-
-out_restore_state:
-	pci_restore_state(pdev);
-out:
+	vfio_pci_core_try_reset(vdev);
 	pci_disable_device(pdev);
 
 	vfio_pci_dev_set_try_reset(vdev->vdev.dev_set);
-- 
2.55.0.795.g602f6c329a-goog


