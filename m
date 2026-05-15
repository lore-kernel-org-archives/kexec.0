Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649C1CD4851
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Web2s5uVg47aYyCtELeKAMQeYbkPbYPk/ttB5U3wMg=; b=ARTN3JMRiRXIVGMe4bEugLtiSj
	eJMzqImrVVPUzFXISV+bFc4JOuN/yk6B2D+2IzlcQhTpdaNAIk1TLDoiZOAqZdsC1AB43rJtMQQhA
	dYOREbHUCPfTMDlN5d8u5cyIbpsNr+srs++PvPYPq/eMIyjunBps5pqs2fNvhV5BB8Si01TQrlcZA
	+dRBFTiFcYj58VgBSJU2bssUQ+Kawv+3C2cV7Yrh0Kamd7R8G+H+NntfgY0qFPD9AHLMFgVgNf6cX
	ZB6xVLkvOmdkNdPFFxVNPKlHU8KayEpCQ5KbktUT4ej/6+IZEaoeoYqPiX1SrRXMDgmyoxVBpF33A
	bEy+bgNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzs0-00000009TRy-2IVr;
	Fri, 15 May 2026 21:14:56 +0000
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzrx-00000009TPL-2Hgs
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:14:54 +0000
Received: by mail-dl1-x1233.google.com with SMTP id a92af1059eb24-130c9dcbd25so971236c88.1
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879693; x=1779484493; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Web2s5uVg47aYyCtELeKAMQeYbkPbYPk/ttB5U3wMg=;
        b=OZ6WyE2KO4Mx/BViIeqxv3si2VqrRGHAor0UwLDaywcvQWiH36K+pFzGvFLAjxiZv9
         MkrMuBN7pkI3NPMDx13+/szeDqbngVKBTaAK1aUFcqYmc2DNH8B4qIlFrxcmnapZ1xAO
         aGcZgpSj4Td1Neo42OGNGwzGQbGDjqCbZ9xX6vnmH/J14EScVBEmv8h9qIwvZIWhAtV9
         Q3Jnbl4cWl6sGDtoddJ+/uneNVQ5RPTpY7H31fBsQYXlYNnTa7SsS3Abc9rxwDjjK7H/
         qrKn2t4M/qAHfMXEiTnOK0FdPpqEvIl+9FOfE5sUtw+ifwdNRwL2at4VCD3dX8AxTt2i
         TNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879693; x=1779484493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Web2s5uVg47aYyCtELeKAMQeYbkPbYPk/ttB5U3wMg=;
        b=JAb3D/BlyqHZneG4WCIWOZ9zx6gniTOyjXJs85Igi6hBsRhyMlSN8SJQsvteqrXjHj
         46WhKoBAuKU8KU1lg67v0YWJc6JeZA5qbk6S3BO/HSu1lawi0pbL/kfIQaH8H+xprUWj
         zteUCWqBtiQb0Mb2Ij/d6OY+A0IwTkgRw7tq5j9VrtD3e5pQlY/RCmNMWlarb8pfSVe4
         1M7l5aygolYN5MlXqJ4zG+Mv1NziYP+VANFxK7Dnzs7LHGYrOLy2L+8Fxmmf5k97rlCp
         IZ/EDvsDVAtU6eu6a1urLnMD5GwgXHNDXX6sIYGWsrkorwNslrLmZjDQXLI7041lt1XE
         sq/g==
X-Forwarded-Encrypted: i=1; AFNElJ+Kn6Dtgt0BU8uv0ufsK3M9+6RQo0vguaSimtRdTNZJfwn2hBlfS4dfx1UXE9e0jxpBHF++jg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx721GDqtbZXMWT413Z/6iiDiMMLMmlPJWi1RCRWH3fQozNR3tu
	ZlMlQfQbHjnOql1giHJYiPVAOdHxRXWp9EUK9f5Y7bO3rd0K01ujAVo6
X-Gm-Gg: Acq92OG+ZD+xPXyL/0JEUSTZEn++yrJJudR9Afmz6pXh01bEBkw4xVj2eNOSlLkZyoD
	c9jghFAf9qHptkaLiaIbB6pscDCx3BpWAusscAwyr9evhc9HvjeS9DVbE9FN26mgsDnmgMN5FVC
	nIIyicB2EwVZjOX+ke9YeD2EFjbXMxTat7Y4S/mDH8uQj4f8bOTfEJeYhZ6/Qbj0ShAlYGNg7JV
	0e40fUJ/T2iqAeiThxncc5uaTiUtS9Wtxo+YlkcBWlKkdgxyA4opjwlDQlveZ3o7UXftYz3MEcM
	fZIzZEoQ7CMFG4eDuORaVV5mySJVtY1xnc08KAJ1m2tr9gE/uJBV36hh0o5S9xQTj3ijQI2krOo
	DIt/5rkaqJLKtoLM9UVV8cBwtXBDi7i337iZKYlqCoanSi/mELYbFRUoXZb4+IMHhLrfGcYAPS7
	h+9PZmY5207a8iQIkP//xy3dUtGhVCoYA=
X-Received: by 2002:a05:7022:79d:b0:12a:6abf:ab1c with SMTP id a92af1059eb24-134ffe943c0mr2448441c88.11.1778879692592;
        Fri, 15 May 2026 14:14:52 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc3490bcsm9740184c88.15.2026.05.15.14.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:52 -0700 (PDT)
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
Subject: [PATCH v16 14/38] tpm/sysfs: Show locality used by kernel
Date: Fri, 15 May 2026 14:13:46 -0700
Message-ID: <20260515211410.31440-15-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_141453_592102_90510853 
X-CRM114-Status: UNSURE (   9.55  )
X-CRM114-Notice: Please train this message.
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

Expose the current locality used by the kernel TPM driver via
the sysfs interface.

Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm-sysfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index f5dcadb1ab3c..772c4ae67957 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -308,6 +308,14 @@ static ssize_t tpm_version_major_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(tpm_version_major);
 
+static ssize_t locality_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct tpm_chip *chip = to_tpm_chip(dev);
+
+	return sprintf(buf, "%u\n", chip->kernel_locality);
+}
+static DEVICE_ATTR_RO(locality);
+
 #ifdef CONFIG_TCG_TPM2_HMAC
 static ssize_t null_name_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
@@ -335,6 +343,7 @@ static struct attribute *tpm1_dev_attrs[] = {
 	&dev_attr_durations.attr,
 	&dev_attr_timeouts.attr,
 	&dev_attr_tpm_version_major.attr,
+	&dev_attr_locality.attr,
 	NULL,
 };
 
@@ -343,6 +352,7 @@ static struct attribute *tpm2_dev_attrs[] = {
 #ifdef CONFIG_TCG_TPM2_HMAC
 	&dev_attr_null_name.attr,
 #endif
+	&dev_attr_locality.attr,
 	NULL
 };
 
-- 
2.47.3


