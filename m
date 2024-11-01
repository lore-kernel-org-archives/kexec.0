Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9093E6B240
	for <kexec@archiver.kernel.org>; Fri,  1 Nov 2024 10:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:
	Subject:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kkGcCPA+hwGod7iK8wyfmYjhT9+q6707l2gY/LRslf4=; b=Qc6q/cOLAHOeKM
	EaSIi7JHh7gnqmA++WtI5bpdnMK1THXl/iRL7B2bAkevmnWwipDLowns0dFH4S+hcSfznWrlkB7cX
	h0zTLLgNXI2NyejxJvkD3xT9kg03d/4UMwpH78tswaXyJhp4bRy056RyyD0vYijb/F92/vko/FJGQ
	gZqiRBvu+D8io6Bl8arVzcP52nzwfijHlwTV3muR47/JjQgGhTWuY+Vht1Qq2Rjku06kO6usAXXW1
	fAVJBPTv23AjE2L8TXgthiIi14ba9TGb+yeNHXeR//m8jn1b+4SKDMm7TKgAoE0UuNVxSzyMga4Vz
	ZbzNFBqOVZpfo81VZTKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6ohv-00000006XJ9-4BHa;
	Fri, 01 Nov 2024 10:16:44 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6oWN-00000006Uy1-13w0
	for kexec@lists.infradead.org;
	Fri, 01 Nov 2024 10:04:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2D890A42A86;
	Fri,  1 Nov 2024 10:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6CDC4CED1;
	Fri,  1 Nov 2024 10:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730455485;
	bh=ItQI00nS8tC10ZV8l2jyRO6gDNvw+VRojMmh7RUgXnI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=fOMg2SZJB9VVqSZQ39KHQMlL2y8sJbkrgDhxf7Z8ZlTa/VEnVFFfhaaRPrtwP8/yh
	 POWHBMEO8mFRPnTFzrzEAvAEa7YdtvJVaxBM49PI/q8ZQvP3Ym8s220U+NYbs9OsdS
	 +vuoKWKCLZUorjlnKqZZaysZwEpw/R1tDdJNbIBLC8DK5NT7+pO7AolUM2yicAOYd9
	 mhheEhTsmnGjUz9/4jZki/KtKYunba+0jUH54/79vbCL8pbHJ+pCAz4ugGM27D+IUj
	 rJ4UiSjiCb3r6TDI0JUpPfI/DvTRhUCObpYTAuV8sPwA4fh1Mkuv/pfrUbjsKVyDRn
	 VRPZSZJ8prfFA==
Mime-Version: 1.0
Date: Fri, 01 Nov 2024 12:04:41 +0200
Message-Id: <D5AR9TGFZL14.AZMGA2G8GTDA@kernel.org>
Subject: Re: [PATCH v11 16/20] tpm: Make locality requests return consistent
 values
From: "Jarkko Sakkinen" <jarkko@kernel.org>
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
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <20240913200517.3085794-17-ross.philipson@oracle.com>
In-Reply-To: <20240913200517.3085794-17-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_030447_462799_582EC5F2 
X-CRM114-Status: GOOD (  22.75  )
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
> The function tpm_tis_request_locality() is expected to return the locality
> value that was requested, or a negative error code upon failure. If it is called
> while locality_count of struct tis_data is non-zero, no actual locality request
> will be sent. Because the ret variable is initially set to 0, the
> locality_count will still get increased, and the function will return 0. For a
> caller, this would indicate that locality 0 was successfully requested and not
> the state changes just mentioned.
>
> Additionally, the function __tpm_tis_request_locality() provides inconsistent
> error codes. It will provide either a failed IO write or a -1 should it have
> timed out waiting for locality request to succeed.
>
> This commit changes __tpm_tis_request_locality() to return valid negative error
> codes to reflect the reason it fails. It then adjusts the return value check in
> tpm_tis_request_locality() to check for a non-negative return value before
> incrementing locality_cout. In addition, the initial value of the ret value is
> set to a negative error to ensure the check does not pass if
> __tpm_tis_request_locality() is not called.
>
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 22ebf679ea69..20a8b341be0d 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -210,7 +210,7 @@ static int __tpm_tis_request_locality(struct tpm_chip *chip, int l)
>  again:
>  		timeout = stop - jiffies;
>  		if ((long)timeout <= 0)
> -			return -1;
> +			return -EBUSY;
>  		rc = wait_event_interruptible_timeout(priv->int_queue,
>  						      (check_locality
>  						       (chip, l)),
> @@ -229,18 +229,21 @@ static int __tpm_tis_request_locality(struct tpm_chip *chip, int l)
>  			tpm_msleep(TPM_TIMEOUT);
>  		} while (time_before(jiffies, stop));
>  	}
> -	return -1;
> +	return -EBUSY;
>  }
>  
>  static int tpm_tis_request_locality(struct tpm_chip *chip, int l)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> -	int ret = 0;
> +	int ret = -EBUSY;
> +
> +	if (l < 0 || l > TPM_MAX_LOCALITY)
> +		return -EINVAL;
>  
>  	mutex_lock(&priv->locality_count_mutex);
>  	if (priv->locality_count == 0)
>  		ret = __tpm_tis_request_locality(chip, l);
> -	if (!ret)
> +	if (ret >= 0)
>  		priv->locality_count++;
>  	mutex_unlock(&priv->locality_count_mutex);
>  	return ret;

First of all, -1 is as consistent value as a value can be.

Secondly:

	if (tpm_tis_request_locality(chip, 0) != 0)
		return -EBUSY;

What am I missing here?

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
