Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB62CC48BC3
	for <kexec@archiver.kernel.org>; Mon, 19 Feb 2024 13:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6zwGpS8/28fL6arY2O6ZZsstqjWSvQV3sIbDteST8e0=; b=qtOr0BtWbmbiHk
	hof5PGBBUi0v0+YexB7w1oAdjChdBMWp6Rysz/pCruYEycl7etF3H7v20T0mxMD1UMV6uhMYFJfdQ
	9m4yFPO8u5ayUOyI9+OUz1fLtvY9+RHjm5Ed3gjaQ3ERVvKG0SzfwA6iROzmQGEO80v3+qGkQ2npe
	eO1T5AKJqF/ZCIZ9cuHJZjtnhQ/tP8M5qBB9udx/fiZhYeOajHuIiVRmICdSroXHXt+lAG24JVqUI
	P48rYhDhXyJXj1ebxC2QpkN82yyqP0Ha7P0RK/E6smcy6txAPAcrzsGZ+hYx5/8mXdw1l0e3Sn68a
	DwUykhGWOginnlk1LYBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc44h-0000000AjME-1Z9e;
	Mon, 19 Feb 2024 13:52:51 +0000
Received: from mgamail.intel.com ([198.175.65.21])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc44f-0000000AjLG-0FO2
	for kexec@lists.infradead.org;
	Mon, 19 Feb 2024 13:52:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708350769; x=1739886769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yPMBSovixa7VCIL6tvi34aVw1yfzyVwmD5bVU4sWDNs=;
  b=Tc/bkRfGnH4tYpL/cBr5WitRPSTgOrL23TXriReGdfImOMUUU74uqM3m
   bESGZ9ZdOkgDuPEgypuD+z9yqtQm7xqP/sbVXc/LV8Q6+Y0I1hP3b1ZVq
   jZDyylLtPDO2hi4X6KSZhh10lpVl/xLsIDfUTGInK5KI5G3SY600Fe9ao
   u59pdyyX94B5fhC5EhhyBR7LVyLdlwtrA4j6CKE5buvp6XQBX+ryFOWYR
   8pP/2yI9tcsP1K7DqBhTtvMyHA2m4yySKTqz8vBTTcLcytsS+YRDZI3Zt
   dzH0Ib+38RtviMrNUMsH1PICl/HxE4TN+ZCabej+JgTOulOwAXIdKuIdP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2333805"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2333805"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 05:52:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="936293708"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936293708"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2024 05:52:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9DC35350; Mon, 19 Feb 2024 15:52:41 +0200 (EET)
Date: Mon, 19 Feb 2024 15:52:41 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Baoquan He <bhe@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 07/16] x86/mm: Return correct level from
 lookup_address() if pte is none
Message-ID: <zhbhgq27kjrhkdgbxomjykjez2i4hckguvmxyptvfvoftue5ca@zowl5qbl6psl>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-8-kirill.shutemov@linux.intel.com>
 <ZdLjQCaxhOnR+GzX@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZdLjQCaxhOnR+GzX@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_055249_192180_B3D8B0FD 
X-CRM114-Status: GOOD (  22.56  )
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

On Mon, Feb 19, 2024 at 01:12:32PM +0800, Baoquan He wrote:
> On 02/12/24 at 12:44pm, Kirill A. Shutemov wrote:
> > lookup_address() only returns correct page table level for the entry if
> > the entry is not none.
> > 
> > Make the helper to always return correct 'level'. It allows to implement
> > iterator over kernel page tables using lookup_address().
> > 
> > Add one more entry into enum pg_level to indicate size of VA covered by
> > one PGD entry in 5-level paging mode.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > ---
> >  arch/x86/include/asm/pgtable_types.h | 1 +
> >  arch/x86/mm/pat/set_memory.c         | 8 ++++----
> >  2 files changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> > index 0b748ee16b3d..3f648ffdfbe5 100644
> > --- a/arch/x86/include/asm/pgtable_types.h
> > +++ b/arch/x86/include/asm/pgtable_types.h
> > @@ -548,6 +548,7 @@ enum pg_level {
> >  	PG_LEVEL_2M,
> >  	PG_LEVEL_1G,
> >  	PG_LEVEL_512G,
> > +	PG_LEVEL_256T,
> >  	PG_LEVEL_NUM
> >  };
> >  
> > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > index f92da8c9a86d..3612e3167147 100644
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -666,32 +666,32 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
> 
> LGTM,
> 
> Reviewed-by: Baoquan He <bhe@redhat.com>
> 
> By the way, we may need update the code comment above function
> lookup_address_in_pgd() and function lookup_address() since they don't
> reflect the latest behaviour of them.

I am not sure what part of the comment you see doesn't reflect the
behaviour. From my PoV, changed code matches the comment closer that
original.

Hm?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
