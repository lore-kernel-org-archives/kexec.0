Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B19C00A98
	for <kexec@archiver.kernel.org>; Fri, 20 Oct 2023 15:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZdPx3ESTEUgy7kFmHjUKb5WN9rBMjQxXliQBWX+gun4=; b=Ke3OcbdZZI0rVk
	ETxVdSQd1UzIUJ2XF4hpc/AHMJKxRVz0S3D8cjkKeGSUDOS8Nmak3r9SSUJVvt+WnvN7O+VbjQcqt
	kIb+yXga+utGFup5fF42o548VHJ3iV518wyuDSKN+Ewt68Tl+X1Q+5vnOuM3b8CrSSNNrYVtJZNVH
	LydExhImoEWxjbOUmp9NukYX6utvJp/m8xZclfHc0zI3Nw/Et6lsHqHoRE0noalcsd6eqKrJVqCoF
	8/VoecZ50sI6Y36S7Yb6zEmrZ3OJg6yFlH5FQj8QzogONPe0ff5Um+hZ8LAaU25BFKsErZAApi1DQ
	QdatBV5jXsNwV9LdJz3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtrct-002dEj-0x;
	Fri, 20 Oct 2023 15:41:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtrcq-002dE3-2j
	for kexec@lists.infradead.org;
	Fri, 20 Oct 2023 15:41:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697816483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aa4iee+yZHK+8BBdXmj4PGqXcZj5CIosrDU7qDGuMQQ=;
	b=LGoSNWk7Fgz+Hb6CkNb7SzOeXFKOU2dNBC+syBBwOXPRtGqRiElIgVpscQ/+sT8pcDg/CL
	/SLemHeh0Do8NjUNkG3A+nSr2ezBvmw9AlvP9BSlnzLJsngPOkD2ik9CAAXRH+3zC5lfaL
	bV04g4PLjcpWxGpD4LPR+W+w0c/VAMc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-Rh_TvmBHMx-iaEyH7DDyjw-1; Fri, 20 Oct 2023 11:41:16 -0400
X-MC-Unique: Rh_TvmBHMx-iaEyH7DDyjw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-507bd5f4b2dso924328e87.2
        for <kexec@lists.infradead.org>; Fri, 20 Oct 2023 08:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697816475; x=1698421275;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aa4iee+yZHK+8BBdXmj4PGqXcZj5CIosrDU7qDGuMQQ=;
        b=bC7w+sQ8vof3g0aXQ8e1+UKSsdeAC1zYLm2XVnjDMsIhc3Arq8DwCkH0UXIcruoYxF
         IXjkm3WrP6dbSVuv3RsNnoQNkdS3OH/ZEmI2MWAl92Fckul8Brg9jOl9TN7eFSjHERVp
         OoGbkHFnSdCfiqeaiG1S0g4TfLTMgCvaZlrc1GusickQCz0yWHGV3aCzb7CzReSN0JeZ
         tCUVhzVNuQU5L9cJz5O83tiusLrBXxi1Jk7Go0/x5xZZvzm84LRND0yK9JU2c1zZh+P0
         r0igB3e0InGC2h6ZS3yfmKKKb3YXFWNiwVhdr3e4WlaKJ4d3BynCrxZ1E2oB3wQNPX4v
         w/4Q==
X-Gm-Message-State: AOJu0YyI78/n9Boh7+n5a9lSxr5tmxpq2/R8dqHMAwgn5hF4gtHIlAWe
	Hzk66SGKhzfs82mS44P3vdjSztfvIRJ66cWhcgDfDdTf27MUadyUqP/BMwjlOE2UfdpcYQjqKns
	862h7VbyINAyli49Dx1pX
X-Received: by 2002:a19:500c:0:b0:502:cc8d:f20a with SMTP id e12-20020a19500c000000b00502cc8df20amr1641005lfb.27.1697816474861;
        Fri, 20 Oct 2023 08:41:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx40VYFF8tpxC5v03dVRu4wq4nsq5G+AfVDRR5o1snolIVICfC2CekJy5f8SCZ1z4mgxc/Og==
