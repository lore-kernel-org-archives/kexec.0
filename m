Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701A3CD8CA8
	for <kexec@archiver.kernel.org>; Tue,  9 Jun 2026 10:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jLGghC6UIfVrvCdIhumzQTyhB1QR5R7Bsqly45dLP7M=; b=E4CPm3X+uRvoK89/sQDVdVyH4o
	rHF9haVJ1PTx3I6+oxUonKx+U6rfMb0w0F4C2xaemomDCglBImbePAGttxmmv+ejNfSbjZwxOm/aV
	hfkPyyaci8saXClXa39iYH4EwZ0Y/m5XOFNgxqZuOHqpS8oFoGzRYPQ/aOUqhN032J3BxtNmDx4IO
	vxajdFYjwEH0SNsB/WsI7hGa2TOc5ecVxqdlqYPiMsYWIMbMLkCjedsxFmxVF5MaCLaMFJTh5Dgmu
	tA0TMlgSv2xhSROMDfIlkrExS354+vLFuouOjDwSTkLNOn5+l8ola3cAp3Dr5XkK5s/Z/Xq/sAAYa
	YLB+zpzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWu0P-00000005OJ5-1kD2;
	Tue, 09 Jun 2026 10:48:25 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWu0N-00000005OId-27n5
	for kexec@lists.infradead.org;
	Tue, 09 Jun 2026 10:48:24 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2c0b1a48855so495785ad.0
        for <kexec@lists.infradead.org>; Tue, 09 Jun 2026 03:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781002102; x=1781606902; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jLGghC6UIfVrvCdIhumzQTyhB1QR5R7Bsqly45dLP7M=;
        b=qispf2X5J7yK5es+/vf06DdE3L4JDK2W4PhUqawtdVNazyFQmRa/n20TlZISiZRr0y
         4NqpunOVIWxpdkCZyNI266tmHX0sX7As5xeWYwKskK2FkS6dytRYpSxMh8m0dYicPIpH
         VvtibavYwYXrMvIC/67UIiuP/XEiFYEhyj5P3G+KNVtgtUh2CcA7uUPTZYkJKOUwhcMN
         cI0ZlNiQEPW0uNaev+CT2Bjnr3Ut6/fXNBlu1AeddRg2VYEcKU9OYN3UOA4L6pXO111W
         mG7wqn8ovkIS5bZ4sKyRqBDPXnWvYeReNxqgUy7iSdrqW3Eb02aurp/GAjQHjFoBhlMA
         1WXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781002102; x=1781606902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLGghC6UIfVrvCdIhumzQTyhB1QR5R7Bsqly45dLP7M=;
        b=dpua0TFiNaQMNacJH3ZDUluG89J0rVSXJ9ELfxMDaf7/XTGr08FPqsYeA1hFi0ao54
         Dzk/50HV1wT2KukkXyz3D9daezqQwHfD+D5TDWpPGgXNC8zpN9jxxxN7MQBZ1wposBX1
         KrBSY3eYOuxyq5wraL+ddudeAz05y0ti0S6sR7GORpZiO9Zk+FHPaoT9pbY8giDYna7s
         eRk2ftoc+zvwkP/jWnwzL5aDeT4XAkbxw4/asuACcHjrcJZSb1F/EV6d52GYjkYL1NdP
         fvY4L26imhS6v2yTadBDmrKbDc+cbVysP3PlF4sbgZLpOMgRIGcTaIPszC4X9X0XlEQu
         2LBw==
X-Gm-Message-State: AOJu0YwEqxObOsACnSHC0i4Ri9q9SbQU8nMXIeqqcMY8RWm0QKvU0FwC
	Ied0Mr+GNnamjkVIwJivmQGXav9N8aUAhqN/8HXhOO41fwOatuea1frnZMKayMkfXQ==
X-Gm-Gg: Acq92OHCzxg31Uo/NPj58Vk9RgdY35qmQDfeLcU1c7qppuggrs+cz9enyAm9XDn1i4S
	W1agZETeALBnTFL+7Sg7DZo4Rjm3je5xhMulu4Ln+OYPFjkEo+zI240zVUbx2QbF9md7ZDnGkrg
	2+OVQ/9N/LZDfCQfs0El7S/bn4/mBevE8sqZ3ML6iCbPjwo3CwHq6cpSutgpYyBB2La8Wb8vQfE
	tuNEFj7ggshSL8M9ZAuiVuxtJzvhTgERHKe++WnpF9g3QhizRISsgXVxYDRePzXd+9TENu4DxRA
	yT78sWcE7A79fvUbDuj49w20+S4WjjCPOZJPyGDaDDmLdSkiUK+NBjft2qiawj11/SMR+HjArXj
	xIQBsFaL5P8bHCXUJ2Wr9wM8YSbFiNgajoPpLVnz/v81l0SwPrUu5Xl8p0hFwgx56WMmj2/mIJ2
	g2g7EVGiAFSJSK3RJ7FMSYV89Rd1ztgMuwu7q7rU7JoIivzQFMngpzqlLWC1GARV12oAOh0Iw=
X-Received: by 2002:a17:903:1a6f:b0:2b0:b0c9:96e2 with SMTP id d9443c01a7336-2c1ec0deac6mr7312765ad.21.1781002102069;
        Tue, 09 Jun 2026 03:48:22 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282372502sm22347071b3a.16.2026.06.09.03.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:48:21 -0700 (PDT)
