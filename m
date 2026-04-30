Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DB9CD13D2
	for <kexec@archiver.kernel.org>; Thu, 30 Apr 2026 20:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JvD+uC7yGlafUSeu2Mn7DdblXz0CDLD8RU3/xZfrtps=; b=ZdO3vE+rXEowTfqOZLYTyX3C9l
	LjK5AYyxmJuRfq3OKCCG3ZWsSju6f4YxUvULNT0Nkp5VcOfhi2YLOR1uIUCQHeMaJdSUK+2HJhyTN
	9Ls9fnOqZ/inj2/HCcIplmpdedtbi+z4w/cgwIw/5xZALwEHmiPrGoruahG1h3nP/nYmeh4+xuPN7
	9KjKn0EFghG1EBUoix/YXxYzHVIEhUL3jPfGinN4/OJZgP96Hfr+14yaKSzCrpbz7ojOxC1Aviza5
	10lz81OmpThglkrwVn2Qx3xnK8X7PDozEpsEM3VM0VIvJ3Hx3u6p/WXq6zYxwNJy3G4qMsPkJ2mZ/
	zatAfrbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIYFv-00000005w4s-0bNM;
	Thu, 30 Apr 2026 20:45:07 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIYFs-00000005w48-2HZ6
	for kexec@lists.infradead.org;
	Thu, 30 Apr 2026 20:45:05 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2ab46931cf1so16921235ad.0
        for <kexec@lists.infradead.org>; Thu, 30 Apr 2026 13:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777581904; x=1778186704; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JvD+uC7yGlafUSeu2Mn7DdblXz0CDLD8RU3/xZfrtps=;
        b=TD7swI2bo6Pk2HYNkaQgOcDLzc7xiy1uAag6cvpbVFGF2MMoKsbp9mqNZk1lQtXE1S
         DzdUVIwiJz2JEVVLnq2rwAv0pdyuVrRfPVLVs0Q/TWUg12HwRD8VV+KVACLPCHYlncom
         Z1u55/kjnvLawSvtieQPZpuKMR95ZqBs1DDpwJa1Wfx5hqxg/UJYsYZ0wqOj5oMlEZFG
         d7T277YlkGJ8Ln2Y4JTbKRRSjkdijY8iadbNOamP02Khi0iehzjb3ifoq5zhANpRP6v0
         uuIql+NJctzLJuv1PmC3chldo+z2lYVTREAy/pNB1NSgeDGzRSg3+nqexqmlBm5rCF8j
         VFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777581904; x=1778186704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JvD+uC7yGlafUSeu2Mn7DdblXz0CDLD8RU3/xZfrtps=;
        b=s72hPlalrVoN5dOxO7Nelpj6FwL41qno9UZtwvqaaEOsI0JCOBdEsOWIMCx6pYiE04
         evobAewJO64/oV5jPucwPAEw6yqv/bfwmddXiFS4w3jselKraL/pD45t0HUVacWSx1SE
         GaHQ56oUEljFdvzTiMiSD7dwlw2PUN/ML5XtosItsW+GP9dzHMLWyUeSggm/h41k0RrU
         rTxE1TFjkhutVE6LbUtYA4tUOMrZBTTUAFWUz1APCPEWSVjV5mSDORcjpXn0nDHsVzij
         zo7gRh1QPDhyApztszW4t3Nzs3gs8vR5op1gisWIfKAJhNGh6aOZ8rt5bEzlfqRuuUwS
         eW7w==
X-Forwarded-Encrypted: i=1; AFNElJ92aDi9txmXYwV6y5XWif8kj/dhEEXz69hoOSZDMmqcUaFBBtF0a+G0wt7+XTHHOPTz4f++cw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw3xdBD23FccLls7q7+WW/0+O+gKIoU/BhhUwdCi0G85FqxaZbm
	VMbQwzlyjPwZq6FHOZsC9AnQIARRZ8gI1XK8EAcgf48VLFwr3HQ9rpu7SxxbqO3jMw==
