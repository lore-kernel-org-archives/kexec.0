Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBC4CA9EBE
	for <kexec@archiver.kernel.org>; Sat, 10 Oct 2026 08:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9aAKNdFlAWIBUhCteIbdgam8eQs/tWYWWSOa0TvAgNk=; b=KDmtdRMV7HvLfjOMoIt9JuGY+x
	Fk9sIXL8tqUaaNUl2n2ms2bkSiTYrJSjPN9kIlDM5ITvc2aXqCfIODF7cl7AaXDxAhiEQB/Mi6qK/
	i4mLZDZs2jbtyjcs+ozZ4fN6OLqr4RDm3i6PKPi8Uan6zSGQyux6B0WGsNi1B4WpFi+E3ZAx0RHBg
	kOiX7HG4zk2BH8NZc45dQX+6NYfFZ0c1D5rXUo9jM8LZTtN5uJkBPhwQRE+8FAo/NFVkyE0yin0Jw
	3Inxz8gybCPJx7Ysxm2jpDvYx7zylv09RuKTpA1zvFrrEnpua7luQWqFbAzEF5nvO4KE8FQpkoQ72
	pS9oIDYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFSkO-00000007hkZ-0R7E;
	Sat, 10 Oct 2026 08:48:04 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFSkM-00000007hjW-3eGD
	for kexec@lists.infradead.org;
	Sat, 10 Oct 2026 08:48:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4704143F5E;
	Sat, 10 Oct 2026 08:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D321F000FF;
	Sat, 10 Oct 2026 08:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791622082;
	bh=9aAKNdFlAWIBUhCteIbdgam8eQs/tWYWWSOa0TvAgNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a+QntHaBhv0z8VDbqJJkqrAwEbrFgBRg9/Xdm5ENmSUmHKoLcSJ8FMMZ1gUr4vKt2
	 kGmnMkcNDCeDjoev+XtP9mnEW/W3AbTtLQlms8kGI99KHAiN8gB4Ms0D0wlymWzpY3
	 A9bZ3rVrc8o9I5DkUPZn69Dq+TWk/7MmKxXr0QQB+04WP/nEaGg0ZWk5RR+xz+Bss8
	 7j/ghcFbgoFQw9puG4IAQz8wyGEuft4Vd85CchZXZtPtCYMZJC3Cw2LlLaQBeKgVQW
	 LkWEQNOgeGNWM1wyUpEfoQkQoV3dm7cHU5Fl9S+m6qv4N2Kw4TOV+2TKCNPET8VLZ9
	 VReZAo7MXRnpw==
Date: Sat, 10 Oct 2026 10:47:52 +0200
From: Mike Rapoport <rppt@kernel.org>
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
	Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v9 03/13] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <asn7uP123pDkdkSm@kernel.org>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-4-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918200640.887030-4-dmatlack@google.com>
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

Hi David,

On Fri, Sep 18, 2026 at 08:06:29PM +0000, David Matlack wrote:
> During PCI enumeration, the previous kernel might have passed state about
> devices that were preserved across kexec. The PCI core needs to fetch
> this state to identify which devices are "incoming" and require special
> handling.
> 
> Add pci_liveupdate_setup_device() which is called during device setup
> to fetch the serialized state (struct pci_ser) from the Live Update
> Orchestrator. The first time this happens, pci_flb_retrieve() will run
> and convert the array of pci_dev_ser structs into an xarray so that it
> can be looked up efficiently.

...

> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 3781e2b5f095..8af20f558086 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -273,7 +273,7 @@ config VGA_ARB_MAX_GPUS
>  
>  config PCI_LIVEUPDATE
>  	bool "PCI Live Update Support"
> -	depends on PCI && LIVEUPDATE
> +	depends on PCI && LIVEUPDATE && 64BIT

This could have been there from the first patch, no? :)

>  	help
>  	  Enable PCI core support for preserving PCI devices across Live
>  	  Update. This, in combination with support in a device's driver,

-- 
Sincerely yours,
Mike.

