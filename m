Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CBCCD8C89
	for <kexec@archiver.kernel.org>; Sun,  7 Jun 2026 19:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7bxnEjA/C3zuxdR051u14W5wOLjOO10IAKaN4C2htfQ=; b=lvUq7k9TTlcIUCLmeUKCZDFTs7
	QdxpKapJKXRkB9bUYfRlkAX8b2xZbEuwfnsHAVcSxvYOC4WdqsU2v2fNLQ7AeLMMjM2mN1BtXX4LS
	B0mC0Voif4Ef9pbB5UygVR2h9lHAgtB8W/Fav6p1kaGR3E0olRD7DJgqMEkLJOI4SMIRIKHR7pUWj
	cWkTD/cIQoP4lDjWpOjr23jevmPVsK65xMePy2tnhq87s2OKgagcM3jZd7entyNjFEWM5aMB9LYCk
	NOO9KnPK5cs9yGVKl1I2WQoWXEfI/qYWx6QJDkXaM2H3DBRDNwp5j9PBxAaFOL7JPEQIen8dwn6n/
	+gFIUXWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWIke-00000002R4K-1qNX;
	Sun, 07 Jun 2026 19:01:40 +0000
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWIkc-00000002R3w-23ml
	for kexec@lists.infradead.org;
	Sun, 07 Jun 2026 19:01:39 +0000
Received: by mail-dl1-x122c.google.com with SMTP id a92af1059eb24-1336742714fso24295c88.1
        for <kexec@lists.infradead.org>; Sun, 07 Jun 2026 12:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780858897; x=1781463697; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7bxnEjA/C3zuxdR051u14W5wOLjOO10IAKaN4C2htfQ=;
        b=nIKODfih6AuiCt9R5FCWgTMUqiSg5NcHShbXl1t1lrraFtyXSBqypUHaNODwqBR6af
         Q10DaGfpHgN2uZU21rB+v0wiA1hq9+5uIsKA5oBnX6AtJW86H/bCIfHTWb39iVCjOLp1
         uOcyfpADrcCZoRgYgfVCrHTlPAeN3s8ZKoLW/0datA8azROopm+k1Jhca9oT7q+1aB01
         8JauDMOog2NBywR2QCfAGpBlij+d0DkurgKDTKTIDExzmUop3Me8ydZpL3DprwnWzB/Y
         2S7P2TuiWaeLb+eJoPGzqKKMDQnZov8blcU7YEp5DtPx+/83a5tEg/hyoXXV9k2xrRBP
         OpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780858897; x=1781463697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bxnEjA/C3zuxdR051u14W5wOLjOO10IAKaN4C2htfQ=;
        b=ImdN1pwncfoNF4Vhlge+zBKkre1yq0xR/eP8qhgYgUVJZlq+SViPv5XbH3wqtT/8J0
         NAMcQSst9oYUtNaQ87c5lgo7IqZy512RxyP2r8fOVdpLI68Wp7C+jETo1qgFq8LdznZk
         jCsqk2OffsMu9/V970d23sKRtMDHTXP1BbBnJ8lp4O4QQSf23AUuYHACqixelWRZNsNg
         5ypRpkA5bhwGrjPZplZJ03vEVxQTENczQiUQRqxaDNtQm200QteyLetMz803bkUxi/Bb
         pmfTrFCZjk6njGm957cgHdIRN7cdiujPYvWw4oGar1pSM2Pw0+9SGvrH+5P4bX8BF76Q
         gxTQ==
X-Gm-Message-State: AOJu0Yz/acGTq+AMxFptOiwrleiaugUGWyPEDMVNd87Zm5NDxHsbErRW
	2P6W4AhoV5y50q1epuvhz1ztU0KBRIHqD3rtKWprbtfGf/pwyyME+KLQNuv2stuolQ==
