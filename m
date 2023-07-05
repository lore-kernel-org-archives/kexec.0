Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81DDEB64D9
	for <kexec@archiver.kernel.org>; Wed,  5 Jul 2023 02:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WJNLn/4ShxEyWTwhBZYr82RoT01SpV6ciwXrZOY5afQ=; b=bfNnWX/A0KifFr
	vwIvBforGbCbF6G1jtLNZs/2n/zBEtq4RS7KtdH3wS8+NKXW1NEOOfG1Jf/D4IHnS0kKH3a5PKHJh
	ASFRTOIZSs6dh4XXt/WKaz+pMKiQBypGRlWeNlfNaMLwWWMKnDr5GF0m4JytDJH7tk6FC4579rHAh
	LFyhXRoiSfofMyvEwIhuNQ4RXaxA20nHL8hwW0iweAbSEIl+sk1sY95dqcHuVEkz7l4TdjV2zxaaV
	3iOifTx3EmgDeKOEB2wdmdmdIy0fKdqmr8TlIQHcrwQuqK6ToYZMdAcOEml9/Hxvzne6qfLUu9YsK
	SuihZvl+Tbd4QFGsE0tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGsYm-00Edud-08;
	Wed, 05 Jul 2023 02:48:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGsYj-00Edsw-0T
	for kexec@lists.infradead.org;
	Wed, 05 Jul 2023 02:48:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688525280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8y4cVumLb2YxKPVGeyeuDY469ixzP8JHW9CIVUQQe+c=;
	b=R8jh6sLS4iszm95ig9j/NBOvuP+/6dFJQNHiV+c6OxNIihpuPIefEosDItApk9EUBvUJPv
	xIcpYKvhAZvZxVIKSxCBcB/lWJdP7ixVi7D/RgOSevz2afBbseF9MGYrptfcw2HK3Av/vD
	Mrkb0bxQwrAokAxjQ3EOuZBfKAJSLXU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-jioMDMzcOreq_5OSlfJ-kA-1; Tue, 04 Jul 2023 22:47:58 -0400
X-MC-Unique: jioMDMzcOreq_5OSlfJ-kA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80A3485A58A;
	Wed,  5 Jul 2023 02:47:58 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9ADDB1121314;
	Wed,  5 Jul 2023 02:47:55 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	Pingfan Liu <piliu@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org
Subject: [PATCHv4 6/8] kexec/zboot: Add arch independent zboot support
Date: Wed,  5 Jul 2023 10:47:23 +0800
Message-Id: <20230705024725.11741-7-piliu@redhat.com>
In-Reply-To: <20230705024725.11741-1-piliu@redhat.com>
References: <20230705024725.11741-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230704_194801_258231_042F7209 
X-CRM114-Status: GOOD (  27.12  )
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
[Modified by Pingfan to adapt the new probe interface]
Signed-off-by: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au
Cc: ardb@kernel.org
Cc: jeremy.linton@arm.com
---
 include/kexec-pe-zboot.h |  15 +++++
 kexec/Makefile           |   1 +
 kexec/kexec-pe-zboot.c   | 133 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+)
 create mode 100644 include/kexec-pe-zboot.h
 create mode 100644 kexec/kexec-pe-zboot.c

diff --git a/include/kexec-pe-zboot.h b/include/kexec-pe-zboot.h
new file mode 100644
index 0000000..991fb75
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
+int pez_prepare(const char *crude_buf, off_t buf_sz, struct parsed_info *info);
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
index 0000000..1420eef
--- /dev/null
+++ b/kexec/kexec-pe-zboot.c
@@ -0,0 +1,133 @@
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
+int pez_prepare(const char *crude_buf, off_t buf_sz, struct parsed_info *info)
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
+	info->fd = open(fname, O_RDONLY);
+	if (info->fd == -1) {
+		dbgprintf("%s: Failed to open file %s\n",
+				__func__, fname);
+		ret = -1;
+		goto fail_bad_header;
+	}
+
+	dbgprintf("%s: ", __func__);
+
+	info->kernel_buf = kernel_uncompressed_buf;
+	info->kernel_size = decompressed_size;
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
