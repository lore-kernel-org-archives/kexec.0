Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E33FF8877
	for <kexec@archiver.kernel.org>; Tue, 28 Apr 2026 17:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nLQfCSN8EWjiFZX7iYk3vg7MUEyfn/VCYlErQ2TNxjE=; b=z1ksfdffbMkjzKJDlKXbrfck5x
	EU/KMnmuS3bi5gDzAYXy6GZcRsor2WS74+1Bse7vVvWYEDzrFi77TxId0x8MCPI9Q9j0qdWbWRDMO
	2jXM4Cc4aRmekIXyTUwarEI7+Wlt0v0ljo8Wnm9Ygca3w9JmZiYGn8ECpG6SpjfOYUOE2cSqIuMXZ
	muP7BuCgEI9BoRETZHK04uR3k2dB8LuayAd1eKRh4KKF2GgCDUM0ZRSUTnvXwv8wxVQw9WKOFRlfB
	OAQ4uMw43WCoeHvKBNNmrAnLVBiCKTqsphLWvq4O7q6b48obYWNEZfJLObTfApvc5v3Vk8MXMishh
	zb46ehNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHma3-000000022pJ-0Hwj;
	Tue, 28 Apr 2026 17:50:43 +0000
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHma0-000000022os-1PFl
	for kexec@lists.infradead.org;
	Tue, 28 Apr 2026 17:50:41 +0000
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-8a3b0242631so147275886d6.3
        for <kexec@lists.infradead.org>; Tue, 28 Apr 2026 10:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1777398638; x=1778003438; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nLQfCSN8EWjiFZX7iYk3vg7MUEyfn/VCYlErQ2TNxjE=;
        b=DmcmMclBzDGiY2H/FFUtOLjBg2uHoVjM8TLyjJmhdwHbwW1GTX0rMt3NECgmx4Rj7+
         xYWB9NHkOrdaksn4c0gzBq4dwuPpH3FY4MCArbLBdFQLf6iYgP6FfB26QMxvk+WDbB+H
         BERsiEYP55ZxMBeKQEN/2KCowzpBuX0w8Dqrb5TxnZ4ecI7uroMsyQf//84d0LSHWzm8
         uxl7+9Ntp5eJA4SbpHCX0e1ctUHJU2X5fkGGFeULB3Kk34b/YfVpHiS7MQcuR20qFLDr
         nybWoLTO2QsndXFC0CpvJ+ZDyyq0+O3tGcfiez8AZtuM8sEQ7y/8maHeGVrqZxBx+W5Z
         Dwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777398638; x=1778003438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLQfCSN8EWjiFZX7iYk3vg7MUEyfn/VCYlErQ2TNxjE=;
        b=gLs2Z5ccahwkNH4x1UclitG54UMxny/PaEDNP1sledMq1PE042g5GxHiP8rYcbiifl
         80Gga8bnOMsz4ecAexEhTYO57h/B6zD+h3Zdvd1UGVyI5N490zJARL4lRIRGXX08WGFk
         Z94pXq1Xbi6wg4XjxuS7zVqMj1f2qGRytg3h27ky1K55T6W5YLMSZ4YNFs566/W/qWkC
         dIP2ZTdbScmGfT7n/HoRj69rOVFKsxHAnjt/6tuwSMbSd3caxN9sGW4iyUac94OYwuV2
         edPXNSiUJhPcQSUwB4z8gtnvt9iV5jjeWoBe/6Uqd4R1J6ao4ln9naGNEnF1qnLPV6lR
         ou5A==
X-Forwarded-Encrypted: i=1; AFNElJ+NS4GnsszsCNoP5he5VUwvkLCCLHWQWc20M9dllpwgOYToMGs0Y7aK2yeS7wtLE/11vzyZAA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxSUWc665JEuGisIuiokZ7cjGyqROxLQqSsXLE0LgXsYAz8xrFY
	vvOU+RCYbtTUc22hEeck17qgjaZjE3oSeDmdhClHjIZzy4W2J9CK0LqUBDnfAdDw1CM=
X-Gm-Gg: AeBDievE1xMfO7rMoTA52sJWHJ0mcJrFOqPoTNFgEIXAvFL/8RhXZyMO+KyAPK3r+Vi
	SuewV+ZnDulLBUiTG+Ww2iPyphqfDMlCNZHR3TPTa/vvEywbeVDgQK60h2kZ1PJhOtPLXo3QsqK
	qdcCoUdPalioQY/gIn2egt7pLQJFsXg+oZL8kIoOU0Aa5VOPMfxVmlkGlQ/ENCSsENZB1JgHDMu
	sGqCcByI1l5FpxBi46fCQl7bcSu3QQCtbclGtUGafRHcf4e7oh9beUbJNVAHQGNPYDgTRMXCbVQ
	JPaDwXFeeN3hXGpvzvHfVRc0gGQyU5If9BzaukSbiLDb65QWDWucJBbjcekB7d6ddTU4Gu15r21
	Adqe1XrT6VJhO/cDYUEZ2EeCrJJO6KRnr6EwQG/bV1KN9OpXEAlJVjrMU//+009tu1U3BYhY/Mw
	1zbBOHKGKuvttocKrvTxJBk5pb58sy4XX7tmzKI/GEUzWPJzZ5l9MFc2kW3nuPCw==
