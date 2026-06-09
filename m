Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3748CD8CAD
	for <kexec@archiver.kernel.org>; Tue,  9 Jun 2026 10:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zdMxQIDs+l/KSPJFUNCwvqWbxtsN9baWYoGyb/P1vPg=; b=OgLmTXRuGP7TSEbkNha7pUjLHe
	cPiuiBtwqoBWT6+U5N7H4Aa+QbmCJacwtz6aHEs5ugKjl+pzpOIWX+VCRbqBXl+sdqW+aH61dJu0Q
	xz/P7IcO+eZRf83Vqj7myHRb/VWBAT0ONyX5sXSBBnshe1bezYcvBX2oXJegNV0n3KqJdCbnKfpnd
	D5jOAiqSvBM5ORzSxi49I5s9aTXhwZN3U56Cy1IIOclGk/zcd0gIKgVVvqfAca033MMbNxk5fOIj4
	bhDcT60WwktYPzO59fWZ08Lo1UCJeeS9765Fh3vtUcQjWQcyrzbYxcdbl/GEymr/A+tVlwvCP8XM+
	DT4OzYpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWu7z-00000005Ono-2YOL;
	Tue, 09 Jun 2026 10:56:15 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWu7w-00000005Omv-1k7M
	for kexec@lists.infradead.org;
	Tue, 09 Jun 2026 10:56:13 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2bf2d865383so434935ad.1
        for <kexec@lists.infradead.org>; Tue, 09 Jun 2026 03:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781002571; x=1781607371; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zdMxQIDs+l/KSPJFUNCwvqWbxtsN9baWYoGyb/P1vPg=;
        b=fmLBX7fa5roGJjqZeywnAjpipFXMHapgNcM0KuwMxOIfevQHgiAREhqZe15tKqGYVP
         9mRi34rj/o0CSbCnSJnCtegTTrPwqgyisdSpPVx+CuiYuyBC4VqbDRCo2JGfbajZmjbr
         vJmLVzxOC4FRLeWSImWWbgsu0fWIoX4mPZSEjLXVPFqfPpJFSBxx+JLbj5f6o8HD3oFO
         3QxtLBlgi0IV37xrQtj4u8D1S5/4hi9FBJV8YdhM0ieb0wrObB2LwvaubZSLTvOkwHCG
         YyalXe47/ptGwVDiGct/6OIVzWdfnH575/k6QANChVY4jV8Ts87Ejtg9prZoZ2r1dVpT
         FvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781002571; x=1781607371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdMxQIDs+l/KSPJFUNCwvqWbxtsN9baWYoGyb/P1vPg=;
        b=Fc0/jOV97FxTijE32HABHrWFrvdoKSpA/CEB/aJwYKwx/ephGNX8SrQMeTx3j1eYyJ
         pWUvxHUjmQpDKT2l8N58wD/ND6MwT5sydevfrUQIIkSjZiTaJVvID0xXMdqRSw/b0jyk
         7P9cBIEPqycGVdoK4eryTaOtHBmT0LKSqPpVwhn2zblyBjXc2YgqnegaO20wyB/y1ZHI
         QsknnfWQQuvXbo0XEONAb65B5YosPne0XKneBDvjNEJ6N0YrDcjCeww/ZcQrc22FcPXB
         SUR4ulKRiXYynJfnJ9u0nv03HkxpP6AxfyqbecVVeXQj7IsvIuCcH83aaIPgyVCnT4kf
         vg0Q==
X-Gm-Message-State: AOJu0Yza9+lomgvcNtlxbFbHIg8L5mfXaujBuQZaFw8zlqQoHqBSH+L/
	ndge/1/XV3XWHdHrNvDm0qKUZwOFNHdINT5+zeqQkbb47xJ04VQMJFPEX3Z/HGRQYg==
X-Gm-Gg: Acq92OEmGeyP14Oznw8S98uGmtSVgkUazcS0Wbr7LL2SgF3Au54QQ0ahdJzH6Sal591
	KdoakoPBPF7/AAl/BydNfSJmsAChmLP9/K1OCdNlHNxhT7C1yP/gkawHQ9ekGA5dhaQitXO96rP
	o2m2AicF1v2ICFpdzzu4iaLdg9c+Q7Lha9i6lkASJHiYnnNehr0nZBVmmBE876+FHR+cb6sCgxl
	YMiPEvVd5zHxFvaGEJtayqCbglXcz72RzyB260/KijjW04xCGTVQlcEG/nnLcrrAD1x7pr9Ommq
	X2jL10nOCHcyWvGNGfwQFdTlkR5RF8CM2kRryLmjAecjP2HU8TmCut3sy8tSOPoykZKmjzkwfW+
	aVbznoGsTaNyB3UTD9CWpXXArMqdIfOrUIxL4vO4KM8b9i68hdFHKLKY7cXXOUvb5n1PC5D7u1x
	Km6D+ZwdS1U7fSsZ+x8odmwrYFArK5i+8I9oVKFn0neUMvlD2qWzpbMG4Q71PJpUN9HuDcEmI=
