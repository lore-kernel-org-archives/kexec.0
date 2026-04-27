Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A97FF8864
	for <kexec@archiver.kernel.org>; Mon, 27 Apr 2026 21:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=hgHpiDOCUudw7O/cEVLVNH4ElJQq9HH5iQOKl9zHxME=; b=ftdHWoWqxurDQW
	nQo3wFiET1qnJvn81alqz3bCeN9LPkPMxj/Pr5Q2tcREBar7wyuxXNxl7jV8wCpimDpvKTNgKaHVd
	oI2EkP1d6P+d6HjSuArovw94XOJmu8EE0NQ0vOyAfig1otI6NkDwWAggOyit2n4I0KGmmJmyDXufV
	xCHEgJmVnAxKRMO7SqYD+XUgxPwwS4KXgI+smjuUmHvUdhJ/VKxriCeH0rn2MBLpKoV9jCQftCiuN
	n+tH8hWJ+Gd4K+4jNJnUEdO18m+Rn5j37YKzJy+CmbkriCeaXH23c9ff3pwleXSUarzQMYMirSS/O
	PL1R5WEvYgZYX7leyTyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHT9m-000000009sj-1UJj;
	Mon, 27 Apr 2026 21:06:18 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHT9l-000000009sd-36Pd
	for kexec@lists.infradead.org;
	Mon, 27 Apr 2026 21:06:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 332236057A;
	Mon, 27 Apr 2026 21:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4DBC19425;
	Mon, 27 Apr 2026 21:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777323977;
	bh=CIswUHjtV6oSUsxjeWT06cacL6KEcFHO+pUSNAd7kso=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YoNJN0KKRc41UjoNkjKTVxHCQ9uHmb1vXRgaeoA4tQWz/iAKTXe43aboUj7ZhDG0t
	 grNENZpJKNHzFBJy7Y506+AuuCHjO1qZfDRXYgBS/0Yw8y5dlIOWegmRBKPba4bB6Y
	 5VcibMz6TPsiqAgZkvXp2IBx61Yw3YfO9M4cAandeRfDj83rXbzcmH2WqXx6KVwMY1
	 tFRBliyM+9VjS8JW20gNO4qb1z7tkpfpIBwBl3Wh8cGH9NaUQh2VAbsD4l95ckOfFr
	 7cMHIO7JOZkCSv8VfoEMbGIMwpAhmicK4vHq6YczTKvrrB2AuD0Nao69SvIM0v/DRr
	 xVcZfTO9P4O2Q==
Date: Mon, 27 Apr 2026 16:06:15 -0500
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
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <20260427210615.GA186434@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423212316.3431746-3-dmatlack@google.com>
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

On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
> Add APIs to allow drivers to notify the PCI core of which devices are
> being preserved across a Live Update for the next kernel, i.e.
> "outgoing" devices.

> +++ b/drivers/pci/liveupdate.c
> @@ -43,6 +43,26 @@
>   *
>   *  * ``pci_liveupdate_register_flb(driver_file_handler)``
>   *  * ``pci_liveupdate_unregister_flb(driver_file_handler)``
> + *
> + * Device Tracking
> + * ===============
> + *
> + * Drivers must notify the PCI core when specific devices are preserved or
> + * unpreserved with the following APIs:
> + *
> + *  * ``pci_liveupdate_preserve(pci_dev)``
> + *  * ``pci_liveupdate_unpreserve(pci_dev)``
> + *
> + * This allows the PCI core to keep it's FLB data (struct pci_ser) up to date
> + * with the list of **outgoing** preserved devices for the next kernel.

s/it's/its/

