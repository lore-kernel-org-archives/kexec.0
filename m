Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F3CF532C1
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 23:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i6NpvLJAkS4c52+WboP6wAkf2PbPQKSMM3U4nd1tgoo=; b=tFKPwlHE62eIDn0mVmj+nk3VyF
	LQ9LdVMzbArTnGw5utI1GtANFrmA6xJ+YRxdf/uUiv/9yIuMCRgfbFh0ooU3+ZNBAIreKCNCVbtAG
	DeBpHFiyaMiCtK6ubXC9TiiweVfrroasBdReTF54eBIaqZJYewcSGJ8N3gqUu2jIBcIsi/aAVBL7X
	hVJcJaki4m1vBoX7tcMVGh3RrN6IxvytPYHtRzxs/CHXdWB3i565JWeIPeSFAJHPGms3XRLMU5q4c
	pH+euSOzsQ9WtU8Ixy/dhay8esvdC4wxXezzPnaRtOZIwfAJFuZZvltr33u/4snTHc/ReG9SmGJLv
	F6iPjpUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAm-00000000BeE-3jFs;
	Mon, 23 Mar 2026 23:59:04 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAg-00000000BWI-19EB
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 23:59:03 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2b061868724so3415365ad.1
        for <kexec@lists.infradead.org>; Mon, 23 Mar 2026 16:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310337; x=1774915137; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i6NpvLJAkS4c52+WboP6wAkf2PbPQKSMM3U4nd1tgoo=;
        b=HFSwFafYzV3A4twwIr5aS/gT5qUK29wl5m9oHTuSI6VMURb2RhSqXMeGJwsrSe99fJ
         q9DPzU87/PuBjUDh6wITRhe+eUsN4hsO7/ZcMXHG5zjHqsSfQiokL0+qxHepeA87FQvu
         Y+n7uMnoJ6dn1/SKw0VbK+nxk9wLOR9cZIieEHlFsafcLkkKCkeujR15tsOGMLt506jf
         5b+0gj63tU5dI4c91pWSQ1Dnd1NuPN8TEhsBG3RmqXJRxtSWL7a1PgnQL4iEsCPLO1Xl
         iL2IF9bwwAG76hlpFWRqaMfi8HhFWnajw8rkmbeOuER+Q5jNTu/W9gWB1e5fkDvktfRr
         Uviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310337; x=1774915137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6NpvLJAkS4c52+WboP6wAkf2PbPQKSMM3U4nd1tgoo=;
        b=NsbQzpdr/FKGbGSZ5ifEaPftPbH/Q0ykAwel9JSKPy5GrXqDHqEHj1My2j/hVZdJyS
         NwMbZ+3hjwmYjc0KpMW+WYQEV2/xxxUvGtwBTxuJ/A18XNsKxVaSqEh8RbhaxTDRJoT0
         MiCroks06Gk67VBs9jrqzcAfhuERGQjKfm2gxc2L9fFBpy8hgNBHLYMq8IBkob8pFhB3
         IFsDkYwWjQz7KS0qOY//o/WZWx51YlNOLU7Oz/6cpByrqQfMhivRzMXqFEzf/mOfwoKQ
         DaxspmRCk5JgXsZ4TbBjvTW0AZKVatkm+5ACO2OAXBPnVnZzD4zOgY9dScmDCeG5COF4
         6cQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCJAAX9w7Mq6/rIlL8XcgRYNMWmH4uMYegBlNaK6Ry3tq/hHHSD7JaP6hi020MF1WBX+j54w==@lists.infradead.org
X-Gm-Message-State: AOJu0YzMjPGYsK8SoRd2oo4m7/1qrjYF3tB90S1DQU3mn7RoTpGJcYw1
	tk4NrwytvM1Ey9IhS6KWy2fCFkcA9Oxwny4/CXqE0kfDMoiGhWGzbAlvYeTDMRBP1n7c/svMbn3
	qyhEPGxfdx+BAtQ==
X-Received: from plgd12.prod.google.com ([2002:a17:902:cecc:b0:2a8:71ec:6799])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f984:b0:2ae:c795:6b4a with SMTP id d9443c01a7336-2b0826d73f3mr94191885ad.11.1774310336851;
 Mon, 23 Mar 2026 16:58:56 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:58:03 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-12-dmatlack@google.com>
Subject: [PATCH v3 11/24] vfio/pci: Store incoming Live Update state in struct vfio_pci_core_device
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_165858_394013_09D1763D 
X-CRM114-Status: GOOD (  17.28  )
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

Stash a pointer to a device's incoming Live Updated state in struct
vfio_pci_core_device. This will enable subsequent commits to use the
preserved state when initializing the device.

To enable VFIO to safely access this pointer during device enablement,
require that the device is fully enabled before returning true from
can_finish(). This is synchronized by vfio_pci_core.c setting
vdev->liveupdate_incoming_state to NULL under dev_set lock once it's
done using it.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c       |  2 +-
 drivers/vfio/pci/vfio_pci_liveupdate.c | 17 ++++++++++++++++-
 include/linux/vfio_pci_core.h          |  2 ++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 81f941323641..d7c472cf4729 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -568,7 +568,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
 		vdev->has_vga = true;
 
-
+	vdev->liveupdate_incoming_state = NULL;
 	return 0;
 
 out_free_zdev:
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 6f760ace7065..8d6681e1d328 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -226,6 +226,7 @@ static int match_device(struct device *dev, const void *arg)
 static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
 {
 	struct vfio_pci_core_device_ser *ser;
+	struct vfio_pci_core_device *vdev;
 	struct vfio_device *device;
 	struct file *file;
 	int ret = 0;
@@ -246,6 +247,9 @@ static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
 		goto out;
 	}
 
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+	vdev->liveupdate_incoming_state = ser;
+
 	args->file = file;
 out:
 	/* Drop the reference from vfio_find_device() */
@@ -255,7 +259,18 @@ static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
 
 static bool vfio_pci_liveupdate_can_finish(struct liveupdate_file_op_args *args)
 {
-	return args->retrieve_status > 0;
+	struct vfio_pci_core_device *vdev;
+	struct vfio_device *device;
+
+	if (args->retrieve_status <= 0)
+		return false;
+
+	device = vfio_device_from_file(args->file);
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+
+	/* Check that vdev->liveupdate_incoming_state is no longer in use. */
+	guard(mutex)(&device->dev_set->lock);
+	return !vdev->liveupdate_incoming_state;
 }
 
 static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *args)
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 2ebba746c18f..0c508dd8d1ac 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -26,6 +26,7 @@
 #define VFIO_PCI_OFFSET_MASK	(((u64)(1) << VFIO_PCI_OFFSET_SHIFT) - 1)
 
 struct vfio_pci_core_device;
+struct vfio_pci_core_device_ser;
 struct vfio_pci_region;
 struct p2pdma_provider;
 struct dma_buf_attachment;
@@ -142,6 +143,7 @@ struct vfio_pci_core_device {
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
 	struct list_head	dmabufs;
+	struct vfio_pci_core_device_ser *liveupdate_incoming_state;
 };
 
 enum vfio_pci_io_width {
-- 
2.53.0.983.g0bb29b3bc5-goog


