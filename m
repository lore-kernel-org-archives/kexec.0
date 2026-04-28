Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2266DFF8875
	for <kexec@archiver.kernel.org>; Tue, 28 Apr 2026 23:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EpaL2C2UFwZgckez6PzSxOJ2+MS43lyhGR+45AYtYTo=; b=gEsp2VLuIYqCzIB6uty1+hD/H6
	zHMk5B7K7fTt+40N3IxUet+bY2SrDQ8i1tMn9BnWrslrMI4SxFULt40ptSCfIbuNb3G8zSDtaprGD
	JCtzWO6OycgBT3A2kfKXoXzTqtj04TIjoRY564+TzhB8bdOz8hzgceVEUG+4brnAtOALJaQ1bjUXc
	E4WA9Dszq8DMfchuwzh6/u5hN39nnB0EDIixDXeiksAzpAppZ3r3zwu2cUz2CZRChbWFlqq0K0m7v
	8m1DlngWf8PE5D8tKmx2SOxb6lQqzIC3VhZwP/0Ak8ApuTFowTZaEaDD/vVPEjhV9g6yIBm7i59qI
	GNBkYPQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHs9N-00000002dLG-04y5;
	Tue, 28 Apr 2026 23:47:33 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHs9J-00000002dKl-3FeD
	for kexec@lists.infradead.org;
	Tue, 28 Apr 2026 23:47:31 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so8329986a91.0
        for <kexec@lists.infradead.org>; Tue, 28 Apr 2026 16:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777420048; x=1778024848; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EpaL2C2UFwZgckez6PzSxOJ2+MS43lyhGR+45AYtYTo=;
        b=ImVUnRY6SxKDQY5VDHFluacXD4un3HNYI6t6+WrAKslig0hsgBqPHMZISKDX2r/Tuk
         zkC3J7iXobjj5O+oEJAFFe0XNrLR/D0mheLv9Tfbr57Bbtc5MfYsDaeCS5g6cdBIFC39
         +5Yco7EyYITbBSfnqFfFvigxa7AQaNmBJoX8QlIphSG6Ylf8YN5iO6XSQe4hLCPuIyQT
         yiL8z58aL4uiavRG7ZPFcqIfvRjgW6Tuc/3ZOfmxQio0tu5x8OLg7ZX41CjdJSlUvKqG
         MkYUzugURtteDq4eBuwK8Im9pP5p2WBx/q8OXNCiwCiSqNVq3jHEd/slaDJ7D+eFMOUl
         n0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777420048; x=1778024848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpaL2C2UFwZgckez6PzSxOJ2+MS43lyhGR+45AYtYTo=;
        b=QD+3Hl59fmbDFldZFhxhaRMu/TQ/TzKurTmYpV16RpLNG/4yvTxEQoIgmqlz54joaT
         DsBnL6OZdpuRhZ/XxYikMk8eIg0qy9rzanYI8Ssq4NvNtHB/r5kXUNblU4ai9WUfyck1
         speCbV1WlYnxaLYDsfJwMxoiHGWgu1ECWmDojGV254TpEHW+7UWlq7glK+J3HxMCrEcI
         Jxhovz9niamTxPOppf1CUeNZduGev0Ih0YYOx5uVWGpNEQvFPyncC0dHc50UinpIrxjw
         0Gna71mD/1zBrPrkpiR5eLf5siQpUkIDAP4S36XwkWyYpxsRzrm7yQ6YgvIXIs3bRLe4
         Jddw==
X-Forwarded-Encrypted: i=1; AFNElJ9iKrk4bAnBOcsR00tikvDqfxOCcszMviuj5q95cQX/fjjF+BRM4PQ2EVBbPzR9O0FiCDVkOQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwHYCQDQA1H4z3ITwddPk1kkDl9JbdWIhkZY4DzSnj7EnyL1KaD
	AvN8Khuqf97kZT9vohOmtGZgPxsUXRsnKxTk5p2SLOJGJztsyWi5JaDbSx8sF6TFbw==
