Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B6AFF8867
	for <kexec@archiver.kernel.org>; Tue, 28 Apr 2026 00:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tW+6Pw0a8+ahYm3oOFUJTtBa/jkSN4mmIAQkMqykSWk=; b=4wMrUEo3exR6Evgw4vUZkWm1D/
	TySeFPf9W9c771hUDSDHwLNyIoy/FX04KO9l/g3w56csy/9T2kuA/X3wvhkjIIWSRogiAJTop1sfy
	2NmexJ/1/9Vhv+Wupu1gjjPJ6ADcAKiwSEmOzK4wmQ9UUfcDrSqgrcxKs1Xik5S0PKo7kt9fYjX2I
	i5Yt5+B7evgTDMr4iPsYRe5K1Yf8lgivZ61V4Sbqe9mATtxjA7K0/AbjbKbd4rYLnH+En2NBOwkE9
	YVCY7uyooCwfec5dH4cUtl5AcpDlBoDDMswgumHy/B7B6sbALgSxYGfCjJdUkMtyMuxoKm3CEGBp2
	dAazwoxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHVs0-00000000Jsw-0CzZ;
	Tue, 28 Apr 2026 00:00:08 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHVrx-00000000JsY-0XEs
	for kexec@lists.infradead.org;
	Tue, 28 Apr 2026 00:00:06 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-82f8bf96b46so5176822b3a.2
        for <kexec@lists.infradead.org>; Mon, 27 Apr 2026 17:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777334404; x=1777939204; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tW+6Pw0a8+ahYm3oOFUJTtBa/jkSN4mmIAQkMqykSWk=;
        b=YBv1EbXdOQwQHkcnkBqkdGzg8a/iyGqWKyeQoxtru+jM+jjEOrQ0DD32FqgPVmh/Rl
         HpjTFo7kpJbLfMPMWhyyWJWh1swQ1/e2iek7OXdnoMT4KbDHGTMUhybkxa8s+b/VU8SB
         jIDsZHxHC/PFi+WtKzjaB+/ymN4hM8pHsmcex/HBok/vjn3WWqsCuj3ntAFG5NaBb/Pm
         Rb5rM9wp9StByZxTKG2v4fwlvqu+XCz9SuY/hlsNzsVi4f87nZqw8zI3XVnSp75AU1O8
         sTGo4m/lk6va2gJ2/sfJrfg1d90QvbL5a6se7Ik17pUIriNcIu1Cx12BXVRMoFNTHRlR
         fGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777334404; x=1777939204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tW+6Pw0a8+ahYm3oOFUJTtBa/jkSN4mmIAQkMqykSWk=;
        b=ZrNMD9Eqh8l0pB9wP2bckml/h1W0gKhFabVwiFEt7N8YJO0dlf5Gu3E4HZ0gREkLzV
         wB0UQfmE8t2EdEzcKCqggDaMMEQg/YWAaE2OsE2cSwQ044Iva9qLqvBP9Bjedzo0Ec5J
         9uSNPlhqvrzkonWZHxRN5lvq25r64kHDhGtPFsE5LSCczIqHed2KQc36Mc5Ld6GS9b9u
         weUeOYUviOxk4aHEU7lHNv1RQiIJWB262+IQz7MbcRK8yadKPqrFUpccISxLnXg8jmYc
         KBB71G2tZ5k+f1qq5ugCsX+nRSVFU47INAmdb0K+aL+fnNr/2MgkSgXLPBMcDiX8EyM4
         4Bjg==
X-Forwarded-Encrypted: i=1; AFNElJ9urC6JKrh+WAoAO/fzH3pGBVwt7reqG+zwWudDy7WeTxkg+jmaTessxegDBpfFN1dZ54rA/A==@lists.infradead.org
X-Gm-Message-State: AOJu0YyvF7NSE7X5AC6pCFPf6D7c1ds0JLYtiFWm5ejttcTM1wO4gbXO
	2gCCeq7EylQPrcb54pO6MDr4btBHp2ZbeHno+c5icfJGY/qb2X9OUnInARiveZ8S7A==
