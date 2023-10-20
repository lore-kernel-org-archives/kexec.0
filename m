Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8568FCDB474
	for <kexec@archiver.kernel.org>; Fri, 20 Oct 2023 17:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=40/BvoTJOFrO8DQMk/nD6DYJFGCWrTk8wxIeSOZfNBE=; b=n84jv9loCOHfuF8y/Swy5M7sPo
	v2bGkDZqHZGqW5BobLG+54yYxjnPw0YD4wy/8mAenQ05M6x7mdvd7oTKuUmi0QuCkXO+fn9T+ZNLV
	EU3gAhY/3x4r4ZpEQTCzrfvrqb1Mw6JNRIYMD7Dcqzp0mcdkDCsJ40/nDEMw/go0B9xYgfwX7GfCz
	ZRT6fPATHi0H2YsNLTjYQ2VNWfSPwRi3yMWtxMTs1qypsCFdXBACJF48kjh5kMrLZ6GSRbGM7Mw0s
	zOr73oP/M2frMR/6QIy1rQtB3vxQ3YhStLOT8aivbZENSVpLs1Wm7bvLO464FD7cheFGSA5DeHkfl
	CUYU3lgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtsyR-002k9c-2R;
	Fri, 20 Oct 2023 17:07:47 +0000
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtsyO-002k85-1G
	for kexec@lists.infradead.org;
	Fri, 20 Oct 2023 17:07:45 +0000
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-27779f49458so916162a91.2
        for <kexec@lists.infradead.org>; Fri, 20 Oct 2023 10:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697821656; x=1698426456; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x4BWurQpapK412rcDC+pUyHudLjLoftq7UvjlE0wpgY=;
        b=vJyyTqkgnsdLf+Zg4gXJyngRPpl5/RuF92j1RR6a7mO9jkY8GsmZ2/AjmiZI1I4fE0
         na/3L89OYeGr1IeIECOK5cU1mnetTok3QFlJ8Hb7BIUE0qpzXmwC9UhSYDIbOEBMSo9i
         X25tYHLveMCgJ7kE86YvNZKV6DzFD5QJaCGoEpBhOnpYPW2WY0nVyAHg6g6jtBewFknz
         ndBBBlj0n/VfbiUP7q/Z+SpvEtV5ldXyoQ+f9EdFfo3ntqG6kAsRgjeMIaE3Fvqdafkx
         FlxocfxTJ8YqttfguHTZ3l1ewU9qvQhYMozAUJYJYJlrxCQsbbFSi0HobDyJJm/DbJmN
         nUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697821656; x=1698426456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x4BWurQpapK412rcDC+pUyHudLjLoftq7UvjlE0wpgY=;
        b=tHMVnup3SYml4BnYMhvUU7mU0MLYLJ970cpCvRBq5bDqwD/K9ROif2pXpRYvSEluxd
         dC2nIYGTahQ3O2z/Bxqjdf6wZtkDJGn87U3hmVyyBzW68Q7g6lv5sV//GJgnrK9yRzOf
         z6vafNGJOsyZ0Cem49eG7T3zTLRcaAEG3pFJnSPQ5NOUPMlsT8Are2B2ErhuJnl3wfhj
         7DTg/MYs0FBoEbnOZcymCawZbkmMQrw4X9sP9OWwKW3aiCqRjbGF8gIMIQ8eslhAsI90
         BbO4GZjD9lwv7Yb7/QiE69JR9V7BZoDGadf+P6SmxTBNscrIoB4pQVzAd+FLHFmnSnLp
         PuJg==
X-Gm-Message-State: AOJu0YwbUYpPtfsnkRkRQSOaHqZzBrC02YmjZrQN+G2p4UVWcG3cWN43
	o8bh94Z9TVqBxGhjfi/OJ1nP0+Q3nP4=
