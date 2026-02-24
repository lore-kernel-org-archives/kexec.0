Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B08F4BB79
	for <kexec@archiver.kernel.org>; Tue, 24 Feb 2026 19:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X93b96xDCWqbNSn/Osk0k6D0QiHzoDXCBhSgmB8C344=; b=q8rNkckTFFtbOkwA0qgpjJsBkF
	bcJgtULJHE6hr0JfUqS/yoChWwm4wVpD44ExLHAPGHM9VUtdEfbWJsDRm/mgl1N6Z5YCpD40cS5vT
	RwsKAGeHCk2rkLFYCnZM6a+88adIckkjTPT0qAolkkAkt5BUZYwwjITdwfZ8m0lMsaFwXzRE9f88Q
	6uPqh4n3ql0XVsO59+RyFl7kJMh9pwa+6Z1JHiBnAGeAcNECR7RigkENwpFqWKAecPmn8yTZ554/4
	xLad36EFjG8on6lsbmaJsCeRE7w8/mlVWtLjkYXoaeZ/IZoWpYiWWEhVLNyQxGyqn23HKKCOzFiqX
	ceggVdUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuxge-00000002fQy-2oNL;
	Tue, 24 Feb 2026 19:03:12 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuxgb-00000002fQd-1Zri
	for kexec@lists.infradead.org;
	Tue, 24 Feb 2026 19:03:10 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2aad8123335so10105ad.1
        for <kexec@lists.infradead.org>; Tue, 24 Feb 2026 11:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771959788; x=1772564588; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X93b96xDCWqbNSn/Osk0k6D0QiHzoDXCBhSgmB8C344=;
        b=Z//2NkpdcM1D6stn045x2EumNGKNiF9KY6PE86gLKuCX6r2rR7p43PXGkYCJv6Sk4c
         5zFMuEa4j4+zKMyyIi13Njci8n017gkOb9VK8hdZGVi1u8YF3G/vbc5JgkK8dx1zLNE4
         9xtjtCD9O0Bh9u7Ab0uuEd78W8hjtk2QGYr/e9AcDvqXLN0TDSxU4jeSuiOhlRrVtsOo
         5UBy27w2Ss+vAOmSrpVvtHGDIIkkz3b5t9aXWwqRd1bMnymZJOGbtQRXIovKBVLToBSF
         AmYWwT39+lMmzIl71pIgGwNWXfjWmHak4zYH/tkU8y2GMSMe/9YoSogAHjXR/qqbqOg+
         ycZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959788; x=1772564588;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X93b96xDCWqbNSn/Osk0k6D0QiHzoDXCBhSgmB8C344=;
        b=cT05xxT6t31EDnpU40J8dlXobMMiMqkHMd4Iv7WsM+ntF/eMvAhiRKl9IBXAv273Zh
         6TsWRHe4MDziVqFj5h7ACRxOTQHVHjVaXTlr6tKV60Lj4z5oayMCAh+UhbWeDyErrKiK
         bSz8D6QR5CyaoOYeOL6ClbDPUUXl+qVd8O/thzaBUbF2edrbG5RtXkyt3veNqNj7OEbG
         R60y45KGBnKUij7X9YTRgyPlVv/JPPV1B/N2CQziHh4EWYEGhxIPq+gn1DRDs00rs5Oq
         hNsQ/q7hEVAXmht+wlov8hJ3Zd37xPAAmpMQei2CoTX/IDwfTnAk6cbx3Y3RNeoIusHv
         6p6w==
X-Forwarded-Encrypted: i=1; AJvYcCVh49RvxBXsNyKn3ivZCY/IO84M01pzg2xQQZl3E+KCnJRpAhU1U3o88iNszdJ89/M4wCCeMQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyEXXaAZQ6wbW94xAwjdULRODQlip35kvv65BOj4ntyqZJIdznf
	7HS8XJkYUaVpZDgTbaxLCkgkMrSdPUSJuRCjHhnsTIKKTRdvkIpFLNySK1s0Rhc3UQ==
