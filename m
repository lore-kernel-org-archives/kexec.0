Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B8DCD8CA7
	for <kexec@archiver.kernel.org>; Mon,  8 Jun 2026 21:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/VPaRCEiFTRGJk9h7XnzGq6197n1Ij6plODDt3+seDY=; b=bdVWS2vYFSwAovudbw5fm2K63+
	/rs3TTLcaEdbNAtFg+1apt5saYZTbxYnak2jtdEPYd32YmZWilAaFT9BrcTT/m9AHR6perjM4FuNo
	P+ENIhd/4kMiDC6XFodoNEBggvt5bAxz1vnuj8rJDmYSuSWa2p8lirG8JXQ8XJysOSdW4MF6WVTMR
	ngYkwnXnILS25BxvS7Zoh2atPEAzTAji1WQb/51ErGcP13V0NHNW/ez3jddLo82ek/7bUDTUQF6jB
	WtmlmkS7Rf45aWqYTArBht7i95hrp9t5X6ZrducJOUXCUs7BgnMkVPf8OIf3me6edKKG6BZ2uY63w
	g5fYhH+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWhqh-00000004SAn-3fuj;
	Mon, 08 Jun 2026 21:49:35 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWhqf-00000004SAM-1JHc
	for kexec@lists.infradead.org;
	Mon, 08 Jun 2026 21:49:34 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-8422f395a4aso2959782b3a.0
        for <kexec@lists.infradead.org>; Mon, 08 Jun 2026 14:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780955372; x=1781560172; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/VPaRCEiFTRGJk9h7XnzGq6197n1Ij6plODDt3+seDY=;
        b=W3h+T58eSFGvYF1m/RWFdlB33lUVQlPQK7hvNzNgX4JatKFPfbL3tjKh8G7OMzJwVy
         8l4Yoy0OL7ssjQlLTQMgHAR9YthB1kRm7hJJojASX/t434BOr9ufpxUqj9G8O4y0gCYG
         fugPMrNFjMvZtF55FF78vYjGclHoj7L1J6N8Z+ooGF33dzPdDsxOJADIX26mQ+tXzYsF
         +u2wX3IMOzMl5hVrR4g8r3TynFoaLR/QAnPzfJZLKF8ipT031xmmOz2/wO5w5Q95CeaE
         acmMoc4GOtPjdMn5HbaSqao131/gkmS7um/Rv8up7/q1WsZtz4NS1nZ7EbEWS8b6AjnK
         cquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780955372; x=1781560172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VPaRCEiFTRGJk9h7XnzGq6197n1Ij6plODDt3+seDY=;
        b=sUp4Au2mClUy+ULhhaOiyx5++UonhodXThrwqGH5SQdVaNw4y5dw8WNVektaVe/tUH
         gALQGq2WJfg4YiYb+p2ws/dRXQzBLuL3uUCZ0JgCP4AFqd+dqISQcuaYdez5SzUYms91
         +eRsJ+LS8u7OeGePUL9W+hRTJnY2uuMjn4Fmp3x7+f2/V9rEJWlKCotQkCO4ScKby6CF
         46sNVQDypKWMP79pET4AEg0VUcN4jjHYKwKSISHwQWgZToxskZRt4Qma1jA+wbM9aAtu
         MI2IUBrAiysn3NOfzL4+pr8J8thN62br0+DXtFpUbv9hQ8lZDlbJ/brY1NYRfeDr/YOu
         6c6A==
X-Gm-Message-State: AOJu0YxwSus2n1yO8Fslk0uGUuX3dJtchfdzNZ2fz8HZZPzgtYNLgjFO
	j1LGbCMmM8rHU9IPvzHSaeeizG2sE8c+DuLsLmicI6yBnfnoDnaUJuHn91+3Pi1Lwg==
X-Gm-Gg: Acq92OHn+gmoYiY6EJWjWjdi/kI9N0I1y5WbrHNXNLWV3Rw37eehocKGaw6PLt0uP7Z
	jqgodrZr6AT7MtdVvGi1qTQt5h+JARej58lOjwcY9+m6ma7FqclnqE5oSQ6hIpWH+dimSABiaKS
	Gw1tt40i8TbK+hWIYNiLRlZC3hN+rtZ/t1M4BvUGSiXJwQUXFV5KuowHsLaf0+OM6nYv+jurqBj
	JwDW66pP1RSn9LeIoy/NhTYrnzxp9L1U4NnAi9r7BTMU69DE6PcEJW4awmdZU/6ZjkgGtRmjdNV
	NPGMQlOCH2exSD9hyey17Uw3kVogHcOBudT77hd4CDb5MDTBcV5hItNpvMTg4Wkv0sfZd+sIAdx
	9dbXb68o81A2fii0uDTfiFNQR9lnPOgeIgY1yCoIv8qfveiMmdbcuryGUl7PdgZjMxoeV34rzJw
	NKBfAw7nKWT08B2zMi5Kj/VbqWs9pTf8dq+xu+BH3MRUakrcpfNwgrafw2s7XX9XO7+dzXPGLA
