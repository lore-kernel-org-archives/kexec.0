Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDCBE81E05
	for <kexec@archiver.kernel.org>; Fri,  6 Oct 2023 15:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sKOK1r7UQahnaQAq4eDX7XhmsazZem3nX8GrVJtD9ic=; b=e/26+Vgw0Fg8pW
	8GrAKa64YHJrlaardMNws8mMp0/SOULHGNnoiDQoQ92ZLMAjeCU+IgEJStTZgrrZfDxAjbUx51LYG
	rx65qgqQQ5YQ+bdNDXO6Cu5GGicP3td/IY/mAkbDsBMmEm+rjfQcd2XjBcJGD0ITSJhmYhm8JwhbI
	jSrpkOC0uRpg7izVwbiQTKPsS0WjM2FUpgyK3gb5t2sNS6a4hP59S99mf2Sjhjuru0zuTA+c2zvf/
	QxAmotgeXe1B+iq4tL5hd9Rtf6zH4AByAsscXsWMvO8rxqPsSbQI8dCZZ8IatgY1nhd+Bdib6wnP6
	qJfAFbH+xK/sKtyPs+Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qomUp-0063tZ-2W;
	Fri, 06 Oct 2023 15:12:07 +0000
Received: from mgamail.intel.com ([192.55.52.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qomUn-0063rn-1d
	for kexec@lists.infradead.org;
	Fri, 06 Oct 2023 15:12:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696605125; x=1728141125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fjbIAXrWpPm5Y8Alw4dLyHvY0cP22rX9Piu85LI1l5Y=;
  b=PPK61ecvDbEX/aSCfi0DFu640Bo9J+vJyda5Em4Re01Js5nr5lS53yVP
   zLfcudDgbIyfbxYriDWOqxse0eFOX3Ds0fvr9CAMi2lZARPwlz0SimKGa
   c4OJemHfyenhNeSKNjzr7U6fkkQSvwG3VDKcVH7/k7CEFDJhHRTDvcZt1
   F2Q2PwaF/sx97bN8H1DcyKtKp9d2Xi6BFsVJUmQjR8JQHFD0zx70vkMt+
   Tav/V3cuPyM01kR15TqJTonnex/zpFaatqiZ4ccaVIb8IJZ5PYfYqqgni
   oQyK6btO0BX5XlmZ17WREdZ3UYi54Sulzurg/eoKJi2RP3rWdqw4Yn/oG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="470035256"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="470035256"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 08:11:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="702081581"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="702081581"
Received: from kvsudesh-mobl1.gar.corp.intel.com (HELO box.shutemov.name) ([10.251.222.76])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 08:11:54 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id AD52C10A172; Fri,  6 Oct 2023 18:11:51 +0300 (+03)
Date: Fri, 6 Oct 2023 18:11:51 +0300
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
	"Kalra, Ashish" <ashish.kalra@amd.com>
Subject: Re: [PATCH 10/13] x86/tdx: Convert shared memory back to private on
 kexec
Message-ID: <20231006151151.2m6t7fcu36hlrtzj@box.shutemov.name>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-11-kirill.shutemov@linux.intel.com>
 <ZSAge6W4vF6ePudw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZSAge6W4vF6ePudw@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231006_081205_566230_78255115 
X-CRM114-Status: GOOD (  27.17  )
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

On Fri, Oct 06, 2023 at 07:58:03AM -0700, Sean Christopherson wrote:
> On Thu, Oct 05, 2023, Kirill A. Shutemov wrote:
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 7368d254d01f..b5acf9fb4c70 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -884,6 +884,7 @@ config INTEL_TDX_GUEST
> >  	select X86_MEM_ENCRYPT
> >  	select X86_MCE
> >  	select UNACCEPTED_MEMORY
> > +	select EMERGENCY_VIRT_CALLBACK
> >  	help
> >  	  Support running as a guest under Intel TDX.  Without this support,
> >  	  the guest kernel can not boot or run under TDX.
> 
> ...
> 
> >  void __init tdx_early_init(void)
> >  {
> >  	struct tdx_module_args args = {
> > @@ -882,6 +1007,14 @@ void __init tdx_early_init(void)
> >  	 */
> >  	x86_cpuinit.parallel_bringup = false;
> >  
> > +	machine_ops.shutdown = tdx_shutdown;
> > +
> > +	/*
> > +	 * KVM overrides machine_ops.crash_shutdown, use emergency
> 
> This is going to be super confusing.  KVM utilizes the emergency virt callback.
> The KVM paravirt guest code uses .crash_shutdown().  People that are passingly
> familiar with virt and know what KVM is, but don't already know the difference
> between the two are going to be all kinds of confused.
> 
> I also feel like you're playing with fire, e.g. what's to stop the hypervisor
> specific paravirt guest support from using .shutdown() in the future?
> 
> And the callback is invoked for far more than just kexec().  I don't see how the
> host can emulate a reboot without destroying and rebuilding the VM, e.g. it can't
> stuff register state to emulate INIT or RESET.  Unless I'm missing something,
> converting shared memory back to private for a shutdown or reboot is undesirable
> as adds one more thing that can go wrong and prevent the system from cleanly
> shutting down ASAP (for some definitions of "cleanly").

Okay, fair enough. I will look for better way to hookup into kexec
process. That was the best fit I found so far, but yes it is not ideal.

> Lastly, doesn't SEV need similar behavior?  This seems like core functionality
> for any guest with cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT).  Why not make the
> "unshare on kexec" code common and gate it with CC_ATTR_GUEST_MEM_ENCRYPT?

I don't know SEV specifics. I am open to collaboration on this.

Tom, Ashish, let me know if you need this in generic code. I can arrange
that.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
