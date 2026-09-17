Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4141C982D0
	for <kexec@archiver.kernel.org>; Thu, 17 Sep 2026 23:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u0O1lZsSl6FgDJ9eTYr2jlFm3jSIkWmZkODdW+Q8s2I=; b=WD5cxhl9hnLtzmGglxtOm8Jyzl
	rGa18ugaZ+zvvGZilLUZj05z4bXoVYUS/yD8BkH5+V8+N49zKVyudX+4/ZR/IXuAPtbyawgmNv1rM
	ZPqpWBottIP2n4BPOjeOBFxfTG1zizoh403EOUq68w9P8dP06KNFEfFIXuT5hGtfqb4eTfvA7vxTp
	L5nhQL4A+hvjY+46FjMTaVhbbgHmIgVK5ut+Yt+vrc3i6/x0VYElTu498PFUdhKlPXrkQZ94evm4m
	HBevpBvNTMr63ULVsMDkQ8wayxwgxNL4qn9B70wPgvDDL6JVy5lSgkqTN8WicTSbesESsJv8eJZ1m
	9/IVyNQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7LmJ-0000000Cx2A-3RII;
	Thu, 17 Sep 2026 23:44:31 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7LmH-0000000Cx1X-0tZ5
	for kexec@bombadil.infradead.org;
	Thu, 17 Sep 2026 23:44:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u0O1lZsSl6FgDJ9eTYr2jlFm3jSIkWmZkODdW+Q8s2I=; b=o+gaQDAjXeBda5ZFrXQM0I2ZyJ
	Hn33o7rMXdoYylXO91aCG+7e4y+gA9i9N6ly8ENLIPRJEPw51L1jq5t8mmEW4n5q/98iqmsWUKPnc
	x4zzvKIbIB76IMy7kcD60j7rK5naEiyjErSpRIj8pf7jm9523chhXASCLSKPrkt2c2PJ5XVH7mhd/
	Daz+kDnsc56Cdnt4l5gXcoWgad6NCiTbxeYTJbQ5ces/D+6ygqWQUCJEGjx0r0SY/rInDCmhSnBUN
	Bomtz3JaIUXSiBhNvFDtSiHHfiwfTpss/CNKv2+g2X/xR1zysKGMXbyDIphGIGYGJywbw/LZACR1x
	e5ZBsNLA==;
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x7LmD-00000009OHD-1kZN
	for kexec@lists.infradead.org;
	Thu, 17 Sep 2026 23:44:28 +0000
Received: by mail-pj2-x11.google.com with SMTP id d9443c01a7336-2d8fbef5018so2100055ad.0
        for <kexec@lists.infradead.org>; Thu, 17 Sep 2026 16:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789688663; x=1790293463; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u0O1lZsSl6FgDJ9eTYr2jlFm3jSIkWmZkODdW+Q8s2I=;
        b=dsa8JDtIijNCe3jgyHtnLc/sOH2BuwEN/1q+35U+LGFEK4x27SFbymCL8J525OhdcM
         TXSmLBcqCowoPcRiW95UqYcomD+/54IP0jy0voaGItyaiZsxnWCYTTFv/GrTgWTfcGIV
         GgW+GGQxOLhy8OQFGGJ+BNW68OhTsQ2BkaxfiGKmhXee/eZa8M9M1S3IezubE/c6iSyB
         qLuzVTAmJ+T0bZxM6A6WVo0XzJxzmthzAg60GgxAN5Di5O5khv2OjShOJEW0EMoG1hyR
         k6R9dZHz9fvwHhgQh2ZWW6CWkzqaEviJVeA2iGYTj3Fa1k/dfw3m5dhwdOI7FDZdn32G
         KAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789688663; x=1790293463;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u0O1lZsSl6FgDJ9eTYr2jlFm3jSIkWmZkODdW+Q8s2I=;
        b=fevxUv+PhOwfWRiW3YntSvqwIHldma+t/XZyRVIBCF562QfcHy7z4E0DZqSQFn7ByS
         qVc+iQu13bKxyu03fbPBrDyzmZksFuixVvveCsmrytuOLk3R+ahLgFs5F1ao4K870Mc2
         AqbDh0ouDW8sS/EHQDQJdcG3jTABqr5ts3tbMyFJg6FAZCqKWgrg3KlnrVFcksoV8C4u
         wnIGHkD00UBc6Wlo/GMBGrDSPWGM0PawqYf1UDAzrOi9E/W12jn3h3LxSpukjJycaLbN
         zLZQRCWaz7ET54Pq8KDvFdsGRzEA3uNJzqKqDySa/AoGoEMnPa48RiL36rS4jkphs7iw
         vwwg==
X-Gm-Message-State: AFuF++mH84f7Yj7/I6atUbbJ2B+7OaR2eBQpTntrWKZ55KqkzwsO+64Q
	hXF9ETFQ4sIF3vxmtCaEQpOCHr21ECvwjN1l/SG9Rs1Bwjn02CvCjuMTZaHz1OoNAg==
