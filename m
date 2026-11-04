Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7009E606BDC0
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BtoHirxR;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=YIn31Bxk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JAX2rOFX3ps0z7E54cgly2XJNYqW8YfGnVzidzlyKN4=; b=BtoHirxRTwT4YRBWwUaInBMLI5
	wC1GZxD+7nJtoiwHEhLgexW5FTqLY8rjR3BgRK38g+Cgb8tm84kGIMqpqo1TLEzpqAuLqvfda618H
	P9OLZSGyR63UNqHJkzsoAZLtdO0/38syYWgSSGHD6eBX/lHnJWAtiPB3EnlbpLArYIyngIR902HH6
	FcqmsVsP30pPtpfCrCW53KJZRsK9LWRSN+ItZczGAy1IXkmRdaF+sZD+ogLmzNeg8DoujoNVErTP8
	kqwKydfwQ1lDVdJAg5QqJBiWR+zAuRJBYD8iUnMYOlUjBXuzkrHbzGsHisR5GPZzLxYNwYSTihCSf
	1NEkkSZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOfHg-00000006LJH-0XOl;
	Wed, 04 Nov 2026 18:00:28 +0000
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOfHd-00000006LIv-3Q0Q
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 18:00:27 +0000
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-7c3b6e8225dso617200137.2
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 10:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793815224; x=1794420024; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JAX2rOFX3ps0z7E54cgly2XJNYqW8YfGnVzidzlyKN4=;
        b=YIn31BxkuQ44Q5lcW3mTfa5Wu7ors9/ZJ+ZHbdd1nID8SPraYB3THZoe6cwtb66dQI
         1k8O0SdaGJxjeOZBjHzQYkxc/Tjn9aM9uHL3HxFapJHReoE/1Gh6y+ZvFAw2RSfhanlx
         X6eAOYoxMrIxc4zsvxI0A6+bw8T1cT6ZHpCIcPM2vGHWe5b7W5MjjTciOPh9E32/OBB+
         W5OvncYJ/phj4PRcxvoOUupK+LzW+uVJ/GHJGX47kVxuRbo+1rlk//11yXIQsXvnQnkE
         cs1rJ8tyWvR6MiJcrB8yWzkW3Pt/IZf1SlGlq4zk7Gc2O4VEJGPW4uWf4hMT9FlKi6y1
         n9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793815224; x=1794420024;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JAX2rOFX3ps0z7E54cgly2XJNYqW8YfGnVzidzlyKN4=;
        b=fy8sPhRpXnJjhiseX+YwpYKfhWScWO440PQbDYRQu0rDTUy/9M9Co3YYOQTiG1R6Q1
         J42F/mfIAjcVtGCwh3X5uVDceVi6xsIvKQkqIzoSj3GIhAvaD8TmGwJKxJr3T8tB/i/6
         HACb/kmT4xVSXJRPt5n/EtMkPFa7/0MtgaqB7/ldVgTP3HFJofrcDLgMD31wdZYYlq9i
         CqeMkBe4/8csaVvm1M8aj+CvdO9CpCR2ZjH9AVWRWc9Hu8C8+ajM/HcgRq9YnPRzKw2H
         tNhGsOodsmWKaeUagXphckFiWRRQV2QCIPwC82i8UIKf4suS/Os5Inhve8U7uds5vn1z
         PeBA==
X-Gm-Message-State: APuU4Z9Iap46WKi5ia4EU4hqlbQO5+YBgcZusMELesKY/OC7wDeX3t3D
	hJqfvSGr1KNIcAwKf6kZf/LKprJybeng5BMSqmJ9lV9DsWM/98vKbmZwFmExDRwdSes=
X-Gm-Gg: AYBFou2YNCF/rSrYP99bKubPkHUIsdaePobvNwtCnvjhk401amGRHdBm6Pvkk0/WuxJ
	nWJiH8rMgW58qpkJ3tEFNzPcsKlV7SsqDXHFwiIwfTma2xusAy9SzAjbEVbHWBD7dHXATUosLIO
	0a436Tbu2SU3925OLFO2YyO7k+aqtzVY2ShiWe+K6DBcdk3IQPKXePdHB/0Lwtdahv4NfJvduSI
	4o35ma3QqtH054PHuAtljxj9nPDTEVZvc5HxlUP9Q1x/iYAm54gCOd3pGfZCBeVPJImzfNhGEyC
	wz5vzUYaVNc7aa38/B93JYpkV90H/zavDQEVhAamdoq+cUhpkyjteTbOXNUaCUvnPkLxmmkqBHO
	9vPj27ztB9CWMyoVD1EuNEOAk4SEPpofbInrpQ4N8hqJ+RolPs4nDKOXc7ZFxFH3JTdtk+CJ8u+
	fayqM3VLPZQt0mTyoL7LBHXzhZu+6vFQK9mgBzid8LMgFhHw3jThI2Tu/sc47Ayfn94I7UZjADI
	dXXaJJPXOcIjycTyddI5MpUr/KiwQZNxE99m92A9ABQi8D3NzvpiqmD56GWvLJhrMYRfS2QlyMs
	cBedEqQd4zMiPe79cqW9WyeE9p7nDDUTuqrz//aNUqozjaWXmBIVdPILXF6rT22P8/cPFwKuz70
	5bAeKvBsEqJfuU+JlxnKltmszt/hG
