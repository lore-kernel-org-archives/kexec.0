Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97971C54FB9
	for <kexec@archiver.kernel.org>; Tue, 21 Nov 2023 09:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z/xfbMccXDAjMGEn29oD+ZwzNAY5e/5JpdoyYlOt+x4=; b=xAKmTNqxqJRZNc
	nozUHVFAJ9gikmi8Nni0lPKxEoBckni63+LDz1F2nouyTY5CPu0SChDBCo6mOVwKr4T/lUyaGdHCB
	3/8+J7rQVNBcMuMkjnE4tSj4IjYSqFrJoRt1VX+/TqJh43Jawflscv/nUzBzCZugqWmG6x6uzPeyl
	z9/vR5s+J0i4PwhN/cL43dAJ44Jh1v8fXuxm6OQCL1rlUT3WpOwl2wLh3DOoxgVZUGufOxtF4vnKp
	3XVTA76C/tL/nxNQ0RkGw0yRVoYog5IYiREm+IWoHdwQLfbagatJPKFlCQ4GO08tMmR21Tuwl2b3i
	+1BhpuRPygJvIIuHk9xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5NXD-00GCS9-1k;
	Tue, 21 Nov 2023 09:59:11 +0000
Received: from mgamail.intel.com ([134.134.136.126])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5NXA-00GCRC-2g
	for kexec@lists.infradead.org;
	Tue, 21 Nov 2023 09:59:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700560748; x=1732096748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XyEy7zmHBwf6sIUIxjVHPKFIhUo8sYFFxrT0V70k+g8=;
  b=DMqNUu+p5GaxM1RuBR8UfcoFTeSQHUgh0nMqnGDkRxbydhB115EJca8F
   XQ5HQJ7phxkZj1q+s4HRZa1IHaYKP4RyXNxpZ/Xn9I8vVZO2vlg17Oo5y
   kUGzf08MW9HZz+749NaKOLtKbXXZWpKGsyC9faWTQwe6UHBGlE5c3BZYk
   uJ2/R+KTT4lw5eJ3Uu220y0msGgfTxc4IkPHwDm9DiDwb56YXWQggGY+D
   ofiY9HXM4TidWne/nqIZECRseSluu2N3ktRYG7IAujuFKOiitet4vq4Gj
   L8WvEiVXNrj6rWvbdDjaX9HWLOGox2okBh3rnY4t5GQHrTVzFtATXGS3C
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="376841398"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="376841398"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 01:59:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="766586766"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="766586766"
Received: from ikosarev-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.40.84])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 01:59:02 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id BFF8510A36E; Tue, 21 Nov 2023 12:58:59 +0300 (+03)
Date: Tue, 21 Nov 2023 12:58:59 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"bhe@redhat.com" <bhe@redhat.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv3 10/14] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <20231121095859.36xiltn2gwgyxmwy@box.shutemov.name>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
 <20231115120044.8034-11-kirill.shutemov@linux.intel.com>
 <8277e9a1df4c3fd968edf670b0aa7dc1dd50dcf8.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8277e9a1df4c3fd968edf670b0aa7dc1dd50dcf8.camel@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_015908_912514_AD7158EB 
X-CRM114-Status: GOOD (  23.16  )
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

On Tue, Nov 21, 2023 at 03:46:41AM +0000, Huang, Kai wrote:
> 
> >  
> > +static atomic_t conversions_in_progress;
> > +static bool conversion_allowed = true;
> > 
> 
> [...]
> 
> >  /* Used while preparing memory map entries for second kernel */
> >  struct crash_memmap_data {
> > @@ -107,6 +108,9 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
> >  
> >  	crash_smp_send_stop();
> >  
> > +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> > +		x86_platform.guest.enc_kexec_unshare_mem(true);
> > +
> >  	cpu_emergency_disable_virtualization();
> >  
> >  	/*
> > diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> > index 830425e6d38e..9fb302562bfd 100644
> > --- a/arch/x86/kernel/reboot.c
> > +++ b/arch/x86/kernel/reboot.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/objtool.h>
> >  #include <linux/pgtable.h>
> > +#include <linux/kexec.h>
> >  #include <acpi/reboot.h>
> >  #include <asm/io.h>
> >  #include <asm/apic.h>
> > @@ -31,6 +32,7 @@
> >  #include <asm/realmode.h>
> >  #include <asm/x86_init.h>
> >  #include <asm/efi.h>
> > +#include <asm/tdx.h>
> >  
> >  /*
> >   * Power off function, if any
> > @@ -716,6 +718,9 @@ static void native_machine_emergency_restart(void)
> >  
> >  void native_machine_shutdown(void)
> >  {
> > +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) && kexec_in_progress)
> > +		x86_platform.guest.enc_kexec_unshare_mem(false);
> > +
> >  	/* Stop the cpus and apics */
> >  #ifdef CONFIG_X86_IO_APIC
> >  	/*
> 
> In native_machine_crash_shutdown() the "unshare" is called after
> crash_smp_send_stop(), but here it's called before the stop_other_cpus().
> 
> I am wondering if you call "unshare" after stop_other_cpus(), can we guarantee
> there's only one cpu running in both normal and crash kexec in which case you
> might be able to get rid of the "conversions_in_progress" and
> "conversion_allowed" above?

For normal kexec we need to keep other CPUs going so they can finish
conversion cleanly and get us to the known state. Note that the conversion
is not atomic wrt preemption.

In crash scenario we do the best effort: detect if we race with conversion
and report. We cannot really wait for conversions to finish: we get into
crash path with IRQs disabled and in generally unknown state.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
