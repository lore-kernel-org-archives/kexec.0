Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F73EE801F
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 05:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=txnuzbyu+eHn83PJx1JhRdqJbe8MRFlii+umHfUz5h4=; b=0xyvQ6yNdFuEUn
	2kVeGLtBwBDG2NNlo27PVlDPx7PdoT4QGha/wEq9oaCxrn6EIiTJSRNrkGW9xBxJ7YRkBI4Yz6rWw
	cTCEYH8xV9KobKnBoALhjdkfQ2EsRDZQ7GCPGJvbpLD+6OVLJKEShsQBkuNU1wWhSjrA21kSD0p6N
	nFoae7Dh6CemmGoFqagsxbiahQJBJRl56XOO+Q6pX+hzqBgpUIgRH0OROHfCTqTQvZ4sg68uYLqdK
	PUtglEkiwp0q2JVtR5clapgyd8IpO+Wv13j+kcHCtKWAP5mg5JLq7irVUMOlQxbqyl+VD1UfTbrd5
	DBcJ2rAH2BJOsd1ZLLDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfZRS-00HGFO-0s;
	Mon, 11 Sep 2023 05:26:34 +0000
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfZRP-00HGDq-1f
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 05:26:33 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id E46AD5C00CE;
	Mon, 11 Sep 2023 01:26:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 11 Sep 2023 01:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1694409990; x=
	1694496390; bh=BCXzQAxKcTxOEQhh9DLQ4hnHkrayZdUDOP+GxHQhMCc=; b=P
	O+W4r3BkSWadKS/4TCpzSkOOgcR+yJRn4ND1OnYvfIu/ihtCKbqOgkTQpCO0/SdN
	ZCjfaf9wiZz3DipGll9Ru55yaNi0hS+Xsp+WdkgSsbRS+LgN1hntDunDdxb8rMWr
	SKwY+DTFVMmKRVwg3HthjE9p06gu8APoBP2Dek6pth4NK/u/tTMh2jbhwfAiOtUK
	ttzSN+LRIabnzQzIzQ1G/Fk5NfjWm5trHmcur+OK650+nw7FuvCFVT+qRvRDpFJE
	dMV+B0k7qskjBvUq9wd7a7eymQqkm3zCCDfYGKpZibV/AIgnK52vH1ItNbgDjGgY
	KiQ3WGjC/3rM6Q4K5IOyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1694409990; x=
	1694496390; bh=BCXzQAxKcTxOEQhh9DLQ4hnHkrayZdUDOP+GxHQhMCc=; b=w
	jmd2kyLNblsdB/Q4uTcxZgXYO1U9Ni5XU4FmSGDse431WTNl7kWjB99NRRPpLx97
	DJn2mQKr5viNZqdySQwGXPx7IVlTvVzRHV6vcMZpRLU0QBOyUZCbHmZUhaJ+6rqY
	/WIuTUoxpfFb46F3UsC4+2Xf9C58N7nAeqgXnJ6ht/sNzbD/ArNCbAzdn4XIKQGw
	o3veEiDJ3My7405/CH1u8RCeVa9nsCA0DVCN6Pl7XtUx+ww9mIsE49vkVqlJmqaj
	eiQR0wkMUDDlJe2uj97kVIkCQ4Ar8f3uhNSd2G572ojJ1Le1ShGNoQXUvJQrobCw
	XdXJBRHEM3fTDs+M0qnwA==
X-ME-Sender: <xms:BqX-ZCq-XgF71RDNGZWYSnPa1_fkG-TDMHsBDfMUsMSEEC2kklRL8A>
    <xme:BqX-ZArQ3rZ71SlM39syWrfLmoI_U1zh5c-FwUDc4kGRbBDz3eAkpanW033GMJVfN
    HqGouZSjotswEXNgsE>
X-ME-Received: <xmr:BqX-ZHPoX3jNfcZTXg1bNJr0BMP9ikJL7F93gmtw9RPm7jrVhfXBHG_JRuEdZCOS_rhl4VPrA-iS8XJCjJ0Prf9hWNTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeifedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflrghnucfjvghnughrihhk
    ucfhrghrrhcuoehkvghrnhgvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpe
    egfeeliefggeeiiedtudevveevvddvvefguddtvdeitdejleejuefgueelieehteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkvghrnhgvlh
    esjhhfrghrrhdrtggt
