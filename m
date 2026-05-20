Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E0ACD5BA4
	for <kexec@archiver.kernel.org>; Wed, 20 May 2026 17:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0v72zAjpVoNGtu4uzPAqcHvbj8JBWjnbgBGdrtKjqFE=; b=sWFdwzIOTy0B36ixVww5tunX5L
	bz5GD1b5my+phneym8aDTfg1KP0lrEt9DW+ls0wLAiyJ/phCdED4hxJKPzWgEDinrgLIVpFKLZBOH
	R1AxUh3aK05aLQDwysxyvqFAsj8QBbPgBOe7+jT79ao4cF3+yITIYzctifIruUI0tgre9eSpIosYs
	8v/H9HwRLR3Vm2b9CxFbqayj98Bf8aanasyaLLjgGY8vlngRU0KcM27dgewqD158mdRPIzNF2K0bw
	Gu2ZkjYprKXFsg1aNhqtIP5bTVFSa89TkakzXLEBttWuV6Op58hwyojDcNNFaXizcwG9AuvJ2TWxj
	frXQtjJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPkxd-00000005L7d-0VZl;
	Wed, 20 May 2026 17:44:01 +0000
Received: from mail-ej1-x649.google.com ([2a00:1450:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPkxZ-00000005L6X-2H09
	for kexec@lists.infradead.org;
	Wed, 20 May 2026 17:43:59 +0000
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-bd09ec46507so480292966b.0
        for <kexec@lists.infradead.org>; Wed, 20 May 2026 10:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779299035; x=1779903835; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0v72zAjpVoNGtu4uzPAqcHvbj8JBWjnbgBGdrtKjqFE=;
        b=cLHJ/dm8Y1PCO9VlN9WN4VmIVHTOWCst/ythfjXqx1BhPCtN0PZqsqiGWV9LaG6AgG
         XCHouukNGbFi3mxqKPFoB7AK2SNNdgbECuCgEF7SpaXooAMtv2OssfwuFixGPgFGjSpY
         UWtT6VEUGi+59YAsJdWowZBnQ4Iw/xlZVhKhyz07nTjO/KD5NyJ0TVgbvrPXIhbYvpMS
         4BctsSzp5ebwnm4VbXMYMKw13a5Sw91vUHo8P3lHsmCVe6M9k7Rtp7WZCSRt5WCFL1ZV
         +4Z3fr5g6Fw2M9QBu+77oOD1WkZhCN7UEScyjPVH2pqOS2ifE/sAbK7PbgYE/icckOUJ
         1coA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779299035; x=1779903835;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0v72zAjpVoNGtu4uzPAqcHvbj8JBWjnbgBGdrtKjqFE=;
        b=psa0CB2QRBsENYk6HHMTdm3FnwLIyplGe3EW4wl2lpjOMSnMecFqtnhmofJqk05b+D
         UdEcXUKnuajC8aG+WePPuOYZp2UdWPyCGXMgF7D/3/vXA4f9OYnMCPUo2JClrNRbEHZj
         +CEO+VGz4owEBEN27ZEM4xQj4acqI0ymqc85Rwlwz+WybhWs+oqnw/j/RIllkV/9CkuV
         D/rnfaNhvkZKLRktVg2nJLM2dnqUYLwYGv/87jWA98PTH7cBsHniAZMEuXEhJdLtTea+
         zLtWbMCVjFB9EQCYkgK21Lhaj4mi+twqjNArCAYGicF0yf+2DOiqx8GqlGgVR6BlOAMb
         GqAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+FtSmlOJQEsdKGLYUQgYbWu7uytMxNWJ/DvKg3lUQHzpoJwxMsa22xmoyWiwshAl3c1JLNSA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx0fg6L3t0ej56up/eaEPEz+0Ga2Wtqy8+/1YQpqc3dywJ8d6n4
	DZWOeffiwMmardG5COTvNtYUViBVsthh16kwShreV+rgxi4TROulIOROKK86ppw98QtN5PkR/Ta
	hl7jb4W5N4Jrn9uE6XizDeA==
X-Received: from ejcdl17.prod.google.com ([2002:a17:907:9451:b0:bc6:4cec:2704])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:cc03:b0:bdb:a45a:c2de with SMTP id a640c23a62f3a-bdba45acccdmr45497666b.38.1779299034859;
 Wed, 20 May 2026 10:43:54 -0700 (PDT)
Date: Wed, 20 May 2026 19:43:32 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260520174332.921186-1-mclapinski@google.com>
Subject: [PATCH] pstore: add a KHO backend
From: Michal Clapinski <mclapinski@google.com>
To: Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_104357_624481_B53D3D94 
X-CRM114-Status: GOOD (  21.93  )
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

For now it supports preserving only 1 dmesg buffer.
It gets replaced with the new buffer on every kexec, so the user has to
copy the file out of pstore after every kexec.
There is no erase() support.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
 fs/pstore/Kconfig      |   9 ++
 fs/pstore/Makefile     |   2 +
 fs/pstore/pstore_kho.c | 267 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 278 insertions(+)
 create mode 100644 fs/pstore/pstore_kho.c

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 3acc38600cd1..70853799e211 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -81,6 +81,15 @@ config PSTORE_RAM
 
 	  For more information, see Documentation/admin-guide/ramoops.rst.
 
+config PSTORE_KHO
+	tristate "Preserve logs over kexec"
+	depends on PSTORE
+	depends on KEXEC_HANDOVER
+	help
+	  A pstore backend for preserving dmesg over KHO (kexec handover).
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
index 000000000000..3bc679273c8d
--- /dev/null
+++ b/fs/pstore/pstore_kho.c
@@ -0,0 +1,267 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KHO (Kexec Handover) backend for pstore
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kexec_handover.h>
+#include <linux/libfdt.h>
+#include <linux/module.h>
+#include <linux/pstore.h>
+#include <linux/slab.h>
+#include <linux/unaligned.h>
+
+#define KHO_PSTORE_FDT_NAME	"pstore-kho"
+#define KHO_PSTORE_COMPAT	"pstore-kho-v1"
+#define KHO_PSTORE_DATA		"pstore_kho_record"
+
+static const size_t record_max_size = 1 << CONFIG_LOG_BUF_SHIFT;
+
+struct pstore_kho_record {
+	ssize_t			size;
+	struct timespec64	time;
+	int			count;
+	enum kmsg_dump_reason	reason;
+	unsigned int		part;
+	bool			compressed;
+	char			buf[];
+};
+
+struct pstore_kho_context {
+	struct pstore_info pstore;
+	bool read_done;
+};
+
+static struct pstore_kho_record *kho_data_in;
+static struct pstore_kho_record *kho_data_out;
+static void *fdt_out;
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
+
+	if (cxt->read_done)
+		return 0;
+
+	cxt->read_done = true;
+
+	if (!kho_data_in || !kho_data_in->size)
+		return 0;
+
+	record->buf = kmemdup(kho_data_in->buf, kho_data_in->size, GFP_KERNEL);
+	if (!record->buf)
+		return -ENOMEM;
+
+	record->type = PSTORE_TYPE_DMESG;
+	record->id = 0;
+	record->size = kho_data_in->size;
+	record->time = kho_data_in->time;
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
+	if (record->type != PSTORE_TYPE_DMESG)
+		return -EINVAL;
+
+	if (kho_data_out->size != 0) {
+		pr_err("pstore kho already contains a record\n");
+		return -ENOSPC;
+	}
+
+	if (record->size > record_max_size) {
+		pr_err("dmesg record too big, record size: %lu, available space: %lu\n",
+		       record->size, record_max_size);
+		return -ENOSPC;
+	}
+
+	memcpy(kho_data_out->buf, record->buf, record->size);
+	kho_data_out->size = record->size;
+	kho_data_out->time = record->time;
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
+		.bufsize	= record_max_size,
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
+	phys_addr_t fdt_phys;
+	void *fdt_in;
+	const phys_addr_t *kho_data_phys;
+	int err, len;
+
+	err = kho_retrieve_subtree(KHO_PSTORE_FDT_NAME, &fdt_phys);
+	if (err) {
+		if (err != -ENOENT)
+			pr_err("failed to retrieve FDT %s from KHO: %d\n",
+			       KHO_PSTORE_FDT_NAME, err);
+		return;
+	}
+
+	fdt_in = phys_to_virt(fdt_phys);
+	err = fdt_node_check_compatible(fdt_in, 0, KHO_PSTORE_COMPAT);
+	if (err) {
+		pr_err("FDT '%s' is incompatible with '%s' [%d]\n",
+		       KHO_PSTORE_FDT_NAME, KHO_PSTORE_COMPAT, err);
+		return;
+	}
+
+	kho_data_phys = fdt_getprop(fdt_in, 0, KHO_PSTORE_DATA, &len);
+	if (!kho_data_phys || len != sizeof(*kho_data_phys)) {
+		pr_err("failed to find kho property %s\n", KHO_PSTORE_DATA);
+		return;
+	}
+
+	kho_data_in = phys_to_virt(get_unaligned(kho_data_phys));
+
+	pr_info("successfully restored preserved data\n");
+}
+
+static int __init kho_setup_outgoing(void)
+{
+	phys_addr_t header_ser_phys;
+	int err;
+	size_t total_size = sizeof(struct pstore_kho_record) + record_max_size;
+
+	kho_data_out = kho_alloc_preserve(total_size);
+	if (IS_ERR(kho_data_out)) {
+		pr_err("failed to allocate pstore kho data\n");
+		return PTR_ERR(kho_data_out);
+	}
+
+	fdt_out = kho_alloc_preserve(PAGE_SIZE);
+	if (IS_ERR(fdt_out)) {
+		pr_err("failed to allocate/preserve FDT memory\n");
+		err = PTR_ERR(fdt_out);
+		goto err_free_header;
+	}
+
+	err = fdt_create(fdt_out, PAGE_SIZE);
+	err |= fdt_finish_reservemap(fdt_out);
+	err |= fdt_begin_node(fdt_out, "");
+	err |= fdt_property_string(fdt_out, "compatible", KHO_PSTORE_COMPAT);
+
+	header_ser_phys = virt_to_phys(kho_data_out);
+	err |= fdt_property(fdt_out, KHO_PSTORE_DATA, &header_ser_phys,
+			    sizeof(header_ser_phys));
+	err |= fdt_end_node(fdt_out);
+	err |= fdt_finish(fdt_out);
+	if (err) {
+		pr_err("failed to configure fdt tree\n");
+		goto err_free_fdt;
+	}
+
+	err = kho_add_subtree(KHO_PSTORE_FDT_NAME, fdt_out);
+	if (err) {
+		pr_err("failed to add subtree\n");
+		goto err_free_fdt;
+	}
+
+	return 0;
+
+err_free_fdt:
+	kho_unpreserve_free(fdt_out);
+
+err_free_header:
+	kho_unpreserve_free(kho_data_out);
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
+		goto err_free_incoming;
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
+	kho_remove_subtree(fdt_out);
+	kho_unpreserve_free(fdt_out);
+
+	kho_unpreserve_free(kho_data_out);
+
+err_free_incoming:
+	if (kho_data_in)
+		kho_restore_free(kho_data_in);
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
+	kho_remove_subtree(fdt_out);
+	kho_unpreserve_free(fdt_out);
+
+	kho_unpreserve_free(kho_data_out);
+
+	if (kho_data_in)
+		kho_restore_free(kho_data_in);
+}
+module_exit(pstore_kho_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Pstore backend for dmesg preservation over kexec");
-- 
2.54.0.669.g59709faab0-goog


