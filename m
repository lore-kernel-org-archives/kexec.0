Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D73ECD1284
	for <kexec@archiver.kernel.org>; Thu,  4 Apr 2024 09:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fwgYyibP2jZns3VoLEX66i9CQLFMWWRnlitFsJNH9mA=; b=qW1M+UjJllFnSv
	BuY/nNN/CG8tg7lJr0dqJkvxsIpO/J0PZ8lxcsFgWbmStsVybz08naCt8JNtch87+1wLLT5EgSHgV
	A1QMAWx33yadcGjzG2/hCzRQQlfgDFLbIvafBhMDCY6KriROw/gKM1o1jfpwxnD5+q7lgM0gKTK3f
	1Ea9icFSr6RNxrw3lWshv8LPIulPi8PrAVkGA0M3h7Iq+mRqmNaT1jqD+UxHWkrsCvf9SD5q+ZkSD
	YqxiRkqTlIlzT7bVQCDiYTkfKQ5supCuxYidrKIfOmsTsYnAenJe91izImOsTk2ww1Se8Lmu+MKAS
	SCKz/HjfLDoszQwzfgPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsJSx-000000022Ln-2fJ8;
	Thu, 04 Apr 2024 09:33:03 +0000
Received: from mgamail.intel.com ([192.198.163.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsJSu-000000022Jy-3CCg
	for kexec@lists.infradead.org;
	Thu, 04 Apr 2024 09:33:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712223181; x=1743759181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DMeWIz1Du52cE1BkXc9SPzON+93nq6RzYRZOTm7qPd8=;
  b=FDtva7HqrLjlG832CklTVptBCPS72drXndpCbS8NA87qOx7lwFPS9hAs
   +uc8AW7tdcjMCZnSUFWlhLxNAepMZ4NOx9MtmCy4vg4ZMEtGZeJ5n9HW6
   tyNAeRKimhrM8ZQjSk1e5NIpm+UKdn0kkTKOorBj78f1MkSF158n1fMU5
   3S42ZGXPVwH+4W3T1jps8MpUjVFS0SnULbplVbBkQN2WnaJU0WihcObug
   RoV50TMpq4QJGX6TAIqRY0aq+RGWS3oY7Z5SHmt8QaaPoOnyzA2SiEQS3
   vJaJc1yFrOxblMhrqPJ+xtF1+M/QoER/zRsD9cjK5J7HG/RbYKSug9UKj
   Q==;
X-CSE-ConnectionGUID: zjOxUg9fSOiuZtxeQSZqsg==
X-CSE-MsgGUID: qo/m92zPSL2525c4/XZLmg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="11267035"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="11267035"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 02:32:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="937086251"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="937086251"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2024 02:32:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4079A12C; Thu,  4 Apr 2024 12:32:52 +0300 (EEST)
Date: Thu, 4 Apr 2024 12:32:52 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, 
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
Message-ID: <cxwixclmgbx3xidn6g6keihampcbzcbosog6r6lyoa4hs3teu2@sqntzeltdajc>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
 <20240325103911.2651793-6-kirill.shutemov@linux.intel.com>
 <b94c81ef-50f2-4e66-9533-461791777d10@intel.com>
 <dlixf7bld4efdh5goir5nreabkgtcwfbvv2rovjqrvjttplqss@auuqnt4h2llj>
 <j4s4n5slt6a234w5o5r4zjmb3xj53odnmwekt6ihotfzotd7ur@ghyvphwcki57>
 <8e4e1d80-11ef-472f-befc-f61310281f18@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8e4e1d80-11ef-472f-befc-f61310281f18@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_023300_877136_D8EB390C 
X-CRM114-Status: GOOD (  29.65  )
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

On Thu, Apr 04, 2024 at 10:40:34AM +1300, Huang, Kai wrote:
> 
> 
> On 3/04/2024 4:42 am, Kirill A. Shutemov wrote:
> > On Fri, Mar 29, 2024 at 06:48:21PM +0200, Kirill A. Shutemov wrote:
> > > On Fri, Mar 29, 2024 at 11:21:32PM +0800, Xiaoyao Li wrote:
> > > > On 3/25/2024 6:38 PM, Kirill A. Shutemov wrote:
> > > > > TDX guests are not allowed to clear CR4.MCE. Attempt to clear it leads
> > > > > to #VE.
> > > > 
> > > > Will we consider making it more safe and compatible for future to guard
> > > > against X86_FEATURE_MCE as well?
> > > > 
> > > > If in the future, MCE becomes configurable for TD guest, then CR4.MCE might
> > > > not be fixed1.
> > > 
> > > Good point.
> > > 
> > > I guess we can leave it clear if it was clear. This should be easy
> > > enough. But we might want to clear even if was set if clearing is allowed.
> > > 
> > > It would require some kind of indication that clearing MCE is fine. We
> > > don't have such indication yet. Not sure we can reasonably future-proof
> > > the code at this point.
> > > 
> > > But let me think more.
> > 
> > I think I will go with the variant below.
> > 
> > diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> > index 56cab1bb25f5..8e2037d78a1f 100644
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
> > @@ -145,11 +147,17 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> >   	 * Set cr4 to a known state:
> >   	 *  - physical address extension enabled
> >   	 *  - 5-level paging, if it was enabled before
> > +	 *  - Machine check exception on TDX guest, if it was enabled before.
> > +	 *    Clearing MCE might not allowed in TDX guests, depending on setup.
> 
> Nit:  Perhaps we can just call out:
> 
> 	Clearing MCE is not allowed if it _was_ enabled before.
> 
> Which is always true I suppose.

It is true now. Future TDX will allow to clear CR4.MCE and we don't want
to flip it back on in this case.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
