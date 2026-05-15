Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05619CD4851
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rg1O72SYx+Mww3ZjC2LhL3IwBU8aOcEM6iuwyJssfKc=; b=aBTMsu/LVRmU5YgqqSfhOUEzJg
	BjJSTpkrFQ+1AihXQjA9XiZwPBP6HTaluBM0q/CedRuczRVuLvxqUGvr7J91ub2SOsYxn0ZdkpDKV
	mjv3JC7aAeo+W/J/xpATuSkH5jN3BP6tu9tP2DvUz1moPL2O2RV2TKybSPmk+u+XHc0KiJIwi6Zfz
	7X95PoG5v5jgimrjwhmqH12G1xDsPCpeXycR4GBpbGm8MhVRu1oWoLrqn+rnL2DQneuuxfX4tJUJG
	POe3vDuPfLpHkvYcGekwNp9wX1bm5bCwK044/FLZDp3byD8Clzot9cULSW+AME7YD341hKhsVe2x7
	wwx7S1FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzrP-00000009T19-05sR;
	Fri, 15 May 2026 21:14:19 +0000
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzrM-00000009Szw-1IgJ
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:14:17 +0000
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-2b4520f6b32so434585eec.0
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879655; x=1779484455; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rg1O72SYx+Mww3ZjC2LhL3IwBU8aOcEM6iuwyJssfKc=;
        b=byj7v9Aaa2vqeWvZfN41jFFZfqZbyNHIVkJn8RBfJLIKF7wZ7pzMCokFBMbW9fuhxy
         PCN8d2h8ZRF9oKAbebjNK5kWgoyYBegx9e+Z91W9sCJYTSZE4sKROoUdJ/Bn770UeQ9J
         /Jsm0+uIDXZJBgfEWOrDq+YbFtvun1ilY7CYMkg/GcVfQuLxLrbP5rxX8krJYInhMeTJ
         mPKX/82/LBYgtlH1kY138GrNbNYaO+CQc4jqlCcltKekMcgaqhKfc7lW+PVKtLAO3nz/
         xU69PoCUewAGFwt7FGRV+Dw14gzgSq/5AAOEAO9xtY6IhXXBUbJAhxSawkZmGgdPDwxf
         +sqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879655; x=1779484455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rg1O72SYx+Mww3ZjC2LhL3IwBU8aOcEM6iuwyJssfKc=;
        b=kCMK5x40v13lEI4iSJvUMTe7xXOItzXMjr26UJ9uoM478jiBxDK1Ic7Nkh9BoDZIOq
         ClDokEWnLce5iAuDxthAod2tltzaIrsCNCt8UXfglGoh3AUkNdcjHw2BhW43yLpzg7eX
         DjtjjzoCQniZTTR33uCpdwHLgJeJus5CbHKx63wGrFvSk+S06Q9yvPLOB+SfQdd9IVV+
         RKXG0NtSiRnXSw76H0ZfYOO9CVApuioKFiNQjr2i/pAVwLOuWhwpFmsQrUCF2MqIoo1B
         Wp8aqXp8LbW26JxBscs+2147fRwNt+QxP0OB9EAwUcT6tPEH17BSMMzfnPkxMqD2ZQ9R
         6+YA==
X-Forwarded-Encrypted: i=1; AFNElJ9o9dTTQnRaiJI4QA56xVmcngT7M3TdGE5a3JlA/2AbGk4owlnhXK68IrGn6RnyxJAfxVmxBA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzTFSz/Oitxx1MF/X6v6rTR1ywydTp+ILUUhRIYAeDScbTSrqg2
	hTjJbp5HuyAGUdXP2AtrwcmtJ5MOZn8AKuL9XjYQwc72EMumxyXB3ynx
