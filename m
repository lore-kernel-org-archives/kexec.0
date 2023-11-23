Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CAFC5AD4C
	for <kexec@archiver.kernel.org>; Thu, 23 Nov 2023 13:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tEGuNTxZTsk+tVBZLvj+hdtyYvZhF2lmeR3R8wbVcDA=; b=JChLwbSL5woxBp
	kdFypcGhOzMlPTT7jJdMpxSh0lNwyoKlcooPDXidz3lLc9FePg+Z6TQjCPO5dGL5hLQ+nE66pj3ZZ
	aDE3BpvO9CH6UUVRBaWPlc81DW/ELPyoqFDqsKipHBQxvgMrh11p7X22gyzcNTr7ux5ZOKy9+sSaR
	P90155yLTqGm0nsoWOD/4HjJmtxtlB76/Krq0zGF57vlI5N2keyvYx7ejw6FyLr8b+LA+GsTKR8sp
	QBZnuK/dMlmm5E+AdtgmM1UEOEV8hDqpEeqklSSKXaC5Hgzw+Qd9za3JZ5jUZWLImubZ/29Di6K+v
	9U8PTpxvBcUJMOX71FoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6A3Z-004wHb-1Z;
	Thu, 23 Nov 2023 13:47:49 +0000
Received: from mgamail.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r6A3X-004wFo-0I
	for kexec@lists.infradead.org;
	Thu, 23 Nov 2023 13:47:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700747267; x=1732283267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+3ldtTDXARvqNtIx8SpOQNFanxpj2hF5Q8A+SDJI1ck=;
  b=lsAtoN3YifXFv9B+dzFLCmpUu6fi3OGOzYHzHfmvRzlMUsehRXNQP+Wz
   6jw/kGXJ9aU20iE9TJfJr+qtWbOhACEs43gofj+VuvxMjtlhlWrEIYd2T
   sPEjMwWyHwmoRz7RIEnyLJredMIheFG81F351IeoPj96yfuZJoZw7NHSH
   DZYfvYk5hr3GmBi1/yTSVpNQroi6GIuQEAKsWRsApfI6LSZutnj6Y7rXF
   k60TNQISLNqoPzkhuttM/CLsm5nvgj/LunC8a/Fx0/BQPhHK+UBGsVyQ5
   VXThfm3aH7Bm9rRwHHAfL3zbNFqVMK62DNyR4LxqJJlM8EcvPvDDmTm5Y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="389417772"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="389417772"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 05:47:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="833431403"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="833431403"
Received: from ckochhof-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.58.117])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 05:47:33 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 6F5A210A38A; Thu, 23 Nov 2023 16:47:31 +0300 (+03)
Date: Thu, 23 Nov 2023 16:47:31 +0300
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
	"mingo@redhat.com" <mingo@redhat.com>,
	"seanjc@google.com" <seanjc@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"bhe@redhat.com" <bhe@redhat.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv3 10/14] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <20231123134731.4zc3nq7gpzrcrbos@box.shutemov.name>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
 <20231115120044.8034-11-kirill.shutemov@linux.intel.com>
 <8277e9a1df4c3fd968edf670b0aa7dc1dd50dcf8.camel@intel.com>
 <20231121095859.36xiltn2gwgyxmwy@box.shutemov.name>
 <d7ac53b76217abbb9bc06717b76ec91a376ba210.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d7ac53b76217abbb9bc06717b76ec91a376ba210.camel@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231123_054747_152247_4A844447 
X-CRM114-Status: GOOD (  32.10  )
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

On Wed, Nov 22, 2023 at 10:07:44AM +0000, Huang, Kai wrote:
> On Tue, 2023-11-21 at 12:58 +0300, kirill.shutemov@linux.intel.com wrote:
> > On Tue, Nov 21, 2023 at 03:46:41AM +0000, Huang, Kai wrote:
> > > 
> > > >  
> > > > +static atomic_t conversions_in_progress;
> > > > +static bool conversion_allowed = true;
> > > > 
> > > 
> > > [...]
> > > 
> > > >  /* Used while preparing memory map entries for second kernel */
> > > >  struct crash_memmap_data {
> > > > @@ -107,6 +108,9 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
> > > >  
> > > >  	crash_smp_send_stop();
> > > >  
> > > > +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> > > > +		x86_platform.guest.enc_kexec_unshare_mem(true);
> > > > +
> > > >  	cpu_emergency_disable_virtualization();
> > > >  
> > > >  	/*
> > > > diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> > > > index 830425e6d38e..9fb302562bfd 100644
> > > > --- a/arch/x86/kernel/reboot.c
> > > > +++ b/arch/x86/kernel/reboot.c
> > > > @@ -12,6 +12,7 @@
> > > >  #include <linux/delay.h>
> > > >  #include <linux/objtool.h>
> > > >  #include <linux/pgtable.h>
> > > > +#include <linux/kexec.h>
> > > >  #include <acpi/reboot.h>
> > > >  #include <asm/io.h>
> > > >  #include <asm/apic.h>
> > > > @@ -31,6 +32,7 @@
> > > >  #include <asm/realmode.h>
> > > >  #include <asm/x86_init.h>
> > > >  #include <asm/efi.h>
> > > > +#include <asm/tdx.h>
> > > >  
> > > >  /*
> > > >   * Power off function, if any
> > > > @@ -716,6 +718,9 @@ static void native_machine_emergency_restart(void)
> > > >  
> > > >  void native_machine_shutdown(void)
> > > >  {
> > > > +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) && kexec_in_progress)
> > > > +		x86_platform.guest.enc_kexec_unshare_mem(false);
> > > > +
> > > >  	/* Stop the cpus and apics */
> > > >  #ifdef CONFIG_X86_IO_APIC
> > > >  	/*
> > > 
> > > In native_machine_crash_shutdown() the "unshare" is called after
> > > crash_smp_send_stop(), but here it's called before the stop_other_cpus().
> > > 
> > > I am wondering if you call "unshare" after stop_other_cpus(), can we guarantee
> > > there's only one cpu running in both normal and crash kexec in which case you
> > > might be able to get rid of the "conversions_in_progress" and
> > > "conversion_allowed" above?
> > 
> > For normal kexec we need to keep other CPUs going so they can finish
> > conversion cleanly and get us to the known state. Note that the conversion
> > is not atomic wrt preemption.
> 
> Yeah makes sense.
> 
> Add a comment to explain this?  That would help to remind us when we look at the
> code like years later.

Okay, will do.

> > In crash scenario we do the best effort: detect if we race with conversion
> > and report. We cannot really wait for conversions to finish: we get into
> > crash path with IRQs disabled and in generally unknown state.
> > 
> 
> Maybe it's good idea to add a TDVMCALL to query page status from the TDX module?
> In that case we can avoid the inaccuracy when looking at the page table.

No. TDX module has no control over what memory is shared. Shared-EPT is in
full control of VMM and therefore we have to track unshared memory on the
guest side to make sure that VMM doesn't do silly things.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
