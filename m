Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8B6CCFA13
	for <kexec@archiver.kernel.org>; Thu, 30 Apr 2026 20:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hkx4tLK7DpveuSLFftKdSSEC4NdhOfO2fjr8Ook6ULw=; b=SJ4B9NGpvEHVeHFm9Mq/NNdsio
	IstuIaIozAwmITAEVP79+ipyjrnSnpJaP4KH6ozG53MII729XAd3jPDffZhqUQlFy9SR56ux2+aiW
	1k2nt5bppN36ScAh7o6Kf1y6hHDxwyf3hygi/tAO0ZN05iI0Y/PNzvRfuk1goEFk9favlVnQmMecO
	e7F9aw94GeMVnI0Zyz+oAdYqFLP5UcTq16N9Fg9jjUlq9J0WRzjN6OgjIUfa0MfDvZfYODEsUjuFL
	W4Uf3ntD3HDLrHcwqSGpQ91OPWKZaVA2Guy/di6Fv9m9n7oauXGcO5BUWdffTTZAE4Jgaqh0LUOzu
	EjTBxK1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIYKB-00000005wKn-0h2i;
	Thu, 30 Apr 2026 20:49:31 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIYK8-00000005wKI-3FXj
	for kexec@lists.infradead.org;
	Thu, 30 Apr 2026 20:49:29 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-362bb3260f1so991831a91.2
        for <kexec@lists.infradead.org>; Thu, 30 Apr 2026 13:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777582168; x=1778186968; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hkx4tLK7DpveuSLFftKdSSEC4NdhOfO2fjr8Ook6ULw=;
        b=FfJpE/C+8Fm2hecllWLB1y6JNPBJLzmA/iCdkZ3nHKWnMo1K0gZ0bKW0GZk91BeluD
         BgIFN2UZ1sGbzFhFKdX7uCYJY00S6qGVr/lRNCj3aS9R50rb3XbkcufhquEDcbPVydSF
         ZDbk5mP8HTZnK35qmd1j+dbFrwc9N+SlBlJCLA/A92wIsfth5XYcYIu9ukR8cXNzblRK
         bAykWXpR816pt9oypzdOAfi1+RTIhD39NDtRKmanAtunMgEzof86bmn/8uW7VDQnmCyi
         +6dAptr1ik4lc8TJBqbnLdR72rl3RSHrpReaGE6PGwA+11DJ18wodr8Wxwv1YB3ZVmtJ
         2sxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777582168; x=1778186968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hkx4tLK7DpveuSLFftKdSSEC4NdhOfO2fjr8Ook6ULw=;
        b=cl15mHLIahtI3j6wKJj/qecvDaNIXPfpSs6Ddu9hQCbxrG65I7e9HfBRtZ8nOq3kpo
         VDe5NjErmDpM6dC7N7byy2BoRm87QBtpTy7PBE87xOV7QBhAvKV/g0ci54/dJrsEr7n+
         3YHtGAXnBnCLZG448FKQ1G0MvYVsFa5SMbT/MXe1pfI/JGiSncXKwir/vh7ikSo7SK4d
         h14i0bXceXXtk+AtheInRfZkwM29FtIxRtGAR5pJ1De+4z7exIaThDVglDmFCMcTTgkm
         UR3XL6rmybqC5c9cO/sKYTxJZdNgP77fxmDLbQ7pBzISxm+WrwN56dnxKwhGb3aYL72g
         rpWg==
X-Forwarded-Encrypted: i=1; AFNElJ/hhZpmj+emMsud9baKCqCgez1jqX5SPzelRe790X5BpQ2+9DXHVlyKc3lPi7kWl0rrbJYQ8A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy/eiuZiUoVqpusfWqGkkJkspZkQYg0PdiJn7TPZPCU99VBLWO6
	DFwoXtJI7cpHw/ESnzLVuPBgK4clN7wCBIreHS1fFjjo/DSus+ayBg0qUpypnGv4qA==
X-Gm-Gg: AeBDietqpGvZ9lplncuTxMOWFh0Y/lwu428ip2O+LIf1c9yL3/j3UsOlMpVqYQb7sDW
	cclCzV4x7Fr54n3VD2TmjZyTV2t+94W0+2tmVLGngeEofR+4ac/3JLxVX6Z/RJJOS0aRG60jaM+
	o2fpdRQBwEQ/AuQ9/CEcXZcGAuR0oTEOcsr/0I7QD8FBKNSQ0wG4aZ01xyE8z6Vy+HQiUcj51Fx
	ztEzKARVqOiooHYsJHZ1Fp5DsV58EUMctWn2T9SUHvMgArs3S+tCMLyubENowesOpeKcvhAeA0n
	UDAXqs+ckrcy22BN6oftXo0Mu4NZkdjefVqOcCbUBYfo+SSzKpKv2CnOzUdezzel8ENsqGGGsGz
	H+Pxm5G1Dox6+dGdnYblQdAw4a+4LwbHENL+D50p28kZberzkJuMnv3GiTFCqOqlwPRFPGG6N8k
	R0S4UKUActBLtB1NcCGMrfFt7SPNl6BIJIqlhyjJxFFTYOox99BXnIxsKPAzNb7gioEx9tQKFUE
	5+RoA==
X-Received: by 2002:a17:90b:3e4f:b0:35f:b288:8e4c with SMTP id 98e67ed59e1d1-364c30cb4f7mr4328476a91.15.1777582167388;
        Thu, 30 Apr 2026 13:49:27 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ec00b094sm307888a91.9.2026.04.30.13.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 13:49:26 -0700 (PDT)
Date: Thu, 30 Apr 2026 20:49:22 +0000
From: David Matlack <dmatlack@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
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
Subject: Re: [PATCH v4 08/11] PCI: liveupdate: Require preserved devices are
 in immutable singleton IOMMU groups
Message-ID: <afPAUiHoqoZl1-4I@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-9-dmatlack@google.com>
 <20260427135625.0000413e@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427135625.0000413e@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_134928_813674_F2D6E931 
X-CRM114-Status: GOOD (  12.80  )
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

On 2026-04-27 01:56 PM, Jacob Pan wrote:
> On Thu, 23 Apr 2026 21:23:12 +0000
> David Matlack <dmatlack@google.com> wrote:

> > +bool pci_device_group_immutable_singleton(struct pci_dev *dev)
> > +{
> > +	struct iommu_group *group;
> > +	struct group_device *d;
> > +	struct pci_bus *bus;
> > +	int nr_devices = 0;
> > +
> > +	group = iommu_group_get(&dev->dev);
> > +	if (!group)
> > +		return false;
> This may not work for noiommu mode where we could have a null group.
> Maybe I can add special case later?

Yeah depending which series goes in first. But based on the other thread
I am going to drop this patch from v5.


