Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BFDCD6E7C
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 12:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=58P1q1XUXWtvX8VsXYXNzBZuVvbe3GtJn7syrrjTljc=; b=F2xIE/iy6XQYkYC4806UnuQ4yo
	leSwEcxRIe7w+dbwsM8h12YMWdIF1eDbbOeE77c7DQg/egg8AMJRDhEXN43g1tZDLEXv4TH49q5wp
	rhZy1dG66u2ScMTI+XZ0rUpogG3sktAxKfiFhw274JWs+U2YS+zCypAeQjmlnV4ZmGkvca6YWQ4jz
	+JrYBzyEROUUk1dQKHNIUCYYil9DBfElvKs3LrHLXmGzD0x/pk/Japi5Bc2edpXtbRsCXlHqx/RBW
	eTI26CiYo6GXx029hcRRBmcmIPZUgvX9ihLxFJkZcdQ3XCDySSoj8mCeL4DcpW+exTLuOtAfHhcnj
	xSuOCI1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVTO0-00000000ayq-37bO;
	Fri, 05 Jun 2026 12:10:52 +0000
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVTNy-00000000ayP-1wf9
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 12:10:51 +0000
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-490b5d2e394so14031715e9.3
        for <kexec@lists.infradead.org>; Fri, 05 Jun 2026 05:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780661448; x=1781266248; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=58P1q1XUXWtvX8VsXYXNzBZuVvbe3GtJn7syrrjTljc=;
        b=wKJ8Newm5T3F8qFYCSf2CJCzfD0Z8pdZ0xHZV78hpgygpFIO1/u8RQP7G7IAVrTpDx
         riMPHwuzz60JdSSShHdPco1BR9BrFKR3UD4ysOzj4BlTsyyiOjbaYjuWz2wmtHYunkIX
         O4wa6yjEMigdToqTyjJ1psFFagPzSx5rgQKLH0h9Oi3hhRJ3b/ZKkrcxwfF8LPnmDU1r
         XYMY4rwFqhXcXUhMlYBHPHkvW57KtXY03KP8xOsf2LgXpNM+pnGnvZDvWFV2u+hMeyYc
         PIpN7kEbK7tJr86jwpx3QQAVd0+i4qxWuEt9iCkVobzwz0RtkIEH0w2s7EDeNI6xEGgw
         LY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780661448; x=1781266248;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=58P1q1XUXWtvX8VsXYXNzBZuVvbe3GtJn7syrrjTljc=;
        b=eceHsQ0dc057JjyRtrfqjM7zPVMSRcz2IIUcshe2Z0HglHFcCvV+o3ayx2EpOEBqU8
         Dl4AHwZ1sGvA3dfFiC2HAHvQzvHeXuaYd5knjp1TbvCsFlxP5EweFIMug26DpyGxdX0Y
         ZUQ0Ze/ji3VNk7zHuPIGF/KVlRmwgbcWmQDJ7D1UglYITVg6g/GbY6T2JxPJ9g+D1IWh
         Wag6R/MoHAaQnJxamXf9xqgSV7zZOq6qzZWBIEsJ/XoxwZ5F2o9rMtP8dhSbPHT5s3lb
         9NH7UNAI5EkZaTdpUkxxziNnS+HPhUfxUzMSm5n8np6dHvNIyu9vSNhiwJB795+xhrqk
         J/Qg==
X-Forwarded-Encrypted: i=1; AFNElJ/jdE87TMXnAPfPBfRtQjH9NX/VJxo1Seay1csa9NX/wB6HGDrRTjykixuhaefeLAh1ZOnuMg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyCSUQbFHx+ocaKRa/R8KkmuT4y7JGoY4Yj+MgZSVGHnKaBOIbk
	1zD9zq505t9ILuQruMpJLx1VXog8RlyZofO0LQ+Wg5VJQdt28ZxgI0d4T/pT00LQmZ0gF4rYoO1
	jejsQScWh2d9iMolpGjsjIg==
