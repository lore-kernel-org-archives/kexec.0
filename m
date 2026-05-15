Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2760DCD343F
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kFmz/IKFkr+yHkTTECqlvzt5xXCg9R4f8VRlkTmPQhI=; b=mzmVhNy4qDUH1l/UIUSLi6Z/7R
	x7E9AsnLvN+OqoTL5kmLAD9YplmW/GBVZvaXELEr4LJsOh30eYW/ELziN5SJTujY9FLMTrNJ/LpXt
	H7yFR57K4cjpl5kkcX1d9omH7G5RB7UB6Sh7pHZi3AFwKirDUFEpg+L7JCN0rFdcHhcnNihZ4MTK3
	8whwMaszQmXD/qvfXQK4x49q62bY6mB/DRqxHyWaAUVu9iRkd1wc72L1M6pb2PJT+9cOVQQiGyHTJ
	Mx5G4XXIicZ96Ic3COGjnLk/yH6M1z9/ukLIrekJaiOBNanVLbCkb1SPES8qN9GZeg4hCsc9o+XkD
	aYdKiefg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzrX-00000009T66-1AkG;
	Fri, 15 May 2026 21:14:27 +0000
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzrU-00000009T4N-3n04
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:14:26 +0000
Received: by mail-dl1-x122e.google.com with SMTP id a92af1059eb24-134ac81c445so953057c88.1
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879664; x=1779484464; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFmz/IKFkr+yHkTTECqlvzt5xXCg9R4f8VRlkTmPQhI=;
        b=mK3Uc59mQWD0pLtmaPLLFGE7EIUCJFiRKNbHmM3cY5a77eMvLgyrI8zdCvRJB4fHeB
         6JFSXKhPTlT9Qo0t+ZEoBOu/u6Fik8imVJZXQgVoFE8F+EM0IEUdBncFEIyac1DHH6T3
         UJsGq6w7uWWEF3HBNXkKqJsZDFF1hwC38Tbxs2+9ASoD4Zl+xOPfr5SXS2QXSSCuBtGW
         ow4XDnwk/ONo8TN0aWmd37c+ao0QbdJ5NVAAAa6jRCAtBFcVHrvIDy+QIZc7VzFR8fQY
         ktC47HqyARJcVyLKYp+Zg9IrqCqeCry+qj1kChBTbAyElCL9HshpOLWbHcWYJHif8QzW
         0HEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879664; x=1779484464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kFmz/IKFkr+yHkTTECqlvzt5xXCg9R4f8VRlkTmPQhI=;
        b=XT9O/opKWnnHHIHjq575zBfZwKo4pPcwuNIWjzc4GeYgum6XTx4GAHccsMyHfuY0BN
         Q04tPs02EpUOY/If+zNiWVgH2579IGwga4Uc9SP03Kxdv3+vjXMxhN/yyaomBmmb1enp
         Oo8360jBFou022S1hHg3hIsp+sYwKasnoodNg5Y/x9fFdOAIDGabtYbGS+ag2pKJeAG+
         El2T1oKt89dKY6fTX/VQliirjzGMuF8znm4Jf8iqqKCvRJpVM496loGUZmroHgWjnIA3
         Bgo+XAn+v36PFulcoyfbHdAskDKM7AIFDeHZ5Z4c1XfK24Hnpbm69vnKVB6c9Mxt4QCI
         NVLA==
X-Forwarded-Encrypted: i=1; AFNElJ/4iPRJtF5aTR2CQYRrIzOtpFm5NHX3ovF2/qItZuUlk3ue31BMzVt3Yx7tQNWGs5DnsLvfLA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzJwM0cMgEmiT38f1oeItJrnzgBUmm3mgS2kb58FBWbwUAZmP0g
	FDwLRti4mCNOYcy0wTFNgaJMRBva6B9PrxGKU7oZq+I49VOSeh/Vd8CS
