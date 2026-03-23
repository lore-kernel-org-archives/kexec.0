Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4837AF532C0
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 23:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YCGcH5x5HW+NRzEKEkZIp2gqKlZo/LGIoKmQ3sM/JLo=; b=ZvGbJaP8E1I9BEcgfZOQO+vrT9
	EH0fkjsHbhCGxX44b9DdQyL8RkqHMGhPNLBuGYlt/T/BNQw1KhQ1o2MNNFnu5WmjYIUl2RprwaQTb
	rZFQFYQx4oTraUX5hQWY5pthvZDKqYtNxAz/d28vIjqx7T72nRFQSlchXC+bWtyHK0ALeGoVP6mKa
	pDCCenhqQmOTv3Y6QX+Mgr3NFzB6urcvFebmTn9TU+IgV5ujhNtSPVw9i43UWUtja+pnXSggnGbsS
	Ro5QeqgAnrI2DDQvCz3M04JqZSnGbFmXJg8FppZQYbtMMolp+35d1zBF6EG06KT8DYmhWudMOkXQi
	xLkrkPnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAa-00000000BOU-2crO;
	Mon, 23 Mar 2026 23:58:52 +0000
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAX-00000000BKP-1bkM
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 23:58:51 +0000
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-35b9333cbfbso2760859a91.2
        for <kexec@lists.infradead.org>; Mon, 23 Mar 2026 16:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310328; x=1774915128; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YCGcH5x5HW+NRzEKEkZIp2gqKlZo/LGIoKmQ3sM/JLo=;
        b=Hlyl96eNKs4pXK1Fpj1JIhMscagjIxIEJnd3DPr+8Zi7f7vSY+8F3HMrlgVYIMXi5m
         GWAeu1PvCHwKE63/fnfA/lTTrtcsUfvRGjQ3cbmrL+933J9DbMsz29PvXLLBDqQFgQC3
         NCznmkP9r6ucSwWinPmqB9WYy7HsZMad8dfRKjcsZVr27mLJEwNMLiz1dK/W61QbgD4A
         Zx1YdWYLyhEKA0cYxpMqvbAIsr9ji5/CCiU9TABN1MEM3r8X3qLByMPsxaG6wKiwbf8V
         A8CMllpbT8Hk7DRzQ1lUVVNhDuzvtFmJqFz5ze0E76Jc20QuuV5TvnBLpzMxzWknvK7C
         in5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310328; x=1774915128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCGcH5x5HW+NRzEKEkZIp2gqKlZo/LGIoKmQ3sM/JLo=;
        b=i7G6M1w3hD1QqBttK88IdQKz3Sk0H5fgDujc7zu69a8V0BdOcgi1a5ggpMnaaM5M+1
         bfuvjckWF+i3fjTSnzfaN4MdfA/bj3hCcSQQOrMnHfF5rydjEdf9f+XxLh5hl4PbQsnw
         IXo+BHA9zQEqLWtYjtnoXI3pm41GWSFSInh9bV9TnO6+hTcZT7h/Q5AwSa2GfcKTKJli
         fRM34dJghK/76kBHr0/kHf2d3ZPDserOfAmn9uCaALh7n9b2GPFYVx6uKI9e+IVPfKi7
         1/BDQuFL05geNS1MurPeTE7/la+6BET6W8JPV4UBkbib/M6pMi7LMuG63JkWTjKsbjy2
         FXTg==
X-Forwarded-Encrypted: i=1; AJvYcCVq/ZY+XWAccD33XdtiIDLK7HZIG+5WeQDLD7X9Opfvx3jwp0QkWDofJgXRsmD9tqcT9Bog9Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YyQHDgEz+XypGyy4jx/XzzklOyMoSwAGHBgcISEn8ZgX8m7bFdW
	gAJpuHp1MNNMw42/IfSdHMT5dxaRvuktgEs8HjRiMkzGZ8TF3yWQ7LkgPuCneevYeTDn9+ygA09
	FXwF53J5LIfa8Iw==
