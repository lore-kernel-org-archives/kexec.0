Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D14BC4450D
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 15:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S1UFdHONMaUW3i8xUAtShYLn0EA7imz4HjKdEgIKF0Q=; b=GEgRX/zZSCUOwrxRpOc4z8Xhqw
	LW0w90ITSsCmBkcRXK9mKgfQDxdZyl0UpbDJG+/u9SgdVVxQNpT4Qa1GNwSLIVzACswQzz933vMxS
	M1SwM4dv+syziqbvyh6+zJD10KHeoseZEziOTq/OT+DJ8relGAPnQBjP/QVze7t8KlWLBUyXJR7aU
	0AZrlEXVdaQjsrxLF2HjcGIljL5Fg4WV8k/u8GjeAbMl6fDF/kGc3tS9HrhtGIY4AG82A0rlpjcRh
	PdPw8sVtbheHrV4axtYgcg+LFvkB13mi9ixDvIja1Jw7Za+cgIbfRpVqtNzbkOS9GgJerL/zF5zF5
	wfyi1tfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjeqs-0000000CU7j-2Tdx;
	Tue, 14 Jul 2026 15:15:18 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjeqr-0000000CU5M-2WWb
	for kexec@bombadil.infradead.org;
	Tue, 14 Jul 2026 15:15:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=S1UFdHONMaUW3i8xUAtShYLn0EA7imz4HjKdEgIKF0Q=; b=Z90Qm3cC9t5OVedN7mrIRnfMns
	qJ1eAfGpXzLaDFASe72HdNo778XwcKJqN6a/+VUhkWncB9SMkZP1ZyAeEvkzFnM8qn2S3X7qTdHGi
	W8DKjb56sRdoQYFVSeekoWAlFMe1AhWQ+5yPTqvMeL1SuI9LyZqJDqCL5y3caeD8ohqzCibt3LTHN
	N+W/ag3Gf8aDVkU1731JCT2xF4K8pq+WkSN/iSB9OdLRVZ5BdYZqUjO3BUXMQmmCJUID+ybtKsSYe
	G9djP8pN57lUshuDUAd3o5/RwqNI+dQG9kb1nGqYJsdYudkaT33KdW+acPFiViO/7PnlDd+/C5Tvi
	xVBre/Xg==;
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wjeqo-0000000Cd25-34vj
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 15:15:16 +0000
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-84a3514f912so4346645b3a.3
        for <kexec@lists.infradead.org>; Tue, 14 Jul 2026 08:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042112; x=1784646912; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S1UFdHONMaUW3i8xUAtShYLn0EA7imz4HjKdEgIKF0Q=;
        b=fk6iUIBfE/HneraIY1mB79V9WGwvwsVo7KPbx6fxohWWDUp8beWazmTqvJqEDCvPDD
         lGGHUDmhZ5msHa3rPzD45lPmtizOn17qR/tixosEypSLIyVLnReEohe8H0QgbwgBO79V
         /cNql052NV5UDKPLCOJUg6WqxLu6qoYQUj16VWlVmzA5QUUBwVudXRMGJ6BUiaaFMEU/
         nXrmkm+Gcb/xigZ0F9mQHqwsRebKnXZVc5NLaHAnNzo4Xmn6brZz6YYRH1Y0m+Yl8iWA
         zZf+tUN1q1jYKFXnX00n9QeYB9nie4EPqI49zcbRyRetiTqDVkxqglmnIZg6W6NQMUgF
         KgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042112; x=1784646912;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S1UFdHONMaUW3i8xUAtShYLn0EA7imz4HjKdEgIKF0Q=;
        b=pAmO4roAZn/cp55kIF97q1H0vZx0dUjjY5uVpbs1dl809y0DPmDuDb7Q9rHDj6IvZ4
         rMHA0TJQJAQJQXrRDh8iSvIorNSzDyeCzdRIa7QjhLmXaqYxJKjS0TMnloskQTc3mnCr
         nTJAglCTyhwuKU5PJOPh7kO7pFkcXiu2O2I7ShcD7WUBzRvXZ/Wml+BfzFlLS8gnDJ12
         UCC9ICVEHYUXszmGyBTc8PN2uGJI/uYCmYiqQkZMsLWZt1hLCfh0Xsi0vO4vKmR3ujoI
         X7jK5J3uxaDF0CSKMZVFQUFH6JPknOv3lY2jxAGq5/BNpMu7AWu7dLtClrWiDDY+DeS7
         WFbg==
X-Gm-Message-State: AOJu0Yz6lFN+EhgdTQo5TrzCo+PSWFPf6XDsmmz7tDOSoD49QibRqxW1
	1WFa0QzDETnbGrycg+2qH0vmyoHeOS8/eULAx7PsC4iVFiP3IoITf7+jV8zHCTL17hDn82Ygsr7
	N6HvW8S4tmlnhl/RWOVgl33F69T3MUxcTzXADg34eMNTiAiN79hg9FXOT2HliYU9qld3WAxdiVS
	sMRcDMCFYe1Jqw9ZFJRU/6LYJK2hicSP9NkkEnoEhMmITUYg==
