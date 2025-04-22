Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BF8C369D7
	for <kexec@archiver.kernel.org>; Tue, 22 Apr 2025 11:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cDzjuAw8gyec0UtcHaMK8ay4lrVZAz455CrMeb1zHOU=; b=4VMlBVb2kA8Lr5uNgAE+Wh48Bi
	xwdbiMYKIOCJ5vUXqBHStxj5c8G/9YmZTavCsh3TJdTcbO3JFDdkg1XvJQQyjMygIpFzc5RmdT1F3
	uK7SQY5uEjTAS0QRM+alodWvq+6xF2LgMXmkPTvyUBImTpRXT7mSX2QU6amfbnRe9bne+A9iAu4bv
	XjAQN+6IsoB8EmNftGcUYK/0AIoPFg+fUKHIsQO/MKpKemqJ/rgN8wazON7v0DF54BGstBKTmH0ep
	tbIX70P6aDt0JzmjuZ4qrFE9rIrmIJ1Dazd4oapIG6G8LXiZKXEe/g2eFL9dv7WWaQa6UT7N4ZEIl
	pyY6V1kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7BPh-00000006s3T-0nFY;
	Tue, 22 Apr 2025 11:03:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Ak9-00000006jHv-1Gqf
	for kexec@lists.infradead.org;
	Tue, 22 Apr 2025 10:20:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745317242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cDzjuAw8gyec0UtcHaMK8ay4lrVZAz455CrMeb1zHOU=;
	b=OVGh4lWHLMMvMFxGOtgQoO6qCZJhgprXKOkraLIgxy4f4exuk7JsUCRioqrj45ZgFMugdI
	bF/9cSEfqUpnpClywu6NN7uIvgHa4/G9t6R1IdUEWHNLVV5Jn5B8lQdbZ8IFjcqJ4vq9Vf
	g8aIhM+BqeubZWUAwBMFy7FJRrZqWAU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-eni5Hes7PeuGpOOfuTEQYA-1; Tue, 22 Apr 2025 06:20:41 -0400
X-MC-Unique: eni5Hes7PeuGpOOfuTEQYA-1
X-Mimecast-MFC-AGG-ID: eni5Hes7PeuGpOOfuTEQYA_1745317240
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-acb66d17be4so327541966b.2
        for <kexec@lists.infradead.org>; Tue, 22 Apr 2025 03:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745317240; x=1745922040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDzjuAw8gyec0UtcHaMK8ay4lrVZAz455CrMeb1zHOU=;
        b=foIMzyixCrIbm/fI+Sixj/uRaEMsl5zTwwgy3U2BseP8qu3xa/D4Y+cvoLFbP8YvtL
         HWsz+xgGIPKXJepG04mSn1wLfTi0zfguNAj2o6m7J6NG932Ak+J4eu1iaLgSsAeqKkk6
         t6dGc4T82FmtTBluoZ9EDPjVkYET2vivOKrfXn733zjOISs/n8HkCKx0Bussm7Lgia7z
         Nlvc3+/Hjndoswm2s1wT9uo5tmWpKBQVUwewNGSlIYDZ9mV2LNEgOC7YrL9/U9iIMv0u
         71MIfPrf5k+yYnByCxWD5jmCycRo46HAsozaG3fPHHHD7D8Pe0rF60QVtsUqfZLCN56L
         FySg==
X-Forwarded-Encrypted: i=1; AJvYcCVqnWjFtjHlEbj5/h9N3sKQ+AuGV1RvRKSkm7uO8SfL232tNwnhxyJZK9b8F49I7FXWSBeJOg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzkf/zLKbltbZZcbJvKtC6URRAj5v7L8pDUK0Svx9ooarJDVfRO
	Aewk5TyjfBHpAJ+QqWffRPdq+013J320RZZ1ZrjETq2VbVBJZ49a0klj2L11nP0+cwbdZ6+QV+G
	1f8pSBjjsuIJpfr5YwqbaaW8MWQstESbRtT3EG68I4FQlvbg+L7xU1lHP+g==
X-Gm-Gg: ASbGncsdALQBO3smgIQWK2wVxwRugUM64lUSHyi54c7smss/0lE1UVQIWxED7fcEO6b
	KdWHxFSVeFOUOlba6WrACLpiPgBTW7/sxKhQIbmKpuoffXHaRoVcXU1qeRqitV/FAwsqHOqOElS
	ci6i9R9SWSQXwnV6lbj/3ysbmK5fB1X6qAvHOji1tD4fT9DJWputp8sGG8AyERc3GtDdR46FIjU
	oysqjwTeBP7ZQPxnAzb5qJLqhj5G4oXs3n5y6VSFvzoTRYhDmgDuYJza7Ax+LvVo2lNhBopgEWB
	EalfEOBGywXEGNgSGQ==
X-Received: by 2002:a17:907:72ce:b0:ac6:fec7:34dd with SMTP id a640c23a62f3a-acb74e09f3fmr1184070166b.52.1745317240076;
        Tue, 22 Apr 2025 03:20:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS+uMA1StUCAyrk69fQ00I3GurylSo4xmtvYwqLxjQJ/N/RmIisq+dh9LxGK6QS38KW2+XjA==
X-Received: by 2002:a17:907:72ce:b0:ac6:fec7:34dd with SMTP id a640c23a62f3a-acb74e09f3fmr1184065566b.52.1745317239418;
        Tue, 22 Apr 2025 03:20:39 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.201.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb8f2019dbsm473147666b.158.2025.04.22.03.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 03:20:38 -0700 (PDT)