X-Received: from pjvp18.prod.google.com ([2002:a17:90a:df92:b0:35b:9822:9f79])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1a8a:b0:359:f43d:4a6e with SMTP id 98e67ed59e1d1-35bd2996301mr12903584a91.0.1774310327594;
 Mon, 23 Mar 2026 16:58:47 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:57:58 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-7-dmatlack@google.com>
Subject: [PATCH v3 06/24] vfio/pci: Register a file handler with Live Update Orchestrator
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
X-CRM114-CacheID: sfid-20260323_165849_998796_EB542A48 
X-CRM114-Status: GOOD (  28.85  )
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

From: Vipin Sharma <vipinsh@google.com>

Register a live update file handler for vfio-pci device files. Add stub
implementations of all required callbacks so that registration does not
fail (i.e. to avoid breaking git-bisect).

This file handler will be extended in subsequent commits to enable a
device bound to vfio-pci to run without interruption while the host is
going through a kexec Live Update.

Put this support behind a new Kconfig VFIO_PCI_LIVEUPDATE that is marked
experimental and default-disabled until more of the device preservation
support has landed in the kernel.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 MAINTAINERS                            |  1 +
 drivers/vfio/pci/Kconfig               | 11 ++++
 drivers/vfio/pci/Makefile              |  1 +
 drivers/vfio/pci/vfio_pci.c            | 12 ++++-
 drivers/vfio/pci/vfio_pci_liveupdate.c | 69 ++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h       | 14 ++++++
 include/linux/kho/abi/vfio_pci.h       | 28 +++++++++++
 7 files changed, 135 insertions(+), 1 deletion(-)
 create mode 100644 drivers/vfio/pci/vfio_pci_liveupdate.c
 create mode 100644 include/linux/kho/abi/vfio_pci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 96ea84948d76..a16a7ecc67a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27685,6 +27685,7 @@ F:	Documentation/ABI/testing/debugfs-vfio
 F:	Documentation/ABI/testing/sysfs-devices-vfio-dev
 F:	Documentation/driver-api/vfio.rst
 F:	drivers/vfio/
+F:	include/linux/kho/abi/vfio_pci.h
 F:	include/linux/vfio.h
 F:	include/linux/vfio_pci_core.h
 F:	include/uapi/linux/vfio.h
diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 1e82b44bda1a..8f087f7b58c3 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -58,6 +58,17 @@ config VFIO_PCI_ZDEV_KVM
 config VFIO_PCI_DMABUF
 	def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
 
+config VFIO_PCI_LIVEUPDATE
+	bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
+	depends on VFIO_PCI && PCI_LIVEUPDATE
+	help
+	  Support for preserving devices bound to vfio-pci across a Live
+	  Update. This option should only be enabled by developers working on
+	  implementing this support. Once enough support has landed in the
+	  kernel, this option will no longer be marked EXPERIMENTAL.
+
+	  If you don't know what to do here, say N.
+
 source "drivers/vfio/pci/mlx5/Kconfig"
 
 source "drivers/vfio/pci/hisilicon/Kconfig"
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index e0a0757dd1d2..f462df61edb9 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
 
 vfio-pci-y := vfio_pci.o
 vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
+vfio-pci-$(CONFIG_VFIO_PCI_LIVEUPDATE) += vfio_pci_liveupdate.o
 obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
 
 obj-$(CONFIG_MLX5_VFIO_PCI)           += mlx5/
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 0c771064c0b8..41dcbe4ace67 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -170,6 +170,7 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	ret = vfio_pci_core_register_device(vdev);
 	if (ret)
 		goto out_put_vdev;
+
 	return 0;
 
 out_put_vdev:
@@ -264,10 +265,14 @@ static int __init vfio_pci_init(void)
 
 	vfio_pci_core_set_params(nointxmask, is_disable_vga, disable_idle_d3);
 
+	ret = vfio_pci_liveupdate_init();
+	if (ret)
+		return ret;
+
 	/* Register and scan for devices */
 	ret = pci_register_driver(&vfio_pci_driver);
 	if (ret)
