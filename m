Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A24C77B73
	for <kexec@archiver.kernel.org>; Wed, 24 May 2023 22:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DaGvT5yvnYUgye3e7jiC0DcWLbfxqZpO/O/4ibnPEFQ=; b=OVWIxYBVu7siBQ
	FYVEKV6se9ZUfVMBsRJDW3RFCEStvuYLG2sLjJKT9tn8Tnkkb7mBdApAclue0MY7pFDzqRYOpqXVL
	9C6V7aa492isSefQpi5ZJIj1/oQ9odWbjADvUVGflafts/BlMmZSy4pCoChqJgT1I3fNF34JARtbK
	OzRASBbaEMD/H+Pr6O7Xzhe3MJ/muUqi1nH0+eo6w1q5cofC288FLi9iXWR1mhrYYW49y3tM0PrAt
	qPm4bEVruGXtr8ZtxV6akeW0hfqV1DZVMrQghjADIiRzagW/cJkVMR0M8OhutMhMau+QgSmRMZwau
	INtyBij44wl9xJkrvBVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1xPQ-00Es66-1u;
	Wed, 24 May 2023 22:56:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1xPN-00Es59-28
	for kexec@lists.infradead.org;
	Wed, 24 May 2023 22:56:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684969000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c2n57YKfPVwMrQwNDuZqoWvbyKlduQB03Z0HHDFLgso=;
	b=EtCWe9dcMx+p8PKu62uHg655/GpfF1YBFy+ylbD6PJnGvhOWdHd6QiCSYJ66JnnTQmG5SR
	vH3a8oMk3It6Q8ucD/BnAhk7Duq0teVhbfLkVWKhaJao4pN+ySzMmruhyDtt2lB+OQm6lM
	ASAbeI9zRGz50wNpUY7ktm5QdjlwReU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-2-IrpZTmOMe9v1yGkc7VXg-1; Wed, 24 May 2023 18:56:39 -0400
X-MC-Unique: 2-IrpZTmOMe9v1yGkc7VXg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f3c9860201so3610741cf.0
        for <kexec@lists.infradead.org>; Wed, 24 May 2023 15:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684968999; x=1687560999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2n57YKfPVwMrQwNDuZqoWvbyKlduQB03Z0HHDFLgso=;
        b=bXLNwl29w3c8pKn8AxlD8ZUsR+Bd6OPWsCFlKiia7nVSI6/rik5/ugkhheHX39Sm+w
         eWVEHKnM6bBAY0texT3B5JZ65L+2A0kSi/r7p+nGCPQb14y3ybG1RZJC5nM1MYBgOqDC
         uTsACNrl0GofE4th+K6Vc3HxsesU8/mysmRrrW0tpr/Ri2UNKnvnOnRFd+0dMK8Bsr/m
         9dj775VTd7A4ZNb2j/Jhz6f4/uXSgeK84J1K49GE04CJU0RhNt/1kyKXUQN5K3n8vT1Y
         5ZAEEhcYwjB7aegPXudyXP5DH7Telpk12dz1VJXXiGPy+2qoCRt8LHgvX6h0BABtLCDE
         MAEA==
X-Gm-Message-State: AC+VfDxjV3mk2lB2bcFaB9ETs7JOXfY8r0Hy95jR0rTpcE4p0GXLmvXi
	dNPUEJ8RkXXgrNr3f+1YZ6x9fUF75sQFY+a5dkqPfWrIxCgFWGXe2ZRP7oeV22zq3XfUyu3Uz4z
	OKdKY4yGN/pZ/2A1pC9Xy
X-Received: by 2002:a05:622a:1812:b0:3f7:f9c6:d33a with SMTP id t18-20020a05622a181200b003f7f9c6d33amr656004qtc.51.1684968999141;
        Wed, 24 May 2023 15:56:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4CObucFQQ/UXbQ4sJujExv1d1biF4QFEW+6FEL2jpcT2X+WZhsbL2VOihUuYm6dAlnu94vPg==
X-Received: by 2002:a05:622a:1812:b0:3f7:f9c6:d33a with SMTP id t18-20020a05622a181200b003f7f9c6d33amr655981qtc.51.1684968998843;
        Wed, 24 May 2023 15:56:38 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id w1-20020ac84d01000000b003f6b58b986fsm2303178qtv.41.2023.05.24.15.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 15:56:38 -0700 (PDT)
Date: Wed, 24 May 2023 15:56:37 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: kexec@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	nayna@linux.ibm.com, nasastry@in.ibm.com, mpe@ellerman.id.au, 
	Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Rob Herring <robh+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nageswara R Sastry <rnsastry@linux.ibm.com>, Coiby Xu <coxu@redhat.com>
Subject: Re: [PATCH v9 2/4] tpm: of: Make of-tree specific function commonly
 available
Message-ID: <e4dcxwp63uisirxwanjwrhzrnve45wqnxhijfp4oq274r4neco@v2btoy43ue5h>
References: <20230418134409.177485-1-stefanb@linux.ibm.com>
 <20230418134409.177485-3-stefanb@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20230418134409.177485-3-stefanb@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230524_155641_795382_81599631 
