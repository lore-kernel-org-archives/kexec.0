Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60332C3DA6E
	for <kexec@archiver.kernel.org>; Mon,  8 Jan 2024 13:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H9EUwU8pG9DJ4NoqQtwuo+vNep7lCowsZf9tGOsoCj0=; b=JiQoxgaXPtnFDY
	6IFgGrr/3S6/asBZ+jZvt1Mn2DOjpAWhG95cU7cIOtKZIgmQTc/QgzBfiRxKz0aUuLyp3YFzUUPZD
	DsvWu2A0LLw0D0ftgdpghhFwapZRfd99IApWhO3JwkvD3r2dC5Dl43WdhgwLIngNGu8XwykeDSzWS
	Mj0a47IbEhUcM8JF0+tjEjM3G1/eRgLUGAC0UdekD5i4V7JYyjG/RVzhB2IGMfaTeUn006d6RL+kF
	RV/xIeXTBS9ZaK5YvEGAN55vn2GrCAG9/J2RwE2YkAYPZ6eICBbmnYcye6l+yQk/zJxmHrNyIHKhg
	hX13BAfLSziep4ZM5E5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMpnE-005EBb-0F;
	Mon, 08 Jan 2024 13:35:52 +0000
Received: from mgamail.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMpnA-005EAz-0d
	for kexec@lists.infradead.org;
	Mon, 08 Jan 2024 13:35:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704720948; x=1736256948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tvyxi9rLpB6tMw43Ff+F4ni44W91YgQK1/npXpO1cwc=;
  b=OuzkrlHSTa2iAW7N55JGtkFUYKasjU/iC3B68OXX96+4lhZRx6s95O+t
   bYCdL6xD980271fVsYsC5HqwgKs+bqS7TGQv38005tFO241IjU/OKcGHJ
   SBEEkhDkebRGkxtz47/de1OYY5kfPU7o53Uo2jntHU6K+5wBG+0U/o6MA
   W38zmIVVTTmYbX9U94v9spXBH4YjT1K/iQMthz8+uesFWl/PokV4y569e
   fjWQ+4SsybsUVv2gJ0dXmZJ0vZPB/0zHED/SJMB33t/FhPx3KoetoWHpo
   MAUFAsBMYuHPqoksLNpOuYssFjZn4qDo+L06MrXLlfciTmRswsW9AWiU0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="429064498"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="429064498"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 05:35:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="1028403682"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="1028403682"
Received: from ddraghic-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.212.53])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 05:35:39 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id D536E10498C; Mon,  8 Jan 2024 16:35:36 +0300 (+03)
Date: Mon, 8 Jan 2024 16:35:36 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"seanjc@google.com" <seanjc@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"bhe@redhat.com" <bhe@redhat.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv5 15/16] x86/mm: Introduce kernel_ident_mapping_free()
Message-ID: <20240108133536.7mi6oc2sfkumjqpv@box.shutemov.name>
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
 <20231222235209.32143-16-kirill.shutemov@linux.intel.com>
 <ba8265977a4b30f48b6b33fb135b714d5ada2a52.camel@intel.com>
 <3bddc0a0d69b6b18ce3fd568e6a7e6d7be8a1a11.camel@intel.com>
 <20240108101715.7hxn3wj6njemsf2x@box.shutemov.name>
 <b0dcc7016e6810791fa0aedbe7728a5deab29f5b.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b0dcc7016e6810791fa0aedbe7728a5deab29f5b.camel@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240108_053548_267586_D25FC1F0 
X-CRM114-Status: GOOD (  30.80  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Jan 08, 2024 at 01:13:18PM +0000, Huang, Kai wrote:
> On Mon, 2024-01-08 at 13:17 +0300, kirill.shutemov@linux.intel.com wrote:
> > On Mon, Jan 08, 2024 at 03:30:21AM +0000, Huang, Kai wrote:
> > > On Mon, 2024-01-08 at 03:13 +0000, Huang, Kai wrote:
> > > > On Sat, 2023-12-23 at 02:52 +0300, Kirill A. Shutemov wrote:
> > > > > The helper complements kernel_ident_mapping_init(): it frees the
> > > > > identity mapping that was previously allocated. It will be used in the
> > > > > error path to free a partially allocated mapping or if the mapping is no
> > > > > longer needed.
> > > > > 
> > > > > The caller provides a struct x86_mapping_info with the free_pgd_page()
> > > > > callback hooked up and the pgd_t to free.
> > > > > 
> > > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > > ---
> > > > >  arch/x86/include/asm/init.h |  3 ++
> > > > >  arch/x86/mm/ident_map.c     | 73 +++++++++++++++++++++++++++++++++++++
> > > > >  2 files changed, 76 insertions(+)
> > > > > 
> > > > > diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
> > > > > index cc9ccf61b6bd..14d72727d7ee 100644
> > > > > --- a/arch/x86/include/asm/init.h
> > > > > +++ b/arch/x86/include/asm/init.h
> > > > > @@ -6,6 +6,7 @@
> > > > >  
> > > > >  struct x86_mapping_info {
> > > > >  	void *(*alloc_pgt_page)(void *); /* allocate buf for page table */
> > > > > +	void (*free_pgt_page)(void *, void *); /* free buf for page table */
> > > > >  	void *context;			 /* context for alloc_pgt_page */
> > > > >  	unsigned long page_flag;	 /* page flag for PMD or PUD entry */
> > > > >  	unsigned long offset;		 /* ident mapping offset */
> > > > > @@ -16,4 +17,6 @@ struct x86_mapping_info {
> > > > >  int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
> > > > >  				unsigned long pstart, unsigned long pend);
> > > > >  
> > > > > +void kernel_ident_mapping_free(struct x86_mapping_info *info, pgd_t *pgd);
> > > > 
> > > > Maybe range-based free function can provide more flexibility (e.g., you can
> > > > directly call the free function to cleanup in kernel_ident_mapping_init()
> > > > internally when something goes wrong), but I guess this is sufficient for
> > > > current use case (and perhaps the majority use cases).
> > > > 
> > > > Reviewed-by: Kai Huang <kai.huang@intel.com>
> > > > 
> > > 
> > > Another argument of range-based free function is, theoretically you can build
> > > the identical mapping table using different x86_mapping_info on different
> > > ranges, thus it makes less sense to use one 'struct x86_mapping_info *info' to
> > > free the entire page table, albeit in this implementation only the
> > > 'free_pgt_page()' callback is used. 
> > 
> > The interface can be changed if there will be need for such behaviour.
> > This kind of future-proofing rarely helpful.
> > 
> 
> Do you want to just pass the 'free_pgt_page' function pointer to
> kernel_ident_mapping_free(), instead of 'struct x86_mapping_info *info'?  As
> mentioned above conceptually the page table can be built from multiple
> x86_mapping_info for multiple ranges.

I don't think we have such cases in kernel. Let's not overcomplicate
things. I see value in keeping interface symmetric.

We can always change things according to needs.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
