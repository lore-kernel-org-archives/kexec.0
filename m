Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCDFCD8CA4
	for <kexec@archiver.kernel.org>; Mon,  8 Jun 2026 20:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OqANBGSP00mnERvECbdyBZ/QnoUicIMj2Z9x9A+M1D8=; b=NYs6S38p65RE8btjoV3up4X7+t
	g8fUd+YEZYrtArDLwaxItwUDiC9tQ18XTBBKOReFn3vQw7D74+GkGupPX6FT3XKV1PCxLybP0LQci
	9L6736xzh343c7+9rk7BuBgkfka5I7ZdHLtvhb9Uk0wUIE1q53srv0jw6TZWG9W4rcdLCd1t8ZvEm
	UnjZCKv/UZYJHSVtfeJHZd3wVGViNdfGq49X753bUO1buSEsbdgOTzA806HtxV5B9ZJS7UwBl00MB
	fMRdG++5zJuapilUcgg9dtN3AnzlfWAaBM08IOsnw/0vFEQb6uo/psRmIYKPexRwUqfRPatzlIk+f
	fvL0PiYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWgwC-00000004OCW-1Tao;
	Mon, 08 Jun 2026 20:51:12 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWgw8-00000004OC7-45q4
	for kexec@lists.infradead.org;
	Mon, 08 Jun 2026 20:51:10 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-c859a374903so1631348a12.3
        for <kexec@lists.infradead.org>; Mon, 08 Jun 2026 13:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780951867; x=1781556667; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OqANBGSP00mnERvECbdyBZ/QnoUicIMj2Z9x9A+M1D8=;
        b=G89TxsEK4t9l7GABQ+XeZib3od50t/xWvFModov3DXwIOAl8JWdXCflgcJXHClngnG
         /trzpnT0ndAzeWq0RGwdkw/gsnu9NzdfwvPWKw1xTFcSzYsDOkh6+rS4saVIf+H3REVW
         qqti0fWfTJqTBRYwHpCKZ3atRTkSyLL0S5fGCplpM3aWgq1MKY6To19q39ELA4q0UVTw
         Sq6hwC9qwdh22fv01b3716RWb8VLvaMe8spjFFiB1iffiM0q9HH+BBxcI4OQgJMj+byd
         jib4LPOuDxVq6cdQVZTkb68aLHCchzRqItNOm3s+Z637JKKqsnGEmMqJxfkf+Z2wuaUJ
         NLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780951867; x=1781556667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqANBGSP00mnERvECbdyBZ/QnoUicIMj2Z9x9A+M1D8=;
        b=CIxb5jlAHXzR0xCfDeJ7h2iixWUEnaz1OgURobYgREx7zwTsul1+UGY2AS2Z9c54m8
         HAhJI2AVNKhU7GjQSHX2QkgFXiRCFhZXArXpZMHve5PB7m5guaghSv6ZmrAlSNn47DA+
         kTjTb6PW4zKabRSXl9lc5KupiGi9/oyaZxvK7QRYi9mhv/4z/G5WhCoJQbfRS3Bwla/i
         8Vjfi/VjPZ6Yy1x18vZe30pGKms1BHbEKNbMJH2o/zw7XyD05zz9gNkAl7lIiYA2WVIW
         ivKr5cTuRK7rpDSMl3xwJ0ANanrwwn/CEEOC8EDPEKL7iuxPWkesY0iXGSh/tq/0QrhY
         dt+g==
X-Gm-Message-State: AOJu0Yx0f8zGr7200d2gtrDqnjVklEFGMj+ukC8zAc8+ThI8jcdLTz2K
	ONBAkA+IhFHaeLGivBCk2463GE8vutYRqTtzPqx75lOsIB7u6GRRFwGkEEtGzgYk3w==
X-Gm-Gg: Acq92OHQoCGE4dKnNrMVj432729kpoXnrp+E7lghP2MwOlhEFRgOPHiFfbPFbJgMpdF
	QFIangGQcCiwoIimhOUVULtGB3unLDTr2sWIc0/grvDmFtf9AJBFe/P5W4fFaAmunhlGjQMnnJm
	aVgaULNoxLMKAZDf8jS++DqhZGBeGDJwfPMFl35CaFEvie2rQP4qut2nUw2PsMMkMppk6gBJ9t6
	6IjqP8/H8G+9I5Bn0g0hRlMEgKvBZf1QGqoNw5KVwLhfHrbIwtaDEcjdIatmFRRrcOIelIMSFWE
	orn5wkDI49NzsYqS4+eUjnAJMOqxGTANeKVKMm6HgAh/TeF32/bza2LnPM/LhifZhhXnuOAcTQ5
	rvuuXdgtbOrtmGFxHG29wgc0WgqgVMPJjQCxIy0dtKGIQftgy1S8PjG3lYgj7cw/QA2l0PaBzO6
	4KfADMk0AHcf/8tZ9/oPMyZnt12qW6srLrlscAjvaixBIB+qJlSBA4Odjc8MOXSdIAC2ZDLCFT
