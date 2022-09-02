Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F349DC6FA82
	for <kexec@archiver.kernel.org>; Fri,  2 Sep 2022 03:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nkbYDfpOTR+eNi7b9Ln1qpZfHVIwyUQ1CT8FfX2KFvw=; b=bP6fEeGSvqmWBx
	GalpyL1C9XRWAsKxFTNpULMZ02c05dgTMDPairiIcvb9zv3YnhKSuLTn94r4SxuiE50eKqs5/VI2p
	PVUbu4nufGC5rRjbvJSBHJ4akYPzg8qWlHAXPtmIRJAMwqXEdFAa9+nocteVzY3VtSj212Pou0AlS
	16J5liBbyEYEy38K63/1oG/es6QyXFdxCtfi6UncHYxlb00yz8kkBbjfPy9pJ2crgONiN7ncWdHUg
	UlNzIPOUijHELUfLadJ2wPZnf3yBZQGd0Keo/VsKc4A0ymCISql9QfYpd1Pm9ROkerNu8MUc5j9bx
	O84QyxMJVZeGZ0mJ9inA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTxEa-00HIle-Ll; Fri, 02 Sep 2022 03:20:44 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTxEX-00HIkj-04
	for kexec@lists.infradead.org; Fri, 02 Sep 2022 03:20:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 6E3B1B82939;
	Fri,  2 Sep 2022 03:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6FEC433D7;
	Fri,  2 Sep 2022 03:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662088838;
	bh=BsOHRM4pj/Cx8jQlerkEmWkvN1ZmISnL0o3Je+RC3rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GKaUWEyjbUEJRtygq8yOuDVsk1O04YnbRJGoh7VvhNd2P1rxWx4bnXqflp21EoP8j
	 buEgk7J+cWUd5w63K33u1gmvuBgvleQoLczdUYEHhIe4b/bHpJk3wpa9oun5xIUUQn
	 EeCzn7anOLNmtAKSVDDC6xGqxiaJwsAWqKnd8bg0koKtrvKoo5/BUx2g8iCvQd2l9R
	 OsHcjQ2UoQlUNW460HYHQRSfenZNJxl2XpHCWCIjP/2mlhVWuKAcwFPKzQsBlnCJ5J
	 Tku/VFuscSdEsr3TD912gdlFXx+DBeNh233eWt1mF7hudLkeKk1xz5AJ5hwz4dfmNU
	 RjmGqaz32M8jg==
Date: Fri, 2 Sep 2022 06:20:33 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: kexec@lists.infradead.org, devicetree@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, nayna@linux.ibm.com,
	nasastry@in.ibm.com, mpe@ellerman.id.au,
	Jason Gunthorpe <jgg@ziepe.ca>, Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Nageswara R Sastry <rnsastry@linux.ibm.com>,
	Coiby Xu <coxu@redhat.com>
Subject: Re: [PATCH v8 2/4] tpm: of: Make of-tree specific function commonly
 available
Message-ID: <YxF2gTw4vlfwxhpl@kernel.org>
References: <20220901214610.768645-1-stefanb@linux.ibm.com>
 <20220901214610.768645-3-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220901214610.768645-3-stefanb@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_202041_359082_4D499F62 
X-CRM114-Status: GOOD (  28.07  )
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

On Thu, Sep 01, 2022 at 05:46:08PM -0400, Stefan Berger wrote:
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
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Tested-by: Coiby Xu <coxu@redhat.com>
> 
> ---
> v7:
>  - Added original comment back into inlined function
> 
> v4:
>  - converted to inline function
> ---
>  drivers/char/tpm/eventlog/of.c | 31 +++++------------------------
>  include/linux/tpm.h            | 36 ++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
> index a9ce66d09a75..f9462d19632e 100644
> --- a/drivers/char/tpm/eventlog/of.c
> +++ b/drivers/char/tpm/eventlog/of.c
> @@ -12,6 +12,7 @@
>  
>  #include <linux/slab.h>
>  #include <linux/of.h>
> +#include <linux/tpm.h>
>  #include <linux/tpm_eventlog.h>
>  
>  #include "../tpm.h"
> @@ -20,11 +21,10 @@
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
> @@ -35,30 +35,9 @@ int tpm_read_log_of(struct tpm_chip *chip)
>  	if (of_property_read_bool(np, "powered-while-suspended"))
>  		chip->flags |= TPM_CHIP_FLAG_ALWAYS_POWERED;
>  
> -	sizep = of_get_property(np, "linux,sml-size", NULL);
> -	basep = of_get_property(np, "linux,sml-base", NULL);
> -	if (sizep == NULL && basep == NULL)
> -		return -ENODEV;
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
> +	ret = of_tpm_get_sml_parameters(np, &base, &size);
> +	if (ret < 0)
> +		return ret;
>  
>  	if (size == 0) {
>  		dev_warn(&chip->dev, "%s: Event log area empty\n", __func__);
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index dfeb25a0362d..6356baaa1393 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -460,4 +460,40 @@ static inline struct tpm_chip *tpm_default_chip(void)
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
> 2.35.1
> 

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
