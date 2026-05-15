Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A46CD4851
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MWgkYkzNwtEfRsNqnMWcy72BtOHvVyAwK+VJB1q1fiM=; b=Z3kax+UdTcG4L8cYZXu2x5iN7B
	t6wBXGtdwJTYKF5s2w7QJU7HY7ijAVPuRSLeeDUdoAx4CpW/LOc2ePcJYdFXH2qoJrQROSpb0uLdQ
	3/Q1B56149tlZNo+OFIb7E9KDGWVFU0sf9yPiHwVqkQoNCycbTTdTnDF6H+8zkbJBxLcw1nzFrJeI
	qgHmaQ3cY2EquYCkkj2yx37UcJVKoIZse6nkFf0DzrjQjr2KYLNThgM5LFeNWu5eciU7HIFLRCyZ3
	SdrPOwBPQnnR3uRqjiewrZnUCvJPvlIDlakPLSjRVTP4cgjYKEtuwjMY2WMrw/TZ5wr8zjb3Qt2xi
	S+UP9kHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzrt-00000009TLd-0Gaq;
	Fri, 15 May 2026 21:14:49 +0000
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzrp-00000009TIl-19ky
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:14:47 +0000
Received: by mail-dl1-x1234.google.com with SMTP id a92af1059eb24-135200bc7d2so448272c88.0
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879684; x=1779484484; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWgkYkzNwtEfRsNqnMWcy72BtOHvVyAwK+VJB1q1fiM=;
        b=rLvAoTr/Ql/7pNfQakGp5Mgoe1PQrPQXA1nk4rpz2cbZ4rvlrRZ0J2xAlgle7LwcLt
         HztrQrEbZTRkHNudAyvNX9d21s/YMjVhGRIb/RnPYFcOg1DkXRPd+Ly72bQMslsoBduE
         /pTphAMNP/UY1o7iPQ+sUXzDQLORYOLUoD85FUrKHLWFuPzLJTNFjWPf0J9LGulwGoVI
         lT8c1eaqbhzycB9k6S/wTTHIp+ku86pcCRGofjVIK894aavmrMGeyXayTya6jE47QrrQ
         V24ObNWyZlnYwNkvzXEfsWsWytJbhCNW9mTo9OADVX4aBzhXEIWEpSAxSSlTuC70qUXv
         Uh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879684; x=1779484484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MWgkYkzNwtEfRsNqnMWcy72BtOHvVyAwK+VJB1q1fiM=;
        b=S6vQ2kvDBE294YTmBJF7i/qOCU4mqFB4v5txkKwEL1HUCKlhqLby13RS2f8czeGkmf
         i8bySzV7DzGmVZ3c96gKmI03sctLjuh8fvyN45TTQMe6QP0D0yJFED6mt7MBYSiqKDyH
         QcNfSXVIml+n3XaWJDmw/VuRYti+T2UA8YgcuftrQbykJcIGU3kRvUfV3YAcvv+MkKjz
         BklWqoIxGazytYIbJGQuDrmqDjiZ2EFqfWPrqxO1jE5TRLqP0kZ/CPEZ9wNQ/3XWpduE
         9M+nRGNddx6GsfaS3NRfZlCdaFvaqFcrmPlrGJGow0i2NPOcjZ/BJw3+16W2YmT1cfis
         Dflw==
X-Forwarded-Encrypted: i=1; AFNElJ8dgPkPq3ic904N2HEWs0uEy/q7uvT4qHZUzDhOM9kDPCIxTwY73LBlPUuJPSrWEw6KsY7IRw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwiewqqSj8xggayf2SHiv/2ULtrndMBNk6CnDWeeN8QLpkddyuR
	5iweimkbhVLzV3yZI/bB8C7axcyaojAx1Rsn9TLyF/QBoNYjYmXm7tGT
X-Gm-Gg: Acq92OHNOE2fWje3BFQ8Tblq/hINFZfeXU5ple+duP3TzyR/zXdW02jnPuYXGaEq5xR
	GqqVDZx+SRvJ+X9PcROXE+ATSwJa9/7jGddIrh8a02YsoC7uOhqc3DSA3DVDEJuKZWq3uRvEW36
	Sd/7xueB/7znBkkcgnJN78xEiG3yqvL0k/MnQDqgaixLii0c++XjE/zahIUsunSO8qGTFx4h7aE
	n5wqnYt0/bt+pnZciU1u5efdu1V+ixYSIiSmYyhlVMOC65xlVwTVNbDhJ9V223kqhHY+XohPaWi
	NCBolHk9Urn/8n0smUl1xXHDsHizgcUBO/4nCgOMdYpK8hRySDbSa4AKP02mqinkQmD32P8rPRp
	Ez+zby52+w0zMr4sCYYnBKwEKMtBX5Rbrybdr0bcjEkV7nTgHe1v7wWQMl5gJisV1tkG3QdAipn
	KURd/zVpSv+flVtR9wzHaulChVtmu1wFAC3xtr1jqWSg==
X-Received: by 2002:a05:7022:928:b0:130:ca3d:fa74 with SMTP id a92af1059eb24-13504a545d4mr2603120c88.42.1778879684210;
        Fri, 15 May 2026 14:14:44 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbdcf140sm11364153c88.5.2026.05.15.14.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:43 -0700 (PDT)
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
Subject: [PATCH v16 11/38] tpm/tpm_tis: Close all localities
Date: Fri, 15 May 2026 14:13:43 -0700
Message-ID: <20260515211410.31440-12-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_141445_319766_1524FCE9 
X-CRM114-Status: GOOD (  11.58  )
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

Close all the localities while initializing the TPM driver. The addition
of TCG DRTM support requires this.

Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index e2a1769081b1..1fbb74a565f4 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1111,7 +1111,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	u32 intmask;
 	u32 clkrun_val;
 	u8 rid;
-	int rc, probe;
+	int rc, probe, i;
 	struct tpm_chip *chip;
 
 	chip = tpmm_chip_alloc(dev, &tpm_tis);
@@ -1176,6 +1176,15 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		goto out_err;
 	}
 
+	/*
+	 * In order to comply with the TCG DRTM specification, relinquish all
+	 * the localities.
+	 */
+	for (i = 0; i <= TPM_MAX_LOCALITY; i++) {
+		if (check_locality(chip, i))
+			tpm_tis_relinquish_locality(chip, i);
+	}
+
 	/* Take control of the TPM's interrupt hardware and shut it off */
 	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
 	if (rc < 0)
-- 
2.47.3


