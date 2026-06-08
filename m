Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021ADCD6E79
	for <kexec@archiver.kernel.org>; Mon,  8 Jun 2026 21:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sXXyfmnFaXTXjgYYiyfgw2DtQ2NRAhcXZrd2mOcuVWY=; b=0JDvb1rzCb6hXwoPFEuAFAuNMJ
	8ioIGYp8fA8Yi3Uh160kNGZLcLAZMFl3IIy4btZzg8Vhk4gbto0PsnVl+0eqMzTmkLiHT15zvripy
	L6m3ws+7RMYrgZqyOWARNl4191AFyJiOYvaW2dlvMtWQaIjrMkAzrnE8V7jnPy3fBBXNcTNvLdTme
	FXhzTtRfmiqM1KlTJMqe/I3o0+2xepvVlRDRsSOW+/On+gJQUS/m/SM1ZyRYFErmJiv9r/VmS/M/G
	7blqgqnlNKpD2ioR+ccuYm4nA9YeqUmWrc4kvVb0iW9k7bVi/kYrKCo9pLvkeitkXhuH/pzmd6JNI
	MoXhRL2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWhxf-00000004SpW-3G98;
	Mon, 08 Jun 2026 21:56:47 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWhxe-00000004Sor-1K6x
	for kexec@lists.infradead.org;
	Mon, 08 Jun 2026 21:56:47 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2c0c32f6ce1so32489715ad.2
        for <kexec@lists.infradead.org>; Mon, 08 Jun 2026 14:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780955805; x=1781560605; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sXXyfmnFaXTXjgYYiyfgw2DtQ2NRAhcXZrd2mOcuVWY=;
        b=mkaCpcAs8TC7wXORZWguyB2cE7pZKETxYBSr3cTP0aaC1soCLdi57Z66ZxXzUpraPZ
         nf2t2l+gPKd8Z55zA7zgxUW53cNUA9Qx4tfFZUHJgxVS4NFvVHq5HGf6beuY52/sHB4Y
         6And7QxWy6EiiZjcmnVTGnJx+p+5eBnHbB5rOJxRuBD+sZqfjV4L85gI2Nu14ED9sbWj
         7FdOxSFGYxSAt6BZuoqCjc6LO2VS/zkcOoqDjIHVQpaVqLCtfMQ5319MSXejJd5oKyRA
         hJCLc337eki0EvQSqCgMfLxnryEOdVDCc93W9RTGnITpkkyWRStfbgRM5fNMqqQWdR4Z
         45Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780955805; x=1781560605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXXyfmnFaXTXjgYYiyfgw2DtQ2NRAhcXZrd2mOcuVWY=;
        b=RtOHFj7he46npb2BYcBtOJjFz7xKJ60yJ2Hg1SxEMdxPy4bFZmYAtge3Q66zFCWg4E
         jQW9DFBhYiZJxtIoeVp16k+JYXr8uDOHhh7sbIaCugIqnFtN1+UsDWx7zPLeVnZdxVxS
         mhQ2DIV9C2ay4pEVL/LGqTLCtYg78iGCjHEroP2M+Tv1gX6a+zJkj1F/I8dmOlB+AEGQ
         wxECJc98ov3cy4yzCqzdb+vCwJT6cp5ALzVBhF8dVQyjFNs9ANDWnhV9I+ADX7rOKlIn
         oW/sGb8sxGra4A2m7T6TKAmvFkqijaFpts/IHG5rtFH5+NZYEtAMF4FrVoeNvy4tRy4Z
         B3qA==
X-Gm-Message-State: AOJu0YztksSD4aszGRf24QTKDeAOZeupAFJQBmwm9NPATye2QVuD+yV2
	YJjeMQwUQO0wsDlrWXLvzZbIFLGd2UdfM8yVxBdbVFz7urmURsPsSUBw7HOjHvwE4Q==
X-Gm-Gg: Acq92OFUpuPEyCzUq4shAGL18mYKENSBu3c0my9AIhRQB1/G81XXw05Khzx1MgkTUTM
	nK92hegLO2SvsSP1h3M/hizNd33SUGSxFOPQOLN6hiwpOQ0XwYSFJPPN6tBLGJ2wAog57bFIakc
	IYkxTLebs01BJKNfhpfMCQ7zy+lbpdPZOtTUcaZr2zN0dZlAGPoMFSOR3ClPXKe4IhpinRt0021
	zwdZ9u/xFDGDYqeJLeze/TVgH4vCZ3XCIGpT8qIRPQvHBxngD0Y2GTuUAKlGSDF6cZMhNoHzByr
	aaCdq5/v8dcx3vV7El4cycBlLVCVeNjwmEveEksaLiMZCZ5GvthWhWHjs6+c6TOIQJomuEIaDCD
	bLGlR1wJBmGpWmJ+zp31JCaOcmuYg56Bhnq/gjTsQIHWXMYIbdEQYxEZ3KI6g4D7DOGNAPhoga9
	D+nu4GW2k43IAtPJPGzCjSs83AV/20r1mMLry1LnZOtcGgK9VMJMs6ndSL4tOpGWXQD+RcjQn7