X-Gm-Gg: ATEYQzwjsV3RvcytqzGD8u1SWAMg8NbmojbiHV/nx3/VPAMryPE5mriMovO/TXgVQv/
	GFNv72zLM52D0hobISCj/6uqjzYamBbgSURPSFwK7c8+q7S9dwYBcInUQU/LBY4Vvci2B2HkxWE
	/vN1NgEl3aatcIaJWhd/txxLzXaNWvmOKh/TrpO/2EIdej983JXXmQDEKYFvO4yhOQrbR0wO/Ny
	y4ZlmySxp12EBC9Lv9afgdSAU02DZ+wabVwrPq48sWzze5Jbv7Gh0hil+MA3AlLjClpyoClR0th
	K3R4D/Uurvp5SXvoUcTD54P9sDmitis5ps4GraAmNZsUKtjVPOeaG8hc9/kiOPp7JnAXJoz+1VV
	//nNGypUSecT8a9DQCnklD1nR7V/dSrif2NYPQtgDWZhL+T/tczt6UeGFqcGVOQ/puQ5YpX19BB
	cyCViDeamDtL6+W4i24tQkwi/bT3GPSAMdtcx5wQ6yNw0eD7J4/6FCgnPvVKFk
X-Received: by 2002:a17:902:c412:b0:2a9:5bfa:54ef with SMTP id d9443c01a7336-2adca6c8e0amr234085ad.10.1771959787309;
        Tue, 24 Feb 2026 11:03:07 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74d36911sm114902575ad.0.2026.02.24.11.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 11:03:06 -0800 (PST)
Date: Tue, 24 Feb 2026 19:02:56 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org,
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 02/22] PCI: Add API to track PCI devices preserved
 across Live Update
Message-ID: <aZ314HSRnYtGinTU@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-3-dmatlack@google.com>
 <aZ1svGur9IxQ7Td2@google.com>
 <CALzav=fSpd6H5pQNtJoFHdNtWVO11vffhWQFsMFkM+osGuE0wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=fSpd6H5pQNtJoFHdNtWVO11vffhWQFsMFkM+osGuE0wQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_110309_470886_04457503 
X-CRM114-Status: GOOD (  53.69  )
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

On Tue, Feb 24, 2026 at 09:33:28AM -0800, David Matlack wrote:
> On Tue, Feb 24, 2026 at 1:18 AM Pranjal Shrivastava <praan@google.com> wrote:
> > On Thu, Jan 29, 2026 at 09:24:49PM +0000, David Matlack wrote:
> > > + * Copyright (c) 2025, Google LLC.
> >
> > Nit: Should these be 2026 now?
> 
> Yes! Thanks for catching that.
> 
> > > +int pci_liveupdate_outgoing_preserve(struct pci_dev *dev)
> > > +{
> > > +     struct pci_dev_ser new = INIT_PCI_DEV_SER(dev);
> > > +     struct pci_ser *ser;
> > > +     int i, ret;
> > > +
> > > +     /* Preserving VFs is not supported yet. */
> > > +     if (dev->is_virtfn)
> > > +             return -EINVAL;
> > > +
> > > +     guard(mutex)(&pci_flb_outgoing_lock);
> > > +
> > > +     if (dev->liveupdate_outgoing)
> > > +             return -EBUSY;
> > > +
> > > +     ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&ser);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     if (ser->nr_devices == ser->max_nr_devices)
> > > +             return -E2BIG;
> >
> > I'm wondering how (or if) this handles hot-plugged devices?
> > max_nr_devices is calculated based on for_each_pci_dev at the time of
> > the first preservation.. what happens if a device is hotplugged after
> > the first device is preserved but before the second one is, does
> > max_nr_devices become stale? Since ser->max_nr_devices will not reflect
> > the actual possible device count, potentially leading to an unnecessary
> > -E2BIG failure?
> 
> Yes, it's possible to run out space to preserve devices if devices are
> hot-plugged and then preserved. But I think it's better to defer
> handling such a use-case exists (unless you see an obvious simple
> solution). So far I am not seeing preserving hot-plugged devices
> across Live Update as a high priority use-case to support.
> 

Ack. If we aren't supporting preservation for hot-plug at this point.
Let's mention that somewhere? Maybe just a little comment or the kdoc?

