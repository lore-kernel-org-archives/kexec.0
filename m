Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EB0C25B78
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 15:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yaQUNXkmxxyp61UPE2AxOPCfSWOrbjgMeI/6Eq+ko30=; b=Bgj7gA1FowJgO/
	gPJ+DRTDj4i7/ZQ9qwtlD9OP1Q3giQBWRxRL1AON7QdVaapS/7pEyqmr2Ck2NrxvDxiOczj/lDAuo
	38Yj7rG9p7FCnhtQIPSR6DKms8M7dAqYeAA2vkkJ5nSjs5eZhy7Q32WIup8jrDDdnTmxm+LPUoDCU
	+wL1s9klPS5omLnQCAROcQ4+SoepeNK4otFGkAmbPsXzMwQCTdxfpt8EzMY7q8WMi2E6/tF2CuT39
	5FoI8xh96r4yVQtKDglMxvLhRetdo78KQL90SKlm+dpKiDAOdR4IycNGVomnQc40KGlNNKV2iYDsZ
	96T/To4wWudUNLEjR3EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEVyn-00000002td0-1L5x;
	Tue, 04 Jun 2024 15:21:41 +0000
Received: from mgamail.intel.com ([192.198.163.19])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEVyj-00000002tc0-33YS
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 15:21:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717514497; x=1749050497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E+b2QUNEozOByn7XosVfo22ORgGbyZc8ikuTipiKM4k=;
  b=VTl0YdhyiN+HE9zGf+8GXVe5e4Fb1sjgnQx6AtCYoEsYvvvucf1HkxDL
   CgI4NJz2doJT4GkeleOqrddKEHusA2oUuknvhUTa461pMNoTEvMQWDvgV
   WvhYJmb5/v2aTQw9X1kF61Wl7FK/5YTI35+68OhUdRA9ymNv2CChP30py
   OHWK7Lgm9mMqHmZkrYWVNY8yka68tZJ5/ti+E+GrXNiL2tnEk6ZkbwDSd
   f5WJmWgvYO474reXxfZOlrJE5CE92e3x/mAkAj2oHr6yXJssequzszEnL
   +q5BROyTq7vl8IeWQHqmmNJXBgSB6lBE9dEkD0orT6y+uS+XZ+0WT27e+
   A==;
X-CSE-ConnectionGUID: rCZTyqo0RKuRld1AI5oGrg==
X-CSE-MsgGUID: dG2d/Pp/SOmHyu9ccUZgVg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13876550"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="13876550"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 08:21:35 -0700
X-CSE-ConnectionGUID: 80QFIjp6QEKsJylgelC6zA==
X-CSE-MsgGUID: hyN/V+NqSJm6vfhx7CCozg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="37214950"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 04 Jun 2024 08:21:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id A67F32DC; Tue, 04 Jun 2024 18:21:27 +0300 (EEST)
Date: Tue, 4 Jun 2024 18:21:27 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
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
Message-ID: <ehttxqgg7zhbgty5m5uxkduj3xf7soonrzfu4rfw7hccqgdydl@afki66pnree5>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-6-kirill.shutemov@linux.intel.com>
 <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>
 <t3zx4f6ynru7qp4oel4syza2alcuxz7q7hxqgf2lxusgobnsnh@vtnecqrsxci5>
 <748d3b70-60b4-44e0-bd81-9117f1ab699d@zytor.com>
 <20240604091503.GQZl7bF14qTSAjqUhN@fat_crate.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240604091503.GQZl7bF14qTSAjqUhN@fat_crate.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_082137_821900_E6E1FF95 
X-CRM114-Status: GOOD (  22.88  )
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

On Tue, Jun 04, 2024 at 11:15:03AM +0200, Borislav Petkov wrote:
> On Mon, Jun 03, 2024 at 05:24:00PM -0700, H. Peter Anvin wrote:
> > Trying one more time; sorry (again) if someone receives this in duplicate.
> > 
> > > > > 
> > > > > diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> > > > > index 56cab1bb25f5..085eef5c3904 100644
> > > > > --- a/arch/x86/kernel/relocate_kernel_64.S
> > > > > +++ b/arch/x86/kernel/relocate_kernel_64.S
> > > > > @@ -148,9 +148,10 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> > > > >    	 */
> > > > >    	movl	$X86_CR4_PAE, %eax
> > > > >    	testq	$X86_CR4_LA57, %r13
> > > > > -	jz	1f
> > > > > +	jz	.Lno_la57
> > > > >    	orl	$X86_CR4_LA57, %eax
> > > > > -1:
> > > > > +.Lno_la57:
> > > > > +
> > > > >    	movq	%rax, %cr4
> > 
> > If we are cleaning up this code... the above can simply be:
> > 
> > 	andl $(X86_CR4_PAE | X86_CR4_LA54), %r13
> > 	movq %r13, %cr4
> > 
> > %r13 is dead afterwards, and the PAE bit *will* be set in %r13 anyway.
> 
> Yeah, with a proper comment. The testing of bits is not really needed.

I think it is better fit the next patch.

What about this?

From b45fe48092abad2612c2bafbb199e4de80c99545 Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Fri, 10 Feb 2023 12:53:11 +0300
Subject: [PATCHv11.1 06/19] x86/kexec: Keep CR4.MCE set during kexec for TDX guest

TDX guests run with MCA enabled (CR4.MCE=1b) from the very start. If
that bit is cleared during CR4 register reprogramming during boot or
kexec flows, a #VE exception will be raised which the guest kernel
cannot handle it.

Therefore, make sure the CR4.MCE setting is preserved over kexec too and
avoid raising any #VEs.

The change doesn't affect non-TDX-guest environments.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 085eef5c3904..9c2cf70c5f54 100644
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
@@ -145,14 +147,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 * Set cr4 to a known state:
 	 *  - physical address extension enabled
 	 *  - 5-level paging, if it was enabled before
+	 *  - Machine check exception on TDX guest, if it was enabled before.
+	 *    Clearing MCE might not be allowed in TDX guests, depending on setup.
+	 *
+	 * Use R13 that contains the original CR4 value, read in relocate_kernel().
+	 * PAE is always set in the original CR4.
 	 */
-	movl	$X86_CR4_PAE, %eax
-	testq	$X86_CR4_LA57, %r13
-	jz	.Lno_la57
-	orl	$X86_CR4_LA57, %eax
-.Lno_la57:
-
-	movq	%rax, %cr4
+	andl	$(X86_CR4_PAE | X86_CR4_LA57), %r13d
+	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %r13d), X86_FEATURE_TDX_GUEST
+	movq	%r13, %cr4
 
 	jmp 1f
 1:
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
