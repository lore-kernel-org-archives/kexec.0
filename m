Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08241FED3CB
	for <kexec@archiver.kernel.org>; Fri, 24 Apr 2026 13:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4ezbOz+DNq/Ln5lGWJ2GbxuTePwedL+fzC5CYxvFRhc=; b=m3h/HadTNtgQYe1SxyL6NW9cXh
	Yw39c1JlqipEk4zUaXuUwIYMIe9URFc1mW9kuxUnYhFrHhuy0kmjOk8uaj4qBFXpk8Rv0T9qQ4Aqy
	5Rp15S+qRHl4O9O9gQ1RwgXySrSYVQ4sY65NRRArwaNfPh3T9Y008aEFemIsdz004BmYm+HX7aXwl
	BvAIfDKU+T+VvFlW9d+mXOGyf+vlzomLVdpzZVTIMsB7q3/aaaTdN61LC6oYsdyPbkfkm1MIwWw3e
	sdVT1VKWomspNzXLbvGrnyytkIlmldW7RUgdIgnykFXFL4dWuHhPiKASGNX+zhvkX0tIkWofNW6nz
	TDE+nS+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGGb5-0000000DFAR-2Rtv;
	Fri, 24 Apr 2026 13:29:31 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGGb3-0000000DF9x-1CpU
	for kexec@lists.infradead.org;
	Fri, 24 Apr 2026 13:29:30 +0000
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-50e614fdb42so55144651cf.3
        for <kexec@lists.infradead.org>; Fri, 24 Apr 2026 06:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1777037368; x=1777642168; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ezbOz+DNq/Ln5lGWJ2GbxuTePwedL+fzC5CYxvFRhc=;
        b=jPTY8EYnIycOr0G4Fh5NXO7CMobDWSTakAfODpnfJpe9saUpzFOSiNU68VUQQ66eDJ
         XM1ztTXWJKG5y/VCQEqWf7jq2mPcCFmKplPtPtHXzXrzxeOl/yGuVJrWpcRxDLXdPHI6
         /EtIT5vmh8HvYvEr3rFwj9rnW9A2rE/JqQvb7xke0GYaBiGam75EKzIFrvKOoy02lvdA
         ZoNFssB8RA0S+YoePIMPEiGVkXL+gbXsna69JKdT+tQf1bRgAAe8+JbfWK2ep93KfJiv
         fxrw4qYh7UR7ka10pYW7HCro3A0h2Q+fow2806z5SMiEMxpL+saOvMfsDBY1W+VnnZcP
         Zc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777037368; x=1777642168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ezbOz+DNq/Ln5lGWJ2GbxuTePwedL+fzC5CYxvFRhc=;
        b=oPVZFJGWLBdHsJILe6WkDQMwANrIQhAgmTM+bfXM/g9s3Rb7j4GEWS3Mpmqla5p9zt
         VHClCFSgzsMReGAQswbl0Tv2mzXHr/I3XOT2msZHAon1VSj1ZkSgeLtut8rweFYJDa3o
         gKKNba2I0HCNfEiLlq670g1wpCSY6c+APvUVMy0BhMHdCShL4X4kgm6XYYZEaV9jByoc
         ME60hVp/4b+iorMHbBdTUX4OZaM9xP4E6BIw5/Cu6eByBYLFR6WnbsefLwt1+owYiAxn
         b5HDcyscUSmYbE+fAhL1LTScFGo2R6VsnW4iwPl/XcYYvF5v1J9voOYInPOQESudnzVY
         TKAw==
X-Forwarded-Encrypted: i=1; AFNElJ9F+cQU+ROFCNG/5oOpShmZRdnJ1wBROz6FaeaCmBePoT2JIZZORFThi46eXtVRkEAjbnrlgQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyEg9Q31dFNZNSYgteFI3qOD+LU2LaFfuOQJlf5tcpvgzzGN6f/
	PJZxtRog97QDoGUpqUN77yhF84ReVpcR9h+8XvDkt+CUp85ZSDzSqudtpRlF+U5YXXo=