> > > +u32 pci_liveupdate_incoming_nr_devices(void)
> > > +{
> > > +     struct pci_ser *ser;
> > > +     int ret;
> > > +
> > > +     ret = liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **)&ser);
> > > +     if (ret)
> > > +             return 0;
> >
> > Masking this error looks troubled, in the following patch, I see that
> > the retval 0 is treated as a fresh boot, but the IOMMU mappings for that
> > BDF might still be preserved? Which could lead to DMA aliasing issues,
> > without a hint of what happened since we don't even log anything.
> 
> All fo the non-0 errors indicate there are 0 incoming devices at the
> time of the call, so I think returning 0 is appropriate.
> 
>  - EOPNOTSUPP: Live Update is not enabled.
>  - ENODATA: Live Update is finished (all incoming devices have been restored).
>  - ENOTENT: No PCI data was preserved across the Live Update.
> 
> None of these cover the case where an IOMMU mapping for BDF X is
> preserved, but device X is not preserved. This is a case we should
> handle in some way... but here is not that place.
> 
> >
> > Maybe we could have something like the following:
> >
> > int pci_liveupdate_incoming_nr_devices(void)
> > {
> >         struct pci_ser *ser;
> >         int ret;
> >
> >         ret = liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **)&ser);
> >         if (ret) {
> >                 if (ret != -ENOENT)
> >                         pr_warn("PCI: Failed to retrieve preservation list: %d\n", ret);
> 
> This would cause this warning to get printed if Live Update was
> disabled, or if no PCI devices were preserved. But both of those are
> not error scenarios.
> 

I agree, the snippet was just an example. What I'm trying to say here
is, what if the retval is -ENOMEM / -ENODATA, the existing code will
treat it as a fresh boot because it believes there are no incoming 
devices. However, since this was an incoming device which failed to be
retrieved, there's a chance that it's IOMMU mapping was preserved too.
By returning 0, the PCI core will feel free to rebalance bus numbers or
reassign BARs. For instance, if the IOMMU already inherited mappings for
BDF 02:00.0, but the PCI core (due to this masked error) reassigns a 
different device to that BDF, we face DMA aliasing or IOMMU faults.
Am I missing some context here?

> > > +void pci_liveupdate_setup_device(struct pci_dev *dev)
> > > +{
> > > +     struct pci_ser *ser;
> > > +     int ret;
> > > +
> > > +     ret = liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **)&ser);
> > > +     if (ret)
> > > +             return;
> >
> > We should log something here either at info / debug level since the
> > error isn't bubbled up and the luo_core doesn't scream about it either.
> 
> Any error from liveupdate_flb_get_incoming() simply means there are no
> incoming devices. So I don't think there's any error to report in
> dmesg.
> 
> > > +     dev->liveupdate_incoming = !!pci_ser_find(ser, dev);
> >
> > This feels a little hacky, shall we go for something like:
> >
> > dev->liveupdate_incoming = (pci_ser_find(ser, dev) != NULL); ?
> 
> In my experience in the kernel (mostly from KVM), explicity comparison
> to NULL is less preferred to treating a pointer as a boolean. But I'm
> ok with following whatever is the locally preferred style for this
> kind of check.
> 

No strong feelings there, I see both being used in drivers/pci.

> > > @@ -582,6 +583,10 @@ struct pci_dev {
> > >       u8              tph_mode;       /* TPH mode */
> > >       u8              tph_req_type;   /* TPH requester type */
> > >  #endif
> > > +#ifdef CONFIG_LIVEUPDATE
> > > +     unsigned int    liveupdate_incoming:1;  /* Preserved by previous kernel */
> > > +     unsigned int    liveupdate_outgoing:1;  /* Preserved for next kernel */
> > > +#endif
> > >  };
> >
> > This would start another anon bitfield container, should we move this
> > above within the existing bitfield? If we've run pahole and found this
> > to be better, then this should be fine.
> 
> Yeah I simply appended these new fields to the very end of the struct.
> If we care about optimizing the packing of struct pci_dev I can find a
> better place to put it.

If you have pahole handy, it would be great to see if these can slide 
into an existing hole. If not, no big deal for v3.. we can keep it as is

Thanks,
Praan

