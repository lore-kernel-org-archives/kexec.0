Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84704CD8CA4
	for <kexec@archiver.kernel.org>; Mon,  8 Jun 2026 20:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KwWXYyLBedswXBpDr6XhVLr7hKW6gX2W2Wf9GCvWRA8=; b=Xak2IQTToaqWzmRccFgAgz4Ju7
	DcZjv03Pn8364RkfEXVPa5T400vAzJ8Czw0gukB9u9hCHEr71H37kTnHDU5JN+0HvStTbyVSvfno8
	BV0w44fn8/AkA+0Mrw+7x3Wk+lfe9MHOgHDWpVsTFAo8z/piWboO5ZNKSNLUltlzBCuwuRqPO4reK
	6gqfcKH8jX1PFEDB4dkNSbxNEgsUCcHSmGz9MdCYD74TCq0D0LpquCLmLQJQ+cc9xdBhHAgABb0Wp
	fe3c0eBjN1VHd6Jazi2N24w8nyZs75p5qAYRusqe7vyXsoFB3QRQDkoIhNZ0+rDGt8UhyTNvIj/+E
	CqjntrZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWh2f-00000004P4Z-3Kuc;
	Mon, 08 Jun 2026 20:57:53 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWh2d-00000004P4D-1CpD
	for kexec@lists.infradead.org;
	Mon, 08 Jun 2026 20:57:52 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2bf20f6be6bso36807515ad.3
        for <kexec@lists.infradead.org>; Mon, 08 Jun 2026 13:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780952270; x=1781557070; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KwWXYyLBedswXBpDr6XhVLr7hKW6gX2W2Wf9GCvWRA8=;
        b=v4R7IaVp4LClRBukjFqjpKNy0lsnysFJ3cheaKL1X9DFyQMRpV95jv1Mo11thzwCkl
         QLgRC70K0YA9is8d71IloVkHao/RQrE2L8IdKvZNem8WWfiDtnQpNlQH0+1A6Ry/gTh/
         HzOsfSBZNWXTESXC39HHqWmM75xsCamOd3PGcDlUvet68scss8Uq42FyIUy3c4rh05Nk
         UBoVPTZe/yyznFO0f+714ZZdXbgJ7Mhr8T05wcuemHl/EZ2fdeYWOCzxuyyihBispspu
         rzeBnUc+XY1DFeBohqKneEjBR6DFNZ+EIJPRPeJ0aCH59HpSxZki9V3DewV13C+zHG7L
         curA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780952270; x=1781557070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwWXYyLBedswXBpDr6XhVLr7hKW6gX2W2Wf9GCvWRA8=;
        b=mIeiClVB3oYspzLlZlKy+Q1+ucW2VPLSiKL8mS27K9U229d6NCZ18b3QNcjULFCBGd
         Gp9jn0nIW/DAKg3nSfQg/fy69i/OX16nxGjEDKVMcfbAvAtu9OdVO5limBIyQHhzED0N
         vm9hlr23xrG0CjxhDfie32evT54nbvompZ3T2LAZ/r0jh3xhnqD4Gm9UhljpYrb81cak
         YumHGPqkpuW6lYlsqmwptzGNiqH1+k3tEV5bzf6VB6+Js5h0gNSv2bJ0EA+S1EYfU3ny
         Ac77tmxTIiWm7+/pXhJoFgUFRUa1OwY1lACnNNr0dvv5mzx6YyN6IDn64KHg7ihMNMs6
         sdLA==
X-Gm-Message-State: AOJu0Yw421KkHaFyGbZA6q2u0vVsW5BO5b4NpUex/qfo8kdFIPHf7TPt
	yzGDzG5ZT8yZkTZz+c6mm+G9HWK63zY0NTwQYOfYeYNstVP0XVqBvukHvJhcq8lCxg==