X-Gm-Gg: Acq92OG+lfYxLWIORSGd/kGWeVHR6A9gxeShR+ZVPpAYyUJXzO1HfkyFBgtv63u8EBv
	xGVMIXLf+eeel58coL1BXhzYJiCkUgOs0axkb4qaMB+OL/04aB0ZKxxfpX8i2KdOx6YFlxL/BYT
	5haAyqESf6KrHfcb7uLwQTJVcYMHQpryutzJx4cYafXy0tef8nF0hVWTq0tJZfS+mFsj5YBJo4I
	oZ9Y1T1rRQOi4DOBn7cp/Fu76Jg7cWL0qspLHG1HbamKgHTOTs5Rwkx1L7Iw2tZv88OT21qmDBM
	Ej96rN/rXYPzdCGmCFhztJK6JbDnVup0mDYy2LMVfhQElqO5CZhdh9kiXzhWGkyyI2lD0ghGWfm
	5e4EAH3YYAKIPgBAfn/2FD6fkP7Vffp0Xy/grQdYtHg7Kcqil4BMuZkU+nG0AoxKS1S4z9aAqnp
	PjEHKFxe+MPXuVbpe6b7zmMQ6beiM/uzwe662qiqSjIR9mdTFCl/FTYiIcpK+8TbfBk1LPMR0=
X-Received: by 2002:a05:7022:23a2:b0:138:888:32de with SMTP id a92af1059eb24-13808883386mr174298c88.30.1780858894965;
        Sun, 07 Jun 2026 12:01:34 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea8e76sm13773740eec.18.2026.06.07.12.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 12:01:34 -0700 (PDT)
Date: Sun, 7 Jun 2026 19:01:25 +0000
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
Subject: Re: [PATCH v6 07/12] PCI: Refactor matching logic for pci_dev_acs_ops
Message-ID: <aiW_M7y0fFwLN84G@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-8-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-8-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260607_120138_560924_4AE7CFC1 
X-CRM114-Status: GOOD (  17.91  )
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

On Fri, May 22, 2026 at 08:24:05PM +0000, David Matlack wrote:
> Refactor the logic to match devices to pci_dev_acs_ops by factoring out
> the loop and device matching into its own routine. This eliminates some
> duplicate code between pci_dev_specific_enable_acs() and
> pci_dev_specific_disable_acs_redir(), and will also be used in a
> subsequent commit to check if a device requires device-specific
> enable_acs() during a Live Update.
> 
> No functional change intended.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/quirks.c | 50 ++++++++++++++++++--------------------------
>  1 file changed, 20 insertions(+), 30 deletions(-)
> 

[...]

>  } pci_dev_acs_ops[] = {
>  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
> +	    .match = pci_quirk_intel_pch_acs_match,
>  	    .enable_acs = pci_quirk_enable_intel_pch_acs,
>  	},
>  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
> +	    .match = pci_quirk_intel_spt_pch_acs_match,
>  	    .enable_acs = pci_quirk_enable_intel_spt_pch_acs,
>  	    .disable_acs_redir = pci_quirk_disable_intel_spt_pch_acs_redir,
>  	},
>  };
>  
> -int pci_dev_specific_enable_acs(struct pci_dev *dev)
> +static const struct pci_dev_acs_ops *pci_dev_acs_ops_get(struct pci_dev *dev)
>  {
>  	const struct pci_dev_acs_ops *p;
> -	int i, ret;
> +	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(pci_dev_acs_ops); i++) {
>  		p = &pci_dev_acs_ops[i];
> @@ -5481,33 +5475,29 @@ int pci_dev_specific_enable_acs(struct pci_dev *dev)
>  		     p->vendor == (u16)PCI_ANY_ID) &&
>  		    (p->device == dev->device ||
>  		     p->device == (u16)PCI_ANY_ID) &&
> -		    p->enable_acs) {
> -			ret = p->enable_acs(dev);
> -			if (ret >= 0)
> -				return ret;
> -		}
> +		    p->match(dev))
> +			return p;

Nit:
Should we check if (p->match != NULL) like we check for p->enable_acs &
p->disable_acs_redir(). 

Otherwise, it seems like we're mandating the existence of a match op in
the pci_dev_acs_ops here? Today, we just have two Intel entries in that
array, both of which need the match op. However, AFAICT, it shouldn't be
mandatory for future SoCs that might only need a simple vid + devid match

[...]

with that nit:
Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

