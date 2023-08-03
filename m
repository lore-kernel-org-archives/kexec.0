Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3984CC001DE
	for <kexec@archiver.kernel.org>; Thu,  3 Aug 2023 02:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=15oG+O8ehC0CRLAQxgfaqvBd+ALP6KREEKhG8ayggrE=; b=mwmCQhs8oVHUax
	05FR8ZBKMPPn1sO3oLAlfShnzxqPh8VI+/nqO4HXvxQyPEQp3DA3D9XV5yywgmuFw7VL6W8qrfiy5
	KT+rY0DsCBs7rK8Fo6rkjdEv0um1PBoP+q0WKfUUlpx9POWDAMIGVGvtJJXeCaeigARSsNc3/T9C4
	q9XWnBd9ruy9T/4XkLRIeVOYFflxG22Wke4NkJ/MsywVL8AnK3ZUPqCWmxgN+EkUiWDcK6lmQQAnl
	4N85fRj1hKcNmpBDIjB4vD1GbmRt3V1NIAlTI2fcspwEodSo6lDNh9D+H/ti8A7L+XkbJHQVG63Ze
	/xRxK2c5p/hyHwcy8Avg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qROIH-006Tjt-0A;
	Thu, 03 Aug 2023 02:42:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qROID-006TiH-2A
	for kexec@lists.infradead.org;
	Thu, 03 Aug 2023 02:42:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691030544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vggSqu6iQDOHPq9BKBNOGzXUnN3gS8ZGNHRsiuNuDQQ=;
	b=D9GjBOYF2ChD8Uf/XbgAJfzkF+LdDl8Id8YY3PXrXYF2rWFY2+GsSiyYjMBurmgpW5VJyn
	dFcE6DuD3YuPY0LciFOeC6Ok45WJZzAP56w0UUcwwqnFMOP3/1VMHOZcs9EMDbkamihUeL
	nkFI7NnFdQb5P2PDvb+mMwxtNyE4xyI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-G7REJy-ONnm0UdG9Z_P3gw-1; Wed, 02 Aug 2023 22:42:23 -0400
X-MC-Unique: G7REJy-ONnm0UdG9Z_P3gw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9043185A78B;
	Thu,  3 Aug 2023 02:42:22 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 231BE1454143;
	Thu,  3 Aug 2023 02:42:19 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	Pingfan Liu <piliu@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org
Subject: [PATCHv7 3/5] kexec/zboot: Add arch independent zboot support
Date: Thu,  3 Aug 2023 10:41:50 +0800
Message-Id: <20230803024152.11663-4-piliu@redhat.com>
In-Reply-To: <20230803024152.11663-1-piliu@redhat.com>
References: <20230803024152.11663-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230802_194225_779942_B85D1861 
X-CRM114-Status: GOOD (  28.04  )
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

The linux kernel CONFIG_ZBOOT option creates
self decompressing PE kernel images. So this means
that kexec should have a generic understanding of
the format which may be used by multiple arches.

So lets add an arch independent validation
and decompression routine.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
[Modified by Pingfan to export kernel fd]
Signed-off-by: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au
Cc: ardb@kernel.org
Cc: jeremy.linton@arm.com
---
 include/Makefile         |   1 +
 include/kexec-pe-zboot.h |  15 +++++
 kexec/Makefile           |   1 +
 kexec/kexec-pe-zboot.c   | 131 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 148 insertions(+)
 create mode 100644 include/kexec-pe-zboot.h
 create mode 100644 kexec/kexec-pe-zboot.c

diff --git a/include/Makefile b/include/Makefile
index 621ce9f..cd88a26 100644
--- a/include/Makefile
+++ b/include/Makefile
@@ -1,6 +1,7 @@
 dist += include/Makefile		\
 	include/config.h		\
 	include/config.h.in		\
+	include/kexec-pe-zboot.h	\
 	include/kexec-uImage.h		\
 	include/x86/x86-linux.h		\
 	include/x86/mb_info.h		\
diff --git a/include/kexec-pe-zboot.h b/include/kexec-pe-zboot.h
new file mode 100644
index 0000000..c588ca2
--- /dev/null
+++ b/include/kexec-pe-zboot.h
@@ -0,0 +1,15 @@
+#ifndef __KEXEC_PE_ZBOOT_H__
+#define __KEXEC_PE_ZBOOT_H__
+
+/* see drivers/firmware/efi/libstub/zboot-header.S */
+struct linux_pe_zboot_header {
+	uint32_t mz_magic;
+        uint32_t image_type;
+        uint32_t payload_offset;
+        uint32_t payload_size;
+        uint32_t reserved[2];
+        uint32_t compress_type;
+};
+
+int pez_prepare(const char *crude_buf, off_t buf_sz, int *kernel_fd);
+#endif
diff --git a/kexec/Makefile b/kexec/Makefile
index 8a52e8d..11682bf 100644
--- a/kexec/Makefile
+++ b/kexec/Makefile
@@ -17,6 +17,7 @@ KEXEC_SRCS_base += kexec/kexec-elf-exec.c
 KEXEC_SRCS_base += kexec/kexec-elf-core.c
 KEXEC_SRCS_base += kexec/kexec-elf-rel.c
 KEXEC_SRCS_base += kexec/kexec-elf-boot.c
