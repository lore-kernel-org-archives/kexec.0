Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE84ACD80D5
	for <kexec@archiver.kernel.org>; Tue, 10 Oct 2023 13:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qCKGFsDQ9VQMArOHHOD9sanPygiEwREos2wygounmzs=; b=N/OoWByb8TnbG4
	5UsLAVO++L4L5YUrvCVG96RP6LwzIb/O08qPJn07993ZiEwUlEjVDnRU+ihsRko1GeUD/Mda862xY
	T52nI+igiFlaOrem99JW9u3dQuCtF1jAKCxVJOSIJHsKNwcxLIA2J/ICHo/XnnGpi63a2At/uBebB
	5D6wvnHC7gC7fwoRdq8KAkwlHyDQxrgDVlxst/YKSsT8keXdLH217uxJYMRQlGEMZE4OeeJffB8Dk
	1AT57+6CW5cLyedIyBtRTDIGo0LvfF7xuCMCegPSGiriyuiN44XGov6KRfC+eDHKPeu18eeVFX8vs
	06P9mcmyUTBsC4Awupjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqCxM-00DSwH-09;
	Tue, 10 Oct 2023 13:39:28 +0000
Received: from mgamail.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqCxF-00DSs5-35
	for kexec@lists.infradead.org;
	Tue, 10 Oct 2023 13:39:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696945161; x=1728481161;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jFQ77hdf5zEKB0qNpCTju/j74KsLB6t/D+R9NA4ih+U=;
  b=IA56ZC1A652XSjHWcXCJy67uxNe2T73Zi/GJ5VCUJgmT0ANmhjuCcAkT
   2Wjl2f4BwVnftF6Yj/OgtyqAG7cVVRHkNKyVyATowkoMaXRaoy7I1DeeX
   9+VAhDQcyEzoWWxWVU3KthxXO5P/DPpYyutAg7Z7IL6fLY7hkLL/x9sen
   9KYd8Q85HcPvmzCwQSj6vwUL6hREoDwlepT7YwUsLd/AZ2iIuiHGe/gxK
   rt52f5sZyx43Wg8GONoZ8VPs2JMeidylEhlMw7+ImRWZgupbWc3kEnhox
   Q4l++tpC1WXPyTJPFg9vBIL+DN/b9ubmxe9tp+vlxdqA4A5PjGsqhAPv8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="384251680"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="384251680"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 06:39:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="747072743"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="747072743"
Received: from patinira-mobl.amr.corp.intel.com (HELO [10.212.128.216]) ([10.212.128.216])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 06:39:20 -0700
Message-ID: <f9e8de5e-56a6-4209-a78a-6997dac489a0@linux.intel.com>
Date: Tue, 10 Oct 2023 06:39:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] cpu/hotplug, x86/acpi: Disable CPU hotplug for ACPI
 MADT wakeup
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
 <20231005131402.14611-4-kirill.shutemov@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20231005131402.14611-4-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231010_063922_057652_4404AA9E 
X-CRM114-Status: GOOD (  22.04  )
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
> ACPI MADT doesn't allow to offline CPU after it got woke up.
> 

I think you can use the term "CPU hotplug" instead of just offline.

> Currently hotplug prevented based on the confidential computing
> attribute which is set for Intel TDX. But TDX is not the only possible
> user of the wake up method.
> 
> Mark CPU hotplug as "not supported" on ACPI MADT wakeup enumeration.

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/coco/core.c               |  1 -
>  arch/x86/kernel/acpi/madt_wakeup.c |  4 ++++
>  include/linux/cc_platform.h        | 10 ----------
>  kernel/cpu.c                       |  2 +-
>  4 files changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
> index eeec9986570e..f07c3bb7deab 100644
> --- a/arch/x86/coco/core.c
> +++ b/arch/x86/coco/core.c
> @@ -20,7 +20,6 @@ static bool noinstr intel_cc_platform_has(enum cc_attr attr)
>  {
>  	switch (attr) {
>  	case CC_ATTR_GUEST_UNROLL_STRING_IO:
> -	case CC_ATTR_HOTPLUG_DISABLED:
>  	case CC_ATTR_GUEST_MEM_ENCRYPT:
>  	case CC_ATTR_MEM_ENCRYPT:
>  		return true;
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
> index 1b9747bfd5b9..15bdf10b1393 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -1,4 +1,5 @@
>  #include <linux/acpi.h>
> +#include <linux/cpu.h>
>  #include <asm/apic.h>
>  
>  /* Physical address of the Multiprocessor Wakeup Structure mailbox */
> @@ -74,6 +75,9 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
>  
>  	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
>  
> +	/* Disable CPU onlining/offlining */
> +	cpu_hotplug_not_supported();
> +
>  	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
>  
>  	return 0;
> diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
> index cb0d6cd1c12f..d08dd65b5c43 100644
> --- a/include/linux/cc_platform.h
> +++ b/include/linux/cc_platform.h
> @@ -80,16 +80,6 @@ enum cc_attr {
>  	 * using AMD SEV-SNP features.
>  	 */
>  	CC_ATTR_GUEST_SEV_SNP,
> -
> -	/**
> -	 * @CC_ATTR_HOTPLUG_DISABLED: Hotplug is not supported or disabled.
> -	 *
> -	 * The platform/OS is running as a guest/virtual machine does not
> -	 * support CPU hotplug feature.
> -	 *
> -	 * Examples include TDX Guest.
> -	 */
> -	CC_ATTR_HOTPLUG_DISABLED,
>  };
>  
>  #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index cf536fe1a88a..9d4279476b40 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1522,7 +1522,7 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
>  	 * If the platform does not support hotplug, report it explicitly to
>  	 * differentiate it from a transient offlining failure.
>  	 */
> -	if (cc_platform_has(CC_ATTR_HOTPLUG_DISABLED) || !cpu_hotplug_supported)
> +	if (!cpu_hotplug_supported)
>  		return -EOPNOTSUPP;
>  	if (cpu_hotplug_disabled)
>  		return -EBUSY;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
