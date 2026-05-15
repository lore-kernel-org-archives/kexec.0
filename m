Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F77CCD4851
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q5U2oXqABMo/EXd3140iU8ar3y05m7m/a9rRtZzhgJM=; b=NOvue6OJaszENPoqheksWLiiHU
	PmrvniigJzSmPrmwO6IqShewDIDJcJ5rcEhWYzxcjiYlC8olAks94+EgkUTKu/vE/bNmL1nyfSSQB
	7hWIMMOvqi6s4+VkNUskW8sZhk8bM7ZHs5MFd3M2pS57C8og79/B6XjixrgkmhCoInXyHM5o3RgEC
	5gWBC2XD7nGzKu063Ef0spYpBFkxg7hgemeaeKltPmHkJY2/aJP8KVaJ51JqSJRmmn1IvEHvNfabH
	EzUcK2zIja6l1omx43xIA/eL/hln8smfdgPKNDvyeE3+khkUDKmOfteOgsneH3SKrvarURGM4eB8V
	EhyLGYNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzrg-00000009TCv-2JTw;
	Fri, 15 May 2026 21:14:36 +0000
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzrd-00000009TAh-2Im9
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:14:34 +0000
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-2f68f3b075fso1100943eec.0
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879673; x=1779484473; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5U2oXqABMo/EXd3140iU8ar3y05m7m/a9rRtZzhgJM=;
        b=csxWevuWlY/+JWDNGaR9LRdbOwXDQFECAVhZXUzkM9EktKkJPbrV+3SrJyB4MfOtMu
         Ua5NGae6O7rSAKvF6U5N6vQTRI4TofGHs4wXqU6pPND8JooS2Ifie1OzAq9i9r68X+Cq
         j3PbotCDOdqup/bDtaMHGQt7qlODU8MlDfCaP1gS9SJhGXawlc2dYZU4f3ZfYgChaEKb
         vxcmbON2Ju1MpE/jZRlLWoiWzQPJpbAI3Da8iHSMn9AfzBLiozo4JAa61SE1eW8/NDI2
         nK72XwpOwXp23CuUFmAisnyH+hnH4g7Qb73n6Xo5mxmbYrzFety3O1mUK4XT+3DP9PeG
         /QMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879673; x=1779484473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q5U2oXqABMo/EXd3140iU8ar3y05m7m/a9rRtZzhgJM=;
        b=mrYEr4e0VzAfV0/ZZxBXtlJikMbG8gFSSvZGfF2OchHq7GCmrw3Zf+fCCKOUmZYXeB
         3/6JghIr35/IP8kcmuMTWbxLOiBTo0Ehe2vtg7PyGfv+HTa6nbKfVzioaLKcZTpX2sAs
         PauQu4B0Sxg5847zLwVIG4iCbo7rIlA5unonSSzaaF9l5HixQpSdUWrEEomBKGCHkTis
         m33PUWAgRM4MR2IxAPBprSHYMaCQ4NTteZFKbd2yLOyft3I57HZEpFnDPy98CZlDO62q
         xDu1Mn2gjML6nv1CXIGtRfOLE99zpPuDNADpJiCG/gpledPAxiC0SKpCiZ1+Lrf7litw
         yqpA==
X-Forwarded-Encrypted: i=1; AFNElJ8VDAUAGz+P/VelaUdBtmj3LVlz1hUKLCdb6nPvvEHFyn1wp2yeIDB2XRSgEBtAl09sHPHQuw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzV02Ka4F+9cDY9qz5N9UyCNaMcR3YvcAc3Vvj4RdQ5HAFPUr6Q
	GTVrW6kIXmOFMS07CcBV77dYxFZZ4M9FmiOn81uxk4EvVhws4JQfG1wL
X-Gm-Gg: Acq92OFVcoYzoqJK7BTujd5j3U6Fve6hdiiLwbWxFIW3E2wycrSpfzTV4SQsH+Z/4m4
	OeWjveQ2M+pavGjNZvaX3CPiJVApyLMcxvBkCJWzQ8IbbtGW1pxaJx5I+M2JiLfbCWuyZAJjk47
	bYZ+OKKpH17BktQ2aS93xRUw0Uah9MUd4hd8YKZ6tglqsnW31iZ9XjPG1cAfBKraAoe6O7BGbmD
	HRUREJf6tfu6eXJ1fQFpWoC6NOoRobjO5MryGyEnQqYUdBxZoCSDTnLvju9F+QbCtHHNLIIV3AN
	8eLnWFTvNUmgXiqc4fpABx5dh6Y5C44LMZb6jkHvXgV9SsugkHvfZeBnn8U6Y46aKdEIjrYUvx3
	MqXtrXdzSaVr+HWxv+YaE3Jsf3JvwJaZEk/70gLIX7COZ3ZS52Q6I3+YPTXo257SgTgDeYcOpI3
	+odlKlLS9NLkaBtquzlSSQUwMp2jeGqDk=