X-Received: by 2002:a17:902:f708:b0:2c1:ee6e:be23 with SMTP id d9443c01a7336-2c1ee6ec5ebmr6732565ad.33.1781002570788;
        Tue, 09 Jun 2026 03:56:10 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f711e52b0sm19480623a91.15.2026.06.09.03.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:56:10 -0700 (PDT)
Date: Tue, 9 Jun 2026 10:56:01 +0000
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
Subject: Re: [PATCH v6 07/12] PCI: Refactor matching logic for pci_dev_acs_ops
Message-ID: <aifxQalxwM_hic6F@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-8-dmatlack@google.com>
 <aiW_M7y0fFwLN84G@google.com>
 <aic46OtIKfLhdoKy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aic46OtIKfLhdoKy@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_035612_459334_B5B26183 
X-CRM114-Status: GOOD (  28.96  )
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

On Mon, Jun 08, 2026 at 09:49:28PM +0000, David Matlack wrote:
> On 2026-06-07 07:01 PM, Pranjal Shrivastava wrote:
> > On Fri, May 22, 2026 at 08:24:05PM +0000, David Matlack wrote:
> > > Refactor the logic to match devices to pci_dev_acs_ops by factoring out
> > > the loop and device matching into its own routine. This eliminates some
> > > duplicate code between pci_dev_specific_enable_acs() and
> > > pci_dev_specific_disable_acs_redir(), and will also be used in a
> > > subsequent commit to check if a device requires device-specific
> > > enable_acs() during a Live Update.
> > > 
> > > No functional change intended.
> > > 
> > > Signed-off-by: David Matlack <dmatlack@google.com>
> > > ---
> > >  drivers/pci/quirks.c | 50 ++++++++++++++++++--------------------------
> > >  1 file changed, 20 insertions(+), 30 deletions(-)
> > > 
> > 
> > [...]
> > 
> > >  } pci_dev_acs_ops[] = {
> > >  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
> > > +	    .match = pci_quirk_intel_pch_acs_match,
> > >  	    .enable_acs = pci_quirk_enable_intel_pch_acs,
> > >  	},
> > >  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
> > > +	    .match = pci_quirk_intel_spt_pch_acs_match,
> > >  	    .enable_acs = pci_quirk_enable_intel_spt_pch_acs,
> > >  	    .disable_acs_redir = pci_quirk_disable_intel_spt_pch_acs_redir,
> > >  	},
> > >  };
> > >  
> > > -int pci_dev_specific_enable_acs(struct pci_dev *dev)
> > > +static const struct pci_dev_acs_ops *pci_dev_acs_ops_get(struct pci_dev *dev)
> > >  {
> > >  	const struct pci_dev_acs_ops *p;
> > > -	int i, ret;
> > > +	int i;
> > >  
> > >  	for (i = 0; i < ARRAY_SIZE(pci_dev_acs_ops); i++) {
> > >  		p = &pci_dev_acs_ops[i];
> > > @@ -5481,33 +5475,29 @@ int pci_dev_specific_enable_acs(struct pci_dev *dev)
> > >  		     p->vendor == (u16)PCI_ANY_ID) &&
> > >  		    (p->device == dev->device ||
> > >  		     p->device == (u16)PCI_ANY_ID) &&
> > > -		    p->enable_acs) {
> > > -			ret = p->enable_acs(dev);
> > > -			if (ret >= 0)
> > > -				return ret;
> > > -		}
> > > +		    p->match(dev))
> > > +			return p;
> > 
> > Nit:
> > Should we check if (p->match != NULL) like we check for p->enable_acs &
> > p->disable_acs_redir(). 
> > 
> > Otherwise, it seems like we're mandating the existence of a match op in
> > the pci_dev_acs_ops here? Today, we just have two Intel entries in that
> > array, both of which need the match op. However, AFAICT, it shouldn't be
> > mandatory for future SoCs that might only need a simple vid + devid match
> 
> *shrug*
> 
> I would usually say those future SoCs should be the ones to make it
> optional if and when they need to.

Well.. that's fair I guess.

> 
> But making p->matc optional now isn't so bad:
> 
>         for (i = 0; i < ARRAY_SIZE(pci_dev_acs_ops); i++) {
>                 p = &pci_dev_acs_ops[i];
>                 if ((p->vendor == dev->vendor ||
>                      p->vendor == (u16)PCI_ANY_ID) &&
>                     (p->device == dev->device ||
> -                    p->device == (u16)PCI_ANY_ID) &&
> -                   p->enable_acs) {
> -                       ret = p->enable_acs(dev);
> -                       if (ret >= 0)
> -                               return ret;
> +                    p->device == (u16)PCI_ANY_ID)) {
> +                       if (!p->match || p->match(dev))
> +                               return p;
>                 }
>         }
> 
> I can include this in v7 if you would like.

I don't have a strong opinion here, this should be fine.
It's just that we have NULL checks for p->enable_acs and 
disable_acs_redir too. It'd be nice to keep the same pattern.

Thanks,
Praan

