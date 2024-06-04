Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923EAC25B78
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 22:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XrOnh0zdGrWQIi9VXojPz1Ls4tQh8bGaFL/fLUqIlXw=; b=PPjHwP4iU4d4Zb
	9s5WzRmSQtuOkbImxNS/I+W931GpFDL4pAOBpTGlYbkJ4ba2W4WG1gQX8Zk0ZbilJac8XzGDj8OXU
	jwYqH8SOvpCr9JXgtdrRjnxwtScm75SihZkXp/7iGWsgEsafUGxMdtAJqZxKL0N96kyzsXQNyrOgT
	hII7CXCJkdCM824/oYwDNa0DvPzwxKYEz5+fuXcMKfSq7+ojZA4VLtSmW4Hwx0Jz+28yxfED0Twc9
	0XUsmxx1beR4goAq5aDmLVIByIUEEcntqP8t0JZDKGrtAdhqHmEg8nWOdOMHx4+eqjs5Zr/JqD8s3
	L7uquQXk/Q8IUCQkKRSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEczK-000000046cX-0gUT;
	Tue, 04 Jun 2024 22:50:42 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEczF-000000046aM-4AN3
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 22:50:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id BBDAACE10AC;
	Tue,  4 Jun 2024 22:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4CCC2BBFC;
	Tue,  4 Jun 2024 22:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717541435;
	bh=ege4vjOJhEIvZKGgsEARopmGzWR0ra0W6Va4o3bk6Vw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=e1taLLy8RGqZhbpnU0DTI33LuGV0zz2zuk65csiP3dNrr3yJHBAtjd8XlgdEMsgLo
	 g46tIPD1lu27t1fne5zVzyp8SHX6ffTE22LZdgiadbcN1Lcxf47pWP0NBulMN2NPZP
	 dU3/yi9BIbaakGf8OH02qkg9aqL8STP+8fgg5oygMC5cW80nzzClrecmddLZtfKZA4
	 pxx3S9498UD/pIfFd/+MRx4dR4eIXI4XPkZXSedGq1Iu2P3WGJebjBUVEpgVSqWxAH
	 0DK2X+qJkj0zTuggldM9iP94ULVCm7EPYs+BjUkziKPuTt8qEdBenQJRxzhWKu5uT+
	 S2YWrHaH1SA/g==
Mime-Version: 1.0
Date: Wed, 05 Jun 2024 01:50:27 +0300
Message-Id: <D1RLMF7VZ0BQ.1Y0SVHN39UQNN@kernel.org>
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
To: <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-17-ross.philipson@oracle.com>
 <D1RIKP548WG9.Q5MM7K3FRH4P@kernel.org>
 <282fddde-d156-4bd3-906b-0318d0a3746d@oracle.com>
In-Reply-To: <282fddde-d156-4bd3-906b-0318d0a3746d@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_155038_426092_9FECCE08 
X-CRM114-Status: GOOD (  22.53  )
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

On Wed Jun 5, 2024 at 1:14 AM EEST,  wrote:
> On 6/4/24 1:27 PM, Jarkko Sakkinen wrote:
> > On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> >> Curently the locality is hard coded to 0 but for DRTM support, access
> >> is needed to localities 1 through 4.
> >>
> >> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> >> ---
> >>   drivers/char/tpm/tpm-chip.c      | 24 +++++++++++++++++++++++-
> >>   drivers/char/tpm/tpm-interface.c | 15 +++++++++++++++
> >>   drivers/char/tpm/tpm.h           |  1 +
> >>   include/linux/tpm.h              |  4 ++++
> >>   4 files changed, 43 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> >> index 854546000c92..73eac54d61fb 100644
> >> --- a/drivers/char/tpm/tpm-chip.c
> >> +++ b/drivers/char/tpm/tpm-chip.c
> >> @@ -44,7 +44,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
> >>   	if (!chip->ops->request_locality)
> >>   		return 0;
> >>   
> >> -	rc = chip->ops->request_locality(chip, 0);
> >> +	rc = chip->ops->request_locality(chip, chip->pref_locality);
> >>   	if (rc < 0)
> >>   		return rc;
> >>   
> >> @@ -143,6 +143,27 @@ void tpm_chip_stop(struct tpm_chip *chip)
> >>   }
> >>   EXPORT_SYMBOL_GPL(tpm_chip_stop);
> >>   
> >> +/**
> >> + * tpm_chip_preferred_locality() - set the TPM chip preferred locality to open
> >> + * @chip:	a TPM chip to use
> >> + * @locality:   the preferred locality
> >> + *
> >> + * Return:
> >> + * * true      - Preferred locality set
> >> + * * false     - Invalid locality specified
> >> + */
> >> +bool tpm_chip_preferred_locality(struct tpm_chip *chip, int locality)
> >> +{
> >> +	if (locality < 0 || locality >=TPM_MAX_LOCALITY)
> >> +		return false;
> >> +
> >> +	mutex_lock(&chip->tpm_mutex);
> >> +	chip->pref_locality = locality;
> >> +	mutex_unlock(&chip->tpm_mutex);
> >> +	return true;
> >> +}
> >> +EXPORT_SYMBOL_GPL(tpm_chip_preferred_locality);
> >> +
> >>   /**
> >>    * tpm_try_get_ops() - Get a ref to the tpm_chip
> >>    * @chip: Chip to ref
> >> @@ -374,6 +395,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
> >>   	}
> >>   
> >>   	chip->locality = -1;
> >> +	chip->pref_locality = 0;
> >>   	return chip;
> >>   
> >>   out:
> >> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> >> index 5da134f12c9a..35f14ccecf0e 100644
> >> --- a/drivers/char/tpm/tpm-interface.c
> >> +++ b/drivers/char/tpm/tpm-interface.c
> >> @@ -274,6 +274,21 @@ int tpm_is_tpm2(struct tpm_chip *chip)
> >>   }
> >>   EXPORT_SYMBOL_GPL(tpm_is_tpm2);
> >>   
> >> +/**
> >> + * tpm_preferred_locality() - set the TPM chip preferred locality to open
> >> + * @chip:	a TPM chip to use
> >> + * @locality:   the preferred locality
> >> + *
> >> + * Return:
> >> + * * true      - Preferred locality set
> >> + * * false     - Invalid locality specified
> >> + */
> >> +bool tpm_preferred_locality(struct tpm_chip *chip, int locality)
> >> +{
> >> +	return tpm_chip_preferred_locality(chip, locality);
> >> +}
> >> +EXPORT_SYMBOL_GPL(tpm_preferred_locality);
> > 
> >   What good does this extra wrapping do?
> > 
> >   tpm_set_default_locality() and default_locality would make so much more
> >   sense in any case.
>
> Are you mainly just talking about my naming choices here and in the 
> follow-on response? Can you clarify what you are requesting?

I'd prefer:

1. Name the variable as default_locality.
2. Only create a single expored to function to tpm-chip.c:
   tpm_chip_set_default_locality().
3. Call this function in all call sites.

"tpm_preferred_locality" should be just removed, as tpm_chip_*
is exported anyway.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
