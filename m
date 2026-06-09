Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4B3CD8CAA
	for <kexec@archiver.kernel.org>; Tue,  9 Jun 2026 10:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=No+49IMmQGsjPk0qMclq8vTdt88psTr6uq6iD4QVA2E=; b=YLNJQrIfMf2gIOzK0+tmx0uYKt
	H6WZ3/MJrltpmAeilX9D84LEZ2m9D+uNfJsXTzIPKq3eUZe4zW3tMBdG4ExPKOVyCZ6pR6IFDzYFh
	bg3pqbvy7zFeM0EHCJYBQ/ss9HxbMHhHz0cFsqQY1V16NHAtIHb4IEeRPeUPG8HOHbt4M4pPwC2TW
	lQQCpVYbJzyTxpul0Y9YeiWBhPjXHjWjziF7Rg8tY4BySk53RZHZWVL8ggkFxAEDbtJf8RsGdF636
	gzCiHNvp/fgSfe3UqZYMc5nJMixHZhpUjNPi9hEOsnh+cbLLctKFc82CWeLeiqwAk418zz2t6efx9
	1FVeId5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWtxw-00000005NvW-32hT;
	Tue, 09 Jun 2026 10:45:52 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWtxu-00000005Nuy-0M03
	for kexec@lists.infradead.org;
	Tue, 09 Jun 2026 10:45:51 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2bf22c18ad3so504285ad.0
        for <kexec@lists.infradead.org>; Tue, 09 Jun 2026 03:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781001949; x=1781606749; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=No+49IMmQGsjPk0qMclq8vTdt88psTr6uq6iD4QVA2E=;
        b=Zth4bBV2fLhDpXGxRfnb6T9SWyH7q5dhKpqkhhbKwZojZAcoowjMYwkBEUbRYdWPOI
         5wBAGRkmgb52j2WIgrfrmkVx6byDuGMPYT72Hlhmws3eg22mm9Aygx22DWsvKeVKZfgN
         6auPC6k1XsqiYrEUHYPzWO/TYLpO32HqS/wSo7wuiY0LwVC33Q77tZoWKOaQ9KC+ynTY
         02xNKFTdVFifE39fxDVYPdJ7bl4QnKKuUtLK2q7gGDx0ZALOwUxMbA4UhosfJ8l9vGKg
         RZCPR8lHgasxYXWvEORGqFufJcM7YKAlHRPS5u4CTWRQBDGM0SRRH9gAlbseM/nvnI+G
         N+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781001949; x=1781606749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=No+49IMmQGsjPk0qMclq8vTdt88psTr6uq6iD4QVA2E=;
        b=WQoQ0O4R1fA1wRhNuQZQEE2KUumaOBIl6YZai/pfOn+F/snpWXu6yut6G661rymmEG
         IFu4G9lb62k8yJ9AMThQuSNK4bX3vZnFFfdSXqfLwpHx+tfPv7VgF5QzbEQHNhiEfa3W
         HwSUa6iaeeO618LMDXtb0zfYyCMZ7SQ+e/7/36+tNcALgLo2CB5/Qq+AwAiqf7OGTt9S
         ooDjX0obPUJrZU8cLtDjYzfOTrtvQ92CqFxV6Y3ZG8sT7waXA1HLI4vDxDMp0IP0B58I
         bGyDsC1XhLUQJaITRTiEpvoAd9ww/ew44yA/WWZqtKiyeHL2o4HaUzhewh3ts5Txv9GK
         Zv+A==
X-Gm-Message-State: AOJu0Yx+U5rz8HHJMHGA7Cuwo6aqjHmT3ef+YJm9wECW+o6gFtxQSi/o
	mh3DKZM8iMYZpxsfMkyWGB4qTSn6nilBdTJkXZVOC4KItVR/24As2gKv1pCk+AI12w==
