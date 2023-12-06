Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46469C4167B
	for <kexec@archiver.kernel.org>; Wed,  6 Dec 2023 13:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SjN3WAESqQ2W0XMfUIMTJ9+2msuY5F8t0o468z3uNI8=; b=HqHJ8evQZBhjap
	mXAUj4GGU3VSc0juiQhoCsDVRJqj5f11vzOZzy+cfV3H6jz1aVDRrxc5dPwY7PjMD+fZ3CxK8bTA9
	IK9mYgiMgEwfoAyzu+wbPL/VfCC17i8EVdA4wGGv/lFBhsrBMAuQYsaUzEtPS94gmemfexY7hWlYR
	16Yy75XIznsXszTqaJ4nLFEM44mxiqUYI7GRBOV4g5Fm88Th4kTY5nVsIqZQ/3B5hHfa34wvq9DSm
	Tl91euGNzp2S9zyHRuXN7cZT2Xfjf9Z6rnj774kKS47XiH2AvbR+hlXOdmv+cOA/yhOeTGRX/gR4M
	8CxP2+/6DD8daszhd0kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rArvF-00ANii-0a;
	Wed, 06 Dec 2023 13:26:41 +0000
Received: from mgamail.intel.com ([198.175.65.11])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rArvC-00ANhc-1E
	for kexec@lists.infradead.org;
	Wed, 06 Dec 2023 13:26:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701869198; x=1733405198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wvRatAZPIQq3Q3PGd/WkGxxbZ5rxDQhioWQiZbIj1vg=;
  b=B7Hgn6XgRn6+rdiZH8ZFgB/5lsMTPkX2Px4Vn59UkL56IWYjjSlS9V/O
   eibeh00kpbi2O9DlPmxPRNS1xiv8DcK8XSoOAHPSt6SJfMnJgJEa0T1Fs
   dSS3N6Rp+i7iwJFq1EUnK2fgYdzJiehCVgAK2jxX8eOnYaWMzNPxfxsnZ
   G23GTwFdccedmRm8doCzerpg20cSSIhfKJhyRBBWBX/bJihgXij2DCpqr
   bZch2go21zmF+2HlUsS+jOsk5iqYQwQY1eeTFQW6B4D0R4FvnY9thRVSP
   25VzXR1cyZT76+DQtTABKVciffuzM8XlOPSvtBEWZxirJBRl3LMwle/vs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="930861"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="930861"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 05:26:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="721084730"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="721084730"
Received: from eborisov-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.46.36])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 05:26:30 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 0618B10A3F5; Wed,  6 Dec 2023 16:26:28 +0300 (+03)
Date: Wed, 6 Dec 2023 16:26:27 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"bhe@redhat.com" <bhe@redhat.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv4 06/14] x86/kexec: Keep CR4.MCE set during kexec for TDX
 guest
Message-ID: <20231206132627.5dx4sbgkypgnq6yn@box.shutemov.name>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
 <20231205004510.27164-7-kirill.shutemov@linux.intel.com>
 <861f583e2550959616e19565235f0debbe27149b.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <861f583e2550959616e19565235f0debbe27149b.camel@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_052638_479595_5A44C243 
X-CRM114-Status: GOOD (  18.83  )
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

On Tue, Dec 05, 2023 at 11:58:45PM +0000, Huang, Kai wrote:
> On Tue, 2023-12-05 at 03:45 +0300, Kirill A. Shutemov wrote:
> > TDX guests are not allowed to clear CR4.MCE. Attempt to clear it leads
> > to #VE.
> > 
> > Use alternatives to keep the flag during kexec for TDX guests.
> > 
> > The change doesn't affect non-TDX-guest environments.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reviewed-by: Kai Huang <kai.huang@intel.com>
> > ---
> >  arch/x86/kernel/relocate_kernel_64.S | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> > index 56cab1bb25f5..cd6a53667c6b 100644
> > --- a/arch/x86/kernel/relocate_kernel_64.S
> > +++ b/arch/x86/kernel/relocate_kernel_64.S
> > @@ -145,12 +145,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> >  	 * Set cr4 to a known state:
> >  	 *  - physical address extension enabled
> >  	 *  - 5-level paging, if it was enabled before
> > +	 *  - Machine check exception on TDX guest. Clearing MCE is not allowed
> > +	 *    in TDX guests.
> >  	 */
> >  	movl	$X86_CR4_PAE, %eax
> >  	testq	$X86_CR4_LA57, %r13
> >  	jz	1f
> >  	orl	$X86_CR4_LA57, %eax
> >  1:
> > +	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
> >  	movq	%rax, %cr4
> >  
> >  	jmp 1f
> 
> Nit:
> 
> It seems <asm/alternative.h> isn't included in relocate_kernel_64.S.  Maybe it's
> better to do it explicitly.
> 
> Maybe even better to explicitly include <linux/stringify.h> too, but I see
> <asm/alternative.h> already does that.

Okay, I will add both.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
