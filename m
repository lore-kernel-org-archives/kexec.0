Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A507CD343F
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=azOcaoqgBG4GOjXSMRG7UYVXI2K8VE7Oo8FvV1FqK6Y=; b=4VEwJhVq5JRlUY1FHCoG+HzHI7
	tDJRl66x40z7712z8hZInk3V8Rgcbov3E+JbwNtwsLsp/sVfJIsyEb8wUeP+9hJ+KY9e8uRr+I3IH
	Us1hvJ6IG2Mrj447Y3YQHGnTNpVTm5R7XiZBwMIheh08uwPP0OQLX4e5WS9Up0IKHKdbSDZF26FBq
	V04Tn8NDqnGYRWfzKDkxIwhJ+Ym2KQVSI5fD+NYFfm+ieKJCJwUR45hLbg9Fh4G/nRqdUDPMxbQ8n
	ANDO3WkiwCtEWTlIgI7/xxgwW8EzXzekOmDpbhtl3aQZ8zuEhwc8P32xIAF9dGTgqXBmwGsnF9LlL
	LqRE5QdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzsD-00000009TcW-1x7a;
	Fri, 15 May 2026 21:15:09 +0000
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzs8-00000009TZ1-2UTN
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:15:06 +0000
Received: by mail-dl1-x1234.google.com with SMTP id a92af1059eb24-1329fc4bf77so361565c88.1
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879704; x=1779484504; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azOcaoqgBG4GOjXSMRG7UYVXI2K8VE7Oo8FvV1FqK6Y=;
        b=jk05Z0M4GElKtuRJqQ1e0pybZqnuIxdK/KfaUWpiwpl2yB5wMAFRePzNln8YAKzr03
         cnzeXKkqjMCWQdE5W+KkSIllrSpcRFDrhrcmTnInDy6lO449ryUJ9ILelX/d8yrL7NEt
         mH8FgAEWK5cVX1q1Q9vA8AWc2zEkVnpISk2COjdahT1zclxnbnLlRYf8qZkMpMpjbnMG
         nebY6gJ4rlYphRZeuC86HSFTX/3KjH21hyA+aiJ17T+tQG9x6GiPovDlpUkEOiashsx6
         ytDk9zCrxNG0mV+6w6Yac5L1BuSjiIN6HW1UePpkbsMLo+73Z6xRbglaykiJDkjxArpO
         B3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879704; x=1779484504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=azOcaoqgBG4GOjXSMRG7UYVXI2K8VE7Oo8FvV1FqK6Y=;
        b=JXj91jtdwRw5q2kPgfiqmjBxxTfkGu0oElQeCNsOOBZOMkeTdo8fv7xjY8TAvamb86
         pruIT9zrC6TOcC6Voj74Eb+bWNY4kQOi0dJWPHR5aJ6Gv0eHB2UaxEuXOqykCHOfR+j4
         3fMaxXszMs9EvZa9wbtKljInr7u/mrtXSWWPFe8BJEAB6wcGcuO40uF6MNoW06vTJRrV
         PO9+oK5WKayf1CCfLduAiULZB8p+t0DEbcCqMB3n1oc6g6Fef9IWJ0jgkMAbmZTJrOS/
         r9HHKJVX7q8ULYkeXKAydU2h1VThoIeTJLfBlr/pR6NxZVI2PqpE3a2voTam46ROC/Xm
         TnPg==
X-Forwarded-Encrypted: i=1; AFNElJ80tnxwP1P9XP8cP2LTMjEX4J7cZssLAQpYNiK70/8my/Z6mEGiuJ5BaiJoRqYml/Xfv4SrCw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzPEgHBENmdckSg15MDy2/UUQsTCc7T8TNQNmPvcda/T6FCHEdr
	KrYrmPf2K3z9Xcf7P1pastCK5/8hrHMy4Lu/c0vW4izweiSCGmwclpxl
