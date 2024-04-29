Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2980C4345F
	for <kexec@archiver.kernel.org>; Mon, 29 Apr 2024 13:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EO78eeJLgXCQAWihce23cXTHtLXwheLapfvWUnb44cA=; b=jC/MzMpISF53pL
	Zq40JjhHXWJT2aYJcXkZLWm6d4dbWBjl7ZmGaJOhX7sqNJ3srZXI5h19Vimx3mYwWkX76dMrCiBZy
	OrDsfgHvVRg5S+tw2hURo/cEiE2e0mDHiQa3vJIr37k16mfecan0Ykdmsgus7p5z/XbV8dDCFq1vm
	l2VtZc7GmBOg55qyrMIwLpjgB6v7UpAbvqbCDeZQoXOF4vBccHL8FieRenfCcsmuJwSW8MHqD0l9G
	55t3LvNxeZoEIl+zqowXWqs+woM25pl+WIAgV8VTpfAVRguw4hpQVj6OXDs/TVl2ZXSiWk0pZxByj
	bjN3tQAx/VVCFnioDwxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1Qte-00000002tou-1LsX;
	Mon, 29 Apr 2024 13:18:18 +0000
Received: from mgamail.intel.com ([198.175.65.17])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1Qtb-00000002ta9-1LYR
	for kexec@lists.infradead.org;
	Mon, 29 Apr 2024 13:18:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714396696; x=1745932696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vvnS47Dpfc2lPtfocF2xFFI42fQVbBcxzt1unzaD04A=;
  b=TYyaWYzI5dBIohU+lk/g2fPDNBspU0sWA5ZUV3/N+bg59/i0qfU+oMuD
   OYORDIMnEOy4VD6T+Gk99ZdcRMKrCUw2t3g01gIlWN93eNalxGkkVUXAG
   n6lO4L1XfxtJ+nufQSkRd4X75/wPRCdS787jxamNNYrqfCiMqTY10GM2R
   ZoiXJIxNB+SxuvIrSTAdN6ek/VgZ63XNy6e7uXJC6GmTA8U7DFGDNQX0f
   5AaUsjC/XE83IvIvs777YeWyJX1uY6AUCE46zFAF11Pb9l5/HJvW5n9re
   ETc6QBdFcoqudKlc982ssf+kvy2brOnNP/2QBvfkWMqBPZshv1kIB1K7a
   g==;
X-CSE-ConnectionGUID: 5y9S06A0Qrap15c6q6kTaA==
X-CSE-MsgGUID: 27DYRamqT6GbDzPjjyev+g==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10167085"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="10167085"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 06:17:45 -0700
X-CSE-ConnectionGUID: 8NOiztBIRTaSIwyN+FuNlw==
X-CSE-MsgGUID: pfLor2xfQQiqFaB6fEhbAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26069268"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 29 Apr 2024 06:17:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 71239179; Mon, 29 Apr 2024 16:17:38 +0300 (EEST)
Date: Mon, 29 Apr 2024 16:17:38 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv10 05/18] x86/kexec: Keep CR4.MCE set during kexec for
 TDX guest
Message-ID: <e35yxpa2xdynm7focg6k4u2bjzojn24bmeaszh2jz52e4szc5f@6mgtrdnkewhe>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
 <ZhVPIDDLkjOB96fI@google.com>
 <3q6jv3g4tezybmd667mqxio7ty22akxv7okrznmzx3tju2u4qo@2alzjkbgm2lh>
 <20240428171111.GKZi6DLy_ZwuZsZdFq@fat_crate.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240428171111.GKZi6DLy_ZwuZsZdFq@fat_crate.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_061815_438671_0B4D3BE6 
X-CRM114-Status: GOOD (  23.90  )
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

On Sun, Apr 28, 2024 at 07:11:11PM +0200, Borislav Petkov wrote:
> On Tue, Apr 09, 2024 at 06:26:05PM +0300, Kirill A. Shutemov wrote:
> > From 6be428e3b1c6fb494b2c48ba6a7c133514a0b2b4 Mon Sep 17 00:00:00 2001
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > Date: Fri, 10 Feb 2023 12:53:11 +0300
> > Subject: [PATCHv10.1 05/18] x86/kexec: Keep CR4.MCE set during kexec for TDX guest
> > 
> > Depending on setup, TDX guests might be allowed to clear CR4.MCE.
> > Attempt to clear it leads to #VE.
> > 
> > Use alternatives to keep the flag during kexec for TDX guests.
> > 
> > The change doesn't affect non-TDX-guest environments.
> 
> This is all fine and dandy but nothing explains *why* TDX needs this
> special dance.
> 
> Why can't TDX do the usual CR4.MCE diddling like the normal kernel
> during init and needs to do that here immediately?

As I mentioned above, clearing CR4.MCE triggers #VE. It is quirk of the
platform.

There's plan to allow it in newer TDX modules, but kernel still has to
assume we cannot touch it in TDX guest case.

> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/kernel/relocate_kernel_64.S | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> > index 56cab1bb25f5..90246d544eb1 100644
> > --- a/arch/x86/kernel/relocate_kernel_64.S
> > +++ b/arch/x86/kernel/relocate_kernel_64.S
> > @@ -5,6 +5,8 @@
> >   */
> >  
> >  #include <linux/linkage.h>
> > +#include <linux/stringify.h>
> > +#include <asm/alternative.h>
> >  #include <asm/page_types.h>
> >  #include <asm/kexec.h>
> >  #include <asm/processor-flags.h>
> > @@ -143,14 +145,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> >  
> >  	/*
> >  	 * Set cr4 to a known state:
> > -	 *  - physical address extension enabled
> >  	 *  - 5-level paging, if it was enabled before
> > +	 *  - Machine check exception on TDX guest, if it was enabled before.
> > +	 *    Clearing MCE might not allowed in TDX guests, depending on setup.
> 
> 			 ... might not be allowed ...
> 

Oopsie. Thanks.

> > +	 *  - physical address extension enabled
> >  	 */
> > -	movl	$X86_CR4_PAE, %eax
> > -	testq	$X86_CR4_LA57, %r13
> > -	jz	1f
> > -	orl	$X86_CR4_LA57, %eax
> > -1:
> > +	movl	$X86_CR4_LA57, %eax
> > +	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
> > +	andl	%r13d, %eax
> 
> %r13 needs a comment here that it contains %cr4 read above in
> relocate_kernel()

Okay.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
