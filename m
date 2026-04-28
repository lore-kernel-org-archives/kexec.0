Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C892FF885A
	for <kexec@archiver.kernel.org>; Tue, 28 Apr 2026 19:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DQ/Dt/O+th05aIC11KQd/tiOeex8kzc+/1s7j7TCtCI=; b=YlpIF5kQeVpwXVkVmYVQuctBO+
	ehhIBUePjDqEQZBxq8dApUbEHFyTNwMgu/BjN0A3bmy73DewCbgYfAtzrWTkqvRNdDqhTDkJ2UxbC
	VM+yV8EgZcMzRUSCmFP0SFrFnyMFHAOkWwr0nkw3j5XtwzPrIfoE2m1QoINfRn2mg7nc6ivD9sBD2
	klmXT0UQ1vhXmkQuSXP4skQnUmuzYy2VAVZpulR1/xg58Jy170ila6ay7WNh24etpB2YFcDVJJ3XB
	t/sIQnBBJfzDMtBfzAFtwlapY2tE+Cn6yEH6YKuuHxTS4tfTMmzTjWnpK3neMoQWFx0aR0+OIDHMn
	hIeMGEjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHoNb-00000002B6X-24J2;
	Tue, 28 Apr 2026 19:45:59 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHoNY-00000002B6C-2d8D
	for kexec@lists.infradead.org;
	Tue, 28 Apr 2026 19:45:57 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso10805ad.0
        for <kexec@lists.infradead.org>; Tue, 28 Apr 2026 12:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777405555; x=1778010355; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DQ/Dt/O+th05aIC11KQd/tiOeex8kzc+/1s7j7TCtCI=;
        b=vGFVw9oNRO8TMJkdQI3vqBvtjmJPvUkXRKc38Wm8EWSrVp9cjqwO9BHfZrpdbri6rL
         gWHhckZIDE0TzlFR7L62DP+8tCIYqgrqcWmI83b+DIyK8i/e//HKJImUrmvnfqjs2gq2
         Y8sMhlLCCQgfUuSKvXwnWEY8W9NAPSwET1UDN8ZY3fljUVZn9ENDomLiqae/VVWgwfmS
         BndcaiuyeXyZiBqgy6qnkfl9IF9ONUmZJfMUrIrgXFjE6Idu44G8tCpPm38ecWGuoB2T
         rEsm/Fbk+0UGaV8Dogj5YSNih3gOu+MpOq4y303NuT8JzGYrHetA47wIZmPBI5VKgaL9
         3QuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777405555; x=1778010355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQ/Dt/O+th05aIC11KQd/tiOeex8kzc+/1s7j7TCtCI=;
        b=ncJgXbDqBtMvbsrqjPM3KJURbJW6Dxtyn/lNuHHbawd3ejop0NmsLhN/2jxCqtue0A
         TjP4Kwqjk8/cg6Y7xUnJUIlf3X1uDz33bQiK86DMK9I9QaY1lID1sMLWlO6ejkVeZgJO
         aVGp1tJhVr2lm4aGJ/zecpkUd/Nu/kCYWuXgzuQhCAyJ1RB0sotTWQ9xZEAtEcK1phQq
         pGfZpSzlF4NHzVUJ8rP4ONPiBUDPoLXuX2I30/qCtIQWnVmEbNR+Ge0r9F3ySiy1AObE
         11XarRZNls3JPYRJb+aDwnypDbY5Ood0wT2BrTODgqhY6B8S/kA5v3YbLdokjdcbr9rH
         MswQ==
X-Forwarded-Encrypted: i=1; AFNElJ9bopQiJQpSEHJiiqG46oUcsw+cvfeK15lfPVp5M2UuO36+Co3sui8BrwqqFQUbwd8xPd3ACg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx73dLJmXn0t6sJlY085U/jEjsQgYi3fF3fSUM3c1un8dH1BZMy
	JLp+G9KjkTNb17Uk+HCq9DfTKsu8orhhc0HnkPwPjqjQu/nUVUYe08U4b7aeyRJ4Qw==
