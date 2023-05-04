Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B16C77B7C
	for <kexec@archiver.kernel.org>; Thu,  4 May 2023 16:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ud84hLhyHEiGzMxmn4//9ZnUZZpLWMGFHrtYcTP24W4=; b=BFIWLp8u9/Pl+K
	tmY/75FdjZbax60mNOkWzSUQIH1HZMdJ/WgXwTLecUBJn8bKLYTr92H3KsBug5GeD9yve95lpZdxm
	HcxFpphwS37A8ogYmxxo2CmMsTysH9YFi8qcQ9qFPdXkruoikJf2RfxTfgssdv9ktKIfl34yiFRE4
	R+esHpz3qbVSiqsCq9KSXSApJdAALGF9lOgXSk11Fjp/FDq+jD6Xs49/LvS7UGsjKzIBJCFdAGWQf
	cCoIVV07vRe7taQcd9YakJMdhiLp1qiYpYycp39fBv3oET4Md9Q5m77kR49/6OA1y+NHCTMt0QK9F
	i6fUWckRsDK7lhCCMPBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puc1o-008M3K-0h;
	Thu, 04 May 2023 16:42:00 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puc1k-008M1S-1F
	for kexec@lists.infradead.org;
	Thu, 04 May 2023 16:41:58 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 694ED1042;
	Thu,  4 May 2023 09:42:37 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1760E3F5A1;
	Thu,  4 May 2023 09:41:53 -0700 (PDT)
From: Jeremy Linton <jeremy.linton@arm.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au,
	piliu@redhat.com,
	bhsharma@redhat.com,
	ardb@kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 2/4] arm64: Add ZBOOT PE containing compressed image support
Date: Thu,  4 May 2023 11:41:45 -0500
Message-Id: <20230504164147.1166614-3-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230504164147.1166614-1-jeremy.linton@arm.com>
References: <20230504164147.1166614-1-jeremy.linton@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_094156_538788_7FC2C865 
X-CRM114-Status: GOOD (  22.95  )
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

The kernel EFI stub ZBOOT feature creates a PE that
contains a compressed linux kernel image. The stub
when run in a valid UEFI environment then decompresses
the resulting image and executes it.

Support these image formats with kexec as well to avoid
having to keep an alternate kernel image around.

This patch adds a the _probe() and usage() routines needed
for kexec to understand this format.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 kexec/arch/arm64/image-header.h        |  11 ++
 kexec/arch/arm64/kexec-vmlinuz-arm64.c | 172 +++++++++++++++++++++++++
 2 files changed, 183 insertions(+)
 create mode 100644 kexec/arch/arm64/kexec-vmlinuz-arm64.c

diff --git a/kexec/arch/arm64/image-header.h b/kexec/arch/arm64/image-header.h
index 158d411..5106b67 100644
--- a/kexec/arch/arm64/image-header.h
+++ b/kexec/arch/arm64/image-header.h
@@ -35,8 +35,19 @@ struct arm64_image_header {
 	uint32_t pe_header;
 };
 
+/* see drivers/firmware/efi/libstub/zboot-header.S */
+struct arm64_zboot_header {
+	uint32_t mz_magic;
+        uint32_t image_type;
+        uint32_t payload_offset;
+        uint32_t payload_size;
+        uint32_t reserved[2];
+        uint32_t compress_type;
+};
+
 static const uint8_t arm64_image_magic[4] = {'A', 'R', 'M', 0x64U};
 static const uint8_t arm64_image_pe_sig[2] = {'M', 'Z'};
+static const uint8_t arm64_pe_machtype[6] = {'P','E', 0x0, 0x0, 0x64, 0xAA};
 static const uint64_t arm64_image_flag_be = (1UL << 0);
 static const uint64_t arm64_image_flag_page_size = (3UL << 1);
 static const uint64_t arm64_image_flag_placement = (1UL << 3);
diff --git a/kexec/arch/arm64/kexec-vmlinuz-arm64.c b/kexec/arch/arm64/kexec-vmlinuz-arm64.c
new file mode 100644
index 0000000..7033e2e
--- /dev/null
+++ b/kexec/arch/arm64/kexec-vmlinuz-arm64.c
@@ -0,0 +1,172 @@
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
+
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdlib.h>
+#include "crashdump-arm64.h"
+#include "image-header.h"
+#include "kexec.h"
+#include "kexec-arm64.h"
+#include "kexec-syscall.h"
+#include "kexec-zlib.h"
+#include "arch/options.h"
+
+#define FILENAME_IMAGE		"/tmp/ImageXXXXXX"
+
+/* Returns:
+ * -1 : in case of error/invalid format (not a valid PE+compressed ZBOOT format.
+ * fd : File descriptor of the temp file containing the decompressed
+ *	Image.
+ */
+int pez_arm64_probe(const char *kernel_buf, off_t kernel_size)
+{
+	int ret = -1;
+	int fd = 0;
+	int kernel_fd = 0;
+	char *fname = NULL;
+	char *kernel_uncompressed_buf = NULL;
+	off_t decompressed_size = 0;
+	const struct arm64_image_header *h;
+	const struct arm64_zboot_header *z;
+	h = (const struct arm64_image_header *)(kernel_buf);
+	z = (const struct arm64_zboot_header *)(kernel_buf);
+
+	dbgprintf("%s: PROBE.\n", __func__);
+	if (kernel_size < sizeof(struct arm64_image_header)) {
+		dbgprintf("%s: Not large enough to be a PE image.\n", __func__);
+		return -1;
+	}
+	if (!arm64_header_check_pe_sig(h)) {
+		dbgprintf("%s: Not an PE image.\n", __func__);
+		return -1;
+	}
+
+	if (kernel_size < sizeof(struct arm64_image_header) + h->pe_header) {
+		dbgprintf("%s: PE image offset larger than image.\n", __func__);
+		return -1;
+	}
+
+	if (memcmp(&kernel_buf[h->pe_header],
+		   arm64_pe_machtype, sizeof(arm64_pe_machtype))) {
+		dbgprintf("%s: PE header doesn't match machine type.\n", __func__);
+		return -1;
+	}
+
+	if (memcmp(&z->image_type, "zimg", sizeof(z->image_type))) {
+		dbgprintf("%s: PE doesn't contain a compressed kernel.\n", __func__);
+		return -1;
+	}
+
+	if (memcmp(&z->compress_type, "gzip", 4) &&
+	    memcmp(&z->compress_type, "lzma", 4)) {
+		dbgprintf("%s: kexec can only decompress gziped and lzma images.\n", __func__);
+		return -1;
+	}
+
+	if (kernel_size < z->payload_offset + z->payload_size) {
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
+	if (write(fd, &kernel_buf[z->payload_offset],
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
+	h = (const struct arm64_image_header *)(kernel_uncompressed_buf);
+	if (!arm64_header_check_magic(h)) {
+		dbgprintf("%s: Bad arm64 image header.\n", __func__);
+		ret = -1;
+		goto fail_bad_header;
+	}
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
+	kernel_fd = open(fname, O_RDONLY);
+	if (kernel_fd == -1) {
+		dbgprintf("%s: Failed to open file %s\n",
+				__func__, fname);
+		ret = -1;
+		goto fail_bad_header;
+	}
+
+	dbgprintf("%s: ", __func__);
+
+	ret = kernel_fd;
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
+
+void pez_arm64_usage(void)
+{
+	printf(
+"     An ARM64 vmlinuz, PE image of a compressed, little endian.\n"
+"     kernel, built with ZBOOT enabled.\n\n");
+}
-- 
2.40.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
