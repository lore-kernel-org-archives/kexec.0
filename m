Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423F8FF8875
	for <kexec@archiver.kernel.org>; Tue, 28 Apr 2026 23:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=in+mysCXNp4IJcp8wpKV/ePcsC7P4CQwStR4ajhF2Xo=; b=mAm4ykrE7G0IIQUVCBvRUIRYq/
	dPRSnNxdcPMUj90j0gKqyAwqozI2K2/SAm60p5v4CTfR51nDNIs8nTzGZUkpBlzRM+5hHTkx10FbW
	XWts8vA3IJe04JShTnVzslgbLIMdDd6HbpKxAJm+RmUp9fU8wD0MyEmym8hgr5m4hGemURbppFUJU
	yLDd8dGsGWCE9cyqcg//qdp9De7R2w4mR/507oJAaScrMPeMAgg2NOwHs4tMSXqEydJBki98TcoYv
	7dMQp/08XhTyP/IJwoBaLqWOd22O8ma7ysUWxFBtwd4GEgutCYTvP4b3hJUtBW8TEPWXYMkz29tZd
	fHV0UNzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHsDS-00000002dbV-2aNs;
	Tue, 28 Apr 2026 23:51:46 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHsDQ-00000002db5-17gp
	for kexec@lists.infradead.org;
	Tue, 28 Apr 2026 23:51:45 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2b45cb89f7eso74796465ad.0
        for <kexec@lists.infradead.org>; Tue, 28 Apr 2026 16:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777420303; x=1778025103; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=in+mysCXNp4IJcp8wpKV/ePcsC7P4CQwStR4ajhF2Xo=;
        b=FVjp0y0fWDim0DXgSipeFm4KWlJyi0Pufggp4gs/m9kO7V0seDww4U8GTQBl7BqSq+
         3hUV9mqkYgT5Zj2r3aQ6dWgn0uTqFF3hcs1z+ZbRl/nmSvTy7YRIMmeRP/nWLjEZbSeM
         h9xsKKswH6/JPzpCQ3J/Ay8PSHlvg2IvRzUqP3P064enTSU2DegTwCiuxyfDUfm2dBmj
         EonjkrN8H6Z+oq5DHdu/mJzd/5NgkphcLqf+6fjFyJcG8azOVH5C0YK+Dy5ZgHUsQu3x
         0fUdQQP+tWFzPEv0JPCyCJeaR1XddP/56FGo/VclQUHtJI1rZGgJHCAKyBroZK0SD1vB
         1AEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777420303; x=1778025103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=in+mysCXNp4IJcp8wpKV/ePcsC7P4CQwStR4ajhF2Xo=;
        b=Qksiv8bGiVJ0dmvQA1R6eqDroqBS1prn4IW281L2zYKtU+ve740hlvPbboo5hZop8X
         iUOWxUvu+Sc7U56KKYu6Jm1vj2mtI3BKYNYz1Dml/sF4YV5vmcJ0WvmxlCEfkvjCYa4T
         DuL5czZTW65UrWU3mJrda6gIaLt96b0Tc7aVJ9yXnQboLKPea6XeBaP5l6kQmUzPsly2
         zA9ypi7h7eQ3CTN7/Z7vb/Y006eHRqATi4ZmHq2KFirI9h+Wu4Fi5VIPIHY6MlJg5avS
         0IxwnH7h3gYnYZ7GOE5Rsi/oZzDd5DNq9e9CkcDlIhKyP8jpw+Jp3WhizJPFMvzEt/er
         nN0Q==
X-Forwarded-Encrypted: i=1; AFNElJ8scgaeBqkSmmd6XR4Uhk4H+Z4R1XGw2qzSMySKE5u8LgZS2Vjprj022tnaDLttUA3ZvRQLqw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzCFdGN/FINoJ8qda2LgLzY7zlHBlxRSGQMDLe0T0PbkgRcC0PL
	4h3IRWdKGlwOy4NLNM82yYl+EEGUnSHNgVT1Ca455fdxOHBj642m8oDo9w1Je1AGgQ==