X-Gm-Gg: Acq92OGGYlSBdVgjilwyqfeWEI9yWzvGT4qrOP6r57tgtcWL+VcA0GJ4pcOx3nGLPcK
	at9Oo5nKDvB8AJH82qCG93aSMEaHiESGaYCTkuL0x7Qviddz5cXz76hCkP1gXNDd1E1ogo31+NB
	JI+qSfGUJbOyj3ekEh+sJnGHD4gRNcyKP79yD28dNnwOem9L4Ri3+pKmCfqRxF9optnDoVd3dNe
	F3e52zd3dLD15I4gEPeG/IXkCN9X/JZwI2oAmS7g1sJLlv2nD5UOvwpJHvcb5z1BTSghULAL+Zw
	P0MxwWAM/y85rYCswOPLR+SnkpvFKXYmDISv6qNjCqrRKd/WEpOOb4DFajn3zqqFl71gium/FI5
	RUD4NL+bAfc10vq0RuhZYQkS2t/ooOWoid/wy0e7LPPiQFzQtRba6nHZ/9lAmvU7/rHn4wQQZPx
	t71QOf2dkmADgU5rjsOj/FnaBi6vmBjNo=
X-Received: by 2002:a05:7022:4582:b0:132:5db9:27af with SMTP id a92af1059eb24-13504a49ademr2695477c88.35.1778879663897;
        Fri, 15 May 2026 14:14:23 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb93f3sm11145075c88.3.2026.05.15.14.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:23 -0700 (PDT)
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
Subject: [PATCH v16 04/38] tpm: Move TPM common base definitions to the command header
Date: Fri, 15 May 2026 14:13:36 -0700
Message-ID: <20260515211410.31440-5-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_141424_948578_21B1DA22 
X-CRM114-Status: GOOD (  15.42  )
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

These are top level definitions shared by both TPM 1 and 2
family chips. This includes core definitions like TPM localities,
common crypto algorithm IDs, and the base TPM command header.

Co-developed-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Co-developed-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 include/linux/tpm.h         | 50 +--------------------
 include/linux/tpm_command.h | 89 +++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 49 deletions(-)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 8551b24c2bff..3630b2ea6aef 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -27,49 +27,12 @@
 
 #include <linux/tpm_command.h>
 
-#define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
-
-#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
-#define TPM2_MAX_PCR_BANKS	8
-
 struct tpm_chip;
 struct trusted_key_payload;
 struct trusted_key_options;
 /* opaque structure, holds auth session parameters like the session key */
 struct tpm2_auth;
 
-/* if you add a new hash to this, increment TPM_MAX_HASHES below */
-enum tpm_algorithms {
-	TPM_ALG_ERROR		= 0x0000,
-	TPM_ALG_SHA1		= 0x0004,
-	TPM_ALG_AES		= 0x0006,
-	TPM_ALG_KEYEDHASH	= 0x0008,
-	TPM_ALG_SHA256		= 0x000B,
-	TPM_ALG_SHA384		= 0x000C,
-	TPM_ALG_SHA512		= 0x000D,
-	TPM_ALG_NULL		= 0x0010,
-	TPM_ALG_SM3_256		= 0x0012,
-	TPM_ALG_ECC		= 0x0023,
-	TPM_ALG_CFB		= 0x0043,
-};
-
-/*
- * maximum number of hashing algorithms a TPM can have.  This is
- * basically a count of every hash in tpm_algorithms above
- */
-#define TPM_MAX_HASHES	5
-
-struct tpm_digest {
-	u16 alg_id;
-	u8 digest[TPM2_MAX_DIGEST_SIZE];
-} __packed;
-
-struct tpm_bank_info {
-	u16 alg_id;
-	u16 digest_size;
-	u16 crypto_id;
-};
-
 enum TPM_OPS_FLAGS {
 	TPM_OPS_AUTO_STARTUP = BIT(0),
 };
@@ -127,7 +90,7 @@ struct tpm_chip_seqops {
 	const struct seq_operations *seqops;
 };
 
