Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B544AC982C1
	for <kexec@archiver.kernel.org>; Thu, 17 Sep 2026 00:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=+yFcjzj37ujFduHmXiBvfG9JBS833j3YXgLJ04CFxHE=; b=MWlVIaH2okOQi5
	O59Z3mQX2W5yRaLHJJYklWnB/HvxLjlLyYd69ppEkE5UICLBHq37P/zk5qs+c7f8EgoZa3s+LroS4
	iNaWQ21mDTphhJOQGSaDSajzAOmxh1yHpnV52MEvK5M+XuBFflmAJ//pk9neQ/c+tp1Bn2UY9jfYu
	hjlFXQ2IpoaDkCt/rQk5Nhf0cIlOcmQUiHljNM4bAefgXNvZfQHmz+FlgCUIecdgrr3rto1/eJwll
	xxaajpNecptYt44uL5EFqf0XC1BdNbaRLFWvnPEYVUYaUf+GcShvz7NDs/+bD3scRTDjwHTYhBM7r
	T7jgNVTFylfBOlnc6R/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6zex-0000000AJEn-1KAD;
	Thu, 17 Sep 2026 00:07:27 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6zew-0000000AJE3-0S7N
	for kexec@lists.infradead.org;
	Thu, 17 Sep 2026 00:07:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1BB6E601EF;
	Thu, 17 Sep 2026 00:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5DF1F000FF;
	Thu, 17 Sep 2026 00:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789603644;
	bh=+yFcjzj37ujFduHmXiBvfG9JBS833j3YXgLJ04CFxHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=UjbTsEtVaPtsiaZUuZNq+T2sPIquKhVFlF6WCE1Nit+LYL5byUhUnUswsWKHVH8wK
	 7qMsN9mQuJsHdDVnrFzUsqc9srPE2TyNRfy5sfQGHZd2IhIXBj2X/t95jvsRKjbxes
	 lW4C1s7A5Nc0siyJhxlMktOEclBcFv0GC8ZCkpoYvvrYb+6YZUqa5gzAF92LNEhiWG
	 fbkCpan3pHHSqNMPeNzv/+c7N/vuVGzf8tIrVMWvAFsKjZw1wSbvxtDjUqQoHSjPIh
	 af2nNUqh3M0izEpdLd5+JAe9EJ8BchGBTY8vR4TP4CD1d2d1+4+nNv6FNem2o7XMVr
	 6IuBrI0whhNvw==
Date: Wed, 16 Sep 2026 19:07:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
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
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 06/12] PCI: liveupdate: Auto-preserve upstream bridges
 across Live Update
Message-ID: <20260917000723.GA992337@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-7-dmatlack@google.com>
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

On Tue, Jul 28, 2026 at 10:10:00PM +0000, David Matlack wrote:
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
> ...

> +static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
> +					    struct pci_dev *dev)
>  {
>  	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
>  
>  	if (!dev_ser) {
>  		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
> -		return;
> +		return -EINVAL;
> +	}
> +
> +	if (!dev_ser->refcount) {
> +		pci_WARN(dev, 1, "Preserved device has a 0 refcount!\n");
> +		return -EINVAL;
>  	}
>  
> +	if (--dev_ser->refcount)
> +		return 0;

I guess this is a nit: I was looking for a dev_ser->refcount++ in this
patch to correspond with this decrement.  I *guess* the
"dev_ser->refcount = 1" in pci_liveupdate_preserve_device() starts
that, and the "dev->liveupdate.outgoing->refcount++" there is an
increment of the same refcount?  The connections there don't seem
quite obvious to me.

But I guess "dev_ser->refcount = 1" was added by a different patch, so
probably *not* the same?

>  	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
>  	outgoing->ser->nr_devices--;
>  	memset(dev_ser, 0, sizeof(*dev_ser));
>  	dev->liveupdate.outgoing = NULL;
> +	return 0;
> +}

> @@ -385,13 +418,23 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
>  	}
>  
>  	if (dev->liveupdate.outgoing) {
> -		pci_warn(dev, "Device is already preserved\n");
> -		return -EBUSY;
> -	}
> +		if (!dev->liveupdate.outgoing->refcount) {
> +			pci_WARN(dev, 1, "Preserved device with 0 refcount!\n");
> +			return -EINVAL;
> +		}
>  
> -	if (!pci_is_root_bus(dev->bus)) {
> -		pci_warn(dev, "Cannot preserve devices behind bridges\n");
> -		return -EINVAL;
> +		/*
> +		 * Endpoint devices should not be preserved more than once.
> +		 * Bridges are preserved once for every downstream device that
> +		 * is preserved.
> +		 */
> +		if (!dev->subordinate) {
> +			pci_warn(dev, "Device is already preserved\n");
> +			return -EBUSY;
> +		}
> +
> +		dev->liveupdate.outgoing->refcount++;
> +		return 0;
>  	}
>  
>  	dev_ser = pci_flb_alloc_dev_ser(outgoing);

