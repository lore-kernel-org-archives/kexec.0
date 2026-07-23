Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6467EC531CC
	for <kexec@archiver.kernel.org>; Thu, 23 Jul 2026 22:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zj8yGGu0ZvQspv+dm8spEGL6AmJp5gd8JQ+4SasQ24M=; b=ByhbYXfbd8ORy1hvKAtIug/E4g
	Ixp9s1q31iZ24jXD9tZK7SjmF+Ay96du3SryBqJXcFXrRdZLkn2nvyEZgOuZYgOhCOkClYqTjnBd5
	dXTiouvH2UE2nP24HYgX5K8GtXKVGTq78QnDJXjSS7vkWpzfDyf7urlFc2nvStaa6mD/CcE6Q2emQ
	Zrmr5ZGLB3vdYqfvMe8DRupleIAnRP1m4S2jPCZJzWSbvuWVhWpFdhJYiYCztSjPfXW4XqnKec0tT
	LB6Y5zSgkYRxtNyaMOCKoafqwhQP40bnsHCAtYzkfYuO2/MABVPxAjdFKaZljldIcpW14dp6rYXyX
	Jq1Ybk4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn2NT-0000000FEgz-00iU;
	Thu, 23 Jul 2026 22:58:55 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn2NQ-0000000FEga-2ssk
	for kexec@lists.infradead.org;
	Thu, 23 Jul 2026 22:58:54 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2cacef7d299so3085ad.1
        for <kexec@lists.infradead.org>; Thu, 23 Jul 2026 15:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784847531; x=1785452331; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zj8yGGu0ZvQspv+dm8spEGL6AmJp5gd8JQ+4SasQ24M=;
        b=scd7o+sZjuDgr3N00Kkhhu6g90R/TEG5GjiUJUsMCcC26UKxlaFLGez5AtyH4d9D8T
         +SnOlid+pQJG/OPvHibJ2cAFkVb1SGoB36jDCpW0FefyCh0MAq7G09y+0mXT/mXKB0Cx
         J2WBNmKoODgcvS7RFy0Xg1HY/t8rimU96BpzEOQ2k68RwUXBdGMnSGeSoVT7pl/OgyYk
         WAj6EMHesT9++rHgMVCKk2mRMMyaYXk+9FQ7Uyr3SEcmI4GxQisjiRnBBnT7SGztNxXO
         xHlCD7AX6F/vyiPvezNgMU9uFAdY0vc/yH0hdCSYsWs8uAF47oeK3hFVmhrsJaFOTemR
         Cs4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784847531; x=1785452331;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zj8yGGu0ZvQspv+dm8spEGL6AmJp5gd8JQ+4SasQ24M=;
        b=RcGfIs1xXvfBZIfppPnd1i5GVjZCyX4b/yu3q8GCBvt36kL1cMvygrj112KkAfiveP
         dl5/u5U6now+dcgEzDOl4omn42PkixPiJgiM2Ufu/4h6DeZ+8nduDmSc3dj6dWyt/Bps
         d7Mcj/zEOaIvuxEkY7HZgtLvElV1YKukKJCoDLw9+Qc3Aa2yfV1dvXuXhUrNVLFQljmA
         deSKK1ZNXtnIONvcJkdhuFF6iDuImQeKApcv3Ph6KwuhDbUZCQ2Hz5l2gsjKGhsDfXgK
         /DmPwujGuXZTLZ2gH4HgoThiNA91xdMWALfWaQvgRxTYIjaT9ROtjeo4V84pJhBt9yN9
         ADgA==
X-Forwarded-Encrypted: i=1; AHgh+Rr9iEYoc4Dl36rFZ5kNhKtJC7glD3cHcYD7BEI6/jATqwZdYcnoI/PcyvTjObWEU/zSeTHkjw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwWlaEf3YuQDa8HQSRHVHuw14B3BnhIz5/G3Iekg4RHPbXZIwgy
	roJLBe7eq8+Bh+o3j3RP3QwsAmQeMd08hQ2ibznxyL91OE+sguvls5DCLvaYg0fqKA==
