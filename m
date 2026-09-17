Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7DAC982D0
	for <kexec@archiver.kernel.org>; Thu, 17 Sep 2026 23:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FrwLbYHW+qBSkERcNwvno713R7/9AiFADa/N4qgCkwM=; b=THXJYxjHrACuuQSzQ+EVHQciI+
	oc5HzieAVasaRzW2aiFzUGoVgCEbc0d4FrTi+BI0K6/UeD0qEUgaP99ErCmWc4+n9OSNQNvnlQf/O
	kGZ1X2NxkjjQI+pWQAtipA6hJkrysNzLGUeXxyxBSzuZc3MNwI4oJ7MRo+sR3ia2g38Ehk7R69j2T
	oHZHUS/SkgdMVaW6+IOYMr3Wz0OYQLXz7diogarX7i2AVzwdV60I3fActA4BYH7Jv24IMlwLav0Ps
	zcdpxN0GqaSb1UT0yAhEJ2wtIXhbXEirWQVkNCavfpHVp6/5+0ymSJBSXERfXMUM6cgVOt9JPnhHr
	Sq+ktikw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Ll7-0000000Cvkl-1rw0;
	Thu, 17 Sep 2026 23:43:17 +0000
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7LkE-0000000CvDI-02oU
	for kexec@lists.infradead.org;
	Thu, 17 Sep 2026 23:42:23 +0000
Received: by mail-pz2-x0f.google.com with SMTP id d2e1a72fcca58-85469e211a3so156739b3a.2
        for <kexec@lists.infradead.org>; Thu, 17 Sep 2026 16:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789688541; x=1790293341; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FrwLbYHW+qBSkERcNwvno713R7/9AiFADa/N4qgCkwM=;
        b=F1ksdpBD91hWi88u+FadiHvRLCMutVyqQKvi8/HojvGP6y+Y3F7a/3knfEdcgbR2lT
         lNIRifbgJdJZgMGrvJe/P/I/GoEAQncrDBJpC1et5BAZG5en/mswSne60FdZGoBk/K/7
         RzsxUDDi6N/jmJKETfnVnb55AuktitTNvSo2ut0TY2WmjuyRe6IRh4cHVRKqtB/A3Uca
         wCsyJ3stkPGRJpykwG0QhRCutGljnt88XjabWvu66f9oZQsfvWBkoA2gL7AJgxcVRXB+
         lTpOXdvwa0y0JVhhmHrFXXkbLdhqOhmjfuHHXPyN7qnoTzSvMnIUQy3Yhy/OzSLAy1fX
         WZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789688541; x=1790293341;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FrwLbYHW+qBSkERcNwvno713R7/9AiFADa/N4qgCkwM=;
        b=mMzk+DgLMx9GVDSAfH5EYM1fRuY6y1dFI96BeAGzWOpbUU8XDf1kP1lcUHWMUFfW2+
         Tlj13KNoWDAS3Dgm9ynqTBxrNnnKd0/QMH6nzcRSZ13hbNAt0Os+MsrwbIm9NuvK6JD2
         KlkDY59mz1XS90nNH3Raw8djeNe34zBeI74dcHs8RSWvFkWaE+yXcmjPHC+DiS4bseYS
         +UL/SUZWTy5qAXhuIwf3+LriUdstujSsN9GirYPFSzs2Tegu3R/IsieZjVH5ygcAx5La
         yKS65SFwXMU6/zqMMrJCA++1XplB/wv11cduHET0jr0KajdnzOglIMFs/w7LzvUxYpkw
         xVWg==
X-Gm-Message-State: AFuF++kBk5oA77RwTczGewzCSFy2+FvFhsLUbkTNhGKFVnNuPyVKm7Z9
	8SVfpirX8iesHsDRAaHfK8nva/SjFts0rqxUPvz2hbDrEJ+aluDGvzynro6c2g2apQ==