X-Google-Smtp-Source: AGHT+IFD7JzGLSjKGr2CZcLV495hcYva5IMtUI4k4GCi8eJrVOm0W02oUecMyWYmDKA2AFrypQyXMTC0gf8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:ab88:b0:277:3135:bc4f with SMTP id
 n8-20020a17090aab8800b002773135bc4fmr57158pjq.1.1697821656319; Fri, 20 Oct
 2023 10:07:36 -0700 (PDT)
Date: Fri, 20 Oct 2023 17:07:34 +0000
In-Reply-To: <87wmvh47zb.fsf@redhat.com>
Mime-Version: 1.0
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
 <20231020151242.1814-5-kirill.shutemov@linux.intel.com> <87wmvh47zb.fsf@redhat.com>
Message-ID: <ZTKg9XMxeBQ36f5L@google.com>
Subject: Re: [PATCHv2 04/13] x86/kvm: Do not try to disable kvmclock if it was
 not enabled
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Elena Reshetova <elena.reshetova@intel.com>, Jun Nakajima <jun.nakajima@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Wanpeng Li <wanpengli@tencent.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_100744_456738_384063EC 
X-CRM114-Status: GOOD (  23.49  )
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

On Fri, Oct 20, 2023, Vitaly Kuznetsov wrote:
> > ---
> >  arch/x86/kernel/kvmclock.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> > index fb8f52149be9..f2fff625576d 100644
> > --- a/arch/x86/kernel/kvmclock.c
> > +++ b/arch/x86/kernel/kvmclock.c
> > @@ -24,8 +24,8 @@
> >  
> >  static int kvmclock __initdata = 1;
> >  static int kvmclock_vsyscall __initdata = 1;
> > -static int msr_kvm_system_time __ro_after_init = MSR_KVM_SYSTEM_TIME;
> > -static int msr_kvm_wall_clock __ro_after_init = MSR_KVM_WALL_CLOCK;
> > +static int msr_kvm_system_time __ro_after_init;
> > +static int msr_kvm_wall_clock __ro_after_init;
> >  static u64 kvm_sched_clock_offset __ro_after_init;
> >  
> >  static int __init parse_no_kvmclock(char *arg)
> > @@ -195,7 +195,8 @@ static void kvm_setup_secondary_clock(void)
> >  
> >  void kvmclock_disable(void)
> >  {
> > -	native_write_msr(msr_kvm_system_time, 0, 0);
> > +	if (msr_kvm_system_time)
> > +		native_write_msr(msr_kvm_system_time, 0, 0);
> >  }
> >  
> >  static void __init kvmclock_init_mem(void)
> > @@ -294,7 +295,10 @@ void __init kvmclock_init(void)
> >  	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2)) {
> >  		msr_kvm_system_time = MSR_KVM_SYSTEM_TIME_NEW;
> >  		msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK_NEW;
> > -	} else if (!kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)) {
> > +	} else if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)) {
> > +		msr_kvm_system_time = MSR_KVM_SYSTEM_TIME;
> > +		msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK;
> > +	} else {
> >  		return;
> >  	}
> 
> This should work, so
> 
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> but my personal preference would be to change kvm_guest_cpu_offline()
> to check KVM features explicitly instead of checking MSRs against '0'
> at least becase it already does so for other features. Completely
> untested:
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index b8ab9ee5896c..1ee49c98e70a 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -454,7 +454,9 @@ static void kvm_guest_cpu_offline(bool shutdown)
>         kvm_pv_disable_apf();
>         if (!shutdown)
>                 apf_task_wake_all();
> -       kvmclock_disable();
> +       if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2) ||
> +           kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE))
> +               kvmclock_disable();
>  }

That would result in an unnecessray WRMSR in the case where kvmclock is disabled
on the command line.  It _should_ be benign given how the code is written, but
it's not impossible to imagine a scenario where someone disabled kvmclock in the
guest because of a hypervisor bug.  And the WRMSR would become a bogus write to
MSR 0x0 if someone made a "cleanup" to set msr_kvm_system_time if and only if
kvmclock is actually used, e.g. if someone made Kirill's change sans the check in
kvmclock_disable().

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
