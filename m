Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B140EFD45F9
	for <kexec@archiver.kernel.org>; Wed, 25 Feb 2026 23:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/CK8Xw2Z8/jwhJKdKy0esOogFCKRH5zkiTBeIKoVGlM=; b=lWrQiuzjEpZ54Fp5gl5MVpzodp
	uF5Mw9bGOA/NSHn9g35lAl5s38HQ3LakW+gvJsGyaqHxouwT8WJO4dDF5naet+2vy/YMxsseLSLwB
	WuOKP9xqG0zccEKk+Mpo0FKJmguffyJSIeCpDSeaDAgL+LPtXgkhlSRZo7ctJe+eH/W6Uc31krxML
	dUoA03sG2XfaI2fcFBIaxtwxXOykFdvroyVYpGOSWQIFYuS2IG7GLzhwt1AeVll8UeHSAlXsGQRRT
	aVRc1R4BOB3IZOVOsSyEk7EIUUQMI5HnWmbfGvrijvtskALgeEw6LDREarsHazaii1SUsYoKyRwo5
	a3X+8cpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvOVF-000000055JD-3kwP;
	Wed, 25 Feb 2026 23:41:13 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvOVD-000000055Is-05rk
	for kexec@lists.infradead.org;
	Wed, 25 Feb 2026 23:41:12 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2a9296b3926so1838255ad.1
        for <kexec@lists.infradead.org>; Wed, 25 Feb 2026 15:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772062870; x=1772667670; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/CK8Xw2Z8/jwhJKdKy0esOogFCKRH5zkiTBeIKoVGlM=;
        b=XDlBRe2QaUL33qMXZ9FZgBxaWq3Cz75A0Qm7AYGaLbd5l3EXyr9QkjyCePQ0DsmZAb
         eDN7UvXHrJSxnmmPpBN7WgjBN2JyLQOtJmlvDidrtq4ZIXrb7zECW2pGtEnjZ6a9bmwX
         f4hsOLxUQBtoDDk0uurBFOk1hVw4l0rRH1ka31GccFjuAyr1FUwSnoR0GfIKLiJxKIT4
         tBAnnRFquO9y5/DT4I493a1QEm9JUCq5nJhikW+iwcXhVssGaR67AZHWYHrPax6w9135
         Ew+be4wg3jvi5YIlg1xwLjA/l7N96dvn6RoHv+OJxCxR/0OZGLJsqTXz21WtEoHrbsCc
         IVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772062870; x=1772667670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CK8Xw2Z8/jwhJKdKy0esOogFCKRH5zkiTBeIKoVGlM=;
        b=X3ZLS+ut6sPh25ZGYNTZjODmZmXLdGAakDqR373QrfpK5EWIXdSrhJHwwknZjfQCtN
         TfmM5NYKeTSG+OcXSIEUP4Rk1UEtuF8tLpJimD3OFDkruKZdAv9E8SzOp3o6k1TUhcUN
         RmsPCbiO1+JWlCXNC1fptIjrDiTXvGROZRAoF7oqmEgDK0VBBrx8G+dFqFu+YFfa4XMc
         EuT/Nc0TFgrcUKul/Liy/J1MfvLftADssH9EMvwa/zloNrKZ4R36aFMnCjElxo1EXzow
         un23dAB0xXXFGomxfZzda8kyLArFxc/IC7do35TblsgyhfPwFgiYZMQVM15R1+4YXrxZ
         Womg==
X-Forwarded-Encrypted: i=1; AJvYcCVZRgyxTTyNabxl7IlOmPK2baVgPd/8+v0Rq8LadwunwvdlYkGPQZRonMrpGPOdBuItxFBpfA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwHSAxhQF80kQGRH/o+8yaAsDl1JnlqHPZxwRiNwgrJhOpJOMyD
	T1cgc3HjSr8IMFPeKZQEGoOIyvvvg2Lg0e2mzEzZeCBBt25m1yfIocH9arjITUl+5Q==
X-Gm-Gg: ATEYQzzVHCymm9TKyK9PZbWRqKLyfP6XUdT+9PbahVr9DBgBBZWyFc2/UbN+NZqo6Q4
	15NL1PTXHF3lnIWeAJti01NFDIa77P+tOabK0EuXYHZBdH8neGVHl2GyM2zqwO3Qwha5u8Hkb9n
	uK8ouZEmWGB6ysTzoWWz3eXD/mznZTVzbyoww01xrQ7SPrbhdgkTWubUh6MRuulDh2XSxi2p+PK
	9HgyLfB3tT0Zokz//XBoOlgSEmP7GubItDvnRddXzdWuZyPcXd6Nj+1Y7FduLokkVrrS5Mzn+hs
	DO90fv4+RFoWCdzpfKHVXeokhQBkdITFz6ofindfSfBeR1AW/WNASIkL13jt7DRjntkEXXtx09R
	Fi3bKsgXEdTMkpkmkCux1sh2gGx2k7QKLOaenJ+v3nGiO3vESt6K18i+vDfqZbCZSRuaDwqBRWk
	upiwHfXP9WJ2GTBZlWUOpT9kyLgV667Txgh84RdX17/B2+9p2HyynaCfK8DMD0ZQ==
