Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAF5CD343F
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n6vamoagHMf4GbheCVmViNC3dNcySHzOx3Jk2wuZ+G0=; b=Z+f1f8NlU242EDrMrrFxQ1EUCD
	L11DyVue8UtgC8S8qJmBt5VR8psyxmeqHqZgGHC5TB+6QiE4Z5JAGgZxWoQeHBdAZnkWqMnWwGvfe
	HX/l7UqCbWldwQ40ql7vQ2ZH7Zd++1sQ5Pbnlwevs3kc5JvYJyhpDn16YPAdO3qArCWBVUNTAEnOA
	QnJvvp4ny8P9gRKUmWMakJusP0uJflIOxjsHMKXCSf+q/B7GnwVubwyjTz8ImPjTJ5KOGPkN4/cqr
	/d5KyE7cLABdA5twvXqyzCX/3pZgwcHXLrHRVmINOVKdXPUOjCspmzNDqSkKJDvulpZvoaHZCezMP
	JPVSAbSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzro-00000009TIp-3ZIn;
	Fri, 15 May 2026 21:14:44 +0000
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzrm-00000009THN-1yjo
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:14:43 +0000
Received: by mail-dl1-x122c.google.com with SMTP id a92af1059eb24-1329fc4bf77so360292c88.1
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879681; x=1779484481; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6vamoagHMf4GbheCVmViNC3dNcySHzOx3Jk2wuZ+G0=;
        b=cOZzEPfuv8QM8/VNkj/bEsKRxN+LChmrYHPUhhRCwdg2DyBVvBGK0WugQ0jvfCrepA
         JfkgUHuNexThVMglDBAKUe0+e7xqm21By/fdVY/oKKlv5DBwuJG8wsOMOFSG+qr7AEVM
         q2A5FcCySj/YlL4fFBMEi16RAEOII7ECbmJJshOLDJGsHtN4MhhR2xNfhmFesPHYPxvN
         HfssdwHs8t1s0EdfF5d+LEVUX1D1hqhma8JZbe3S/sxjQ3zsdLzhJ4uXH75ht71DN4uL
         CQZd85JLDRPwT4MrlRYPvSz75pDBYvRlTupbg798Pg/6lfUBY4PnovEktDMKgIVowKY2
         CF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879681; x=1779484481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n6vamoagHMf4GbheCVmViNC3dNcySHzOx3Jk2wuZ+G0=;
        b=Sj0kn13BXsfCZh2zrnGAWuwNqA3PbhEEk36/K4d3/62g/BVjaFKxWdrDvKovYGFvSx
         PUM4cc1+kqPLlDBf8x16Sj3FQNIyioYFECdno6mqRH2yx+ul85eY7i8kr0bqpDJRygps
         k9418OJn7WoucgySDIkPzaZJKXiQr2kY5KE7H1vTLiEqmjAmfQLZNJxjzB+yy7kxJYc4
         BJjg+hQ5WRnGEslFt4IeXd8LibxeRcc9hF6Pcvts6ibqNeMdrih5l/fbtVfYUepNL+kh
         71qLyfiYtZxQSBV0Q7edyImgk3i3+n5F9K5qsHIdm3VNSsGJkUTwVZDFK9f7ECe9sAGn
         bk2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+1fYCuKBhGQdhuMu5JIJ5re4H5oEdT9t9kHCS2304JI4EBI0MQ+ls/FUMe5hlLKg1RjFfx1A==@lists.infradead.org
X-Gm-Message-State: AOJu0YxZtQEjsszK+x5lFw1sRDGzFE1xfGFf87/X0+jzxQfKtg0EGTMc
	28jz9HX/h1S84b1SwsXnUwmKnZUcIjA2XonRU/Y+a7ZRZSqKHfr/ePnq
X-Gm-Gg: Acq92OGypIpDWKSlTua1JDxYQRLsSxziIhML/u9T0Ip4tiu2JxNO0zcWrQtIIUtHQ83
	THTC9xwzv4hR870TnTbwvnASTcF9uEdq+GfhGFE99bI9gJ0gSGucUQbgA0uyj7o5EqeDpQtEm+m
	9sjQnCf88EafdTiuqTYkQ2wAIDJvrF7jxF+jZJX9lU1ypY8uwlgXjj9DQhsDpnJDYVZzC/IAabO
	m1b0otVfin/A6J6i9+VfKAgG3gsRfTFkcL5v2MJzjGSWG2gj8AY3HxhUYEnH9QyzxiiQYVPTrqx
	w5x05xHLnL/Xshn328mCfxPjWsRZqtcuSGkfZXzTqUtUrx3ZOlDAyXqCvvslE75H9OJMJycfncN
	uRlR9yhrslPfjV17UqSVAgi+Avo39G8jjI6oq9BH60LPrp7505VqalR0CXflYDiPMnCIpsIJ2RL
	KA7sv0sE7mGWY3KTut9alc20NDQtByawM=
