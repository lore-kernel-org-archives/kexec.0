Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C012F53D69
	for <kexec@archiver.kernel.org>; Mon, 16 Mar 2026 16:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f55pgibkB6ee+8s3SeqViClU/kNvQ9qZ/ylLM13UAeM=; b=qtQ12BXP0jR/Bqxw7D5HAgAmUE
	5awkwuIIkNbjSwIaiMHA+/U8mrWJh+3IhJZy3AtrhG7EPy+zX0DVsZhBFTubS+SsWYzEC8pUXJlQR
	KBd/AdrwmJ9y4tGPWNfUvUn70m2EvNc2jKqWundmpgHwwFZ9t6Hwvd6ywkxfWM8QlQdO93FPaYDZt
	zaIwDGy5lJpU530f38+7Awf2mnDEkSauRC3WQm9Xz4JHgwdYG9EREPRIO+uoqtoFH8ZubRET1cGZ9
	PLauXD75ftPel5gG8Rcszdp68JCdqfS1Vzfndq7pJC+RMN6kjdI9N7Jcg1m+ja0q3Cqe1z5AJJxpo
	ZtCsFxtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2AQC-00000004PTr-1kbZ;
	Mon, 16 Mar 2026 16:04:00 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2AQA-00000004PTT-0KfQ
	for kexec@lists.infradead.org;
	Mon, 16 Mar 2026 16:03:59 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2aeab6ff148so160565ad.1
        for <kexec@lists.infradead.org>; Mon, 16 Mar 2026 09:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773677036; x=1774281836; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f55pgibkB6ee+8s3SeqViClU/kNvQ9qZ/ylLM13UAeM=;
        b=asVpDKXlXHolRpRvdc7BXOUjHgh7WzPPJ1T5YItA/MFNjHLyAFGUnn3thmkRQgon0P
         GlRORnYiPZcFCxiWyhhEeGsBgXPC4DyVhcF/bEse0EgZ/WZbC1h8hgxlFKWE3WPeUH8U
         YDXTd4buHDtlS/Us4uqBmr7+BnSDBTQiDvGhDoplN8/B4gdqqw9/+T0FW/D15bfcB8y5
         bYUdLyiboJm+ANgEzey6eCdvCf7jCG6UBe4gX1NI4KnQygiXag3W2Jm2NOxTmRUd3qG5
         o3XLwb9rtzozPLcDSXpybSNYqsUT0A/AOzlJNYzhXZxlrAu4UvUxVNKcowfkQdezXmFh
         EC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773677036; x=1774281836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f55pgibkB6ee+8s3SeqViClU/kNvQ9qZ/ylLM13UAeM=;
        b=AU0KQBklhNnqfaIsLCfXMs0fu8BSYohTqp6+XSqPnmOPpkI4IoQqqLuaFBfV0Sagtg
         QXe+rTU2SmhZJ2mIQUOYAy50DudBZVsbIK+mYYc4/BQschU2I9mNnfxP8XFcWgEvn5nz
         P5CcbAA5iGZ0SF5pjqnJa6Tk+W4r5j1YndV4mJxBG3LEJ3NLZPYIMIDROSAMzINJz249
         4yAE7O6IyJlssXACiiQiBfIJ/nE1wJEvEappOdK+hU3sWI70YZBGR/R91m7YkPLx05Sf
         BtptbX2IrwajcSt7jMz34neUlnYKotwDsWSfXIJUBzqy5oRuRJmXze/IV7NXfAXYGz23
         OYyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIM13bYf8pFZ3TW01V1ZJnNr9nV7o9GLLRNi78uLoRJvptXdiwUjd/0kmy14eA8pnY32BwbQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy6VM5mSP/QrRRDWWLD9ZecjBGqOmTuwaHS/SkhZBzRvPQWD2gX
	27aEEAaijCQcnpm/sw07GvudS4P8Hx/S2lqRPzv6yzCgCD2a37qP4u2Tgj+UEzWP2A==
X-Gm-Gg: ATEYQzw0aacGEJIGEt+mqVTJ6AxGFOGoVJIJskpvBM2DhMurMExy7HGZ2MWW6jhSfH6
	XABQ5Ksrx2jeDzYM9svo+vok0Dbs4XYb4hA0OCoFnW1OA8jA/yPeb6WD6ymPCnnkHnnw/hQvJ3B
	g0NgKl47nbasZy6+NSd5KjOmkRJMCEkGB3anyaXl4iQ5r7zrSgRtFBw0KJO8KrLMJRzPEKli+I3
	c1C+mlSNDwS20vf1VqfJfaNYi/CSHNWJLmiT1Rmo4j+Ux+obR3FyAiuetvFkOVjCKujRRBZgJ6X
	8SoR8h5q4JoxrNh2q6uO1pJZ1NYFYGBpnd+D/0eUotAnIHWdVkrOy701XeBRNJUzxM1AhU9I/G3
	3T3t1IxXHO4orfNgujI7Ij0lqJ6B0xBsoMnh0uWDtDQgQNgKbq6zqXKvShgd0tUO7wng1BbIV9D
	Qdf7rWmPl2Ep5Rt/6DstNfUhvsIyBemMu2I3QxQGAGjArarnsGi2x3V+HSXw==
X-Received: by 2002:a17:902:f54f:b0:2ae:d10c:6382 with SMTP id d9443c01a7336-2b042102968mr4463575ad.20.1773677035489;
        Mon, 16 Mar 2026 09:03:55 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73eb9966cesm9261411a12.10.2026.03.16.09.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:03:54 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:03:50 -0700
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
Subject: Re: [PATCH v2 07/22] vfio/pci: Notify PCI subsystem about devices
 preserved across Live Update
Message-ID: <20260314061747.GD4177610.vipinsh@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-8-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129212510.967611-8-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_090358_125357_92A8CB45 
X-CRM114-Status: GOOD (  13.68  )
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

On Thu, Jan 29, 2026 at 09:24:54PM +0000, David Matlack wrote:
> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> @@ -192,10 +200,24 @@ static struct liveupdate_file_handler vfio_pci_liveupdate_fh = {
>  
>  int __init vfio_pci_liveupdate_init(void)
>  {
> +	int ret;
> +
>  	if (!liveupdate_enabled())
>  		return 0;
>  
> -	return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> +	ret = liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> +	if (ret)
> +		return ret;
> +
> +	ret = pci_liveupdate_register_fh(&vfio_pci_liveupdate_fh);

May be we should rename pci_liveupdate_register_fh() to something like
pci_register_to_liveupdate_flb(). In the current way, it is confusing to
why same handler is getting registered at two places.

Above name will also make it similar to IOMMU series as well
  https://lore.kernel.org/kvm/20260203220948.2176157-2-skhawaja@google.com/

