Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4FECCF9E3
	for <kexec@archiver.kernel.org>; Fri, 24 Oct 2025 13:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EznOlBH3J/wWVQFA/GsB5CR/rOLAX/sQ+gWhsHSThZ8=; b=G0dJ6TZV5kEy8NkWhfFy5nPgjp
	OetWeG72gYI0uLShjPxKY+qznfosFbsHtXvXl2YgcdyTGCfiVC+7FqhZ/cDZ8aZZuSFYm9SFH5edz
	+MTqv+dGIBWol2DbHXWpLTNza/9107T4MBVKG2l2kcYqQ0sgRnnIVpwIFJLaqVRd+XwuOSg95E/nb
	5S6K5dr4us5MUuje6BZxC2/XCU6gFKJUq8t/8k5kVQKCdaBBtO/TaqXs/+4gGn/vtUtg2IgrLn/P9
	0iR6TG52pjRH9DqAqOEs93+XXsOLl9gIUxSMsissZD8Rz9H2IDGGnLXRpoGUMvVPHdxcHHTJTbKOa
	e6hg/qFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCHRn-00000009U2p-0mQN;
	Fri, 24 Oct 2025 13:03:11 +0000
Received: from mgamail.intel.com ([192.198.163.18])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCHRk-00000009U1n-3Uhc
	for kexec@lists.infradead.org;
	Fri, 24 Oct 2025 13:03:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761310988; x=1792846988;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lpokBpTve9nKXGXDGJUc9rhB1uIH9BOEiKuUQcu2aKg=;
  b=S9PZhLUINnr0ZSneJGxqdSWHZ/GWa7SiNvEIqOFpRZQf4+ZFp3Ltsklr
   FfROe6tTl7MINEohqYxGaXLYk+70b0c1rSNxGBIIsVsMf0B7RTYCvH4yt
   4ro5aTljru65xgI9xzOUlB/eOUQwNSQmmFGSENBJgebfCGg2vCB31sRnL
   SrX2Rbfg5Y+WGko8ZqDXI4aoQXMZGckPAECqrfBMDzylb7aOsWHtZ1OWA
   rAbAREefl9lQM/0ud7HZrNgBcjoSRSzTw+kA+jRemWKFJIWZVmBebFXEL
   iLf5h0gqU1UMnVfTUC6nS4qetTck54y2LUgfGXyuszEchSOswHue2ZPZc
   g==;
X-CSE-ConnectionGUID: MmmSG3X5SCGhnCfOyr70zw==
X-CSE-MsgGUID: 2UCwph3uQ5WAPrCXQcb6SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62700683"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="62700683"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 06:03:08 -0700
X-CSE-ConnectionGUID: QUAK2y9xSO+DNF5Ut+WrKA==
X-CSE-MsgGUID: 7SxJscIBTjyYzwQSSwUSJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="184137908"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 24 Oct 2025 06:03:06 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 73BE796; Fri, 24 Oct 2025 15:03:05 +0200 (CEST)
Date: Fri, 24 Oct 2025 15:03:05 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Justinien Bouron <jbouron@amazon.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [resend, PATCH v2 1/1] kexec: Remove unused code in
 kimage_load_cma_segment()
Message-ID: <aPt5CYz5Cc-7St6L@black.igk.intel.com>
References: <20250916125124.3094021-2-andriy.shevchenko@linux.intel.com>
 <aNLd_6CO6YMvm2MN@80a9970eed1e>
 <aO1lmNyLCVUhL_kO@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO1lmNyLCVUhL_kO@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251024_060308_884703_17AC4D54 
X-CRM114-Status: GOOD (  27.79  )
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

On Mon, Oct 13, 2025 at 11:48:24PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 23, 2025 at 10:50:55AM -0700, Justinien Bouron wrote:
> > On Tue, Sep 16, 2025 at 02:51:09PM +0200, Andy Shevchenko wrote:
> > > clang is not happy about set but unused variable:
> > > 
> > > kernel/kexec_core.c:745:16: error: variable 'maddr' set but not used [-Werror,-Wunused-but-set-variable]
> > >   745 |         unsigned long maddr;
> > >       |                       ^
> > > 1 error generated.
> > > 
> > > Fix the compilation breakage (`make W=1` build) by removing unused variable.
> > > 
> > > As Nathan noted, GCC 16 produces the similar warning;
> > > 
> > > Fixes: f4fecb50d6e1 ("kexec_core: remove superfluous page offset handling in segment loading")
> > FYI the commit this patch is fixing (i.e. f4fecb50d6e1) is going to need a
> > second revision as well (I haven't submitted it yet, still working on it), this
> > means that your "Fixes:" tag will need to be changed again, requiring a 3rd
> > revision.
> > 
> > I am not sure what is the proper way forward here. Should I:
> >     - Send my v2, without fixing the unused variable and then you send your v3
> >       with the updated "Fixes:" tag pointing to my v2.
> >     - OR fixing the unused variable in my v2 (i.e. "absorb" this patch in my
> >       v2).
> 
> Second is the best (integrate this fix into yours v2).
> 
> > In the latter case, I am not sure how I am supposed to credit the work in this
> > case? Do I need to add another "Signed-off-by: Andy Shevchenko" besides mine?
> 
> Just in the comment block (after the cutter '---' line and before the diff) in
> a free words. No need for any special tags for this in such a case.
> 
> > I'm still learning the ropes on how to contribute through the mailing list so I
> > would be grateful if you could share your input on what's the proper way forward
> > here.

Any news, folks, please? The bug is still in Linux Next and prevents me from
building my stuff cleanly.

-- 
With Best Regards,
Andy Shevchenko



