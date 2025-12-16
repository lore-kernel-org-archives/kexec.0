Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CE8D5E374
	for <kexec@archiver.kernel.org>; Tue, 16 Dec 2025 14:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nNRRhRk29YGlyqb/BwG6GiFKvUFmbiQmfGQYctzC5Yk=; b=3F11TRyGND21PcSwgQaTrkRh6g
	Enz7cthb2U0PBApfQ7b+eeOQ5G8/fL77G42Qtun0EV11bXzmujc9E531wAlm5hVlNbA3NK9psE96D
	Ccx0S1JDNwEpFZ9U3oSJ/h500Y0bZij6+mCz44/stiJ6mbdB5EcLr+aIFCiJc4ivY+yz3mdXNqH3v
	iD/C+bt7gepps2LiCKEv4b2hj/jm0owc0ottSbFqS3CdKxhDRGUJlz4sxMEtKksfnuN6vU0zDr47r
	ZMNLUc0QGDLV1mnGwtAOMbDi/ouqQ5O3kYp3FY/02W6aXsZNoPWVe1cczr8lx6cJqREPKtpBTCy/Q
	PO0s0hUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVW0c-00000005L8G-1kV7;
	Tue, 16 Dec 2025 14:26:38 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVW0b-00000005L7U-1One
	for kexec@bombadil.infradead.org;
	Tue, 16 Dec 2025 14:26:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:CC:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nNRRhRk29YGlyqb/BwG6GiFKvUFmbiQmfGQYctzC5Yk=; b=nMPRJUrZ8/L6zJ4M6XNhEX2h6w
	yGWgjZuwqmLg8B8/o46SzOvqi6R7UxoiavUFLC1gnbsHJQyII4PtYsDZ5C/fgJwJZKrOFuWlCvWYQ
	R9gn/HSHZ/Wrh1vGf3I/sMqgRQcw1mePWuHCf3cxtd789s+UVQUYBa8ywpV2syywhrbfz3cO9g6Qc
	a7dPFrS472sk+m4ePz4q4y8++ckFh/KfI6TS3NDg/tMyOsgNFux0ZBLr9ixF4dZ1EYFrTOz1BjbE6
	Ho4u4uvoA5NqBaQsfBmTAChDAitNmElEV4N2OF5wDtWmuibM6jDQimc18Pm0Hznlu1/1vssa7taHh
	vRmjAe8g==;
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com ([52.35.192.45])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVV93-00000004tk8-2dcd
	for kexec@lists.infradead.org;
	Tue, 16 Dec 2025 13:31:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1765895192; x=1797431192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nNRRhRk29YGlyqb/BwG6GiFKvUFmbiQmfGQYctzC5Yk=;
  b=Ms4UxPk07nMCaqHR3EQ8YEYtuDdSH9P8TNShEYA8fJqk8axDC+z/d5+t
   KIw9QCyp+RUoC/b0smT/UkC5AnHbT1p5TC7noAdCK84nO9LjNPBOu8Wr3
   hN67nVSG5XzWLsHktuUrGjZBn886H4P3DwGJmG/36ElD2wrNTxbjsMVgL
   RQrkipZTChzfilZm5fSNNCrrCjZTS+BXDzpVVgFQK+8qQTOQkX+cSj22G
   nbwM0JLaYbiLqq8zmyGPSvnOKKvTv1XTdnoc3dRZfRVN25st1UVMIvXF0
   tVYk14MwVOYzQE87Po2a98jDlzmOO+FxNtboetWRRySH5pLcF0In2lsf4
   g==;
X-CSE-ConnectionGUID: 9TfYceSuRdWsExS5XeUv6g==
X-CSE-MsgGUID: mI+/LehNRlOk7YLzSag9nA==
X-IronPort-AV: E=Sophos;i="6.21,153,1763424000"; 
   d="scan'208";a="8968327"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 14:26:24 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:31014]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.61:2525] with esmtp (Farcaster)
 id a8fb656a-8250-4090-9976-2807247da5e7; Tue, 16 Dec 2025 14:26:24 +0000 (UTC)
X-Farcaster-Flow-ID: a8fb656a-8250-4090-9976-2807247da5e7
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 16 Dec 2025 14:26:22 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Tue, 16 Dec 2025
 14:26:20 +0000
Date: Tue, 16 Dec 2025 14:26:17 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Mike Rapoport <rppt@kernel.org>
CC: Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav
	<pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, Andrew Morton
	<akpm@linux-foundation.org>, Jason Miu <jasonmiu@google.com>,
	<linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-mm@kvack.org>, <nh-open-source@amazon.com>
