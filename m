Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75E2E77182
	for <kexec@archiver.kernel.org>; Thu, 12 Dec 2024 21:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ETj8e4Zz4TNZc+M5aYDvyiWkKKX7Z8xejiyDfP3/k8=; b=HcRdDZW1nCex8bKNxY8ZGGy13v
	3VN2Alo3jC/8QHcaT/yf0O82g5XEWndQCt5IjnGyyNdh7POPbFxyjQlOyR5aqcghbsa3UROlmTQ9R
	+bYdG6H8bZzmvI9JfD/iHugrfbVID06NePOV69aKYlFNyeHTkpEOd4DMqJ9Xlai8T5/2Uv5aePooq
	QHK+F8+QbtDWL46MpprQnDhJnElSsRywNw4KkjzylSmDEWxdgIgU/BBGfUXgp1en658I/3HUffr2V
	+b3B69WYnZNFDkxol+Q65XlLsh+R06NIhYEENN+DENB1A3ZVT1QTtQTdMv5hRD7CoGuOduW7wXqw/
	KxRbkVLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLqWE-00000001vLl-2Ath;
	Thu, 12 Dec 2024 21:14:46 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLqVL-00000001vDw-1AQc
	for kexec@lists.infradead.org;
	Thu, 12 Dec 2024 21:13:52 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 311011A25;
	Thu, 12 Dec 2024 13:14:17 -0800 (PST)
Received: from u200865.usa.arm.com (U203867.austin.arm.com [10.118.30.38])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 045703F58B;
	Thu, 12 Dec 2024 13:13:49 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: kexec@lists.infradead.org
Cc: piliu@redhat.com,
	horms@kernel.org,
	arb@kernel.org,
	dyoung@redhat.com,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [Patch v2 1/2] zstd: Add zstd decompression logic
Date: Thu, 12 Dec 2024 15:13:24 -0600
Message-ID: <20241212211325.805138-2-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241212211325.805138-1-jeremy.linton@arm.com>
References: <20241212211325.805138-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_131351_464722_97C8882D 
X-CRM114-Status: GOOD (  29.12  )
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

zstd is becoming a popular zlib replacement because it both tends to
get a better compression ratio as well performs considerably
better. As such, zstd is now one of the options that can be used to
compress the Linux kernel.

Lets enable it by using a system provided shared library, creating the
required boilerplate to match the existing zlib/lzma function
signatures, and creating build options to enable/disable it.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Acked-by: Pingfan Liu <piliu@redhat.com>
---
 configure.ac       |  10 +++
 kexec/Makefile     |   4 +-
 kexec/kexec-zstd.h |   7 ++
 kexec/zstd.c       | 181 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 201 insertions(+), 1 deletion(-)
 create mode 100644 kexec/kexec-zstd.h
 create mode 100644 kexec/zstd.c

diff --git a/configure.ac b/configure.ac
index e030302..43cdb64 100644
--- a/configure.ac
+++ b/configure.ac
@@ -106,6 +106,9 @@ AC_ARG_WITH([zlib], AS_HELP_STRING([--without-zlib],[disable zlib support]),
 AC_ARG_WITH([lzma], AS_HELP_STRING([--without-lzma],[disable lzma support]),
 	[ with_lzma="$withval"], [ with_lzma=yes ] )
 
+AC_ARG_WITH([zstd], AS_HELP_STRING([--without-zstd],[disable zstd support]),
+	[ with_zstd="$withval"], [ with_zstd=yes ] )
+
 AC_ARG_WITH([xen], AS_HELP_STRING([--without-xen],
 	[disable extended xen support]), [ with_xen="$withval"], [ with_xen=yes ] )
 
@@ -180,6 +183,13 @@ if test "$with_lzma" = yes ; then
 		AC_MSG_NOTICE([lzma support disabled]))])
 fi
 