X-Gm-Gg: AeBDietgSja3748ImRRLXsq7okgR0An4IqQDJ9rm4ApEd8Va7Om3iMSqwaFzIfoQW6k
	NG+OHjJT/kmfgEorR08M6HIoFaqnzpCgPusiTIdtDwxCeUDbFiJ3PEAD3U25HXh42w4ijohOJ6x
	hCF8mIk8eXkGCeEjVdlBnxvFsNZaj/9CHgayrwUlIzOUtHvBwY5IcPvvmC1oO6gtLQ2kZfYXJoz
	UGRrYEbRv03WIq5jc+l2kg4P2fA9/EBsTgGv1UR+lWOAOn2u3N6znlpPCRhic8B/frj+Coad5+H
	87S8MALUx0hHM5ErAmXU1/bOfdhLgoCC5GqRK7SnPWDbCzBiU7wlfKKPLwDzvokdNHyFWACZ13D
	HygrKoynoZ4+3CSLxMXZaICsdJ66d7NRRmAJHBIlI2RxdFrGcSu8/S87ag36eTJB6ha1L+6fEN3
	LM3QPlNM4IepEAWR/MmzlOkMgyzb74KInn+vjyyuIC8mYwkh4j87aXQ0Zu05rZKg==
X-Received: by 2002:a05:622a:1f0d:b0:50f:c36a:381a with SMTP id d75a77b69052e-50fc36a3bd2mr157337571cf.55.1777037367645;
        Fri, 24 Apr 2026 06:29:27 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50fb5fc8e04sm101886121cf.13.2026.04.24.06.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 06:29:26 -0700 (PDT)
Date: Fri, 24 Apr 2026 13:29:24 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: David Matlack <dmatlack@google.com>, iommu@lists.linux.dev, 
	kexec@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 01/11] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <aetvAkM0y45WAmfV@plex>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-2-dmatlack@google.com>
 <2vxzeck45yin.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzeck45yin.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_062929_337087_BFA96BD0 
X-CRM114-Status: GOOD (  19.61  )
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

On 04-24 14:33, Pratyush Yadav wrote:
> Hi David,
> 
> On Thu, Apr 23 2026, David Matlack wrote:
> [...]
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c9b7b6f9828e..94af31837375 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20555,6 +20555,18 @@ L:	linux-pci@vger.kernel.org
> >  S:	Supported
> >  F:	Documentation/PCI/pci-error-recovery.rst
> >  
> > +PCI LIVE UPDATE
> > +M:	Bjorn Helgaas <bhelgaas@google.com>
> > +M:	David Matlack <dmatlack@google.com>
> > +L:	linux-pci@vger.kernel.org
> > +S:	Supported
> > +Q:	https://patchwork.kernel.org/project/linux-pci/list/
> > +B:	https://bugzilla.kernel.org
> > +C:	irc://irc.oftc.net/linux-pci
> > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> > +F:	drivers/pci/liveupdate.c
> > +F:	include/linux/kho/abi/pci.h
> > +
> 
> Can we please also add these files under the "LIVE UPDATE" entry. The
> code here concerns both live update and PCI. We can figure out the
> maintenance details as we go along, but I think the live update
> maintainers should at least get all the patches for PCI live update.
> 
> Perhaps also add the kexec list here? We plan to use it to maintain the
> LUO patches, and adding it will make sure we get the patches in case
> someone updates the file list here but forgets to update it in the LIVE
> UPDATE entry.

+1

These files should also be added to the Live Update entry, and the kexec
mailing list should be included.

Changes specific to Live Update should be routed through the
liveupdate/linux.git tree, while generic PCI changes should go through
pci/pci.git. In either case, if liveupdate.c or abi/pci.h are modified,
acks are required from the Live Update group.

Pasha