Subject: Re: [PATCH] kho: add support for deferred struct page init
Message-ID: <aUFsCQclDWFu3KDE@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>
References: <20251216084913.86342-1-epetron@amazon.de>
 <aUFJH9xzJXYOt_X8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aUFJH9xzJXYOt_X8@kernel.org>
X-Originating-IP: [10.253.109.105]
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251216_133118_019032_84412E4D 
X-CRM114-Status: GOOD (  28.41  )
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

On Tue, Dec 16, 2025 at 01:57:19PM +0200 Mike Rapoport wrote:
> Hi Evangelos,
> 
> On Tue, Dec 16, 2025 at 08:49:12AM +0000, Evangelos Petrongonas wrote:
> > When `CONFIG_DEFERRED_STRUCT_PAGE_INIT` is enabled, struct page
> 
> No need for markup formatting in the changelog.
> 
ack

> > initialization is deferred to parallel kthreads that run later
> > in the boot process.
> > 
> > During KHO restoration, `deserialize_bitmap()` writes metadata for
> > each preserved memory region. However, if the struct page has not been
> > initialized, this write targets uninitialized memory, potentially
> > leading to errors like:
> > ```
> > BUG: unable to handle page fault for address: ...
> > ```
> > 
> > Fix this by introducing `kho_get_preserved_page()`,  which ensures
> > all struct pages in a preserved region are initialized by calling
> > `init_deferred_page()` which is a no-op when deferred init is disabled
> > or when the struct page is already initialized.
> > 
> > Fixes: 8b66ed2c3f42 ("kho: mm: don't allow deferred struct page with KHO")
> > Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> > ---
> 
> ...
> 
> > +static struct page *__init kho_get_preserved_page(phys_addr_t phys,
> > +						  unsigned int order)
> > +{
> > +	unsigned long pfn = PHYS_PFN(phys);
> > +	int nid = early_pfn_to_nid(pfn);
> > +
> > +	for (int i = 0; i < (1 << order); i++)
> > +		init_deferred_page(pfn + i, nid);
> 
> This will skip pages below node->first_deferred_pfn, we need to use
> __init_page_from_nid() here.
> 
Right, __init_page_from_nid() unconditionally initializes the page.

> > +
> > +	return pfn_to_page(pfn);
> > +}
> > +
> >  static void __init deserialize_bitmap(unsigned int order,
> >  				      struct khoser_mem_bitmap_ptr *elm)
> >  {
> > @@ -449,7 +466,7 @@ static void __init deserialize_bitmap(unsigned int order,
> >  		int sz = 1 << (order + PAGE_SHIFT);
> >  		phys_addr_t phys =
> >  			elm->phys_start + (bit << (order + PAGE_SHIFT));
> > -		struct page *page = phys_to_page(phys);
> > +		struct page *page = kho_get_preserved_page(phys, order);
> 
> I think it's better to initialize deferred struct pages later in
> kho_restore_page. deserialize_bitmap() runs before SMP and it already does
> heavy lifting of memblock_reserve()s. Delaying struct page initialization
> until restore makes it at least run in parallel with other initialization
> tasks.
> 
> I started to work on this just before plumbers and I have something
> untested here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=kho/deferred-page/v0.1
> 

Nice suggestion! I looked at your branch and I agree, your
approach seems better.

I also noticed your debug check:
```
	if (IS_ENABLED(CONFIG_KEXEC_HANDOVER_DEBUG))
		WARN_ON(nid != early_pfn_to_nid(pfn + i));
```

This catches, or at least allows for easier debugging of,
another potential (although unlinkely (?)) issue that my patch missed:
preserved pages spanning multiple NUMA nodes within a single higher-order
allocation. Nice to have this :)

I am happy to drop my patch in favor of yours. FWIW I have quickly
tested it both using the modified selftest and a custom payload and it
seems to be working fine. Please let me know once you post the patches.

> >  		union kho_page_info info;
> >  
> >  		memblock_reserve(phys, sz);
> > -- 
> > 2.43.0
> > 
> > 
> > 
> > 
> > Amazon Web Services Development Center Germany GmbH
> > Tamara-Danz-Str. 13
> > 10243 Berlin
> > Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
> > Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> > Sitz: Berlin
> > Ust-ID: DE 365 538 597
> > 
> 
> -- 
> Sincerely yours,
> Mike.

Kind Regards,
Evangelos



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