X-Gm-Gg: Acq92OHgsKPKsA0F/2VlMwz0H/hCsq3AjmGlHMoJnwCwcapo//grnLYrADln1H4OYPJ
	WXlSZHRhLQSxhig14zHmBfv+nzPOUEVfytwJh0wUTp77PRiSShv0gvXYLm3C/HEuvgdMMtZs3l2
	6fnhGJ1mv+m0N0m4e5qQYZBYliH7hJqRQ4bFPlCpirvu89xO+aqwHhUQlAyG5/6hoktg7SvA882
	JNFKKFAg7A3C1DOQwSr9aoTJs7MZvVQ2SQLI7lKo0O4YAjf23BqtvqDt5A2BZcQRj1o31/E2Eil
	mjv6OsbnWmx4vkSvw3hVcQJZw1GZk5jYLpR2zA5MWlLcWWNIFUk43lvslVKtj2JWPeiCaKQG5tL
	JCZQYmf0j4FNwt9JJqXS9kYfociMgw+Ibeo5Z+BD7cxSfH78f62I0FhAV+eT0/BlzMLRRwh4ZEf
	8536Q4UNf3+zmusLRCPzEQganb81ZBaCM=
X-Received: by 2002:a05:7300:6c05:b0:2d8:df01:d9f6 with SMTP id 5a478bee46e88-3039864d5c1mr2737865eec.23.1778879655311;
        Fri, 15 May 2026 14:14:15 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302947e917dsm8003313eec.12.2026.05.15.14.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:14 -0700 (PDT)
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
Subject: [PATCH v16 01/38] tpm: Initial step to reorganize TPM public headers
Date: Fri, 15 May 2026 14:13:33 -0700
Message-ID: <20260515211410.31440-2-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_141416_354584_3E8E8D0F 
X-CRM114-Status: GOOD (  13.13  )
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

Consolidate TPM1 constants in tpm_command.h and remove duplicate
constants from tpm1-cmd.c.

Co-developed-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Co-developed-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm-buf.c                |  1 -
 drivers/char/tpm/tpm1-cmd.c               | 14 +-------
 include/keys/trusted_tpm.h                |  1 -
 include/linux/tpm.h                       |  2 ++
 include/linux/tpm_command.h               | 41 ++++++++++++++++-------
 security/keys/trusted-keys/trusted_tpm1.c |  1 -
 security/keys/trusted-keys/trusted_tpm2.c |  1 -
 7 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index dc882fc9fa9e..4c4f450630df 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -3,7 +3,6 @@
  * Handling of TPM command and other buffers.
  */
 
-#include <linux/tpm_command.h>
 #include <linux/module.h>
 #include <linux/tpm.h>
 
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index b49a790f1bd5..664ca1fff2e8 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -22,8 +22,6 @@
 
 #include "tpm.h"
 
-#define TPM_MAX_ORDINAL 243
-
 /*
  * Array with one entry per ordinal defining the maximum amount
  * of time the chip could take to return the result.  The ordinal
@@ -308,9 +306,6 @@ unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 		return duration;
 }
 
-#define TPM_ORD_STARTUP 153
-#define TPM_ST_CLEAR 1
-
 /**
  * tpm1_startup() - turn on the TPM
  * @chip: TPM chip to use
@@ -459,7 +454,6 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
 	return 0;
 }
 
-#define TPM_ORD_PCR_EXTEND 20
 int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 		    const char *log_msg)
 {
@@ -478,7 +472,6 @@ int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 	return rc;
 }
 
-#define TPM_ORD_GET_CAP 101
 ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		    const char *desc, size_t min_cap_length)
 {
@@ -511,7 +504,6 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 }
 EXPORT_SYMBOL_GPL(tpm1_getcap);
 
-#define TPM_ORD_GET_RANDOM 70
 struct tpm1_get_random_out {
 	__be32 rng_data_len;
 	u8 rng_data[TPM_MAX_RNG_DATA];
@@ -580,13 +572,12 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	return rc;
 }
 
-#define TPM_ORD_PCRREAD 21
 int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 {
 	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCRREAD);
+	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_READ);
 	if (rc)
 		return rc;
 
@@ -609,7 +600,6 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 	return rc;
 }
 
-#define TPM_ORD_CONTINUE_SELFTEST 83
 /**
  * tpm1_continue_selftest() - run TPM's selftest
  * @chip: TPM chip to use
@@ -726,8 +716,6 @@ int tpm1_auto_startup(struct tpm_chip *chip)
 	return rc;
 }
 
-#define TPM_ORD_SAVESTATE 152
-
 /**
  * tpm1_pm_suspend() - pm suspend handler
  * @chip: TPM chip to use.
diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
index 0fadc6a4f166..3a0fa3bc8454 100644
--- a/include/keys/trusted_tpm.h
+++ b/include/keys/trusted_tpm.h
@@ -3,7 +3,6 @@
 #define __TRUSTED_TPM_H
 
 #include <keys/trusted-type.h>
-#include <linux/tpm_command.h>
 
 extern struct trusted_key_ops trusted_key_tpm_ops;
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 202da079d500..1846d5485a2c 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -25,6 +25,8 @@
 #include <crypto/hash_info.h>
 #include <crypto/aes.h>
 
+#include <linux/tpm_command.h>
+
 #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
 
 #define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
index f5c03e9c3913..174b043d8bbc 100644
--- a/include/linux/tpm_command.h
+++ b/include/linux/tpm_command.h
@@ -3,27 +3,42 @@
 #define __LINUX_TPM_COMMAND_H__
 
 /*
- * TPM Command constants from specifications at
- * http://www.trustedcomputinggroup.org
+ * == TPM 1 Family Chips ==
+ *
+ * TPM 1.2 Main Specification:
+ * https://trustedcomputinggroup.org/resource/tpm-main-specification/
  */
 
