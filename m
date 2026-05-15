Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1DBCD4851
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JUJQNdeVMNwfKTOPs21LgA+X7O3xhgiTOeD6RQEitLA=; b=CI1HbJsS22LNY3YzFxNWh8jPK2
	CwJNNwVcmPmSRIfiD4I/6zq+3gjG4CWKUQETGGgAgREFqnAqvmE5AB8SqzMp/5EB7vHB3C9co3rHk
	4QMxztpbaUHueMfvkc5uxalytUTSc9PcGfIO9LHsBRnRv3Ti3hdoFL9LBaFKrsi51MQNBObtIkIK3
	YstDOcIn3lAF+mYiFsEJ17xzt5kdazdKGdF8tgc1dNngCx1Ty/p5sPL0ifVjskHKyf5UwBepkql4Z
	TH9srPuzduXo0t/a9swXRFAVJXUx7AaxhvGjuCqEg3ff/6SIHW7Sr/e+Qzwr5OAmKNyu82t1IUiCH
	Ihgm640A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzrx-00000009TPO-1y6T;
	Fri, 15 May 2026 21:14:53 +0000
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzru-00000009TN3-2Fjv
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:14:51 +0000
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-2f0ad52830cso402589eec.1
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879690; x=1779484490; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUJQNdeVMNwfKTOPs21LgA+X7O3xhgiTOeD6RQEitLA=;
        b=EbqiNXmdFrAsk8/t5y8ASzbYja22Tpo9LlgtxjUr+5hhNCzRfQAQE0J7O4e13xl24Z
         94zx4sRgHk4L+poPu/xhzF2yRKjri77qH8/JEpYGGK2YHCDYBM+74bIdWmgBxzI9lzq8
         qrK+OSALEF7SC9GfsdcXz8zLoXjfITfC5SlDmis+pD22+SuxLFVYbzv9NDDsYWY3yyoQ
         9mDGOBikufND1lFpo+4QpXxTL+RoiJpNWSaqwyHjv3yLFaNvreegsYYZmkzgq1Fhc9NK
         OWYiGZttc/O5mMzic40czXbW0xexC/on85IPAnDI+ZrEITUNaAW9CBIPRow2BJ+S9MhK
         qNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879690; x=1779484490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JUJQNdeVMNwfKTOPs21LgA+X7O3xhgiTOeD6RQEitLA=;
        b=XjtSok+IfLZ+lLw+XGms79am2VXfjXRNWHdHNZ/t4H+mmzts0SzeoGeE5j9nLchPvF
         CuLlVJLfrY2yfVUsRilirIo77WCDe7hpZ3P/N1q5z347TMnllurIP2WduUnoMXwmahB8
         4HSDoOT9bBmvxu/C5rrjyHqkYGGvpg1aSy/9pgh53Kg9+9mJLYkLd+NyZ+YTAfvgAVOc
         TlpVRFVQIilcbwlWu90ANigbBn9BnSviMeGX1znNyS3Ie8VbmsKw8vBIMxxQt8DLlPWX
         v5cQCvcinQ8qz9EdzAV6/O99DhDDCOYInG08oFGfgKk+06JfutCSlK/LRHIDtSqSUA9r
         ViJQ==
X-Forwarded-Encrypted: i=1; AFNElJ817pczn+25zI/hpVk+mjU/3YXqLsfvkjQHgS7lcvNWWglZNdfpNL6D8y28mBDSGbKXd5gjNw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx0u3E6xiCDm65ypT7KGT6BMap9clJZNK7avfXLDYzbAR3odhyw
	TpwPSYA7dTjWbUTbgOvWdsgwqK32wvSKaUdh4jM8Q23KmSRoJ+Hmkykp
X-Gm-Gg: Acq92OE8p+eKrP9o0NfshuMpxgJhz5rcg4QBInswn5iZ8UtY+1ufsLRTqqUEQZUCVzc
	JJMVtLhz+QDFGcKjsFk1yrOJvxsHgcNgDjocSPwgyO2094KfPdeibyH3VIIBUuxV3PokoxTRqtM
	/YKheebKTc25ffUYvGKGZMUTwuSc8oTTig6cu9e8OFmHRC4Vg3ok0nmYPiC+IoNEtGwvBwKmvAc
	SQYKEUnKmSwTAb0m7pjyKK0A1FcO2H1Y6oHwHiwre51UVrf2YlA2KGARW24Go/SYCjUV7iXARJn
	R/G/JsdCir1QgO2XLrUyGMq6eS0QcfcHkWnJIjbdeWTO99OnY9I2QbH3QtRl/5Ab+hYicJ2/5yE
	+zJgwEvNoKkoUJu9Yk6Fht2g6jv2HTvzJPU1Vsf4+Q+k8YoR5nP9x09hBSKAcb3StgL0N1Y0El2
	RT1+tOIGxZwhiaO6AGowkt5FPdAh+Ml1U=
