Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3405CCD5BCF
	for <kexec@archiver.kernel.org>; Tue, 26 May 2026 05:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mhjJIdMJSZbwgW0echWW60aABdTn/FljUdA0qAn9t7A=; b=w2EcJuTQyxXzDXiv1jNMGuTHnP
	Px1WbIgZSEpisCclbpXxAK4A/IjbMwA/c7k+mqB1jfHScdXIYAKoef5ev8vYwvOJ9suYl+ap8W67g
	gOy4GbYuOjQNHPTk2xvpABZ5sYg03Qg5yTPI3tKVKgSwn642zKdPXV+YA+Dtg7oWGmaU2j7bnJEmF
	SMbVT80a4adeuQaG/fo97IiFvqW2VQogad1LyCiO5T1klg6yrwgVZoXZP9yT6lIqtnN1L525pbycW
	+t5CgTloVuV+ZwYZWGL1LBijmgkx/gAemOgyEt5n9JJWKQph2oezPlL7qTNYwAJniML3dtAjMsiu6
	MbUexF8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRjyQ-0000000131h-1po3;
	Tue, 26 May 2026 05:05:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRjyN-0000000130h-195O
	for kexec@lists.infradead.org;
	Tue, 26 May 2026 05:05:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779771896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mhjJIdMJSZbwgW0echWW60aABdTn/FljUdA0qAn9t7A=;
	b=g2wL4qA1jXAkVzCpB9v8zun22+EHHFo1ef29U6ptWSKu2JbFoC6JWPrhj7gpYZfcVv9toI
	7xR5M/w9bd3J85Au8rs54y+eUJJWeqR8HLDSA0yEMc2riU4e8s4zlzgs0jrvl6iTlKTZ6R
	o4iLlafNHo6LuZtUsfcDzAeN6GG0oBQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-Pb8rAq00OmWIK4LGEiukvA-1; Tue, 26 May 2026 01:04:52 -0400
X-MC-Unique: Pb8rAq00OmWIK4LGEiukvA-1
X-Mimecast-MFC-AGG-ID: Pb8rAq00OmWIK4LGEiukvA_1779771891
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2e8bba2e6so136540905ad.1
        for <kexec@lists.infradead.org>; Mon, 25 May 2026 22:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779771891; x=1780376691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhjJIdMJSZbwgW0echWW60aABdTn/FljUdA0qAn9t7A=;
        b=ZCveKAGYIlfpaSRE7klaAdnLoCxkgeOY1Gu0eXTO4Oof+NAcCRik1QWXnickF5Xqfy
         mOhoztC6DzV7igIQ8CWxtVHTvcQFfgcGDn/DgqGZ3xj9S4UGv/i64X0NYfUctu20msj5
         mWjWuhVy7VGua3H5TIla5sm0otrbeTC+zCcdpvMQQYGSSRz1yZD6ELFb5brdHiavC9N+
         l41PTUKJziOKfsXOoc3gXvsFTndEu3cC9mPnX1phiQ1yKD7sSOazA2p5+ZSAjD8qxlf8
         bp938mWQebAyWQfCIM4Mc18JvvX3mbxBzZXgvjk3OUFj0Om5hrfSDQYts0ntrGS+Z955
         in7A==
X-Gm-Message-State: AOJu0Yx4yHL/0WlSXp9H+PBcHiL9kVMaiV4me6pWRntB/DAMVUYBlTCw
	x/wC1ef2Cv+cOzrTJ7hT2XMPjuLc21gyJKfdWUasbnCA+Hdzeqenk9wIpEuqOYzUBMRAdDhwh4k
	uwHo+gdVzyS2Jw6aR0gcbqkS+P/Y/goG8w24kFxNuILj6zoKMVNB5ya+xqmRZPDyrDAPItayb+P
	RH0UvRBOFvTnz6nxq1RPfRvVX0ZAMVC6tfyX0qnPSo
X-Gm-Gg: Acq92OFSdU2uhmWO8Xfuj6EECQZXEDgccj8j9zTVBeugjMe1p3FvTE9JdKoVZ9eKdq1
	gSerodGgieakR+LV/o0ptpTfiMxwExeHNWKP2TBM5jfeBck+AdE2Tb6OUMp0cxnr75Mhghf2Xnk
	l5L7vKvH+npPnAP/d0P/fVgvyYE83Shk9PqjlXzf3a2TDstW5NYgiyA8TUhkzJzpUIDlcQjKr8O
	IoYT2rGQAnCoivLEbVJo3gzbsP7LcxRhfNVOL+qnfjeORIk3IjvoaBq0ZomzuLCvMqWBxjagys9
	B1DWXb6/19NHqsxoRFPOXNGFd8eCPhS4ASlAIpBZQxUQSFAellQ+LLlzocm/blBh9S5DKAsb3wR
	UyAUgn6XZDqGgPeNLXoVLilZvUjxzQP90zx6jJDAwu/o18k+lpoEVlQwwXwkBKmC9lF0T
