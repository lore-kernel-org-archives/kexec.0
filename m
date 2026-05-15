Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8032CCD343F
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zaLNJCVWymRzHzAosL0l4Cb63oV8tVc7xKx597eZEkQ=; b=bck2eod75z3vXY2KpT5my+LUKW
	rK+b6TWKWJVFnIFy0Ew2STKw6Uju2FhMrlyqVOaDdal59IiD1LTkrnEYWDxTANAHKwuZ/MsPcIBjm
	NsCMZS4azsrUUZPskQoWF/MtdYLhEsMyUqJdRlt/gWWpkQj8N7EEoRnih3xWUtuNOBsoPzlmOhAJc
	TR2aqwJtVYCy+vx/y312agJLQOTrFXHRUx+CMPa7BlErr1pG7bVa8bCFNrbENS6gAAQqjpbu2DiXG
	eDTT0jbiUB2P/2C6pfJJyaFEAPAUgyfClZSoz/3JxLN5QWj6BtAjvVUM3jLZVAC4y9J4D7yGfArOv
	zWdEOUnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzrj-00000009TFo-2uDV;
	Fri, 15 May 2026 21:14:39 +0000
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzrg-00000009TCp-2ppR
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:14:39 +0000
Received: by mail-dl1-x122b.google.com with SMTP id a92af1059eb24-1354403c610so388937c88.0
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879676; x=1779484476; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaLNJCVWymRzHzAosL0l4Cb63oV8tVc7xKx597eZEkQ=;
        b=sqg2P+CVXpzFOV87gXkKamrHib9Tu/AzoK2jGPSxG76VJJkEnZIZePqwdCzmP6Kvvo
         zWR0rQ3DtbhMAWGfkbbcTqFZcY7N4l11ekGvHHSqX1cHTbYzvbjxwWOJOtrH7j5xj3m+
         qE2lix1rYQwhdEhXUco/8n5iQfNKrG02ZJBkSXABziR4QF4+Zq1RTzJIb55g0LqVT6Fm
         9Dm0Mi28ahvrVhIaPYtPgzcdNGnlvGrUqrqkmhAtENzdYZA7hy4WvqdGpeRzoW7FDICT
         I94DADFS1lorp5EJnJp0B2rqpKqpad8Fs8nGQFHN7J5JThooQl6LY0g49tyilrTJUZdU
         a3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879676; x=1779484476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zaLNJCVWymRzHzAosL0l4Cb63oV8tVc7xKx597eZEkQ=;
        b=e9WuPp31I7LYi6ocX00ty+BwujFwFqcR0I9sjqegOpLSYNlQ6PEQHF+3oyk9f9rmTI
         vY7DY7/UuOHUw6VQCa1IBG7+aADA5EsRHqA2ckgMWfOkYjBqdYnEpjqbSTYGZ+p8BnTT
         3H3NPfK3mKngrtYeeCS6ap0OTLVWpAhz/9RAUrkKp0fZzUYamFp72vi90Ry7XpL0kyzD
         XcYz2XTRZCuhklSxNHRZNVxzooPtH+eaRSez47As5gg0IvIJuOweSxmFsxxAXBU37lKR
         W021KsCIYzy/lr+SOp8aPpDNRcdn0BfjvJy1NTvZ/7LHxEJwCrzg4pXAKo6wvKL3mmlL
         u59A==
X-Forwarded-Encrypted: i=1; AFNElJ8SVDc/sVmfpnAm6dMo0c13TvC/nl4NCUtqBPpbPupUMBm+J61aUjwSWQdwGeVGS/rl0coS1Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YyQOSaLBZ/tGHA2cwxpdM6DJU+37hXJwEZJWEjLG8jnIOI4hehm
	/+8mNQ5wFbnZReVhOtfRnIUHpZQZ2p9oOg2CX9MuByRpj9+HJxXP3Tzq