X-Gm-Gg: AeBDiesWEICpx3P3CgIF78xrE6umWYOUAQrRQFNkvpqJiWiCPR4U8DzH2PmS1c8qqy8
	C7LL1yfnFWZp1yiEws1oDWpu6h5K/hbtPSt4ON+2pe/yp9a2u6Z4h4uFt1N+SaVrNUNZgItU8nm
	sNAWp0AHCtjc118Wi5wG3vNh6sV8gKQ16W+nPp+GBq1yw1BsidrrEZCTMTUVQSPLIppFP5SXrGK
	zVf0uJCIldxpV8up7fW8HjqVExwnY2ro8hP5EBEXeVs99mOW24uM7IwKCHCPxd2Q23aRsw4yRdp
	/q018gknzpmgdUL4NXYo9wZUxe3WMAOGcC6xenD4dIgeVyOrgZeX1J2D4hMMN5wF58ZcHooFigU
	MK9B3fil3syfJxn/AjKKO3hhikCRme3qdwvC0XFXJ6AqTKIr0dNLdADQa47+UamswmJa3Rj1JX4
	cDiK/WdrTK+bAQKnp0x5wSHMun2hhjHguPkCctGBZZOT8jB4hhRoFQ2T9jCN85fqzmyojZBckX5
	xA3qQ==
X-Received: by 2002:a17:903:200a:b0:2b2:6cab:3127 with SMTP id d9443c01a7336-2b9a44c5da2mr25533465ad.20.1777581903207;
        Thu, 30 Apr 2026 13:45:03 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae5cc52sm4845105ad.78.2026.04.30.13.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 13:45:02 -0700 (PDT)
Date: Thu, 30 Apr 2026 20:44:58 +0000
From: David Matlack <dmatlack@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 01/11] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <afO_StuvUj1Rj-5I@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-2-dmatlack@google.com>
 <20260428185242.GB3825533.vipinsh@google.com>
 <afFICT9mSL1XG0v_@google.com>
 <20260430182532.GB13902.vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430182532.GB13902.vipinsh@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_134504_590693_0E720BA3 
X-CRM114-Status: GOOD (  32.56  )
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

On 2026-04-30 11:48 AM, Vipin Sharma wrote:
> On Tue, Apr 28, 2026 at 11:51:37PM +0000, David Matlack wrote:
> > On 2026-04-28 12:45 PM, Vipin Sharma wrote:
> > > On Thu, Apr 23, 2026 at 09:23:05PM +0000, David Matlack wrote:
> > > > +	pr_debug("Preserving struct pci_ser with room for %u devices\n",
> > > > +		 max_nr_devices);
> > > > +
> > > > +	ser = kho_alloc_preserve(size);
> > > > +	if (IS_ERR(ser))
> > > > +		return PTR_ERR(ser);
> > > 
> > > Should there be a similar pr_debug() in case of failure to denote that above
> > > "Preserving ..." message didn't finish, or, maybe just print one
> > > pr_debug() after the error check above?
> > 
> > Hm... I guess there could always be more pr_debug()s but I don't want to
> > instrument every error path. I could move it to the success path but I
> > don't see how that makes it any better.
> > 
> 
> In current way, it is printing that it is preserving pci_ser, but there
> is no indication did it succeed or not in logs. If we are printing the
> logs then may be complete picture will be to know what is the action and its
> result.
> 
> I think moving to success path or printing again based on the failure
> provides assurance of what happened. If this gets printed in happy
> path, then we will know it succeeded in preserving that struct on
> kho.  Absence means it didn't. 
> 
> We can also remove pr_debug(), if this is of no value.

I think I'll just drop these. BPF can be used to trace this function and
what it returns when debugging issues.

> 
> > > 
> > > > +/**
> > > > + * struct pci_dev_ser - Serialized state about a single PCI device.
> > > > + *
> > > > + * @domain: The device's PCI domain number (segment).
> > > > + * @bdf: The device's PCI bus, device, and function number.
> > > > + * @reserved: Reserved (to naturally align struct pci_dev_ser).
> > > > + */
> > > > +struct pci_dev_ser {
> > > > +	u32 domain;
> > > > +	u16 bdf;
> > > > +	u16 reserved;
> > > 
> > > Should this be renamed to 'u8 __padding[2];' instead? This will allow to
> > > just change the array length based on the need (0, 1, 2, 3).
> > 
> > Sorry I'm not following what you mean here. What is the reason to rename
> > this field and change it to an array?
> > 
> 
> Having a padding explicitly tells there is a requirement of being
> aligned. Reserved sounds more like don't use this u16.

It's documented above, but agree padding is a better name.

> If someone add more field down the line say u8, then to make struct size
> aligned they will need to add another u8, u16, u32, and name those
> fields padding or reserved. IMO, having a u8 array named padding makes
> it easier to just change array length as per the need.

This field does get replaced in the next patch. But I see your point
that if we need to pad by an amount other than u8, u16, or u32, then we
would need an array.