X-Received: by 2002:a17:902:d2c1:b0:2bd:b6f6:3446 with SMTP id d9443c01a7336-2beb0633f1emr195413005ad.3.1779771891444;
        Mon, 25 May 2026 22:04:51 -0700 (PDT)
X-Received: by 2002:a17:902:d2c1:b0:2bd:b6f6:3446 with SMTP id d9443c01a7336-2beb0633f1emr195412725ad.3.1779771890911;
        Mon, 25 May 2026 22:04:50 -0700 (PDT)
Received: from localhost.localdomain.com (122-63-87-145.mobile.spark.co.nz. [122.63.87.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695a29sm105606325ad.11.2026.05.25.22.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 22:04:50 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: kexec@lists.infradead.org
Cc: horms@kernel.org,
	Tao Liu <ltao@redhat.com>
Subject: [kexec-tools][PATCH] RISC-V: add kexec_load support for vmlinuz
Date: Tue, 26 May 2026 16:58:07 +1200
Message-ID: <20260526045806.23933-2-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QW1vMTGDHEgw04LjhAVRPjE3IVzmA753ux8kbCGkqGc_1779771891
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_220459_398179_F1AA1B4C 
X-CRM114-Status: GOOD (  20.41  )
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

Copy arm64 code and change for riscv so that the kexec -c can load
a vmlinuz image.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 kexec/arch/riscv/Makefile              |   1 +
 kexec/arch/riscv/image-header.h        |  12 +++
 kexec/arch/riscv/kexec-riscv.c         |   1 +
 kexec/arch/riscv/kexec-riscv.h         |   6 ++
 kexec/arch/riscv/kexec-vmlinuz-riscv.c | 112 +++++++++++++++++++++++++
 5 files changed, 132 insertions(+)
 create mode 100644 kexec/arch/riscv/kexec-vmlinuz-riscv.c

diff --git a/kexec/arch/riscv/Makefile b/kexec/arch/riscv/Makefile
index 18a997b..6ba8976 100644
--- a/kexec/arch/riscv/Makefile
+++ b/kexec/arch/riscv/Makefile
@@ -4,6 +4,7 @@
 riscv_KEXEC_SRCS = kexec/arch/riscv/crashdump-riscv.c
 riscv_KEXEC_SRCS += kexec/arch/riscv/kexec-elf-riscv.c
 riscv_KEXEC_SRCS += kexec/arch/riscv/kexec-image-riscv.c
+riscv_KEXEC_SRCS += kexec/arch/riscv/kexec-vmlinuz-riscv.c
 riscv_KEXEC_SRCS += kexec/arch/riscv/kexec-riscv.c
 
 riscv_DT_OPS += kexec/dt-ops.c
diff --git a/kexec/arch/riscv/image-header.h b/kexec/arch/riscv/image-header.h
index a677546..7e950ee 100644
--- a/kexec/arch/riscv/image-header.h
+++ b/kexec/arch/riscv/image-header.h
@@ -85,4 +85,16 @@ static inline uint64_t riscv_header_image_size(const struct riscv_image_header *
 	return le64toh(h->image_size);
 }
 
+static const uint8_t riscv_image_pe_sig[2] = {'M', 'Z'};
+static const uint8_t riscv_pe_machtype[6] = {'P','E', 0x0, 0x0, 0x64, 0x50};
+
+static inline int riscv_header_check_pe_sig(const struct riscv_image_header *h)
+{
+	if (!h)
+		return 0;
+
+	return (*((char *)&(h->code0)) == riscv_image_pe_sig[0] &&
+		*((char *)&(h->code0) + 1) == riscv_image_pe_sig[1]);
+}
+
 #endif
diff --git a/kexec/arch/riscv/kexec-riscv.c b/kexec/arch/riscv/kexec-riscv.c
index a5a12a0..a7188ac 100644
--- a/kexec/arch/riscv/kexec-riscv.c
+++ b/kexec/arch/riscv/kexec-riscv.c
@@ -34,6 +34,7 @@ const struct arch_map_entry arches[] = {
 struct file_type file_type[] = {
 	{"elf-riscv", elf_riscv_probe, elf_riscv_load, elf_riscv_usage},
 	{"image-riscv", image_riscv_probe, image_riscv_load, image_riscv_usage},
+	{"vmlinuz-riscv", pez_riscv_probe, pez_riscv_load, pez_riscv_usage},
 };
 int file_types = sizeof(file_type) / sizeof(file_type[0]);
 
diff --git a/kexec/arch/riscv/kexec-riscv.h b/kexec/arch/riscv/kexec-riscv.h
index cfb0377..f487b27 100644
--- a/kexec/arch/riscv/kexec-riscv.h
+++ b/kexec/arch/riscv/kexec-riscv.h
@@ -51,3 +51,9 @@ int image_riscv_probe(const char *buf, off_t len);
 void image_riscv_usage(void);
 int image_riscv_load(int argc, char **argv, const char *buf, off_t len,
 		   struct kexec_info *info);
+
+/* kexec-vmlinuz-riscv.c */
+int pez_riscv_probe(const char *buf, off_t len);
+void pez_riscv_usage(void);
+int pez_riscv_load(int argc, char **argv, const char *buf, off_t len,
+		   struct kexec_info *info);
diff --git a/kexec/arch/riscv/kexec-vmlinuz-riscv.c b/kexec/arch/riscv/kexec-vmlinuz-riscv.c
new file mode 100644
index 0000000..6430e37
--- /dev/null
+++ b/kexec/arch/riscv/kexec-vmlinuz-riscv.c
@@ -0,0 +1,112 @@
+/*
+ * RISC-V PE compressed Image (vmlinuz, ZBOOT) support.
+ * Based on arm64 code
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include "kexec.h"
+#include "kexec-riscv.h"
+#include "image-header.h"
+#include <kexec-pe-zboot.h>
+#include "arch/options.h"
+
+static int kernel_fd = -1;
+static off_t decompressed_size;
+
+/* Returns:
+ * -1 : in case of error/invalid format (not a valid PE+compressed ZBOOT format.
+ */
+int pez_riscv_probe(const char *kernel_buf, off_t kernel_size)
+{
+	int ret = -1;
+	const struct riscv_image_header *h;
+	char *buf;
+	off_t buf_sz;
+
+	buf = (char *)kernel_buf;
+	buf_sz = kernel_size;
+	if (!buf)
+		return -1;
+	h = (const struct riscv_image_header *)buf;
+
+	dbgprintf("%s: PROBE.\n", __func__);
+	if (buf_sz < sizeof(struct riscv_image_header)) {
+		dbgprintf("%s: Not large enough to be a PE image.\n", __func__);
+		return -1;
+	}
+	if (!riscv_header_check_pe_sig(h)) {
+		dbgprintf("%s: Not an PE image.\n", __func__);
+		return -1;
+	}
+
+	if (buf_sz < sizeof(struct riscv_image_header) + h->res3) {
+		dbgprintf("%s: PE image offset larger than image.\n", __func__);
+		return -1;
+	}
+
+	if (memcmp(&buf[h->res3],
+		   riscv_pe_machtype, sizeof(riscv_pe_machtype))) {
+		dbgprintf("%s: PE header doesn't match machine type.\n", __func__);
+		return -1;
+	}
+
+	ret = pez_prepare(buf, buf_sz, &kernel_fd, &decompressed_size);
+
+	if (!ret) {
+	    /* validate the riscv specific header */
+	    struct riscv_image_header hdr_check;
+	    if (read(kernel_fd, &hdr_check, sizeof(hdr_check)) != sizeof(hdr_check))
+		goto bad_header;
+
+	    lseek(kernel_fd, 0, SEEK_SET);
+
+	    if (!riscv_header_check_magic(&hdr_check)) {
+		dbgprintf("%s: Bad riscv image header.\n", __func__);
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
+int pez_riscv_load(int argc, char **argv, const char *buf, off_t len,
+			struct kexec_info *info)
+{
+	if (kernel_fd > 0 && decompressed_size > 0) {
+		char *kbuf;
+		off_t nread;
+		int fd;
+
+		if (info->kernel_fd > 0)
+			close(info->kernel_fd);
+		info->kernel_fd = kernel_fd;
+		fd = dup(kernel_fd);
+		if (fd < 0) {
+			dbgprintf("%s: dup fd failed.\n", __func__);
+			return -1;
+		}
+		kbuf = slurp_fd(fd, NULL, decompressed_size, &nread);
+		if (!kbuf || nread != decompressed_size) {
+			dbgprintf("%s: slurp_fd failed.\n", __func__);
+			return -1;
+		}
+		return image_riscv_load(argc, argv, kbuf, decompressed_size, info);
+	}
+
+	dbgprintf("%s: wrong kernel file descriptor.\n", __func__);
+	return -1;
+}
+
+void pez_riscv_usage(void)
+{
+	printf(
+"     An RISC-V vmlinuz, PE image of a compressed, little endian.\n"
+"     kernel, built with ZBOOT enabled.\n\n");
+}
-- 
2.47.0


