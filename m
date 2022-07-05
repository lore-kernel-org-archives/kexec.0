Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7066FC43334
	for <kexec@archiver.kernel.org>; Tue,  5 Jul 2022 22:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ItfyElihS+WX5JanKoyRM9gyTSUmCzlP3r4PfwGXdS4=; b=boxn6KFfq3HSS1
	LT5an6d5bJiggJqCQl84gP2JkTSgbvSeE8+A7fb5Rwl+/lyFMBhymslEBpNrmSX+vc4qQ51nEwEs7
	6WtPSksHppQw7PoqVQktaypC4VLyTuDn573vNfTxh69/7nOHDtsesCq61SHYFpCBHygEsYLU3DMG7
	iq6ZjzBijlM6Bcc7xI+kYsa0jv3F0E0nCysOXb+Rg7H/kiYKF0hv9hI2mm5+kD1SS+xR+9TyTxuEu
	sIOWi6wa5Mwc35Sh39MRp+Lf/Lo5odm3+C+dZVpT+qgQDBRUivnDWjNvFFCxAH6unOY4yBkRLkVi4
	AvJpvTh10uIHW2OP1t4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8rKE-003H2z-2d; Tue, 05 Jul 2022 22:47:22 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8rK9-003H1D-NE
	for kexec@lists.infradead.org; Tue, 05 Jul 2022 22:47:20 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265LofWc018671;
	Tue, 5 Jul 2022 22:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=qTkmdsElXaiI1gFxf5tq/TR/wAqNux/WQh/17NhFdpo=;
 b=dwLd9bdyGhDwHfRQ4U5QkUxUd3Zfr622lV48dIHcrYhh8iS8Mcb2aiw+69VtUoTXDC9e
 28MeyfSCLc3bnn3q4m8v+ZmnWPwLypZf7YcYKs7SvctVfexTLt0RxnTGhn964iueaM1R
 YpEK7EPqCqPD5qEGmJPu5udIlQpdLPEXk3i8p1PmTlXXm6rdpuTkzkvwktnqjlh5NXrb
 3z5GpGQquw637RMADPcP+drUpy0v0SXD8aFLoV3lcale9n9diU39XdiW4aHVvFTjYWmx
 HFYL41Iwfs9AY1o8eASTAdKp3pFRsZIErrx74cGYFLtN1dUhscMuQ5UmKxwt3rCS3X/W qg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h4wju937n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Jul 2022 22:47:04 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 265MdY6L003859;
	Tue, 5 Jul 2022 22:47:04 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h4wju936w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Jul 2022 22:47:04 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
	by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 265MM0K2001260;
	Tue, 5 Jul 2022 22:47:01 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by ppma02fra.de.ibm.com with ESMTP id 3h4uwp030n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Jul 2022 22:47:01 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 265MkwHw23855430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Jul 2022 22:46:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56A3FAE045;
	Tue,  5 Jul 2022 22:46:58 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A85DAE04D;
	Tue,  5 Jul 2022 22:46:55 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.99.148])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue,  5 Jul 2022 22:46:55 +0000 (GMT)
Message-ID: <47256afac54d68c23f0bdec257ffa26ddf1eb25d.camel@linux.ibm.com>
Subject: Re: [PATCH v4 4/5] of: kexec: Refactor IMA buffer related functions
 to make them reusable
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>, kexec@lists.infradead.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: nayna@linux.ibm.com, nasastry@in.ibm.com, mpe@ellerman.id.au,
        Rob
 Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, Borislav Petkov <bp@suse.de>,
        Jonathan McDowell <noodles@fb.com>
Date: Tue, 05 Jul 2022 18:46:54 -0400
In-Reply-To: <20220701022603.31076-5-stefanb@linux.ibm.com>
References: <20220701022603.31076-1-stefanb@linux.ibm.com>
	 <20220701022603.31076-5-stefanb@linux.ibm.com>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -x1Dh1y0EJb-AfkgfkHymnGfWTli0eet
X-Proofpoint-GUID: r5JLXk2Kpw16oJa3Z5CMPR49-qQNuX-5
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-05_18,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 phishscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207050097
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220705_154718_074869_4686864F 
X-CRM114-Status: GOOD (  34.66  )
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

