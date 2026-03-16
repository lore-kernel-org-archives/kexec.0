Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D85F53D6C
	for <kexec@archiver.kernel.org>; Mon, 16 Mar 2026 21:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OzZGe5xJiZCdI8yLv+9J6duKMFuSxCgV09Lwr9FRsuY=; b=W9EBfMBKS8C+YVqXAZ7i0qNt/r
	uoZLyprw3/oE9VKJWzwGsC1Ag5pkw4tOMlRDs6V7NGV1nW5GHfdkLSzb2gsCuzqU1D6nBgYuJTzQE
	2k7gFIZspEu2MdG34+/66bMD6GYSnDvbXkNiSgDr20MJDOGaFXhsBbTL6ZevOwen6BvcwvwAO2mSQ
	P6rQbpSFt/NropbyiT3UjPpEGOZb+OdCQI2mHeK66pjOsjXltBwqCoBh5U8ParaWnk6It/HOijbly
	nDLjOoWtM9IVYWzjXhpMHZkHhwy2+qbqJBxefoA8FVevbrLhfZEbyhZQjDqgvtll+HQ6pYY8mFlEN
	uxNpzekw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2FuR-00000004y3S-00o0;
	Mon, 16 Mar 2026 21:55:35 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2FuO-00000004y35-36Yr
	for kexec@lists.infradead.org;
	Mon, 16 Mar 2026 21:55:33 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2b052ec7176so13715ad.1
        for <kexec@lists.infradead.org>; Mon, 16 Mar 2026 14:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773698132; x=1774302932; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OzZGe5xJiZCdI8yLv+9J6duKMFuSxCgV09Lwr9FRsuY=;
        b=FYsFn4yH4pEWLXw+DFxyvQpAxwmqpOPXYW1lKDvNw6h0FfJm+CdX9K+OY2ACM8pwgu
         Bs4VmXVPpaJC7YtrckdTemvqLd8m3YP7Qim9lN66RnF11pS2ADabI/b4f4IcYx5Tgmzk
         BOuZ+MR+0j8uNUwnpN1yqWC1wf4vaDR8h4nnjUeh7qBIpAhhJQegb2jYHeBKbwfJ4Q+B
         JKPBLY1he9go5lC2X2Xzu+tA9VWNL0RLrkHV0LsHraX/0+VO0n1aGQ1XGQ/6W5akEc+2
         RX7zcG6vZslqFpHr+utCflQdGadUFRkhpsIqY49ioPo/3wfIC/6c+O7B3+feAqIUQ9DO
         ZQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773698132; x=1774302932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzZGe5xJiZCdI8yLv+9J6duKMFuSxCgV09Lwr9FRsuY=;
        b=n1mMR2+xfbYscm+Aij5AoWmMariIAcTmLyaEa+FXqWG+YKyqYN79e4mbnG10hQV7se
         KuDA/mdFPgz4WDokweTqefJZZ7UxNJ/wrudcIaOWbJs3ejZO8xduM6043U1Lh2iVkb6q
         HSK+5g2blk2yUE7mmftYNMlqvhfl+LqJ3is5CHX0wyX5K7kFi07oqguxbvSdF0HIjrPO
         rglEQ4f7VYhmgrxKGU18yy874Tedf9EgytqjE2mmRQCAWEKPlLSF4/zreQXGMT20lR4/
         NDyqIlDT2jLSv1RkKP13t0YODlIVdxSGpGhPwVcOt9z3LZkJ5fJaQ1UvzSqzAtxD1mqS
         wx1A==
X-Forwarded-Encrypted: i=1; AJvYcCVmmQuAekB86jHx77xikhlkoe3zqzAn7Oeak9biKOEkt4Ocx2I40jaVrc7XwkCthEqOnIm25Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YyOXS6MYvRl1I15iVuSolXCYR3t6aWyffwNv2ALBXA7J6uI004a
	VJr6bNAgT0qD1u0P+Jy4J4smw6tpj8bNb+GYyY1PDWg3xHL42/ZVmRGci7hOtvS/kg==
X-Gm-Gg: ATEYQzwWIfYESkl902iG4GNEWUGCLW5sDqP8k3cXS7didGMYdt/3PyIqI1HtAS1OkMT
	G5uwgboYmyddgreVqZaQqF3BW3TRmQd8bAFYCMnA1tW1QJ7lKKicAmBAkVgYDcozgTbAyvM+aJw
	USjMpsvw3U869BI66pMrfuOVQ+8iD5X4KkB90M6/EruVyhgb4s9DGXuJrIM77VosFd/V+84l2++
	n7fywXLOb+vAwgFFdP/no4tncZcLyratdHP5B5f69TA1VAxrKPQu/dqNTc5IvVBvAbCGEMmvYxq
	hwi9e7QcXj0cLquQ2O4LkceMr3kMtLO5IGV2CxPVBIlx2IZfdDawovOUKTUnMPaPpqhiAR/93f4
	kjsQcVQuW6eGlqqY9YR/sXuJlhHD4TC5kmF8exbeoPUdZuAcpWM+qIZMfz/XDDgW/JI7YHDeu0O
	Ugy5fV8pyGW9AaRGFRQ9V3N2JMGM+lZQcRtDIB+n9JpLHTRctNAw6BGkN6dw==
X-Received: by 2002:a17:902:e885:b0:2ae:4e8e:954e with SMTP id d9443c01a7336-2b06599f6camr431285ad.5.1773698131381;
        Mon, 16 Mar 2026 14:55:31 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7edd14sm155239485ad.50.2026.03.16.14.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:55:30 -0700 (PDT)
Date: Mon, 16 Mar 2026 14:55:26 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 11/22] docs: liveupdate: Document VFIO device file
 preservation
Message-ID: <20260316215056.GC1846904.vipinsh@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-12-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129212510.967611-12-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_145532_784712_7C48E4B0 
X-CRM114-Status: GOOD (  16.73  )
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

On Thu, Jan 29, 2026 at 09:24:58PM +0000, David Matlack wrote:
> Add documentation for preserving VFIO device files across a Live Update,
> as well as some generic file preservation documentation. This
> documentation will be extended in the future as new types of files are
> supported and new dependency/ordering requirements are added.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  Documentation/userspace-api/liveupdate.rst | 144 +++++++++++++++++++++
>  1 file changed, 144 insertions(+)
> 
> diff --git a/Documentation/userspace-api/liveupdate.rst b/Documentation/userspace-api/liveupdate.rst
> index 41c0473e4f16..dbf1e4aeddd7 100644
> --- a/Documentation/userspace-api/liveupdate.rst
> +++ b/Documentation/userspace-api/liveupdate.rst
> @@ -14,6 +14,150 @@ ioctl uAPI
>  ===========
>  .. kernel-doc:: include/uapi/linux/liveupdate.h
>  
> +File Preservation
> +=================

Should we use the existing way where documentation is written in code
files and referenced here? Maybe luo_file.c for this?

> +
> +File Retrieval
> +==============

Same as above.

> +
> +
> +VFIO Character Device (cdev) Files
> +==================================
> +

vfio_pci_liveupdate.c

