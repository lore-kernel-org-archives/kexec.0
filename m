Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A12CD8C8E
	for <kexec@archiver.kernel.org>; Sat,  6 Jun 2026 22:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LYxfXn22R4rSEp+91VSc3le3ou2J0SQ37n2yrmKjM2Q=; b=fozAqWPOx6raqM/Tcd/gjQ4jd2
	9HrQ2m3DsKMBrgz3K3xf85AgWTfTrQ6PIpyEKdnuohNO1aaWrF6qN0bWbgrEzv64NsaHNDlz7dNtl
	Bhd6mJncUfbGctN8oGRET622NK/u0YVKcJ8ND7JrftIZzQqKYHJR+PSL8YNYLUKkVyX6rvfprEk2P
	pe7BKwvGjBPCKl04p4nfLcg9gkyMmKwTt+TgyqkF0aw5Np7HavSyQrNClQvXiyBVsdp2QV7sNzyhO
	Y7BAsRjHXFXStFB2ink/bOlRWsKC6lVKLhQTTz+M+HrzLhVS20SjS8BsHPfpqLnhHymW4AU30ZW5O
	sWu7161A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVzIf-00000001ryX-1VXb;
	Sat, 06 Jun 2026 22:15:29 +0000
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVzId-00000001ry9-06Qo
	for kexec@lists.infradead.org;
	Sat, 06 Jun 2026 22:15:28 +0000
Received: by mail-dl1-x122d.google.com with SMTP id a92af1059eb24-133362c30cfso21058c88.0
        for <kexec@lists.infradead.org>; Sat, 06 Jun 2026 15:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780784126; x=1781388926; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LYxfXn22R4rSEp+91VSc3le3ou2J0SQ37n2yrmKjM2Q=;
        b=oM4bkG1cVLPit1vtoaAi1BZUvN+j/zfxkM8NEAKoTl+CkZaUgufIbyfhMgDdowNoQx
         ul69iL0zZhbNBfwTJCw2f2wKRHDL2Skm+83Wt3NE6By8XLH4kYmqVDpSjXOV7Kgek4VX
         a4OS4JhqOlTWIuAUeiRXh7Jx1ZVOOSwzfVk8VppD9h1hTUCCIcTD8qiCqtuqg3TYZdeu
         Z+7U1kWzW/jjTWhbeaBgY512a1dtjwdbWS+o0gu8vMcd3zATlU2y3eEUDh+160ploPve
         MVmtnt4AValayn+svE7K/u03swWrbo8CB40pUOF6yQ0pcI/hFTFKrnW5qFnv1+gdORkq
         XlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780784126; x=1781388926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYxfXn22R4rSEp+91VSc3le3ou2J0SQ37n2yrmKjM2Q=;
        b=ZYfQxDkMhDYMrxSIayVz2qr8lka41Xfp9uqh/hHPgZAkMKeDoLY86tcn/ybSZV7Wcl
         tC7ubfGwDySRj6d+ilLHjT/5qClTrAx99DIx3ydl5Hx6H7xhNWplDYZNBnY1pmeRD8E8
         P/5lrRzrg+tOBkQEUGQg+t4ABVcIL8Il/bvnYZ+aQlFsP2ELoI2gJ8Tq5X3gd633BYAK
         2ELk4jSZmBTL4/6zXvpxRAuJYeFoZKzu6QYhl79jcP+k1zgdQfJGjDIC5DymlCLDgk3e
         Pxn8WiPmdQopjA49Dcr6t4dX8L4GvG5eGLyY1GSuw8wR/7lQmplzBoQe3Ba7dZqdQGTs
         VQSQ==
X-Gm-Message-State: AOJu0YxoWJqBk/xP75FVXh475M7PrSrkgFlRZfs3SErMWOxBQB8OShzj
	k5mm/3ft4XyIyDLJH0ay7kn1nHLQBejwneRPNlNter/3d/YbOtdBc8QfNk2ECOTb2A==
X-Gm-Gg: Acq92OEaV5EZyGQ3m1TbJ5j50JRjWdzlBTAgWdn4Eill1Tg79Hw9ZRGW4hEpn1eYgbw
	7EU/6pMB4mBGzhsaqXtZBXChvVpis+8XoOpDLRw+vDzx8rnY2mbSMauymovyi6HoU3MSp+vuwWW
	Y2gyNd1p1QexFvv9GYRZI6R0nNkAW/9p2atltqPBSunOka7X923tMH+Z0ddNwesFUAzKD6BRMRf
	mv6a9NAKcOQkr7aP8qMUmtZFkKny58h4hJwsghiAJPDTVmGImDLEsmHCU4Yiew+6UYY7XFlUwC/
	Uc+2kyHBPD6sbBi7wSWW7gNUqUB4TyTKFUH2raYq3VCKqnid5mEvTlKRbAAQ6MyzcGhudGXPwhl
	922ausx1JcWxuxgRFHzKQ0CGMbCzWESOh+IIgscVBWOa80h1EYejPt1CQBixSaBA4pZVlua+vMl
	4hZSbP/Y4PWiYQpkpFfZstH43Zr1BDwd7NL40+bmmVaJgfiggu98SafikcoyiSJWvp1ndTN9U=
