Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D090AE9B245
	for <kexec@archiver.kernel.org>; Tue, 24 Feb 2026 09:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=24cju2hDHQ+kbJrPkzmdwVRuKgiC4K6oV6u1w7p/OMI=; b=r2l0f4Sfai8UuDvgZG9r6+d/C2
	ROX/ZRPBEifV3SWu+cxgM6rjixTwsv0mm/Esqg3tJlacC1A5t098FCxZvQCPfIujhmy6rET9tMgmL
	YUl7vFNuzXmLuhK1ca7PHuIYkTq22hivnFjG3K0rO4JDOUz9eDj/wvVs1Hr+DGePszaJTlGLVH/QW
	5rOfl6lv4GHvt3+anJ4JpoG3leegE3XJ0lgAAjFtfvAwR7FlJKY/kVrQAsalrd9OmVNbuXpJ3TGk5
	vfcooOR67CpyUmMJ43rF53/3mrGT5kkZJ6FRzfakyzR/Tg8zAu99LO5v8VdZU2tmiXafYH7R8Dbbj
	RC8dsHGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuoq1-00000001mDx-160H;
	Tue, 24 Feb 2026 09:36:17 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuopz-00000001mDS-1OWd
	for kexec@lists.infradead.org;
	Tue, 24 Feb 2026 09:36:16 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2adb1c1f9d4so15025ad.0
        for <kexec@lists.infradead.org>; Tue, 24 Feb 2026 01:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771925774; x=1772530574; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=24cju2hDHQ+kbJrPkzmdwVRuKgiC4K6oV6u1w7p/OMI=;
        b=Aw9jNuHeFvUO5SVclEPpf/d2FgEN+tt5Q8br9f6fw1bTLivmGaQdsYGg6B7lCaqkVz
         bUocfNXYkt4cVHiczoqa0CD2YtOcMMGtirEfInI/0YlU4ozfCkS6IU2eE4E+Qee6En7C
         oHIPqZYYWq4ejds7WzjBTXp5IelJKXu6D4jNWO7E6knlY0gH5Jgh22JK8rUcvdNJV0cH
         15DP0+mh4kPgVKFfj/JLhJvVFTIDVDwNihmJiNkp+SR9gg2yqqGk0qvxZDkjCKu0yb4o
         Z7faPdpq6F3xdf7mTlWJIzlMZzG6EN7/fGE5yy4VRTKwBwdKrL9zvr6GLm9Ehtp4vevx
         H20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771925774; x=1772530574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24cju2hDHQ+kbJrPkzmdwVRuKgiC4K6oV6u1w7p/OMI=;
        b=RElUmMsmBX0yWxik+eE8BlZdyX8/PcGi20KoGW7md0TwAFRN0SUqBMQe9mIy3HEP01
         jbNgm6ylMibXQFAuPiLBeKsBfwpz+1t+pmDAlvkbkuNGV9Cb8yCTtiJU8BuQmJakeo7H
         s2l5nyU77vNsSuzNFKRUXaVf/MRIFv6LMWUJzPyBLbwC9hWceHz277MW6KRxjB29eAWV
         xdW/h9xFF0O3t4bNpLpNzF/WnXEmIPq6QzAJZ/YeaxOG/WueXZHbM/ORiYDXLQUA82Qu
         CoWqPU7NiOWwM7s5eDMY9ntJ3J6KQ6snxiXxI1mcxFKrvkP1RzTrc34aIgyOr6vXPYEK
         rMhw==
X-Forwarded-Encrypted: i=1; AJvYcCVMYnMo9oT5BYE902VTajA1l2r8JxWgO4LkgljJcnibvD3DycAMFh0L8JK1mKmeaYknAGRVOw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw8gRlcumyy0Yd/+wHWpx4AI+IH3TFxb4Km06IF9+1+n43raCD2
	BTzu2zksyDl5uO7Vc2kgAeFxadnuU6dFK4/8MjUKulJY/B51C4LNn/BPEx3/0sREfw==
