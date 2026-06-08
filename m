Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986B1CD8C9F
	for <kexec@archiver.kernel.org>; Mon,  8 Jun 2026 17:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HKaJq/FqOrnnsfhBbbAGAUYIrDaTZV/8Gb9XfRMpf40=; b=CkMuIByHK3efUIeksigQzi7hEx
	CXd3MRuapavuRMWcSl5sPElEjODCcq9DMLnixO4ma/AIp99acnussC22969xkWY5mcMT9BxzFQQpi
	C+GCZjh6fz2qmOByAMWpNJszvqXwFsMf05UAVSgv5bQgbl7Df7VnGeF7Ynov7qKXqUGO2iCmqv5Dx
	28YdyIc+tZFVKFDmIjPjq+MRyi8Mpn7oHreLzpHeMJA6f7fEzm1x3uRmptyorcSuCZfUrZcyBvQ4i
	aewEsNMHOmcQoMEvdg73takTDREzX2e5X7wPaNkOhdCjKU+QX8kkNEDXESxXoAol830WoE2HAmYck
	icv9Gvnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWeAc-00000004ECZ-2zcM;
	Mon, 08 Jun 2026 17:53:54 +0000
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWeAa-00000004EBM-0SpZ
	for kexec@lists.infradead.org;
	Mon, 08 Jun 2026 17:53:53 +0000
Received: by mail-dl1-x1229.google.com with SMTP id a92af1059eb24-137ff9a7d5eso28853c88.1
        for <kexec@lists.infradead.org>; Mon, 08 Jun 2026 10:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780941231; x=1781546031; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HKaJq/FqOrnnsfhBbbAGAUYIrDaTZV/8Gb9XfRMpf40=;
        b=GOCL4x5Bqe0uyQbYk6t5QNM6ShttmETb6iYJeQErETjVutICldqGCfwQiwIFMNm+dv
         kCamubyE2YmOCsaGpeDzyLJzgk6p1DqBo3cFnNGemfzI0jHHxvpSc0V7e75OpHT50+CQ
         ObTUIriv/cwzVjkUaIcrBmW7viiw6ec1cy9UeCOI4IMWnyO6bWFYz2Bo8NDgtJOFPCuv
         cHEZ6iTkKfXidwbgg+K0mAzUAAV7FfevzmoE5Sxb7KrG/1ybo6e823nyN1dF4yzzEASF
         6pYhmEOaVqoKYQuiE2DfdHS5yd6MXEsArS8h5hFzUm3Ed+Ib/dQZflSfVD4GqurHh8zp
         /6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780941231; x=1781546031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKaJq/FqOrnnsfhBbbAGAUYIrDaTZV/8Gb9XfRMpf40=;
        b=eSHsN3FaL+jPmXsoUpOpHtg9n20ayHhhRNXzpt9QyVbSsmGVH2AFxj37fX+K/UIdYO
         QMxalBsinNPJpoAfkBR/tE7uf6xn2yWDJMfvWqJy7oj4fhtX3AeNHb6Iqzh3XR5HOp+H
         vYLQqQBRUEL1UeC3Tg5vqXtU77yxh3A45HlU8E67Uclq0ejHDtHoVCVhlN0p0Dk/HKqc
         an2eppRvjXsIKi6iF02X3jEnd61aX5o9MC/TL1PE0qzvkR+duEiKet9mXW8PcDXGbne7
         kzcj7DxKlLuTliXDUznkeUZgBRlmcBv4xX58cVV7Q5tzAJ46u7wFPn7HGuOnQGQn1S3z
         RlKQ==
X-Forwarded-Encrypted: i=1; AFNElJ8smgUGhr+ohElY3yw13n3q8b2pUwGy39mJgozDmOU3+2aWfPJeMTUvU0sbYVv8ileKsOe3Mg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzfynyhhCppO2oUWx8vM1vlWoEWvltOtpp3nqP7HiyZ3LIa3obe
	K3JbyOCxOns4TIzdtLDUT+I4mS+cQK7xt1PgyKg7Y3vGj3LiEt3LRpQ85QRxGZ53qA==