X-Received: from wmoq17.prod.google.com ([2002:a05:600c:46d1:b0:490:beee:59ba])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:81c9:b0:490:b724:507d with SMTP id 5b1f17b1804b1-490c259f6e2mr43633315e9.11.1780661447497;
 Fri, 05 Jun 2026 05:10:47 -0700 (PDT)
Date: Fri,  5 Jun 2026 14:10:40 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605121040.1177072-1-mclapinski@google.com>
Subject: [PATCH v2] pstore: add a KHO backend
From: Michal Clapinski <mclapinski@google.com>
To: Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260605_051050_555860_2833B549 
X-CRM114-Status: GOOD (  26.81  )
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

Up to this point to preserve late shutdown logs in memory, users had to
predefine a memory region using ramoops. This commit changes this by
preserving a buffer using kexec-handover.

pstore_kho supports preserving only 1 dmesg buffer.
It gets replaced with the new buffer on every kexec, so the user has to
copy the file out of pstore after every kexec.
There is no erase() support.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
v2:
- Added a comment explaining the benefits of pstore_kho.
- Created include/linux/kho/abi/pstore.h.
- Got rid of the KHO subtree.
- Made sure never to free incoming kho data.
  This way the module can be safely reloaded.
- Sashiko complained that I trust the data coming from the old kernel.
  I ignored it. LMK if I shouldn't trust the old kernel.
---
 fs/pstore/Kconfig              |  10 ++
 fs/pstore/Makefile             |   2 +
 fs/pstore/pstore_kho.c         | 230 +++++++++++++++++++++++++++++++++
 include/linux/kho/abi/pstore.h |  27 ++++
 4 files changed, 269 insertions(+)
 create mode 100644 fs/pstore/pstore_kho.c
 create mode 100644 include/linux/kho/abi/pstore.h

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 3acc38600cd1..455790fec955 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -81,6 +81,16 @@ config PSTORE_RAM
 
 	  For more information, see Documentation/admin-guide/ramoops.rst.
 
+config PSTORE_KHO
+	tristate "Preserve logs over kexec"
+	depends on PSTORE
+	depends on KEXEC_HANDOVER
+	help
+	  A pstore backend for preserving dmesg over KHO (kexec handover).
+	  It does not require any additional cmdline params to work.
+
+	  It supports preservation of only 1 dmesg file.
+
 config PSTORE_ZONE
 	tristate
 	depends on PSTORE
diff --git a/fs/pstore/Makefile b/fs/pstore/Makefile
index c270467aeece..518cd408bf8e 100644
--- a/fs/pstore/Makefile
+++ b/fs/pstore/Makefile
@@ -13,6 +13,8 @@ pstore-$(CONFIG_PSTORE_PMSG)	+= pmsg.o
 ramoops-objs += ram.o ram_core.o
 obj-$(CONFIG_PSTORE_RAM)	+= ramoops.o
 
+obj-$(CONFIG_PSTORE_KHO)	+= pstore_kho.o
+
 pstore_zone-objs += zone.o
 obj-$(CONFIG_PSTORE_ZONE)	+= pstore_zone.o
 
