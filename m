Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFFFC982D0
	for <kexec@archiver.kernel.org>; Thu, 17 Sep 2026 19:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=FIVFF1Gz0qTcL6D0qsjU7Wz5A7oH5Uxjc4mt3x0Rb8M=; b=c6Jf+CLcX2qEcy
	hOrnpP+3lUcjOtL1z3pTM2wSxN1cngHAieTVe36G7Tqu1fxXH/FrYALJkD3xmOSaSri/sTNI1MzG0
	2MvmI3KRB2huA0KhcJFLAMCPmWfkD40AK8sfimf0S6DUJLpTiFW2b6NSKpGlPlgRiqQccqFmbSZoq
	bkt2pQLQv6SQJQnsGt8ZJH6fk8t58y0HnnzS/cftSZidk9m+FA7hLLu8Pv32wuAnFNSoXE7y5eWXy
	EeiTU+colakvyKGqzhk1PnOH8Z8KjEb+feR+kOeWtH9evimmCVKHyBpaZ9IMyeXPvNIhiWwNMByCE
	yMdVfXvRbu/PuXvmEUqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7I4d-0000000CMev-2dOr;
	Thu, 17 Sep 2026 19:47:11 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7I4b-0000000CMei-436v
	for kexec@lists.infradead.org;
	Thu, 17 Sep 2026 19:47:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 695B9601EF;
	Thu, 17 Sep 2026 19:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96EC1F000FF;
	Thu, 17 Sep 2026 19:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789674429;
	bh=FIVFF1Gz0qTcL6D0qsjU7Wz5A7oH5Uxjc4mt3x0Rb8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ITACFmTuRMNQBN70r1LnmUlyRzCHXOzNKwQta9Q3q8IXvtIZGGZC0HnDjiuVGz78R
	 EI93ZUJBBCPLeovbDy0Ya2s+Jizc+FiJeJ9wBZfFKMjqoaH52DlK4Xoo4X2+aED1PO
	 11Tu3BmmyNrTrknb2wJyGvUs8xJD893qs2vSLN/6pGC4pfbcMZAsUQQ6hTvbLLsDxB
	 A1Un69fr/uNRVwYmEKSRf/2s2tCjcBCliZfkAx5MkL96mrCZXc6aA42BYjNJjlyYri
	 wmyHxC0nRKKJiVpWROfJSOnMgC3KzaifYv19mCGGyI3yp1TqpS9tRfTJ6cXz8tNlc5
	 QykvFjSC7e2Uw==
Date: Thu, 17 Sep 2026 14:47:07 -0500
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
Subject: Re: [PATCH v8 09/12] PCI: liveupdate: Adopt ARI Forwarding Enable on
 preserved bridges
Message-ID: <20260917194707.GA1047156@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-10-dmatlack@google.com>
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

On Tue, Jul 28, 2026 at 10:10:03PM +0000, David Matlack wrote:
> Adopt the ARI Forwarding Enable bit on preserved bridges and update
> pci_dev->ari_enabled accordingly during a Live Update. This ensures that
> the preserved devices on the bridge's secondary bus can be identified
> with the same expanded 8-bit function number after a Live Update.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/liveupdate.c | 30 ++++++++++++++++++++++++++++++
>  drivers/pci/liveupdate.h |  6 ++++++
>  drivers/pci/pci.c        |  8 +++++++-
>  3 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index fb602dd3933e..744513ee11ed 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -128,6 +128,10 @@
>   *    way after Live Update and ensures that IOMMU groups do not change. Note
>   *    that a device will use its adopted ACS controls for the lifetime of its
>   *    struct pci_dev (i.e. even after pci_liveupdate_finish()).
> + *
> + *  * The PCI core adopts ARI Forwarding Enable on all bridges with downstream
> + *    preserved devices to ensure that all preserved devices on the bridge's
> + *    secondary bus are addressable after the Live Update.
>   */
>  
>  #define pr_fmt(fmt) "PCI: liveupdate: " fmt
> @@ -833,6 +837,32 @@ int pci_liveupdate_enable_adopted_acs_controls(struct pci_dev *dev)
>  	return 0;
>  }
>  
> +/**
> + * pci_liveupdate_adopt_ari() - Adopt ARI configuration
> + * @dev: The PCI device to adopt ARI configuration for
> + *
> + * For devices preserved across a Live Update, read the ARI state from
> + * hardware and adopt it. This ensures the device continues to use the ARI
> + * configuration established by the previous kernel.
> + *
> + * Return: 0 on success, or -EINVAL if the device was not preserved.
> + */
> +int pci_liveupdate_adopt_ari(struct pci_dev *dev)
> +{
> +	u16 val;
> +
> +	guard(rwsem_read)(&pci_liveupdate.rwsem);
> +
> +	if (!dev->liveupdate.incoming)
> +		return -EINVAL;
> +
> +	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &val);
> +
> +	/* Safe to modify dev->ari_enabled bitfield during enumeration. */
> +	dev->ari_enabled = !!(val & PCI_EXP_DEVCTL2_ARI);
> +	return 0;
> +}
> +
>  /**
>   * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
>   * @dev: The PCI device to check
> diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
> index ac5b8bf2edf5..ccc23031e99d 100644
> --- a/drivers/pci/liveupdate.h
> +++ b/drivers/pci/liveupdate.h
> @@ -18,6 +18,7 @@ bool pci_liveupdate_preserve_bus_numbers(struct pci_bus *bus,
>  void pci_liveupdate_scan_bridge_end(struct pci_dev *dev);
>  void pci_liveupdate_cache_adopted_acs_controls(struct pci_dev *dev);
>  int pci_liveupdate_enable_adopted_acs_controls(struct pci_dev *dev);
> +int pci_liveupdate_adopt_ari(struct pci_dev *dev);
>  #else
>  static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
>  {
> @@ -45,6 +46,11 @@ static inline int pci_liveupdate_enable_adopted_acs_controls(struct pci_dev *dev
>  {
>  	return -EINVAL;
>  }
> +
> +static inline int pci_liveupdate_adopt_ari(struct pci_dev *dev)
> +{
> +	return -EINVAL;
> +}
>  #endif
>  
>  #endif /* DRIVERS_PCI_LIVEUPDATE_H */
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 22001bdf4c97..6922f361a89e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3528,7 +3528,7 @@ void pci_configure_ari(struct pci_dev *dev)
>  	u32 cap;
>  	struct pci_dev *bridge;
>  
> -	if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
> +	if (!pci_is_pcie(dev) || dev->devfn)
>  		return;
>  
>  	bridge = dev->bus->self;
> @@ -3539,6 +3539,12 @@ void pci_configure_ari(struct pci_dev *dev)
>  	if (!(cap & PCI_EXP_DEVCAP2_ARI))
>  		return;
>  
> +	if (!pci_liveupdate_adopt_ari(bridge))
> +		return;
> +
> +	if (pcie_ari_disabled)
> +		return;
> +
>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
>  		pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
>  					 PCI_EXP_DEVCTL2_ARI);
> -- 
> 2.55.0.487.gaf234c4eb3-goog
> 