X-Gm-Gg: Acq92OFkAmle3BETQW3wRvyVoBUzNvT93+/r91UjPjcpnJxgWYI0d8PPwP0oPB1RZ9x
	FcDgTEth7sC4WrN83dliS6e4IVBUi0y4HI4j0Xw94NcjbZ0QUC1UUsSO7u5td5lUmjvC+PBYbAN
	5ucfZZAtZmvTo9IsM25PddHsCshYS+ytrznUNKFGDsYz7qnD3Sn3K/9XkdMRGNt9w2F58V6xH3n
	O8Nme4fqqjLMy1OatSSpWHgZVuuwvkzGCHz4+YDgaYRw3eAcXzRkbhrDK3goNvGxtnUvXA+TgR6
	GvvN7yCUaoCZxEW5D7Wi5jwmR2xj0Mlr3aJwPDRLi2JaL4t8u8S5Nkjigdw65vwrYMcq5F0Zw/N
	q5ToreKDemGnVyl8sAnwazjmDpkcypQDG5CXS68W3F8OjU3vqw+6flTxAnMeg5iw5ZdMBwsrphM
	bG9r+9kbF2beFvwGLSfhj9ZdRTauAH3kw=
X-Received: by 2002:a05:7022:239d:b0:133:598c:2b45 with SMTP id a92af1059eb24-1350494e3f6mr2888720c88.31.1778879703912;
        Fri, 15 May 2026 14:15:03 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc3490bcsm9740638c88.15.2026.05.15.14.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:03 -0700 (PDT)
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
Subject: [PATCH v16 18/38] x86/efi: Secure Launch Resource Table EFI definitions header file
Date: Fri, 15 May 2026 14:13:50 -0700
Message-ID: <20260515211410.31440-19-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_141504_661091_5BA3A656 
X-CRM114-Status: GOOD (  12.08  )
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

The Secure Launch EFI definitions are contained in the Secure Launch
Specification. The definitions are split out into a separate header
file for compilation purposes for EFI vs non-EFI environments in the
kernel.

The specification can be found here:
https://github.com/TrenchBoot/documentation/blob/master/specifications/secure-launch-specification.rst

Co-developed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 include/linux/slr_efi.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 include/linux/slr_efi.h

diff --git a/include/linux/slr_efi.h b/include/linux/slr_efi.h
new file mode 100644
index 000000000000..5de87a9b38aa
--- /dev/null
+++ b/include/linux/slr_efi.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * EFI Definitions for Secure Launch Resource Table
+ *
+ * See TrenchBoot Secure Launch kernel documentation for details.
+ *
+ * Copyright (c) 2026 Apertus Solutions, LLC
+ * Copyright (c) 2026, Oracle and/or its affiliates.
+ */
+
+#ifndef _LINUX_SLR_EFI_H
+#define _LINUX_SLR_EFI_H
+
+#include <linux/slr_table.h>
+
+#ifndef __ASSEMBLER__
+
+/* EFI Support */
+
+/* SLR table GUID for registering as an EFI Configuration Table (put this in efi.h if it becomes a standard) */
+#define SLR_TABLE_GUID			EFI_GUID(0x877a9b2a, 0x0385, 0x45d1, 0xa0, 0x34, 0x9d, 0xac, 0x9c, 0x9e, 0x56, 0x5f)
+
+/* Secure Launch EFI runtime protocol */
+#define EFI_SLAUNCH_PROTOCOL_GUID	EFI_GUID(0x534189e0, 0x6fde, 0x413d,  0xbe, 0x91, 0xcd, 0x4e, 0x8d, 0x67, 0x2f, 0xea)
+
+struct efi_slaunch_protocol {
+	efi_status_t
+	(__efiapi *setup_dlme)(struct efi_slaunch_protocol *this,
+			       u64 dlme_base,
+			       u64 dlme_header_offset,
+			       u64 dlme_table);
+
+	efi_status_t
+	(__efiapi *launch)(struct efi_slaunch_protocol *this);
+};
+typedef struct efi_slaunch_protocol efi_slaunch_protocol_t;
+
+#endif /* !__ASSEMBLER__ */
+
+#endif /* _LINUX_SLR_EFI_H */
-- 
2.47.3