X-Gm-Gg: AeBDievU7dBbY6N/mwQloV+yO6SbBCwpY4b2nSfdoYX8ni1vM+h2GdwKpV/PN7/Ff/7
	ok58I+n2iSrcU2/pRQ4X5wjbUK2bYQw5cAo3oIteqBWJVxcZHpiQD7D48oHmMAk1KsRPimD6pds
	TGBd9kdUkP/pPjWhYl1DFI5GIpmP6XksGmY1fm/QCLtgbvHC3BRo5VmgUQ3DxJFDo4NgC2Nmrzn
	QcuurxMFFRe7TRivaIp+KriFdLLqb/NPBFt6ORILzW3JU5n0PVYLYJgumhT8E8Ax0wM8glLOpGW
	sLSYOP/bZMo7VHVaf9omNoqp+hsUlVKr+QPv/81DjsJuN4UlNUwEyjWeZktIf95d1qtWg/uacgk
	RfTabda/iIAlAoTo3QpBuE14fkeP1mMN1EQq2Y6jbAF+KpzTzo2qWigSreMymoxQMTgcHNjIFf+
	uSZVSZjdoNncb+w0DNihrfjEeGDQC5wwIm/Zf1twrn4WyjBjXa2xq+IXz/1lzIjIduSDylc2Q6g
	X3qXA==
X-Received: by 2002:a05:6a00:1885:b0:82f:1d38:f68d with SMTP id d2e1a72fcca58-834ddc22f16mr638227b3a.34.1777334403001;
        Mon, 27 Apr 2026 17:00:03 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf7f43bsm633995b3a.58.2026.04.27.17.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 17:00:01 -0700 (PDT)
Date: Mon, 27 Apr 2026 23:59:58 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, iommu@lists.linux.dev,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
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
	Pranjal Shrivastava <praan@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 01/11] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <ae_4fg_18Rli2_Nt@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-2-dmatlack@google.com>
 <2vxzeck45yin.fsf@kernel.org>
 <aetvAkM0y45WAmfV@plex>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aetvAkM0y45WAmfV@plex>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_170005_172252_67D8713C 
X-CRM114-Status: GOOD (  29.11  )
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

On 2026-04-24 01:29 PM, Pasha Tatashin wrote:
> On 04-24 14:33, Pratyush Yadav wrote:
> > Hi David,
> > 
> > On Thu, Apr 23 2026, David Matlack wrote:
> > [...]
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index c9b7b6f9828e..94af31837375 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -20555,6 +20555,18 @@ L:	linux-pci@vger.kernel.org
> > >  S:	Supported
> > >  F:	Documentation/PCI/pci-error-recovery.rst
> > >  
> > > +PCI LIVE UPDATE
> > > +M:	Bjorn Helgaas <bhelgaas@google.com>
> > > +M:	David Matlack <dmatlack@google.com>
> > > +L:	linux-pci@vger.kernel.org
> > > +S:	Supported
> > > +Q:	https://patchwork.kernel.org/project/linux-pci/list/
> > > +B:	https://bugzilla.kernel.org
> > > +C:	irc://irc.oftc.net/linux-pci
> > > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> > > +F:	drivers/pci/liveupdate.c
> > > +F:	include/linux/kho/abi/pci.h
> > > +
> > 
> > Can we please also add these files under the "LIVE UPDATE" entry. The
> > code here concerns both live update and PCI.

Covering that intersection of Live Update and PCI was exactly my
intention with introducing this new PCI LIVE UPDATE entry. This ensures
we have maintenance coverage with knowledge of that intersection.

> > We can figure out the
> > maintenance details as we go along, but I think the live update
> > maintainers should at least get all the patches for PCI live update.

Would adding kexec@ here be sufficient or do you want to be CC'd
directly?

If you want to be CC'd directly do you think makes more sense to add the
Live Update maintainers as Reviewers under PCI LIVE UPDATE, or add
drivers/pci/liveupdate.c under LIVE UPDATE?

> > 
> > Perhaps also add the kexec list here? We plan to use it to maintain the
> > LUO patches, and adding it will make sure we get the patches in case
> > someone updates the file list here but forgets to update it in the LIVE
> > UPDATE entry.
> 
> +1
> 
> These files should also be added to the Live Update entry, and the kexec
> mailing list should be included.
> 
> Changes specific to Live Update should be routed through the
> liveupdate/linux.git tree, while generic PCI changes should go through
> pci/pci.git. In either case, if liveupdate.c or abi/pci.h are modified,
> acks are required from the Live Update group.

Do you want to merge changes to drivers/pci/liveupdate.c through the
live update tree or PCI tree? We should probably decide now. I was
assuming the PCI tree since its part of PCI core.

As we project this out there are going to be users of the Live Update
API across different parts of the kernel: PCI core, IOMMU core, IOMMU
drivers, VFIO core, VFIO PCI drivers, and KVM. I don't think it will
scale to take all that code through the live update tree.

