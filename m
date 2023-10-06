Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F43E81DFF
	for <kexec@archiver.kernel.org>; Fri,  6 Oct 2023 14:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=jA3lhRrEUMHNfvhuDREyjgJP5O7PJhfL7iX4qPxN5FI=; b=EENk7Wm97x/Sf15tgXjExKGOhR
	n8od0cIOALtoP2jXfuNgdnMLZLhmIdcBVvS/OTP6COEvJ/meRhCTYFDHgzR8kdnuchHZEeyf0u5iJ
	Yy5Vzg2wYc8ffsSMxCjk5UecbwiAHHA6S52x5SQ67nbI58BaTmmwnu8tv8+2QOdSdqtmnDtflXuwj
	z5gm3f5M4catsL+4FxYLPC16DFcHkHkkQ3gHqv/eVT/c6cIZgXv5rCUTrDVvEuZVpRKdNXN4ISM98
	+ZbXvcJq7TVbed6LANa44IRBH+PPSOjOFZA5fyz7YeQik2L3MbA+0WdSNOdke7q32jJQoshzQi9S+
	RssKuIcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qolwq-005zgk-2f;
	Fri, 06 Oct 2023 14:37:00 +0000
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qolwn-005zfT-18
	for kexec@lists.infradead.org;
	Fri, 06 Oct 2023 14:36:58 +0000
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a1df5b7830so33862847b3.1
        for <kexec@lists.infradead.org>; Fri, 06 Oct 2023 07:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696603016; x=1697207816; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i58l4QdfZN6X+tVl9sXUSU5MssTQt5gV2xYo4Yk/tro=;
        b=RhevwWLnFfK6NLrRM1prD+R5g+0lslutWfs5y6dpYXD7J+25GfFmsOd0nq8cLkRqbN
         oZZLaAr2ImbU9n6C1as2j+N0RD8lYqL90Q49mwCvHPSMq+aFhy21n/gc42c7n7XcaV07
         XCzK60AJzSNi0fkF/v2C/uVEwU4uZFX25zQKKROkNNlxBCrYzbq7PFmb61X1bPX14j5o
         uJN5GRXZVEBEo/927hCqUuzJsxXn1WvFOz8Ok1PXEDq/pPmTp9ln7J4vtbKzWymU1ytE
         gS0HAcTwlPMS7klGyLqYtPxHC3gO2zlGFKK5b5dynw+63rXARANjdwP5RvlBIttsmZ71
         PZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696603016; x=1697207816;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i58l4QdfZN6X+tVl9sXUSU5MssTQt5gV2xYo4Yk/tro=;
        b=L1UaRkY9kEf7ZfAjkNShFVgSgUNaSqUTPbu91pPezjwJFcIe5wkoKrHoQMcUitpQPU
         FJZ+Lgz3mOwGJ2K0A0g6f4+9pvAT98v8/S5o3Hpt8xMKVZOfoIndadEbJSL3Y/nSiGAs
         Lv6udMSV5IX8O6rozlbA9fbZcjixHEtntL//MdY/0yU2Eu6jnpNlLRfggqpkPOufhNf/
         qGin1teTesuUdZJKusP4rrnLTVxpINwEd043uTGXMkI4eAvKvARz8iuxy0kxZnCX4JuW
         M+Sk7o8zsXgDvrQpffDKeyFpgQgb3hVzZBYh9LK7HsF/q0+NZNTtNfQFDuyF71W5FMMf
         CiNw==
X-Gm-Message-State: AOJu0Yz1UgqOju89spzviYLxwqACWYOcs3Xq8akAkA2pDZQk4sZKlaKz
	Aud/axqMwU3+YT5BTG0xv4TiU0PFpPc=
