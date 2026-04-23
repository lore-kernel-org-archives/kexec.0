Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B32FDEE31
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 17:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q8pH7aIhkAAd4FmOdPYp3EielDOR+Hmc79iCFACzh0o=; b=uKflaO5uVohlvRJL0tiGsdR7ky
	IjsBue6zDduO4C711fje0DzShAFHSm7E6qvcMrYA8eWp5ja92zejyJD+xMJPQWYL0LU6Q4fES3m7b
	uEo1ISCgAH72JhsutqWE5OVISeiV5fP2q5F2WriekVF6wK7dWzDK1G1OvrovWp8BLDjaIj6j3TCpO
	32KJ3Pc5ECSP25FelpMjThzawbNfaygfVVYV17sknjUWkMfD41VH/roLALreNP24HsUP5Sv5EUzt+
	X8Qry1ZvC/56qv+0md7zzcyD6JoyoZEgMcWN10yZyxU29XcB5eN+G1em1HA2HRTjp05Bjee2T6h1K
	13GeDlSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFy45-0000000C4R1-24WF;
	Thu, 23 Apr 2026 17:42:13 +0000
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFy42-0000000C4QR-47lh
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 17:42:12 +0000
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-8d736211595so456775585a.0
        for <kexec@lists.infradead.org>; Thu, 23 Apr 2026 10:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776966129; x=1777570929; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q8pH7aIhkAAd4FmOdPYp3EielDOR+Hmc79iCFACzh0o=;
        b=KMsQPxH0xHNMxsJdaDaEw5DsnrgkejVUI9/LIrOUk6K2F6JGyKFZ1VzBYrsGw+S6be
         11rbMRa/FxhzWNBpTowdaIhjmgInHkmKwm6bb+glmT8m+U9Ps0TRmxdJ2GKEqVeVCbYq
         MGxhiEXzVUkNhqZPzmRx/+aJZsrurvH6oxxFqBxxveKrn4LO8ixuN6mN/uhvv0YHSE65
         adbX8UV5amzrKgtOyU/bWLm+4RQiNG+7mfneOJqV8t4iNQoHE1ckzXuNEkOrwdjQ0Gfv
         tQ6+vUeIyOIAlPfdxm/eMaUnuO5ZRog4QWi+pvpd+DztSJuW20YrWSG5Z+qRwNGqSlU/
         0KSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776966129; x=1777570929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8pH7aIhkAAd4FmOdPYp3EielDOR+Hmc79iCFACzh0o=;
        b=FYeGvq9nWBSmyrtQLZm4TbJ4nlK59AXuduretF5nZLYF7GsZLBlWr7HrQob4dCLm7e
         h8tWkpl5J1HLX6Fx/TYl1yM8IxNjX9SmkB//QpG85aygKLfdyvbfJ4zYt910rvReXpyu
         9tGenbdzednWi9R9dPHSQP1SBfRDK12RUZy8OamuMgv3zYsnvQ7gjDaQ+O1367XdDb6h
         Te0T1np3C/0n3Z/VhjVBf0YoLNXdUjQd8daXCnzaTauEFfRxEl2JxuajMKiCEnR2fNoe
         dlmLnKo1tpeSm92oWdhgTNNuNPsNSgxaP5WnveKOO6uuN+cMMJyBGvi9/sT5aFOVnjzd
         FNjA==
X-Forwarded-Encrypted: i=1; AFNElJ+/zHYw371V3OzTaTh+m+HuqV+4HbcFQCGCKWSPRifmEu1PVyrpOM5DKQP8fKnHtQqvv7z+aw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwcidthZZ2XDTyd24G7vmqfi/FpNh6KITAg4g+1VoucABAoMDSE
	YA5N8HTPwloj6Ox6RLPgcKbmGUGeNfARHsAzIXDMNprv58WmFsqdc7bBEEPBvs+tEmk=
X-Gm-Gg: AeBDieswmgf7Cro/Lv/5GS1FC183c5mB/0Vgn2Nqoud5UOHeKApxEKbNXXswBQMbquU
	5dNnFqzqIInxmkvSj2YeDsLbDW2wluqsnwSUMdgsc026jCWCfaeB08UCOhZlxbpqeNLBCtu4fLd
	Fdx2BT4ycvUMEwOHsL7S7gsXWD3UCa7Y/pUyTLlF2K3QX4XxJEbk54CzrCqScOjRLiYinw3sJxN
	1Ag/g+QNBLN16g0jz28WGfCczdNqMtJH9n7G30I8Jn4QlyC2xFO0cg3Ae6/LJX8PUaDdAeKoCeT
	M9mT1+kL01/7tBfa7qSV5E36DChhR9G3d70hpwiiu3sXrNU1J9emdxiwDwhIBHr7zIyvuyUWGtW
	lrzGTlsQsunk9bCelUZJ3XeSdOG52HeTcZCeuU+Fweq7OGDTpus6V7xsNu6dZIS7VWqVk7GtVZ/
	W6eltA54xmdVP0UlgaTx3XVtsrAakd0Mlxbw1m9yRVfxIciqp9BgX3oKMS1+cFYA==
X-Received: by 2002:a05:6214:8016:b0:8ac:b328:1314 with SMTP id 6a1803df08f44-8b028012885mr364606876d6.10.1776966128995;
        Thu, 23 Apr 2026 10:42:08 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac78513sm164398756d6.19.2026.04.23.10.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 10:42:08 -0700 (PDT)
Date: Thu, 23 Apr 2026 17:42:07 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Michal Clapinski <mclapinski@google.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v9 1/3] kho: fix deferred initialization of scratch areas
Message-ID: <aepZ4BAmfJ6_CtlG@plex>
References: <20260423122538.140993-1-mclapinski@google.com>
 <20260423122538.140993-2-mclapinski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423122538.140993-2-mclapinski@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_104211_021269_20BAEBDB 
X-CRM114-Status: UNSURE (   8.48  )
X-CRM114-Notice: Please train this message.
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

On 04-23 14:25, Michal Clapinski wrote:
> Currently, if CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled,
> kho_release_scratch() will initialize the struct pages and set migratetype
> of KHO scratch. Unless the whole scratch fits below first_deferred_pfn,
> some of that will be overwritten either by deferred_init_pages() or
> memmap_init_reserved_range().
> 
> To fix it, make memmap_init_range(), deferred_init_memmap_chunk() and
> __init_page_from_nid() recognize KHO scratch regions and set
> migratetype of pageblocks in those regions to MIGRATE_CMA.
> 
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Michal Clapinski <mclapinski@google.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

