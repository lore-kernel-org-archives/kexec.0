Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC12CD13D3
	for <kexec@archiver.kernel.org>; Thu, 30 Apr 2026 18:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eSG/yM4Jbprzjr8hlewRTOp1V59hFoclV98ulyGviIc=; b=RAFQfu0OrntHsFVSMrj/t5zk2A
	HrOeuyEk+YmrSHgUvz+E8GF3z+JeahBPPWwBb6bn6FeV490e9zie5rDvnc1EQUAF5cKsqtFtArMP0
	WqqcmTh1Y2vvKivX57G9Zn1Yz9GMhBUTjnrJ9QFA3Vgwv030dWssporcMsQ0nURep6tRX60yYRlNb
	nuDMlR/1C/pFA2WdC42UkcngR2tvg7VTX/RiZLgjSONkl6TLKVO0t/rDtCwLtaAtvRFPOBkxgM0AR
	JkLrc9XXDEsE1sDGb7Wt9G66XsJNihsbl3NLQNUDpYVS9bnXgcKPtXNdUYKjl/gCWqUkqRocUZwub
	r5khLqfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIW4q-00000005pGF-1m5x;
	Thu, 30 Apr 2026 18:25:32 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIW4k-00000005pFh-18ly
	for kexec@lists.infradead.org;
	Thu, 30 Apr 2026 18:25:27 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2b2591757fbso18945ad.0
        for <kexec@lists.infradead.org>; Thu, 30 Apr 2026 11:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777573523; x=1778178323; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eSG/yM4Jbprzjr8hlewRTOp1V59hFoclV98ulyGviIc=;
        b=lSDMeIIC7N3xjev3FZ3hYlp5DTLzUlPevoGLzKkKm9ArAFDZphJkPhVoCm5fcVUFLE
         ShmWcjwT0hWy6HOKyDbtFjtnhoN6Gq+SvR0VHnaT3vO6wRapCyjAISDaDe8WPnMoIl1e
         b4owd/+Y/x5lScFGfwMv8P6AfCUWySimtjcHpQoGPDFwVh9W3L0jM2n8PJGmRgBJhWBr
         hwiqh/0iY43vNdEPCStLT5yYxm+ecWMrqcXSEu5OjMjk06UXNEjW9yN2sLvEpY6yJ8T3
         4Bga1Gyr6zOU3A2shQMlnlUc49qSo/ZIMhFVrz+ZgXjhH6MlDqRmqpMuIAI7aZanWDed
         NBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777573523; x=1778178323;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eSG/yM4Jbprzjr8hlewRTOp1V59hFoclV98ulyGviIc=;
        b=YNqKvUwF4gWl+p5xRkyUchPbQomtomWSnAeu6/gG0sMbggq13hBh2E5/NAcCITrpIK
         7rmxft59anXIKVVGmbWXYpkV0QKN6xcVjIV5r922nazgepJJhLkQW0PctJJzqAL8NXve
         T/6DWK8m59Xg3tInry3/NSwo2yJfvtxx+D7y9rnxeRMvZq6YdeeBuRIJe0uAV0OO18ww
         o6QjDGPfduDewJwlOjlnGMNZUtuF9FOKPrjwP8xcqht+26vy3BKDFOcHGGCbIVpiXxff
         WKaErWx+HQ5mhjb5auzABcL/qLLsET9vw98oNsNB8N7y63QI3YI5dUfnT/j6kzvh5xI1
         JWLg==
X-Forwarded-Encrypted: i=1; AFNElJ/ETcgJH2kaouY3j5yiyzJepX+NPdcc+lDmSix0Syjle+ilnDtyhr/krCjtm80dmFM/uSP+ww==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx2lLG+DDBdnFCnsAkkiRjiaNlyiBO1fiLkMC2syvhkrZ5Tdlr/
	TuzWI1OSBwXSnklqk7+8o60UPGBw4Od2F9XOCmm3iP1gd2mGl5NDc8hjQZaOYREXrw==
X-Gm-Gg: AeBDieu1YkqeCgQ3BS9ygE6k3JqYEhXibKk5S72d6/rsBrbPnxZcAqCsr60OJki3la2
	BVSp1zHjaValWVEoEupA/3ZYifsQXPzG7TF+jRidBQtaP5dKIsm/z7GtJwX2986rKwNy42ap+uC
	tJBH/Tw1/1yxmQGjymc5Ebjf5NpdXUu9J2sqnS0pV0iGIj0EUT+0hIvNyExbImb7se0bihjI9N5
	B45FTiq+35u/hhcaouKGxL9l6hvCQA0RqXCnBHcs4uolc9/cAiAc9QkdtVSHyp0IIrHQ7J20BXg
	j8Xszm97MSv22o51EVk9/3duL0au/ioO1T7Jem7A0rPysyRCnD8llGFDYfXvBoefN2deMULxhn0
	FkSIgO/NeYJtJYHY3k2YTsS4a8PVxasn3ZDoZ/9uUqh9no9XmIPNED6lX8TVOhHav/D1Ptew0NE
	7scW5uhgxMZnS/agh9VkkyfxyVcQ1iHjfhs0iEp2yX+csLwhgw5lIsmqOcbdKQs2ALn0jvBcbSU
	h5qVsU=
