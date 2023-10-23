Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C99CDB474
	for <kexec@archiver.kernel.org>; Mon, 23 Oct 2023 08:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FQfjUdcVln2Xa2axhXdIz3XCB3aJBK72MYLnvNcwt5M=; b=0eibYUAZxwMbH0
	MZEAu5wzeqqJotWlOFaum5nqnhJtIsw/Z4FAfJHs+cuzn8F5GVKnN2kS6xiVcY05E2UL9Uz/l/9qC
	hpb6zcB/MOIi7VsA5A43iPVnI+HHA67us/ygDVar1a59ydnWZrF7MvlJA4xx5eiA4EY4TZsmvQnoA
	V2e808OfTTwKhzcQu+O7OgBp/C66Y66uIvPXJ0TcZNDy7lPKx2NBdun4HQ2gsTelBVl+E3S0pp1l0
	zuTHuHHHT2TMxnWjToiavtd1RHn+7Mv1GQ3gNwXH5oqPJFxucMAHMzXKEjd7Kio1GhkKVI17CW5WT
	M9A7zT+8+/ghQCNaunDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1quqZB-006o9q-1B;
	Mon, 23 Oct 2023 08:45:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1quqZ7-006o95-2U
	for kexec@lists.infradead.org;
	Mon, 23 Oct 2023 08:45:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698050735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ONX0XVyCTtsac8zioBH3gBVyx/xvQWqU8VDZR3vizo=;
	b=XaIEgQYK/KYOCXAwQTuzhRg2eXbT1O6S3AKXvz5OzFCqYk3xlglrolU4aeA3N8nMZ/vjWM
	n7fHMDIAPAkTJhz1Jiu2dlyQUYDuks47FXHxqAZXc8cJkI+41S2hIB5vwTzu8JLYiMyZLZ
	VPvV3pPFydT5+KN/OLXyL5GIZGTV4Qo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-P0wFK5MSOOa6bZAUgLxZuQ-1; Mon, 23 Oct 2023 04:45:33 -0400
X-MC-Unique: P0wFK5MSOOa6bZAUgLxZuQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99bcb13d8ddso186272566b.0
        for <kexec@lists.infradead.org>; Mon, 23 Oct 2023 01:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698050732; x=1698655532;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ONX0XVyCTtsac8zioBH3gBVyx/xvQWqU8VDZR3vizo=;
        b=oo5HWFaQF9hJPjY0NT1mwpanJSYTuX/42pOWhlgrru7Smayv+diEhNacLfD3hl80fZ
         JTGuEGTGmT/T65weCuoAXko7vsz5jQJIXMqS6dZW3KsIGrs4i86PaJ8/zF8qt1roKZRb
         IT3aj1225Qh5+uZBZG7Sc4MfyID2zZTC28A/wO4skxTGGaKgFsDYKetFSjPlhLxvdTCa
         U3q4B7OhnWjiLTC5Snd1CB64bEO3mR8NUdojPgwiWfN6tXLSTgwJEzUyOHx/7KFOWwdI
         h0xNTzW7QZnT6jUzx0oPm0CSH86JY02Oo+3FXSSnlLejKZBGAb6mvNncRM0AOE7ZuUBF
         mHqw==
X-Gm-Message-State: AOJu0YyL1yqqFUkPhGPYwPhWRIhWmMU9DMRBsIZz5nr4l4KgL6H4PZYF
	4tNiRn5ZeRH/4UxagYzGCo3uJNv4QGMVnvhv2o5+MMlUuupoRuB3pXNXKJSoiQ0/1kZQiUFPZUr
	cG5ssDhm09OUkTEDFMsDE
X-Received: by 2002:a17:906:eec6:b0:9c7:5200:e4f4 with SMTP id wu6-20020a170906eec600b009c75200e4f4mr6393508ejb.41.1698050732748;
        Mon, 23 Oct 2023 01:45:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWTFAp6QtMJSjMVDuSWl670+37nbjJceCxIyo+JB67CunU+EP22o6HuiyUdGLqsHZXvKal7w==
X-Received: by 2002:a17:906:eec6:b0:9c7:5200:e4f4 with SMTP id wu6-20020a170906eec600b009c75200e4f4mr6393489ejb.41.1698050732408;
        Mon, 23 Oct 2023 01:45:32 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id m1-20020a170906580100b009ae3e6c342asm6302165ejq.111.2023.10.23.01.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 01:45:31 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>, Jun Nakajima
 <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom
 Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Wanpeng
 Li <wanpengli@tencent.com>