X-Received: by 2002:a05:6102:fa0:b0:7c3:9982:67d7 with SMTP id ada2fe7eead31-7d072670942mr7469213137.16.1793815224323;
        Wed, 04 Nov 2026 10:00:24 -0800 (PST)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d91d2a3asm2383636241.8.2026.11.04.10.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:00:23 -0800 (PST)
Date: Wed, 4 Nov 2026 13:00:22 -0500
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v10 00/13] PCI: liveupdate: PCI core support for Live
 Update
Message-ID: <autxCZPJ9yiE2ucq@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013162529.1928093-1-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_100025_900415_9F3FDEEA 
X-CRM114-Status: GOOD (  29.48  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10-13 16:25, David Matlack wrote:
> This series can be found on GitHub:
> 
>   https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v10
> 
> This series introduces support in the PCI core for Live Update, enabling
> drivers to preserve PCI devices across a kexec-based kernel update
> without interrupting the device. This functionality is critical for
> minimizing downtime in environments where PCI devices (e.g., those
> assigned to VMs via VFIO) must continue operating or maintain state
> across a host kernel upgrade.
> 
> Specifically, this series allows preserved PCI devices to perform
> uninterrupted memory transactions (DMA) targeting system memory
> (specifically, preserved memfds) across a Live Update. These devices can
> be behind a bridge but must not be VFs. Support for P2P and VF
> preservation will be addressed in future series.
> 
> Series Overview
> ---------------
> 
> This series implements the following to support PCI device preservation
> across Live Update:
> 
>   1. Set up a File-Lifecycle-Bound (FLB) handler to track and preserve
>      PCI-specific state (struct pci_ser) across Live Update using Kexec
>      Handover (KHO).
> 
>   2. Add APIs for drivers to register devices for preservation
>      (outgoing) and for the PCI core to identify preserved devices
>      during enumeration (incoming)
> 
>   3. Automatically preserve all upstream bridges for any preserved
>      endpoint. Use reference counting to ensure bridges remain preserved
>      as long as any downstream device is preserved.
> 
>   4. Guarantee that preserved devices retain the same RequesterID (bus,
>      device, function) for the duration of their preservation by
>      inheriting secondary bus numbers, subordinate bus numbers, and ARI
>      Forwarding Enable on preserved bridges.
> 
>   5. Guarantee that memory transactions to/from preserved devices are
>      routed consistently by inheriting Access Control Services (ACS)
>      flags across a Live Update, from the endpoint up to the root port.
> 
>   6. Modify the PCI shutdown path to avoid disabling bus mastering on
>      preserved devices, thereby allowing preserved devices to perform
>      uninterrupted during kexec for Live Update.
> 
>   7. Provide comprehensive documentation for the FLB API, device
>      tracking mechanisms, and the division of responsibilities between
>      the PCI core, drivers, and userspace.
> 
> Merge Plan
> ----------
> 
> This series will be merged through liveupdate.git, matching the
> agreed-upon tree in the MAINTAINERS entry for PCI LIVE UPDATE.
> 
> Testing
> -------
> 
> This series was tested in conjunction with v5 of the VFIO PCI driver
> series:
> 
>   https://lore.kernel.org/kvm/20260714151505.3466855-1-vipinsh@google.com/
> 
> The full set of patches used for testing can be found on GitHub.
> 
>   https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v10-with-vfio
> 
> Testing was performed using the new VFIO selftests:
> 
>   - vfio_pci_liveupdate_uapi_test
>   - vfio_pci_liveupdate_kexec_test
> 
> Both tests were run in a QEMU-based VM environment (using a single
> virtio-net PCIe device connected to a root port to exercise bridge
> support) and on bare metal using an Intel EMR server with 8x Intel DSA
> PCIe devices and 1x NVMe device.
> 
> Future Work
> -----------
> 
> Please see the PCI core Live Update Roadmap:
> 
>   https://lore.kernel.org/linux-pci/20261001232133.560284-1-dmatlack@google.com/
> 
> Changelog
> ---------
> 
> v10:
>  - Save and restore the ACS Egress Control Vector along with the ACS
>    Control register, sizing the save buffer from the HwInit Egress
>    Control Vector Size field (Alex) and drop Bjorn's R-b tag
>  - Make CONFIG_PCI_LIVEUPDATE depend on 64BIT from the first patch
>    rather than adding the dependency later in the series (Pratyush,
>    Mike)
>  - Reword kernel-doc comments to read better in the HTML docs and
>    spell out "reference count" (Mike)
>  - Replace the version number at the start of struct pci_ser with
>    required_flags and optional_flags, and record the size of struct
>    pci_dev_ser, so that the PCI FLB ABI can be extended (LPC BoF)

Hi Bjorn,

I am planning to target this series for the 7.5 merge window through the 
liveupdate tree, as we previously agreed. However, there are still 6 
patches that lack an Acked-by from you. I believe you might have 
reviewed some of them before, but the tags were lost during subsequent 
refactoring. Could you please take another look at the following to make 
sure everything is in order for us to merge the series:

PCI: liveupdate: Set up FLB handler for the PCI core
PCI: liveupdate: Track incoming preserved PCI devices
PCI: liveupdate: Document driver binding responsibilities
PCI: liveupdate: Auto-preserve upstream bridges across Live Update
PCI: Save and restore the ACS Control register and Egress Control Vector
PCI: liveupdate: Adopt ACS controls in incoming preserved devices

Thanks!

-- 
Pasha