X-Received: by 2002:a05:7022:12b:b0:137:dbbf:db2c with SMTP id a92af1059eb24-13807bfbad7mr235639c88.5.1780784125379;
        Sat, 06 Jun 2026 15:15:25 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df75ff6sm12469930eec.26.2026.06.06.15.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 15:15:24 -0700 (PDT)
Date: Sat, 6 Jun 2026 22:15:15 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 06/12] PCI: liveupdate: Auto-preserve upstream bridges
 across Live Update
Message-ID: <aiSb85Ec6jW4xPaE@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-7-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-7-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260606_151527_260463_D24171CB 
X-CRM114-Status: GOOD (  23.59  )
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

On Fri, May 22, 2026 at 08:24:04PM +0000, David Matlack wrote:
> When a PCI device is preserved across a Live Update, all of its upstream
> bridges up to the root port must also be preserved. This enables the PCI
> core and any drivers bound to the bridges to manage bridges correctly
> across a Live Update.
> 
> Notably, this will be used in subsequent commits to ensure that
> preserved devices can continue performing memory transactions without a
> disruption or change in routing.
> 
> To preserve bridges, the PCI core tracks the number of downstream
> devices preserved under each bridge using a reference count in struct
> pci_dev_ser. This allows a bridge to remain preserved until all its
> downstream preserved devices are unpreserved or finish their
> participation in the Live Update.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/liveupdate.c    | 136 +++++++++++++++++++++++++++++++-----
>  include/linux/kho/abi/pci.h |   5 +-
>  2 files changed, 122 insertions(+), 19 deletions(-)
> 

[...]

> +
> +#define for_each_pci_dev_in_path(_d, _start, _end) \
> +	for ((_d) = (_start); (_d) != (_end); (_d) = (_d)->bus->self)
> +
> +static void __pci_liveupdate_unpreserve_path(struct pci_ser *ser,
> +					     struct pci_dev *start,
> +					     struct pci_dev *end)
> +{
> +	struct pci_dev *dev;
> +
> +	for_each_pci_dev_in_path(dev, start, end) {
> +		if (pci_liveupdate_unpreserve_device(ser, dev))

I might be reading this wrong but are we leaking some upstream devs if 
an intermediate node fails?

			  EP0
			/
Assume we have: RC -> B1 -> B2 
				\
				 EP1

and EP0 & EP1 were preserved successfully.

And then we try unpreserving EP1, we follow:

unpreserve EP1 -> unpreserve B2 failed due to a corruption.

This aborts the loop, skipping B1 and RC completely?
Their refcounts remain elevated, effectively leaking them as preserved 
state permanently? (i.e. if we unpreserve EP0 after this, B1 & RC will
still get preserved).

> +			return;
> +	}
> +}
> +
> +static void pci_liveupdate_unpreserve_path(struct pci_ser *ser,
> +					   struct pci_dev *start)
> +{
> +	__pci_liveupdate_unpreserve_path(ser, start, /*end=*/NULL);
> +}
> +
> +static int pci_liveupdate_preserve_path(struct pci_ser *ser,
> +					struct pci_dev *start)
> +{
> +	struct pci_dev *dev;
> +	int ret;
> +
> +	for_each_pci_dev_in_path(dev, start, NULL) {
> +		ret = pci_liveupdate_preserve_device(ser, dev);
> +		if (ret) {
> +			__pci_liveupdate_unpreserve_path(ser, start, dev);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * pci_liveupdate_preserve() - Preserve a PCI device across Live Update
>   * @dev: The PCI device to preserve.
> @@ -321,6 +403,9 @@ static int pci_liveupdate_preserve_device(struct pci_ser *ser, struct pci_dev *d
>   * pci_liveupdate_preserve() from their struct liveupdate_file_handler
>   * preserve() callback to ensure the outgoing struct pci_ser is already set up.
>   *
> + * pci_liveupdate_preserve() automatically preserves all bridges upstream of
> + * @dev.
> + *
>   * Returns: 0 on success, <0 on failure.
>   */
>  int pci_liveupdate_preserve(struct pci_dev *dev)
> @@ -336,7 +421,7 @@ int pci_liveupdate_preserve(struct pci_dev *dev)
>  	if (IS_ERR(ser))
>  		return PTR_ERR(ser);
>  
> -	return pci_liveupdate_preserve_device(ser, dev);
> +	return pci_liveupdate_preserve_path(ser, dev);

Minor nit: I might be too nitpicky here (and it's NOT a strong opinion)
but naming it pci_liveupdate_preserve_path_for_dev() reads better to me.

>  }
>  EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
>  

[...]

Thanks,
Praan