-/* fixed define for the curve we use which is NIST_P256 */
+/* Fixed define for the curve we use which is NIST_P256 */
 #define EC_PT_SZ	32
 
 /*
@@ -209,8 +172,6 @@ struct tpm_chip {
 #endif
 };
 
-#define TPM_HEADER_SIZE		10
-
 static inline enum tpm2_mso_type tpm2_handle_mso(u32 handle)
 {
 	return handle >> 24;
@@ -239,15 +200,6 @@ enum tpm_chip_flags {
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
 
-struct tpm_header {
-	__be16 tag;
-	__be32 length;
-	union {
-		__be32 ordinal;
-		__be32 return_code;
-	};
-} __packed;
-
 enum tpm_buf_flags {
 	/* the capacity exceeded: */
 	TPM_BUF_OVERFLOW	= BIT(0),
diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
index 9dd903dd6b5c..96edebd9610f 100644
--- a/include/linux/tpm_command.h
+++ b/include/linux/tpm_command.h
@@ -427,4 +427,93 @@ struct tpm2_context {
 	__be16 blob_size;
 } __packed;
 
+/*
+ * == TPM Common Defs ==
+ */
+
+#define TPM_DIGEST_SIZE		20	/* Max TPM v1.2 PCR size */
+#define TPM_BUFSIZE		4096
+
+/*
+ * SHA-512 is, as of today, the largest digest in the TCG algorithm repository.
+ */
+#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
+
+/*
+ * A TPM name digest i.e., TPMT_HA, is a concatenation of TPM_ALG_ID of the
+ * name algorithm and hash of TPMT_PUBLIC.
+ */
+#define TPM2_MAX_NAME_SIZE	(TPM2_MAX_DIGEST_SIZE + 2)
+
+/*
+ * Fixed define for the size of a name.  This is actually HASHALG size
+ * plus 2, so 32 for SHA256
+ */
+#define TPM2_NULL_NAME_SIZE	34
+
+/*
+ * The maximum number of PCR banks.
+ */
+#define TPM2_MAX_PCR_BANKS	8
+
+/* If you add a new hash to this, increment TPM_MAX_HASHES below */
+enum tpm_algorithms {
+	TPM_ALG_ERROR		= 0x0000,
+	TPM_ALG_SHA1		= 0x0004,
+	TPM_ALG_AES		= 0x0006,
+	TPM_ALG_KEYEDHASH	= 0x0008,
+	TPM_ALG_SHA256		= 0x000B,
+	TPM_ALG_SHA384		= 0x000C,
+	TPM_ALG_SHA512		= 0x000D,
+	TPM_ALG_NULL		= 0x0010,
+	TPM_ALG_SM3_256		= 0x0012,
+	TPM_ALG_ECC		= 0x0023,
+	TPM_ALG_CFB		= 0x0043,
+};
+
+/*
+ * The locality (0 - 4) for a TPM, as defined in section 3.2 of the
+ * Client Platform Profile Specification.
+ */
+enum tpm_localities {
+	TPM_LOCALITY_0		= 0, /* Static RTM */
+	TPM_LOCALITY_1		= 1, /* Dynamic OS */
+	TPM_LOCALITY_2		= 2, /* DRTM Environment */
+	TPM_LOCALITY_3		= 3, /* Aux Components */
+	TPM_LOCALITY_4		= 4, /* CPU DRTM Establishment */
+	TPM_MAX_LOCALITY	= TPM_LOCALITY_4
+};
+
+/*
+ * Structure to represent active PCR algorithm banks usable by the
+ * TPM chip.
+ */
+struct tpm_bank_info {
+	u16 alg_id;
+	u16 digest_size;
+	u16 crypto_id;
+};
+
+/*
+ * Maximum number of hashing algorithms a TPM can have.  This is
+ * basically a count of every hash in tpm_algorithms above
+ */
+#define TPM_MAX_HASHES		5
+
+struct tpm_digest {
+	u16 alg_id;
+	u8 digest[TPM2_MAX_DIGEST_SIZE];
+} __packed;
+
+#define TPM_HEADER_SIZE		10
+
+struct tpm_header {
+	__be16 tag;
+	__be32 length;
+	union {
+		__be32 ordinal;
+		__be32 return_code;
+	};
+} __packed;
+
 #endif
-- 
2.47.3


