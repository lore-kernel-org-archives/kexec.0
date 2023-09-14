Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F236DEDE999
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 08:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/VRRPBjm71/J92LCk7YS53zMIsIsidOffn+CM5ADmPY=; b=wldahPjyirqkA1
	vM7EiVeAFlxaI4VLcmNagZLaJ9KRelWKa7+te53/xHzpi+sX4F7kREfKYXrSUBKClbLM3brs/9j5s
	ipNjSl9Fjfl5j/cGaIZYsmjlMLKlAH2vutP715b8t6Iv7deAypIj6+FVRv0dHic43WUa5iWxdz59Y
	syVauwDOpCaiEMLvOltceG/vcJ164dTmnpKU9LLq9dgkMnqhFn8ZiK2ldNdLN7DPJyqDhEhJeBbNp
	0wgm2a1EwDwn35Zonb8GhDUQW7RRUrqQvs+m9XOI/Vjk3J/aMs4jX4oXDFE8tHF8edZgTnbp0AKs/
	un2yLBAWw/Mqk87O7dgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgi3O-007kbU-0o;
	Thu, 14 Sep 2023 08:50:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgi3J-007kZb-2Q
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 08:50:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694681421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hqC7yov+uSneH+eA1Iw5MfuxTJMqs/j4D0rbTNNSnrs=;
	b=iSG0KAv8EjfbA+KQzwccmipBwa3aK8wrNCD6lmo10DG5dPgnnceNzVchbVWGQYTvftMJ10
	q6tGxl+NVs8t0lhaE2w12vhwuw7HHTL8twOfqHSxkzPTU1mFpLLb62Xr9EjJY01bVxISYF
	JhD+nMFcX9yz0JukpjinfkOGkpPGm9w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-ldfaR2RFO4i4lfeQgoD6cQ-1; Thu, 14 Sep 2023 04:50:17 -0400
X-MC-Unique: ldfaR2RFO4i4lfeQgoD6cQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9729981B194;
	Thu, 14 Sep 2023 08:50:17 +0000 (UTC)
Received: from darkstar.users.ipa.redhat.com (unknown [10.72.112.219])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8141621B2417;
	Thu, 14 Sep 2023 08:50:15 +0000 (UTC)
From: Dave Young <dyoung@redhat.com>
To: kexec@lists.infradead.org,
	Simon Horman <horms@kernel.org>,
	Pingfan Liu <piliu@redhat.com>
Subject: [PATCH v1 2/2] zboot: add loongarch kexec_load support
Date: Thu, 14 Sep 2023 16:50:00 +0800
Message-Id: <20230914085000.17982-3-dyoung@redhat.com>
In-Reply-To: <20230914085000.17982-1-dyoung@redhat.com>
References: <20230914085000.17982-1-dyoung@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_015021_856751_48D5F1D9 
X-CRM114-Status: GOOD (  19.33  )
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

Copy arm64 code and change for loongarch so that the kexec -c can load
a zboot image.
Note: probe zboot image first otherwise the pei-loongarch file type will
be used.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 kexec/arch/loongarch/Makefile              |  1 +
 kexec/arch/loongarch/image-header.h        |  1 +
 kexec/arch/loongarch/kexec-loongarch.c     |  1 +
 kexec/arch/loongarch/kexec-loongarch.h     |  4 +
 kexec/arch/loongarch/kexec-pez-loongarch.c | 90 ++++++++++++++++++++++
 5 files changed, 97 insertions(+)
 create mode 100644 kexec/arch/loongarch/kexec-pez-loongarch.c

diff --git a/kexec/arch/loongarch/Makefile b/kexec/arch/loongarch/Makefile
index 3b33b9693287..cee7e569a2a2 100644
--- a/kexec/arch/loongarch/Makefile
+++ b/kexec/arch/loongarch/Makefile
@@ -6,6 +6,7 @@ loongarch_KEXEC_SRCS += kexec/arch/loongarch/kexec-elf-loongarch.c
 loongarch_KEXEC_SRCS += kexec/arch/loongarch/kexec-pei-loongarch.c
 loongarch_KEXEC_SRCS += kexec/arch/loongarch/kexec-elf-rel-loongarch.c
 loongarch_KEXEC_SRCS += kexec/arch/loongarch/crashdump-loongarch.c
+loongarch_KEXEC_SRCS += kexec/arch/loongarch/kexec-pez-loongarch.c
 
 loongarch_MEM_REGIONS = kexec/mem_regions.c
 
diff --git a/kexec/arch/loongarch/image-header.h b/kexec/arch/loongarch/image-header.h
index 3b7576552685..223d81f77d9f 100644
--- a/kexec/arch/loongarch/image-header.h
+++ b/kexec/arch/loongarch/image-header.h
@@ -33,6 +33,7 @@ struct loongarch_image_header {
 };
 
 static const uint8_t loongarch_image_pe_sig[2] = {'M', 'Z'};