Date: Tue, 22 Apr 2025 12:20:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org, iommu@lists.linux.dev, 
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com, 
	dwmw2@infradead.org, baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com, 
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v14 16/19] tpm, tpm_tis: Allow locality to be set to a
 different value
Message-ID: <4w5oshnh6opkrhngzy74cagd7vio45wz6cv3ltmowfbcipdjvs@rijgzlucl6jd>
References: <20250421162712.77452-1-ross.philipson@oracle.com>
 <20250421162712.77452-17-ross.philipson@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20250421162712.77452-17-ross.philipson@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8fSzu8INdyS_Pv-ctP9aQE1qntyunlxXNmD50uAMYk4_1745317240
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_032045_423154_3ED86D9B 
X-CRM114-Status: GOOD (  16.68  )
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

On Mon, Apr 21, 2025 at 09:27:09AM -0700, Ross Philipson wrote:
>DRTM needs to be able to set the locality used by kernel. Provide
>a one-shot function tpm_chip_set_locality() for the purpose.
>
>Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>---
> drivers/char/tpm/tpm-chip.c     | 34 ++++++++++++++++++++++++++++++++-
> drivers/char/tpm/tpm_tis_core.c |  2 ++
> include/linux/tpm.h             |  4 ++++
> 3 files changed, 39 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>index e25daf2396d3..a603f0dadd43 100644
>--- a/drivers/char/tpm/tpm-chip.c
>+++ b/drivers/char/tpm/tpm-chip.c
>@@ -44,7 +44,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
> 	if (!chip->ops->request_locality)
> 		return 0;
>
>-	rc = chip->ops->request_locality(chip, 0);
>+	rc = chip->ops->request_locality(chip, chip->kernel_locality);
> 	if (rc < 0)
> 		return rc;
>
>@@ -380,6 +380,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
> 	}
>
> 	chip->locality = -1;
>+	chip->kernel_locality = 0;
> 	return chip;
>
> out:
>@@ -695,3 +696,34 @@ void tpm_chip_unregister(struct tpm_chip *chip)
> 	tpm_del_char_device(chip);
> }
> EXPORT_SYMBOL_GPL(tpm_chip_unregister);
>+
>+/**
>+ * tpm_chip_set_locality() - Set the TPM locality kernel uses
>+ * @chip:	&tpm_chip instance
>+ * @locality:   new locality
>+ *
>+ * This a one-shot function. Returns zero or POSIX error on failure.
>+ */
>+int tpm_chip_set_locality(struct tpm_chip *chip, u8 locality)
>+{
>+	int ret;
>+
>+	if (locality < 0 || locality >= TPM_MAX_LOCALITY)

Since `locality` is unsigned, we can skip the `locality < 0` check.

>+		return -EINVAL;
>+
>+	ret = tpm_try_get_ops(chip);
>+	if (ret)
>+		return ret;
>+
>+	if (!(chip->flags & TPM_CHIP_FLAG_SET_LOCALITY_ENABLED)) {
>+		tpm_put_ops(chip);
>+		return -EINVAL;

IIUC this operation is allowed only one time.
So, this case seems more like an operation that's not allowed because 
it's already been done, so what about returning "-EPERM".

Thanks,
Stefano

>+	}
>+
>+	chip->kernel_locality = locality;
>+	chip->flags &= ~TPM_CHIP_FLAG_SET_LOCALITY_ENABLED;
>+	tpm_put_ops(chip);
>+
>+	return 0;
>+}
>+EXPORT_SYMBOL_GPL(tpm_chip_set_locality);
>diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>index 222081e5c7f7..2bc0cf46adbf 100644
>--- a/drivers/char/tpm/tpm_tis_core.c
>+++ b/drivers/char/tpm/tpm_tis_core.c
>@@ -1124,6 +1124,8 @@ int tpm_tis_core_init(struct device *dev, struct 
>tpm_tis_data *priv, int irq,
> 	if (IS_ERR(chip))
> 		return PTR_ERR(chip);
>
>+	chip->flags |= TPM_CHIP_FLAG_SET_LOCALITY_ENABLED;
>+
> #ifdef CONFIG_ACPI
> 	chip->acpi_dev_handle = acpi_dev_handle;
> #endif
>diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>index 86fe8f6a2d52..884791acba2e 100644
>--- a/include/linux/tpm.h
>+++ b/include/linux/tpm.h
>@@ -207,6 +207,8 @@ struct tpm_chip {
>
> 	/* active locality */
> 	int locality;
>+	/* the locality used by kernel */
>+	u8 kernel_locality;
>
> #ifdef CONFIG_TCG_TPM2_HMAC
> 	/* details for communication security via sessions */
>@@ -355,6 +357,7 @@ enum tpm_chip_flags {
> 	TPM_CHIP_FLAG_SUSPENDED			= BIT(8),
> 	TPM_CHIP_FLAG_HWRNG_DISABLED		= BIT(9),
> 	TPM_CHIP_FLAG_DISABLE			= BIT(10),
>+	TPM_CHIP_FLAG_SET_LOCALITY_ENABLED	= BIT(11),
> };
>
> #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
>@@ -448,6 +451,7 @@ static inline u32 tpm2_rc_value(u32 rc)
> extern int tpm_is_tpm2(struct tpm_chip *chip);
> extern __must_check int tpm_try_get_ops(struct tpm_chip *chip);
> extern void tpm_put_ops(struct tpm_chip *chip);
>+int tpm_chip_set_locality(struct tpm_chip *chip, u8 locality);
> extern ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
> 				size_t min_rsp_body_length, const char *desc);
> extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>-- 
>2.39.3
>
>


