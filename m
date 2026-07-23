Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493B2C531D0
	for <kexec@archiver.kernel.org>; Thu, 23 Jul 2026 22:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=AzhkvE35OLgSJeDoG4ympV/KpNSWvwXjJ0euGOpNYdM=; b=CQ+ki6tE5kOhjj
	/AGEB7YwF9CMBkz96oEN2eiT3rKZhg4Wc08xb1imTF7k7YV8hpi4FExozHpSUMb2h0bqiTrUJzWr9
	yKB0hdRAfFl5Cdu60TSiS89OiaHgOR4VgFMU2D4IJhYGevmaai5BS0AYswtjIeKYSZrWllBZtgCBo
	uav0Gz0nKKaG4sNz0DUipURkmcCCPMI5Xx9CEnnUBck9d0rx0/L6L45ZhLmCoHRMZoSY/d7HOduUT
	EpvKKxWz6HTbSGjsvrtlLavslQTcexg0qq4Bf/xobdYkqP7UfqW/vCc3+Fzji8hGq1qih+qVBIIm9
	6T9ouRUMqiIyYonI+Lsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn1vL-0000000FDYm-2GxY;
	Thu, 23 Jul 2026 22:29:51 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn1vJ-0000000FDYT-36Gn
	for kexec@lists.infradead.org;
	Thu, 23 Jul 2026 22:29:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 31FCE437E5;
	Thu, 23 Jul 2026 22:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF061F000E9;
	Thu, 23 Jul 2026 22:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784845788;
	bh=AzhkvE35OLgSJeDoG4ympV/KpNSWvwXjJ0euGOpNYdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=jxZW/nu3CXPiWcwj+x6K4YRDb3DrW8DFXGAxUW/O/c41NSdn+3EAAGfV128mF4txX
	 u1ujjcA2PwqcZUC9bf9hS2Igqo07ugIeH4d/G8zLSxxVkDF7rKuq65okwe/EbAMegB
	 Q4xAVC4G8ItofSVuXKgtcHFDz5EW1+Gq4nEZ9boWdkh1PIO7Io9jIZG/LzQCZyMfU2
	 Pfk7jJNctcfToZeLftnQ4AJ9ZmSCbwyht6uQ60I3sWz6Mqc3m4v9iNVllRdCQa8Xu7
	 rTzvBICrwzL/iafIpRv/MiTC0qsCRlGWXIrWPdBjdTl/ewxIJAvdwUrV5Ya/ZhAOYX
	 gev15MW3uJHEg==
Date: Thu, 23 Jul 2026 17:29:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Matlack <dmatlack@google.com>
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
Subject: Re: [PATCH v7 02/12] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <20260723222947.GA868047@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710212616.1351130-3-dmatlack@google.com>
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

On Fri, Jul 10, 2026 at 09:26:05PM +0000, David Matlack wrote:
> Add APIs to allow drivers to notify the PCI core of which devices are
> being preserved across a Live Update for the next kernel, i.e.
> "outgoing" devices.
> 
> Drivers must notify the PCI core when devices are preserved so that the
> PCI core can update its FLB data (struct pci_ser) and track the list of
> outgoing devices. pci_liveupdate_preserve() notifies the PCI core that a
> device must be preserved across Live Update. pci_liveupdate_unpreserve()
> reverses this (cancels the preservation of the device).
> 
> This tracking ensures the PCI core is fully aware of which devices may
> need special handling during shutdown and kexec, and so that it can be
> handed off to the next kernel.

I guess the antecedent of "it" is a device?  Maybe s/it/they/?

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com> 

> +static void pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing, struct pci_dev *dev)

Wrap parameter list to fit in 80 columns.

