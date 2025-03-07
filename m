Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95101C282D0
	for <kexec@archiver.kernel.org>; Fri,  7 Mar 2025 07:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=10aUH5Zzdvu53j1Ld5u0jFZrdqLOSh2m3PyArGUZMcA=; b=bDNDjH092IHDh35bvsh5JwQWTq
	9oDwNFqtRB869wsNYVjJgiWHY2LSQ8IzIg9AyTr7Jo5KeZoub0YL9EZJXF+Myf43ncVgZ+FyUNx8S
	oegfqQJSCalvyntKbhCuoyOzTQ3KM+SVWiDFKzvZ5VjOAdt1nQHL7BQufhNjxw+ebSEBK2KaAJpJg
	ykU9p0cIacobh8h/NbRKwk5Liu9FgnpqYXFz0HnvdOZ/OQTD+vQzpgROLZAICqRHliTSNrnQ3R0ay
	Dm4MbQ385JtauyFamX9MKuPXgAnhte3aYflIBjoLMeBAWZZkmUwNNpuPSD3aMu4JHU9CiXkKyvwmK
	w0qAEk6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqRq6-0000000DP6s-0viK;
	Fri, 07 Mar 2025 07:09:46 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqRq3-0000000DP4m-113c
	for kexec@lists.infradead.org;
	Fri, 07 Mar 2025 07:09:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 856FEA45530;
	Fri,  7 Mar 2025 07:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025F8C4CED1;
	Fri,  7 Mar 2025 07:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741331381;
	bh=s1sKDyB3KwoorGYkRUNMSWK+weQ2ZgqEryheJlaust8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WXd6LGeYM1ZUHYTADkI/CgYdZN7wl00h5VkIkciSLi5bq0LEugYucScv2usw2KtZ+
	 inYH6JhOi23F5ivtzCXp41XPoKEnKvOkm8PF8Xj1CMzyHw7BB+nzfDIUUVYRZlaPyH
	 jfOtsPzjLt92Z/FTAKjEVCfNRE7hG8DCho+sgpyCVPbqJMp+XtdYwx6Pz43dV87+1f
	 hLbVNqE9vWMI05GpDaPRngEEWnEerHRWOwy42gh38i7dqX46Y1PLXgmlBNqo6Jlgpc
	 RIjN5h4k819B9+XAxWAtZh/ZeeylT78bE+9ZIwhUOgwrcLwH/4XxvYVnC+q+MzSSCA
	 /U582UJWb8qRQ==
Date: Fri, 7 Mar 2025 09:09:37 +0200
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
Subject: Re: [PATCH v12 17/19] tpm, sysfs: Show locality used by kernel
Message-ID: <Z8qbsdX2hTathvbs@kernel.org>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-18-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219194216.152839-18-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_230943_369701_CCE6CC2B 
X-CRM114-Status: GOOD (  17.44  )
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

On Thu, Dec 19, 2024 at 11:42:14AM -0800, Ross Philipson wrote:
> Expose the locality used by the kernel to sysfs.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm-sysfs.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
> index 94231f052ea7..2da5857e223b 100644
> --- a/drivers/char/tpm/tpm-sysfs.c
> +++ b/drivers/char/tpm/tpm-sysfs.c
> @@ -309,6 +309,14 @@ static ssize_t tpm_version_major_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(tpm_version_major);
>  
> +static ssize_t locality_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct tpm_chip *chip = to_tpm_chip(dev);
> +
> +	return sprintf(buf, "%u\n", chip->kernel_locality);
> +}
> +static DEVICE_ATTR_RO(locality);
> +
>  #ifdef CONFIG_TCG_TPM2_HMAC
>  static ssize_t null_name_show(struct device *dev, struct device_attribute *attr,
>  			      char *buf)
> @@ -336,6 +344,7 @@ static struct attribute *tpm1_dev_attrs[] = {
>  	&dev_attr_durations.attr,
>  	&dev_attr_timeouts.attr,
>  	&dev_attr_tpm_version_major.attr,
> +	&dev_attr_locality.attr,
>  	NULL,
>  };
>  
> @@ -344,6 +353,7 @@ static struct attribute *tpm2_dev_attrs[] = {
>  #ifdef CONFIG_TCG_TPM2_HMAC
>  	&dev_attr_null_name.attr,
>  #endif
> +	&dev_attr_locality.attr,
>  	NULL
>  };
>  
> -- 
> 2.39.3
> 

I think we are now in good standing point with TPM changes.

I'd really put focus now on unimportant seeming but actually important
documentation full refinement. It has all the infos but it is torture
to read still :-) I did put detail how I would like it to be edited
(personally, perhaps others could comment that part too). If it was
a bit more punctual it would be easier to follow rest of the patch
set.

BR, Jarkko

