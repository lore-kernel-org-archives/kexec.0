Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BE1C433EF
	for <kexec@archiver.kernel.org>; Wed, 15 Jun 2022 21:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LHUCULQ61r9O53ErI152UXN/6x5PKkiQUd4AV1P1BLA=; b=Yn+A0R0BV6XyNc
	WpiJ0bBa9mK71P0LipBdw4wh/GGXkF+enAmWLu6yXCSLFaL48zn/WYUfmjJIKLuQTmgPhwnqvnMDq
	y+wmCsRMt/yA4cgiJk0umgEsNd+P+nlNFrndkHlLj6S8Qycori3VZiTEKfDnF/A5JF4fFceGhfb/u
	egzplY5tCuV7z69Q5iK4IQWEP/d/90kFxOU6pyrM1yPm7rzzoR3CXH31dazkAPYaJ4jenKiy0e2Af
	l64sBCb7StpjgROzSEJBJIaWSB+plBmyebv8ViKcXPVTXCs/kYPPv0JrWYQP+Tfcrswx9DaXpgpNp
	cOset5EUdl5cK5t6yNLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1aXn-00GRuB-P1; Wed, 15 Jun 2022 21:27:19 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1aXk-00GRtQ-CM
	for kexec@lists.infradead.org; Wed, 15 Jun 2022 21:27:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 080CEB82182;
	Wed, 15 Jun 2022 21:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDC5C3411A;
	Wed, 15 Jun 2022 21:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655328433;
	bh=j0Nz9gWzlQB5Laxm3qH9cDjyMSYDdvtiAQPBRjsZCzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOQ208fhg+Tmuw1zKTODfmwydFIugZW2qvQ4eq18PnBNlbcFzZBZS8nn3Cf/cgBIe
	 qKqocbS/jmO4V0fygItYBu/gCz+W9N/oETJAi0mJsc0zZ6abxxeoQlhXWRoG560NTt
	 1DoD6E6mvFbWSfaLX1qOKlp/8IpFwMRjIf4HRlo/zHH1AdBsO+f1T5gf+nQ8aehBoR
	 hXffr2dfAgieVQpyCRtspShYxAlTwnqgPUFyKm826s+/hugNVeJ938ZyBxuLGLUzx9
	 PjfMp1eb0HOZzNq84lIHWXtFh2YG2PhxYIE3pjcdsOXsV2zd3iS5gXNnboErmit2Ky
	 VxCCiOpWkmohg==
Date: Thu, 16 Jun 2022 00:25:04 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: kexec@lists.infradead.org, devicetree@vger.kernel.org,
	nayna@linux.ibm.com, nasastry@in.ibm.com,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 3/3] tpm: of: Call of_tpm_get_sml_parameters() to get
 base and size of log
Message-ID: <YqpOMPVZwx1pb2mp@iki.fi>
References: <20220614161258.1741427-1-stefanb@linux.ibm.com>
 <20220614161258.1741427-4-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220614161258.1741427-4-stefanb@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_142716_747136_D00D7413 
X-CRM114-Status: GOOD (  21.69  )
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

On Tue, Jun 14, 2022 at 12:12:58PM -0400, Stefan Berger wrote:
> Simplify tpm_read_log_of() and call of_tpm_get_sml_parameters() to get
> the base and size of the TPM log.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> ---
>  drivers/char/tpm/eventlog/of.c | 31 +++++--------------------------
>  1 file changed, 5 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
> index a9ce66d09a75..e272c7a0765f 100644
> --- a/drivers/char/tpm/eventlog/of.c
> +++ b/drivers/char/tpm/eventlog/of.c
> @@ -12,6 +12,7 @@
>  
>  #include <linux/slab.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
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
> -- 
> 2.35.1
> 

Looks good to me.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