diff --git a/fs/pstore/pstore_kho.c b/fs/pstore/pstore_kho.c
new file mode 100644
index 000000000000..6d4187d91642
--- /dev/null
+++ b/fs/pstore/pstore_kho.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KHO (Kexec Handover) backend for pstore.
+ *
+ * KHO-based pstore provides a mechanism to hand over pstore data (specifically
+ * dmesg logs) from one kernel to another across a kexec reboot using the
+ * Kexec Handover (KHO) framework.
+ *
+ * Key advantages of KHO-based pstore include:
+ * - No hardcoded memmap: Unlike ramoops, it does not require reserving a static
+ *   memory region in the bootloader or device tree. Memory is allocated
+ *   dynamically and handed over to the next kernel.
+ * - Firmware independence: It does not rely on platform firmware support (like
+ *   ACPI ERST or UEFI variable storage) to preserve logs across reboots.
+ * - High throughput: It avoids the performance bottlenecks of serial consoles,
+ *   not being limited by console baud rates.
+ * - Complete log preservation: It preserves all dmesg logs, including those
+ *   generated late in the reboot cycle after filesystems have been unmounted,
+ *   up to the point of the kexec jump.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kho/abi/pstore.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kexec_handover.h>
+#include <linux/module.h>
+#include <linux/pstore.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+/*
+ * The in and out buffers are separate and they need not be the same size.
+ * Therefore, this is not part of ABI.
+ */
+#define RECORD_MAX_SIZE		(1 << CONFIG_LOG_BUF_SHIFT)
+
+struct pstore_kho_context {
+	struct pstore_info pstore;
+	bool read_done;
+};
+
+static struct pstore_ser *kho_ser_in;
+static struct pstore_ser *kho_ser_out;
+
+static int pstore_kho_open(struct pstore_info *psi)
+{
+	struct pstore_kho_context *cxt = psi->data;
+
+	cxt->read_done = false;
+	return 0;
+}
+
+static ssize_t pstore_kho_read(struct pstore_record *record)
+{
+	struct pstore_kho_context *cxt = record->psi->data;
+	struct pstore_kho_record *kho_data_in;
+
+	if (cxt->read_done || !kho_ser_in)
+		return 0;
+
+	cxt->read_done = true;
+	kho_data_in = &kho_ser_in->record;
+
+	record->buf = kmemdup(kho_data_in->buf, kho_data_in->size, GFP_KERNEL);
+	if (!record->buf)
+		return -ENOMEM;
+
+	record->type = PSTORE_TYPE_DMESG;
+	record->id = 0;
+	record->size = kho_data_in->size;
+	record->time.tv_sec = kho_data_in->time_sec;
+	record->time.tv_nsec = kho_data_in->time_nsec;
+	record->count = kho_data_in->count;
+	record->reason = kho_data_in->reason;
+	record->part = kho_data_in->part;
+	record->compressed = kho_data_in->compressed;
+
+	return record->size;
+}
+
+static int pstore_kho_write(struct pstore_record *record)
+{
+	struct pstore_kho_record *kho_data_out = &kho_ser_out->record;
+
+	if (record->type != PSTORE_TYPE_DMESG)
+		return -EINVAL;
+
+	if (kho_data_out->size != 0) {
+		pr_err("pstore kho already contains a record\n");
+		return -ENOSPC;
+	}
+
+	if (record->size > RECORD_MAX_SIZE) {
+		pr_err("dmesg record too big, record size: %lu, available space: %d\n",
+		       record->size, RECORD_MAX_SIZE);
+		return -ENOSPC;
+	}
+
+	memcpy(kho_data_out->buf, record->buf, record->size);
+	kho_data_out->size = record->size;
+	kho_data_out->time_sec = record->time.tv_sec;
+	kho_data_out->time_nsec = record->time.tv_nsec;
+	kho_data_out->count = record->count;
+	kho_data_out->reason = record->reason;
+	kho_data_out->part = record->part;
+	kho_data_out->compressed = record->compressed;
+
+	return 0;
+}
+
+static struct pstore_kho_context pstore_kho_cxt = {
+	.pstore = {
+		.owner		= THIS_MODULE,
+		.name		= "kho",
+		.bufsize	= RECORD_MAX_SIZE,
+		.flags		= PSTORE_FLAGS_DMESG,
+		.max_reason	= KMSG_DUMP_SHUTDOWN,
+		.open		= pstore_kho_open,
+		.read		= pstore_kho_read,
+		.write		= pstore_kho_write,
+	},
+};
+
+static void __init kho_setup_incoming(void)
+{
+	phys_addr_t kho_ser_phys;
+	int err;
+
+	err = kho_retrieve_subtree(KHO_PSTORE_FDT_NAME, &kho_ser_phys);
+	if (err) {
+		if (err != -ENOENT)
+			pr_err("failed to retrieve KHO data %s: %d\n",
+			       KHO_PSTORE_FDT_NAME, err);
+		return;
+	}
+
+	kho_ser_in = phys_to_virt(kho_ser_phys);
+
+	if (kho_ser_in->version != KHO_PSTORE_VERSION) {
+		pr_err("unsupported KHO pstore version: %d\n", kho_ser_in->version);
+		kho_ser_in = NULL;
+		return;
+	}
+
+	pr_info("successfully restored preserved data\n");
+}
+
+static int __init kho_setup_outgoing(void)
+{
+	int err;
+	size_t total_size = sizeof(struct pstore_ser) + RECORD_MAX_SIZE;
+
+	kho_ser_out = kho_alloc_preserve(total_size);
+	if (IS_ERR(kho_ser_out)) {
+		pr_err("failed to allocate pstore kho ser anchor\n");
+		return PTR_ERR(kho_ser_out);
+	}
+	memset(kho_ser_out, 0, total_size);
+	kho_ser_out->version = KHO_PSTORE_VERSION;
+
+	err = kho_add_subtree(KHO_PSTORE_FDT_NAME, kho_ser_out);
+	if (err) {
+		pr_err("failed to add KHO data\n");
+		goto err_free_ser;
+	}
+
+	return 0;
+
+err_free_ser:
+	kho_unpreserve_free(kho_ser_out);
+	return err;
+}
+
+static int __init pstore_kho_init(void)
+{
+	int err;
+	struct pstore_kho_context *cxt = &pstore_kho_cxt;
+
+	if (!kho_is_enabled()) {
+		pr_info("KHO is disabled, pstore_kho cannot start\n");
+		return -ENODEV;
+	}
+
+	kho_setup_incoming();
+	err = kho_setup_outgoing();
+	if (err) {
+		pr_err("failed to setup outgoing KHO\n");
+		return err;
+	}
+
+	cxt->pstore.data = cxt;
+	cxt->pstore.buf = kmalloc(cxt->pstore.bufsize, GFP_KERNEL);
+	if (!cxt->pstore.buf) {
+		err = -ENOMEM;
+		goto err_free_outgoing;
+	}
+
+	err = pstore_register(&cxt->pstore);
+	if (err) {
+		pr_err("failed to register with pstore\n");
+		goto err_free_pstore_buf;
+	}
+
+	return 0;
+
+err_free_pstore_buf:
+	kfree(cxt->pstore.buf);
+
+err_free_outgoing:
+	kho_remove_subtree(kho_ser_out);
+	kho_unpreserve_free(kho_ser_out);
+
+	return err;
+}
+module_init(pstore_kho_init);
+
+static void __exit pstore_kho_exit(void)
+{
+	pstore_unregister(&pstore_kho_cxt.pstore);
+	kfree(pstore_kho_cxt.pstore.buf);
+
+	kho_remove_subtree(kho_ser_out);
+	kho_unpreserve_free(kho_ser_out);
+}
+module_exit(pstore_kho_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Pstore backend for dmesg preservation over kexec");
diff --git a/include/linux/kho/abi/pstore.h b/include/linux/kho/abi/pstore.h
new file mode 100644
index 000000000000..743ec64d67fc
--- /dev/null
+++ b/include/linux/kho/abi/pstore.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_KHO_ABI_PSTORE_H
+#define _LINUX_KHO_ABI_PSTORE_H
+
+#include <linux/types.h>
+
+#define KHO_PSTORE_FDT_NAME	"pstore-kho"
+#define KHO_PSTORE_VERSION	1
+
+struct pstore_kho_record {
+	s64			size;
+	s64			time_sec;
+	u32			time_nsec;
+	s32			count;
+	u32			reason;
+	u32			part;
+	u32			compressed;
+	char			buf[];
+};
+
+struct pstore_ser {
+	u32			version;
+	struct pstore_kho_record record;
+};
+
+#endif /* _LINUX_KHO_ABI_PSTORE_H */
-- 
2.54.0.1032.g2f8565e1d1-goog


