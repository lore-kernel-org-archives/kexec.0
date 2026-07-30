Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7396C55165
	for <kexec@archiver.kernel.org>; Thu, 30 Jul 2026 12:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jtRpHwnpz9cpARPetnCI9M1YK2PZpdz9An3dyVypqLg=; b=C2mTsG62yL9ex6M9RTzwUpf3s8
	VbLhvQ9bsFOy4Y+Bfpyfab+wtb1SSNYp0yT/GtRUdUgKtEdnqfmsNLsjfn4U5FbKq9j+eogc7uwCX
	cTLSSIMGmtRFdFvojkHfH88I3yu0m4yHGC+JtyhjFbIBkuYrtt8osGN9l23wSkWUwek4AgIuEqMTw
	/rO7p7hxzYx6BSIiazzYNI4cZThq/bwUfB+QRxRLOO5nGIg69/XI+pSKmYy8CjBjB4xMD9Ym9sjSK
	v6VUCG1yD+xRIgU4zsL/5b8685Vfq+0KfuJJ8QRXF2Sx7E0WY6UdQkBl47PU9iWpEkQLN9cw65EnY
	cV4vTaFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpPVz-0000000APyl-1j1P;
	Thu, 30 Jul 2026 12:05:31 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpPVv-0000000APwi-2ald
	for kexec@lists.infradead.org;
	Thu, 30 Jul 2026 12:05:28 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2cede6375caso95975ad.0
        for <kexec@lists.infradead.org>; Thu, 30 Jul 2026 05:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785413125; x=1786017925; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jtRpHwnpz9cpARPetnCI9M1YK2PZpdz9An3dyVypqLg=;
        b=QjJUM4yGO6Y80pDo37E06iCZmWH4W9LuWArFgxORpfq7PvUqqoAZPKBVKNohFVh4YB
         1ytAyYwE70dYZ9ioUH9AXwMDTIL7v4zbgWNBiSS5qfWX4NJApKLA32VbDrDY2sgVuWxy
         zpuRqZ3hVIzH2ARqt1T8CFkxvokDHb/4kZBfOw9umygYidluvwQUusZOC1E7lhQXtGRo
         hSoE5S81ebSUcobGZuw8AV2N8urpjvN02KY88qQwbavTDGgcwmjO6JszBjYz5z6UicvG
         KFnwd5rbJmE+avYGdj6SGedDWGTmsCUiPVuVU1qBTHrJConAXu3+QvSXgR1LA4xwnZvK
         BrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785413125; x=1786017925;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jtRpHwnpz9cpARPetnCI9M1YK2PZpdz9An3dyVypqLg=;
        b=pxjXen+u57pUJB3CmGwvjuRYYAuWdGGso1Y9atp1E8d3oHFEgyK0Ai+dttVPex9knm
         aq4xi2obR/p4Awz6tWfv8m8+FSgtM7TtDgTt1eCCZkwSEE8cmEeiHiFKcIRbMTfn62jl
         LoRBzddvLRG3deJoBsIVPx/Y7jkhdYSU/eyR3E+QpzGnON5bjSf3D+nE1kcK3vW1TSt+
         XebQSnJrFld+JioYMwyBCa7N8fXAWLBjlaiAolHKJefSW/NxGDfSLX6bv+gzDOK2xW+G
         827bCLfGhOeNoZA7vnuw20GI2WJ8ufczw0gO7tzH2u8rCBHbQS6oHZeFV2VKTDlyZgLh
         w6Ow==
X-Forwarded-Encrypted: i=1; AHgh+Rpr1V2Q/KGiewgDGrRmVtXl7rqAcDeZbwdsfz+YIAT6/z3M73eNM/V+aCw6PPtIAQLvhnx1CQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwWYLWSByuEDYG1HlRrQO/nOT4ZCPXemCLGaIN7AUpQYyAhVg5g
	vu9bvUaOjjPr+474E2M+xTwB+0FfCds7DPILYsSZTkVLPX+aAMYRbHV8zqb6jfW2cQ==
X-Gm-Gg: AR+sD123BEJ+qwEEDMpPg2yZaNHODt/eargtUv252LSldHutdmE77FlRElgm4zN10LN
	+sWfwQ1QoYBWZv0XsSQjifLWsEXeshacNXBiuRJcPLUYPxcT+lZhFcdhsKF9WV/Smffh8WBbNOn
	QIIKl+YyTXALQJQ8LpEmZ4ByiVNjQY2UOt9tU93ICiMvN+MtCvLkgIY8UOYLY987t9LprH3BEkL
	bMX6ouW4aQSk8G0iOhdjixfrD+KXI6aKDfdEf21pDNiciGguPqZvPWJ6r/hIauZVoZC/QCk9o27
	lCkYQNiFz1lkBRLYBSkyF1mc0GyirjJDi6s5OPl8peqJluSxL59AxuXea5HVRewyl2LrPVGKrew
	My9y/ic5tUWGDMC3jenkPINM0TKp5364eFoIR1Q0/ZDsAdkprFRhziMB7vFogIG1YlU7qOzRN6F
	UEl5FN7/8WJk+JfMfl+ItBPT/MLd7doiblkpvy8FTPANoVUBO67rLLNgk+2C3UaNrXVjCrNFeWR
	4endhWj0V4IKUTX3BF5ydo=
X-Received: by 2002:a17:902:f2d1:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2d03e47005bmr23875ad.2.1785413125046;
        Thu, 30 Jul 2026 05:05:25 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bc6d70sm26178725ad.39.2026.07.30.05.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 05:05:24 -0700 (PDT)
Date: Thu, 30 Jul 2026 12:05:18 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] kho: Introduce preserve/restore APIs for
 high-order pages
Message-ID: <ams9_pf-URoEYdWg@google.com>
References: <20260723204203.2997395-1-praan@google.com>
 <20260723204203.2997395-3-praan@google.com>
 <178539640188.2151126.10266644348178621151.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178539640188.2151126.10266644348178621151.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_050527_662065_ED8AAADD 
X-CRM114-Status: GOOD (  18.69  )
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

On Thu, Jul 30, 2026 at 10:26:41AM +0300, Mike Rapoport wrote:
> Hi Pranjal,
> 
> > The current KHO page preservation APIs (e.g. kho_preserve_pages) assume
> > that multi-page blocks are split into independent 4KB pages during
> > restoration. This is incompatible with high-order non-compound pages,
> > such as DMA buffers, which must be restored with tail pages having a
> > zero reference count.
> > 
> > Introduce explicit preserve and restore APIs for high-order pages,
> > which preserve and restore a high-order page block as a single unit,
> > applying a refcount of 1 to the head page while leaving tail pages at 0.
> > Rename the existing internal helper to __kho_restore_page() and
> > consolidate the common restoration code into it.
> > 
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> >
> > @@ -457,10 +482,14 @@ struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages)
> >  	while (pfn < end_pfn) {
> >  		const unsigned int order =
> >  			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
> > -		struct page *page = kho_restore_page(PFN_PHYS(pfn), false);
> > +		unsigned int info_order;
> > +		struct page *page = __kho_restore_page(PFN_PHYS(pfn), &info_order);
> >  
> >  		if (!page)
> >  			return NULL;
> > +
> > +		kho_init_pages(page, 1UL << info_order);
> > +		adjust_managed_page_count(page, 1UL << info_order);
> 
> Seeing 
> 
> +		adjust_managed_page_count(page, 1UL << info_order);
> 
> for the third time hinted that something is off ;-)
> 

Ack. I'll fold it into the __kho_restore_page() helper 

Thanks,
Praan

