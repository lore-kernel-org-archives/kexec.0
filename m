Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D69C282EC
	for <kexec@archiver.kernel.org>; Mon, 17 Mar 2025 11:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kjzvpr1hU9ogWpfJDCtE+I2Ieds/Vp9p2lrb3TbqCEQ=; b=YCR/ZghcjStjSoTJpE5vWQ7s1S
	TLRUUYnlRVYxpxco7Rnwq9SSw5L6HAPRjhfcwlyG/km7rBEz00dX2QY+9cnG1+m03PVCJvMfgrydj
	7DeIIT4wOsNbfjvu0wRAFJXL9Z34lN3yvUS8XlgudiakzgEiQOTru4XsFjwdSWnPdUbytahO/DGDp
	IYGqOY58VW9nfr1OTZNZtP7y/8kUL0Z3SXGUfHxclabDzUbjD6beva/qSdDAS8zMfJ6YWZ2abXt1v
	x+WIB9kHPYoGqZIppJ/6YPD3DY7w3D9gN67CSmaxKi0jGN0eF0Et6OmPr0KonnG9kus6UjVVngHWP
	AGqRC2zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tu8Mh-00000002LJ4-1iJE;
	Mon, 17 Mar 2025 11:10:39 +0000
Received: from mgamail.intel.com ([198.175.65.16])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tu8G3-00000002JYL-2RtK
	for kexec@lists.infradead.org;
	Mon, 17 Mar 2025 11:03:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742209428; x=1773745428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Ek44iPcH0mU0ldu7ybADHXzeIYNkQ+rgyIE+nEzrKO8=;
  b=ny6yg00YUjYAZyTgx8BKS+D8GOll8GJ4DKM0NrWb7HwLuM2VVs5c7sVo
   t4AdNSc6pWBi55a85RJmb8bdnMAitczgMu9SNDlc/uJQxXdcI/GTb+b4E
   HJO4BYsrWww4XFnV7/+x8lBt3lHN9C76Hp/3oSs56Ukb1l3O/OpSeSrdc
   hMsbo98UyivIVhyjnPQ5kLXpnU0O8u0gfglPygjA5j+yQvp1yzkE/llsY
   uGe/bl2JXPoClJRP3HPYzuNZoAHXhFTSPFywBVIDxGx09sLLAwma796l4
   iYhusIPSPlyJAMUJRaqVODjO2ItFETHhvVNBVx1jsYgRC6pCVny/HxSvf
   w==;
X-CSE-ConnectionGUID: j0uqhjnLTB+GYKofI8F/Ng==
X-CSE-MsgGUID: 9pfFQz3gTK6Wl1/5rdQvTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="43401111"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="43401111"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 04:03:45 -0700
X-CSE-ConnectionGUID: DY8PXfBRQJyZmyE9yjHiww==
X-CSE-MsgGUID: DJ5WOLy3THOApnBGX7AhxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="122647420"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 17 Mar 2025 04:03:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 0DD431D8; Mon, 17 Mar 2025 13:03:38 +0200 (EET)
Date: Mon, 17 Mar 2025 13:03:38 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Huang, Kai" <kai.huang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv9 05/17] x86/kexec: Keep CR4.MCE set during kexec for TDX
 guest
Message-ID: <uchg74rtpcpwlkxgqww2n6nh23p4ouaswqc737xy7y6rqzowtb@pbf4whogx2s4>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
 <20240325103911.2651793-6-kirill.shutemov@linux.intel.com>
 <b94c81ef-50f2-4e66-9533-461791777d10@intel.com>
 <dlixf7bld4efdh5goir5nreabkgtcwfbvv2rovjqrvjttplqss@auuqnt4h2llj>
 <j4s4n5slt6a234w5o5r4zjmb3xj53odnmwekt6ihotfzotd7ur@ghyvphwcki57>
 <8e4e1d80-11ef-472f-befc-f61310281f18@intel.com>
 <cxwixclmgbx3xidn6g6keihampcbzcbosog6r6lyoa4hs3teu2@sqntzeltdajc>
 <f74db2c44ee7ef8ec127b5135ff80885c21c6836.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f74db2c44ee7ef8ec127b5135ff80885c21c6836.camel@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250317_040347_685766_5E5EEEFE 
X-CRM114-Status: GOOD (  40.77  )
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