X-Gm-Gg: Acq92OGE7IIqRMyTmAC2QU+N9o7oxSCJPda/QifOnMhNuudeQ5ENO4LSRxrSUodK1Z0
	PavFhZdBItNV9VoSyfu9a10ViRWjquoO62a/HI2bR5CPUzQns/ZXLQtF5Fk8Fqh3uEchUDKXtxt
	E7R0yb/4/dwjpP4XbU9i+RVyjNR1bCHrWj0GlcJeh5I+FE5DwaDdXM5eztrmHGCylT94Eg1X4De
	EP99Xv2cTYgOTfzgJeyDzv7up3MkYAy5e8D/yJbmVj7ETKEaSKYyffZBFn+HMyK//KifTpPQlyx
	gWV7YkHh7cBurlkWYNUaJzQi88oIM5qEvT6fybch9bx4gK/N3tglQLwKptmoxLIrYaMfRuLEaA4
	j3JChYnsmaSltm2Wws+FUVJSoMKm2IuQ07bDSfqShlul7YELKEP5mxcsB1xvTJc35JJpLeIZz70
	cJF66ZUqzdHUH8HEq678S+gd3Zf80PBmKPud6vXg875+bvOPlwFfbSJcPVR2Z7+VGqWxj83Jg=
X-Received: by 2002:a05:7022:48f:b0:137:ead9:4608 with SMTP id a92af1059eb24-13807cbdceamr310348c88.17.1780941230355;
        Mon, 08 Jun 2026 10:53:50 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db528dcsm21257291eec.3.2026.06.08.10.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 10:53:49 -0700 (PDT)
Date: Mon, 8 Jun 2026 17:53:43 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 1/4] dma: Add DMA allocation preservation KHO ABI
Message-ID: <aicBp4tSyzyYBnzn@google.com>
References: <20260505002737.2213734-1-skhawaja@google.com>
 <20260505002737.2213734-2-skhawaja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505002737.2213734-2-skhawaja@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_105352_151037_6F1752FE 
X-CRM114-Status: GOOD (  21.25  )
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

On Tue, May 05, 2026 at 12:27:34AM +0000, Samiullah Khawaja wrote:
> The DMA allocations can be backed by a variety of allocators. Add KHO
> ABI for the preservation of contiguous allocations that are done through
> dma-direct.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  include/linux/kho/abi/dma_alloc.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 include/linux/kho/abi/dma_alloc.h
> 
> diff --git a/include/linux/kho/abi/dma_alloc.h b/include/linux/kho/abi/dma_alloc.h
> new file mode 100644
> index 000000000000..46e61db81abe
> --- /dev/null
> +++ b/include/linux/kho/abi/dma_alloc.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_KHO_ABI_DMA_ALLOC_H
> +#define _LINUX_KHO_ABI_DMA_ALLOC_H
> +
> +#include <linux/types.h>
> +
> +/**
> + * DOC: DMA Alloc ABI
> + *
> + * This header defines the structures used to serialize the state of DMA
> + * allocations, done by device driver, across a Live Update.
> + *
> + * Only DMA allocations done through dma-direct that are contiguous and
> + * allocated using alloc_page are supported.
> + */
> +
> +/**
> + * struct dma_alloc_ser - Serialized state of a single DMA allocation
> + * @page_phys: Physical address of the preserved pages
> + * @size: Size of the DMA allocation
> + * @force_decrypted: Whether the memory is force decrypted in previous kernel
> + */
> +struct dma_alloc_ser {
> +	u64 page_phys;
> +	u64 size;
> +	u8 force_decrypted;

Should we also stope attrs in this ser state here? There might be flags
like DMA_ATTR_NO_KERNEL_MAPPING which would need to be preserved across
a kexec? 

> +	u8 padding[7];
> +} __packed;
> +
> +#endif /* _LINUX_KHO_ABI_DMA_ALLOC_H */
> -- 
> 2.54.0.545.g6539524ca2-goog
> 

Thanks,
Praan