X-Gm-Gg: Acq92OGb7j/2FWnfdEf6HPzggZFnrLAfELm/PuG44EiIT5ngG2HgLZdfbo6djW6LROt
	U9b7bys/UB82/d9ACSrekTgX1Mli35yRB1B+aBTAI9lgYcGJL6LRsHZ6pasFXid0Yp/1/fMqWmj
	/qL31g5e6TPgLJTkR7R0DMsbf85aipSHIp3x+EgwE/NdmkvsakH/ht5VTJ8a0tpFRStI914YmJq
	oU27Ef+nHSCdtK/6Q2C7WALOQBts5YmDdPBCCzVYsi0IBsl/0eHpT5mpGz8w1U1Z88yFWADp9FA
	9rSz1KzPPmvG4WY+OoFFxB1Awa/ITWloIw/KDfb/lzxpbdHaMfCoxa1xJmWAAzJL1VSErIkH6LE
	kzbyxW5Bbh+GKsQRGZtNRO3oeJ1D7d90Kc352O7r4ph+cPNi5pPQO3mxWB5G1Qal4x8PhDRNKU/
	vv2p1MadToC9dSZ3uaLdB80oQ0cAno1cCEqIdp3gW650LLVqbkN10uZPqpj3K++o6vY2Ho3ujw
X-Received: by 2002:a17:902:6ac7:b0:2bf:bd17:90d4 with SMTP id d9443c01a7336-2c1e820b41fmr143853655ad.28.1780952269772;
        Mon, 08 Jun 2026 13:57:49 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f890b2sm191929635ad.26.2026.06.08.13.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:57:49 -0700 (PDT)
Date: Mon, 8 Jun 2026 20:57:45 +0000
From: David Matlack <dmatlack@google.com>
To: Pranjal Shrivastava <praan@google.com>
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
Message-ID: <aicsyesGrqcWj7vu@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-4-dmatlack@google.com>
 <aiPxVxu2sUVQfG9D@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiPxVxu2sUVQfG9D@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_135751_335741_8951F829 
X-CRM114-Status: GOOD (  48.03  )
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

On 2026-06-06 10:08 AM, Pranjal Shrivastava wrote:
> On Fri, May 22, 2026 at 08:24:01PM +0000, David Matlack wrote:
> > During PCI enumeration, the previous kernel might have passed state about
> > devices that were preserved across kexec. The PCI core needs to fetch
> > this state to identify which devices are "incoming" and require special
> > handling.
> > 
> > Add pci_liveupdate_setup_device() which is called during device setup
> > to fetch the serialized state (struct pci_ser) from the Live Update
> > Orchestrator. The first time this happens, pci_flb_retrieve() will run
> > and convert the array of pci_dev_ser structs into an xarray so that it
> > can be looked up efficiently.
> > 
> > If a device is found in the xarray, the PCI core stores a pointer to its
> > state in dev->liveupdate_incoming and holds a reference to the incoming
> > FLB until pci_liveupdate_finish() is called by the driver.
> > 
> > This ensures proper lifecycle management for incoming preserved devices
> > and allows the PCI core and drivers to apply specific Live Update
> > logic to them in subsequent commits.
> > 
> > Drivers can check if a device is an incoming preserved device (e.g.
> > during probe) by calling pci_liveupdate_is_incoming().
> > 
> > CONFIG_64BIT is now required to enable CONFIG_PCI_LIVEUPDATE so that the
> > domain and bdf can be guaranteed to fit in an unsigned long and be used
> > as the xarray key.
> > 
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> >  MAINTAINERS                    |   1 +
> >  drivers/pci/Kconfig            |   2 +-
> >  drivers/pci/liveupdate.c       | 230 ++++++++++++++++++++++++++++++++-
> >  drivers/pci/liveupdate.h       |   5 +
> >  drivers/pci/probe.c            |   3 +
> >  include/linux/pci_liveupdate.h |  13 ++
> >  6 files changed, 251 insertions(+), 3 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6c618830cf61..0e262c0ceb43 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20537,6 +20537,7 @@ L:	linux-pci@vger.kernel.org
> >  S:	Maintained
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
> >  F:	drivers/pci/liveupdate.c
> > +F:	drivers/pci/liveupdate.h
> >  F:	include/linux/kho/abi/pci.h
> >  F:	include/linux/pci_liveupdate.h
> >  
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index 10c9b65aa242..e68ae5c172d4 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -330,7 +330,7 @@ config VGA_ARB_MAX_GPUS
> >  
> >  config PCI_LIVEUPDATE
> >  	bool "PCI Live Update Support"
> > -	depends on PCI && LIVEUPDATE
> > +	depends on PCI && LIVEUPDATE && 64BIT
> 
> I see that the static assertions in Patch 1 work because of the 64BIT
> enforcement here. In that case, should we have the assertions check u64?