Subject: Re: [PATCHv2 04/13] x86/kvm: Do not try to disable kvmclock if it
 was not enabled
In-Reply-To: <ZTKg9XMxeBQ36f5L@google.com>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
 <20231020151242.1814-5-kirill.shutemov@linux.intel.com>
 <87wmvh47zb.fsf@redhat.com> <ZTKg9XMxeBQ36f5L@google.com>
Date: Mon, 23 Oct 2023 10:45:30 +0200
Message-ID: <87r0ll4thx.fsf@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231023_014537_899506_674E3D11 
X-CRM114-Status: GOOD (  25.46  )
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

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Oct 20, 2023, Vitaly Kuznetsov wrote:
>> > ---
>> >  arch/x86/kernel/kvmclock.c | 12 ++++++++----
>> >  1 file changed, 8 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
>> > index fb8f52149be9..f2fff625576d 100644
>> > --- a/arch/x86/kernel/kvmclock.c
>> > +++ b/arch/x86/kernel/kvmclock.c
>> > @@ -24,8 +24,8 @@
>> >  
>> >  static int kvmclock __initdata = 1;
>> >  static int kvmclock_vsyscall __initdata = 1;
>> > -static int msr_kvm_system_time __ro_after_init = MSR_KVM_SYSTEM_TIME;
>> > -static int msr_kvm_wall_clock __ro_after_init = MSR_KVM_WALL_CLOCK;
>> > +static int msr_kvm_system_time __ro_after_init;
>> > +static int msr_kvm_wall_clock __ro_after_init;
>> >  static u64 kvm_sched_clock_offset __ro_after_init;
>> >  
>> >  static int __init parse_no_kvmclock(char *arg)
>> > @@ -195,7 +195,8 @@ static void kvm_setup_secondary_clock(void)
>> >  
>> >  void kvmclock_disable(void)
>> >  {
>> > -	native_write_msr(msr_kvm_system_time, 0, 0);
>> > +	if (msr_kvm_system_time)
>> > +		native_write_msr(msr_kvm_system_time, 0, 0);
>> >  }
>> >  
>> >  static void __init kvmclock_init_mem(void)
>> > @@ -294,7 +295,10 @@ void __init kvmclock_init(void)
>> >  	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2)) {
>> >  		msr_kvm_system_time = MSR_KVM_SYSTEM_TIME_NEW;
>> >  		msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK_NEW;
>> > -	} else if (!kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)) {
>> > +	} else if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)) {
>> > +		msr_kvm_system_time = MSR_KVM_SYSTEM_TIME;
>> > +		msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK;
>> > +	} else {
>> >  		return;
>> >  	}
>> 
>> This should work, so
>> 
>> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> 
>> but my personal preference would be to change kvm_guest_cpu_offline()
>> to check KVM features explicitly instead of checking MSRs against '0'
>> at least becase it already does so for other features. Completely
>> untested:
>> 
>> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
>> index b8ab9ee5896c..1ee49c98e70a 100644
>> --- a/arch/x86/kernel/kvm.c
>> +++ b/arch/x86/kernel/kvm.c
>> @@ -454,7 +454,9 @@ static void kvm_guest_cpu_offline(bool shutdown)
>>         kvm_pv_disable_apf();
>>         if (!shutdown)
>>                 apf_task_wake_all();
>> -       kvmclock_disable();
>> +       if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2) ||
>> +           kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE))
>> +               kvmclock_disable();
>>  }
>
> That would result in an unnecessray WRMSR in the case where kvmclock is disabled
> on the command line.  It _should_ be benign given how the code is written, but
> it's not impossible to imagine a scenario where someone disabled kvmclock in the
> guest because of a hypervisor bug.  And the WRMSR would become a bogus write to
> MSR 0x0 if someone made a "cleanup" to set msr_kvm_system_time if and only if
> kvmclock is actually used, e.g. if someone made Kirill's change sans the check in
> kvmclock_disable().

True but we don't have such module params to disable other PV features so
e.g. KVM_FEATURE_PV_EOI/KVM_FEATURE_MIGRATION_CONTROL are written to
unconditionally. Wouldn't it be better to handle parameters like
'no-kvmclock' by clearing the feature bit in kvm_arch_para_features()'s
return value so all kvm_para_has_feature() calls for it just return
'false'? We can even do an umbreall "no-kvm-features=<mask>" to cover
all possible debug cases.

-- 
Vitaly


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