X-Gm-Gg: AR+sD131+BUEU22ojs22Ga5GqUn7783SGB2Q4a4KkDIubDKi++/kXMJyckIUI2DyXOE
	/BcYvSq1YOa7VXVpceaCJovbPjHp18MTcUXLCq0dvu9eCE268GnOxeESShKCG9xw/+bmBQTqw6A
	3n0G8Q2IeSNDkdo0HC+pmf7apo3wo8oQg+ghwKLgP8cvO0+tZT3PFZH8GrO0auKfCO/G5jQTuly
	ImWJSjJogTTX0IVF6X9KIoh5SfPSGJT79HXRalJ+8U4JB6X8UWtpejCiUmqzv8ooO+tmG5awE6a
	Qz88xW1yDAjMT83yyqLltK+71766O+8pUL0ZS+UYQFzE+ubcRLTton6q8ychQLvt6TUSGpmCdvx
	32o1WjRaYRez9vudDad5713YiUvsDsFOldgyPQARcvs4J37vSqrw7FVv8tt6HOdJNh0c6bp6AgP
	CoVUJT15g1HC7OsWEnxAgmfS2/G8KlGxvCEr4FKWg=
X-Received: by 2002:a17:902:d4c6:b0:2c9:a222:47e0 with SMTP id d9443c01a7336-2cfc049d8efmr1917685ad.20.1784847530903;
        Thu, 23 Jul 2026 15:58:50 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17236924sm3686474b3a.7.2026.07.23.15.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 15:58:50 -0700 (PDT)
Date: Thu, 23 Jul 2026 15:58:45 -0700
From: Vipin Sharma <vipinsh@google.com>
To: alex@shazbot.org, rppt@kernel.org, pasha.tatashin@soleen.com, 
	pratyush@kernel.org
Cc: ajayachandra@nvidia.com, amastro@fb.com, ankita@nvidia.com, 
	apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, christian.koenig@amd.com, 
	corbet@lwn.net, dmatlack@google.com, graf@amazon.com, 
	jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com, 
	julianr@linux.ibm.com, kees@kernel.org, kevin.tian@intel.com, leon@kernel.org, 
	leonro@nvidia.com, lukas@wunner.de, mattev@meta.com, michal.winiarski@intel.com, 
	parav@nvidia.com, praan@google.com, rananta@google.com, rientjes@google.com, 
	rodrigo.vivi@intel.com, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 00/20] vfio/pci: Base Live Update support for VFIO
Message-ID: <20260723215749.GC260824.vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_155852_769874_8ACB62A1 
X-CRM114-Status: GOOD (  11.26  )
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

On Tue, Jul 14, 2026 at 08:14:45AM -0700, Vipin Sharma wrote:
> Hello,
> 
> This series can be found on Github:
> 
>   https://github.com/shvipin/linux vfio/liveupdate/v5
> 
> This series provides the base support to enable Live Update feature for
> VFIO PCI devices using the Live Update Orchestrator (LUO) and Kexec
> Handover (KHO).
> 

Hi Alex, Pasha, Mike, and Pratyush,

I'd like to discuss which maintainer tree should take the VFIO Live
Update series.

For context on related efforts:

  - PCI Live Update is targeting the Live Update tree (maintained by
    Pasha, Mike, and Pratyush, with David Matlack maintaining the
    PCI-specific code).
    https://lore.kernel.org/linux-pci/20260710212616.1351130-2-dmatlack@google.com/

  - IOMMU Live Update is planned to go through the IOMMU tree.
    https://lore.kernel.org/linux-iommu/20260614233728.2212104-3-skhawaja@google.com/

Given these different approaches, what is your preference for routing
the VFIO Live Update code?

Thanks
Vipin Sharma


