Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77869CD8C90
	for <kexec@archiver.kernel.org>; Sat,  6 Jun 2026 10:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0IAXiSA/ZV+jth47JKvQthC0sv+FXjXrt59JcT36/1Y=; b=M0biY1Qd6h3RB5rWC9OZrSAiY9
	2XAbneUh4nfssU0rgVH+u/I/bkgzEazTdgokNROGejuLtHNBqxobwYjVtb4DC58koueEI+ID41+38
	VyDYqXcOVk7ZtVdVzdc3ZaBI18z+2cZbAIaN9uveHreK1vNgw/xwHTeQEHMo5Mk7oF8J7GUUQOM+t
	Q739Ka617e93mtOzejxhVdjZu7DlyGssdDypH5rjuCBhfI9ChpzioDZMqwzPrNmPfgPhDWt2lVIhG
	JxZ9jDUsWhVm/FTgK4Xsp+GOxlVd9XyRNwpxaXRe9dRaQu0Z09l8Liy4x5fp41ULloeUEGv3DUjVq
	+PRurGYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVnxQ-00000001YEn-1Q64;
	Sat, 06 Jun 2026 10:08:48 +0000
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVnxK-00000001YEM-1xUO
	for kexec@lists.infradead.org;
	Sat, 06 Jun 2026 10:08:44 +0000
Received: by mail-dl1-x1234.google.com with SMTP id a92af1059eb24-1380104f31eso16511c88.0
        for <kexec@lists.infradead.org>; Sat, 06 Jun 2026 03:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780740520; x=1781345320; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0IAXiSA/ZV+jth47JKvQthC0sv+FXjXrt59JcT36/1Y=;
        b=keCqLDvae47OVtryI9f93SGF011FydZYQQtZupdBysZnYOEqm1Stf/+KHJWaGSY7yP
         XOTerXWhqoNvnzXbWeTZjdbhsqK94aCxfNeVeWS1dDzTcx9jqTXtqR04lNYTwwsGEAul
         Cb4/dbKmS89w/4l/W4g5Ks/8yTgyqny/o1zWBMstUy0XtFLBuWqdukChOoI4TEOGE9fU
         S4R4pIvvSnLgiSoAOtWDNLHxvw7j3oEFRmbU4qGGyqcYLy45GCrlPIe5MHSTVzgp3S0K
         BiAOK9hJBar3voTAnbIW/PSigL++X9qlB6zdHrsG/WQGUQeC7wqXlbV8SHZvmZxWVmVd
         n+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780740520; x=1781345320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IAXiSA/ZV+jth47JKvQthC0sv+FXjXrt59JcT36/1Y=;
        b=klY2XLBxwwydR4ndcoL7tikkLryJd3qGXGId4lXJ27H5VV6NJg679ET0z3I8X62MVz
         TQ3yoRMD1NcArsih2oASIngddvlUaqthq9x7kVqkELlTQ39QuaZOIJXsE2Pw6U8DtslU
         MX5Afr7ckXbmj4EwXA8TXHMCwQtN5BRBoczMcRwwzKkQaEjuWgyvPQ9UHc4+hdkW+5wj
         +ui0UcMrF3L9oyX7ssT8df6igs/o/aUXnk1Liy0juNFZvgqmfN1hP5M9WJ2D6GT6awZW
         F7yWLVFvwM1Bq4MH/ibv6UZtAuXgX3UeQRkBTvMK30dF4O4Zu97CedRv08eYx0cLQODt
         6k6Q==
X-Gm-Message-State: AOJu0YzGt/uTubaIjCiXUZJOYu3YnvWoEsiqafMYGkq2y1GnjHnccZWV
	iBmy60QmkjEQopMTyuwTn9+TrIyBkrhQo632fAicp6Tp9NxlhMDFOx4tIusRF0ouxg==
X-Gm-Gg: Acq92OGIm2L+qxedml3k+v7l3nwg32PUEveQsnDokrC6FmFuhMyRnqIpmGEkBKLTw8v
	vuxNvV51wuYV61gGIek4lyGKnW/ZSitw4+4hXhOtiEcLMcNDJuKFmBG8XPKpPbQ/dInjt7zmv2Y
	zNec3JRAqCwUNb4tvJVghT7y3jr93B1zGRfroXLAINF9Lje6dsV0Nr89eWmK+o9nomQunD3qIr7
	nxHZtWOfFG02ZPcocOHfE/DtrrUG6fAw9wyvNU/cPJkEwTkbdyW2PEXvXDu/xAW5BbJElBhrftI
	jOJQDgLlCRTdgKdrVNZ0453tFxZx/+hIm1R6fiAX8mNL+8C5J1EWpjLMYeTpatQQtW4MulQJjfO
	B7l9oUmTEpuY/oH0iK7EEcgoLqKHNfNtryeGVOWbOqPZC4fK6xaZwc+E8cYOAOCfKDrDuXlNdK7
	M7JZM90a0+iDAQ+9kfmT5mDMSRtxyQS2IUt+1jnq40h+NuFeEoVhiLhRT2ZkF8pjlEDQUCSpg=
X-Received: by 2002:a05:7022:672a:b0:136:799c:bd1 with SMTP id a92af1059eb24-13807c512edmr207588c88.10.1780740519572;
        Sat, 06 Jun 2026 03:08:39 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db528dcsm12388863eec.3.2026.06.06.03.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 03:08:38 -0700 (PDT)
