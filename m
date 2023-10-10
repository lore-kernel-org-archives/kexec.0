Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7355DCD80DB
	for <kexec@archiver.kernel.org>; Tue, 10 Oct 2023 13:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JbdjjKF7s6I42th3AMGo3bvY+IO6oSTy4+QYxhD3XK8=; b=BiB3r2/ogW3Gq2
	DHJ73f/oDks01+AGz8FNoBk99pNJSmX/oRqUMHr6r3GAwdu05EqcXImeMPFT/LOefPTgjIoKV9Eer
	DbqYjXKV8LuNizv+LXcLD2QDaRDUiBGjuchoMUw7M1XLAQ80f/5itAQNRh4o4Pqos2mIrmzpK81cs
	0E1GsCPhx14IdGNPVliZaCixlJyuP+k2y/c6BNJpvZ9OBWomdJsZxUDZPMpIdyMabvQUDlZkl7KkJ
	a2rEyHwM66tgevcCqqUd+xPv5sXvamB+Fe5vE2NgWCCxfPIXWrSP/4zhVPBfyDMUy6ON+S0FlQg+7
	JAQGeIXQL0ReDAG4Rlfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqDBD-00DUlx-0s;
	Tue, 10 Oct 2023 13:53:47 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqDB6-00DUjn-0d
	for kexec@lists.infradead.org;
	Tue, 10 Oct 2023 13:53:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696946020; x=1728482020;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=STfmPYVLdo6+qt87QB/G2RvqDg2ED/4+X+sOB+AaltU=;
  b=En+Fut0GJcF4mRVR3bpZ4ZZ4yR3P9IUf5pMa0vZA/ElkZxIKj2NA9KXN
   udgmtQLcFOBcoFkUlmlO1Kto/fABBXTKQ0nWQOUWBp6ehvKtqdojSyx5T
   xhDXcJHPetopo2DKptjjmucPdXUkkbwZXnyWM242FaHN2UhxTV5t2Vh9e
   8K9Ae14z4nHl4FwaWR0rlxlAdFBRXvij78rhpsE8qXoI+rx2cysmNNWUF
   Si203GqfsB4SqnMS+OofoKFju4wjihLKCXofo8m+roGifmw+0RHvg9Afk
   di+IN5dg8/hfZm91CT5PClYjE1fwImZaQfB8p+1au4Jh8IszTdocwFx2X
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="2990218"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="2990218"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 06:53:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="747075063"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="747075063"
Received: from patinira-mobl.amr.corp.intel.com (HELO [10.212.128.216]) ([10.212.128.216])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 06:53:27 -0700
Message-ID: <b69b21b8-7915-4854-b5f7-5124cd4e5bbf@linux.intel.com>
Date: Tue, 10 Oct 2023 06:53:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] x86/kvm: Do not try to disable kvmclock if it was
 not enabled
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-5-kirill.shutemov@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20231005131402.14611-5-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231010_065340_275984_DB1F5FE7 
X-CRM114-Status: GOOD (  19.74  )
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



On 10/5/2023 6:13 AM, Kirill A. Shutemov wrote:
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

For the above warning,  check for CLOCKSOURCE and CLOCKSOURCE2
feature is sufficient, right? Do we need to include user/command-line
disable check here?

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
>  }
>  
>  static void __init kvmclock_init_mem(void)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