[Cc'ing Borislav Petkov <bp@suse.de>, Jonathan McDowell <noodles@fb.com
>]

Hi Stefan,

On Thu, 2022-06-30 at 22:26 -0400, Stefan Berger wrote:
> Refactor IMA buffer related functions to make them reusable for carrying
> TPM logs across kexec.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Mimi Zohar <zohar@linux.ibm.com>

Refactoring the ima_get_kexec_buffer sounds good, but there's a merge
conflict with Jonathan McDowell's commit "b69a2afd5afc x86/kexec: Carry
forward IMA measurement log on kexec".
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/of/kexec.c

thanks,

Mimi

> 
> ---
> v4:
>  - Move debug output into setup_buffer()
> ---
>  drivers/of/kexec.c | 131 ++++++++++++++++++++++++++-------------------
>  1 file changed, 76 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index c4f9b6655a2e..0710703acfb0 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -115,48 +115,59 @@ static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
>  	return 0;
>  }
>  
> -/**
> - * ima_get_kexec_buffer - get IMA buffer from the previous kernel
> - * @addr:	On successful return, set to point to the buffer contents.
> - * @size:	On successful return, set to the buffer size.
> - *
> - * Return: 0 on success, negative errno on error.
> - */
> -int ima_get_kexec_buffer(void **addr, size_t *size)
> +static int get_kexec_buffer(const char *name, unsigned long *addr, size_t *size)
>  {
>  	int ret, len;
> -	unsigned long tmp_addr;
>  	unsigned long start_pfn, end_pfn;
> -	size_t tmp_size;
>  	const void *prop;
>  
> -	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
> -		return -ENOTSUPP;
> -
> -	prop = of_get_property(of_chosen, "linux,ima-kexec-buffer", &len);
> +	prop = of_get_property(of_chosen, name, &len);
>  	if (!prop)
>  		return -ENOENT;
>  
> -	ret = do_get_kexec_buffer(prop, len, &tmp_addr, &tmp_size);
> +	ret = do_get_kexec_buffer(prop, len, addr, size);
>  	if (ret)
>  		return ret;
>  
> -	/* Do some sanity on the returned size for the ima-kexec buffer */
> -	if (!tmp_size)
> +	/* Do some sanity on the returned size for the kexec buffer */
> +	if (!*size)
>  		return -ENOENT;
>  
>  	/*
>  	 * Calculate the PFNs for the buffer and ensure
>  	 * they are with in addressable memory.
>  	 */
> -	start_pfn = PHYS_PFN(tmp_addr);
> -	end_pfn = PHYS_PFN(tmp_addr + tmp_size - 1);
> +	start_pfn = PHYS_PFN(*addr);
> +	end_pfn = PHYS_PFN(*addr + *size - 1);
>  	if (!page_is_ram(start_pfn) || !page_is_ram(end_pfn)) {
> -		pr_warn("IMA buffer at 0x%lx, size = 0x%zx beyond memory\n",
> -			tmp_addr, tmp_size);
> +		pr_warn("%s buffer at 0x%lx, size = 0x%zx beyond memory\n",
> +			name, *addr, *size);
>  		return -EINVAL;
>  	}
>  
> +	return 0;
> +}
> +
> +/**
> + * ima_get_kexec_buffer - get IMA buffer from the previous kernel
> + * @addr:	On successful return, set to point to the buffer contents.
> + * @size:	On successful return, set to the buffer size.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +int ima_get_kexec_buffer(void **addr, size_t *size)
> +{
> +	int ret;
> +	unsigned long tmp_addr;
> +	size_t tmp_size;
> +
> +	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
> +		return -ENOTSUPP;
> +
> +	ret = get_kexec_buffer("linux,ima-kexec-buffer", &tmp_addr, &tmp_size);
> +	if (ret)
> +		return ret;
> +
>  	*addr = __va(tmp_addr);
>  	*size = tmp_size;
>  
> @@ -191,72 +202,82 @@ int ima_free_kexec_buffer(void)
>  	return memblock_phys_free(addr, size);
>  }
>  
> -/**
> - * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
> - *
> - * @fdt: Flattened Device Tree to update
> - * @chosen_node: Offset to the chosen node in the device tree
> - *
> - * The IMA measurement buffer is of no use to a subsequent kernel, so we always
> - * remove it from the device tree.
> - */
> -static void remove_ima_buffer(void *fdt, int chosen_node)
> +static int remove_buffer(void *fdt, int chosen_node, const char *name)
>  {
>  	int ret, len;
>  	unsigned long addr;
>  	size_t size;
>  	const void *prop;
>  
> -	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
> -		return;
> -
> -	prop = fdt_getprop(fdt, chosen_node, "linux,ima-kexec-buffer", &len);
> +	prop = fdt_getprop(fdt, chosen_node, name, &len);
>  	if (!prop)
> -		return;
> +		return -ENOENT;
>  
>  	ret = do_get_kexec_buffer(prop, len, &addr, &size);
> -	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
> +	fdt_delprop(fdt, chosen_node, name);
>  	if (ret)
> -		return;
> +		return ret;
>  
>  	ret = fdt_find_and_del_mem_rsv(fdt, addr, size);
>  	if (!ret)
> -		pr_debug("Removed old IMA buffer reservation.\n");
> +		pr_debug("Remove old %s buffer reserveration", name);
> +	return ret;
>  }
>  
> -#ifdef CONFIG_IMA_KEXEC
>  /**
> - * setup_ima_buffer - add IMA buffer information to the fdt
> - * @image:		kexec image being loaded.
> - * @fdt:		Flattened device tree for the next kernel.
> - * @chosen_node:	Offset to the chosen node.
> + * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
>   *
> - * Return: 0 on success, or negative errno on error.
> + * @fdt: Flattened Device Tree to update
> + * @chosen_node: Offset to the chosen node in the device tree
> + *
> + * The IMA measurement buffer is of no use to a subsequent kernel, so we always
> + * remove it from the device tree.
>   */
> -static int setup_ima_buffer(const struct kimage *image, void *fdt,
> -			    int chosen_node)
> +static void remove_ima_buffer(void *fdt, int chosen_node)
> +{
> +	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
> +		return;
> +
> +	remove_buffer(fdt, chosen_node, "linux,ima-kexec-buffer");
> +}
> +
> +#ifdef CONFIG_IMA_KEXEC
> +static int setup_buffer(void *fdt, int chosen_node, const char *name,
> +			phys_addr_t addr, size_t size)
>  {
>  	int ret;
>  
> -	if (!image->ima_buffer_size)
> +	if (!size)
>  		return 0;
>  
>  	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
> -				       "linux,ima-kexec-buffer",
> -				       image->ima_buffer_addr,
> -				       image->ima_buffer_size);
> +				       name, addr, size);
>  	if (ret < 0)
>  		return -EINVAL;
>  
> -	ret = fdt_add_mem_rsv(fdt, image->ima_buffer_addr,
> -			      image->ima_buffer_size);
> +	ret = fdt_add_mem_rsv(fdt, addr, size);
>  	if (ret)
>  		return -EINVAL;
>  
> -	pr_debug("IMA buffer at 0x%pa, size = 0x%zx\n",
> -		 &image->ima_buffer_addr, image->ima_buffer_size);
> +	pr_debug("%s at 0x%pa, size = 0x%zx\n", name, &addr, size);
>  
>  	return 0;
> +
> +}
> +
> +/**
> + * setup_ima_buffer - add IMA buffer information to the fdt
> + * @image:		kexec image being loaded.
> + * @fdt:		Flattened device tree for the next kernel.
> + * @chosen_node:	Offset to the chosen node.
> + *
> + * Return: 0 on success, or negative errno on error.
> + */
> +static int setup_ima_buffer(const struct kimage *image, void *fdt,
> +			    int chosen_node)
> +{
> +	return setup_buffer(fdt, chosen_node, "linux,ima-kexec-buffer",
> +			    image->ima_buffer_addr, image->ima_buffer_size);
>  }
>  #else /* CONFIG_IMA_KEXEC */
>  static inline int setup_ima_buffer(const struct kimage *image, void *fdt,



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