X-ME-Proxy: <xmx:BqX-ZB63lLQbM7t7JUnGdLXU6ba_daiPsUpmO9sXIsSMYn6SKlqYhw>
    <xmx:BqX-ZB6wwo-f4Dv1LYMZ1c3SXDKBcKWW1slFfqDzC7RRlIO4B1CcCg>
    <xmx:BqX-ZBiNrgAKybSryFHc8XDp1tzO9fvDSKLrn9lkgIFy0HAF1Mmhmw>
    <xmx:BqX-ZNgV4raizDmiNNKYYAgGb6nbno40W2aGTCX7EBGFts6_6KX-pw>
Feedback-ID: i0fc947c4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Sep 2023 01:26:29 -0400 (EDT)
From: Jan Hendrik Farr <kernel@jfarr.cc>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	x86@kernel.org,
	tglx@linutronix.de,
	dhowells@redhat.com,
	vgoyal@redhat.com,
	keyrings@vger.kernel.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	bhelgaas@google.com,
	bluca@debian.org,
	lennart@poettering.net,
	Jan Hendrik Farr <kernel@jfarr.cc>
Subject: [PATCH v2 2/2] x86/kexec: UKI support
Date: Mon, 11 Sep 2023 07:25:35 +0200
Message-Id: <20230911052535.335770-3-kernel@jfarr.cc>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230911052535.335770-1-kernel@jfarr.cc>
References: <20230911052535.335770-1-kernel@jfarr.cc>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230910_222631_618736_94AA5523 
X-CRM114-Status: GOOD (  24.28  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

make the kernel accept UKIs (Unified Kernel Images) for kexec_file_load.

UKIs contain the kernel bzImage, initrd, and cmdline all packaged up as
one EFI application. The main advantage of this is that the whole
combination is signed together as a package for secure boot.

This implementation parses the UKI and passes the bzImage, initrd, and
cmdline to the normal bzImage loader.

Signed-off-by: Jan Hendrik Farr <kernel@jfarr.cc>
---
 arch/x86/include/asm/kexec-uki.h       |   7 ++
 arch/x86/kernel/Makefile               |   1 +
 arch/x86/kernel/kexec-uki.c            | 126 +++++++++++++++++++++++++
 arch/x86/kernel/machine_kexec_64.c     |   2 +
 crypto/asymmetric_keys/verify_pefile.c |  11 ++-
 lib/Makefile                           |   1 +
 lib/parse_pefile.c                     |  21 ++---
 7 files changed, 157 insertions(+), 12 deletions(-)
 create mode 100644 arch/x86/include/asm/kexec-uki.h
 create mode 100644 arch/x86/kernel/kexec-uki.c

diff --git a/arch/x86/include/asm/kexec-uki.h b/arch/x86/include/asm/kexec-uki.h
new file mode 100644
index 000000000000..87fd2c6fb091
--- /dev/null
+++ b/arch/x86/include/asm/kexec-uki.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_KEXEC_UKI_H
+#define _ASM_KEXEC_UKI_H
+
+extern const struct kexec_file_ops kexec_uki_ops;
+
+#endif  /* _ASM_KEXEC_UKI_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 3269a0e23d3a..a73d61f86d29 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -101,6 +101,7 @@ obj-$(CONFIG_CRASH_CORE)	+= crash_core_$(BITS).o
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec_$(BITS).o
 obj-$(CONFIG_KEXEC_CORE)	+= relocate_kernel_$(BITS).o crash.o
 obj-$(CONFIG_KEXEC_FILE)	+= kexec-bzimage64.o
+obj-$(CONFIG_KEXEC_FILE)	+= kexec-uki.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump_$(BITS).o
 obj-y				+= kprobes/
 obj-$(CONFIG_MODULES)		+= module.o
diff --git a/arch/x86/kernel/kexec-uki.c b/arch/x86/kernel/kexec-uki.c
new file mode 100644
index 000000000000..5a381e4f3728
--- /dev/null
+++ b/arch/x86/kernel/kexec-uki.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Kexec UKI loader
+ *
+ * Copyright (C) 2023 Jan Hendrik Farr
+ *
+ * Authors:
+ *      Jan Hendrik Farr <kernel@jfarr.cc>
+ */
+
+#define pr_fmt(fmt)	"kexec-uki: " fmt
+
+#include <linux/kernel.h>
+#include "linux/pe.h"
+#include <linux/kexec.h>
+#include <linux/err.h>
+
+#include <asm/kexec-uki.h>
+#include <asm/kexec-bzimage64.h>
+#include <linux/parse_pefile.h>
+
+static int find_section(struct pefile_context *ctx, const char *name,
+			const struct section_header **sec)
+{
+	for (int i = 0; i < ctx->n_sections; i++) {
+		const struct section_header *cur_sec = &ctx->secs[i];
+
+		if (!strncmp(cur_sec->name, name, ARRAY_SIZE(cur_sec->name))) {
+			*sec = cur_sec;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int uki_probe(const char *buf, unsigned long len)
+{
+	int ret = -ENOEXEC;
+	int r = 0;
+	struct pefile_context pe_ctx;
+	const struct section_header *s;
+
+	memset(&pe_ctx, 0, sizeof(pe_ctx));
+	r = pefile_parse_binary(buf, len, &pe_ctx);
+
+	if (r) {
+		pr_info("Not a UKI. Not a valid PE file\n");
+		return ret;
+	}
+
+	if (find_section(&pe_ctx, ".linux", &s) ||
+	    find_section(&pe_ctx, ".initrd", &s)) {
+		pr_info("Not a UKI. Missing .linux, or .initrd\n");
+		return ret;
+	}
+
+	pr_info("It's a UKI\n");
+	return 0;
+}
+
+static void *uki_load(struct kimage *image, char *kernel,
+		      unsigned long kernel_len, char *initrd,
+		      unsigned long initrd_len, char *cmdline,
+		      unsigned long cmdline_len)
+{
+	struct pefile_context pe_ctx;
+	const struct section_header *sec_linux, *sec_initrd, *sec_cmdline;
+	int r_linux, r_initrd, r_cmdline, r = 0;
+	void *ret;
+
+	if (initrd_len || strcmp(cmdline, "") || cmdline_len != 1) {
+		pr_err("No manual cmdline or initrd allowed for UKIs");
+		return ERR_PTR(-EPERM);
+	}
+
+	memset(&pe_ctx, 0, sizeof(pe_ctx));
+	r = pefile_parse_binary(kernel, kernel_len, &pe_ctx);
+
+	if (r)
+		return ERR_PTR(r);
+
+	r_linux   = find_section(&pe_ctx, ".linux", &sec_linux);
+	r_initrd  = find_section(&pe_ctx, ".initrd", &sec_initrd);
+	r_cmdline = find_section(&pe_ctx, ".cmdline", &sec_cmdline);
+
+	if (r_linux || r_initrd)
+		return ERR_PTR(-EINVAL);
+
+	if (r_cmdline) {
+		cmdline = "";
+		cmdline_len = 1;
+	} else {
+		cmdline = kernel + sec_cmdline->data_addr;
+		cmdline_len = sec_cmdline->raw_data_size;
+	}
+
+	ret = kexec_bzImage64_ops.load(
+		image,
+		kernel + sec_linux->data_addr,
+		sec_linux->raw_data_size,
+		kernel + sec_initrd->data_addr,
+		sec_initrd->raw_data_size,
+		cmdline,
+		cmdline_len
+	);
+
+	if (IS_ERR(ret))
+		pr_err("bzImage64_load error\n");
+
+	return ret;
+}
+
+static int uki_cleanup(void *loader_data)
+{
+	return kexec_bzImage64_ops.cleanup(loader_data);
+}
+
+const struct kexec_file_ops kexec_uki_ops = {
+	.probe = uki_probe,
+	.load = uki_load,
+	.cleanup = uki_cleanup,
+#ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
+	.verify_sig = kexec_kernel_verify_pe_sig,
+#endif
+};
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 1a3e2c05a8a5..072f5aac52b9 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -25,6 +25,7 @@
 #include <asm/io_apic.h>
 #include <asm/debugreg.h>
 #include <asm/kexec-bzimage64.h>
+#include <asm/kexec-uki.h>
 #include <asm/setup.h>
 #include <asm/set_memory.h>
 #include <asm/cpu.h>
@@ -81,6 +82,7 @@ static int map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p) { retu
 #ifdef CONFIG_KEXEC_FILE
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 		&kexec_bzImage64_ops,
+		&kexec_uki_ops,
 		NULL
 };
 #endif
diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index 68592a328db7..ea183feca231 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -334,6 +334,13 @@ int verify_pefile_signature(const void *pebuf, unsigned pelen,
 	if (ret < 0)
 		return ret;
 
+	const struct data_dirent *certs = pebuf + ctx.cert_dirent_offset;
+
+	if (!certs->virtual_address || !certs->size) {
+		pr_warn("Unsigned PE binary\n");
+		return -ENODATA;
+	}
+
 	ret = pefile_strip_sig_wrapper(pebuf, &ctx);
 	if (ret < 0)
 		return ret;
@@ -342,8 +349,10 @@ int verify_pefile_signature(const void *pebuf, unsigned pelen,
 				     pebuf + ctx.sig_offset, ctx.sig_len,
 				     trusted_keys, usage,
 				     mscode_parse, &ctx);
-	if (ret < 0)
+	if (ret < 0) {
+		pr_warn("invalid PE file signature\n");
 		goto error;
+	}
 
 	pr_debug("Digest: %u [%*ph]\n",
 		 ctx.digest_len, ctx.digest_len, ctx.digest);
diff --git a/lib/Makefile b/lib/Makefile
index 01a6c13565b6..ad6af1bab3ef 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -366,6 +366,7 @@ obj-$(CONFIG_SBITMAP) += sbitmap.o
 obj-$(CONFIG_PARMAN) += parman.o
 
 obj-$(CONFIG_SIGNED_PE_FILE_VERIFICATION) += parse_pefile.o
+obj-$(CONFIG_KEXEC_FILE) += parse_pefile.o
 
 obj-y += group_cpus.o
 
diff --git a/lib/parse_pefile.c b/lib/parse_pefile.c
index 9a8496b2588e..672a044d380c 100644
--- a/lib/parse_pefile.c
+++ b/lib/parse_pefile.c
@@ -88,18 +88,17 @@ int pefile_parse_binary(const void *pebuf, unsigned int pelen,
 		(unsigned long)&ddir->certs - (unsigned long)pebuf;
 	ctx->certs_size = ddir->certs.size;
 
-	if (!ddir->certs.virtual_address || !ddir->certs.size) {
-		pr_warn("Unsigned PE binary\n");
-		return -ENODATA;
-	}
+	if (ddir->certs.virtual_address && ddir->certs.size) {
+
+		chkaddr(ctx->header_size, ddir->certs.virtual_address,
+			ddir->certs.size);
+		ctx->sig_offset = ddir->certs.virtual_address;
+		ctx->sig_len = ddir->certs.size;
+		pr_debug("cert = %x @%x [%*ph]\n",
+			 ctx->sig_len, ctx->sig_offset,
+			 ctx->sig_len, pebuf + ctx->sig_offset);
 
-	chkaddr(ctx->header_size, ddir->certs.virtual_address,
-		ddir->certs.size);
-	ctx->sig_offset = ddir->certs.virtual_address;
-	ctx->sig_len = ddir->certs.size;
-	pr_debug("cert = %x @%x [%*ph]\n",
-		 ctx->sig_len, ctx->sig_offset,
-		 ctx->sig_len, pebuf + ctx->sig_offset);
+	}
 
 	ctx->n_sections = pe->sections;
 	if (ctx->n_sections > (ctx->header_size - cursor) / sizeof(*sec))
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
