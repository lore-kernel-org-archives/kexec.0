Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685CDC00A8F
	for <kexec@archiver.kernel.org>; Mon, 23 Oct 2023 14:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=uGo4fNkZQUDUcbCZdUowRCrR8z2mFIj0JhDncDgzJYg=; b=eRbXUti8ZP8+e1lHPOu7bLshc+
	U1KR3hIRxujz1UytK5NBkl3Z7XIh+2S5+yoFFAr1GHiHViHswhzZV0YSYLIMfcQZCWkBWs9teQBR4
	QnCLUZKNYNx1WlXr+ig8n3+0iff8KeSyba0FaIk3lSszrOUuoR64wW+WGJzNd4wdqyk64MNVOvrcU
	NAoj4GH2oA1LGO8qLVsFDqYnWvMAzJC/UvL4YzbcI7wz3GvyxO4IUmDJwOcA/ZGFKpaAyrwmy9bSA
	Ye1A/+6tnsyUt5InxjlALFtAonP0HzR+MYBfBR+B6SmTeTGVvelYf1Mojje4MGRVQTKIaq/wF9H8t
	RvyYbAXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1quw7i-007aNL-1L;
	Mon, 23 Oct 2023 14:41:42 +0000
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1quw6w-007Zfz-1q
	for kexec@lists.infradead.org;
	Mon, 23 Oct 2023 14:40:57 +0000
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5b8ae483459so681231a12.1
        for <kexec@lists.infradead.org>; Mon, 23 Oct 2023 07:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698072052; x=1698676852; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TOIO+H7vBCJRfyqao5vTRDK/ZnUXqp5753SeNzy629c=;
        b=NVM4YLwlQ2J8Fp/ioDfFowdcuTw1SP6sVN0LEOFOJfvgfyeozpQg+e5gBTZU5fnf8R
         wpvVeeQsDz5j4zX/lIvc63L5SBwyzpLrOY51iIIe9u48NabOSe4fExAnYr9sqi3pTDSi
         uViwYpMdsVUhsNLj9mOSJHWpgPCwWW62EM3t/GOBmpwV6ZY4vqMMcGevA9v7YRJnNa7m
         38tCglpaql6i2DR541QDrHa3+RBAU5In88zkxK3/NHjHMjpQSMEs6phOYFPJ+SI6OVqW
         F7vaRyve9Bx5SjUr1mDrk9RtSbJH9DNYFHdyipPRmBwi/u3YzsQBOXnI01Tsv6ZUg8KB
         +08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698072052; x=1698676852;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TOIO+H7vBCJRfyqao5vTRDK/ZnUXqp5753SeNzy629c=;
        b=WjSutBDbVMXRt0GkcPiDP1W5pt7fMu7mxmP/O+BSqxLeNCtHITNrUNJn80HHSIMyrv
         rDbYenDP4M6shtAr0Gs7m3IVQxaAHJnxCHT4btXZSfGGT/+Pqb+J4dW7U20WRRaYqW7j
         LcGLvulAvjHO8bnhJ/6i97+Om/O/TUxMYubNBUcd1O1XsuE2uxssyTJz169xXmgH8XnY
         PBH3xGSvbOYpFNVbSzw93lIuI6YZvPh+BItADtBjDQotWxkhII64CInTLF2ps9CZ5hK+
         hvFMyHj26DFMvXLQhSdBgovDYs6QjlMC7KvccFp5lGmbUASwDUufoTowZgYE2aGhYCFU
         2Deg==
X-Gm-Message-State: AOJu0Yykeqc9N4nKUTSC901jfqLynqNFH9a7avHgJ6/sXT1E5U9jEtWx
	1NcIGMtxe36i89PWf6L2zFN9yvxfzS4=
X-Google-Smtp-Source: AGHT+IExAuTTDvPv+uDKpzbze6eiqwdc7PLWiowzJWFsT1Fls/h45TIz/DhVhP8uEFt0TqXIZLj2MgO8bn8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:e551:0:b0:584:dd94:24c1 with SMTP id
 z17-20020a63e551000000b00584dd9424c1mr155269pgj.11.1698072052492; Mon, 23 Oct
 2023 07:40:52 -0700 (PDT)
Date: Mon, 23 Oct 2023 07:40:50 -0700
In-Reply-To: <87r0ll4thx.fsf@redhat.com>
Mime-Version: 1.0
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
 <20231020151242.1814-5-kirill.shutemov@linux.intel.com> <87wmvh47zb.fsf@redhat.com>
 <ZTKg9XMxeBQ36f5L@google.com> <87r0ll4thx.fsf@redhat.com>
Message-ID: <ZTaF8n9WM5BQ3rYS@google.com>
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
X-CRM114-CacheID: sfid-20231023_074054_638588_1FF6B70F 
X-CRM114-Status: GOOD (  24.18  )
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

On Mon, Oct 23, 2023, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Fri, Oct 20, 2023, Vitaly Kuznetsov wrote:
> >> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> >> index b8ab9ee5896c..1ee49c98e70a 100644
> >> --- a/arch/x86/kernel/kvm.c
> >> +++ b/arch/x86/kernel/kvm.c
> >> @@ -454,7 +454,9 @@ static void kvm_guest_cpu_offline(bool shutdown)
> >>         kvm_pv_disable_apf();
> >>         if (!shutdown)
> >>                 apf_task_wake_all();
> >> -       kvmclock_disable();
> >> +       if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2) ||
> >> +           kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE))
> >> +               kvmclock_disable();
> >>  }
> >
> > That would result in an unnecessray WRMSR in the case where kvmclock is disabled
> > on the command line.  It _should_ be benign given how the code is written, but
> > it's not impossible to imagine a scenario where someone disabled kvmclock in the
> > guest because of a hypervisor bug.  And the WRMSR would become a bogus write to
> > MSR 0x0 if someone made a "cleanup" to set msr_kvm_system_time if and only if
> > kvmclock is actually used, e.g. if someone made Kirill's change sans the check in
> > kvmclock_disable().
> 
> True but we don't have such module params to disable other PV features so
> e.g. KVM_FEATURE_PV_EOI/KVM_FEATURE_MIGRATION_CONTROL are written to
> unconditionally. Wouldn't it be better to handle parameters like
> 'no-kvmclock' by clearing the feature bit in kvm_arch_para_features()'s
> return value so all kvm_para_has_feature() calls for it just return
> 'false'? We can even do an umbreall "no-kvm-features=<mask>" to cover
> all possible debug cases.

I don't know that it's worth the effort, or that it'd even be a net positive.

Today, kvm_para_has_feature() goes through to CPUID every time, e.g. we'd have
to add a small bit of infrastructure to snapshot and clear bits, or rework things
to let kvm_para_has_feature peek at kvmclock.

And things like KVM_FEATURE_PV_TLB_FLUSH would be quite weird, e.g. we either end
up leaving the feature bit set while returning "false" for pv_tlb_flush_supported(),
or we'd clear the feature bit for a rather large number of conditions that don't
really have anything to do with KVM_FEATURE_PV_TLB_FLUSH being available.

  static bool pv_tlb_flush_supported(void)
  {
	return (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
		!kvm_para_has_hint(KVM_HINTS_REALTIME) &&
		kvm_para_has_feature(KVM_FEATURE_STEAL_TIME) &&
		!boot_cpu_has(X86_FEATURE_MWAIT) &&
		(num_possible_cpus() != 1));
  }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
