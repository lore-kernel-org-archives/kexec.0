Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CF0CD1284
	for <kexec@archiver.kernel.org>; Tue,  2 Apr 2024 15:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rVJt+chHtQ1OfInbYnQCVuXGr9uaHSfoInpxkTNlBiQ=; b=i5z8KQ07BHYfNy
	fw9IwZBiqEZ23e9jFQyPLvQi2/BasBfG072W1qrCTqS64hj3zd/P+zMcDFBB5T/VPtBxDvCW5ME6d
	fzEt8Pcm0DAaNuVlXgwgeHTSgl+f7qPbYs+Q3oPtVxMDdsZgw6G+kUf/5dVY7a33zmwqger088uGR
	jg6vi7XnFYVdBw0xNv9glklrN4uImQGxRyd3ToCjABeXl2rOhNPy3oieisw4Md3I/KhzTeU1oGXpg
	CK2jDXlk/Kk8TAjgvnOevmFxgAEcsSyk9SKbPsEdo87dhGeaDGytl9VnZET7x5XLyKsohBsFbOesA
	lg86+0JcuKBB1Sjw6r6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrgHT-0000000BqUt-3RgN;
	Tue, 02 Apr 2024 15:42:35 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrgHQ-0000000BqS5-41Mn
	for kexec@lists.infradead.org;
	Tue, 02 Apr 2024 15:42:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712072553; x=1743608553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RZamI5f8/aC7oIQVbalM1Cimf9G3hUXqlyz/JLjpQQQ=;
  b=Y7gnneORwgOLb3V6D17KlAX9Ta6FXbOg+b+OTQ6tgWf4ZpYVDCOqkF+F
   QWvcvvbhvomAVm8g0SzCcyvg/sfgkK8vYE0lJ1dbbf2IDc9py7HEKc5sB
   759o+GuC95FVxou8zUDycC58K62vp1tGzAHPbftUNGZlIENG44RnGLCnY
   y7cyhIm+LspUcuuQ3Pce/n2p7mkgKXvikLtn0j0ejo5U2+d+hhstcl5g3
   fjDMxnHOAtqMlvFz4UPBcy9JuJr2dsX6RcvXZk0vj9yEYin1fx+b/Nry2
   X5zkHT5FnNXTOeWa4YOOE42KI2iaHdSOgdg+zGT7NLZPGOwn5nMaYmCtK
   Q==;
X-CSE-ConnectionGUID: QaA1NPTOR7+t28TAUCEyNQ==
X-CSE-MsgGUID: x+2SZXNRSQWLcSLQMaOo6A==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="17870109"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="17870109"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 08:42:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083654"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083654"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 08:42:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id A10101C5; Tue,  2 Apr 2024 18:42:23 +0300 (EEST)
Date: Tue, 2 Apr 2024 18:42:23 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv9 05/17] x86/kexec: Keep CR4.MCE set during kexec for TDX
 guest
Message-ID: <j4s4n5slt6a234w5o5r4zjmb3xj53odnmwekt6ihotfzotd7ur@ghyvphwcki57>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
 <20240325103911.2651793-6-kirill.shutemov@linux.intel.com>
 <b94c81ef-50f2-4e66-9533-461791777d10@intel.com>
 <dlixf7bld4efdh5goir5nreabkgtcwfbvv2rovjqrvjttplqss@auuqnt4h2llj>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dlixf7bld4efdh5goir5nreabkgtcwfbvv2rovjqrvjttplqss@auuqnt4h2llj>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_084233_085570_CAA28E1A 
X-CRM114-Status: GOOD (  21.89  )
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

On Fri, Mar 29, 2024 at 06:48:21PM +0200, Kirill A. Shutemov wrote:
> On Fri, Mar 29, 2024 at 11:21:32PM +0800, Xiaoyao Li wrote:
> > On 3/25/2024 6:38 PM, Kirill A. Shutemov wrote:
> > > TDX guests are not allowed to clear CR4.MCE. Attempt to clear it leads
> > > to #VE.
> > 
> > Will we consider making it more safe and compatible for future to guard
> > against X86_FEATURE_MCE as well?
> > 
> > If in the future, MCE becomes configurable for TD guest, then CR4.MCE might
> > not be fixed1.
> 
> Good point.
> 
> I guess we can leave it clear if it was clear. This should be easy
> enough. But we might want to clear even if was set if clearing is allowed.
> 
> It would require some kind of indication that clearing MCE is fine. We
> don't have such indication yet. Not sure we can reasonably future-proof
> the code at this point.
> 
> But let me think more.

I think I will go with the variant below.

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 56cab1bb25f5..8e2037d78a1f 100644
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
@@ -145,11 +147,17 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 * Set cr4 to a known state:
 	 *  - physical address extension enabled
 	 *  - 5-level paging, if it was enabled before
+	 *  - Machine check exception on TDX guest, if it was enabled before.
+	 *    Clearing MCE might not allowed in TDX guests, depending on setup.
 	 */
 	movl	$X86_CR4_PAE, %eax
 	testq	$X86_CR4_LA57, %r13
 	jz	1f
 	orl	$X86_CR4_LA57, %eax
+1:
+	testq	$X86_CR4_MCE, %r13
+	jz	1f
+	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
 1:
 	movq	%rax, %cr4
 
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