X-Received: by 2002:a05:7022:f10e:b0:12d:ed19:e6aa with SMTP id a92af1059eb24-1350494e78fmr2605508c88.33.1778879681459;
        Fri, 15 May 2026 14:14:41 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb9ed3sm11076036c88.1.2026.05.15.14.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:41 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: ross.philipson@gmail.com,
	dpsmith@apertussolutions.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	luto@amacapital.net,
	nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	ebiederm@xmission.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v16 10/38] tpm-buf: Add TPM buffer support header for standalone reuse
Date: Fri, 15 May 2026 14:13:42 -0700
Message-ID: <20260515211410.31440-11-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_141442_518707_71ECD4BC 
X-CRM114-Status: GOOD (  15.27  )
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

Extract all the functions and definitions for TPM buffer handling
and separate them into their own header.

Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm-buf.c |  4 ++-
 include/linux/tpm.h        | 34 +----------------------
 include/linux/tpm_buf.h    | 57 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 34 deletions(-)
 create mode 100644 include/linux/tpm_buf.h

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index e79a8071c9ee..e81ce7215b1a 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -4,7 +4,9 @@
  */
 
 #include <linux/module.h>
-#include <linux/tpm.h>
+#include <crypto/sha2.h>
+#include <linux/tpm_command.h>
+#include <linux/tpm_buf.h>
 
 static void __tpm_buf_size_invariant(struct tpm_buf *buf, u16 buf_size)
 {
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 0a56f6c1ea98..0db277af45c3 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -26,6 +26,7 @@
 #include <crypto/aes.h>
 
 #include <linux/tpm_command.h>
+#include <linux/tpm_buf.h>
 
 struct tpm_chip;
 struct trusted_key_payload;
@@ -200,44 +201,11 @@ enum tpm_chip_flags {
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
 
-enum tpm_buf_flags {
-	/* TPM2B format: */
-	TPM_BUF_TPM2B		= BIT(0),
-	/* The buffer is in invalid and unusable state: */
-	TPM_BUF_INVALID		= BIT(1),
-};
-
-/*
- * A buffer for constructing and parsing TPM commands, responses and sized
- * (TPM2B) buffers.
- */
-struct tpm_buf {
-	u8 flags;
-	u8 handles;
-	u16 length;
-	u16 capacity;
-	u8 data[];
-};
-
 struct tpm2_hash {
 	unsigned int crypto_id;
 	unsigned int tpm_id;
 };
 
-void tpm_buf_init(struct tpm_buf *buf, u16 buf_size);
-void tpm_buf_init_sized(struct tpm_buf *buf, u16 buf_size);
-void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
-void tpm_buf_reset_sized(struct tpm_buf *buf);
-u16 tpm_buf_length(struct tpm_buf *buf);
-void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length);
-void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
-void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
-void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
-u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset);
-u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
-u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
-void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle);
-
 /*
  * Check if TPM device is in the firmware upgrade mode.
  */
diff --git a/include/linux/tpm_buf.h b/include/linux/tpm_buf.h
new file mode 100644
index 000000000000..7f8abb59de24
--- /dev/null
+++ b/include/linux/tpm_buf.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Following copyright information was take from the original file
+ * <include/linux/tpm.h> where the definitions were moved from:
+ *
+ * Copyright (C) 2004,2007,2008 IBM Corporation
+ *
+ * Authors:
+ * Leendert van Doorn <leendert@watson.ibm.com>
+ * Dave Safford <safford@watson.ibm.com>
+ * Reiner Sailer <sailer@watson.ibm.com>
+ * Kylene Hall <kjhall@us.ibm.com>
+ * Debora Velarde <dvelarde@us.ibm.com>
+ *
+ * Maintained by: <tpmdd_devel@lists.sourceforge.net>
+ *
+ * Device driver for TCG/TCPA TPM (trusted platform module).
+ * Specifications at www.trustedcomputinggroup.org
+ */
+
+#ifndef __LINUX_TPM_BUF_H__
+#define __LINUX_TPM_BUF_H__
+
+enum tpm_buf_flags {
+	/* TPM2B format: */
+	TPM_BUF_TPM2B		= BIT(0),
+	/* The buffer is in invalid and unusable state: */
+	TPM_BUF_INVALID		= BIT(1),
+};
+
+/*
+ * A buffer for constructing and parsing TPM commands, responses and sized
+ * (TPM2B) buffers.
+ */
+struct tpm_buf {
+	u8 flags;
+	u8 handles;
+	u16 length;
+	u16 capacity;
+	u8 data[];
+};
+
+void tpm_buf_init(struct tpm_buf *buf, u16 buf_size);
+void tpm_buf_init_sized(struct tpm_buf *buf, u16 buf_size);
+void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
+void tpm_buf_reset_sized(struct tpm_buf *buf);
+u16 tpm_buf_length(struct tpm_buf *buf);
+void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length);
+void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
+void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
+void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
+u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset);
+u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
+u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
+void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle);
+
+#endif
-- 
2.47.3


