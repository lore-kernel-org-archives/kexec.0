Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8728C67861
	for <kexec@archiver.kernel.org>; Tue,  9 Apr 2024 15:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tCKkpsTMoQZaVaxBv6/jxZYu7ogRKkpGikfwMa2hsVg=; b=Cp/q6BbjADACKl
	pOzsYV5uySPY4VqR52L7AjqdJ80R89xcgIWcyPxxAIzU+BRoG8kckfy/PvSiAGBc1RFbK1Q2e+xzJ
	Ln8jjrIu3O7LbI3tHNllR8wiMOWPR5vNBGJ80//rMJxQy1fJE0L6Ksq7+fiTcY1jR3elL0pMA5snK
	6yTfNfZd8Rf/33ufWn+IInNYwDb222T4UYCkSJIME3681fbsJiLYLaydTy/4IGzc0SdsrY+F9uT1F
	Eqi7tab3cUscIkbA/QKMPRkH+3yqhkNS2WVaa0fJngueJyxBmLCCd5YqqEwuCsJ7IoRCS2EY0Qxhy
	Q4oazcaRhEqtkoonGzKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruDN2-00000002hP0-47cA;
	Tue, 09 Apr 2024 15:26:49 +0000
Received: from mgamail.intel.com ([198.175.65.16])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruDMX-00000002hKk-36P2
	for kexec@lists.infradead.org;
	Tue, 09 Apr 2024 15:26:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712676378; x=1744212378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jzHlRPxbj4n++6c1Y7jC5HhgzBvQwRs0eWR4xEuQY1c=;
  b=mHfJd6u/jPVE2ZA7awBZLeDSW9Rc4vjsXFMMmOXC+uA7GqaGtiqQ3Q18
   /BFXwqanuGshhOSmo8Uwxk6Yylzh3nXt0ly3uTiXFdlifnG12FMXt3tSz
   Fqybde6qU+O8iwSIv52tTeCLrmg+dsMFVDQpXio+8uz28V9pX750fJIrY
   X2C3iZGldKl9pkGtbXz6dL5tqscPJh3iI2xH3GHrxcpQe8AS1sUh3EKUk
   QvGruiyrMbu4kwKl0PVt0idY3/BL0k8DrTDiPvEejK2bQWo0dXVSc5Hlt
   trBktDWRqWik+s/VKeDzJdtF2u1ZLfP1hd1y9vH3SpQPPvyJjWf6s8NRM
   w==;
X-CSE-ConnectionGUID: qjPElqJjRSamorIHAMNjgQ==
X-CSE-MsgGUID: 2tMeZ7R7Qli218mj85vJAw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8119651"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="8119651"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 08:26:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937093549"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="937093549"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2024 08:26:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id BBE70279; Tue,  9 Apr 2024 18:26:05 +0300 (EEST)
Date: Tue, 9 Apr 2024 18:26:05 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv10 05/18] x86/kexec: Keep CR4.MCE set during kexec for
 TDX guest
Message-ID: <3q6jv3g4tezybmd667mqxio7ty22akxv7okrznmzx3tju2u4qo@2alzjkbgm2lh>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
 <ZhVPIDDLkjOB96fI@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZhVPIDDLkjOB96fI@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_082617_873954_D706D7D7 
X-CRM114-Status: GOOD (  24.55  )
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

On Tue, Apr 09, 2024 at 07:22:24AM -0700, Sean Christopherson wrote:
> On Tue, Apr 09, 2024, Kirill A. Shutemov wrote:
> > Depending on setup, TDX guests might be allowed to clear CR4.MCE.
> > Attempt to clear it leads to #VE.
> > 
> > Use alternatives to keep the flag during kexec for TDX guests.
> > 
> > The change doesn't affect non-TDX-guest environments.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/kernel/relocate_kernel_64.S | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> > index 56cab1bb25f5..8e2037d78a1f 100644
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
> > @@ -145,11 +147,17 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> >  	 * Set cr4 to a known state:
> >  	 *  - physical address extension enabled
> >  	 *  - 5-level paging, if it was enabled before
> > +	 *  - Machine check exception on TDX guest, if it was enabled before.
> > +	 *    Clearing MCE might not allowed in TDX guests, depending on setup.
> >  	 */
> >  	movl	$X86_CR4_PAE, %eax
> >  	testq	$X86_CR4_LA57, %r13
> >  	jz	1f
> >  	orl	$X86_CR4_LA57, %eax
> > +1:
> > +	testq	$X86_CR4_MCE, %r13
> > +	jz	1f
> > +	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
> 
> The TEST+Jcc+OR sequences are rather odd, and require way more instructions and
> thus way more copy+paste than is necessary.
> 
> 	movl	$X86_CR4_LA57, %eax
> 	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
> 	andl	%r13d, %eax
> 	orl	$X86_CR4_PAE, %eax
> 	movq	%rax, %cr4
> 
> Then preserving new bits unconditionally only requires adding the flag to the
> initial move, and feature-dependent bits only need a single ALTERNATIVE line.

Thanks! It is much better.

> And there's no branches, blazing fast kexec! ;-)

kexec/sec STONKS! :D

Updated patch is below.

From 6be428e3b1c6fb494b2c48ba6a7c133514a0b2b4 Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Fri, 10 Feb 2023 12:53:11 +0300
Subject: [PATCHv10.1 05/18] x86/kexec: Keep CR4.MCE set during kexec for TDX guest

Depending on setup, TDX guests might be allowed to clear CR4.MCE.
Attempt to clear it leads to #VE.

Use alternatives to keep the flag during kexec for TDX guests.

The change doesn't affect non-TDX-guest environments.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 56cab1bb25f5..90246d544eb1 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -5,6 +5,8 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/stringify.h>
+#include <asm/alternative.h>
 #include <asm/page_types.h>
 #include <asm/kexec.h>
 #include <asm/processor-flags.h>
@@ -143,14 +145,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 
 	/*
 	 * Set cr4 to a known state:
-	 *  - physical address extension enabled
 	 *  - 5-level paging, if it was enabled before
+	 *  - Machine check exception on TDX guest, if it was enabled before.
+	 *    Clearing MCE might not allowed in TDX guests, depending on setup.
+	 *  - physical address extension enabled
 	 */
-	movl	$X86_CR4_PAE, %eax
-	testq	$X86_CR4_LA57, %r13
-	jz	1f
-	orl	$X86_CR4_LA57, %eax
-1:
+	movl	$X86_CR4_LA57, %eax
+	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
+	andl	%r13d, %eax
+	orl	$X86_CR4_PAE, %eax
 	movq	%rax, %cr4
 
 	jmp 1f
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