+KEXEC_SRCS_base += kexec/kexec-pe-zboot.c
 KEXEC_SRCS_base += kexec/kexec-iomem.c
 KEXEC_SRCS_base += kexec/firmware_memmap.c
 KEXEC_SRCS_base += kexec/crashdump.c
diff --git a/kexec/kexec-pe-zboot.c b/kexec/kexec-pe-zboot.c
new file mode 100644
index 0000000..2f2e052
--- /dev/null
+++ b/kexec/kexec-pe-zboot.c
@@ -0,0 +1,131 @@
+/*
+ * Generic PE compressed Image (vmlinuz, ZBOOT) support.
+ *
+ * Several distros use 'make zinstall' with CONFIG_ZBOOT
+ * enabled to create UEFI PE images that contain
+ * a decompressor and a compressed kernel image.
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
+ * This module contains the arch independent code for the above,
+ * arch specific PE and image checks should wrap calls
+ * to functions in this module.
+ */
+
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <stdint.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include "kexec.h"
+#include <kexec-pe-zboot.h>
+
+#define FILENAME_IMAGE		"/tmp/ImageXXXXXX"
+
+/*
+ * Returns -1 : in case of error/invalid format (not a valid PE+compressed ZBOOT format.
+ *
+ * crude_buf: the content, which is read from the kernel file without any processing
+ */
+int pez_prepare(const char *crude_buf, off_t buf_sz, int *kernel_fd)
+{
+	int ret = -1;
+	int fd = 0;
+	char *fname = NULL;
+	char *kernel_uncompressed_buf = NULL;
+	off_t decompressed_size = 0;
+	const struct linux_pe_zboot_header *z;
+
+	z = (const struct linux_pe_zboot_header *)(crude_buf);
+
+	if (memcmp(&z->image_type, "zimg", sizeof(z->image_type))) {
+		dbgprintf("%s: PE doesn't contain a compressed kernel.\n", __func__);
+		return -1;
+	}
+
+	/*
+	 * At the moment its possible to create images with more compression
+	 * algorithms than are supported here, error out if we detect that.
+	 */
+	if (memcmp(&z->compress_type, "gzip", 4) &&
+	    memcmp(&z->compress_type, "lzma", 4)) {
+		dbgprintf("%s: kexec can only decompress gziped and lzma images.\n", __func__);
+		return -1;
+	}
+
+	if (buf_sz < z->payload_offset + z->payload_size) {
+		dbgprintf("%s: PE too small to contain complete payload.\n", __func__);
+		return -1;
+	}
+
+	if (!(fname = strdup(FILENAME_IMAGE))) {
+		dbgprintf("%s: Can't duplicate strings\n", __func__);
+		return -1;
+	}
+
+	if ((fd = mkstemp(fname)) < 0) {
+		dbgprintf("%s: Can't open file %s\n", __func__,	fname);
+		ret = -1;
+		goto fail_mkstemp;
+	}
+
+	if (write(fd, &crude_buf[z->payload_offset],
+		  z->payload_size) != z->payload_size) {
+		dbgprintf("%s: Can't write the compressed file %s\n",
+				__func__, fname);
+		ret = -1;
+		goto fail_write;
+	}
+
+	kernel_uncompressed_buf = slurp_decompress_file(fname,
+							&decompressed_size);
+
+	dbgprintf("%s: decompressed size %ld\n", __func__, decompressed_size);
+
+	lseek(fd, 0, SEEK_SET);
+
+	if (write(fd,  kernel_uncompressed_buf,
+		  decompressed_size) != decompressed_size) {
+		dbgprintf("%s: Can't write the decompressed file %s\n",
+				__func__, fname);
+		ret = -1;
+		goto fail_bad_header;
+	}
+
+	*kernel_fd = open(fname, O_RDONLY);
+	if (*kernel_fd == -1) {
+		dbgprintf("%s: Failed to open file %s\n",
+				__func__, fname);
+		ret = -1;
+		goto fail_bad_header;
+	}
+
+	dbgprintf("%s: done\n", __func__);
+
+	ret = 0;
+	goto fail_write;
+
+fail_bad_header:
+	free(kernel_uncompressed_buf);
+
+fail_write:
+	if (fd >= 0)
+		close(fd);
+
+	unlink(fname);
+
+fail_mkstemp:
+	free(fname);
+
+	return ret;
+}
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
