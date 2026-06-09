Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D6CCD8CAA
	for <kexec@archiver.kernel.org>; Tue,  9 Jun 2026 11:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OIwRB/fzX43FvZDy8zd3F8cYltlmCTKmqxv8mTl/pb8=; b=EOpGA48/v8lZJgXKiHlfds8Ryp
	38beyDe9t5dfId52EGUIPw7iB/CRVn7pr+TvtiYqhWRZ2wwa8kE+yVZoRxiNC4ScQVurTHtUf9H6+
	6gHNUtIPPfAE31l6hDuTndmWHR0er3fPoaTgazdVwNGysnNk/NYFgiYJh9qSpZBRcaXhqRn5VSGEi
	015LAclS0jyjkz+6anzTJd87aPQep951muxneiNzEnhZWxabOUPWNebHyIID64G9o8jG1Wys2nTts
	ooGKTTMt63gLMrydRSjVbZPMaru0O+gbhSx66MQTCfZwjOBoaH6M7LzraqkpWYd83Dgyf5qeD9yJi
	U8/58d+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWuQO-00000005QZe-2qTX;
	Tue, 09 Jun 2026 11:15:16 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWuQL-00000005QZ8-3n5o
	for kexec@lists.infradead.org;
	Tue, 09 Jun 2026 11:15:15 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2c0b1a48855so497925ad.0
        for <kexec@lists.infradead.org>; Tue, 09 Jun 2026 04:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781003713; x=1781608513; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OIwRB/fzX43FvZDy8zd3F8cYltlmCTKmqxv8mTl/pb8=;
        b=FxQT4ZSIqUqcAlztIvdz+PVS5XihBzVD3W7VOfZjaj7vyIn0OvRQ6S6nFjih7d0MlZ
         x+IG+aHt/5DkoyBX8tQY+60LYY0lGhPMmKq+q419UE45A7Ihh4LnHdDs84H9+poDdzcm
         mt4PBVH9Y2MLI2XjTHNKzMDGFaot/jpyji9NyDZuIhM0bX9BTgnTYBCIaVjz1YWoO4Fh
         MzCehqOdBPkJUoblT9dADrDZcWEx0CmJeZRHzyrqmyY3W1VzDoXWlYKV9Fl7raviZZi/
         kVmTXeiEaeVRI2CWM/dUYw32Q4qG73fcmA/lQq/V3u/ouXPdwYSjBZTScxN7sfUMmsgE
         32vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781003713; x=1781608513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIwRB/fzX43FvZDy8zd3F8cYltlmCTKmqxv8mTl/pb8=;
        b=dICKOzmsOYwdayYJqIZbfD4S8MZUKgqzouZAzVmUlT/crswIsT+z7RaxLcZUsAtRBP
         oPQO1GnWYU4+jTa4xPt9VXn/h6i9EWgG6ed9Guwo0pFA1lTHlejYjgHGkSmMVg5ddGmp
         qXb1lV3kqJxlbJCFUV9csylDYgjTk1Nv0GQ4gNnawTu7VmEJmmrrqwiZei5+FKEPL2e5
         k3USEE43DAkvYPhLgGiMhrpBLCrPvQ+QgkP93xLyf0ljefUmkPGDpqKB5f8rdHcnfHVm
         rEZixcFt+FwECJEH/A21xlWUKTV/1iCvN15zfJueWk6+8gG9myXM2zw6N2h3mzHzXTCY
         cXaw==
X-Gm-Message-State: AOJu0YwDFEKsvxzWm9CQ7TL+PxDgLv5IjlvS4MjmjP+Qk45Fvnr6Wx6V
	GVGAR28uIdTpvs0CSVBhgWlOSU2F7SR5xq5nn2xFja36q4Kmdhiry1jtxIZO1rL3ow==
X-Gm-Gg: Acq92OHUuMLHs7fxT5HrNmJQhpPOGvE94jeVC4pnGXXDs8FFamxf6RcdM56Hfmtrs2X
	Z7c39I7E/gZJPft9jHYj+iogHcMrUukZ/hm/wYoZkAsBiXaoCVJVGxMnN9oKsiT1fr0RDua4vaV
	v74TsNxvSswwMgaq67+Qo6j41vaq3tNGQZ/gSvGj3HTmDC1km1lXbq0WRdCiZOEcYrprlQBM4Mp
	MIUNtPJOhRFDPFEEx2pcm7xlKPWCRb5Mw9FuiuNjVOEtPBEAgrUJF40OubFIP0sgKgvZAiNjdA/
	ypRGxXa+RaoJ/RfKkV7OTYg9gXwCWJoEwL9LNPoS2plPv7xoqHUszcz1eJ46WVy19higFpuG3zk
	Jf02qy8KsQTp29N5RHdb7Mfw7PO3zSCwzPSSPgWZ7I4QaeuRVqgM02A6uKod+LF4dqELQOXJ9R5
	RtaIL+gJDPzWVJafeXzygMUArS09YcwwJzQofeQB08ndyUgsaC6uWM8Shl+24VomIOO/YjW1I=
X-Received: by 2002:a17:902:ffce:b0:2c2:50c7:5894 with SMTP id d9443c01a7336-2c250c75a1dmr4219375ad.24.1781003712132;
        Tue, 09 Jun 2026 04:15:12 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6d109dcdsm21430052a91.9.2026.06.09.04.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:15:11 -0700 (PDT)
Date: Tue, 9 Jun 2026 11:15:02 +0000
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
Subject: Re: [PATCH v6 06/12] PCI: liveupdate: Auto-preserve upstream bridges
 across Live Update
Message-ID: <aif1tq8TvHuYwUC-@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-7-dmatlack@google.com>
 <aiSb85Ec6jW4xPaE@google.com>
 <aic1gdmisIT4sqEN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aic1gdmisIT4sqEN@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_041513_951320_F46737DB 