X-Gm-Gg: AYBFou2whZOQkn5HaWunpBwGHzDW4O7EOYwaUlloYuGztFRlXIGizQgFcmvM0ob4ha+
	GSb68wWpTNx+lI4cwQnKZL24lRSJ1ah3f2Gr/14kn+aE3ogjyLCfIEbJDzShhdEPnK+3xgk29/6
	tOdLniu1fFHuySDO1JTU951QAJOuO72mTezuuhmyxhXJLs8vYgfHwEDMg6p2T2BMD+TM6nnBgpx
	Ik29fXDQtuKPh3gaASKcfmKrn7aPrJaH6zB+IygTf71ganqI4NuCIj0aDlDlVxDeaksvuI7KmlM
	poprvarFYjXj4eGGDuLxOw7AF7I2Kim7GIEUXbQpfPYFjxxDcCWO3wyxkLpc3x+qi9sFTMObI6i
	hLuZW7Wr6AjEK88urZSNatBJ/Nb2psUqmEYW7a1fAJWvvt7G2uT2gU4bt4gm7guKmszd9S2Ulif
	LE77PXTmT/iHC/4WBcF2zQA8o7Z1G+S+tZtwH4hz8O1pZjmiefdJl+GdHCxqQiYbkIQ0SSyzyRP
	DLRKxcAHNube5NdN5BqdqAPz5/9Ytz33udKFpCiT446lvNEnVY=
X-Received: by 2002:a17:90b:2ecb:b0:39e:4c81:6c9a with SMTP id 98e67ed59e1d1-39e54fafb06mr1575707a91.32.1789688662542;
        Thu, 17 Sep 2026 16:44:22 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e535f0421sm443246a91.1.2026.09.17.16.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 16:44:21 -0700 (PDT)
Date: Thu, 17 Sep 2026 23:44:17 +0000
From: David Matlack <dmatlack@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <aqx7USJxZrk9GIWm@google.com>
References: <20260728221007.2098560-7-dmatlack@google.com>
 <20260917000723.GA992337@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917000723.GA992337@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_004425_608335_D0453D14 
X-CRM114-Status: GOOD (  29.43  )
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

On 2026-09-16 07:07 PM, Bjorn Helgaas wrote:
> On Tue, Jul 28, 2026 at 10:10:00PM +0000, David Matlack wrote:
> > When a PCI device is preserved across a Live Update, all of its upstream
> > bridges up to the root port must also be preserved. This enables the PCI
> > core and any drivers bound to the bridges to manage bridges correctly
> > across a Live Update.
> > 
> > Notably, this will be used in subsequent commits to ensure that
> > preserved devices can continue performing memory transactions without a
> > disruption or change in routing.
> > 
> > To preserve bridges, the PCI core tracks the number of downstream
> > devices preserved under each bridge using a reference count in struct
> > pci_dev_ser. This allows a bridge to remain preserved until all its
> > downstream preserved devices are unpreserved or finish their
> > participation in the Live Update.
> > ...
> 
> > +static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
> > +					    struct pci_dev *dev)
> >  {
> >  	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
> >  
> >  	if (!dev_ser) {
> >  		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
> > -		return;
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!dev_ser->refcount) {
> > +		pci_WARN(dev, 1, "Preserved device has a 0 refcount!\n");
> > +		return -EINVAL;
> >  	}
> >  
> > +	if (--dev_ser->refcount)
> > +		return 0;
> 
> I guess this is a nit: I was looking for a dev_ser->refcount++ in this
> patch to correspond with this decrement.  I *guess* the
> "dev_ser->refcount = 1" in pci_liveupdate_preserve_device() starts
> that, and the "dev->liveupdate.outgoing->refcount++" there is an
> increment of the same refcount?  The connections there don't seem
> quite obvious to me.
> 
> But I guess "dev_ser->refcount = 1" was added by a different patch, so
> probably *not* the same?

As mentioned in the other reply I can combine refcount=1 and refcount++
into a single refcount++ to make this simpler.

The refcount=1 is for when a device is first preserved. refcount++ is
for when a device is preserved a subsequent time. Bridges are the only
devices that can have a refcount > 1 so that's why this patch introduces
the refcount++.

> 
> >  	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
> >  	outgoing->ser->nr_devices--;
> >  	memset(dev_ser, 0, sizeof(*dev_ser));
> >  	dev->liveupdate.outgoing = NULL;
> > +	return 0;
> > +}
> 
> > @@ -385,13 +418,23 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
> >  	}
> >  
> >  	if (dev->liveupdate.outgoing) {
> > -		pci_warn(dev, "Device is already preserved\n");
> > -		return -EBUSY;
> > -	}
> > +		if (!dev->liveupdate.outgoing->refcount) {
> > +			pci_WARN(dev, 1, "Preserved device with 0 refcount!\n");
> > +			return -EINVAL;
> > +		}
> >  
> > -	if (!pci_is_root_bus(dev->bus)) {
> > -		pci_warn(dev, "Cannot preserve devices behind bridges\n");
> > -		return -EINVAL;
> > +		/*
> > +		 * Endpoint devices should not be preserved more than once.
> > +		 * Bridges are preserved once for every downstream device that
> > +		 * is preserved.
> > +		 */
> > +		if (!dev->subordinate) {
> > +			pci_warn(dev, "Device is already preserved\n");
> > +			return -EBUSY;
> > +		}
> > +
> > +		dev->liveupdate.outgoing->refcount++;
> > +		return 0;
> >  	}
> >  
> >  	dev_ser = pci_flb_alloc_dev_ser(outgoing);

