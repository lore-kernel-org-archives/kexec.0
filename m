Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6780CD8C9D
	for <kexec@archiver.kernel.org>; Mon,  8 Jun 2026 11:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/AClK5b2UGJLL9HjNCJk/rNNqh+8+sTLcKYFLOrhzbk=; b=U3POyjCbZ3+qEM7SKtjUgSLz14
	uZJubf5F0kBwzrytzdMX2CvewXnBJ01+DkjfeWaaD03F/engr6ra27Gtj7dgIxE047pyStt28dXDc
	L2HT8VR1dHzKyH37itywcWNv8/ZpczzkNL1D/ywwNpUrRR3/t9hYiqLri6HbO7GutGLJCy2FRSs7x
	VN0iJOLnWefx8l4lAP1agfbTzAFzNG90evPcgNNRz8O1slA7nriQRtyswGE6PRgJ1PCE9oGIbwpvx
	XUdwx9mp5oFn5aebdmT+iz/mIp2c32nV52xdZxZHNgR1YaHkz8lpQ4sJOY2frxxRwWvPth6YKUMSQ
	yESjIMYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWYEK-00000003R2W-24Re;
	Mon, 08 Jun 2026 11:33:20 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWYEH-00000003R28-3wiw
	for kexec@lists.infradead.org;
	Mon, 08 Jun 2026 11:33:19 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2bf2d865383so300445ad.1
        for <kexec@lists.infradead.org>; Mon, 08 Jun 2026 04:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780918397; x=1781523197; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/AClK5b2UGJLL9HjNCJk/rNNqh+8+sTLcKYFLOrhzbk=;
        b=jLPr75nYPHdvpgDO6tbZ+/6/teBOQMCrsjTqNUOAYdcVCwFme4xGZQH2IOUP4ZZBOM
         G31mYa2wZHDpSHfCJOe8dbd1oY6OuqYby1gmx/mtYO/hV2dE6X4qeQ/jorSdzaueUWjw
         6HPaV9qzB9l4pyXRjJii14YqBCVsm4Vn3I/bvRtu3oudFakmAbbWJ+lFqaK/lfpxPpRi
         ZjFsN41owxd9x3WXmExv+5l6iWBIXmLfyh79uMLy3vA7W9iLSaTPVrXlVx6Znw2y2CmU
         X7oCjjLg301rlDiLM90ogbm3CSueLhPgQchmxvwstD3gjs1Mb70cLTxb7IHpjcQ29tXA
         K2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780918397; x=1781523197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AClK5b2UGJLL9HjNCJk/rNNqh+8+sTLcKYFLOrhzbk=;
        b=YWBfHhs2jxCkaeddvxVapWX+yviND6HZDgOh8zoh3PxcjGtWbUWA+x4FpHwbL4F+TK
         fsrtXTg07y8vLf559W7KDK2SC+y4mlkiGEVyz17vle/mwRDNpsAvVI32WFC3mOglKVyB
         kPSAPHarpoVJ04hxSS78Ft2pyIGGKXLixNxz7Cgf+GgReznjJ5J9UuNuzoOu9O+M2B8J
         rHJZODJhSceuRxLtekPq2FMk3Fj4VE7hQPAizgkIkSmw+2cRjf+M5BmpKR01hHr15Fck
         687Ns/WeFXLwgOWcA12peEFnAEUbeu7xlFjokUH6PjTXZ8dvSKAPT5PL/sEe3uVvWFes
         TFTw==
X-Gm-Message-State: AOJu0Yy56XHz9OaHcMQAQgjnMp1jHH6A7NNfi0FizNXIlFE/hsvb/MmK
	uvi55TTAJsgpcaxnxMh7o43mO+hD667v1/G2/D2CkKufDR4W+dwoUh/ti2Cxi+9B0Q==
