Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881A1C79FBB
	for <kexec@archiver.kernel.org>; Thu, 10 Sep 2026 23:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=EchVdgHD/jaEOcGNwu9K1D/RE/PHTaZPan+sGsBz7Hg=; b=laJIqFAprCxcOp
	+oEj3paBbtXTygTqJktFXnobiqTOjyYtV8slFEKjDcHewJSO43mLA7u2QRXDukq05VVVj7CiZLpDa
	Np1j+vHy91v8eWQ54u6pPCfKv4H19rEBZv4gfv02n5SFxw0N5IGna3fgB3VLdbl/v3dSMZwyV0DSA
	yCssLCyWiDXTA9kfOvW1ZJN/nTim+nP4/US/PilDAj4GNNYKFJQU6FjncnqwrNJqufapRaPGeqGdr
	+mRe+G2G+g1CDMDZRl8EqsPzwAT6j4OZ9x3/Fadw35N6i5xfOTh2Blwn2HVoyMvLQUAnRroDrQxjp
	3AxN0mrZUbeYeQfa5HxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4oYD-0000000FaOC-1dC9;
	Thu, 10 Sep 2026 23:51:29 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4oYC-0000000FaNv-1lj0
	for kexec@lists.infradead.org;
	Thu, 10 Sep 2026 23:51:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 14449439AC;
	Thu, 10 Sep 2026 23:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AF91F000FF;
	Thu, 10 Sep 2026 23:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789084288;
	bh=EchVdgHD/jaEOcGNwu9K1D/RE/PHTaZPan+sGsBz7Hg=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=eVJaDbr7TDZmKSMVzTSzTnbr6LHPdVB4T8TxUGUgkzVL2dnOJj+wLioEQMQFNT3ah
	 EDa8rpCFBgV+rnysoPzaOpgFMxYYbo6Pqs9IDGAnRjH1SCRWeQAno8HW7ro0Srunsp
	 TwjzW2QzUsiPSGwBN81N923kRd+vNzY/mtS3h5Mgqmm0nw5zmAtkqRGBLWuvO0dk/y
	 T7sC6NnhLKcVOV0B9w3Q2t3F20Bkgj7A8yWD4vKMGvehrAyuHIexfk0nS8hyD53iNM
	 M3Au8yPby2Gvs2mOCaOtk75szaMwkTrZFJK3RlCxg0htPYfabgJWieRiyt71eR9ILS
	 HiP7AziEsSSfg==
Date: Thu, 10 Sep 2026 18:51:26 -0500
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
Subject: Re: [PATCH v8 06/12] PCI: liveupdate: Auto-preserve upstream bridges
 across Live Update
Message-ID: <20260910235126.GA367952@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-7-dmatlack@google.com>
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

On Tue, Jul 28, 2026 at 10:10:00PM +0000, David Matlack wrote:
> When a PCI device is preserved across a Live Update, all of its upstream
> bridges up to the root port must also be preserved. This enables the PCI
> core and any drivers bound to the bridges to manage bridges correctly
> across a Live Update.
> 
> Notably, this will be used in subsequent commits to ensure that
> preserved devices can continue performing memory transactions without a
> disruption or change in routing.
> 
> To preserve bridges, the PCI core tracks the number of downstream
> devices preserved under each bridge using a reference count in struct
> pci_dev_ser. This allows a bridge to remain preserved until all its
> downstream preserved devices are unpreserved or finish their
> participation in the Live Update.

This seems to hint that we're going to allow bridge reconfiguration in
some cases, e.g., for hot-adds.  The simplest case is "leave config of
all bridges the same", and I thought that was what the previous patch
commit log said.

What's the benefit added by this patch?