+dnl See if I have a usable copy of zstd available
+if test "$with_zstd" = yes ; then
+	AC_CHECK_HEADER(zstd.h,
+		[AC_CHECK_LIB(zstd, ZSTD_decompress, ,
+		AC_MSG_NOTICE([zstd support disabled]))])
+fi
+
 dnl find Xen control stack libraries
 if test "$with_xen" = yes ; then
 	AC_CHECK_HEADER(xenctrl.h,
diff --git a/kexec/Makefile b/kexec/Makefile
index d4f26d7..e969d1e 100644
--- a/kexec/Makefile
+++ b/kexec/Makefile
@@ -26,6 +26,7 @@ KEXEC_SRCS_base += kexec/crashdump-xen.c
 KEXEC_SRCS_base += kexec/phys_arch.c
 KEXEC_SRCS_base += kexec/lzma.c
 KEXEC_SRCS_base += kexec/zlib.c
+KEXEC_SRCS_base += kexec/zstd.c
 KEXEC_SRCS_base += kexec/kexec-xen.c
 KEXEC_SRCS_base += kexec/symbols.c
 
@@ -36,7 +37,8 @@ dist += kexec/Makefile						\
 	kexec/crashdump.h kexec/firmware_memmap.h		\
 	kexec/kexec-elf-boot.h					\
 	kexec/kexec-elf.h kexec/kexec-sha256.h			\
-	kexec/kexec-zlib.h kexec/kexec-lzma.h			\
+	kexec/kexec-zlib.h kexec/kexec-lzma.h                   \
+	kexec/kexec-zstd.h                                      \
 	kexec/kexec-xen.h 					\
 	kexec/kexec-syscall.h kexec/kexec.h kexec/kexec.8
 
diff --git a/kexec/kexec-zstd.h b/kexec/kexec-zstd.h
new file mode 100644
index 0000000..c5dbb24
--- /dev/null
+++ b/kexec/kexec-zstd.h
@@ -0,0 +1,7 @@
+#ifndef __KEXEC_ZSTD_H
+#define __KEXEC_ZSTD_H
+
+#include <sys/types.h>
+
+char *zstd_decompress_file(const char *filename, off_t *r_size);
+#endif /* __KEXEC_ZSTD_H */
diff --git a/kexec/zstd.c b/kexec/zstd.c
new file mode 100644
index 0000000..79d5bf3
--- /dev/null
+++ b/kexec/zstd.c
@@ -0,0 +1,181 @@
+#include "kexec-zstd.h"
+#include "kexec.h"
+
+#include "config.h"
+
+#ifdef HAVE_LIBZSTD
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <ctype.h>
+#include <zstd.h>
+
+
+/*
+ * Reimplementation of private function available if zstd is
+ * statically linked. Remove when it becomes public.
+ */
+unsigned ZSTD_isFrame(const void* buffer, size_t size)
+{
+	uint8_t *buf = (uint8_t *)buffer;
+	/* Magic zstd frame header value */
+	if ((buf[0] == 0x28) &&
+	    (buf[1] == 0xB5) &&
+	    (buf[2] == 0x2F) &&
+	    (buf[3] == 0xFD))
+		return 1;
+
+	return 0;
+}
+
+/*
+ * A guess at the max compression ratio for buffer overallocation.
+ * Real values are frequently around 4:1, if this is wrong
+ * it simply results in buffer reallocation and the decompression
+ * operation being restarted from where it stopped.
+ */
+#define EXPECTED_RATIO 8
+
+/*
+ * This supports the streaming compression mode the kernel uses
+ * that can result in multiple zstd frames comprising a single
+ * compressed image. In order too be a bit more efficient than
+ * the libz/lzma implementations, we attempt to discover the input
+ * and output image sizes before performing the decompression.
+ * But, in streaming mode the first frame may not have a length
+ * or it seems the length could be incorrect if multiple frames
+ * are appended together. So, its written with buffer resize logic
+ * but a guess at the compression ratio is made to avoid the resize/copy
+ * operation. Ideally this code efficiently allocates the
+ * correct input buffer, and no more than 2-3x the output buffer
+ * size so that it can perform the decompress operation with a
+ * single decompress call.
+ */
+char *zstd_decompress_file(const char *filename, off_t *r_size)
+{
+	void *cBuff = NULL;
+	ZSTD_DCtx* dctx = NULL;
+	FILE *fp = NULL; /* use c streams to match gzip/lzma logic */
+	struct stat fp_stats;
+	uint8_t magic[4];
+	size_t ret;
+
+	ZSTD_outBuffer output = { NULL, 0, 0 };
+	ZSTD_inBuffer input = { NULL, 0, 0 };
+
+	dbgprintf("Try zstd decompression.\n");
+
+	*r_size = 0;
+	if (!filename) {
+		return NULL;
+	}
+	if (stat(filename, &fp_stats)) {
+		dbgprintf("Cannot stat `%s'\n", filename);
+		return NULL;
+	}
+	if (fp_stats.st_size < sizeof(magic)) {
+		dbgprintf("short file\n");
+		return NULL;
+	}
+	input.size = fp_stats.st_size;
+
+	fp = fopen(filename, "rb");
+	if (fp == 0) {
+		dbgprintf("Cannot open `%s'\n", filename);
+		goto fail;
+	}
+	/* before we read the whole buffer see if this looks like a zstd frame */
+	if (fread(&magic, 1, sizeof(magic), fp) != sizeof(magic)) {
+		dbgprintf("Unable to read zstd header\n");
+		goto fail;
+	}
+
+	if (!ZSTD_isFrame((void*)&magic, sizeof(magic))) {
+		dbgprintf("Not zstd compressed\n");
+		goto fail;
+	}
+
+	cBuff = xmalloc(input.size);
+	input.src = cBuff; /* use cBuff ptr to avoid const/mismatches */
+	rewind(fp);
+	if (fread(cBuff, 1, input.size, fp) != input.size) {
+		dbgprintf("Unable to read compressed data\n");
+		goto fail;
+	}
+	fclose(fp);
+	fp = NULL;
+
+
+	output.size = ZSTD_getFrameContentSize(input.src, input.size);
+	if (output.size == ZSTD_CONTENTSIZE_ERROR) {
+		dbgprintf("not compressed by zstd\n");
+		goto fail;
+	}
+
+	if (output.size == ZSTD_CONTENTSIZE_UNKNOWN) {
+		dbgprintf("original zstd size unknown!\n");
+		/*
+		 * The compressed size is an optional field in the header
+		 * So we guess at the compression ratio to avoid reallocating
+		 * the buffer, but this can fail so we still have code to
+		 * handle that case.
+		 */
+		output.size = fp_stats.st_size * EXPECTED_RATIO;
+	}
+
+	output.dst = xmalloc(output.size);
+
+	dctx = ZSTD_createDCtx();
+	if (dctx == NULL) {
+		dbgprintf("zstd context allocation error\n");
+		goto fail;
+	}
+
+	do {
+		if (output.pos == output.size) {
+			output.size <<= 1;
+			output.dst = xrealloc(output.dst, output.size);
+		}
+
+		ret = ZSTD_decompressStream(dctx, &output , &input);
+		if (ZSTD_isError(ret)) {
+			dbgprintf("zstd error %s\n", ZSTD_getErrorName(ret));
+			goto fail;
+		}
+		dbgprintf("zstd decompressed input=%ld to output=%ld\n", input.pos, output.pos);
+
+	} while ((input.pos < input.size) || ret);
+
+	free(cBuff);
+	ZSTD_freeDCtx(dctx);
+
+	*r_size = output.pos;
+
+	return output.dst;
+
+fail:
+	if (fp)
+		fclose(fp);
+	if (dctx)
+		ZSTD_freeDCtx(dctx);
+	if (output.dst)
+		free(output.dst);
+	if (cBuff)
+		free(cBuff);
+
+	return NULL;
+
+}
+#else
+
+char *zstd_decompress_file(const char *filename, off_t *r_size)
+{
+	return NULL;
+}
+#endif
-- 
2.47.0


