Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03BECD13DA
	for <kexec@archiver.kernel.org>; Thu, 30 Apr 2026 18:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9xAzQZcfn4hf28SgvSsobLbrv7DrZRSNcDWvXS0OfYE=; b=HpRh1/fbPV7celiQSdwEOatv0U
	B8q7v8nuK/aTbiE3Tt923u2YmKa/mp0ToIzUcR0hJUPjWt2MtHh+YmKbnnVxhkAhvopvdOCwnU6DZ
	xs/v/rg8e+6Vs3h7VR40LQp4RxN14ZKH3H+DEVTSpQHW0jEEN+4WG6lXjTqgTGtmcu8Xdg2Z8GLal
	bTvnksR6LalfVyEOsfShmHTkN7mFsY4k8rdKHtzISHdf4CMoxhNQrgE3rWZiqdDAe+cJ+Udmg+EEE
	HX7GuPixEsEYqe8v6le53bosh826MM7zypFmLL878Fq+JYCCD9Wh+r+NID2bamoD5gD+f9FKeCE8J
	f58XcatQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIWR4-00000005qFM-0bYV;
	Thu, 30 Apr 2026 18:48:30 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIWR1-00000005qEZ-3PEb
	for kexec@lists.infradead.org;
	Thu, 30 Apr 2026 18:48:28 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2b243198058so24615ad.1
        for <kexec@lists.infradead.org>; Thu, 30 Apr 2026 11:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777574907; x=1778179707; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9xAzQZcfn4hf28SgvSsobLbrv7DrZRSNcDWvXS0OfYE=;
        b=K3Wu3V2R1iyzRy3N3rt1zuFTXapvOa8nno0u+AQWsDhYNr7I/0TYnj0eU+EGYA4oGC
         2jbZ8bQts1MQZkscbzOy3bIayFQu1VbcoTZT/QXAjEnjs9sJE7XIVcZsifTcBAkBFZ1i
         bxpAoaB3reVOICIOK7kJBw23xreDFnHUdZ4S++B2jEageOSh8Eus7MtD5UotS0s3g8mt
         oTk6l4QRBYg6UoEzq0cbOu0kAhLh9xDj0lP6sIrXDfyqOKfi5wmPiD+U8YS+ORvs7kDG
         FyqfDmcXxfraRKBBXzUPzc1wndUdb2jMO6yXSB1GZxUv6BwUnbjORyfRhIR6trALQLxz
         w6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777574907; x=1778179707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xAzQZcfn4hf28SgvSsobLbrv7DrZRSNcDWvXS0OfYE=;
        b=DCsKA4BJXYNF/b0zwTL1sZHQt+eZG3814kE5P1oMpbQIq89OzcR/jhpgoXq38vOx9Y
         6A7zTmFaLX7eRl7Wo4eecLEfJrrlM7OT40FUpDBgsdJ6B7dSGGfLzynk/xmKBCE3CWBC
         ZmivT4wgJtASU6FIy7aazT7HUu81LUKd7guCYNaW9JP6Z6NXAGBaMlP2rtY5p/nU4Aji
         CLZXoqnvfu/bNwj/IYMrSIxTGsF9TPW4Hazd/Yl1VTp5tiW0DC8WRU/Csauulu7qER2O
         HMUhr/WI9RVnuaUcOhJpQ/TpWmuafypWFFxWSFTusA813wSuR2GPur3Br5ca/olinha8
         CCSA==
X-Forwarded-Encrypted: i=1; AFNElJ9TI0q+vpMzkRzDiYTidhPrW1HH8TKUYdJVs/WLoJ8y95s5VExo9bNLD7y+PwmysUIwtdkFew==@lists.infradead.org
X-Gm-Message-State: AOJu0YzKAUyS/dz0XTf9D/eKPRaLhs0dyrGMPhrGL1Mc+jqjDoLWtJ/e
	fs6j3J8vKj8N5qqHfnX57nkEgmOR8pggeEfC2ku27eX3rOYuVHVMIDZjwJm6naHKXg==
X-Gm-Gg: AeBDieuA0PWzXrZWndBsinG0D8nkfY145EfPEdr26/2SYT0KQQbW8MAFz06jPjUm51r
	2gv/5ywZ4h4npc1WxlwnkqWPNQF7QPL1tqxfSO7CtBZgW6uoxYCrhi0iWMc9+wljGujNmrRnNWk
	+AOs8/lPio4EjI9zOA1hcryKxAXE4rndgDqPpKE8iUJnyrPSvrlGZoFvQ5JsyRBTWb17drAVOWb
	XF5osRrxYhTZOkqnZ8X3TXQEGwmRxc3XzTn4kpZ/s96mxR43ALZVKYs08wj/RqeS+Kf+xeumswn
	TnuhZFWb0nhIPpe4TNgtmZSiVsl5TyTPmRgX4qHdCo3AaDZYAFWGgQkTbISSVrOWChvNCL02LX5
	qba/QkO4rykVcX/nIoLItQLD+HS6F/7iJTia2XKlMWBbWAkDjxWqcEKYGx9Oq5if6fGNo0NAF1V
	lX8vCdjTeWBg5YsgtTNzUN09CKqy+88icTSRN2vFfCaHG3PO2PmsIgD8Coa8PWT6et4tRLQPiMd
	DhNIC1RJw==
