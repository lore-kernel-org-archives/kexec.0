Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE68CD343F
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zvhJ+ydmVFUO/FtDIG83CBk7wY0hq1hCXhxrxXZ6CzE=; b=NVrg6VQX/Jbmi49t9QCVhBRbkj
	VXfbNh28NcScqvz2vbGF3zAeN2e/1x1ZEtiy5oT9+KPRhRH7DCdQO/KT0GBdXFAfTHiAh1oJZ8frG
	G1FodWCYX95bugrsYd6QmxRCVhqUfCdRNwSRcHjkZaurhVyrOCGVXT7l/UOnahgV6cpZuwbDhXORa
	MsDy3kbmHdEPje1Po6mceEzrawcBv8VaQxnRCNTvhiDiAtOP6OCrbqtVoew5z1516p6DGLt4HdqDQ
	tV3tYd/E31ZryOThFgTFDunwaT52Jmo049fj+sv0/2u70awIh+Xt5VwwpL9W8+F4YhzAZEzJK4j1v
	MiUoY2Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzra-00000009T8d-1emX;
	Fri, 15 May 2026 21:14:30 +0000
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzrX-00000009T6P-3T5p
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:14:29 +0000
Received: by mail-dl1-x1230.google.com with SMTP id a92af1059eb24-132c338a537so1026464c88.0
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879667; x=1779484467; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvhJ+ydmVFUO/FtDIG83CBk7wY0hq1hCXhxrxXZ6CzE=;
        b=aMein+aPSBevzFwbHVGfmSdt6PhhtuiyLfpzrAeS3YULMH/hDx6m9aCLqIqCKX6t0v
         kcWDJeF1lYTR/CxVZnXEDJwZG/Qkio125NmdWTcwTRQqPsx9BhWWAENNKzo2YUgTc7Dh
         JCAdZgo3Zun6GBh/8TKj1JO8c83a16JgVpsx0pRDmBje8JvQgw/chHI3oB+IeN18vzKR
         2ZRyzI+aWylIKQ/iUcJOlor6dLiHeJ7EjqcXX104yy8NQ98+fx6fAKKBYXJOpUC5KLGk
         l/ObnwB1VyC6rbdJU6O/gQDEt5Wxk/2K/nwRYDHoWfcTdrir29x0vJ/BnUTQAMtr+Cz6
         K88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879667; x=1779484467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zvhJ+ydmVFUO/FtDIG83CBk7wY0hq1hCXhxrxXZ6CzE=;
        b=UYgxjD1XkxLX/K2ej7CrVBn9x103fGcGYGqoCXWRIb8adyuzVaVSU62CmBtzKOBFKn
         EmSpBamPFXYFKuLA+s3a9pNMXaGBQyro6+Hog8eETwnqScMoyOnmtC5pA8US62VbOyMA
         sJeq0ViN5G0ZbK8zmGhcbvie/I4G2udyfLCc1cuE8PkhI1DLdahrW576rx3S6cDail4e
         PepHAqC8m0m3zj9ecsNGII7DwZUu7ve9lON2B5iaZH/VcbsW99WJOvZWMOuZmF40MuyJ
         h+tIgkZCWbpdP971HttejC4fZwWsx6CXvessUOcw6a2GlY2DqMZOwh50WA2P0NElBAYw
         Intw==
X-Forwarded-Encrypted: i=1; AFNElJ93+Ur4bX1qTbkcQoDEBN/WJvF1zLiWZqCAfG5QdS7ncvjv36VkSPgUs57zCK+/POpVdv1Biw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwToP/Zw1CL4GcvFW2os3s1qFuyQ03QP1XJLaiFK/+oL6dCke7k
	xtXieHHdHdAXTKMtHmHf2IUNEeOhJuJJthkvM5fTj+la/gKfuEf1nJe2