X-Received: by 2002:a17:902:f542:b0:2c0:ab82:6bb8 with SMTP id d9443c01a7336-2c1e80cfb97mr203347285ad.27.1780955804952;
        Mon, 08 Jun 2026 14:56:44 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649d2d4sm177346225ad.77.2026.06.08.14.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:56:44 -0700 (PDT)
Date: Mon, 8 Jun 2026 21:56:41 +0000
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
Subject: Re: [PATCH v6 08/12] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
Message-ID: <aic6mdiZ0qUJpFca@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-9-dmatlack@google.com>
 <aiXWmR-ettxin4LC@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiXWmR-ettxin4LC@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_145646_356659_CC271DC4 
X-CRM114-Status: GOOD (  31.34  )
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

On 2026-06-07 08:37 PM, Pranjal Shrivastava wrote:
> On Fri, May 22, 2026 at 08:24:06PM +0000, David Matlack wrote:
> > Inherit Access Control Services (ACS) flags on all incoming preserved
> > devices (endpoints and upstream bridges) during a Live Update.
> > 
> > Inheriting ACS flags avoids changing routing rules while memory
> > transactions are in flight from preserved devices. This is also strictly
> > necessary to ensure that IOMMU group assignments do not change across
> > a Live Update for preserved devices, as changing ACS configurations can
> > split or merge IOMMU groups.
> > 
> > Cache the inherited ACS controls established by the previous kernel in
> > struct pci_dev so that ACS controls do not change after a reset
> > (pci_restore_state() calls pci_enable_acs()).
> > 
> > To simplify ACS inheritance, reject preserving any devices that require
> > quirks to enable ACS as those quirks would also have to take Live Update
> > into account.
> > 
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> >  drivers/pci/liveupdate.c       | 68 ++++++++++++++++++++++++++++++++++
> >  drivers/pci/liveupdate.h       | 11 ++++++
> >  drivers/pci/pci.c              |  5 +++
> >  drivers/pci/pci.h              |  5 +++
> >  drivers/pci/quirks.c           |  7 ++++
> >  include/linux/pci_liveupdate.h |  6 +++
> >  6 files changed, 102 insertions(+)
> > 
> 
> [...]
> 
> >  
> > +void pci_liveupdate_init_acs(struct pci_dev *dev)
> > +{
> > +	guard(rwsem_read)(&pci_liveupdate.rwsem);
> > +
> > +	if (!dev->acs_cap || !dev->liveupdate.incoming)
> > +		return;
> > +
> > +	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &dev->liveupdate.acs_ctrl);
> 
> I might be thinking out loud here, but as an attacker, this motivates me
> to somehow hack the EP FW to mis-report the PCI_ACS_CTRL register across
> a liveupdate to fool the incoming kernel. If the FW feeds a 0, it silently
> strips ACS protections.
> 
> Should we also serialize ACS state in ser somehow to ensure we aren't 
> fooled by something like this?

What does "EP FW" mean?

Does such an attacker even need Live Update to attack the system? It
seems like such an attacker could route TLPs in whatever malicious way
they want regardless of Live Update.

> 
> > +}
> > +
> > +int pci_liveupdate_enable_acs(struct pci_dev *dev)
> > +{
> > +	u16 acs_ctrl = dev->liveupdate.acs_ctrl;
> > +	u16 acs_cap = dev->acs_cap;
> > +
> > +	/*
> > +	 * Use liveupdate.was_preserved instead of liveupdate.incoming since the
> > +	 * device's ACS controls should not change even after the device is
> > +	 * finished participating in the Live Update.
> > +	 */
> > +	if (!dev->liveupdate.was_preserved)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * The previous kernel should not have preserved any devices that
> > +	 * require device-specific quirks to enable ACS, but if such a device is
> > +	 * detected, log a big warning and fall back to the normal enable ACS
> > +	 * path.
> > +	 */
> 
> Nit: It might be worth adding a note here that this can also happen if a
> new device-specific ACS quirk is introduced in the incoming kernel for a
> device that was preserved by the old kernel (which didn't have the quirk).
> In such cases, the two kernels are essentially non-LUO-compatible..

Yes will do.

> 
> > +	if (pci_need_dev_specific_enable_acs(dev)) {
> > +		pci_warn(dev, "Device-specific quirk required to enable ACS!\n");
> > +		WARN_ON_ONCE(true);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (acs_cap)
> > +		pci_write_config_word(dev, acs_cap + PCI_ACS_CTRL, acs_ctrl);
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
> >   * @dev: The PCI device to check
> 
> [...]
> 
> Thanks,
> Praan