X-Received: by 2002:a0c:f40e:0:b0:8ac:b14d:fbe5 with SMTP id 6a1803df08f44-8b3e306950emr64326106d6.13.1777398637724;
        Tue, 28 Apr 2026 10:50:37 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3e281bd11sm26479316d6.8.2026.04.28.10.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 10:50:37 -0700 (PDT)
Date: Tue, 28 Apr 2026 17:50:35 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 01/11] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <afDroRNDr9ttY4O9@plex>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-2-dmatlack@google.com>
 <2vxzeck45yin.fsf@kernel.org>
 <aetvAkM0y45WAmfV@plex>
 <ae_4fg_18Rli2_Nt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae_4fg_18Rli2_Nt@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_105040_419251_44B3A0FE 
X-CRM114-Status: GOOD (  39.76  )
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

On 04-27 23:59, David Matlack wrote:
> On 2026-04-24 01:29 PM, Pasha Tatashin wrote:
> > On 04-24 14:33, Pratyush Yadav wrote:
> > > Hi David,
> > > 
> > > On Thu, Apr 23 2026, David Matlack wrote:
> > > [...]
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index c9b7b6f9828e..94af31837375 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -20555,6 +20555,18 @@ L:	linux-pci@vger.kernel.org
> > > >  S:	Supported
> > > >  F:	Documentation/PCI/pci-error-recovery.rst
> > > >  
> > > > +PCI LIVE UPDATE
> > > > +M:	Bjorn Helgaas <bhelgaas@google.com>
> > > > +M:	David Matlack <dmatlack@google.com>
> > > > +L:	linux-pci@vger.kernel.org
> > > > +S:	Supported
> > > > +Q:	https://patchwork.kernel.org/project/linux-pci/list/
> > > > +B:	https://bugzilla.kernel.org
> > > > +C:	irc://irc.oftc.net/linux-pci
> > > > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> > > > +F:	drivers/pci/liveupdate.c
> > > > +F:	include/linux/kho/abi/pci.h
> > > > +
> > > 
> > > Can we please also add these files under the "LIVE UPDATE" entry. The
> > > code here concerns both live update and PCI.
> 
> Covering that intersection of Live Update and PCI was exactly my
> intention with introducing this new PCI LIVE UPDATE entry. This ensures
> we have maintenance coverage with knowledge of that intersection.
> 
> > > We can figure out the
> > > maintenance details as we go along, but I think the live update
> > > maintainers should at least get all the patches for PCI live update.
> 
> Would adding kexec@ here be sufficient or do you want to be CC'd
> directly?
> 
> If you want to be CC'd directly do you think makes more sense to add the
> Live Update maintainers as Reviewers under PCI LIVE UPDATE, or add
> drivers/pci/liveupdate.c under LIVE UPDATE?
> 
> > > 
> > > Perhaps also add the kexec list here? We plan to use it to maintain the
> > > LUO patches, and adding it will make sure we get the patches in case
> > > someone updates the file list here but forgets to update it in the LIVE
> > > UPDATE entry.
> > 
> > +1
> > 
> > These files should also be added to the Live Update entry, and the kexec
> > mailing list should be included.
> > 
> > Changes specific to Live Update should be routed through the
> > liveupdate/linux.git tree, while generic PCI changes should go through
> > pci/pci.git. In either case, if liveupdate.c or abi/pci.h are modified,
> > acks are required from the Live Update group.
> 
> Do you want to merge changes to drivers/pci/liveupdate.c through the
> live update tree or PCI tree? We should probably decide now. I was
> assuming the PCI tree since its part of PCI core.
> 
> As we project this out there are going to be users of the Live Update
> API across different parts of the kernel: PCI core, IOMMU core, IOMMU
> drivers, VFIO core, VFIO PCI drivers, and KVM. I don't think it will
> scale to take all that code through the live update tree.

All Live-Update-specific changes should go through the liveupdate tree. 
The liveupdate tree is the only Linux tree that will cover full Live 
Update regression testing, and it contains reviewers and maintainers who 
know the details of the Live Update process, its lifecycle, and its 
requirements.

The request we are hearing from other subsystem maintainers is that they 
want to make sure Live Update is isolated enough not to make their lives 
harder. This means reducing the number of conflicts, the maintenance 
burden, and testing responsibilities.

Therefore, the "PCI LIVE UPDATE" entry should specify you as a 
maintainer, "kexec@lists.infradead.org" as the list to which all LU 
changes should be CC'd, and "liveupdate/linux.git" as the git tree 
against which changes should be applied.

It should also include "linux-pci@vger.kernel.org" so the PCI 
maintainers are CC'd. In case there are larger changes that touch core 
PCI and liveupdate.c/abi, we can ACK them, ensuring we are aware of 
incoming conflicts during the current or next merge cycle.

It should also specify the members of LU group so we can stage the 
changes.

This is the way we agreed to handle kexec changes: Baoquan He is the 
maintainer, and without his Reviewed-by tag, we won't take changes to 
kexec. This is the approach we follow with MM for KHO changes to 
memblock and memfd preservation, as well as the upcoming 
hugetlb/guestmemfd preservation. 

This is also the approach we should continue using when adding LUO 
support to other components like PCI, VFIO, IOMMU, and KVM. It keeps 
life easier for the core component maintainers and ensures we do not 
regress LU by staging everything in the same tree and sending LU merge 
requests from a single tree.

Pasha

