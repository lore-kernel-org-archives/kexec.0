Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC79C19F32
	for <kexec@archiver.kernel.org>; Fri,  7 Mar 2025 07:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zjKXz0oI30KmXTWpjDAaKLHWWI7kX15UXD1oadcKbOI=; b=AgBDtCHnfcgygaJWwZjci6b/zo
	BN5ukpjtVyRuJZRu82nhZbtUADp7h0zkeSg/ZjgUZsCAlGN9Hb0Z+fW9IE25ervOD1qiKT0pxhVwn
	ZMQNHRD73799B31O/yCIfxn0rTsZNOm+trZyxZEri2laZbTFpcgZ50bfJGAfADm+VZ6Cgv23w2DXX
	6Hgi3YagvHtdG07f0SAxoEKjkF4X6hYMbV5KSFbU5DCXQKe1IoZbFNwyXJ5VU6cWqLLbSOFALNKNe
	ye8eAFa3S60MHYIT+Fw9IdlUBGfV5FyVjwz/AcrkFgS0lLGId3SzbX2i83CMdGiMueZIrIRharbBO
	fqbHQSDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqRnd-0000000DOZu-1bm9;
	Fri, 07 Mar 2025 07:07:13 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqRna-0000000DOYU-3ZED
	for kexec@lists.infradead.org;
	Fri, 07 Mar 2025 07:07:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 57B625C10BA;
	Fri,  7 Mar 2025 07:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3853C4CEE2;
	Fri,  7 Mar 2025 07:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741331229;
	bh=NfUCXLX47qnl3g7ntvt7VcFk3/TMUuqaEmjkzg006yY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hnRSXatNyhfeQym42Mwoaq7lXelXEckosZP/mDV2JsO53Q/pdmGwCVIxA4HMR3gXi
	 a80cDvOig0TFhlfN9ill252VOAEoJ93bhhUPi0Ep8OEbEuFLuK4sMFGTI+CZZ4PV7I
	 6v0zPTnQEmi3kfiDq2fr+8IBi57gDTkX1FZTw54+d5Uu2RPcSveKf/3iwqZ1vXvsTC
	 RENa8d/Vwk9Es8Ro7RKoOHs6i+TBVf1yGBK89hiID6vLXWim/BANWKGV/Nhnyfe8Mb
	 Vxgz5W0wuTTUq+i33pEb4Ox+O9+zqan+JmGiMty1H0pQpL+KT4wqxwtg9L4rrxRrYe
	 tml2ZPM3hvkyA==
Date: Fri, 7 Mar 2025 09:07:05 +0200
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
Subject: Re: [PATCH v12 15/19] tpm, tpm_tis: Address positive localities in
 tpm_tis_request_locality()
Message-ID: <Z8qbGZwi0yFyus0J@kernel.org>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-16-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219194216.152839-16-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_230710_931139_31DCBF16 
X-CRM114-Status: GOOD (  18.62  )
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

On Thu, Dec 19, 2024 at 11:42:12AM -0800, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> 
> Validate that the input locality is within the correct range, as specified
> by TCG standards, and increase the locality count also for the positive
> localities.
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index c58f360fb4a4..c86100ad743a 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -234,10 +234,13 @@ static int tpm_tis_request_locality(struct tpm_chip *chip, int l)
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>  	int ret = 0;
>  
> +	if (l < 0 || l > TPM_MAX_LOCALITY)
> +		return -EINVAL;

I would mind if we put do dev_warn() here because it is unexpected
condition or even perhaps dev_err(). Or am I missing something?

> +
>  	mutex_lock(&priv->locality_count_mutex);
>  	if (priv->locality_count == 0)
>  		ret = __tpm_tis_request_locality(chip, l);
> -	if (!ret)
> +	if (ret >= 0)
>  		priv->locality_count++;
>  	mutex_unlock(&priv->locality_count_mutex);
>  	return ret;
> -- 
> 2.39.3
> 

I agree with this now.

BR, Jarkko