Date: Sat, 6 Jun 2026 10:08:28 +0000
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
Subject: Re: [PATCH v6 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <aiPxVxu2sUVQfG9D@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-4-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-4-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260606_030842_556996_9DA1933B 
X-CRM114-Status: GOOD (  37.80  )
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

On Fri, May 22, 2026 at 08:24:01PM +0000, David Matlack wrote:
> During PCI enumeration, the previous kernel might have passed state about
> devices that were preserved across kexec. The PCI core needs to fetch
> this state to identify which devices are "incoming" and require special
> handling.
> 
> Add pci_liveupdate_setup_device() which is called during device setup
> to fetch the serialized state (struct pci_ser) from the Live Update
> Orchestrator. The first time this happens, pci_flb_retrieve() will run
> and convert the array of pci_dev_ser structs into an xarray so that it
> can be looked up efficiently.
> 
> If a device is found in the xarray, the PCI core stores a pointer to its
> state in dev->liveupdate_incoming and holds a reference to the incoming
> FLB until pci_liveupdate_finish() is called by the driver.
> 
> This ensures proper lifecycle management for incoming preserved devices
> and allows the PCI core and drivers to apply specific Live Update
> logic to them in subsequent commits.
> 
> Drivers can check if a device is an incoming preserved device (e.g.
> during probe) by calling pci_liveupdate_is_incoming().
> 
> CONFIG_64BIT is now required to enable CONFIG_PCI_LIVEUPDATE so that the
> domain and bdf can be guaranteed to fit in an unsigned long and be used
> as the xarray key.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  MAINTAINERS                    |   1 +
>  drivers/pci/Kconfig            |   2 +-
>  drivers/pci/liveupdate.c       | 230 ++++++++++++++++++++++++++++++++-
>  drivers/pci/liveupdate.h       |   5 +
>  drivers/pci/probe.c            |   3 +
>  include/linux/pci_liveupdate.h |  13 ++
>  6 files changed, 251 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6c618830cf61..0e262c0ceb43 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20537,6 +20537,7 @@ L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
>  F:	drivers/pci/liveupdate.c
> +F:	drivers/pci/liveupdate.h
>  F:	include/linux/kho/abi/pci.h
>  F:	include/linux/pci_liveupdate.h
>  
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 10c9b65aa242..e68ae5c172d4 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -330,7 +330,7 @@ config VGA_ARB_MAX_GPUS
>  
>  config PCI_LIVEUPDATE
>  	bool "PCI Live Update Support"
> -	depends on PCI && LIVEUPDATE
> +	depends on PCI && LIVEUPDATE && 64BIT

I see that the static assertions in Patch 1 work because of the 64BIT
enforcement here. In that case, should we have the assertions check u64?

>  	help
>  	  Enable PCI core support for preserving PCI devices across Live
>  	  Update. This, in combination with support in a device's driver,
>

[...]

>  static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
>  {
> -	args->obj = phys_to_virt(args->data);
> +	struct pci_ser *ser = phys_to_virt(args->data);
> +	struct pci_flb_incoming *incoming;
> +	int ret = -ENOMEM;
> +	u32 i;
> +
> +	incoming = kmalloc_obj(*incoming);
> +	if (!incoming)
> +		goto err_restore_free;
> +
> +	incoming->ser = ser;
> +	xa_init(&incoming->xa);
> +
> +	for (i = 0; i < incoming->ser->max_nr_devices; i++) {
> +		struct pci_dev_ser *dev_ser = &incoming->ser->devices[i];
> +		unsigned long key;
> +
> +		if (!dev_ser->refcount)
> +			continue;
> +
> +		key = pci_ser_xa_key(dev_ser->domain, dev_ser->bdf);
> +		ret = xa_insert(&incoming->xa, key, dev_ser, GFP_KERNEL);
> +		if (ret)
> +			goto err_xa_destroy;
> +	}
> +
> +	args->obj = incoming;
>  	return 0;
> +
> +err_xa_destroy:
> +	xa_destroy(&incoming->xa);
> +	kfree(incoming);
> +err_restore_free:
> +	kho_restore_free(ser);

I tend to partly agree with Sashiko[1] here.. it raises a policy-hole.
We may need a policy here, the options I have in mind are:

1. Retrieve shall ONLY be tried once, if it fails (like -ENOMEM in the
   xArray alloc), it's a liveupdate failure. We can't retry liveupdate.

2. Retrying retrieve is allowed.

The only downside with option 1 is, the user may want flexibility due to
certain subsystems OR may choose NOT to use the proposed LUOd and instead
have its own user-space component which might try funny things or have a
different use-case.

In such a situation, the system may have transiently run out of memory
during the kexec transition (for e.g. a subsystem uses GFP_ATOMIC to
allocate memory and temporarily runs out of the atomic pool). [Note we
removed it in IOMMU v1 [2] but subsystems may have a use-case for it]

If the kernel frees the KHO page on the first failure, it removes any
chance of recovery. :/

Thus, it might make sense to let the user decide if it wants to fail the
liveupdate or retry again based on the failure type / source?

[...]

The changes LGTM, except for policy-based, kho_restore_free discussion.

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

[1] https://lore.kernel.org/all/20260522211333.D56A21F000E9@smtp.kernel.org/
[2] https://lore.kernel.org/all/20260203220948.2176157-2-skhawaja@google.com/