X-Gm-Gg: Acq92OHt4L/pFW8KF27lBCSF75ALdRO6Ww2p+R4Amyy9GmyHhXWf7d46RWSsxsdgt/z
	C/uE4kMcJtR+dabfpbMaPfpeRZ6uPVxd4S8If60UMtYcj3AASMPvlrrULlRyHskvs3rQJW2cNPA
	faJE96FeeTeY6eXa6kWC8pzsqAcB1lB+wiZ6xBwlmRC0lJQpjHr4jolmhO/pLvIBd8EMgD4LJX4
	70TepTbI/NYrwsrSc2iisyxvlj07hMBJwwncbTnuVyI2FqIfzTZk7D03M6omo28109nOprk9POC
	ybakuzDOWi0d5PXlrZslp9RLaka3sSNnri/4V8+YBZ66mR7vtrP4s6/dXQH8cZTdai2qFNyCZym
	Zn/YjyjXxxE25pngOH2oWltFrJYjYMCVRUJ3pnf8LnyTEdBv6qGUFk7Zc+WhmQQ1/ScxZ80q9f9
	5KSphmyhwkkN9F+BHqwyPYquBxr4RVc9C9Oq7jKeE0zA==
X-Received: by 2002:a05:7301:2a02:b0:2c1:67e1:61a9 with SMTP id 5a478bee46e88-303979af82emr2367379eec.13.1778879666828;
        Fri, 15 May 2026 14:14:26 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6f6sm9726668eec.17.2026.05.15.14.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:26 -0700 (PDT)
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
Subject: [PATCH v16 05/38] tpm: Move platform specific definitions to the new PTP header
Date: Fri, 15 May 2026 14:13:37 -0700
Message-ID: <20260515211410.31440-6-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_141427_876656_02020057 
X-CRM114-Status: GOOD (  17.11  )
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

These are definitions for TPM 2.0 interface and interactions with
the platform as defined in the TCG specification:

These definitions are located here in a separate file to avoid conflicts
with vendor specific TIS/FIFO definition (e.g. STMicroelectronics,
Infineon Technologies, etc). This allows the TCG defined TIS/FIFO
interface to be in a public header while the former chip specific
implementations contain their own definitions. TPM 1.x family chips
that adhere to the TCG specifications use the TIS/FIFO interface as
defined here.

TCG PC Client Platform TPM Profile (PTP) Specification
 - https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/

Co-developed-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Co-developed-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.h |  64 +-------------
 include/linux/tpm_ptp.h         | 151 ++++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+), 63 deletions(-)
 create mode 100644 include/linux/tpm_ptp.h

diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 6c3aa480396b..be68883ed399 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -19,71 +19,9 @@
 #ifndef __TPM_TIS_CORE_H__
 #define __TPM_TIS_CORE_H__
 
+#include <linux/tpm_ptp.h>
 #include "tpm.h"
 