X-Gm-Gg: ATEYQzw9b4dpw0ipx7fZKDG4MwxSo+KYCiljhH7ZsnmQql6rBdtnKC90bR3LZSEMrKA
	5NWO4kUXcPCZW55DSE5eiCYpSNLI4zClbC1znwarfD9RdCYcGH9fPB3azfBKQQeozcoj2r+W+uX
	Nc0plcsWHZJ/WXZ66Dt4yOchzeMjcW6/o/VOtBebGr+17uNoTM+WHZrbEJ/GEy5TebxCv1lfL6H
	0C5ejhVeGpiwN+oh8SxI6+Xs2IL6PqIE/X8Q7c1jIHdezopI5Fu5mJKZf39e/3Pbl7HAujyBy2E
	+BMuUMDDRpQtz+6wPzJX6SzMiorKPnFC9TFVxHoVHwyCpqhQsTOPeId3bQuZV/G9zcKcfxVbM7s
	76krPUekMkou2cUvMAwfEFaXOkJYA9CbnSLUjvMhfouC4ribwYIs2uXNOzmupTRnh8UUoE/c3dq
	eaFdkOy7dj+LbEG+Kk7ksoZb3Sv43wCdBwObNkrUVL+LuY/OpmCPRp8cCma2F6
X-Received: by 2002:a17:902:e78f:b0:2a7:7f07:340e with SMTP id d9443c01a7336-2ad993a510cmr1492795ad.4.1771925773665;
        Tue, 24 Feb 2026 01:36:13 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b71a7351sm10754939a12.8.2026.02.24.01.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 01:36:13 -0800 (PST)
Date: Tue, 24 Feb 2026 09:36:03 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org,
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 03/22] PCI: Inherit bus numbers from previous kernel
 during Live Update
Message-ID: <aZ1xAyN0vgLWIi5y@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-4-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129212510.967611-4-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_013615_380755_9A6E5DCB 
X-CRM114-Status: GOOD (  27.29  )
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

On Thu, Jan 29, 2026 at 09:24:50PM +0000, David Matlack wrote:
> Inherit bus numbers from the previous kernel during a Live Update when
> one or more PCI devices are being preserved. This is necessary so that
> preserved devices can DMA through the IOMMU during a Live Update
> (changing bus numbers would break IOMMU translation).
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/probe.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index af6356c5a156..ca6e5f79debb 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1351,6 +1351,20 @@ static bool pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub)
>  	return true;
>  }
>  
> +static bool pci_assign_all_busses(void)
> +{
> +	/*
> +	 * During a Live Update where devices are preserved by the previous
> +	 * kernel, inherit all bus numbers assigned by the previous kernel. Bus
> +	 * numbers must remain stable for preserved devices so that they can
> +	 * perform DMA during the Live Update uninterrupted.
> +	 */
> +	if (pci_liveupdate_incoming_nr_devices())
> +		return false;

Following the comment on Patch 2 regarding propagating errors, the check
if (pci_liveupdate_incoming_nr_devices()) should be made explicit to 
distinguish between "Preservation Active" and "Retrieval Failed".

> +
> +	return pcibios_assign_all_busses();
> +}
> +
>  /*
>   * pci_scan_bridge_extend() - Scan buses behind a bridge
>   * @bus: Parent bus the bridge is on
> @@ -1378,6 +1392,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  				  int max, unsigned int available_buses,
>  				  int pass)
>  {
> +	bool assign_all_busses = pci_assign_all_busses();
>  	struct pci_bus *child;
>  	int is_cardbus = (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS);
>  	u32 buses, i, j = 0;
> @@ -1424,7 +1439,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
>  			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
>  
> -	if ((secondary || subordinate) && !pcibios_assign_all_busses() &&
> +	if ((secondary || subordinate) && !assign_all_busses &&
>  	    !is_cardbus && !broken) {
>  		unsigned int cmax, buses;
>  
> @@ -1467,7 +1482,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  		 * do in the second pass.
>  		 */
>  		if (!pass) {
> -			if (pcibios_assign_all_busses() || broken || is_cardbus)
> +			if (assign_all_busses || broken || is_cardbus)
>  
>  				/*
>  				 * Temporarily disable forwarding of the
> @@ -1542,7 +1557,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  							max+i+1))
>  					break;
>  				while (parent->parent) {
> -					if ((!pcibios_assign_all_busses()) &&
> +					if (!assign_all_busses &&
>  					    (parent->busn_res.end > max) &&
>  					    (parent->busn_res.end <= max+i)) {
>  						j = 1;

Looks like we over-ride the pci=assign-busses boot param here. 
We should document how this change affects the pci=assign-busses kernel
command line. If both are present, the inheritance required by LUO would
likely take precedence to prevent DMA corruption, but a doc update & a 
warning to the user would be nice.

Thanks,
Praan

