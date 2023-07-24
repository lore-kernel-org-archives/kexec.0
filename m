Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FE4C001DC
	for <kexec@archiver.kernel.org>; Mon, 24 Jul 2023 02:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z65mH9rnu8Vo1oJiIISZFDW3as7ZQ/R3aNHlC3FlihE=; b=PTJlGQ0pgX4qQF
	Hl2pkUgBSZNwKT0/jnChHI5eyhhfwjS+L3X+v2XpS8UJzlmAFwZF6oAl6lxszUpo2OtL2IDq6RdHA
	RMsbCsiXHt8hP6kIJx4HGf5+/iBCfwXxvVbN46PylMPqWsJfR4aIJgVTVxs01iNrqefM5PycEwQxN
	3UD2PYA4hgbpQwIJQZFlUJsvxnFxjaVzPwuFkXuApJoXzaIMXfLxoGPun2DgttY/u1mhRwPmhj6dh
	Z0o5N59uQLoukh/NHrAnCge14TrlLOdvzy7QlZJgo569QrP5QLbCgyPBakXUAg9n819J1t5n2ujJv
	RqBOEHA4L0gxgiaC6+OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNlDJ-002WMz-0P;
	Mon, 24 Jul 2023 02:22:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNlDF-002WLX-2o
	for kexec@lists.infradead.org;
	Mon, 24 Jul 2023 02:22:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690165337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RTPkHcftvUC+CLTMOmZN7uSUP8lqz5UMFqthrAZICFk=;
	b=MjaXS+6D5zLNLSqRyB5Vzu2I/mATWDzNQ+yiZAcuA5XxSj4oe9znT7z6ykdu8AFnT58EhK
	VxLq/gmkar3U+ln+slhf2jkTAoi1OIBblRzK2rTFExyOLu834liNoBAM8imO7bKbCXMEVL
	yGLfbEKJ0cuvOL/WcHVWmATxTXupcIM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-84-Z7SLA4zFPcKGDEWs9zHijQ-1; Sun, 23 Jul 2023 22:22:13 -0400
X-MC-Unique: Z7SLA4zFPcKGDEWs9zHijQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5AD6F29A9D28;
	Mon, 24 Jul 2023 02:22:13 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7FC0540C2063;
	Mon, 24 Jul 2023 02:22:10 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	Pingfan Liu <piliu@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org
Subject: [PATCHv6 4/5] arm64: Add ZBOOT PE containing compressed image support
Date: Mon, 24 Jul 2023 10:21:41 +0800
Message-Id: <20230724022142.6425-5-piliu@redhat.com>
In-Reply-To: <20230724022142.6425-1-piliu@redhat.com>
References: <20230724022142.6425-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230723_192217_978793_E6B55D39 
X-CRM114-Status: GOOD (  24.36  )
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

From: Jeremy Linton <jeremy.linton@arm.com>

The kernel EFI stub ZBOOT feature creates a PE that
contains a compressed linux kernel image. The stub
when run in a valid UEFI environment then decompresses
the resulting image and executes it.

Support these image formats with kexec as well to avoid
having to keep an alternate kernel image around.

This patch adds a the _probe(), _load() and usage() routines needed for
kexec to understand this format.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
[Modified by Pingfan to export kernel fd with load method]
Signed-off-by: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au
Cc: ardb@kernel.org
Cc: jeremy.linton@arm.com
---
 kexec/arch/arm64/image-header.h        |   1 +
 kexec/arch/arm64/kexec-vmlinuz-arm64.c | 110 +++++++++++++++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100644 kexec/arch/arm64/kexec-vmlinuz-arm64.c