+#define TPM_MAX_ORDINAL	243
+
 /* Command TAGS */
-#define TPM_TAG_RQU_COMMAND             193
-#define TPM_TAG_RQU_AUTH1_COMMAND       194
-#define TPM_TAG_RQU_AUTH2_COMMAND       195
-#define TPM_TAG_RSP_COMMAND             196
-#define TPM_TAG_RSP_AUTH1_COMMAND       197
-#define TPM_TAG_RSP_AUTH2_COMMAND       198
+enum tpm_command_tags {
+	TPM_TAG_RQU_COMMAND		= 193,
+	TPM_TAG_RQU_AUTH1_COMMAND	= 194,
+	TPM_TAG_RQU_AUTH2_COMMAND	= 195,
+	TPM_TAG_RSP_COMMAND		= 196,
+	TPM_TAG_RSP_AUTH1_COMMAND	= 197,
+	TPM_TAG_RSP_AUTH2_COMMAND	= 198,
+};
 
 /* Command Ordinals */
-#define TPM_ORD_GETRANDOM               70
-#define TPM_ORD_OSAP                    11
-#define TPM_ORD_OIAP                    10
-#define TPM_ORD_SEAL                    23
-#define TPM_ORD_UNSEAL                  24
+enum tpm_command_ordinals {
+	TPM_ORD_CONTINUE_SELFTEST	= 83,
+	TPM_ORD_GET_CAP			= 101,
+	TPM_ORD_GET_RANDOM		= 70,
+	TPM_ORD_PCR_EXTEND		= 20,
+	TPM_ORD_PCR_READ		= 21,
+	TPM_ORD_OSAP			= 11,
+	TPM_ORD_OIAP			= 10,
+	TPM_ORD_SAVESTATE		= 152,
+	TPM_ORD_SEAL			= 23,
+	TPM_ORD_STARTUP			= 153,
+	TPM_ORD_UNSEAL			= 24,
+};
 
 /* Other constants */
 #define SRKHANDLE                       0x40000000
 #define TPM_NONCE_SIZE                  20
+#define TPM_ST_CLEAR			1
 
 #endif
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 6ea728f1eae6..0d3244af8de3 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -18,7 +18,6 @@
 #include <keys/trusted-type.h>
 #include <linux/key-type.h>
 #include <linux/tpm.h>
-#include <linux/tpm_command.h>
 
 #include <keys/trusted_tpm.h>
 
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 6340823f8b53..29d79c05ed6b 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -9,7 +9,6 @@
 #include <linux/string.h>
 #include <linux/err.h>
 #include <linux/tpm.h>
-#include <linux/tpm_command.h>
 
 #include <keys/trusted-type.h>
 #include <keys/trusted_tpm.h>
-- 
2.47.3