X-Gm-Gg: Acq92OFGMByhsuFpXhAJ/7+XTfCCBFge9xFuy3xVTQ700TuhFotpGJYejJ1u0McF3in
	+IYRS51qbEVE1Zku6uqVS0VO8vVw12TZ737wlLrVDlqH5SiQuNde3+JpBGaGqOsaEiSQVOgeJbj
	1Wiwt+NbJ5eO/N4751r2GnRj3vhaLACTwHb21nJvEiuOl3DMo9v7i7YnI7pCozemPC8AXHQxYqM
	P5OoILRtOWybetmZKN9ENUtSo3MXSBM94gVmi5F7lnHJ5wERWYvF70a3RpISdo9og+bAv7cL3tD
	CTwjxNgNk33mto1bCSfo0xIuloNULBF/y81pQV2wUwfMPYlO3gTvKKVkhKjuJ/jTZ5XgfmGMWiw
	G9Vi44Ia40bNcEWLuwJvKarYPg7z/+NNj0/eaLOVdm75a+fSqHlDAm9Bejgnd5u0fMNytdKM2jG
	8koplo4QBbej2T+aHkTP1sbfmj/3hw4YdGUtUY9aJGDJn5puzFtoMhwOc+weFZqwsTfNopvH0=
X-Received: by 2002:a17:903:fa5:b0:2c1:ee6e:4e4c with SMTP id d9443c01a7336-2c1ee6e51e8mr7663135ad.29.1781001948407;
        Tue, 09 Jun 2026 03:45:48 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e228asm22864909b3a.47.2026.06.09.03.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:45:47 -0700 (PDT)
Date: Tue, 9 Jun 2026 10:45:39 +0000
From: Pranjal Shrivastava <praan@google.com>
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
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <aifu0wys8IENAK1C@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-2-dmatlack@google.com>
 <aiJhoq_Yj6-1Hl5r@google.com>
 <aicrNNVrMBtJD2iZ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aicrNNVrMBtJD2iZ@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_034550_131230_580969E8 
X-CRM114-Status: GOOD (  26.42  )
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

On Mon, Jun 08, 2026 at 08:51:00PM +0000, David Matlack wrote:
> On 2026-06-05 05:41 AM, Pranjal Shrivastava wrote:
> > On Fri, May 22, 2026 at 08:23:59PM +0000, David Matlack wrote:
> > > Set up a File-Lifecycle-Bound (FLB) handler for the PCI core to enable
> > > it to participate in the preservation of PCI devices across Live Update.
> > > Essentially, this commit enables the PCI core to allocate a struct
> > > (struct pci_ser) and preserve it across a Live Update whenever at least
> > > one device is preserved.
> > > 
> > > Preserving PCI devices across Live Update is built on top of the Live
> > > Update Orchestrator's (LUO) support for file preservation. Drivers are
> > > expected to expose a file to userspace to represent a single PCI device
> > > and support preservation of that file. This is intended primarily to
> > > support preservation of PCI devices bound to VFIO drivers.
> > > 

[...]

> > > + * struct pci_ser - PCI Subsystem Live Update State
> > > + *
> > > + * This struct tracks state about all devices that are being preserved across
> > > + * a Live Update for the next kernel.
> > > + *
> > > + * @max_nr_devices: The length of the devices[] flexible array.
> > > + * @nr_devices: The number of devices that were preserved.
> > > + * @devices: Flexible array of pci_dev_ser structs for each device.
> > > + */
> > > +struct pci_ser {
> > > +	u32 max_nr_devices;
> > > +	u32 nr_devices;
> > > +	struct pci_dev_ser devices[];
> > > +} __packed;
> > > +
> > > +/* Ensure all elements of devices[] are naturally aligned. */
> > > +static_assert(offsetof(struct pci_ser, devices) % sizeof(unsigned long) == 0);
> > > +static_assert(sizeof(struct pci_dev_ser) % sizeof(unsigned long) == 0);
> > 
> > Minor Nit: Shall we consider using specific bitwidth types here?
> > I'm wondering if down the line another u32 field is added to 
> > struct pci_dev_ser.. in that case on a 32-bit machine 12 % 4 == 0 but on
> > a 64-bit machine 12 % 8 != 0..
> 
> I think natural alignment is what matters for efficient access of the
> array elements. So failing the assert only on 64-bit architectures seems
> like the correct behavior.
> 

Ack. I guess what I was trying to say was we'd anyway need to keep both
architectures in mind, i.e. adding members should be 64-bit aligned
(which implicitly also handles 32-bit) as with the current assert
any new addition would have to be both 32 & 64-bit aligned. I guess we
can keep this as is.

Thanks,
Praan