X-Received: from pfbdi5.prod.google.com ([2002:a05:6a00:4805:b0:848:4690:d658])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e93:b0:848:19f4:3b52
 with SMTP id d2e1a72fcca58-84a516062d4mr3676620b3a.38.1784042111640; Tue, 14
 Jul 2026 08:15:11 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:14:47 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-3-vipinsh@google.com>
Subject: [PATCH v5 02/20] vfio: Export various helpers from VFIO
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
X-CRM114-CacheID: sfid-20260714_161514_954169_CC0F705D 
X-CRM114-Status: GOOD (  14.34  )
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

The upcoming VFIO live update feature needs to access various helper
functions for its logic which are not exported by default.

Export these functions and variable for other modules to use them.
Remove static from their declaration and add them in
include/linux/vfio.h and drivers/vfio/pci/vfio_pci_priv.h header files.

No functional change intended.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/vfio_pci.c      | 2 +-
 drivers/vfio/pci/vfio_pci_core.c | 6 ++++--
 drivers/vfio/pci/vfio_pci_priv.h | 5 +++++
 drivers/vfio/vfio_main.c         | 3 ++-
 include/linux/vfio.h             | 1 +
 5 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 0c771064c0b8..1fb4b276afe7 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -125,7 +125,7 @@ static int vfio_pci_open_device(struct vfio_device *core_vdev)
 	return 0;
 }
 
-static const struct vfio_device_ops vfio_pci_ops = {
+const struct vfio_device_ops vfio_pci_ops = {
 	.name		= "vfio-pci",
 	.init		= vfio_pci_core_init_dev,
 	.release	= vfio_pci_core_release_dev,
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3c8b990ee92f..f31e59e5badb 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -623,7 +623,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_enable);
 
-static void vfio_pci_core_try_reset(struct vfio_pci_core_device *vdev)
+void vfio_pci_core_try_reset(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
 	struct pci_dev *bridge;
@@ -674,6 +674,7 @@ static void vfio_pci_core_try_reset(struct vfio_pci_core_device *vdev)
 out_restore_state:
 	pci_restore_state(pdev);
 }
+EXPORT_SYMBOL_GPL(vfio_pci_core_try_reset);
 
 void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 {
@@ -1657,7 +1658,7 @@ ssize_t vfio_pci_core_write(struct vfio_device *core_vdev, const char __user *bu
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_write);
 
-static void vfio_pci_zap_bars(struct vfio_pci_core_device *vdev)
+void vfio_pci_zap_bars(struct vfio_pci_core_device *vdev)
 {
 	struct vfio_device *core_vdev = &vdev->vdev;
 	loff_t start = VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_BAR0_REGION_INDEX);
@@ -1666,6 +1667,7 @@ static void vfio_pci_zap_bars(struct vfio_pci_core_device *vdev)
 
 	unmap_mapping_range(core_vdev->inode->i_mapping, start, len, true);
 }
+EXPORT_SYMBOL_GPL(vfio_pci_zap_bars);
 
 void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev)
 {
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index fca9d0dfac90..85bc1666cb0e 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -11,6 +11,8 @@
 /* Cap maximum number of ioeventfds per device (arbitrary) */
 #define VFIO_PCI_IOEVENTFD_MAX		1000
 
+extern const struct vfio_device_ops vfio_pci_ops;
+
 struct vfio_pci_ioeventfd {
 	struct list_head	next;
 	struct vfio_pci_core_device	*vdev;
@@ -73,6 +75,9 @@ u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev);
 void vfio_pci_memory_unlock_and_restore(struct vfio_pci_core_device *vdev,
 					u16 cmd);
 
+void vfio_pci_zap_bars(struct vfio_pci_core_device *vdev);
+void vfio_pci_core_try_reset(struct vfio_pci_core_device *vdev);
+
 #ifdef CONFIG_VFIO_PCI_IGD
 bool vfio_pci_is_intel_display(struct pci_dev *pdev);
 int vfio_pci_igd_init(struct vfio_pci_core_device *vdev);
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 5e0422014523..2437af031169 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1467,7 +1467,7 @@ const struct file_operations vfio_device_fops = {
 #endif
 };
 
-static struct vfio_device *vfio_device_from_file(struct file *file)
+struct vfio_device *vfio_device_from_file(struct file *file)
 {
 	struct vfio_device_file *df = file->private_data;
 
@@ -1475,6 +1475,7 @@ static struct vfio_device *vfio_device_from_file(struct file *file)
 		return NULL;
 	return df->device;
 }
+EXPORT_SYMBOL_GPL(vfio_device_from_file);
 
 /**
  * vfio_file_is_valid - True if the file is valid vfio file
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 31b826efba00..cf0d941d0410 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -378,6 +378,7 @@ static inline bool vfio_file_has_dev(struct file *file, struct vfio_device *devi
 bool vfio_file_is_valid(struct file *file);
 bool vfio_file_enforced_coherent(struct file *file);
 void vfio_file_set_kvm(struct file *file, struct kvm *kvm);
+struct vfio_device *vfio_device_from_file(struct file *file);
 
 #define VFIO_PIN_PAGES_MAX_ENTRIES	(PAGE_SIZE/sizeof(unsigned long))
 
-- 
2.55.0.795.g602f6c329a-goog


