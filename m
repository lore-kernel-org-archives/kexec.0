Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31ACAC25B78
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 20:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:Subject:Cc:
	To:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lm6FygFlCitpKVIgZGLvjgjfdIQDimueLV4HzwqDy5I=; b=In3cNXu45W6YXT
	d7fn6E66r/SAVEqfTLM7H+IAr2TobCM1xlevyCvlJJHTNCjpTOdC+b8Ix7i0PV555A1jVaaOy3JqR
	gece91GDlZzJ4Cg86nBHrOXVa+RmCDARdSTmJZBz6R1SqC321Jo4H1HrkoIKYmJTI6lSBIVzYuNUt
	sGjH26JHz7pmhM+fjAPmAHzRgin92JlmSLtgMxrghEAsyAQTQpPDiAU5rgKQ4kz/QfT2IxOzZf28O
	UgpLkKSSazMCShUTNrdW373swSbfEPeSx2KsOgfZd9MQm34VE9M8iO0KoQIIx1XqOD0frHY1C+fpR
	ip24d0DxMjakRxyom91w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEakb-00000003iMo-2lER;
	Tue, 04 Jun 2024 20:27:21 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEakY-00000003iLa-46Cw
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 20:27:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2859C614DB;
	Tue,  4 Jun 2024 20:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F25C2BBFC;
	Tue,  4 Jun 2024 20:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717532836;
	bh=EWZoRD7uLz6RSNswJ4Vk8CAivXRc1LdOOzxMYPLMI7U=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=s+Q8kmRl/zaGIIZ1ThM916E4j9n3mSDWOwtpyL1+fz8ThfDoK0bV50VLk/GU2a1nb
	 AR4BixgQR9V5PRy0lKr5MBzwHpum03NYvMf3dxzdMPUeBdpFm5234PF0rSaIQoscku
	 oCUgzeTOWBmhgapQV1mOtGfThZb6W3xzt+BupS7/68ym1uXddAKgt436nJUiFlKPMy
	 LyM3/6GeW9unhy/DHsJdSQAF8NOUbISCK0aFAGal45iAHLMuaes9tDrd5ukvYxPnQV
	 MRZnm+zr4jADLjmZKWajgVUYPM9gICE8nPgTdWE2q1U53xzA2CZFV5NRLnRsbie6Zb
	 9QW5SeAEOr6xw==
Mime-Version: 1.0
Date: Tue, 04 Jun 2024 23:27:09 +0300
Message-Id: <D1RIKP548WG9.Q5MM7K3FRH4P@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 16/19] tpm: Add ability to set the preferred locality
 the TPM chip uses
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-17-ross.philipson@oracle.com>
In-Reply-To: <20240531010331.134441-17-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_132719_156419_23C598D4 
X-CRM114-Status: GOOD (  18.25  )
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
> Curently the locality is hard coded to 0 but for DRTM support, access
> is needed to localities 1 through 4.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  drivers/char/tpm/tpm-chip.c      | 24 +++++++++++++++++++++++-
>  drivers/char/tpm/tpm-interface.c | 15 +++++++++++++++
>  drivers/char/tpm/tpm.h           |  1 +
>  include/linux/tpm.h              |  4 ++++
>  4 files changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 854546000c92..73eac54d61fb 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -44,7 +44,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
>  	if (!chip->ops->request_locality)
>  		return 0;
>  
> -	rc = chip->ops->request_locality(chip, 0);
> +	rc = chip->ops->request_locality(chip, chip->pref_locality);
>  	if (rc < 0)
>  		return rc;
>  
> @@ -143,6 +143,27 @@ void tpm_chip_stop(struct tpm_chip *chip)
>  }
>  EXPORT_SYMBOL_GPL(tpm_chip_stop);
>  
> +/**
> + * tpm_chip_preferred_locality() - set the TPM chip preferred locality to open
> + * @chip:	a TPM chip to use
> + * @locality:   the preferred locality
> + *
> + * Return:
> + * * true      - Preferred locality set
> + * * false     - Invalid locality specified
> + */
> +bool tpm_chip_preferred_locality(struct tpm_chip *chip, int locality)
> +{
> +	if (locality < 0 || locality >=TPM_MAX_LOCALITY)
> +		return false;
> +
> +	mutex_lock(&chip->tpm_mutex);
> +	chip->pref_locality = locality;
> +	mutex_unlock(&chip->tpm_mutex);
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(tpm_chip_preferred_locality);
> +
>  /**
>   * tpm_try_get_ops() - Get a ref to the tpm_chip
>   * @chip: Chip to ref
> @@ -374,6 +395,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>  	}
>  
>  	chip->locality = -1;
> +	chip->pref_locality = 0;
>  	return chip;
>  
>  out:
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 5da134f12c9a..35f14ccecf0e 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -274,6 +274,21 @@ int tpm_is_tpm2(struct tpm_chip *chip)
>  }
>  EXPORT_SYMBOL_GPL(tpm_is_tpm2);
>  
> +/**
> + * tpm_preferred_locality() - set the TPM chip preferred locality to open
> + * @chip:	a TPM chip to use
> + * @locality:   the preferred locality
> + *
> + * Return:
> + * * true      - Preferred locality set
> + * * false     - Invalid locality specified
> + */
> +bool tpm_preferred_locality(struct tpm_chip *chip, int locality)
> +{
> +	return tpm_chip_preferred_locality(chip, locality);
> +}
> +EXPORT_SYMBOL_GPL(tpm_preferred_locality);

 What good does this extra wrapping do?

 tpm_set_default_locality() and default_locality would make so much more
 sense in any case.

 BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
