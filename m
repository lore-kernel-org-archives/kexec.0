Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DAACD8CA7
	for <kexec@archiver.kernel.org>; Mon,  8 Jun 2026 21:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mok13K1oI/5oKqM9t1zh4zoQDrWvB1QlqYCZOP0VV4Q=; b=P9bC4pMbDTMm7RyeXqpe8PVDLf
	1wQ9mOhFd8crwUWCwgXYd/GwyXdsRdfilzBsDHsK0/PV47Gt/rvmEvmj4UO55XGTmpgyKdZfMK7pU
	bFC6bIEdcexE6TEk3K1JZlHQ+Z5X5i2/mbh/ld+GhabziNfUgPZnJKmY+lZWoUYPgJjmXbnYHdgla
	Xzt32t0FToXz7OagLiNJJYmQbtd161L9oq+I+T3ZIZoHmWQWb1SPHBJXjKaW3v0skhkA2L7C6eMPf
	Di9X7llLiH0qdZ0950DC1JFWv5gYAZWA9cZpS71cZRraWbm1nGg5E3ypihXJS35wXMxUQYAv/0z6+
	e21FGRkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWhce-00000004RDe-2Eng;
	Mon, 08 Jun 2026 21:35:04 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWhcc-00000004RDF-2BVE
	for kexec@lists.infradead.org;
	Mon, 08 Jun 2026 21:35:03 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2c0c379e8ffso32724095ad.3
        for <kexec@lists.infradead.org>; Mon, 08 Jun 2026 14:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780954502; x=1781559302; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mok13K1oI/5oKqM9t1zh4zoQDrWvB1QlqYCZOP0VV4Q=;
        b=g6gp/n1xLGLHBSNgk7nfy8NqkjQ27TGc2sSxivi0g5ykVMz6N8EC+K/9KlgHJ/FvrL
         PCWC7UYkoHZCkVV2zKQhKMPyzktpmQiUWlWJ4paTu1/iFEPUUhY+2nMmdZBoTUKs+YnM
         K5xZyJjebtoVPuXfmaqc+cMyDfO50KJNeZ9GtJ7mlzdoCA1+TjEkApr6ezM3lbQdY1EU
         C40nAQqxAoOwR8QUYvZgdnvJ8M16j+3fQGte17fu+1Id1neSDnVYKzEMzOoe31jfBew3
         +Di6LakYpuwLJ7dUVnezMNp7AT4DtGgOWcYhdQgmozOOhTTQIb+UKswR1ax6MAvPLnc4
         TMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780954502; x=1781559302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mok13K1oI/5oKqM9t1zh4zoQDrWvB1QlqYCZOP0VV4Q=;
        b=cwqucjAMAbOQ1k3nVmtu+mYA+IUnCn3K8O/5VO0MSTOPk4qZ4BIBu+6Z48G8T/Eoqn
         9TGJVSq5U0TNxVstkLwWHGA1YTlqzxxMzOanOZKlNCXqo4SdXDdUfB+UmXx0E15WoLRv
         RS58KsR7VWubSsWCPL7wbzGv3DeMDoYkPZl0UlNVbzmmuQmB0EXK1W/O8S50ijH2FEWs
         qvjfxRkghQ26np5z7TsgHwe/wkK3Iw1Tfmr2NQFwoMlOecG0Sgb74+7GeS4O6AOKbMER
         zMbpniXcI6LFfyO+Q/Qh5wUNZnKVQg6d2tMaWugkBkdY1ZcpUXK7DzphCErQtNNfEVuA
         MLlA==
X-Gm-Message-State: AOJu0YxZK0TrW8PlX/Tb6r1ftZoEEHo1zTkJUsbuCNRgg/plfKYJcBBe
	XA3L2a59X2YNna+STisJdJBEG/g2Z/mLhTIHpeB+MXFlnWwS6ljIMI6STj2TrNKOMw==
X-Gm-Gg: Acq92OG7Up9jgZP3BhdLnEY2regdH0dWQRlcesyLnX3x1OPx09rwB2qtPHFa/VJzTXU
	yjeGk0OoTBq8zjgagzdLti/SG2lzU5gkd7d4hsZUaJE8txlrFTw08DOmQ8bbrScGTlVB4Uw7G/u
	SzX9swlJh0IPyrJ2DpgVgz89jzAhn+S2tryc59CG0gAP7CRXcJ7HCuJXvgiFSd34MUtLwumLZsI
	c4Hp35dMMQInBRFpDEmfk2FFB8mEF8ERzwPGYu6Rjy77Fh1pZy1fcEokpHIBG9DvHNWIZOqY2s/
	C8iRYe+mHRTBieFMkHNGrPEHvfntexBcacjWXu+SQfLK21I+ZSSnuEOlvEIVEn2Xq7njw6AO69L
	jt8NGc9LgSr9P68ZOc9x37xgmDNTheWvTniXGtbHuOUC36B7X1XksDAbxq4R3C14mp0ITS1djvU
	IBLB13BrEKPqiTY4cw6aRw5i4LaX/KiikaC/AJ+f1iL+g2ianbHR3+k9Uhf2EMWouNqDcB3jwD
