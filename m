Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EC0C19F32
	for <kexec@archiver.kernel.org>; Fri,  7 Mar 2025 07:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vMQPUTwmV0j9B4DCHhA7OkXHIAowtpM7HYq7HSZekv4=; b=smmqg4BrzohzXmrT66FmiHtMNI
	GDBntwqEi0xDFEpNa1EyvYsM/nlfQiu/QJB2/19iT7QsTtDlNrfot6AsQl1xXEc755l33HHbS7JBT
	OoQwrQhZbmQOkTox8NNJL0PMRylZHkA2LikRpObe+cvc9slvFMsMgKJiMxMr6y/LcDYwmUZVKvylV
	0/130UJFMot66PxAB4crlxLf3RnQymf4LBLkrN5tIZm5YZMDrcKpC9DsyiAmYcfbiIUFPnP9VEvrC
	v4AL2y10XuM7sIx2ZMV/Ll0VSNKMVjp6Q8ec7z7zGp1jd4lN60rFcmHxKnMUha0xOerVN88FDuenu
	p1o+/HmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqRn5-0000000DOTP-3wsD;
	Fri, 07 Mar 2025 07:06:39 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqRmD-0000000DONI-0qih
	for kexec@lists.infradead.org;
	Fri, 07 Mar 2025 07:05:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 88F475C10C6;
	Fri,  7 Mar 2025 07:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DDDC4CED1;
	Fri,  7 Mar 2025 07:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741331144;
	bh=sg8lIGdAcGl0Nr7oC/i8DO5aGMtK0VBBp7rTicPtVSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K+TToUeVCHBzNksGAEG0u+yLGt8bvrcxM7loUzqKPduGAUIlplwWspTULdQPdjlH4
	 GiIHNjrpiuW7p+QViOsfTzbBmyCiyApLGI5cCE2MFrSQ0RrJYp5TgavHxM9owckfo7
	 NMglh+EaRJwTZ3teO30vIMBPemxWXlznQAg2i1MHbowYQWEvEaGY7ENdAydD1TyH67
	 w2kgj5te2Uhvtan2sHnLEdv9rhdXCkkJU8/djRahDRp/Z6nQlO/+Yu08ym29ot3XPi
	 stHDV+5JeyLLIGeEw57wTTTeQTZntvfQ0G0PMMoNrAI5y+srz6NQ6G9rAzc8aOzmXl
	 0ZJOQUqSdSzlA==
Date: Fri, 7 Mar 2025 09:05:39 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v12 14/19] tpm, tpm_tis: Close all localities
Message-ID: <Z8qaw4XwH3QljLEM@kernel.org>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-15-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219194216.152839-15-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_230545_324457_FB844877 
X-CRM114-Status: GOOD (  22.30  )
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

On Thu, Dec 19, 2024 at 11:42:11AM -0800, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> 
> There are environments, for example, those that comply with the TCG D-RTM
> specification that requires the TPM to be left in locality 2. Prepare
> kernel for such environments by closing all the localities.
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 11 ++++++++++-
>  include/linux/tpm.h             |  6 ++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index fdef214b9f6b..c58f360fb4a4 100644
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
> +	 * There are environments, for example, those that comply with the TCG D-RTM
> +	 * specification that requires the TPM to be left in Locality 2.
> +	 */

I'd just shorten this into

/*
 * In order to comply with the TCG D-RTM specification, relinquish all
 * the localities.
 */

And that's it. It's a punctual reminder and that is what source code
comments should be for.


> +	for (i = 0; i <= TPM_MAX_LOCALITY; i++) {
> +		if (check_locality(chip, i))
> +			tpm_tis_relinquish_locality(chip, i);
> +	}
> +
>  	/* Take control of the TPM's interrupt hardware and shut it off */
>  	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>  	if (rc < 0)
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 20a40ade8030..c5a4a2d7dd15 100644
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
> -- 
> 2.39.3
> 

Otherwise, this is great.

BR, Jarkko