X-Gm-Gg: AeBDieu2eW6DdSxd3Gl5EIkune6ziA5uiGlynphBp/nKxQPiIlXHZ6YWy9qCPTJMCOi
	NxRxfhQ5rJOT6CI6RbhIix4JKIOnJN2cAseZwzXSMZwCW2NxUQHXr1wz3//AuRkLkyOGl3TfV+S
	niy5Dfn6l8wo/Y8VNGF4r2Lh/SzxHPyDJdxk4zOHKVR4CIo5gErA7qMhDrMkivXQhgWpRQ+OvGQ
	VYhbcQnBPoLdUNnYMnd1meEhqhmymefzisgXxPA/9x1jvxvcIT4ZeEh9v7FD/UktBLUm4s9e4Xn
	R9kLzysN0AL4kVK13Cnn6oba9XpglxOGiVKgEktKM5fCby/+yneB8K6q7cpEJ13XX+y5wSKhEcQ
	RWLoL0vOdMWuFld08g1k7nYNdWWxwWgHo0lBBm5/LklU9ED32SJmVSoMMmAl2V32BY6bF6i+iKk
	nRNlnUHi8TYezfCkgZb41b+/LfJnJbFjHUV+yvMvBRLTAxeQsE0HXX6B2qaWlSGNsVm1IDEYRfP
	cWpiA==
X-Received: by 2002:a05:6a20:a120:b0:3a2:bd1d:d68c with SMTP id adf61e73a8af0-3a3af60f200mr1710132637.50.1777420047985;
        Tue, 28 Apr 2026 16:47:27 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fd64f09fdsm178148a12.17.2026.04.28.16.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 16:47:27 -0700 (PDT)
Date: Tue, 28 Apr 2026 23:47:23 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, iommu@lists.linux.dev,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 01/11] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <afFHC6C1Qbwio4pH@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-2-dmatlack@google.com>
 <2vxzeck45yin.fsf@kernel.org>
 <aetvAkM0y45WAmfV@plex>
 <ae_4fg_18Rli2_Nt@google.com>
 <afDroRNDr9ttY4O9@plex>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afDroRNDr9ttY4O9@plex>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_164729_831074_E055ED4F 
X-CRM114-Status: GOOD (  47.24  )
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

