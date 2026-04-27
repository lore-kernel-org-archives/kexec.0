Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD36FF8867
	for <kexec@archiver.kernel.org>; Mon, 27 Apr 2026 21:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=eR7WRDEIu0A3ltOUaleJIJZmRlJgFK+aFlYE1BqZCLk=; b=BDOjrAXoZHz6XU
	RyjGJcQhumNOqVwUsDfIFWEk2FqEJGYyYWDhZlYhwCWbMnXL5uFJGo96RVKNCueR7O6BJmJBalZo6
	XSqIT8LFUEmGT00DpKD0pIbsUUfbgEfMwp1WdhHjFw9uissuHgoMaRiP1PbMRvTNL+BCCxqcnqkpm
	0MmrU/U3AK7vXpXWeKB5uf25yC824jiUKApz0hcLsFg7QaxssD2mTX+jALh20RBJn6pbBZnfbX4iw
	7fUXf3BrkpPVyVWpBmF8ShOOeQ5wS4/YC4oREaWafp2u9UvYeQ+BzkLWPlhvAncEXuoAbekMMgRgZ
	xNOc2dh6aYZGu9pQWIsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHT93-000000009q2-36Sf;
	Mon, 27 Apr 2026 21:05:33 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHT92-000000009pq-2Dba
	for kexec@lists.infradead.org;
	Mon, 27 Apr 2026 21:05:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 97C1360139;
	Mon, 27 Apr 2026 21:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222BEC2BCB5;
	Mon, 27 Apr 2026 21:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777323931;
	bh=BKvU8n8CmmLGOo/iWjExHY4UTAHtpbclc/VETFqsn3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=f2Yasvoienx7V+cC4PCEeVthUNsSP6+lU5/iKedPkKipBTK3W9hQlKQOizBDpjzWt
	 tmNepResRGa9Robr+yPwMgrRAe7aQXzQ2jhIQgRJwvJEOo5f7UtB42dPaDXfDIIcUX
	 afIekttok4tFW/iR+rCngQveUvcIZiUoA3WIpOc8oBp48Bn3VRBy58KHuIkjYwkEFc
	 ftQaqsh5nTtMk8ievxIuK556Wzq+jWivXo+c6aFEfpXiH+ww+Ds4y1wq8ksZKb1Iiu
	 FW8X5Rtq0CoA/Jo+Rum76rkryfic5YtzKPIShtN7H0Nv1vappKhtvXjZXcsJO2PIOL
	 MZ+Bgj4uYDiiQ==
Date: Mon, 27 Apr 2026 16:05:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
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
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 01/11] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <20260427210529.GA186381@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423212316.3431746-2-dmatlack@google.com>
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

On Thu, Apr 23, 2026 at 09:23:05PM +0000, David Matlack wrote:
> Set up a File-Lifecycle-Bound (FLB) handler for the PCI core to enable
> it to participate in the preservation of PCI devices across Live Update.
> Essentially, this commit enables the PCI core to allocate a struct
> (struct pci_ser) and preserve it across a Live Update whenever at least
> one device is preserved.
> 
> Preserving PCI devices across Live Update is built on top of the Live
> Update Orchestrator's (LUO) support for file preservation. Drivers are
> expected to expose a file to userspace to represent a single PCI device
> and support preservation of that file. This is itended primarily to
> support preservation of PCI devices bound to VFIO drivers.

s/itended/intended/

> +++ b/MAINTAINERS
> @@ -20555,6 +20555,18 @@ L:	linux-pci@vger.kernel.org
>  S:	Supported
>  F:	Documentation/PCI/pci-error-recovery.rst
>  
> +PCI LIVE UPDATE
> +M:	Bjorn Helgaas <bhelgaas@google.com>

I don't think I want to be the primary contact here.  I'll see patches
regardless since they're on linux-pci.

> +M:	David Matlack <dmatlack@google.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Supported
> +Q:	https://patchwork.kernel.org/project/linux-pci/list/
> +B:	https://bugzilla.kernel.org
> +C:	irc://irc.oftc.net/linux-pci
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> +F:	drivers/pci/liveupdate.c
> +F:	include/linux/kho/abi/pci.h