X-Received: by 2002:a05:7300:4307:b0:2ea:5057:a331 with SMTP id 5a478bee46e88-30398655963mr2890920eec.21.1778879689799;
        Fri, 15 May 2026 14:14:49 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30294adddaasm8120311eec.13.2026.05.15.14.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:49 -0700 (PDT)
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
Subject: [PATCH v16 13/38] tpm/tpm_tis: Allow locality to be set to a different value
Date: Fri, 15 May 2026 14:13:45 -0700
Message-ID: <20260515211410.31440-14-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_141450_589740_0E934D84 
X-CRM114-Status: GOOD (  16.19  )
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

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

Provide a one-time function tpm_chip_set_locality() for setting the
correct locality needed by DRTM launches.

Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm-chip.c     | 35 ++++++++++++++++++++++++++++++++-
 drivers/char/tpm/tpm_tis_core.c |  2 ++
 include/linux/tpm.h             |  4 ++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 0719577e584d..a9620b27b63d 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -44,7 +44,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
 	if (!chip->ops->request_locality)
 		return 0;
 
-	rc = chip->ops->request_locality(chip, 0);
+	rc = chip->ops->request_locality(chip, chip->kernel_locality);
 	if (rc < 0)
 		return rc;
 
@@ -343,6 +343,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
 	}
 
 	chip->locality = -1;
+	chip->kernel_locality = 0;
 	return chip;
 
 out:
@@ -658,3 +659,35 @@ void tpm_chip_unregister(struct tpm_chip *chip)
 	tpm_del_char_device(chip);
 }
 EXPORT_SYMBOL_GPL(tpm_chip_unregister);
+
+/**
+ * tpm_chip_set_locality() - Set the TPM locality the kernel uses
+ * @chip:	&tpm_chip instance
+ * @locality:   new locality
+ *
+ * This a one time function to set the locality the kernel driver
+ * uses. Returns zero or POSIX error on failure.
+ */
+int tpm_chip_set_locality(struct tpm_chip *chip, u8 locality)
+{
+	int ret;
+
+	if (locality >= TPM_MAX_LOCALITY)
+		return -EINVAL;
+
+	ret = tpm_try_get_ops(chip);
+	if (ret)
+		return ret;
+
+	if (!(chip->flags & TPM_CHIP_FLAG_SET_LOCALITY_ENABLED)) {
+		tpm_put_ops(chip);
+		return -EPERM;
+	}
+
+	chip->kernel_locality = locality;
+	chip->flags &= ~TPM_CHIP_FLAG_SET_LOCALITY_ENABLED;
+	tpm_put_ops(chip);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tpm_chip_set_locality);
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 70aba05f4ee1..cf6d929ce5aa 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1125,6 +1125,8 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 
+	chip->flags |= TPM_CHIP_FLAG_SET_LOCALITY_ENABLED;
+
 #ifdef CONFIG_ACPI
 	chip->acpi_dev_handle = acpi_dev_handle;
 #endif
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 0db277af45c3..4a26a49040b9 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -159,6 +159,8 @@ struct tpm_chip {
 
 	/* active locality */
 	int locality;
+	/* the locality used by kernel */
+	u8 kernel_locality;
 
 #ifdef CONFIG_TCG_TPM2_HMAC
 	/* details for communication security via sessions */
@@ -197,6 +199,7 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_HWRNG_DISABLED		= BIT(9),
 	TPM_CHIP_FLAG_DISABLE			= BIT(10),
 	TPM_CHIP_FLAG_SYNC			= BIT(11),
+	TPM_CHIP_FLAG_SET_LOCALITY_ENABLED	= BIT(12),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
@@ -244,6 +247,7 @@ static inline ssize_t tpm_ret_to_err(ssize_t ret)
 extern int tpm_is_tpm2(struct tpm_chip *chip);
 extern __must_check int tpm_try_get_ops(struct tpm_chip *chip);
 extern void tpm_put_ops(struct tpm_chip *chip);
+int tpm_chip_set_locality(struct tpm_chip *chip, u8 locality);
 extern ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
 				size_t min_rsp_body_length, const char *desc);
 extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
-- 
2.47.3