-enum tis_access {
-	TPM_ACCESS_VALID = 0x80,
-	TPM_ACCESS_ACTIVE_LOCALITY = 0x20,
-	TPM_ACCESS_REQUEST_PENDING = 0x04,
-	TPM_ACCESS_REQUEST_USE = 0x02,
-};
-
-enum tis_status {
-	TPM_STS_VALID = 0x80,
-	TPM_STS_COMMAND_READY = 0x40,
-	TPM_STS_GO = 0x20,
-	TPM_STS_DATA_AVAIL = 0x10,
-	TPM_STS_DATA_EXPECT = 0x08,
-	TPM_STS_RESPONSE_RETRY = 0x02,
-	TPM_STS_READ_ZERO = 0x23, /* bits that must be zero on read */
-};
-
-enum tis_int_flags {
-	TPM_GLOBAL_INT_ENABLE = 0x80000000,
-	TPM_INTF_BURST_COUNT_STATIC = 0x100,
-	TPM_INTF_CMD_READY_INT = 0x080,
-	TPM_INTF_INT_EDGE_FALLING = 0x040,
-	TPM_INTF_INT_EDGE_RISING = 0x020,
-	TPM_INTF_INT_LEVEL_LOW = 0x010,
-	TPM_INTF_INT_LEVEL_HIGH = 0x008,
-	TPM_INTF_LOCALITY_CHANGE_INT = 0x004,
-	TPM_INTF_STS_VALID_INT = 0x002,
-	TPM_INTF_DATA_AVAIL_INT = 0x001,
-};
-
-enum tis_defaults {
-	TIS_MEM_LEN = 0x5000,
-	TIS_SHORT_TIMEOUT = 750,	/* ms */
-	TIS_LONG_TIMEOUT = 4000,	/* 4 secs */
-	TIS_TIMEOUT_MIN_ATML = 14700,	/* usecs */
-	TIS_TIMEOUT_MAX_ATML = 15000,	/* usecs */
-};
-
-/* Some timeout values are needed before it is known whether the chip is
- * TPM 1.0 or TPM 2.0.
- */
-#define TIS_TIMEOUT_A_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_A)
-#define TIS_TIMEOUT_B_MAX	max_t(int, TIS_LONG_TIMEOUT, TPM2_TIMEOUT_B)
-#define TIS_TIMEOUT_C_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_C)
-#define TIS_TIMEOUT_D_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_D)
-
-#define	TPM_ACCESS(l)			(0x0000 | ((l) << 12))
-#define	TPM_INT_ENABLE(l)		(0x0008 | ((l) << 12))
-#define	TPM_INT_VECTOR(l)		(0x000C | ((l) << 12))
-#define	TPM_INT_STATUS(l)		(0x0010 | ((l) << 12))
-#define	TPM_INTF_CAPS(l)		(0x0014 | ((l) << 12))
-#define	TPM_STS(l)			(0x0018 | ((l) << 12))
-#define	TPM_STS3(l)			(0x001b | ((l) << 12))
-#define	TPM_DATA_FIFO(l)		(0x0024 | ((l) << 12))
-
-#define	TPM_DID_VID(l)			(0x0F00 | ((l) << 12))
-#define	TPM_RID(l)			(0x0F04 | ((l) << 12))
-
-#define LPC_CNTRL_OFFSET		0x84
-#define LPC_CLKRUN_EN			(1 << 2)
-#define INTEL_LEGACY_BLK_BASE_ADDR	0xFED08000
-#define ILB_REMAP_SIZE			0x100
-
 enum tpm_tis_flags {
 	TPM_TIS_ITPM_WORKAROUND		= 0,
 	TPM_TIS_INVALID_STATUS		= 1,
diff --git a/include/linux/tpm_ptp.h b/include/linux/tpm_ptp.h
new file mode 100644
index 000000000000..143e887599bb
--- /dev/null
+++ b/include/linux/tpm_ptp.h
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Following copyright information was take from the original file
+ * <drivers/char/tpm/tpm_tis_core.h> where the definitions were moved
+ * from:
+ *
+ * Copyright (C) 2005, 2006 IBM Corporation
+ * Copyright (C) 2014, 2015 Intel Corporation
+ *
+ * Authors:
+ * Leendert van Doorn <leendert@watson.ibm.com>
+ * Kylene Hall <kjhall@us.ibm.com>
+ *
+ * Maintained by: <tpmdd-devel@lists.sourceforge.net>
+ *
+ * Device driver for TCG/TCPA TPM (trusted platform module).
+ * Specifications at www.trustedcomputinggroup.org
+ *
+ * This device driver implements the TPM interface as defined in
+ * the TCG TPM Interface Spec version 1.2, revision 1.0.
+ */
+
+#ifndef __LINUX_TPM_PTP_H__
+#define __LINUX_TPM_PTP_H__
+
+/*
+ * TCG PC Client Platform TPM Profile (PTP) Specification
+ * https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/
+ */
+
+/* TIS/FIFO macros and definitions */
+
+enum tis_access {
+	TPM_ACCESS_VALID		= 0x80,
+	TPM_ACCESS_ACTIVE_LOCALITY	= 0x20,	/* (R) */
+	TPM_ACCESS_RELINQUISH_LOCALITY	= 0x20, /* (W) */
+	TPM_ACCESS_REQUEST_PENDING	= 0x04,	/* (W) */
+	TPM_ACCESS_REQUEST_USE		= 0x02,	/* (W) */
+};
+
+enum tis_status {
+	TPM_STS_VALID		= 0x80, /* (R) */
+	TPM_STS_COMMAND_READY	= 0x40, /* (R) */
+	TPM_STS_DATA_AVAIL	= 0x10, /* (R) */
+	TPM_STS_DATA_EXPECT	= 0x08, /* (R) */
+	TPM_STS_GO		= 0x20, /* (W) */
+	TPM_STS_RESPONSE_RETRY	= 0x02, /* (R) */
+	TPM_STS_READ_ZERO	= 0x23, /* bits that must be zero on read */
+};
+
+enum tis_int_flags {
+	TPM_GLOBAL_INT_ENABLE		= 0x80000000,
+	TPM_INTF_BURST_COUNT_STATIC	= 0x100,
+	TPM_INTF_CMD_READY_INT		= 0x080,
+	TPM_INTF_INT_EDGE_FALLING	= 0x040,
+	TPM_INTF_INT_EDGE_RISING	= 0x020,
+	TPM_INTF_INT_LEVEL_LOW		= 0x010,
+	TPM_INTF_INT_LEVEL_HIGH		= 0x008,
+	TPM_INTF_LOCALITY_CHANGE_INT	= 0x004,
+	TPM_INTF_STS_VALID_INT		= 0x002,
+	TPM_INTF_DATA_AVAIL_INT		= 0x001,
+};
+
+enum tis_defaults {
+	TIS_MEM_LEN		= 0x5000,
+	TIS_SHORT_TIMEOUT	= 750,   /* ms */
+	TIS_LONG_TIMEOUT	= 4000,  /* 4 secs */
+	TIS_TIMEOUT_MIN_ATML	= 14700, /* usecs */
+	TIS_TIMEOUT_MAX_ATML	= 15000, /* usecs */
+};
+
+enum tis_x86_defaults {
+	TIS_MEM_X86_LPC_BASE		= 0xFED40000,
+	TIS_MEM_X86_LEN			= 0x5000,
+	INTEL_LEGACY_BLK_BASE_ADDR	= 0xFED08000,
+	ILB_REMAP_SIZE			= 0x100,
+	LPC_CNTRL_OFFSET		= 0x84,
+	LPC_CLKRUN_EN			= (1 << 2),
+};
+
+/*
+ * Some timeout values are needed before it is known whether the chip is
+ * TPM 1.0 or TPM 2.0.
+ */
+#define TIS_TIMEOUT_A_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_A)
+#define TIS_TIMEOUT_B_MAX	max_t(int, TIS_LONG_TIMEOUT, TPM2_TIMEOUT_B)
+#define TIS_TIMEOUT_C_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_C)
+#define TIS_TIMEOUT_D_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_D)
+
+#define	TPM_ACCESS(l)			(0x0000 | ((l) << 12))
+#define	TPM_INT_ENABLE(l)		(0x0008 | ((l) << 12))
+#define	TPM_INT_VECTOR(l)		(0x000C | ((l) << 12))
+#define	TPM_INT_STATUS(l)		(0x0010 | ((l) << 12))
+#define	TPM_INTF_CAPS(l)		(0x0014 | ((l) << 12))
+#define	TPM_STS(l)			(0x0018 | ((l) << 12))
+#define	TPM_STS3(l)			(0x001b | ((l) << 12))
+#define	TPM_DATA_FIFO(l)		(0x0024 | ((l) << 12))
+#define	TPM_INTF_ID(l)			(0x0030 | ((l) << 12))
+
+#define	TPM_DID_VID(l)			(0x0F00 | ((l) << 12))
+#define	TPM_RID(l)			(0x0F04 | ((l) << 12))
+
+/* TPM HW Interface and Capabilities */
+#define TPM_TIS_INTF_ACTIVE	0x00
+#define TPM_CRB_INTF_ACTIVE	0x01
+
+struct tpm_interface_id {
+	union {
+		u32 val;
+		struct {
+			u32 interface_type:4;
+			u32 interface_version:4;
+			u32 cap_locality:1;
+			u32 reserved1:4;
+			u32 cap_tis:1;
+			u32 cap_crb:1;
+			u32 cap_if_res:2;
+			u32 interface_selector:2;
+			u32 intf_sel_lock:1;
+			u32 reserved2:4;
+			u32 reserved3:8;
+		};
+	};
+} __packed;
+
+#define TPM_TIS_INTF_12		0x00
+#define TPM_TIS_INTF_13		0x02
+#define TPM2_TIS_INTF_13	0x03
+
+struct tpm_intf_capability {
+	union {
+		u32 val;
+		struct {
+			u32 data_avail_int_support:1;
+			u32 sts_valid_int_support:1;
+			u32 locality_change_int_support:1;
+			u32 interrupt_level_high:1;
+			u32 interrupt_level_low:1;
+			u32 interrupt_edge_rising:1;
+			u32 interrupt_edge_falling:1;
+			u32 command_ready_int_support:1;
+			u32 burst_count_static:1;
+			u32 data_transfer_size_support:2;
+			u32 reserved1:17;
+			u32 interface_version:3;
+			u32 reserved2:1;
+		};
+	};
+} __packed;
+
+#endif
-- 
2.47.3