The static asserts have nothing to do with the 64BIT enforcement here.
The static asserts just verify that the array elements in struct pci_ser
are naturally aligned (unsigned long) so they can be accessed
efficiently. The requirement here for CONFIG_64BIT is for the xarray
key.

Theoretically if we got the xarray to work with 32-bit architectures
then we could drop the CONFIG_64BIT requirement here.

> 
> >  	help
> >  	  Enable PCI core support for preserving PCI devices across Live
> >  	  Update. This, in combination with support in a device's driver,
> >
> 
> [...]
> 
> >  static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
> >  {
> > -	args->obj = phys_to_virt(args->data);
> > +	struct pci_ser *ser = phys_to_virt(args->data);
> > +	struct pci_flb_incoming *incoming;
> > +	int ret = -ENOMEM;
> > +	u32 i;
> > +
> > +	incoming = kmalloc_obj(*incoming);
> > +	if (!incoming)
> > +		goto err_restore_free;
> > +
> > +	incoming->ser = ser;
> > +	xa_init(&incoming->xa);
> > +
> > +	for (i = 0; i < incoming->ser->max_nr_devices; i++) {
> > +		struct pci_dev_ser *dev_ser = &incoming->ser->devices[i];
> > +		unsigned long key;
> > +
> > +		if (!dev_ser->refcount)
> > +			continue;
> > +
> > +		key = pci_ser_xa_key(dev_ser->domain, dev_ser->bdf);
> > +		ret = xa_insert(&incoming->xa, key, dev_ser, GFP_KERNEL);
> > +		if (ret)
> > +			goto err_xa_destroy;
> > +	}
> > +
> > +	args->obj = incoming;
> >  	return 0;
> > +
> > +err_xa_destroy:
> > +	xa_destroy(&incoming->xa);
> > +	kfree(incoming);
> > +err_restore_free:
> > +	kho_restore_free(ser);
> 
> I tend to partly agree with Sashiko[1] here.. it raises a policy-hole.
> We may need a policy here, the options I have in mind are:
> 
> 1. Retrieve shall ONLY be tried once, if it fails (like -ENOMEM in the
>    xArray alloc), it's a liveupdate failure. We can't retry liveupdate.
> 
> 2. Retrying retrieve is allowed.
> 
> The only downside with option 1 is, the user may want flexibility due to
> certain subsystems OR may choose NOT to use the proposed LUOd and instead
> have its own user-space component which might try funny things or have a
> different use-case.
> 
> In such a situation, the system may have transiently run out of memory
> during the kexec transition (for e.g. a subsystem uses GFP_ATOMIC to
> allocate memory and temporarily runs out of the atomic pool). [Note we
> removed it in IOMMU v1 [2] but subsystems may have a use-case for it]
> 
> If the kernel frees the KHO page on the first failure, it removes any
> chance of recovery. :/
> 
> Thus, it might make sense to let the user decide if it wants to fail the
> liveupdate or retry again based on the failure type / source?

The plan is to have LUO enforce that retrieve() is only called once:

  https://lore.kernel.org/kexec/20260528174140.1921129-3-dmatlack@google.com/

Supporting retry gets complicated since there's many different places
where retrieve() could have failed.

> 
> [...]
> 
> The changes LGTM, except for policy-based, kho_restore_free discussion.
> 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> 
> Thanks,
> Praan
> 
> [1] https://lore.kernel.org/all/20260522211333.D56A21F000E9@smtp.kernel.org/
> [2] https://lore.kernel.org/all/20260203220948.2176157-2-skhawaja@google.com/