X-Received: by 2002:a05:7300:b913:b0:2f4:3a9c:8193 with SMTP id 5a478bee46e88-3039862655amr2733579eec.16.1778879672589;
        Fri, 15 May 2026 14:14:32 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bc8ddsm7829907eec.21.2026.05.15.14.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:32 -0700 (PDT)
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
Subject: [PATCH v16 07/38] tpm-buf: Merge TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW
Date: Fri, 15 May 2026 14:13:39 -0700
Message-ID: <20260515211410.31440-8-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_141433_600401_9B00BBA5 
X-CRM114-Status: GOOD (  13.05  )
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

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Merge TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW into TPM_BUF_INVALID,
given that they are identical (the only difference being the associated
log messages).

In addition, add a missing TPM_BUF_INVALID check to tpm_buf_append_handle()
following the pattern from other functions in tpm-buf.c.

Message-ID: <20260125192526.782202-11-jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Reviewed-by: Jonathan McDowell <noodles@meta.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm-buf.c                | 10 ++++------
 include/linux/tpm.h                       |  8 +++-----
 security/keys/trusted-keys/trusted_tpm2.c |  6 +++---
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 4c4f450630df..61833b4d81f0 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -103,13 +103,12 @@ EXPORT_SYMBOL_GPL(tpm_buf_length);
  */
 void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
 {
-	/* Return silently if overflow has already happened. */
-	if (buf->flags & TPM_BUF_OVERFLOW)
+	if (buf->flags & TPM_BUF_INVALID)
 		return;
 
 	if ((buf->length + new_length) > PAGE_SIZE) {
 		WARN(1, "tpm_buf: write overflow\n");
-		buf->flags |= TPM_BUF_OVERFLOW;
+		buf->flags |= TPM_BUF_INVALID;
 		return;
 	}
 
@@ -176,14 +175,13 @@ static void tpm_buf_read(struct tpm_buf *buf, off_t *offset, size_t count, void
 {
 	off_t next_offset;
 
-	/* Return silently if overflow has already happened. */
-	if (buf->flags & TPM_BUF_BOUNDARY_ERROR)
+	if (buf->flags & TPM_BUF_INVALID)
 		return;
 
 	next_offset = *offset + count;
 	if (next_offset > buf->length) {
 		WARN(1, "tpm_buf: read out of boundary\n");
-		buf->flags |= TPM_BUF_BOUNDARY_ERROR;
+		buf->flags |= TPM_BUF_INVALID;
 		return;
 	}
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 3630b2ea6aef..3c6a5bcc138a 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -201,12 +201,10 @@ enum tpm_chip_flags {
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
 
 enum tpm_buf_flags {
-	/* the capacity exceeded: */
-	TPM_BUF_OVERFLOW	= BIT(0),
 	/* TPM2B format: */
-	TPM_BUF_TPM2B		= BIT(1),
-	/* read out of boundary: */
-	TPM_BUF_BOUNDARY_ERROR	= BIT(2),
+	TPM_BUF_TPM2B		= BIT(0),
+	/* The buffer is in invalid and unusable state: */
+	TPM_BUF_INVALID		= BIT(1),
 };
 
 /*
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 29d79c05ed6b..779a2e66ac20 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -312,7 +312,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	/* creation PCR */
 	tpm_buf_append_u32(&buf, 0);
 
-	if (buf.flags & TPM_BUF_OVERFLOW) {
+	if (buf.flags & TPM_BUF_INVALID) {
 		rc = -E2BIG;
 		tpm2_end_auth_session(chip);
 		goto out;
@@ -328,7 +328,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out;
 
 	blob_len = tpm_buf_read_u32(&buf, &offset);
-	if (blob_len > MAX_BLOB_SIZE || buf.flags & TPM_BUF_BOUNDARY_ERROR) {
+	if (blob_len > MAX_BLOB_SIZE || buf.flags & TPM_BUF_INVALID) {
 		rc = -E2BIG;
 		goto out;
 	}
@@ -441,7 +441,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 
 	tpm_buf_append(&buf, blob, blob_len);
 
-	if (buf.flags & TPM_BUF_OVERFLOW) {
+	if (buf.flags & TPM_BUF_INVALID) {
 		rc = -E2BIG;
 		tpm2_end_auth_session(chip);
 		goto out;
-- 
2.47.3