X-Received: by 2002:a05:6a00:4f81:b0:835:3861:812c with SMTP id d2e1a72fcca58-842b67b0a55mr12776470b3a.23.1780955372050;
        Mon, 08 Jun 2026 14:49:32 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428288002asm18941791b3a.31.2026.06.08.14.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:49:31 -0700 (PDT)
Date: Mon, 8 Jun 2026 21:49:28 +0000
From: David Matlack <dmatlack@google.com>
To: Pranjal Shrivastava <praan@google.com>
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
Message-ID: <aic46OtIKfLhdoKy@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-8-dmatlack@google.com>
 <aiW_M7y0fFwLN84G@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiW_M7y0fFwLN84G@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_144933_357594_F3438CC8 
X-CRM114-Status: GOOD (  25.30  )
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

On 2026-06-07 07:01 PM, Pranjal Shrivastava wrote:
> On Fri, May 22, 2026 at 08:24:05PM +0000, David Matlack wrote:
> > Refactor the logic to match devices to pci_dev_acs_ops by factoring out
> > the loop and device matching into its own routine. This eliminates some
> > duplicate code between pci_dev_specific_enable_acs() and
> > pci_dev_specific_disable_acs_redir(), and will also be used in a
> > subsequent commit to check if a device requires device-specific
> > enable_acs() during a Live Update.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> >  drivers/pci/quirks.c | 50 ++++++++++++++++++--------------------------
> >  1 file changed, 20 insertions(+), 30 deletions(-)
> > 
> 
> [...]
> 
> >  } pci_dev_acs_ops[] = {
> >  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
> > +	    .match = pci_quirk_intel_pch_acs_match,
> >  	    .enable_acs = pci_quirk_enable_intel_pch_acs,
> >  	},
> >  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
> > +	    .match = pci_quirk_intel_spt_pch_acs_match,
> >  	    .enable_acs = pci_quirk_enable_intel_spt_pch_acs,
> >  	    .disable_acs_redir = pci_quirk_disable_intel_spt_pch_acs_redir,
> >  	},
> >  };
> >  
> > -int pci_dev_specific_enable_acs(struct pci_dev *dev)
> > +static const struct pci_dev_acs_ops *pci_dev_acs_ops_get(struct pci_dev *dev)
> >  {
> >  	const struct pci_dev_acs_ops *p;
> > -	int i, ret;
> > +	int i;
> >  
> >  	for (i = 0; i < ARRAY_SIZE(pci_dev_acs_ops); i++) {
> >  		p = &pci_dev_acs_ops[i];
> > @@ -5481,33 +5475,29 @@ int pci_dev_specific_enable_acs(struct pci_dev *dev)
> >  		     p->vendor == (u16)PCI_ANY_ID) &&
> >  		    (p->device == dev->device ||
> >  		     p->device == (u16)PCI_ANY_ID) &&
> > -		    p->enable_acs) {
> > -			ret = p->enable_acs(dev);
> > -			if (ret >= 0)
> > -				return ret;
> > -		}
> > +		    p->match(dev))
> > +			return p;
> 
> Nit:
> Should we check if (p->match != NULL) like we check for p->enable_acs &
> p->disable_acs_redir(). 
> 
> Otherwise, it seems like we're mandating the existence of a match op in
> the pci_dev_acs_ops here? Today, we just have two Intel entries in that
> array, both of which need the match op. However, AFAICT, it shouldn't be
> mandatory for future SoCs that might only need a simple vid + devid match

*shrug*

I would usually say those future SoCs should be the ones to make it
optional if and when they need to.

But making p->matc optional now isn't so bad:

        for (i = 0; i < ARRAY_SIZE(pci_dev_acs_ops); i++) {
                p = &pci_dev_acs_ops[i];
                if ((p->vendor == dev->vendor ||
                     p->vendor == (u16)PCI_ANY_ID) &&
                    (p->device == dev->device ||
-                    p->device == (u16)PCI_ANY_ID) &&
-                   p->enable_acs) {
-                       ret = p->enable_acs(dev);
-                       if (ret >= 0)
-                               return ret;
+                    p->device == (u16)PCI_ANY_ID)) {
+                       if (!p->match || p->match(dev))
+                               return p;
                }
        }

I can include this in v7 if you would like.


> 
> [...]
> 
> with that nit:
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> 
> Thanks,
> Praan

