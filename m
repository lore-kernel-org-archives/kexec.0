Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286F2C88E53
	for <kexec@archiver.kernel.org>; Fri, 11 Sep 2026 18:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wNS06P8dgAVGWElToa1LxbVILkDrDt7tgcn+fOWtX1k=; b=NVc56mUQ3jmTAgv1zLSTjlyeSD
	fdhXpWofIn7duZ+KLEKyfAalt8AAU2irOoLqBKcYgCn4C14q15QAWNn/WCisrhNUP3HH4tsGiOv1Q
	NN3nP/pcN6ZgKEkCIHkGr1VwEgDdKzm4j1kjsTVS9t5DQ8I5yneyPyKjV9J/g6ubvjUDLiYT/w1vW
	jb450Il3/75GU+1bFGPvR4DuJaFYuuUnljUgf8LCQ7TVx1l8RN7dcTl3ouj8UFomwXRdeuJyHOyiS
	8254TTrVbQ5gvzmkDVkOGWYeQEMY787/eYJvjhN0qLLv1vAJKW539gnbKf4JgyZoqghpWLSAPlRHY
	oRQ7VuaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5615-0000000HRrw-4AWr;
	Fri, 11 Sep 2026 18:30:27 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5614-0000000HRrN-1JRg
	for kexec@lists.infradead.org;
	Fri, 11 Sep 2026 18:30:27 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-39b24d114d4so1576060a91.3
        for <kexec@lists.infradead.org>; Fri, 11 Sep 2026 11:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789151425; x=1789756225; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wNS06P8dgAVGWElToa1LxbVILkDrDt7tgcn+fOWtX1k=;
        b=GLrIb2bVfxUg0IiP85PUYJV+K3MusJPGqSZcqF3fo66Fz8jipELVuj4bC67175My2I
         5pgO7mNDE/aJJ5SpaTh6F7zw9FAZypJqT1yxGsTrvqqIv5hoQXe3DR2Pv3qL/jUHD5HH
         vqEMDDdqmfn32tWPucdlbKNFKrYKDc3YN2qcBPvC4g1xOnsBxOiWSuiE9FN63TR25a/t
         YuTDM/xSRSszmExEAmn6X/Q97RuHvq/OGwsitx8zLeORuY4jFvgAauGQmFDA4vpmdpSg
         Yzbm+5EFCPgUPf+UPjGVOiq+azuyOfdfreOyt8qVBAnvfBW3cTVP+itjv8KysbvS5qzg
         rc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789151425; x=1789756225;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wNS06P8dgAVGWElToa1LxbVILkDrDt7tgcn+fOWtX1k=;
        b=mVLvDLhjXmXFYs/ArMMi3EoZKXkp8YlqRdhZ5PSGCyMd+dG+rCgSdou7Abb9YYoVsm
         5Ub0W8hzgTV2nWWqSQQf+i4JPxg9WGmw44eNgl6Klf6USOfZGM2VD6sUE9EgY5sgfQYT
         uspTEifQQBVfluXe5Osc4eop9n3F/ianVsYvo+yvAWjjg/IbJwl96/V72AY0YWfU2YOb
         N7pVEkPY+AIm7Fd7lwjeTQXGWYPF5Q/jBiwRsRww5yQsw1YwyTw5DLA6GHhJrhcvEv1B
         MnSLpJMP7VtMrrL0LOmPi+Hd4biqAuqQJVAnX3E5Kw0O54Ozj2cc+W3Mbp2WRf4Drg7j
         QcxA==
X-Gm-Message-State: AFuF++kyqlLTgEKqfmosAruZaXd/WsWXGiIUq5DD44SRM9QciuB9hGpK
	vph/O22ZY9FmpaOB94OAeKnXE2m4RXpEDhFZF8zZ0bCUWxPmMQyFnq3TAT1K1CrrwA==
X-Gm-Gg: AYBFou1uHGxHMFdAaY5UYbnXMRB9NcfHSKd9kGomSR9201R01QTvoYp8gpg0AQLkibR
	X4gZTGulEBXTTSaTbQYmjT7j9LPs2wAMDhm5ibhzfzU0+lMfQqE/CeevS265ida1UttfCHw7o8s
	EzqLegXoQkFLt0WU8PWycgivScNlrUTTs7VwzeNdNBihnjqXFIz+EJfcnIc+3sa/wBTSbseUoVe
	xnkAACzs9smb1wNRqg2U0Ji5vDA2th9UB33kSWRx4ZIjCDm+X2i0hHn7sFXozUaP6Hx55/YVIgH
	XzfJ2iiELBGB//cYsgmkQbjVFnn2ui1t/SMFb/mdZJMD4dVrkR2MWDUolmnbU40SSv2qnJD6Mqz
	QKymj0ICaSLm2xBsTdeeDPqEPKiumlHc+T0Qo1s7vOgWhJUpeteLtZkxluqmY6Xn34yg/NR+PPt
	65gcc9JZS9eqUSE4VU1WbZfNN1RUnTlQeCH9goIuRJl1vA3Kl22+b3oU5jAVhR+azfFu4gBSTGL
	AZJsUelqFDEeoTfQvl+iOjcGMgQTcjIzcB0+IiZ