X-Google-Smtp-Source: AGHT+IFQPwuq8dktatytMOhE25UzyzqCNlQC2UUPVzg1lqdTu+UMho1qRpPPz4wW/QHlMjyqJHF5XE+bNrg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ae59:0:b0:d7e:752f:baee with SMTP id
 g25-20020a25ae59000000b00d7e752fbaeemr117773ybe.10.1696603015772; Fri, 06 Oct
 2023 07:36:55 -0700 (PDT)
Date: Fri, 6 Oct 2023 07:36:54 -0700
In-Reply-To: <20231005131402.14611-5-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com> <20231005131402.14611-5-kirill.shutemov@linux.intel.com>
Message-ID: <ZSAbhk7fu_w3ClOv@google.com>
Subject: Re: [PATCH 04/13] x86/kvm: Do not try to disable kvmclock if it was
 not enabled
From: Sean Christopherson <seanjc@google.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Elena Reshetova <elena.reshetova@intel.com>, Jun Nakajima <jun.nakajima@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231006_073657_432372_3D2F6666 
X-CRM114-Status: GOOD (  22.82  )
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

+Paolo

Please use get_maintainers...

On Thu, Oct 05, 2023, Kirill A. Shutemov wrote:
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
> Do not disable kvmclock if it was not enumerated or disabled by user
> from kernel command line.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: c02027b5742b ("x86/kvm: Disable kvmclock on all CPUs on shutdown")
> ---
>  arch/x86/kernel/kvmclock.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index fb8f52149be9..cba2e732e53f 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -22,7 +22,7 @@
>  #include <asm/x86_init.h>
>  #include <asm/kvmclock.h>
>  
> -static int kvmclock __initdata = 1;
> +static int kvmclock __ro_after_init = 1;
>  static int kvmclock_vsyscall __initdata = 1;
>  static int msr_kvm_system_time __ro_after_init = MSR_KVM_SYSTEM_TIME;
>  static int msr_kvm_wall_clock __ro_after_init = MSR_KVM_WALL_CLOCK;
> @@ -195,7 +195,12 @@ static void kvm_setup_secondary_clock(void)
>  
>  void kvmclock_disable(void)
>  {
> -	native_write_msr(msr_kvm_system_time, 0, 0);
> +	if (!kvm_para_available() || !kvmclock)
> +		return;
> +
> +	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE) ||
> +	    kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2))
> +		native_write_msr(msr_kvm_system_time, 0, 0);

Rather than recheck everything and preserve kvmclock, what about leaving the MSR
indices '0' by default and then disable msr_kvm_system_time iff it's non-zero.
That way the disable path won't become stale if the conditions for enabling
kvmclock change.

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index fb8f52149be9..f2fff625576d 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -24,8 +24,8 @@
 
 static int kvmclock __initdata = 1;
 static int kvmclock_vsyscall __initdata = 1;
-static int msr_kvm_system_time __ro_after_init = MSR_KVM_SYSTEM_TIME;
-static int msr_kvm_wall_clock __ro_after_init = MSR_KVM_WALL_CLOCK;
+static int msr_kvm_system_time __ro_after_init;
+static int msr_kvm_wall_clock __ro_after_init;
 static u64 kvm_sched_clock_offset __ro_after_init;
 
 static int __init parse_no_kvmclock(char *arg)
@@ -195,7 +195,8 @@ static void kvm_setup_secondary_clock(void)
 
 void kvmclock_disable(void)
 {
-       native_write_msr(msr_kvm_system_time, 0, 0);
+       if (msr_kvm_system_time)
+               native_write_msr(msr_kvm_system_time, 0, 0);
 }
 
 static void __init kvmclock_init_mem(void)
@@ -294,7 +295,10 @@ void __init kvmclock_init(void)
        if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2)) {
                msr_kvm_system_time = MSR_KVM_SYSTEM_TIME_NEW;
                msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK_NEW;
-       } else if (!kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)) {
+       } else if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)) {
+               msr_kvm_system_time = MSR_KVM_SYSTEM_TIME;
+               msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK;
+       } else {
                return;
        }


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