X-Gm-Gg: Acq92OE9TmMCj35yc/JgvhkQvCcf8Q3424VpqMyvc7CbZXaSvJ1NclpBNFiXLrHK4W5
	6e3iZm9tUWAb9A8fr1F8/TKgKcnaEj2mUQEpOE9IZXvYKE7axuahTe8T1+DcN5oj0JCy+8+Zbei
	0UyWeEE8bDzPQJswDG/EIWErITzXGxhpsOlanDbwsUVKG5bc4DREWgR4yFJw2unjzpeRCbIz2K1
	sAljkrFjbhE5XefsXRFCrQW3RgkyylN8BFxyAEkb53DOHA4Dr1vArHr8BakamOCol8SHVYOfwjb
	jQR/duJ1C4Eww9dqwrCosFwrSLJQ0ULFnMAHTl1cVdpYTj2X3PBDTYwSB/N/HjsR/Rq8oMxrx0d
	OXOUZLePc2wqmPx8p/mtwB7lKU4ahC9Qz61GSDYTZ//8/uF5AcengPmO5mZmqyw2XZZl9CnVU00
	7JBWS1SfwQ9RyR/cxbvM9YJHxWKiU2yKmlGI+BcPuHqd1oHf9z1HkXt19/oDV45/zPNTlYIKI=
X-Received: by 2002:a17:903:2349:b0:2bd:3c1b:3073 with SMTP id d9443c01a7336-2c1ebea9c71mr4318635ad.16.1780918396547;
        Mon, 08 Jun 2026 04:33:16 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f9ed6csm182143405ad.31.2026.06.08.04.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 04:33:15 -0700 (PDT)
Date: Mon, 8 Jun 2026 11:33:07 +0000
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
Subject: Re: [PATCH v6 09/12] PCI: liveupdate: Inherit ARI Forwarding Enable
 on preserved bridges
Message-ID: <aiaoc6Y6qeF_5Wn9@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-10-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-10-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_043318_038255_CDF5A009 
X-CRM114-Status: GOOD (  26.03  )
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

On Fri, May 22, 2026 at 08:24:07PM +0000, David Matlack wrote:
> Inherit the ARI Forwarding Enable on preserved bridges and update
> pci_dev->ari_enabled accordingly during a Live Update. This ensures that
> the preserved devices on the bridge's secondary bus can be identified
> with the same expanded 8-bit function number after a Live Update.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/liveupdate.c | 18 ++++++++++++++++++
>  drivers/pci/liveupdate.h |  6 ++++++
>  drivers/pci/pci.c        |  8 +++++++-
>  3 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index a93b7ef065f2..701276ef6cfb 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -128,6 +128,10 @@
>   *    way after Live Update and ensures that IOMMU groups do not change. Note
>   *    that a device will use its inherited ACS flags for the lifetime of its
>   *    struct pci_dev (i.e. even after pci_liveupdate_finish()).
> + *
> + *  * The PCI core inherits ARI Forwarding Enable on all bridges with downstream
> + *    preserved devices to ensure that all preserved devices on the bridge's
> + *    secondary bus are addressable after the Live Update.
>   */
>  
>  #define pr_fmt(fmt) "PCI: liveupdate: " fmt
> @@ -756,6 +760,20 @@ int pci_liveupdate_enable_acs(struct pci_dev *dev)
>  	return 0;
>  }
>  
> +int pci_liveupdate_configure_ari(struct pci_dev *dev)
> +{
> +	u16 val;
> +
> +	guard(rwsem_read)(&pci_liveupdate.rwsem);
> +
> +	if (!dev->liveupdate.incoming)
> +		return -EINVAL;
> +
> +	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &val);

Again, I might be thinking out loud here, but since these are
hot-pluggable devices, with some FW / SW running on them, I'm a little
worried while assuming the HW registers can be trusted across a kexec.

Say, if the bridge experiences a reset (e.g. link drop etc) during the
kexec blackout, the PCI_EXP_DEVCTL2 register could revert to its default
state, meaning the ARI bit will be 0.

In that scenario, pci_liveupdate_configure_ari() will read 0, set
bridge->ari_enabled = false, and bypass the pci_configure_ari() logic
as well, permanently leaving ARI disabled on the bridge. Any preserved
downstream devices with function numbers > 7 will instantly become
unaddressable, breaking the Live Update. Even if that's desired it gets
hard to identify why the Liveupdate broke.

Should ari_enabled be serialized with bridge's pci_ser to ensure we
correctly restore / match it in case HW changed it during the kexec?

> +	dev->ari_enabled = !!(val & PCI_EXP_DEVCTL2_ARI);
> +	return 0;
> +}
> +

[...]

Thanks,
Praan