X-CRM114-Status: GOOD (  27.48  )
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

On Tue, Apr 18, 2023 at 09:44:07AM -0400, Stefan Berger wrote:
> Simplify tpm_read_log_of() by moving reusable parts of the code into
> an inline function that makes it commonly available so it can be
> used also for kexec support. Call the new of_tpm_get_sml_parameters()
> function from the TPM Open Firmware driver.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
> Tested-by: Coiby Xu <coxu@redhat.com>
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
> v9:
>  - Rebased on 6.3-rc7; call tpm_read_log_memory_region if -ENODEV returned
> 
> v7:
>  - Added original comment back into inlined function
> 
> v4:
>  - converted to inline function
> ---
>  drivers/char/tpm/eventlog/of.c | 30 +++++-----------------------
>  include/linux/tpm.h            | 36 ++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
> index 930fe43d5daf..41688d9cbd3b 100644
> --- a/drivers/char/tpm/eventlog/of.c
> +++ b/drivers/char/tpm/eventlog/of.c
> @@ -51,11 +51,10 @@ static int tpm_read_log_memory_region(struct tpm_chip *chip)
>  int tpm_read_log_of(struct tpm_chip *chip)
>  {
>  	struct device_node *np;
> -	const u32 *sizep;
> -	const u64 *basep;
>  	struct tpm_bios_log *log;
>  	u32 size;
>  	u64 base;
> +	int ret;
>  
>  	log = &chip->log;
>  	if (chip->dev.parent && chip->dev.parent->of_node)
> @@ -66,30 +65,11 @@ int tpm_read_log_of(struct tpm_chip *chip)
>  	if (of_property_read_bool(np, "powered-while-suspended"))
>  		chip->flags |= TPM_CHIP_FLAG_ALWAYS_POWERED;
>  
> -	sizep = of_get_property(np, "linux,sml-size", NULL);
> -	basep = of_get_property(np, "linux,sml-base", NULL);
> -	if (sizep == NULL && basep == NULL)
> +	ret = of_tpm_get_sml_parameters(np, &base, &size);
> +	if (ret == -ENODEV)
>  		return tpm_read_log_memory_region(chip);
> -	if (sizep == NULL || basep == NULL)
> -		return -EIO;
> -
> -	/*
> -	 * For both vtpm/tpm, firmware has log addr and log size in big
> -	 * endian format. But in case of vtpm, there is a method called
> -	 * sml-handover which is run during kernel init even before
> -	 * device tree is setup. This sml-handover function takes care
> -	 * of endianness and writes to sml-base and sml-size in little
> -	 * endian format. For this reason, vtpm doesn't need conversion
> -	 * but physical tpm needs the conversion.
> -	 */
> -	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0 &&
> -	    of_property_match_string(np, "compatible", "IBM,vtpm20") < 0) {
> -		size = be32_to_cpup((__force __be32 *)sizep);
> -		base = be64_to_cpup((__force __be64 *)basep);
> -	} else {
> -		size = *sizep;
> -		base = *basep;
> -	}
> +	if (ret < 0)
> +		return ret;
>  
>  	if (size == 0) {
>  		dev_warn(&chip->dev, "%s: Event log area empty\n", __func__);
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 4dc97b9f65fb..dd9a376a1dbb 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -461,4 +461,40 @@ static inline struct tpm_chip *tpm_default_chip(void)
>  	return NULL;
>  }
>  #endif
> +
> +#ifdef CONFIG_OF
> +static inline int of_tpm_get_sml_parameters(struct device_node *np,
> +					    u64 *base, u32 *size)
> +{
> +	const u32 *sizep;
> +	const u64 *basep;
> +
> +	sizep = of_get_property(np, "linux,sml-size", NULL);
> +	basep = of_get_property(np, "linux,sml-base", NULL);
> +	if (sizep == NULL && basep == NULL)
> +		return -ENODEV;
> +	if (sizep == NULL || basep == NULL)
> +		return -EIO;
> +
> +	/*
> +	 * For both vtpm/tpm, firmware has log addr and log size in big
> +	 * endian format. But in case of vtpm, there is a method called
> +	 * sml-handover which is run during kernel init even before
> +	 * device tree is setup. This sml-handover function takes care
> +	 * of endianness and writes to sml-base and sml-size in little
> +	 * endian format. For this reason, vtpm doesn't need conversion
> +	 * but physical tpm needs the conversion.
> +	 */
> +	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0 &&
> +	    of_property_match_string(np, "compatible", "IBM,vtpm20") < 0) {
> +		*size = be32_to_cpup((__force __be32 *)sizep);
> +		*base = be64_to_cpup((__force __be64 *)basep);
> +	} else {
> +		*size = *sizep;
> +		*base = *basep;
> +	}
> +	return 0;
> +}
> +#endif
> +
>  #endif
> -- 
> 2.38.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