+static const uint8_t loongarch_pe_machtype[6] = {'P','E', 0x0, 0x0, 0x64, 0x62};
 
 /**
  * loongarch_header_check_pe_sig - Helper to check the loongarch image header.
diff --git a/kexec/arch/loongarch/kexec-loongarch.c b/kexec/arch/loongarch/kexec-loongarch.c
index f47c99861674..62ff8fd1aeb7 100644
--- a/kexec/arch/loongarch/kexec-loongarch.c
+++ b/kexec/arch/loongarch/kexec-loongarch.c
@@ -165,6 +165,7 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 
 struct file_type file_type[] = {
 	{"elf-loongarch", elf_loongarch_probe, elf_loongarch_load, elf_loongarch_usage},
+	{"pez-loongarch", pez_loongarch_probe, pez_loongarch_load, pez_loongarch_usage},
 	{"pei-loongarch", pei_loongarch_probe, pei_loongarch_load, pei_loongarch_usage},
 };
 int file_types = sizeof(file_type) / sizeof(file_type[0]);
diff --git a/kexec/arch/loongarch/kexec-loongarch.h b/kexec/arch/loongarch/kexec-loongarch.h
index 5120a26fd513..2c7624f2fd3a 100644
--- a/kexec/arch/loongarch/kexec-loongarch.h
+++ b/kexec/arch/loongarch/kexec-loongarch.h
@@ -27,6 +27,10 @@ int pei_loongarch_probe(const char *buf, off_t len);
 int pei_loongarch_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void pei_loongarch_usage(void);
+int pez_loongarch_probe(const char *kernel_buf, off_t kernel_size);
+int pez_loongarch_load(int argc, char **argv, const char *buf, off_t len,
+		       struct kexec_info *info);
+void pez_loongarch_usage(void);
 
 int loongarch_process_image_header(const struct loongarch_image_header *h);
 
diff --git a/kexec/arch/loongarch/kexec-pez-loongarch.c b/kexec/arch/loongarch/kexec-pez-loongarch.c
new file mode 100644
index 000000000000..942a47c0eade
--- /dev/null
+++ b/kexec/arch/loongarch/kexec-pez-loongarch.c
@@ -0,0 +1,90 @@
+/*
+ * LoongArch PE compressed Image (vmlinuz, ZBOOT) support.
+ * Based on arm64 code
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include "kexec.h"
+#include "kexec-loongarch.h"
+#include <kexec-pe-zboot.h>
+#include "arch/options.h"
+
+static int kernel_fd = -1;
+static off_t decompressed_size;
+
+/* Returns:
+ * -1 : in case of error/invalid format (not a valid PE+compressed ZBOOT format.
+ */
+int pez_loongarch_probe(const char *kernel_buf, off_t kernel_size)
+{
+	int ret = -1;
+	const struct loongarch_image_header *h;
+	char *buf;
+	off_t buf_sz;
+
+	buf = (char *)kernel_buf;
+	buf_sz = kernel_size;
+	if (!buf)
+		return -1;
+	h = (const struct loongarch_image_header *)buf;
+
+	dbgprintf("%s: PROBE.\n", __func__);
+	if (buf_sz < sizeof(struct loongarch_image_header)) {
+		dbgprintf("%s: Not large enough to be a PE image.\n", __func__);
+		return -1;
+	}
+	if (!loongarch_header_check_pe_sig(h)) {
+		dbgprintf("%s: Not an PE image.\n", __func__);
+		return -1;
+	}
+
+	if (buf_sz < sizeof(struct loongarch_image_header) + h->pe_header) {
+		dbgprintf("%s: PE image offset larger than image.\n", __func__);
+		return -1;
+	}
+
+	if (memcmp(&buf[h->pe_header],
+		   loongarch_pe_machtype, sizeof(loongarch_pe_machtype))) {
+		dbgprintf("%s: PE header doesn't match machine type.\n", __func__);
+		return -1;
+	}
+
+	ret = pez_prepare(buf, buf_sz, &kernel_fd, &decompressed_size);
+
+	/* Fixme: add sanity check of the decompressed kernel before return */
+	return ret;
+}
+
+int pez_loongarch_load(int argc, char **argv, const char *buf, off_t len,
+			struct kexec_info *info)
+{
+	if (kernel_fd > 0 && decompressed_size > 0) {
+		char *kbuf;
+		off_t nread;
+
+		info->kernel_fd = kernel_fd;
+		/*
+		 * slurp_fd will close kernel_fd, but it is safe here
+		 * due to no kexec_file_load support.
+		 */
+		kbuf = slurp_fd(kernel_fd, NULL, decompressed_size, &nread);
+		if (!kbuf || nread != decompressed_size) {
+			dbgprintf("%s: slurp_fd failed.\n", __func__);
+			return -1;
+		}
+		return pei_loongarch_load(argc, argv, kbuf, decompressed_size, info);
+	}
+
+	dbgprintf("%s: wrong kernel file descriptor.\n", __func__);
+	return -1;
+}
+
+void pez_loongarch_usage(void)
+{
+	printf(
+"     An LoongArch vmlinuz, PE image of a compressed, little endian.\n"
+"     kernel, built with ZBOOT enabled.\n\n");
+}
-- 
2.37.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
