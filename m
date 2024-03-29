Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00829C6FD1F
	for <kexec@archiver.kernel.org>; Fri, 29 Mar 2024 16:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IckbBlykSSRKcbHXK2m8eHYJjPHEQTKKY+mUZ5zh0as=; b=K6kY7TVHL9TnC3
	rtNTSixbjNUxGrT3iaL1wNy4Lty98QPwLC5tvdtNvmpVfaIAvWv7kL/3U4JBG3nPiV5yfNvK900Nt
	s8v1dGNmk3X0x1xc48aIRhFOoNinowjy1RdJq4LYdSOxFkkl6pFkxXODEeFdZ4qmDW1d0U4bjVYE4
	ZLiwLch1SkhOMW6nu5cV+IWCXCr6E+FDlEeCBx2gDKwjnNbr0KbJnEE/YqWaP646AmDUtQiQN2eKL
	sXitJaSEK81RNqIWO6pIx/wq5qFD6qfcJQDrVcINDnXZEC7MfJyTyq5mJ+CO8df0JXXpAK5NZfzTl
	cJBrCYoBlOTV4WLot0DA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqFP7-00000001MUM-3pSH;
	Fri, 29 Mar 2024 16:48:33 +0000
Received: from mgamail.intel.com ([198.175.65.10])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqFP5-00000001MT2-0sRq
	for kexec@lists.infradead.org;
	Fri, 29 Mar 2024 16:48:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711730911; x=1743266911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VHSFCeLmDsuoG8JZu78Wui4erUPAkz/n1mlCxxF71tE=;
  b=QwRL6NFD3CovA3cCH1uimULpVd5+QPwC/V6OR0o2X4EEyJF8L4yYPPvT
   fVX4GhFLhXIEyozldpRfgZF9VFdKwvp+Pdbw7jRgoIcikEsKaobsI8zmd
   Ho4gQtCZZfjTqGgGmCyh7x4wF5tRXKnX3E3GlAuNIeJP7Ll8sMfmDUi0v
   1QH51Y52SVJNbXrkTx8jlgkaBmYeyhXLAEkiqLFvn3HjyKQyN00npwOhL
   5jwncDfOLGDIQaNC32jFE1h5NuCTdIfPWqj3YqM+/zOcvQduyOyeL57sc
   wb9Ez5DBQgMG0XpJLyKvihMNtskQ7dDvNPp3K+mPD2Hz+1BJSGfWXM8MO
   A==;
X-CSE-ConnectionGUID: stxCEt2gTK+IBPlNp+TR7Q==
X-CSE-MsgGUID: 1VXxugWkT2KFlG4jKNYRhA==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="24385641"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="24385641"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 09:48:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="937078212"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="937078212"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Mar 2024 09:48:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 59EA818F; Fri, 29 Mar 2024 18:48:21 +0200 (EET)
Date: Fri, 29 Mar 2024 18:48:21 +0200
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
Message-ID: <dlixf7bld4efdh5goir5nreabkgtcwfbvv2rovjqrvjttplqss@auuqnt4h2llj>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
 <20240325103911.2651793-6-kirill.shutemov@linux.intel.com>
 <b94c81ef-50f2-4e66-9533-461791777d10@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b94c81ef-50f2-4e66-9533-461791777d10@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240329_094831_330400_752C5E19 
X-CRM114-Status: GOOD (  13.56  )
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

On Fri, Mar 29, 2024 at 11:21:32PM +0800, Xiaoyao Li wrote:
> On 3/25/2024 6:38 PM, Kirill A. Shutemov wrote:
> > TDX guests are not allowed to clear CR4.MCE. Attempt to clear it leads
> > to #VE.
> 
> Will we consider making it more safe and compatible for future to guard
> against X86_FEATURE_MCE as well?
> 
> If in the future, MCE becomes configurable for TD guest, then CR4.MCE might
> not be fixed1.

Good point.

I guess we can leave it clear if it was clear. This should be easy
enough. But we might want to clear even if was set if clearing is allowed.

It would require some kind of indication that clearing MCE is fine. We
don't have such indication yet. Not sure we can reasonably future-proof
the code at this point.

But let me think more.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
