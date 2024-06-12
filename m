Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA58C27C53
	for <kexec@archiver.kernel.org>; Wed, 12 Jun 2024 09:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CwGUNsADaaQSW/KwaMrWU1fETj4vTPJA7oSJZKQJYNg=; b=vf3PDGCOXeZP98
	K9qthxScVRFrVotDIsYmTl/RyTZpR2PaWV0AqUpddoIkMj99aCU5NYaEBaVvxkvIgY9cN0Ga9zvoA
	mwqbl/MYcoiNv0GzJITjNFtE432UjW1mXHfAXHbgVRO0In60Ea+a7iBwhFoqdrCHrY0E/ytto3FAj
	mFTr3YOelzHt/zNM134QM4cvvdhPjEoSaivfsuD5xNpKFchzRxh5i80BEImtEkOjmRc/9jZfE5QOz
	bJF+WbXpLnopPpQwgnSm8tbcnuvSyODIMu7NsarZZOVKDHmEQwapT95SV45G5SdMcyLzgijh1eSG9
	2VPW6ZGNUOPpLwYIglGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHKBj-0000000BwrO-022U;
	Wed, 12 Jun 2024 09:22:39 +0000
Received: from mgamail.intel.com ([192.198.163.17])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHKBf-0000000Bwpd-25qU
	for kexec@lists.infradead.org;
	Wed, 12 Jun 2024 09:22:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718184155; x=1749720155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7QifDfrNsx1fq4Zn54nkhEExNwXSNVLR0i6Op1TRZJI=;
  b=kvC5e96lZeYTPVgV3qvBaeV7Mt9Wh+eOaQp1H+xFUUuvx8nBg+C3/fAD
   F+9TA8Xa+hZo4QKzr1OpeXseiE+kIHAPtU5WXxqMQzpkyuPZA97C/gyN4
   7Cb88KddkOzZp9TJwL9V/eDzO3TuU3lRLZTMZG4RwuBRG4z1FqNilfmAT
   S+zrVUPwV50zW4SsILwMuKKHBCe2xhK+k7VJmOIdGj2xIFtsLpAgsfJO9
   uUak//4s4e+2M4xjOWC7VdJZiW1ScvV0QhnvgKmDNf5H1ydtDsORhDvN7
   CYQDtDNA48Y+mG71viP1UsJi/69dBf/qgSds/uDp5v9RAbKaPSnISWFAW
   Q==;
X-CSE-ConnectionGUID: XZUGZLFgSZWNAoGjWT5O2w==
X-CSE-MsgGUID: N56YPv8JSbKVySxNoD0e0Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="14810228"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="14810228"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 02:22:34 -0700
X-CSE-ConnectionGUID: l+tjhQPjQImOMdvNQ7mk4A==
X-CSE-MsgGUID: Isa6/PTmSJC0RRJHVa41FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="70530128"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 12 Jun 2024 02:22:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 07C52193; Wed, 12 Jun 2024 12:22:26 +0300 (EEST)
Date: Wed, 12 Jun 2024 12:22:26 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Borislav Petkov <bp@alien8.de>, Nikolay Borisov <nik.borisov@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv11 05/19] x86/relocate_kernel: Use named labels for less
 confusion
Message-ID: <nxllu5wfhvfvorxbbt6ll3lc2mr47lw7sduszfawhtryqgtyrd@3qgtci7ocah6>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-6-kirill.shutemov@linux.intel.com>
 <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>
 <t3zx4f6ynru7qp4oel4syza2alcuxz7q7hxqgf2lxusgobnsnh@vtnecqrsxci5>
 <748d3b70-60b4-44e0-bd81-9117f1ab699d@zytor.com>
 <20240604091503.GQZl7bF14qTSAjqUhN@fat_crate.local>
 <ehttxqgg7zhbgty5m5uxkduj3xf7soonrzfu4rfw7hccqgdydl@afki66pnree5>
 <5c8b3ee9-64c2-4ff3-9cca-ba2672b9635e@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5c8b3ee9-64c2-4ff3-9cca-ba2672b9635e@zytor.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_022235_575226_25EDC87E 
X-CRM114-Status: GOOD (  25.42  )
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

On Tue, Jun 11, 2024 at 11:26:17AM -0700, H. Peter Anvin wrote:
> On 6/4/24 08:21, Kirill A. Shutemov wrote:
> > 
> >  From b45fe48092abad2612c2bafbb199e4de80c99545 Mon Sep 17 00:00:00 2001
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > Date: Fri, 10 Feb 2023 12:53:11 +0300
> > Subject: [PATCHv11.1 06/19] x86/kexec: Keep CR4.MCE set during kexec for TDX guest
> > 
> > TDX guests run with MCA enabled (CR4.MCE=1b) from the very start. If
> > that bit is cleared during CR4 register reprogramming during boot or
> > kexec flows, a #VE exception will be raised which the guest kernel
> > cannot handle it.
> > 
> > Therefore, make sure the CR4.MCE setting is preserved over kexec too and
> > avoid raising any #VEs.
> > 
> > The change doesn't affect non-TDX-guest environments.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >   arch/x86/kernel/relocate_kernel_64.S | 17 ++++++++++-------
> >   1 file changed, 10 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> > index 085eef5c3904..9c2cf70c5f54 100644
> > --- a/arch/x86/kernel/relocate_kernel_64.S
> > +++ b/arch/x86/kernel/relocate_kernel_64.S
> > @@ -5,6 +5,8 @@
> >    */
> >   #include <linux/linkage.h>
> > +#include <linux/stringify.h>
> > +#include <asm/alternative.h>
> >   #include <asm/page_types.h>
> >   #include <asm/kexec.h>
> >   #include <asm/processor-flags.h>
> > @@ -145,14 +147,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> >   	 * Set cr4 to a known state:
> >   	 *  - physical address extension enabled
> >   	 *  - 5-level paging, if it was enabled before
> > +	 *  - Machine check exception on TDX guest, if it was enabled before.
> > +	 *    Clearing MCE might not be allowed in TDX guests, depending on setup.
> > +	 *
> > +	 * Use R13 that contains the original CR4 value, read in relocate_kernel().
> > +	 * PAE is always set in the original CR4.
> >   	 */
> > -	movl	$X86_CR4_PAE, %eax
> > -	testq	$X86_CR4_LA57, %r13
> > -	jz	.Lno_la57
> > -	orl	$X86_CR4_LA57, %eax
> > -.Lno_la57:
> > -
> > -	movq	%rax, %cr4
> > +	andl	$(X86_CR4_PAE | X86_CR4_LA57), %r13d
> > +	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %r13d), X86_FEATURE_TDX_GUEST
> > +	movq	%r13, %cr4
> 
> If this is the case, I don't really see a reason to clear MCE per se as I'm
> guessing a machine check here will be fatal anyway? It just changes the
> method of death.

Andrew had a strong opinion on method of death here.

https://lore.kernel.org/all/1144340e-dd95-ee3b-dabb-579f9a65b3c7@citrix.com

> Also, is there a reason to save %cr4, run code, and *then* clear the
> relevant bits? Wouldn't it be better to sanitize %cr4 as soon as possible?

You mean set new CR4 directly in relocate_kernel() before switching CR3?
I guess it is possible.

But I can say I see huge benefit of changing it. Such change would have
own risks.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