X-Gm-Gg: AeBDies8BaWh+MNzyenSgNduVepImJ7yhfu7YPdYxljzuQvd0qYvnenSeDExwefBKxm
	Y3Ly7FAsXmr9Wt3ngQCCdogdLyqStf3+tWsRR9Z8sD1ByuYelIch1GGe33nDOQ/qLPzNJdYCz69
	6UVhDxdFgnqznW4nJH5kUkDJyyIqMgKwr9ncfcZ6PM7Y5lPTSSXlWylAgi18e1WjiFzj6AHvj5V
	vHcz9uSB1tYnEJ6bHVHOxqsbEJPZ6I3p95Q6hWBqXYVE9VLTDnOuokYtXwt8IebGZ7uwnNxp5MH
	bq9Y4s/qJy+fiQdJLVfDJWWh1mPh+WcQ4vgu684GddpazYz8Au0YeFoLoqLWGOjSME7JNDYOggc
	QTHsBtm//mI1LmESmwvbDtTvvMr+lOd7xES+RKkI9/PqhfedtBXbnarlTVMwIjolMqwz61qXtml
	d81SjbqqcIU0BN/5MER/Ayoeakx61X+CMY4qr1KC/Am7THRRfZnXZ/QcPYBzgLzINGOvSQU7OXo
	UfVyA==
X-Received: by 2002:a17:903:a90:b0:2b2:65db:8c5f with SMTP id d9443c01a7336-2b97c4c8995mr46570035ad.27.1777420302688;
        Tue, 28 Apr 2026 16:51:42 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98859f629sm3480345ad.0.2026.04.28.16.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 16:51:41 -0700 (PDT)
Date: Tue, 28 Apr 2026 23:51:37 +0000
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
Message-ID: <afFICT9mSL1XG0v_@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-2-dmatlack@google.com>
 <20260428185242.GB3825533.vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428185242.GB3825533.vipinsh@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_165144_312418_D1F5C849 
X-CRM114-Status: GOOD (  21.36  )
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

On 2026-04-28 12:45 PM, Vipin Sharma wrote:
> On Thu, Apr 23, 2026 at 09:23:05PM +0000, David Matlack wrote:
> > +	pr_debug("Preserving struct pci_ser with room for %u devices\n",
> > +		 max_nr_devices);
> > +
> > +	ser = kho_alloc_preserve(size);
> > +	if (IS_ERR(ser))
> > +		return PTR_ERR(ser);
> 
> Should there be a similar pr_debug() in case of failure to denote that above
> "Preserving ..." message didn't finish, or, maybe just print one
> pr_debug() after the error check above?

Hm... I guess there could always be more pr_debug()s but I don't want to
instrument every error path. I could move it to the success path but I
don't see how that makes it any better.

> 
> > +/**
> > + * struct pci_dev_ser - Serialized state about a single PCI device.
> > + *
> > + * @domain: The device's PCI domain number (segment).
> > + * @bdf: The device's PCI bus, device, and function number.
> > + * @reserved: Reserved (to naturally align struct pci_dev_ser).
> > + */
> > +struct pci_dev_ser {
> > +	u32 domain;
> > +	u16 bdf;
> > +	u16 reserved;
> 
> Should this be renamed to 'u8 __padding[2];' instead? This will allow to
> just change the array length based on the need (0, 1, 2, 3).

Sorry I'm not following what you mean here. What is the reason to rename
this field and change it to an array?

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
> Nit: Maybe move this assert to be near to the definition of this struct,
> easier to find it when editing the struct vs finding it later during
> build.

The combination of these 2 asserts is what guarantees that every element
of the devices[] array are naturally aligned, that's why I put them
together here.

I can move it up though if you think it's better.

