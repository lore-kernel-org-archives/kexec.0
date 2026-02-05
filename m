Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB004EC1E83
	for <kexec@archiver.kernel.org>; Thu,  5 Feb 2026 09:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UwoH02zUpW5B4/exjaevJu1OcPGS6ZQCVZlCuGn50SI=; b=SFWDZvnt/26XLMJTbJUy4jVjlt
	+z8vcUCVjOXBr8rNP4GVfr8EXVgKx5rM+4dvUEitJ2mWNeqg961HH4QT4WystPinwrWwc0/C9xQx8
	gZhKEtiOMEtRUGrDttBMW/PTRGZhkyVqc1z++D5ucLNmolCUzqzV98GiEwzYaTrUrxk9xJXj/i4Xm
	PjCwlZ55KEBfN3AAKP6KcqQopK0DIY6Tr1a1lsbuORMdOFbSDIcCJA81GCegp2d9cgTS78ECEMvyM
	BGnF1+I5HlIQYlUZf7L373NyHv2bQQ6OV6ylXWy6ehRGkkAxmFfdmxMnv86G1qQdLl0IAouVvIAKV
	G/tLrgjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnvqG-00000009idZ-10Fi;
	Thu, 05 Feb 2026 09:40:04 +0000
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com ([52.35.192.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnvqD-00000009icR-2MXq
	for kexec@lists.infradead.org;
	Thu, 05 Feb 2026 09:40:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1770284401; x=1801820401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UwoH02zUpW5B4/exjaevJu1OcPGS6ZQCVZlCuGn50SI=;
  b=HJEEF0+hD9JVA0jtDqc6y5Umsu/Rde70wr8OHqLj1I9RZWT0z81jI1NE
   9mrs+/rn9h10bTbsuOQkKz0lum09NVoznW+pL+7RalkbgBfBGkR2ERTD2
   QF70GvAU3Mro6s/KPIKzmz0/Zw/UmWmZWptUFmB6eTZpv2b71VZnMbFM4
   AvPtcmkieVzePk4nixCIdrl6Hxzcv4wuPjKyZlWjQ3vgvItaN/zgN2JFF
   vUfDWscT3xd6flVxLmHF72QUJcO0NZKcu/0vep6vYP52Dpc742y7p58Xf
   KjRaodWjtSdh09hBLc1vaQ7SPvPK4aDuwhTu0JVPjJcOnGnLmzMV+Xlbv
   Q==;
X-CSE-ConnectionGUID: TWqUXnwdSpKEavVemP8cag==
X-CSE-MsgGUID: jyZJEdQnTZeBpphAIG31qA==
X-IronPort-AV: E=Sophos;i="6.21,274,1763424000"; 
   d="scan'208";a="12193809"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 09:39:53 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:9044]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.190:2525] with esmtp (Farcaster)
 id d0163fd9-f5d7-438c-b978-de77516db7d8; Thu, 5 Feb 2026 09:39:53 +0000 (UTC)
X-Farcaster-Flow-ID: d0163fd9-f5d7-438c-b978-de77516db7d8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Thu, 5 Feb 2026 09:39:53 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Thu, 5 Feb 2026
 09:39:51 +0000
Date: Thu, 5 Feb 2026 09:39:48 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Mike Rapoport <rppt@kernel.org>
CC: Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav
	<pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, Andrew Morton
	<akpm@linux-foundation.org>, Jason Miu <jasonmiu@google.com>,
	<linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-mm@kvack.org>, <nh-open-source@amazon.com>
Subject: Re: [PATCH] kho: add support for deferred struct page init
Message-ID: <20260205093948.GA96044@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>
References: <20251216084913.86342-1-epetron@amazon.de>
 <aYOToJvAUU0dmW94@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aYOToJvAUU0dmW94@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.253.109.105]
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_014001_668700_0E4E299C 
X-CRM114-Status: GOOD (  42.86  )
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

On Wed, Feb 04, 2026 at 08:44:48PM +0200 Mike Rapoport wrote:
> Hi Evangelos,
> 
> Are you planning to send a v2?
> 
> On Tue, Dec 16, 2025 at 08:49:12AM +0000, Evangelos Petrongonas wrote:

Hi Mike,
I am leaving soon for some AFK time, therefore I don't believe I will
post a v2 anytime before the beginning of March. Feel free (you or
anyone else) to send a patch. If a patch is sent until then I am happy,
to test it when I am back.

> > When `CONFIG_DEFERRED_STRUCT_PAGE_INIT` is enabled, struct page
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
> > ### Notes
> > @Jason, this patch should act as a temporary fix to make KHO play nice
> > with deferred struct page init until you post your ideas about splitting
> > "Physical Reservation" from "Metadata Restoration".
> > 
> > ### Testing
> > In order to test the fix, I modified the KHO selftest, to allocate more
> > memory and do so from higher memory to trigger the incompatibility. The
> > branch with those changes can be found in:
> > https://git.infradead.org/?p=users/vpetrog/linux.git;a=shortlog;h=refs/heads/kho-deferred-struct-page-init
> > 
> > In future patches, we might want to enhance the selftest to cover
> > this case as well. However, properly adopting the test for this
> > is much more work than the actual fix, therefore it can be deferred to a
> > follow-up series.
> > 
> > In addition attempting to run the selftest for arm (without my changes)
> > fails with:
> > ```
> > ERROR:target/arm/internals.h:767:regime_is_user: code should not be reached
> > Bail out! ERROR:target/arm/internals.h:767:regime_is_user: code should not be reached
> > ./tools/testing/selftests/kho/vmtest.sh: line 113: 61609 Aborted
> > ```
> > I have not looked it up further, but can also do so as part of a
> > selftest follow-up.
> > 
> >  kernel/liveupdate/Kconfig          |  2 --
> >  kernel/liveupdate/kexec_handover.c | 19 ++++++++++++++++++-
> >  2 files changed, 18 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
> > index d2aeaf13c3ac..9394a608f939 100644
> > --- a/kernel/liveupdate/Kconfig
> > +++ b/kernel/liveupdate/Kconfig
> > @@ -1,12 +1,10 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  
> >  menu "Live Update and Kexec HandOver"
> > -	depends on !DEFERRED_STRUCT_PAGE_INIT
> >  
> >  config KEXEC_HANDOVER
> >  	bool "kexec handover"
> >  	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
> > -	depends on !DEFERRED_STRUCT_PAGE_INIT
> >  	select MEMBLOCK_KHO_SCRATCH
> >  	select KEXEC_FILE
> >  	select LIBFDT
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> > index 9dc51fab604f..78cfe71e6107 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -439,6 +439,23 @@ static int kho_mem_serialize(struct kho_out *kho_out)
> >  	return err;
> >  }
> >  
> > +/*
> > + * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, struct pages in higher memory
> > + * regions may not be initialized yet at the time KHO deserializes preserved
> > + * memory. This function ensures all struct pages in the region are initialized.
> > + */
> > +static struct page *__init kho_get_preserved_page(phys_addr_t phys,
> > +						  unsigned int order)
> > +{
> > +	unsigned long pfn = PHYS_PFN(phys);
> > +	int nid = early_pfn_to_nid(pfn);
> > +
> > +	for (int i = 0; i < (1 << order); i++)
> > +		init_deferred_page(pfn + i, nid);
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

--
Kind Regards,
Evangelos




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


