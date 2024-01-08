Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EECC3DA6E
	for <kexec@archiver.kernel.org>; Mon,  8 Jan 2024 10:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bwa5bcnnh5ARz43Ovkihti5Hd6mRVYDg1SXell61zhg=; b=QG5I1SEmluWKEJ
	ZfhNrrfUOLa1fsWx8q5Eg0EaoTTAGG6h2VnUZIzi5hH732AbCns0qnZS3Tyo1XH031hpBbDcyK5Rs
	3DJvjaPvUKeVKiOBp9YO0aaaFkIoeYWtt8UhUcy4rmI/NNkX1r7jIeP8a13N8la6x4R24bs2AF/kx
	dXrIp9/5eac+QYc/VVMV7v7/b0EygsKfv08IRtfYxiIo2jjgZa2olIrLuBGh21TyFOUDa6q2eHE2U
	ZRATHRkk1VnQty8sIVKMNbgXXXTzFIfdPNfoDK5MujEs6yftH7trhpxsOScS+8WqxUTXq+uausg4x
	9mz1q7cPYlQ/LX5BisRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMmfw-004aME-0I;
	Mon, 08 Jan 2024 10:16:08 +0000
Received: from mgamail.intel.com ([192.198.163.9])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMmfs-004aLB-2j
	for kexec@lists.infradead.org;
	Mon, 08 Jan 2024 10:16:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704708965; x=1736244965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4nAoV/4uxsiWvej/YdpQzm9DtSV2JOFymBVOkYdlfxs=;
  b=gQs/pVjXDOMin7pc0xVjkOoofka2YNgrgRqVCQsjE8p7ZyCWHMGPvaHT
   I9AvBLcLwDAll7o7AF7Ba1MXDye+j2F8rCQCanMlknxAKZ8AkAcxoppvh
   d0oFOMei3d3TL7vwoPWKLq7Ea9HMBsDl1xutly714uTCLrWRvg918Z7aw
   RFN3ze5P3ZxdejGtiszJVS5ncfTtq1xmWYQ0ioOIa3Dr28KUgryTSTLKh
   hxxAHzIqtyZHUccX9EaLCzLGkrBvIIh4BQsF7usOpMGWYNvKM3k5GpQD/
   /xFu5U0HebVf84fWAVbAjW8u7dqTfvVABuc/vJSmMQlfA/dwhdDz/WDEo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="4634135"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="4634135"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 02:16:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="731062339"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="731062339"
Received: from ddraghic-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.212.53])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 02:15:56 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 6FAB5109E5C; Mon,  8 Jan 2024 13:15:53 +0300 (+03)
Date: Mon, 8 Jan 2024 13:15:53 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bhe@redhat.com" <bhe@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv5.1 14/16] x86/smp: Add smp_ops.stop_this_cpu() callback
Message-ID: <20240108101553.4zgji5emlw7cjlik@box.shutemov.name>
References: <20231222235209.32143-15-kirill.shutemov@linux.intel.com>
 <20231225080524.4240-1-kirill.shutemov@linux.intel.com>
 <d23475c878ce1bc899a6b9f613252e985d97d094.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d23475c878ce1bc899a6b9f613252e985d97d094.camel@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240108_021604_940834_A34D6BB6 
X-CRM114-Status: GOOD (  28.94  )
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

On Mon, Jan 08, 2024 at 03:04:31AM +0000, Huang, Kai wrote:
> On Mon, 2023-12-25 at 11:05 +0300, Kirill A. Shutemov wrote:
> > If the helper is defined, it is called instead of halt() to stop the CPU
> > at the end of stop_this_cpu() and on crash CPU shutdown.
> > 
> > ACPI MADT will use it to hand over the CPU to BIOS in order to be able
> > to wake it up again after kexec.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> > 
> >  v5.1:
> >    - Fix build for !SMP;
> > 
> > ---
> >  arch/x86/include/asm/smp.h |  1 +
> >  arch/x86/kernel/process.c  |  7 +++++++
> >  arch/x86/kernel/reboot.c   | 12 ++++++++----
> >  3 files changed, 16 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> > index 4fab2ed454f3..390d53fd34f9 100644
> > --- a/arch/x86/include/asm/smp.h
> > +++ b/arch/x86/include/asm/smp.h
> > @@ -38,6 +38,7 @@ struct smp_ops {
> >  	int (*cpu_disable)(void);
> >  	void (*cpu_die)(unsigned int cpu);
> >  	void (*play_dead)(void);
> > +	void (*stop_this_cpu)(void);
> >  
> >  	void (*send_call_func_ipi)(const struct cpumask *mask);
> >  	void (*send_call_func_single_ipi)(int cpu);
> > diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> > index b6f4e8399fca..ea4c812c7bf3 100644
> > --- a/arch/x86/kernel/process.c
> > +++ b/arch/x86/kernel/process.c
> > @@ -835,6 +835,13 @@ void __noreturn stop_this_cpu(void *dummy)
> >  	 */
> >  	cpumask_clear_cpu(cpu, &cpus_stop_mask);
> >  
> > +#ifdef CONFIG_SMP
> > +	if (smp_ops.stop_this_cpu) {
> > +		smp_ops.stop_this_cpu();
> > +		unreachable();
> > +	}
> > +#endif
> 
> If I read correctly this will result in stop_this_cpu() having different
> behaviour for SMP and !SMP build for TDX guest.  For example, AFAICT
> machine_halt() also calls stop_this_cpu() on local cpu after it stops other
> cpus.  So for the local cpu, in SMP build it will calls into BIOS's reset vector
> but in !SMP it will call native_halt().

It doesn't make a difference in practice: both halt and giving CPU to
BIOS will be unrecoverable operation. Both are equally acceptable for
machine_halt().

> > +
> >  	for (;;) {
> >  		/*
> >  		 * Use native_halt() so that memory contents don't change
> > diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> > index 16dde83df49a..738b3e810196 100644
> > --- a/arch/x86/kernel/reboot.c
> > +++ b/arch/x86/kernel/reboot.c
> > @@ -881,10 +881,14 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
> >  	cpu_emergency_disable_virtualization();
> >  
> >  	atomic_dec(&waiting_for_crash_ipi);
> > -	/* Assume hlt works */
> > -	halt();
> > -	for (;;)
> > -		cpu_relax();
> > +
> > +	if (smp_ops.stop_this_cpu) {
> > +		smp_ops.stop_this_cpu();
> 
> Could you explain why unreachable() is called in stop_this_cpu() but not here?

Compiler complained previously on stop_this_cpu() when it had halt() in
'else' case because the function is declared as __noreturn. I left
unreachable() after reworking it without 'else' to document the behaviour.

> > +	} else {
> > +		halt();
> > +		for (;;)
> > +			cpu_relax();
> > +	}
> 
> Similar to stop_this_cpu(), if you also call unreachable() here, then I think
> you can remove the 'else' here but directly calls halt() + cpu_relax() loop.

It doesn't make much difference to me. But okay, I will rework it the same
way in the next version.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