X-CRM114-Status: GOOD (  39.58  )
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

On Mon, Jun 08, 2026 at 09:34:57PM +0000, David Matlack wrote:
> On 2026-06-06 10:15 PM, Pranjal Shrivastava wrote:
> > On Fri, May 22, 2026 at 08:24:04PM +0000, David Matlack wrote:
> > > When a PCI device is preserved across a Live Update, all of its upstream
> > > bridges up to the root port must also be preserved. This enables the PCI
> > > core and any drivers bound to the bridges to manage bridges correctly
> > > across a Live Update.
> > > 
> > > Notably, this will be used in subsequent commits to ensure that
> > > preserved devices can continue performing memory transactions without a
> > > disruption or change in routing.
> > > 
> > > To preserve bridges, the PCI core tracks the number of downstream
> > > devices preserved under each bridge using a reference count in struct
> > > pci_dev_ser. This allows a bridge to remain preserved until all its
> > > downstream preserved devices are unpreserved or finish their
> > > participation in the Live Update.
> > > 
> > > Signed-off-by: David Matlack <dmatlack@google.com>
> > > ---
> > >  drivers/pci/liveupdate.c    | 136 +++++++++++++++++++++++++++++++-----
> > >  include/linux/kho/abi/pci.h |   5 +-
> > >  2 files changed, 122 insertions(+), 19 deletions(-)
> > > 
> > 
> > [...]
> > 
> > > +
> > > +#define for_each_pci_dev_in_path(_d, _start, _end) \
> > > +	for ((_d) = (_start); (_d) != (_end); (_d) = (_d)->bus->self)
> > > +
> > > +static void __pci_liveupdate_unpreserve_path(struct pci_ser *ser,
> > > +					     struct pci_dev *start,
> > > +					     struct pci_dev *end)
> > > +{
> > > +	struct pci_dev *dev;
> > > +
> > > +	for_each_pci_dev_in_path(dev, start, end) {
> > > +		if (pci_liveupdate_unpreserve_device(ser, dev))
> > 
> > I might be reading this wrong but are we leaking some upstream devs if 
> > an intermediate node fails?
> > 
> > 			  EP0
> > 			/
> > Assume we have: RC -> B1 -> B2 
> > 				\
> > 				 EP1
> > 
> > and EP0 & EP1 were preserved successfully.
> > 
> > And then we try unpreserving EP1, we follow:
> > 
> > unpreserve EP1 -> unpreserve B2 failed due to a corruption.
> > 
> > This aborts the loop, skipping B1 and RC completely?
> > Their refcounts remain elevated, effectively leaking them as preserved 
> > state permanently? (i.e. if we unpreserve EP0 after this, B1 & RC will
> > still get preserved).
> 
> Yes, but that would only happen if there is some sort of kernel bug or
> silent data corruption. I guess we could proceed with trying to
> unpreserve the bridges upstream. But I opted to log a big warning and
> bail immediately.
> 
> pci_liveupdate_finish_path() has the same behavior BTW.

Fair point. I agree we are in a broken state if we hit this. 

I was originally thinking of a situation where we'd want to keep the
failure localized. For example: unpreserve EP1 fails -> user sees the
warning -> resets EP1 -> retries preserving it later. 

But given the recent discussion/decision that retrieve operations
will no longer be retried, I guess there isn't really a use-case for
retrying anything. It makes sense to just bail here.

> 
> > 
> > > +			return;
> > > +	}
> > > +}
> > > +
> > > +static void pci_liveupdate_unpreserve_path(struct pci_ser *ser,
> > > +					   struct pci_dev *start)
> > > +{
> > > +	__pci_liveupdate_unpreserve_path(ser, start, /*end=*/NULL);
> > > +}
> > > +
> > > +static int pci_liveupdate_preserve_path(struct pci_ser *ser,
> > > +					struct pci_dev *start)
> > > +{
> > > +	struct pci_dev *dev;
> > > +	int ret;
> > > +
> > > +	for_each_pci_dev_in_path(dev, start, NULL) {
> > > +		ret = pci_liveupdate_preserve_device(ser, dev);
> > > +		if (ret) {
> > > +			__pci_liveupdate_unpreserve_path(ser, start, dev);
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  /**
> > >   * pci_liveupdate_preserve() - Preserve a PCI device across Live Update
> > >   * @dev: The PCI device to preserve.
> > > @@ -321,6 +403,9 @@ static int pci_liveupdate_preserve_device(struct pci_ser *ser, struct pci_dev *d
> > >   * pci_liveupdate_preserve() from their struct liveupdate_file_handler
> > >   * preserve() callback to ensure the outgoing struct pci_ser is already set up.
> > >   *
> > > + * pci_liveupdate_preserve() automatically preserves all bridges upstream of
> > > + * @dev.
> > > + *
> > >   * Returns: 0 on success, <0 on failure.
> > >   */
> > >  int pci_liveupdate_preserve(struct pci_dev *dev)
> > > @@ -336,7 +421,7 @@ int pci_liveupdate_preserve(struct pci_dev *dev)
> > >  	if (IS_ERR(ser))
> > >  		return PTR_ERR(ser);
> > >  
> > > -	return pci_liveupdate_preserve_device(ser, dev);
> > > +	return pci_liveupdate_preserve_path(ser, dev);
> > 
> > Minor nit: I might be too nitpicky here (and it's NOT a strong opinion)
> > but naming it pci_liveupdate_preserve_path_for_dev() reads better to me.
> 
> Noted :). I'll keep the current name for now since that is pretty long,
> but if anyone else votes for it I'm happy to be overridden.

Sounds good.

Thanks,
Praan