X-Received: by 2002:a05:6a21:a38b:b0:3b4:904f:c9cd with SMTP id adf61e73a8af0-3b4cccffc4fmr20088541637.6.1780951866181;
        Mon, 08 Jun 2026 13:51:06 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0b315esm15840734a12.26.2026.06.08.13.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:51:04 -0700 (PDT)
Date: Mon, 8 Jun 2026 20:51:00 +0000
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
Subject: Re: [PATCH v6 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <aicrNNVrMBtJD2iZ@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-2-dmatlack@google.com>
 <aiJhoq_Yj6-1Hl5r@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiJhoq_Yj6-1Hl5r@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_135109_052031_3353611A 
X-CRM114-Status: GOOD (  30.43  )
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

On 2026-06-05 05:41 AM, Pranjal Shrivastava wrote:
> On Fri, May 22, 2026 at 08:23:59PM +0000, David Matlack wrote:
> > Set up a File-Lifecycle-Bound (FLB) handler for the PCI core to enable
> > it to participate in the preservation of PCI devices across Live Update.
> > Essentially, this commit enables the PCI core to allocate a struct
> > (struct pci_ser) and preserve it across a Live Update whenever at least
> > one device is preserved.
> > 
> > Preserving PCI devices across Live Update is built on top of the Live
> > Update Orchestrator's (LUO) support for file preservation. Drivers are
> > expected to expose a file to userspace to represent a single PCI device
> > and support preservation of that file. This is intended primarily to
> > support preservation of PCI devices bound to VFIO drivers.
> > 
> > This commit enables drivers to register their liveupdate_file_handler
> > with the PCI core so that the PCI core can do its own tracking and
> > enforcement of which devices are preserved.
> > 
> >   pci_liveupdate_register_flb(driver_file_handler);
> >   pci_liveupdate_unregister_flb(driver_file_handler);
> > 
> > When the first file (with a handler registered with the PCI core) is
> > preserved, the PCI core will be notified to allocate its tracking struct
> > (pci_ser). When the last file is unpreserved (i.e. preservation
> > cancelled) the PCI core will be notified to free struct pci_ser.
> > 
> > This struct is preserved across a Live Update using KHO and can be
> > fetched by the PCI core during early boot (e.g. during device
> > enumeration) so that it knows which devices were preserved.
> > 
> > Note: This commit only allocates struct pci_ser and preserves it across
> > Live Update. A subsequent commit will add an API for drivers to tell the
> > PCI core exactly which devices are being preserved.
> > 
> > Note: There is no reason to check for kho_is_enabled() since it can be
> > assumed to return true. If KHO was not enabled then Live Update would
> > not be enabled and these routines would never run.
> > 
> 
> [...]
> 
> > +/**
> > + * struct pci_dev_ser - Serialized state about a single PCI device.
> > + *
> > + * @domain: The device's PCI domain number (segment).
> > + * @bdf: The device's PCI bus, device, and function number.
> > + * @padding: Padding to naturally align struct pci_dev_ser.
> > + */
> > +struct pci_dev_ser {
> > +	u32 domain;
> > +	u16 bdf;
> > +	u16 padding;
> > +} __packed;
> > +
> > +/**
> > + * struct pci_ser - PCI Subsystem Live Update State
> > + *
> > + * This struct tracks state about all devices that are being preserved across
> > + * a Live Update for the next kernel.
> > + *
> > + * @max_nr_devices: The length of the devices[] flexible array.
> > + * @nr_devices: The number of devices that were preserved.
> > + * @devices: Flexible array of pci_dev_ser structs for each device.
> > + */
> > +struct pci_ser {
> > +	u32 max_nr_devices;
> > +	u32 nr_devices;
> > +	struct pci_dev_ser devices[];
> > +} __packed;
> > +
> > +/* Ensure all elements of devices[] are naturally aligned. */
> > +static_assert(offsetof(struct pci_ser, devices) % sizeof(unsigned long) == 0);
> > +static_assert(sizeof(struct pci_dev_ser) % sizeof(unsigned long) == 0);
> 
> Minor Nit: Shall we consider using specific bitwidth types here?
> I'm wondering if down the line another u32 field is added to 
> struct pci_dev_ser.. in that case on a 32-bit machine 12 % 4 == 0 but on
> a 64-bit machine 12 % 8 != 0..

I think natural alignment is what matters for efficient access of the
array elements. So failing the assert only on 64-bit architectures seems
like the correct behavior.

> 
> [...]
> 
> With the nit:
> 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> 
> Thanks,
> Praan