X-Received: by 2002:a17:903:2451:b0:2c0:d99a:2fc with SMTP id d9443c01a7336-2c1e78e4e7fmr195316255ad.2.1780954501183;
        Mon, 08 Jun 2026 14:35:01 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e05fsm197449205ad.54.2026.06.08.14.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:35:00 -0700 (PDT)
Date: Mon, 8 Jun 2026 21:34:57 +0000
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
Subject: Re: [PATCH v6 06/12] PCI: liveupdate: Auto-preserve upstream bridges
 across Live Update
Message-ID: <aic1gdmisIT4sqEN@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-7-dmatlack@google.com>
 <aiSb85Ec6jW4xPaE@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiSb85Ec6jW4xPaE@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_143502_571200_53286B27 
X-CRM114-Status: GOOD (  34.09  )
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

On 2026-06-06 10:15 PM, Pranjal Shrivastava wrote:
> On Fri, May 22, 2026 at 08:24:04PM +0000, David Matlack wrote:
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
> > 
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> >  drivers/pci/liveupdate.c    | 136 +++++++++++++++++++++++++++++++-----
> >  include/linux/kho/abi/pci.h |   5 +-
> >  2 files changed, 122 insertions(+), 19 deletions(-)
> > 
> 
> [...]
> 
> > +
> > +#define for_each_pci_dev_in_path(_d, _start, _end) \
> > +	for ((_d) = (_start); (_d) != (_end); (_d) = (_d)->bus->self)
> > +
> > +static void __pci_liveupdate_unpreserve_path(struct pci_ser *ser,
> > +					     struct pci_dev *start,
> > +					     struct pci_dev *end)
> > +{
> > +	struct pci_dev *dev;
> > +
> > +	for_each_pci_dev_in_path(dev, start, end) {
> > +		if (pci_liveupdate_unpreserve_device(ser, dev))
> 
> I might be reading this wrong but are we leaking some upstream devs if 
> an intermediate node fails?
> 
> 			  EP0
> 			/
> Assume we have: RC -> B1 -> B2 
> 				\
> 				 EP1
> 
> and EP0 & EP1 were preserved successfully.
> 
> And then we try unpreserving EP1, we follow:
> 
> unpreserve EP1 -> unpreserve B2 failed due to a corruption.
> 
> This aborts the loop, skipping B1 and RC completely?
> Their refcounts remain elevated, effectively leaking them as preserved 
> state permanently? (i.e. if we unpreserve EP0 after this, B1 & RC will
> still get preserved).

Yes, but that would only happen if there is some sort of kernel bug or
silent data corruption. I guess we could proceed with trying to
unpreserve the bridges upstream. But I opted to log a big warning and
bail immediately.

pci_liveupdate_finish_path() has the same behavior BTW.

> 
> > +			return;
> > +	}
> > +}
> > +
> > +static void pci_liveupdate_unpreserve_path(struct pci_ser *ser,
> > +					   struct pci_dev *start)
> > +{
> > +	__pci_liveupdate_unpreserve_path(ser, start, /*end=*/NULL);
> > +}
> > +
> > +static int pci_liveupdate_preserve_path(struct pci_ser *ser,
> > +					struct pci_dev *start)
> > +{
> > +	struct pci_dev *dev;
> > +	int ret;
> > +
> > +	for_each_pci_dev_in_path(dev, start, NULL) {
> > +		ret = pci_liveupdate_preserve_device(ser, dev);
> > +		if (ret) {
> > +			__pci_liveupdate_unpreserve_path(ser, start, dev);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * pci_liveupdate_preserve() - Preserve a PCI device across Live Update
> >   * @dev: The PCI device to preserve.
> > @@ -321,6 +403,9 @@ static int pci_liveupdate_preserve_device(struct pci_ser *ser, struct pci_dev *d
> >   * pci_liveupdate_preserve() from their struct liveupdate_file_handler
> >   * preserve() callback to ensure the outgoing struct pci_ser is already set up.
> >   *
> > + * pci_liveupdate_preserve() automatically preserves all bridges upstream of
> > + * @dev.
> > + *
> >   * Returns: 0 on success, <0 on failure.
> >   */
> >  int pci_liveupdate_preserve(struct pci_dev *dev)
> > @@ -336,7 +421,7 @@ int pci_liveupdate_preserve(struct pci_dev *dev)
> >  	if (IS_ERR(ser))
> >  		return PTR_ERR(ser);
> >  
> > -	return pci_liveupdate_preserve_device(ser, dev);
> > +	return pci_liveupdate_preserve_path(ser, dev);
> 
> Minor nit: I might be too nitpicky here (and it's NOT a strong opinion)
> but naming it pci_liveupdate_preserve_path_for_dev() reads better to me.

Noted :). I'll keep the current name for now since that is pretty long,
but if anyone else votes for it I'm happy to be overridden.

> >  }
> >  EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
> >  
> 
> [...]
> 
> Thanks,
> Praan