X-Received: by 2002:a17:90b:53d0:b0:38e:bfe:81e9 with SMTP id 98e67ed59e1d1-39d9bc1b0demr8040768a91.1.1789151424426;
        Fri, 11 Sep 2026 11:30:24 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d99531b16sm6613109a91.14.2026.09.11.11.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:30:23 -0700 (PDT)
Date: Fri, 11 Sep 2026 18:30:19 +0000
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
Subject: Re: [PATCH v8 05/12] PCI: liveupdate: Preserve bus numbers during
 Live Update
Message-ID: <aqRIJs1SdJwoV_cf@google.com>
References: <20260728221007.2098560-6-dmatlack@google.com>
 <20260910235104.GA367522@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910235104.GA367522@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_113026_358883_98B8E322 
X-CRM114-Status: GOOD (  30.37  )
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

On 2026-09-10 06:51 PM, Bjorn Helgaas wrote:
> On Tue, Jul 28, 2026 at 10:09:59PM +0000, David Matlack wrote:
> > During a Live Update, preserved devices must be allowed to continue
> > performing memory transactions so the kernel cannot change the fabric
> > topology, including bus numbers, since that would require disabling and
> > flushing any memory transactions first.
> > 
> > To keep bus numbers constant, always preserve the secondary and
> > subordinate bus numbers assigned to bridges during scanning, instead of
> > assigning new ones, if any PCI devices were preserved. Note that the
> > kernel preserves bus numbers even on bridges without any downstream
> > endpoints that were preserved. This avoids accidentally assigning a
> > bridge a new window that overlaps with a preserved device that is
> > downstream of a different bridge.
> 
> > +bool pci_liveupdate_preserve_bus_numbers(struct pci_bus *bus, struct pci_dev *dev)
> > +{
> > +	struct pci_dev *parent = bus->self;
> > +
> > +	if (dev->liveupdate.preserve_bus_numbers)
> > +		return true;
> > +
> > +	if (parent && parent->liveupdate.preserve_bus_numbers) {
> > +		/*
> > +		 * Preserve bus numbers if the parent bridge is required to
> > +		 * preserve bus numbers. Otherwise the PCI core could expand
> > +		 * this bridge's reservation beyond its parent (which cannot
> > +		 * expand).
> > +		 */
> > +		dev->liveupdate.preserve_bus_numbers = true;
> > +	} else {
> > +		/*
> > +		 * Otherwise preserve bus numbers if there are any incoming
> > +		 * preserved devices. This ensures that the PCI core does not
> > +		 * allocate a bus number to a non-preserved device that
> > +		 * conflicts with the bus number already assigned to a preserved
> > +		 * device.
> > +		 *
> > +		 * This is slightly more restrictive than it needs to be. For
> > +		 * example, each host bridges have their own range of bus
> > +		 * numbers that won't conflict with other host bridges. But the
> > +		 * previous kernel should have assigned a sane bus topology and
> > +		 * it is simpler to just adopt that entire topology.
> 
> s/each ... bridges have their/each ... bridge has its/
> 
> It's true there should be no bus number conflicts between host
> bridges, but it does require the domain as well.
> 
> > +		 */
> > +		dev->liveupdate.preserve_bus_numbers =
> > +			pci_has_incoming_preserved_devices();
> > +	}
> > +
> > +	return dev->liveupdate.preserve_bus_numbers;
> 
> I'm not sure why you don't just return
> pci_has_incoming_preserved_devices() in all cases, which is what the
> commit log suggests this patch does.  What's gained by all the logic
> here?  It's not like devices will be hot-added during the kexec.

To protect against pci_has_incoming_preserved_devices() flipping from
true to false while the PCI core is in the middle of a scan. It is not
likely to ever happen given most host bridge scanning should happen
during early boot, but theoretically possible with the way the PCI core
code is structured. I did not see way to structurally ensure these 2
things cannot race. A lot of the host bridge scanning happens without
taking the rescan lock, for example.