X-Received: by 2002:a17:902:cccf:b0:2a1:e19:ff0 with SMTP id d9443c01a7336-2ae035d235dmr1928845ad.39.1772062869584;
        Wed, 25 Feb 2026 15:41:09 -0800 (PST)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6b5813sm3778175ad.63.2026.02.25.15.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 15:41:08 -0800 (PST)
Date: Wed, 25 Feb 2026 23:41:04 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>,
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
	Pranjal Shrivastava <praan@google.com>,
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
Subject: Re: [PATCH v2 05/22] vfio/pci: Preserve vfio-pci device files across
 Live Update
Message-ID: <aZ-IkNFOLJUff1hC@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-6-dmatlack@google.com>
 <20260225154124.78e18fa4@shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225154124.78e18fa4@shazbot.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_154111_070296_83DE6C02 
X-CRM114-Status: GOOD (  25.06  )
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

On 2026-02-25 03:41 PM, Alex Williamson wrote:
> On Thu, 29 Jan 2026 21:24:52 +0000 David Matlack <dmatlack@google.com> wrote:

> >  static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
> >  					     struct file *file)
> >  {
> > -	return false;
> > +	struct vfio_device_file *df = to_vfio_device_file(file);
> > +
> > +	if (!df)
> > +		return false;
> > +
> > +	/* Live Update support is limited to cdev files. */
> > +	if (df->group)
> > +		return false;
> > +
> > +	return df->device->ops == &vfio_pci_ops;
> >  }
> 
> Why can't we use vfio_device_cdev_opened() here and avoid all the new
> exposure in public headers?

I thought I explored using vfio_device_cdev_opened() but I can't
remember now why I went with df->group. Maybe there wasn't a good
reason. I'll switch to vfio_device_cdev_opened() in the next version.

> >  
> >  static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
> >  {
> > -	return -EOPNOTSUPP;
> > +	struct vfio_device *device = vfio_device_from_file(args->file);
> > +	struct vfio_pci_core_device_ser *ser;
> > +	struct vfio_pci_core_device *vdev;
> > +	struct pci_dev *pdev;
> > +
> > +	vdev = container_of(device, struct vfio_pci_core_device, vdev);
> > +	pdev = vdev->pdev;
> > +
> > +	if (IS_ENABLED(CONFIG_VFIO_PCI_ZDEV_KVM))
> > +		return -EINVAL;
> > +
> > +	if (vfio_pci_is_intel_display(pdev))
> > +		return -EINVAL;
> 
> Some comments describing what's missing, if these are TODO or DONTCARE
> would be useful.

Will do.

> > +static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *args)
> > +{
> > +	struct vfio_device *device = vfio_device_from_file(args->file);
> > +	struct vfio_pci_core_device *vdev;
> > +	struct pci_dev *pdev;
> > +	int ret;
> > +
> > +	vdev = container_of(device, struct vfio_pci_core_device, vdev);
> > +	pdev = vdev->pdev;
> > +
> > +	guard(mutex)(&device->dev_set->lock);
> > +
> > +	/*
> > +	 * Userspace must disable interrupts on the device prior to freeze so
> > +	 * that the device does not send any interrupts until new interrupt
> > +	 * handlers have been established by the next kernel.
> > +	 */
> > +	if (vdev->irq_type != VFIO_PCI_NUM_IRQS) {
> > +		pci_err(pdev, "Freeze failed! Interrupts are still enabled.\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	pci_dev_lock(pdev);
> 
> device_lock() is a dangerous source of deadlocks, for instance how can
> we know the freeze isn't occurring with an outstanding driver unbind?

I can change this to a try-lock and return an error if taking the lock
fails. The freeze() callbacks are triggered by liveupdate_reboot() which
is called from kernel_kexec(). So returning an error to userspace is
possible.

My only concern is whether using try-lock would make kexec flaky, or if
it would only fail if userspace is misbehavior (e.g. unbinding drivers
while kexecing).

> > -static struct vfio_device *vfio_device_from_file(struct file *file)
> > -{
> > -	struct vfio_device_file *df = file->private_data;
> > -
> > -	if (file->f_op != &vfio_device_fops)
> > -		return NULL;
> > -	return df->device;
> > -}
> > +EXPORT_SYMBOL_GPL(vfio_device_fops);
> 
> Seems we just need to export vfio_device_from_file().  Thanks,

Will do.

