Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE538C79FBB
	for <kexec@archiver.kernel.org>; Thu, 10 Sep 2026 23:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=pjUssxhMj5FiuQOqeJ/n4B79y63VUeUxlyscD8iV9MM=; b=Lg5FJdYLs59dcc
	WG9ZrjE8cld9XvHuDDO4esjupodI02kXtj86SvJs7iHOSTW78ifZx9FLBknjGa1hxdJ9T+WQGebIX
	/7T852fkMAUJ+AoeA1ZLSF5tcq8gElDZULtpWghRqsYUAZV6s0mwTKVDS+NLs09W5gIwsgTzdRv+E
	id8Hwu0DAqeW4x4veUwtlFtDncbRzVBl/xi1FHASE7RlWRJUa3FUWRLaP+ovLzI2h50T0eqyWUgSR
	Z3ax4Nc0NkHU8Qz23GCyO7ynYmBYk+XLny+DeE9sg3dI854mHqbdkxbZ3lQMLmt/SgCaNx82fd/1u
	bymonzuvWXc3zIvhpkFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4oXt-0000000FaKh-1GaB;
	Thu, 10 Sep 2026 23:51:09 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4oXq-0000000FaK5-2wr2
	for kexec@lists.infradead.org;
	Thu, 10 Sep 2026 23:51:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 28082601F0;
	Thu, 10 Sep 2026 23:51:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60C01F000FF;
	Thu, 10 Sep 2026 23:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789084265;
	bh=pjUssxhMj5FiuQOqeJ/n4B79y63VUeUxlyscD8iV9MM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=IznEg/t4Jbqs1UnWZoYfs2SNW3eYxJii+gRGtJP4RK3+MXWvNQ7U+9BvnzqbMzdzT
	 ktVLA2JBWKXNKxeDF0IO7dl2nkvPyPHVCzNZM65lubpANrZVz8x3X8eVFjMA2FNHuH
	 qfcGcn33q7udgEPWa7IiDEcY6rFx6R1pq/XJFN+iJQN9kbOzvKIAdtN0ScjUiT5Df1
	 XWw3ZH6CVphruyylZpeUfVYU1Jy++RYDvqFhgZaA3oz8NNVWUbqCIcETZ9z9dBjZKI
	 APtOSYggBul3/7g6jkwJH0gWfVJFyaZ4ETvhBc7Ofpzoq8oNY2NrkmnC8HokuoY4B7
	 QxY+gInKhlK2A==
Date: Thu, 10 Sep 2026 18:51:04 -0500
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
Subject: Re: [PATCH v8 05/12] PCI: liveupdate: Preserve bus numbers during
 Live Update
Message-ID: <20260910235104.GA367522@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-6-dmatlack@google.com>
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

On Tue, Jul 28, 2026 at 10:09:59PM +0000, David Matlack wrote:
> During a Live Update, preserved devices must be allowed to continue
> performing memory transactions so the kernel cannot change the fabric
> topology, including bus numbers, since that would require disabling and
> flushing any memory transactions first.
> 
> To keep bus numbers constant, always preserve the secondary and
> subordinate bus numbers assigned to bridges during scanning, instead of
> assigning new ones, if any PCI devices were preserved. Note that the
> kernel preserves bus numbers even on bridges without any downstream
> endpoints that were preserved. This avoids accidentally assigning a
> bridge a new window that overlaps with a preserved device that is
> downstream of a different bridge.

> +bool pci_liveupdate_preserve_bus_numbers(struct pci_bus *bus, struct pci_dev *dev)
> +{
> +	struct pci_dev *parent = bus->self;
> +
> +	if (dev->liveupdate.preserve_bus_numbers)
> +		return true;
> +
> +	if (parent && parent->liveupdate.preserve_bus_numbers) {
> +		/*
> +		 * Preserve bus numbers if the parent bridge is required to
> +		 * preserve bus numbers. Otherwise the PCI core could expand
> +		 * this bridge's reservation beyond its parent (which cannot
> +		 * expand).
> +		 */
> +		dev->liveupdate.preserve_bus_numbers = true;
> +	} else {
> +		/*
> +		 * Otherwise preserve bus numbers if there are any incoming
> +		 * preserved devices. This ensures that the PCI core does not
> +		 * allocate a bus number to a non-preserved device that
> +		 * conflicts with the bus number already assigned to a preserved
> +		 * device.
> +		 *
> +		 * This is slightly more restrictive than it needs to be. For
> +		 * example, each host bridges have their own range of bus
> +		 * numbers that won't conflict with other host bridges. But the
> +		 * previous kernel should have assigned a sane bus topology and
> +		 * it is simpler to just adopt that entire topology.

s/each ... bridges have their/each ... bridge has its/

It's true there should be no bus number conflicts between host
bridges, but it does require the domain as well.

> +		 */
> +		dev->liveupdate.preserve_bus_numbers =
> +			pci_has_incoming_preserved_devices();
> +	}
> +
> +	return dev->liveupdate.preserve_bus_numbers;

I'm not sure why you don't just return
pci_has_incoming_preserved_devices() in all cases, which is what the
commit log suggests this patch does.  What's gained by all the logic
here?  It's not like devices will be hot-added during the kexec.