X-Gm-Gg: AYBFou1dLynZTeu4AO+Rw0+4cRvn7tTEeOGaC7kvGpsNrlf/eQnRMGet+nEpFNu7KgF
	MRPiUTXhqnwkyE0ci2soMNQH/uQG00DdIKtAUx2ZKihQSZfuKxSdMEze4ifLpVxa9RyjHCKmAAR
	t9hcHmt8Iuow+4t1EsNWp1OPYm58p9U65CK54bQel5LokbED5n/o6Au6tKBis2ykw99R5kf1rkJ
	S3NrQ4p53ZyvobCrYShixu5bnGQ1jmLN8FvdkT6m9dat+QJ8qUoWqagUrBClAsyd5iX2MxkyLSM
	0oQrDHMf5xXowwxtisNzbUvZtnZet7VjNK2H4701F5uY+As5uneaFYddPV4kZ+droWwu6vRbF5A
	oXtVWSbChcUo+QkH0AsAChMa+dEvb+vhffj4U4ww8e9IwDf2EaNjjZrgxKkn9mpXAF7P4BVP/uh
	82ofRhRedaI0CixUtb/O7kA4JfAASUJs1QMKL/dw91JYnkZIVISs0KpRk1Hc6vZwuRx1r3NHUYG
	/Px5RCil3jfsAnA3E8C7qzWiHOaTLudHKW+tjQX
X-Received: by 2002:a05:6a00:2d26:b0:857:72f8:dc98 with SMTP id d2e1a72fcca58-874dddfe1ffmr1080071b3a.25.1789688540476;
        Thu, 17 Sep 2026 16:42:20 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-872024e5acfsm3586862b3a.57.2026.09.17.16.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 16:42:19 -0700 (PDT)
Date: Thu, 17 Sep 2026 23:42:16 +0000
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
Message-ID: <aqx62Czdkh9unP86@google.com>
References: <aqQzmvgILmU8F4TR@google.com>
 <20260917001847.GA993118@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917001847.GA993118@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_164222_080298_3B4621BE 
X-CRM114-Status: GOOD (  32.93  )
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

On 2026-09-16 07:18 PM, Bjorn Helgaas wrote:
> On Fri, Sep 11, 2026 at 05:00:10PM +0000, David Matlack wrote:
> > On 2026-09-10 06:51 PM, Bjorn Helgaas wrote:
> > > On Tue, Jul 28, 2026 at 10:10:00PM +0000, David Matlack wrote:
> > > > When a PCI device is preserved across a Live Update, all of its upstream
> > > > bridges up to the root port must also be preserved. This enables the PCI
> > > > core and any drivers bound to the bridges to manage bridges correctly
> > > > across a Live Update.
> > > > 
> > > > Notably, this will be used in subsequent commits to ensure that
> > > > preserved devices can continue performing memory transactions without a
> > > > disruption or change in routing.
> > > > 
> > > > To preserve bridges, the PCI core tracks the number of downstream
> > > > devices preserved under each bridge using a reference count in struct
> > > > pci_dev_ser. This allows a bridge to remain preserved until all its
> > > > downstream preserved devices are unpreserved or finish their
> > > > participation in the Live Update.
> > > 
> > > This seems to hint that we're going to allow bridge reconfiguration in
> > > some cases, e.g., for hot-adds.  The simplest case is "leave config of
> > > all bridges the same", and I thought that was what the previous patch
> > > commit log said.
> > > 
> > > What's the benefit added by this patch?
> > 
> > It is used in the following patches:
> > 
> >  PCI: liveupdate: Adopt ACS controls in incoming preserved devices
> >  PCI: liveupdate: Adopt ARI Forwarding Enable on preserved bridges
> >  PCI: liveupdate: Do not disable bus mastering on preserved devices during kexec
> > 
> > to preserve certain configuration on bridges that have downstream
> > endpoints that are being preserved. To support P2PDMA we will also have
> > to preserve bridge memory windows (future series).
> > 
> > If we are ok with applying those policies to all bridges on the system
> > whenever one or more endpoints anywhere on the system are being
> > preserved, then I agree we don't need this patch. But I thought it would
> > be cleaner to track things per-device.
> 
> Yes, I agree tracking it per-device is good.  I was looking for a
> traversal upstream to increment refcounts on bridges, and I guess that
> happens via for_each_pci_dev_in_path() in pci_liveupdate_preserve().
> 
> The actual refcount still confuses me a bit (see
> https://lore.kernel.org/all/20260917000723.GA992337@bhelgaas).  Maybe
> it would help if pci_liveupdate_preserve_device() alloc the dev_ser
> *first* (right after all the bail-out checks)?  I wonder if the
> refcount increment could then happen in exactly one place, separated
> from the one-time dev_ser housekeeping?  E.g., something like:
> 
>   if (!dev->liveupdate.outgoing) {
>     dev_ser = pci_flb_alloc_dev_ser(outgoing);
>     ...
>     dev->liveupdate.outgoing = dev_ser;
>   }
> 
>   dev->liveupdate.outgoing->refcount++;

Ack, will fix