X-Received: by 2002:a19:500c:0:b0:502:cc8d:f20a with SMTP id e12-20020a19500c000000b00502cc8df20amr1640982lfb.27.1697816474535;
        Fri, 20 Oct 2023 08:41:14 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id k13-20020a50c8cd000000b0053443c8fd90sm1642437edh.24.2023.10.20.08.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 08:41:14 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>, Jun Nakajima
 <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom
 Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, "Huang,
 Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wanpeng Li <wanpengli@tencent.com>
Subject: Re: [PATCHv2 04/13] x86/kvm: Do not try to disable kvmclock if it
 was not enabled
In-Reply-To: <20231020151242.1814-5-kirill.shutemov@linux.intel.com>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
 <20231020151242.1814-5-kirill.shutemov@linux.intel.com>
Date: Fri, 20 Oct 2023 17:41:12 +0200
Message-ID: <87wmvh47zb.fsf@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_084124_956617_E5EC18DD 
X-CRM114-Status: GOOD (  21.95  )
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

"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> writes:

> kvm_guest_cpu_offline() tries to disable kvmclock regardless if it is
> present in the VM. It leads to write to a MSR that doesn't exist on some
> configurations, namely in TDX guest:
>
> 	unchecked MSR access error: WRMSR to 0x12 (tried to write 0x0000000000000000)
> 	at rIP: 0xffffffff8110687c (kvmclock_disable+0x1c/0x30)
>
> kvmclock enabling is gated by CLOCKSOURCE and CLOCKSOURCE2 KVM paravirt
> features.
>
> Do not disable kvmclock if it was not enabled.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: c02027b5742b ("x86/kvm: Disable kvmclock on all CPUs on shutdown")
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kernel/kvmclock.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index fb8f52149be9..f2fff625576d 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -24,8 +24,8 @@
>  
>  static int kvmclock __initdata = 1;
>  static int kvmclock_vsyscall __initdata = 1;
> -static int msr_kvm_system_time __ro_after_init = MSR_KVM_SYSTEM_TIME;
> -static int msr_kvm_wall_clock __ro_after_init = MSR_KVM_WALL_CLOCK;
> +static int msr_kvm_system_time __ro_after_init;
> +static int msr_kvm_wall_clock __ro_after_init;
>  static u64 kvm_sched_clock_offset __ro_after_init;
>  
>  static int __init parse_no_kvmclock(char *arg)
> @@ -195,7 +195,8 @@ static void kvm_setup_secondary_clock(void)
>  
>  void kvmclock_disable(void)
>  {
> -	native_write_msr(msr_kvm_system_time, 0, 0);
> +	if (msr_kvm_system_time)
> +		native_write_msr(msr_kvm_system_time, 0, 0);
>  }
>  
>  static void __init kvmclock_init_mem(void)
> @@ -294,7 +295,10 @@ void __init kvmclock_init(void)
>  	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2)) {
>  		msr_kvm_system_time = MSR_KVM_SYSTEM_TIME_NEW;
>  		msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK_NEW;
> -	} else if (!kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)) {
> +	} else if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)) {
> +		msr_kvm_system_time = MSR_KVM_SYSTEM_TIME;
> +		msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK;
> +	} else {
>  		return;
>  	}

This should work, so

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

but my personal preference would be to change kvm_guest_cpu_offline()
to check KVM features explicitly instead of checking MSRs against '0'
at least becase it already does so for other features. Completely
untested:

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index b8ab9ee5896c..1ee49c98e70a 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -454,7 +454,9 @@ static void kvm_guest_cpu_offline(bool shutdown)
        kvm_pv_disable_apf();
        if (!shutdown)
                apf_task_wake_all();
-       kvmclock_disable();
+       if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2) ||
+           kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE))
+               kvmclock_disable();
 }

-- 
Vitaly


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
