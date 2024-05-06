Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E310DC10F16
	for <kexec@archiver.kernel.org>; Mon,  6 May 2024 13:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aBXjSAi45OpSvcy2Y+ttXef1mqN98TlJbZXgBYWfrAg=; b=YOlC08WoLxtwXw
	BD98PRsnR+zEwMM1WMoHJX/2OO2FrUSbW0Dc+Nrlqfd11ONwLTbDYycHY0EilgYt2bvWoAiniCYub
	yphj7teZ389VVdAkMVULDWbYpw2lCHZ1mdI8CRiT8EkkNVUlt2bGug5q9byZSjNb0R3fSJTcH2ua1
	aF/vIbSTwdR80Ro5biZcOfBqlwqMPQ3DxBuDex9XGARRrp5km9AodLBCpikFVvxEhnTPQLvZEbQqb
	XsbK5q39KEQLRbjV5NkEdK3QxKwj+UnbzW4T2yFapH0XMQmWJL+6a3BbLorKV6xHfeUCwfFE/xCxl
	17TEbMBP1iOB4fUqt7Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3yIQ-00000007R0S-3Foo;
	Mon, 06 May 2024 13:22:22 +0000
Received: from mgamail.intel.com ([198.175.65.13])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3yIM-00000007Qxh-0FZh
	for kexec@lists.infradead.org;
	Mon, 06 May 2024 13:22:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715001738; x=1746537738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BCuAyhvvdHlZNeT/yRgbvu9IxMPed1+0m8MQqbV2QlI=;
  b=lBo8X0XWTC0oEzoyvLJ+NO9H9I5yGyyHhDfv/P/FqAsT1FPLym3gGcFV
   lLYaiy9cgUSSZHmkJzFVNbrDVHK0yxrh3DvAjW8Kk8nkOsyyIX+zvryTr
   nP8Ndh7FJgndXQOEijP6j1vXVIDUhcbMd8D6p8vp23tcE2kzy2HmYAJN6
   9uaL//pCURTcW4z2aZz+qFcDJfkkaGTBFPV1gZ4y3zvUHpWoGMxX6spjt
   6VXrY05wYQaGjWLX3kvyZ40JYeGixJ9hHQ9bEAB01aYymzUd5KpSzKYWq
   KGmB5UjaP8SX1n+wr9k4bctLqrHF3txtDaZd+NOexKIMLQZuGjVlcD/tu
   A==;
X-CSE-ConnectionGUID: gTprRwH8T9GegHL9QX9sKg==
X-CSE-MsgGUID: Ye2ro4G7Riyk5PBVbTI2bw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="21900693"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="21900693"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 06:22:09 -0700
X-CSE-ConnectionGUID: by/aMopuSXyo3mmKnNMsxg==
X-CSE-MsgGUID: kPhhB31ETkuyZsPTIKNoJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="28256756"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 06 May 2024 06:22:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 0513A12B; Mon, 06 May 2024 16:22:02 +0300 (EEST)
Date: Mon, 6 May 2024 16:22:02 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: adrian.hunter@intel.com, ashish.kalra@amd.com, bhe@redhat.com, 
	dave.hansen@linux.intel.com, elena.reshetova@intel.com, jun.nakajima@intel.com, 
	kai.huang@intel.com, kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, ltao@redhat.com, mingo@redhat.com, nik.borisov@suse.com, 
	peterz@infradead.org, rafael@kernel.org, rick.p.edgecombe@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	x86@kernel.org
Subject: Re: [PATCHv10.1 09/18] x86/mm: Adding callbacks to prepare encrypted
 memory for kexec
Message-ID: <ch244dd4k5nu5rcryuwqp4pztl4dduhciqunin5drr7a3yls2h@siisliaoc2f6>
References: <20240427164747.GCZi0sM6HBCBYtgWqF@fat_crate.local>
 <20240427170634.2397725-1-kirill.shutemov@linux.intel.com>
 <20240502134506.GDZjOY4guvlKH9-73J@fat_crate.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240502134506.GDZjOY4guvlKH9-73J@fat_crate.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240506_062218_155529_A6383F86 
X-CRM114-Status: GOOD (  16.61  )
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

On Thu, May 02, 2024 at 03:45:06PM +0200, Borislav Petkov wrote:
> > diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> > index e74d0c4286c1..f1b261be78b4 100644
> > --- a/arch/x86/kernel/crash.c
> > +++ b/arch/x86/kernel/crash.c
> > @@ -128,6 +128,10 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
> >  #ifdef CONFIG_HPET_TIMER
> >  	hpet_disable();
> >  #endif
> > +
> > +	x86_platform.guest.enc_kexec_stop_conversion(true);
> > +	x86_platform.guest.enc_kexec_unshare_mem();
> > +
> 
> You call them here back-to-back...
> 
> >  	crash_save_cpu(regs, safe_smp_processor_id());
> >  }
> >  
> > diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> > index f3130f762784..c1920ec34f0c 100644
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
> > @@ -716,6 +717,14 @@ static void native_machine_emergency_restart(void)
> >  
> >  void native_machine_shutdown(void)
> >  {
> > +	/*
> > +	 * Call enc_kexec_stop_conversion() while all CPUs are still active and
> > +	 * interrupts are enabled. This will allow all in-flight memory
> > +	 * conversions to finish cleanly.
> > +	 */
> > +	if (kexec_in_progress)
> > +		x86_platform.guest.enc_kexec_stop_conversion(false);
> > +
> >  	/* Stop the cpus and apics */
> >  #ifdef CONFIG_X86_IO_APIC
> >  	/*
> > @@ -752,6 +761,9 @@ void native_machine_shutdown(void)
> >  #ifdef CONFIG_X86_64
> >  	x86_platform.iommu_shutdown();
> >  #endif
> > +
> > +	if (kexec_in_progress)
> > +		x86_platform.guest.enc_kexec_unshare_mem();
> 
> ... but they're split here.
> 
> And I don't know why and nothing tells me...

I do. See comment just above enc_kexec_stop_conversion() call.

Do you want also comment for enc_kexec_unshare_mem() ?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