On 2026-04-28 05:50 PM, Pasha Tatashin wrote:
> On 04-27 23:59, David Matlack wrote:
> > On 2026-04-24 01:29 PM, Pasha Tatashin wrote:
> > > On 04-24 14:33, Pratyush Yadav wrote:
> > > > Hi David,
> > > > 
> > > > On Thu, Apr 23 2026, David Matlack wrote:
> > > > [...]
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index c9b7b6f9828e..94af31837375 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -20555,6 +20555,18 @@ L:	linux-pci@vger.kernel.org
> > > > >  S:	Supported
> > > > >  F:	Documentation/PCI/pci-error-recovery.rst
> > > > >  
> > > > > +PCI LIVE UPDATE
> > > > > +M:	Bjorn Helgaas <bhelgaas@google.com>
> > > > > +M:	David Matlack <dmatlack@google.com>
> > > > > +L:	linux-pci@vger.kernel.org
> > > > > +S:	Supported
> > > > > +Q:	https://patchwork.kernel.org/project/linux-pci/list/
> > > > > +B:	https://bugzilla.kernel.org
> > > > > +C:	irc://irc.oftc.net/linux-pci
> > > > > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> > > > > +F:	drivers/pci/liveupdate.c
> > > > > +F:	include/linux/kho/abi/pci.h
> > > > > +
> > > > 
> > > > Can we please also add these files under the "LIVE UPDATE" entry. The
> > > > code here concerns both live update and PCI.
> > 
> > Covering that intersection of Live Update and PCI was exactly my
> > intention with introducing this new PCI LIVE UPDATE entry. This ensures
> > we have maintenance coverage with knowledge of that intersection.
> > 
> > > > We can figure out the
> > > > maintenance details as we go along, but I think the live update
> > > > maintainers should at least get all the patches for PCI live update.
> > 
> > Would adding kexec@ here be sufficient or do you want to be CC'd
> > directly?
> > 
> > If you want to be CC'd directly do you think makes more sense to add the
> > Live Update maintainers as Reviewers under PCI LIVE UPDATE, or add
> > drivers/pci/liveupdate.c under LIVE UPDATE?
> > 
> > > > 
> > > > Perhaps also add the kexec list here? We plan to use it to maintain the
> > > > LUO patches, and adding it will make sure we get the patches in case
> > > > someone updates the file list here but forgets to update it in the LIVE
> > > > UPDATE entry.
> > > 
> > > +1
> > > 
> > > These files should also be added to the Live Update entry, and the kexec
> > > mailing list should be included.
> > > 
> > > Changes specific to Live Update should be routed through the
> > > liveupdate/linux.git tree, while generic PCI changes should go through
> > > pci/pci.git. In either case, if liveupdate.c or abi/pci.h are modified,
> > > acks are required from the Live Update group.
> > 
> > Do you want to merge changes to drivers/pci/liveupdate.c through the
> > live update tree or PCI tree? We should probably decide now. I was
> > assuming the PCI tree since its part of PCI core.
> > 
> > As we project this out there are going to be users of the Live Update
> > API across different parts of the kernel: PCI core, IOMMU core, IOMMU
> > drivers, VFIO core, VFIO PCI drivers, and KVM. I don't think it will
> > scale to take all that code through the live update tree.
> 
> All Live-Update-specific changes should go through the liveupdate tree. 
> The liveupdate tree is the only Linux tree that will cover full Live 
> Update regression testing, and it contains reviewers and maintainers who 
> know the details of the Live Update process, its lifecycle, and its 
> requirements.
> 
> The request we are hearing from other subsystem maintainers is that they 
> want to make sure Live Update is isolated enough not to make their lives 
> harder. This means reducing the number of conflicts, the maintenance 
> burden, and testing responsibilities.
> 
> Therefore, the "PCI LIVE UPDATE" entry should specify you as a 
> maintainer, "kexec@lists.infradead.org" as the list to which all LU 
> changes should be CC'd, and "liveupdate/linux.git" as the git tree 
> against which changes should be applied.
> 
> It should also include "linux-pci@vger.kernel.org" so the PCI 
> maintainers are CC'd. In case there are larger changes that touch core 
> PCI and liveupdate.c/abi, we can ACK them, ensuring we are aware of 
> incoming conflicts during the current or next merge cycle.
> 
> It should also specify the members of LU group so we can stage the 
> changes.

Sorry what does this mean specifically?

> This is the way we agreed to handle kexec changes: Baoquan He is the 
> maintainer, and without his Reviewed-by tag, we won't take changes to 
> kexec. This is the approach we follow with MM for KHO changes to 
> memblock and memfd preservation, as well as the upcoming 
> hugetlb/guestmemfd preservation. 
> 
> This is also the approach we should continue using when adding LUO 
> support to other components like PCI, VFIO, IOMMU, and KVM. It keeps 
> life easier for the core component maintainers and ensures we do not 
> regress LU by staging everything in the same tree and sending LU merge 
> requests from a single tree.

Ok it sounds like we are aligned on keeping drivers/pci/liveupdate.c,
include/linux/kho/abi/pci.h, and Documentation/PCI/liveupdate.rst in the
PCI LIVE UPDATE entry and not duplicating them in the LIVE UPDATE entry.

I think the only open question is what tree to use for the PCI LIVE
UPDATE entry, PCI tree or Live Update tree. You are proposing the Live
Update tree.

Bjorn are you ok with that approach?