X-Gm-Gg: Acq92OEv1FSu/UNrsBSoopOj0b/jHr1hKxOilPnoXhJ0g33hEtPWU1HN+EbZfjuwfIO
	oCZzllIgzooATT4B8nblPWq4OLBgwKLqbgiHdbydoH088eSR/n8sBBou3Ps91aoaod3K3k4dp7K
	jrt8nRXKFu+HyQE+Jn4SotZygecbhY1KOcA3ZKtXjHnmENM8MUxsQ5J4N7cMHFd0g+msmGYYiry
	omMqRNnp84z6xeBeIKySSo33/CKgg0vMJFfXwWxvFDwafuLPbTwVQOpJ9PtPtAc3j1dggpdeW+6
	3kICpzARNiBxVIm4zYhvOAbHHayj7XrhqfwprBsyl7xuSpf6siYQhvZuGBPa1uU4F96w7QzbwT0
	wq9+AtDot1tF+pgDVjxvEIUI75YisVQs0C7V9u82nFhBL4ngz88NzVr31B4Jv8W+767MG+7sjad
	qVTz5Kg5i3x8Lteh9BWZTCnYIspLQ2NxU=
X-Received: by 2002:a05:7022:6b9a:b0:12d:de3e:86aa with SMTP id a92af1059eb24-13505642857mr2505039c88.40.1778879675567;
        Fri, 15 May 2026 14:14:35 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc33a618sm11242540c88.12.2026.05.15.14.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:35 -0700 (PDT)
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
Subject: [PATCH v16 08/38] tpm-buf: Remove chip parameter from tpm_buf_append_handle()
Date: Fri, 15 May 2026 14:13:40 -0700
Message-ID: <20260515211410.31440-9-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_141436_729227_1C2753CA 
X-CRM114-Status: GOOD (  13.77  )
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

Remove the TPM driver chip parameter from the function
tpm_buf_append_handle(). The chip parameter is only for error logging
which can be done with other facilities like WARN().

Message-ID: <20260125192526.782202-11-jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm-buf.c       | 9 ++++++---
 drivers/char/tpm/tpm2-cmd.c      | 2 +-
 drivers/char/tpm/tpm2-sessions.c | 2 +-
 include/linux/tpm.h              | 2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 61833b4d81f0..99811809a72a 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -146,17 +146,20 @@ EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
 
 /**
  * tpm_buf_append_handle() - Add a handle
- * @chip:	&tpm_chip instance
  * @buf:	&tpm_buf instance
  * @handle:	a TPM object handle
  *
  * Add a handle to the buffer, and increase the count tracking the number of
  * handles in the command buffer. Works only for command buffers.
  */
-void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u32 handle)
+void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle)
 {
+	if (buf->flags & TPM_BUF_INVALID)
+		return;
+
 	if (buf->flags & TPM_BUF_TPM2B) {
-		dev_err(&chip->dev, "Invalid buffer type (TPM2B)\n");
+		WARN(1, "tpm-buf: invalid type: TPM2B\n");
+		buf->flags |= TPM_BUF_INVALID;
 		return;
 	}
 
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 1fa3e8a43c79..c9dc35b57687 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -198,7 +198,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		}
 		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
 	} else {
-		tpm_buf_append_handle(chip, &buf, pcr_idx);
+		tpm_buf_append_handle(&buf, pcr_idx);
 		tpm_buf_append_auth(chip, &buf, NULL, 0);
 	}
 
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 3b1cf1ca0420..eb67ae14ad73 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -257,7 +257,7 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 #endif
 
 	if (!tpm2_chip_auth(chip)) {
-		tpm_buf_append_handle(chip, buf, handle);
+		tpm_buf_append_handle(buf, handle);
 		return 0;
 	}
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 3c6a5bcc138a..b357f8971d03 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -235,7 +235,7 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
 u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset);
 u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
 u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
-void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u32 handle);
+void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle);
 
 /*
  * Check if TPM device is in the firmware upgrade mode.
-- 
2.47.3