X-Gm-Gg: AeBDiesfDjELOngbzfgEicyCenm/7+gqO09o1xu+MLNMFjAbG+/fKEXL9Ie5CKbEURa
	QSPAm9LgZJqmaAx018v6L1AkMdfRCFCXJ65pcCLVDbmoV9jAmPhUGNhZJaVdvPb5aWsi2qTTiXY
	s8KUb9VP4ZcyNCm9xOrECIKSJQZ8uP4UE1tzGse+kJ5IYxGIkuUezZ8i65FVe84or+VXIAFsaih
	riQYS5sqgWw2lg4hbyvthH3DZw+Pl5HuNouRV0YZiwk0boU6ynzqMyh+NQnZOZ5zCR0yzYblnQX
	Ql1VcOxeGN8acX9ViQdr6W0p9AgLaFI5BqBODapmIkk799rwzJcpzVEsThJY8xTFXCKeq+7VhtS
	XroyS8MJD8nWsazlW5AJMtESOXvGkmGQyyFwP146mgyZbRsDDMf69KdNgIuCC5z8F77caOcX4tV
	YWp8OAy/3GDXe2jyfdGR6oGSr1bqk4GFkNLgP+aMnRdAjgTUOYG+3znDF8F77SFxSWFTwapHjX/
	B2hJKWOY0Po7lW+gg==
X-Received: by 2002:a17:902:d58a:b0:2b2:5931:5950 with SMTP id d9443c01a7336-2b987eb5398mr770645ad.16.1777405553961;
        Tue, 28 Apr 2026 12:45:53 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a2732502sm41657a91.3.2026.04.28.12.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 12:45:53 -0700 (PDT)
Date: Tue, 28 Apr 2026 12:45:48 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 01/11] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <20260428185242.GB3825533.vipinsh@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-2-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423212316.3431746-2-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_124556_694630_110E830B 
X-CRM114-Status: GOOD (  14.41  )
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
> +	pr_debug("Preserving struct pci_ser with room for %u devices\n",
> +		 max_nr_devices);
> +
> +	ser = kho_alloc_preserve(size);
> +	if (IS_ERR(ser))
> +		return PTR_ERR(ser);

Should there be a similar pr_debug() in case of failure to denote that above
"Preserving ..." message didn't finish, or, maybe just print one
pr_debug() after the error check above?

> +/**
> + * struct pci_dev_ser - Serialized state about a single PCI device.
> + *
> + * @domain: The device's PCI domain number (segment).
> + * @bdf: The device's PCI bus, device, and function number.
> + * @reserved: Reserved (to naturally align struct pci_dev_ser).
> + */
> +struct pci_dev_ser {
> +	u32 domain;
> +	u16 bdf;
> +	u16 reserved;

Should this be renamed to 'u8 __padding[2];' instead? This will allow to
just change the array length based on the need (0, 1, 2, 3).

> +} __packed;
> +
> +/**
> + * struct pci_ser - PCI Subsystem Live Update State
> + *
> + * This struct tracks state about all devices that are being preserved across
> + * a Live Update for the next kernel.
> + *
> + * @max_nr_devices: The length of the devices[] flexible array.
> + * @nr_devices: The number of devices that were preserved.
> + * @devices: Flexible array of pci_dev_ser structs for each device.
> + */
> +struct pci_ser {
> +	u32 max_nr_devices;
> +	u32 nr_devices;
> +	struct pci_dev_ser devices[];
> +} __packed;
> +
> +/* Ensure all elements of devices[] are naturally aligned. */
> +static_assert(offsetof(struct pci_ser, devices) % sizeof(unsigned long) == 0);
> +static_assert(sizeof(struct pci_dev_ser) % sizeof(unsigned long) == 0);

Nit: Maybe move this assert to be near to the definition of this struct,
easier to find it when editing the struct vs finding it later during
build.