Date: Tue, 9 Jun 2026 10:48:12 +0000
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
Message-ID: <aifvbD9ZoVOsgCrD@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-4-dmatlack@google.com>
 <aiPxVxu2sUVQfG9D@google.com>
 <aicsyesGrqcWj7vu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aicsyesGrqcWj7vu@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_034823_565845_C817AE3B 
X-CRM114-Status: GOOD (  46.42  )
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

On Mon, Jun 08, 2026 at 08:57:45PM +0000, David Matlack wrote:
> On 2026-06-06 10:08 AM, Pranjal Shrivastava wrote:
> > On Fri, May 22, 2026 at 08:24:01PM +0000, David Matlack wrote:
> > > During PCI enumeration, the previous kernel might have passed state about
> > > devices that were preserved across kexec. The PCI core needs to fetch
> > > this state to identify which devices are "incoming" and require special
> > > handling.
> > > 
> > > Add pci_liveupdate_setup_device() which is called during device setup
> > > to fetch the serialized state (struct pci_ser) from the Live Update
> > > Orchestrator. The first time this happens, pci_flb_retrieve() will run
> > > and convert the array of pci_dev_ser structs into an xarray so that it
> > > can be looked up efficiently.
> > > 
> > > If a device is found in the xarray, the PCI core stores a pointer to its
> > > state in dev->liveupdate_incoming and holds a reference to the incoming
> > > FLB until pci_liveupdate_finish() is called by the driver.
> > > 
> > > This ensures proper lifecycle management for incoming preserved devices
> > > and allows the PCI core and drivers to apply specific Live Update
> > > logic to them in subsequent commits.
> > > 
> > > Drivers can check if a device is an incoming preserved device (e.g.
> > > during probe) by calling pci_liveupdate_is_incoming().
> > > 
> > > CONFIG_64BIT is now required to enable CONFIG_PCI_LIVEUPDATE so that the
> > > domain and bdf can be guaranteed to fit in an unsigned long and be used
> > > as the xarray key.
> > > 
> > > Signed-off-by: David Matlack <dmatlack@google.com>
> > > ---
> > >  MAINTAINERS                    |   1 +
> > >  drivers/pci/Kconfig            |   2 +-
> > >  drivers/pci/liveupdate.c       | 230 ++++++++++++++++++++++++++++++++-
> > >  drivers/pci/liveupdate.h       |   5 +
> > >  drivers/pci/probe.c            |   3 +
> > >  include/linux/pci_liveupdate.h |  13 ++
> > >  6 files changed, 251 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 6c618830cf61..0e262c0ceb43 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -20537,6 +20537,7 @@ L:	linux-pci@vger.kernel.org
> > >  S:	Maintained
> > >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
> > >  F:	drivers/pci/liveupdate.c
> > > +F:	drivers/pci/liveupdate.h
> > >  F:	include/linux/kho/abi/pci.h
> > >  F:	include/linux/pci_liveupdate.h
> > >  
> > > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > > index 10c9b65aa242..e68ae5c172d4 100644
> > > --- a/drivers/pci/Kconfig
> > > +++ b/drivers/pci/Kconfig
> > > @@ -330,7 +330,7 @@ config VGA_ARB_MAX_GPUS
> > >  
> > >  config PCI_LIVEUPDATE
> > >  	bool "PCI Live Update Support"
> > > -	depends on PCI && LIVEUPDATE
> > > +	depends on PCI && LIVEUPDATE && 64BIT
> > 
> > I see that the static assertions in Patch 1 work because of the 64BIT
> > enforcement here. In that case, should we have the assertions check u64?
> 
> The static asserts have nothing to do with the 64BIT enforcement here.
> The static asserts just verify that the array elements in struct pci_ser
> are naturally aligned (unsigned long) so they can be accessed
> efficiently. The requirement here for CONFIG_64BIT is for the xarray
> key.
> 
> Theoretically if we got the xarray to work with 32-bit architectures
> then we could drop the CONFIG_64BIT requirement here.
> 

Ack. I see.

[...]
> > > +	kho_restore_free(ser);
> > 
> > I tend to partly agree with Sashiko[1] here.. it raises a policy-hole.
> > We may need a policy here, the options I have in mind are:
> > 
> > 1. Retrieve shall ONLY be tried once, if it fails (like -ENOMEM in the
> >    xArray alloc), it's a liveupdate failure. We can't retry liveupdate.
> > 
> > 2. Retrying retrieve is allowed.
> > 
> > The only downside with option 1 is, the user may want flexibility due to
> > certain subsystems OR may choose NOT to use the proposed LUOd and instead
> > have its own user-space component which might try funny things or have a
> > different use-case.
> > 
> > In such a situation, the system may have transiently run out of memory
> > during the kexec transition (for e.g. a subsystem uses GFP_ATOMIC to
> > allocate memory and temporarily runs out of the atomic pool). [Note we
> > removed it in IOMMU v1 [2] but subsystems may have a use-case for it]
> > 
> > If the kernel frees the KHO page on the first failure, it removes any
> > chance of recovery. :/
> > 
> > Thus, it might make sense to let the user decide if it wants to fail the
> > liveupdate or retry again based on the failure type / source?
> 
> The plan is to have LUO enforce that retrieve() is only called once:
> 
>   https://lore.kernel.org/kexec/20260528174140.1921129-3-dmatlack@google.com/
> 
> Supporting retry gets complicated since there's many different places
> where retrieve() could have failed.

Ack. Thanks for pointing me to the thread.
In that case, no problem.

Thanks,
Praan

