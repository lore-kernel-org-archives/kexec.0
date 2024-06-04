Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F10C25B78
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 20:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6AtkatV3Cbo9WRCDXOQLA+OIStLttMyH0/ajXA2ttAg=; b=f+CFWRn54qlLrB
	U2JbB1oWisUqlcapES9nO3SMJFPh/nlBmz2DQ+tFH4dp08B79S/Tm0xYP+WRHVIXr9nHkzwKLNT2g
	1PKBsCip2a8MsCUxnICcC6ClkwMIx3HZzEbpGWtJZgTCS/A/3NaR5Y374CLMQ24sBD+VyDTLOYfTD
	A7e/Mh7MiWB8TsK3hDxl4VfSC/PIo9/5xE9v6hFuubsE09ihXSxj8ST/XchinGUvcdQH1JSYw12Hz
	cv0hpecrVquOJ7DRiW2kLC92e0vk2QvbCt8b/QseEwdS+9h128ohBcaWZRt7R06PVkAjpjvmi0+MY
	Du+MExscNdQEMYjFfi7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEaYf-00000003hGo-1BuV;
	Tue, 04 Jun 2024 20:15:01 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEaYb-00000003hFB-3ULn
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 20:14:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 327E8CE1082;
	Tue,  4 Jun 2024 20:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24356C2BBFC;
	Tue,  4 Jun 2024 20:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717532095;
	bh=1dJyobrXgBY+x5j48CVCOANJ3cfEJFSAQaYi7nvuypo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=F9K/+UVI55Cki+Zo9OV87c2eeM0ifYp6hzMMXIULk9SS+odlEkpfVLeUXP4r+oQI6
	 wfMGyaFnOX6GdfRpZY9TJNS1oJsfXJZ/IJX+nmhl0yKUw8hVNf0D8m74ltEtcmCyco
	 Ibm1AFdqcrhjN2qr54RkgXTWstymQme4U/+2ZmqA9Nh5hJlq/w8xFHYQXLWKvwZMST
	 jTybqZsrdfgundyOcDQUAtKTV3IprZxJLaq7OYxtGU3mYBJCYfOw9B6zyfb3iCJ1tI
	 QImFf84vT1cJ8PQjS/IYtU0wuNW911HYfxYBIB0HbKIa2FXKYvJiHgBoDofVRq/bSK
	 tkhBei/QCWaHA==
Mime-Version: 1.0
Date: Tue, 04 Jun 2024 23:14:47 +0300
Message-Id: <D1RIB8BHWRC5.3RRW0ZKV3KDVM@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 14/19] tpm: Ensure tpm is in known state at startup
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-15-ross.philipson@oracle.com>
In-Reply-To: <20240531010331.134441-15-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_131458_251087_16D87E77 
X-CRM114-Status: GOOD (  21.68  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>
> When tis core initializes, it assumes all localities are closed. There

s/tis_core/tpm_tis_core/

> are cases when this may not be the case. This commit addresses this by
> ensuring all localities are closed before initializing begins.
>
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 11 ++++++++++-
>  include/linux/tpm.h             |  6 ++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 7c1761bd6000..9fb53bb3e73f 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -1104,7 +1104,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  	u32 intmask;
>  	u32 clkrun_val;
>  	u8 rid;
> -	int rc, probe;
> +	int rc, probe, i;
>  	struct tpm_chip *chip;
>  
>  	chip = tpmm_chip_alloc(dev, &tpm_tis);
> @@ -1166,6 +1166,15 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  		goto out_err;
>  	}
>  
> +	/*
> +	 * There are environments, like Intel TXT, that may leave a TPM

What else at this point than Intel TXT reflecting the state of the
mainline?

> +	 * locality open. Close all localities to start from a known state.
> +	 */
> +	for (i = 0; i <= TPM_MAX_LOCALITY; i++) {
> +		if (check_locality(chip, i))
> +			tpm_tis_relinquish_locality(chip, i);
> +	}

To be strict this should be enabled only for x86 platforms.

I.e. should be flagged.

> +
>  	/* Take control of the TPM's interrupt hardware and shut it off */
>  	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>  	if (rc < 0)
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index c17e4efbb2e5..363f7078c3a9 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -147,6 +147,12 @@ struct tpm_chip_seqops {
>   */
>  #define TPM2_MAX_CONTEXT_SIZE 4096
>  
> +/*
> + * The maximum locality (0 - 4) for a TPM, as defined in section 3.2 of the
> + * Client Platform Profile Specification.
> + */
> +#define TPM_MAX_LOCALITY		4
> +
>  struct tpm_chip {
>  	struct device dev;
>  	struct device devs;


BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