diff --git a/kexec/arch/arm64/image-header.h b/kexec/arch/arm64/image-header.h
index 158d411..26bb02f 100644
--- a/kexec/arch/arm64/image-header.h
+++ b/kexec/arch/arm64/image-header.h
@@ -37,6 +37,7 @@ struct arm64_image_header {
 
 static const uint8_t arm64_image_magic[4] = {'A', 'R', 'M', 0x64U};
 static const uint8_t arm64_image_pe_sig[2] = {'M', 'Z'};
+static const uint8_t arm64_pe_machtype[6] = {'P','E', 0x0, 0x0, 0x64, 0xAA};
 static const uint64_t arm64_image_flag_be = (1UL << 0);
 static const uint64_t arm64_image_flag_page_size = (3UL << 1);
 static const uint64_t arm64_image_flag_placement = (1UL << 3);
diff --git a/kexec/arch/arm64/kexec-vmlinuz-arm64.c b/kexec/arch/arm64/kexec-vmlinuz-arm64.c
new file mode 100644
index 0000000..c0ee47c
--- /dev/null
+++ b/kexec/arch/arm64/kexec-vmlinuz-arm64.c
@@ -0,0 +1,110 @@
+/*
+ * ARM64 PE compressed Image (vmlinuz, ZBOOT) support.
+ *
+ * Several distros use 'make zinstall' rule inside
+ * 'arch/arm64/boot/Makefile' to install the arm64
+ * ZBOOT compressed file inside the boot destination
+ * directory (for e.g. /boot).
+ *
+ * Currently we cannot use kexec_file_load() to load vmlinuz
+ * PE images that self decompress.
+ *
+ * To support ZBOOT, we should:
+ * a). Copy the compressed contents of vmlinuz to a temporary file.
+ * b). Decompress (gunzip-decompress) the contents inside the
+ *     temporary file.
+ * c). Validate the resulting image and write it back to the
+ *     temporary file.
+ * d). Pass the 'fd' of the temporary file to the kernel space.
+ *
+ * Note this, module doesn't provide a _load() function instead
+ * relying on image_arm64_load() to load the resulting decompressed
+ * image.
+ *
+ * So basically the kernel space still gets a decompressed
+ * kernel image to load via kexec-tools.
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include "kexec-arm64.h"
+#include <kexec-pe-zboot.h>
+#include "arch/options.h"
+
+static int kernel_fd = -1;
+
+/* Returns:
+ * -1 : in case of error/invalid format (not a valid PE+compressed ZBOOT format.
+ */
+int pez_arm64_probe(const char *kernel_buf, off_t kernel_size)
+{
+	int ret = -1;
+	const struct arm64_image_header *h;
+	char *buf;
+	off_t buf_sz;
+
+	buf = (char *)kernel_buf;
+	buf_sz = kernel_size;
+	if (!buf)
+		return -1;
+	h = (const struct arm64_image_header *)buf;
+
+	dbgprintf("%s: PROBE.\n", __func__);
+	if (buf_sz < sizeof(struct arm64_image_header)) {
+		dbgprintf("%s: Not large enough to be a PE image.\n", __func__);
+		return -1;
+	}
+	if (!arm64_header_check_pe_sig(h)) {
+		dbgprintf("%s: Not an PE image.\n", __func__);
+		return -1;
+	}
+
+	if (buf_sz < sizeof(struct arm64_image_header) + h->pe_header) {
+		dbgprintf("%s: PE image offset larger than image.\n", __func__);
+		return -1;
+	}
+
+	if (memcmp(&buf[h->pe_header],
+		   arm64_pe_machtype, sizeof(arm64_pe_machtype))) {
+		dbgprintf("%s: PE header doesn't match machine type.\n", __func__);
+		return -1;
+	}
+
+	ret = pez_prepare(buf, buf_sz, &kernel_fd);
+
+	if (!ret) {
+	    /* validate the arm64 specific header */
+	    struct arm64_image_header hdr_check;
+	    if (read(kernel_fd, &hdr_check, sizeof(hdr_check)) != sizeof(hdr_check))
+		goto bad_header;
+
+	    lseek(kernel_fd, 0, SEEK_SET);
+
+	    if (!arm64_header_check_magic(&hdr_check)) {
+		dbgprintf("%s: Bad arm64 image header.\n", __func__);
+		goto bad_header;
+	    }
+	}
+
+	return ret;
+bad_header:
+	close(kernel_fd);
+	free(buf);
+	return -1;
+}
+
+int pez_arm64_load(int argc, char **argv, const char *buf, off_t len,
+			struct kexec_info *info)
+{
+	info->kernel_fd = kernel_fd;
+	return image_arm64_load(argc, argv, buf, len, info);
+}
+
+void pez_arm64_usage(void)
+{
+	printf(
+"     An ARM64 vmlinuz, PE image of a compressed, little endian.\n"
+"     kernel, built with ZBOOT enabled.\n\n");
+}
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