-		return ret;
+		goto err_liveupdate_cleanup;
 
 	vfio_pci_fill_ids();
 
@@ -275,12 +280,17 @@ static int __init vfio_pci_init(void)
 		pr_warn("device denylist disabled.\n");
 
 	return 0;
+
+err_liveupdate_cleanup:
+	vfio_pci_liveupdate_cleanup();
+	return ret;
 }
 module_init(vfio_pci_init);
 
 static void __exit vfio_pci_cleanup(void)
 {
 	pci_unregister_driver(&vfio_pci_driver);
+	vfio_pci_liveupdate_cleanup();
 }
 module_exit(vfio_pci_cleanup);
 
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
new file mode 100644
index 000000000000..5ea5af46b159
--- /dev/null
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Vipin Sharma <vipinsh@google.com>
+ * David Matlack <dmatlack@google.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kho/abi/vfio_pci.h>
+#include <linux/liveupdate.h>
+#include <linux/errno.h>
+
+#include "vfio_pci_priv.h"
+
+static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
+					     struct file *file)
+{
+	return false;
+}
+
+static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
+{
+	return -EOPNOTSUPP;
+}
+
+static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
+{
+}
+
+static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
+{
+	return -EOPNOTSUPP;
+}
+
+static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *args)
+{
+}
+
+static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
+	.can_preserve = vfio_pci_liveupdate_can_preserve,
+	.preserve = vfio_pci_liveupdate_preserve,
+	.unpreserve = vfio_pci_liveupdate_unpreserve,
+	.retrieve = vfio_pci_liveupdate_retrieve,
+	.finish = vfio_pci_liveupdate_finish,
+	.owner = THIS_MODULE,
+};
+
+static struct liveupdate_file_handler vfio_pci_liveupdate_fh = {
+	.ops = &vfio_pci_liveupdate_file_ops,
+	.compatible = VFIO_PCI_LUO_FH_COMPATIBLE,
+};
+
+int __init vfio_pci_liveupdate_init(void)
+{
+	int ret;
+
+	ret = liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
+	if (ret && ret != -EOPNOTSUPP)
+		return ret;
+
+	return 0;
+}
+
+void vfio_pci_liveupdate_cleanup(void)
+{
+       liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
+}
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 27ac280f00b9..cbf46e09da30 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -133,4 +133,18 @@ static inline void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev,
 }
 #endif
 
+#ifdef CONFIG_VFIO_PCI_LIVEUPDATE
+int __init vfio_pci_liveupdate_init(void);
+void vfio_pci_liveupdate_cleanup(void);
+#else
+static inline int vfio_pci_liveupdate_init(void)
+{
+	return 0;
+}
+
+static inline void vfio_pci_liveupdate_cleanup(void)
+{
+}
+#endif /* CONFIG_VFIO_PCI_LIVEUPDATE */
+
 #endif
diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
new file mode 100644
index 000000000000..e2412b455e61
--- /dev/null
+++ b/include/linux/kho/abi/vfio_pci.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Vipin Sharma <vipinsh@google.com>
+ * David Matlack <dmatlack@google.com>
+ */
+
+#ifndef _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
+#define _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
+
+/**
+ * DOC: VFIO PCI Live Update ABI
+ *
+ * VFIO uses the ABI defined below for preserving device files across a kexec
+ * reboot using LUO.
+ *
+ * Device metadata is serialized into memory which is then handed to the next
+ * kernel via KHO.
+ *
+ * This interface is a contract. Any modification to any of the serialization
+ * structs defined here constitutes a breaking change. Such changes require
+ * incrementing the version number in the VFIO_PCI_LUO_FH_COMPATIBLE string.
+ */
+
+#define VFIO_PCI_LUO_FH_COMPATIBLE "vfio-pci-v1"
+
+#endif /* _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H */
-- 
2.53.0.983.g0bb29b3bc5-goog


