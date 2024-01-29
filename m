Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03A1C47422
	for <kexec@archiver.kernel.org>; Mon, 29 Jan 2024 13:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dd2Raeba1OsA7BEM2IOY1DFup1L2JXzPApfLspho+TM=; b=dp+iSCYI50akeJ
	1513jCzRlskHLtyShTKz36TzPM3tp5+3aeq9XET043+lxQLfHiDQcDF58mZvTQeZlWoM6nh9z5q98
	ilwAhE/J19ApxB4bfcYBIxt+NTWExW3iH/0p0gXq3UClEHXcNHChlQ+aEQileDrqPgdLpqq+5A16E
	4QAvNDX2u/3CK8Rzh7vqj5sXjb7Ls1EDJ98NDCOQV1SfXhuHPsqoaWA9oTA9aRSWLO9grawA1olYE
	avbsT8HgH9o+3EdC/DhoTpSvs5c10FAuA9EtCCCQn9oG6nkN3KN7CUv60r3a+OOYHPLzE2sYlu8mY
	uR4c2yYCH27fVbz1C4Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rURvo-0000000CuwW-0ji5;
	Mon, 29 Jan 2024 13:44:12 +0000
Received: from mgamail.intel.com ([198.175.65.10])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rURvk-0000000CuvJ-3JRk
	for kexec@lists.infradead.org;
	Mon, 29 Jan 2024 13:44:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706535849; x=1738071849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S8kbVyjQ+Xxyq/e0oWsbM2LE48Ugi1oJFP+DJtdQZK8=;
  b=iHfhM6o7zald2zEQ7qbej7k16Ri/FpNhtr10X59U2FyHkMtY4o0gfXWl
   XEM2Nt6/jJWHqlzzyw+Gh4932QZGVDLDcbKLWdcJPgfTZ/5pfrkCWQBTP
   k8iLDKPPjuMkKW6BFl7r2iFFSew2nRHwJl7q8OZfFHFJnq5tcwwmO5Np2
   uHF4clJuPv1b3gdCSw6D+wxG1J8A1441a2yc6imWGLlrAwa95mh3/qlhk
   WdGBEaTkhLvbo2LRN7gQ/vJpg4RUlihPSodRhpscuVLVihhce5MLw9FUC
   V4/s+MLQwZD7twhGhv3fUvPvAL9XKUc/JNVBBiEDc03nWwv1ehzSXgwYr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="16311022"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="16311022"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 05:44:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="931093593"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="931093593"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jan 2024 05:44:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 992EC53C; Mon, 29 Jan 2024 15:34:26 +0200 (EET)
Date: Mon, 29 Jan 2024 15:34:26 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Sean Christopherson <seanjc@google.com>, 
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 10/16] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <ao36mdmctptya2r25v3lvuocjbhllum2upmskxjcjtt3c7o3ii@nsghte2cnmkx>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <20240124125557.493675-11-kirill.shutemov@linux.intel.com>
 <f0677a02-72ea-49e8-9499-18eca6b5e8d7@amd.com>
 <r5logoyy46fztohkm6bjobomsrst2izbs2nsts4fegii2uswca@fovizly7y5ju>
 <fad515ec-aba3-4f48-b8be-ebc6640899e3@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fad515ec-aba3-4f48-b8be-ebc6640899e3@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_054408_946424_E8EB2B82 
X-CRM114-Status: GOOD (  23.20  )
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

On Mon, Jan 29, 2024 at 07:09:37AM -0600, Kalra, Ashish wrote:
> Hello Kirill,
> 
> On 1/29/2024 4:36 AM, Kirill A. Shutemov wrote:
> > On Mon, Jan 29, 2024 at 04:24:09AM -0600, Kalra, Ashish wrote:
> > > In case of SNP and crash/kdump case, we need to prevent the boot_ghcb being
> > > converted to shared (in snp_kexec_unshare_mem()) as the boot_ghcb is
> > > required to handle all I/O for disabling IO-APIC/lapic, hpet, etc., as the
> > > enc_kexec_unshare_mem() callback is invoked before the apics, hpet, etc. are
> > > disabled.
> > > 
> > > Is there any reason why enc_kexec_unshare_mem() callback is invoked in crash
> > > case before the IO-APIC/lapic, hpet, etc. are shutdown/disabled ?
> > Not really. Either way works for TDX. I've tested the patch below. Is it
> > what you want?
> > 
> > diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> > index 6585a5f2c2ba..3001f4857ed7 100644
> > --- a/arch/x86/kernel/crash.c
> > +++ b/arch/x86/kernel/crash.c
> > @@ -107,11 +107,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
> >   	crash_smp_send_stop();
> > -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
> > -		x86_platform.guest.enc_kexec_stop_conversion(true);
> > -		x86_platform.guest.enc_kexec_unshare_mem();
> > -	}
> > -
> >   	cpu_emergency_disable_virtualization();
> >   	/*
> > @@ -129,6 +124,12 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
> >   #ifdef CONFIG_HPET_TIMER
> >   	hpet_disable();
> >   #endif
> > +
> > +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
> > +		x86_platform.guest.enc_kexec_stop_conversion(true);
> > +		x86_platform.guest.enc_kexec_unshare_mem();
> > +	}
> > +
> >   	crash_save_cpu(regs, safe_smp_processor_id());
> >   }
> 
> Yes, this will work for SNP.

Okay, good. Will include the change into the next version of the patchset.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
