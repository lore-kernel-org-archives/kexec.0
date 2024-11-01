Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05A0D5CC99
	for <kexec@archiver.kernel.org>; Fri,  1 Nov 2024 09:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u44CeqYXAAy+uhrn6ViAPBj4F9f5RpyBxj8GLrsO1a0=; b=yiR5FXEGE14O0b
	yUyFgo0aAoBK6TaKY002vRfvTbx7DJZbrqJI7Thihgl//zi7xidaVWntH3tV+729JEknMdrCgeBOF
	nNyKCANFKHFXKyIPxEJCz1srar0UIrfDxrZZaJ1dWdAhGTRDtp7bIKONukHr5Dwg1Ez1VzwRNycWj
	OE8+PEUEu+iOnavAMgqbw/W46YeDXHx8aFRiGJ+xIsen5mxRztFKqelmHh5B6rHY5NGo72SEnulsT
	Sij/5OXEgYmo9phvGEqsLnP7gP/v7fThScwARJMUF10/gq0mWRVoOa4BraYs68KgXSAiOPB9mp8cW
	ktMl5h6LkhS5Lpfehslw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6o5w-00000006QWV-1ny1;
	Fri, 01 Nov 2024 09:37:28 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6o5t-00000006QVV-0q0h
	for kexec@lists.infradead.org;
	Fri, 01 Nov 2024 09:37:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7063CA40EC9;
	Fri,  1 Nov 2024 09:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED49AC4CECD;
	Fri,  1 Nov 2024 09:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730453843;
	bh=eAP8wfaTPD3Rk5TZK/GAd2plZiwGTqBnBqW26aAhRSg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=uf3qRIjn3V1T8PXWduVCQE6hlQS1iRMagcqQGVbwyG93uUa2Qz1tTCJyJsE53dPhm
	 OxZbE+hbi7H7sQcYewIqWYLBqxQXU/ClegGR0jqE5tsneJBZ549xr5k0AYVyqZoOLg
	 8+yRUmKhhLpKtGCjIeretJxyYeEbM10s+yV/ayLJE2oZZXAK2PjwO4LUR5vWKdSveh
	 GXD3Cu4oTEfL+gaCXdeEZFbSBIM0Uqyjnvoo2Bdy3R6hhQJVmRiWWUZzMbixf5fLKp
	 wj35hKbn7eSoj7Rk5Rfx/Kqkju0xa+0vOTBVfZB9GY2diYC9JiDlmDJur0Ps+qTw3D
	 zAVnXwgz6pQBQ==
Mime-Version: 1.0
Date: Fri, 01 Nov 2024 11:37:19 +0200
Message-Id: <D5AQOVB2XBF4.3A3CO7K6O8JKF@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v11 15/20] tpm: Ensure tpm is in known state at startup
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <20240913200517.3085794-16-ross.philipson@oracle.com>
In-Reply-To: <20240913200517.3085794-16-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_023725_374741_3B4A6AA5 
X-CRM114-Status: GOOD (  22.44  )
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

On Fri Sep 13, 2024 at 11:05 PM EEST, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>
> When tis_tis_core initializes, it assumes all localities are closed. There
> are cases when this may not be the case. This commit addresses this by

The second sentence is just a claim. Please explain.

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
> index a6967f312837..22ebf679ea69 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -1107,7 +1107,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  	u32 intmask;
>  	u32 clkrun_val;
>  	u8 rid;
> -	int rc, probe;
> +	int rc, probe, i;
>  	struct tpm_chip *chip;
>  
>  	chip = tpmm_chip_alloc(dev, &tpm_tis);
> @@ -1169,6 +1169,15 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  		goto out_err;
>  	}
>  
> +	/*
> +	 * There are environments, for example, those that comply with the TCG D-RTM
> +	 * specification that requires the TPM to be left in Locality 2.
> +	 */

I don't understand this comment. What is "environment"?

> +	for (i = 0; i <= TPM_MAX_LOCALITY; i++) {
> +		if (check_locality(chip, i))
> +			tpm_tis_relinquish_locality(chip, i);
> +	}
> +
>  	/* Take control of the TPM's interrupt hardware and shut it off */
>  	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>  	if (rc < 0)
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index e93ee8d936a9..98f2c7c1c52e 100644
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