X-Received: by 2002:a17:903:2a8f:b0:2b4:6153:e541 with SMTP id d9443c01a7336-2b9ce26a5dcmr69445ad.3.1777573521791;
        Thu, 30 Apr 2026 11:25:21 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbcaa477sm278266a12.31.2026.04.30.11.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 11:25:21 -0700 (PDT)
Date: Thu, 30 Apr 2026 11:25:16 -0700
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
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <20260430175916.GA13902.vipinsh@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-3-dmatlack@google.com>
 <20260428201231.GA3885809.vipinsh@google.com>
 <CALzav=dfLtdrPhkBkGwHpDAWUBMHnbGPccwhy1__doziNVZQJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=dfLtdrPhkBkGwHpDAWUBMHnbGPccwhy1__doziNVZQJQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_112526_319603_3B22C48B 
X-CRM114-Status: GOOD (  34.04  )
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

On Tue, Apr 28, 2026 at 02:12:13PM -0700, David Matlack wrote:
> On Tue, Apr 28, 2026 at 1:20 PM Vipin Sharma <vipinsh@google.com> wrote:
> >
> > On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
> > > +int pci_liveupdate_preserve(struct pci_dev *dev)
> > > +{
> > > +     struct pci_ser *ser;
> > > +     int i, ret;
> > > +
> > > +     guard(mutex)(&pci_flb_outgoing_lock);
> > > +
> > > +     ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&ser);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     if (!ser)
> > > +             return -ENOENT;
> > > +
> > > +     if (dev->is_virtfn)
> > > +             return -EINVAL;
> > > +
> > > +     if (dev->liveupdate_outgoing)
> > > +             return -EBUSY;
> > > +
> > > +     if (ser->nr_devices == ser->max_nr_devices)
> > > +             return -ENOSPC;
> > > +
> > > +     for (i = 0; i < ser->max_nr_devices; i++) {
> > > +             /*
> > > +              * Start searching at index ser->nr_devices. This should result
> > > +              * in a constant time search under expected conditions (devices
> > > +              * are not getting unpreserved).
> > > +              */
> > > +             int index = (ser->nr_devices + i) % ser->max_nr_devices;
> > > +             struct pci_dev_ser *dev_ser = &ser->devices[index];
> > > +
> > > +             if (dev_ser->refcount)
> > > +                     continue;
> > > +
> > > +             pci_info(dev, "Device will be preserved across next Live Update\n");
> > > +             ser->nr_devices++;
> > > +
> > > +             dev_ser->domain = pci_domain_nr(dev->bus);
> > > +             dev_ser->bdf = pci_dev_id(dev);
> > > +             dev_ser->refcount = 1;
> > > +
> > > +             dev->liveupdate_outgoing = dev_ser;
> > > +             return 0;
> > > +     }
> > > +
> > > +     return -ENOSPC;
> >
> > Since it is executing under a mutex, and we already failed
> > 'if (ser->nr_devices == ser->max_nr_devices) check above, will we ever reach
> > here and return -ENOSPC?
> 
> Yeah I wouldn't expect to ever reach here.

Will you be removing it or want to keep it just in case scenario?

> 
> > > diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
> > > index 5c0e92588c00..5b4c8d9e462c 100644
> > > --- a/include/linux/kho/abi/pci.h
> > > +++ b/include/linux/kho/abi/pci.h
> > > @@ -23,19 +23,20 @@
> > >   * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE string.
> > >   */
> > >
> > > -#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
> > > +#define PCI_LUO_FLB_COMPATIBLE "pci-v2"
> >
> > Just curious, why did we change the version here?
> 
> Because a field in struct pci_dev_ser changed.
> 
> > It's not like just
> > previous patch is working enough to perform a live update. As the config
> > is experimental, can't we just keep it PCI-v1 for the whole series?
> 
> What is the benefit of keeping "pci-v1"?
>

I don't see any benefit in keeping v1 or changing to v2 as well.

My reasoning is that before this series is merged, there is no real need
for versioning here. This is first series which is introducing PCI
liveupdate. It is not gonna be that someone has merged patch 1 only, run
its kernel and then kexec to next kernel which has patch 2.

> I think it makes sense to follow the rule we set which is to update
> the compatibility string in any commit that changes the ABI.

Okay, this is also fine.