X-Received: by 2002:a17:903:4b4f:b0:2b0:5c88:51e1 with SMTP id d9443c01a7336-2b9cd98bb43mr418175ad.14.1777574906266;
        Thu, 30 Apr 2026 11:48:26 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa7e47asm3289405ad.15.2026.04.30.11.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 11:48:25 -0700 (PDT)
Date: Thu, 30 Apr 2026 11:48:21 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 01/11] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <20260430182532.GB13902.vipinsh@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-2-dmatlack@google.com>
 <20260428185242.GB3825533.vipinsh@google.com>
 <afFICT9mSL1XG0v_@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afFICT9mSL1XG0v_@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_114827_857981_D6A94A5F 
X-CRM114-Status: GOOD (  31.46  )
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

On Tue, Apr 28, 2026 at 11:51:37PM +0000, David Matlack wrote:
> On 2026-04-28 12:45 PM, Vipin Sharma wrote:
> > On Thu, Apr 23, 2026 at 09:23:05PM +0000, David Matlack wrote:
> > > +	pr_debug("Preserving struct pci_ser with room for %u devices\n",
> > > +		 max_nr_devices);
> > > +
> > > +	ser = kho_alloc_preserve(size);
> > > +	if (IS_ERR(ser))
> > > +		return PTR_ERR(ser);
> > 
> > Should there be a similar pr_debug() in case of failure to denote that above
> > "Preserving ..." message didn't finish, or, maybe just print one
> > pr_debug() after the error check above?
> 
> Hm... I guess there could always be more pr_debug()s but I don't want to
> instrument every error path. I could move it to the success path but I
> don't see how that makes it any better.
> 

In current way, it is printing that it is preserving pci_ser, but there
is no indication did it succeed or not in logs. If we are printing the
logs then may be complete picture will be to know what is the action and its
result.

I think moving to success path or printing again based on the failure
provides assurance of what happened. If this gets printed in happy
path, then we will know it succeeded in preserving that struct on
kho.  Absence means it didn't. 

We can also remove pr_debug(), if this is of no value.

> > 
> > > +/**
> > > + * struct pci_dev_ser - Serialized state about a single PCI device.
> > > + *
> > > + * @domain: The device's PCI domain number (segment).
> > > + * @bdf: The device's PCI bus, device, and function number.
> > > + * @reserved: Reserved (to naturally align struct pci_dev_ser).
> > > + */
> > > +struct pci_dev_ser {
> > > +	u32 domain;
> > > +	u16 bdf;
> > > +	u16 reserved;
> > 
> > Should this be renamed to 'u8 __padding[2];' instead? This will allow to
> > just change the array length based on the need (0, 1, 2, 3).
> 
> Sorry I'm not following what you mean here. What is the reason to rename
> this field and change it to an array?
> 

Having a padding explicitly tells there is a requirement of being
aligned. Reserved sounds more like don't use this u16.

If someone add more field down the line say u8, then to make struct size
aligned they will need to add another u8, u16, u32, and name those
fields padding or reserved. IMO, having a u8 array named padding makes
it easier to just change array length as per the need.

> > > +} __packed;
> > > +
> > > +/**
> > > + * struct pci_ser - PCI Subsystem Live Update State
> > > + *
> > > + * This struct tracks state about all devices that are being preserved across
> > > + * a Live Update for the next kernel.
> > > + *
> > > + * @max_nr_devices: The length of the devices[] flexible array.
> > > + * @nr_devices: The number of devices that were preserved.
> > > + * @devices: Flexible array of pci_dev_ser structs for each device.
> > > + */
> > > +struct pci_ser {
> > > +	u32 max_nr_devices;
> > > +	u32 nr_devices;
> > > +	struct pci_dev_ser devices[];
> > > +} __packed;
> > > +
> > > +/* Ensure all elements of devices[] are naturally aligned. */
> > > +static_assert(offsetof(struct pci_ser, devices) % sizeof(unsigned long) == 0);
> > > +static_assert(sizeof(struct pci_dev_ser) % sizeof(unsigned long) == 0);
> > 
> > Nit: Maybe move this assert to be near to the definition of this struct,
> > easier to find it when editing the struct vs finding it later during
> > build.
> 
> The combination of these 2 asserts is what guarantees that every element
> of the devices[] array are naturally aligned, that's why I put them
> together here.
> 
> I can move it up though if you think it's better.

Okay, SGTM.

