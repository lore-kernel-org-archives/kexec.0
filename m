Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F71E81E04
	for <kexec@archiver.kernel.org>; Fri,  6 Oct 2023 14:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oQWl3Nd/zE2Te52ET/rKqGC3AfYCHrRzETvf6lGAfIc=; b=iHKdswgtwOA+9u
	SAxEJO34ZQdviPI03w0ZPBLiz2rU/YwJtvzO58+vaSKp8JsYrgUD1uOKFy0cFW5joWKlmwXm6S4Gm
	y2a3U7VA9mojfXcIE8dO3WM8YK2U6hcdGSzRvA3T96YYsL9V2xyf43Pe7zaNtwqVikPJlNAYYm+dZ
	WPJU3l9pUd12QGinnYcccFGsUG07pluxqwZN6x9+RTa09ZLOzLTP04Wd+WsQPp8dOjEj+VL4CHn9u
	WwWz07myl7TijcdTSPL6EtRGsUKfcE3yUdhd9tnlXVQVQfU5Jr7lUkP6C9NRnYlgCBZaQoClAwmmv
	aNfKXgLwa59CfFr274JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qom9u-0061Cy-03;
	Fri, 06 Oct 2023 14:50:30 +0000
Received: from mgamail.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qom9r-0061By-0r
	for kexec@lists.infradead.org;
	Fri, 06 Oct 2023 14:50:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696603827; x=1728139827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W/51r4qVWeOrP4iJgr+qcAMJuEyFjcjduXqKxwHzQXk=;
  b=Fcqt9ZQ6LbEVrXyIpq69o0Z0EQJaCwb47gxeiNOB+StGrBuoNGAy8Aue
   pFtd2GgAtuFnzx6Za38OWN5rxUxlRofr3sXZmIHek6x+EI85e66a/+jTQ
   8u5eNr0QGJanESG05z9W+BVaCqdMmp0zV68hGxVnZdWEDpFQf6+gsistt
   k/TQxn6vsLaHKcnZ8yzbDMT95ptjtez6YE6y+HaMsdKvsQ470V1XIunjR
   sNwWCotal/B+VwIi4ZLtnsGOfaU9HEEMTVmg7fz81mC3miuY3ZX9FH+Ul
   y7ZyMNK8Ft8mIkyBOY3sGSV/86fYDVJtZ8H0I10vkFiIDrsvFVyTgXpyo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="374108530"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="374108530"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 07:50:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="781680129"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="781680129"
Received: from kvsudesh-mobl1.gar.corp.intel.com (HELO box.shutemov.name) ([10.251.222.76])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 07:50:19 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 236CC10A172; Fri,  6 Oct 2023 17:50:17 +0300 (+03)
Date: Fri, 6 Oct 2023 17:50:17 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 04/13] x86/kvm: Do not try to disable kvmclock if it was
 not enabled
Message-ID: <20231006145017.26q2quuiup2emodp@box.shutemov.name>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-5-kirill.shutemov@linux.intel.com>
 <ZSAbhk7fu_w3ClOv@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZSAbhk7fu_w3ClOv@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231006_075027_370078_F6279A75 
X-CRM114-Status: GOOD (  24.20  )
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

On Fri, Oct 06, 2023 at 07:36:54AM -0700, Sean Christopherson wrote:
> +Paolo
> 
> Please use get_maintainers...

Will do, sorry.

> On Thu, Oct 05, 2023, Kirill A. Shutemov wrote:
> > kvm_guest_cpu_offline() tries to disable kvmclock regardless if it is
> > present in the VM. It leads to write to a MSR that doesn't exist on some
> > configurations, namely in TDX guest:
> > 
> > 	unchecked MSR access error: WRMSR to 0x12 (tried to write 0x0000000000000000)
> > 	at rIP: 0xffffffff8110687c (kvmclock_disable+0x1c/0x30)
> > 
> > kvmclock enabling is gated by CLOCKSOURCE and CLOCKSOURCE2 KVM paravirt
> > features.
> > 
> > Do not disable kvmclock if it was not enumerated or disabled by user
> > from kernel command line.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Fixes: c02027b5742b ("x86/kvm: Disable kvmclock on all CPUs on shutdown")
> > ---
> >  arch/x86/kernel/kvmclock.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> > index fb8f52149be9..cba2e732e53f 100644
> > --- a/arch/x86/kernel/kvmclock.c
> > +++ b/arch/x86/kernel/kvmclock.c
> > @@ -22,7 +22,7 @@
> >  #include <asm/x86_init.h>
> >  #include <asm/kvmclock.h>
> >  
> > -static int kvmclock __initdata = 1;
> > +static int kvmclock __ro_after_init = 1;
> >  static int kvmclock_vsyscall __initdata = 1;
> >  static int msr_kvm_system_time __ro_after_init = MSR_KVM_SYSTEM_TIME;
> >  static int msr_kvm_wall_clock __ro_after_init = MSR_KVM_WALL_CLOCK;
> > @@ -195,7 +195,12 @@ static void kvm_setup_secondary_clock(void)
> >  
> >  void kvmclock_disable(void)
> >  {
> > -	native_write_msr(msr_kvm_system_time, 0, 0);
> > +	if (!kvm_para_available() || !kvmclock)
> > +		return;
> > +
> > +	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE) ||
> > +	    kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2))
> > +		native_write_msr(msr_kvm_system_time, 0, 0);
> 
> Rather than recheck everything and preserve kvmclock, what about leaving the MSR
> indices '0' by default and then disable msr_kvm_system_time iff it's non-zero.
> That way the disable path won't become stale if the conditions for enabling
> kvmclock change.

Okay, works for me too.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