On Mon, Mar 17, 2025 at 09:27:16AM +0000, David Woodhouse wrote:
> On Thu, 2024-04-04 at 12:32 +0300, Kirill A. Shutemov wrote:
> > On Thu, Apr 04, 2024 at 10:40:34AM +1300, Huang, Kai wrote:
> > > 
> > > 
> > > On 3/04/2024 4:42 am, Kirill A. Shutemov wrote:
> > > > On Fri, Mar 29, 2024 at 06:48:21PM +0200, Kirill A. Shutemov wrote:
> > > > > On Fri, Mar 29, 2024 at 11:21:32PM +0800, Xiaoyao Li wrote:
> > > > > > On 3/25/2024 6:38 PM, Kirill A. Shutemov wrote:
> > > > > > > TDX guests are not allowed to clear CR4.MCE. Attempt to clear it leads
> > > > > > > to #VE.
> > > > > > 
> > > > > > Will we consider making it more safe and compatible for future to guard
> > > > > > against X86_FEATURE_MCE as well?
> > > > > > 
> > > > > > If in the future, MCE becomes configurable for TD guest, then CR4.MCE might
> > > > > > not be fixed1.
> > > > > 
> > > > > Good point.
> > > > > 
> > > > > I guess we can leave it clear if it was clear. This should be easy
> > > > > enough. But we might want to clear even if was set if clearing is allowed.
> > > > > 
> > > > > It would require some kind of indication that clearing MCE is fine. We
> > > > > don't have such indication yet. Not sure we can reasonably future-proof
> > > > > the code at this point.
> > > > > 
> > > > > But let me think more.
> > > > 
> > > > I think I will go with the variant below.
> > > > 
> > > > diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> > > > index 56cab1bb25f5..8e2037d78a1f 100644
> > > > --- a/arch/x86/kernel/relocate_kernel_64.S
> > > > +++ b/arch/x86/kernel/relocate_kernel_64.S
> > > > @@ -5,6 +5,8 @@
> > > >    */
> > > >   #include <linux/linkage.h>
> > > > +#include <linux/stringify.h>
> > > > +#include <asm/alternative.h>
> > > >   #include <asm/page_types.h>
> > > >   #include <asm/kexec.h>
> > > >   #include <asm/processor-flags.h>
> > > > @@ -145,11 +147,17 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> > > >   	 * Set cr4 to a known state:
> > > >   	 *  - physical address extension enabled
> > > >   	 *  - 5-level paging, if it was enabled before
> > > > +	 *  - Machine check exception on TDX guest, if it was enabled before.
> > > > +	 *    Clearing MCE might not allowed in TDX guests, depending on setup.
> > > 
> > > Nit:  Perhaps we can just call out:
> > > 
> > > 	Clearing MCE is not allowed if it _was_ enabled before.
> > > 
> > > Which is always true I suppose.
> > 
> > It is true now. Future TDX will allow to clear CR4.MCE and we don't want
> > to flip it back on in this case.
> 
> And yet v12 of the patch which became commit de60613173df does
> precisely that.
> 
> It uses the original contents of CR4 which are stored in %r13 (instead
> of building a completely new set of bits for CR4 as before). So it
> would never have *cleared* the CR4.MCE bit now anyway... what it does
> is explicitly *set* the bit even if it wasn't set before?
>
> This is what got committed, and I think we can just drop the
> ALTERNATIVE line completely because it's redundant in the case that
> CR4.MCE was already set, and *wrong* in the case that it wasn't already
> set?

But we AND R13 against $(X86_CR4_PAE | X86_CR4_LA57). We will lose MCE if
drop the ALTERNATIVE.

And we don't want MCE to be enabled during kexec for !TDX_GUEST:

https://lore.kernel.org/all/1144340e-dd95-ee3b-dabb-579f9a65b3c7@citrix.com/

I think we should patch AND instruction to include X86_CR4_MCE on
TDX_GUEST:

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index b44d8863e57f..f6c552a39815 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -148,8 +148,8 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 * Use R13 that contains the original CR4 value, read in relocate_kernel().
 	 * PAE is always set in the original CR4.
 	 */
-	andl	$(X86_CR4_PAE | X86_CR4_LA57), %r13d
-	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %r13d), X86_FEATURE_TDX_GUEST
+	ALTERNATIVE __stringify(andl	$(X86_CR4_PAE | X86_CR4_LA57), %r13d), \
+		    __stringify(andl	$(X86_CR4_PAE | X86_CR4_LA57 | X86_CR4_MCE), %r13d), X86_FEATURE_TDX_GUEST
 	movq	%r13, %cr4
 
 	/* Flush the TLB (needed?) */
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

