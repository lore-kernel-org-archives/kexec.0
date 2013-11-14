Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vguvn-0005Cx-Hy
 for kexec@lists.infradead.org; Thu, 14 Nov 2013 11:17:52 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id E9EEE3EE110
 for <kexec@lists.infradead.org>; Thu, 14 Nov 2013 20:17:25 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id DC36345DD77
 for <kexec@lists.infradead.org>; Thu, 14 Nov 2013 20:17:25 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.nic.fujitsu.com [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id C5E6945DD76
 for <kexec@lists.infradead.org>; Thu, 14 Nov 2013 20:17:25 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id B8EAEE08002
 for <kexec@lists.infradead.org>; Thu, 14 Nov 2013 20:17:25 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 6B4D6E08001
 for <kexec@lists.infradead.org>; Thu, 14 Nov 2013 20:17:25 +0900 (JST)
Message-ID: <5284B11C.3020103@jp.fujitsu.com>
Date: Thu, 14 Nov 2013 20:16:44 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v5 1/3] x86, apic: add bsp_physical_apicid
References: <20131112094952.4902.72689.stgit@localhost6.localdomain6>
 <20131112095153.4902.51290.stgit@localhost6.localdomain6>
In-Reply-To: <20131112095153.4902.51290.stgit@localhost6.localdomain6>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: hpa@linux.intel.com
Cc: jingbai.ma@hp.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, akpm@linux-foundation.org, fengguang.wu@intel.com, vgoyal@redhat.com

Hello HPA,

I have another question relevant to http://lkml.org/lkml/2013/11/12/311.

(2013/11/12 18:51), HATAYAMA Daisuke wrote:
<cut>
> @@ -2589,3 +2593,14 @@ static int __init lapic_insert_resource(void)
>    * that is using request_resource
>    */
>   late_initcall(lapic_insert_resource);
> +
> +void __init bsp_physical_apicid_init(void)
> +{
> +	u32 l, h;
> +
> +	if (boot_cpu_data.x86 >= 6 && cpu_has_apic) {
> +		rdmsr(MSR_IA32_APICBASE, l, h);
> +		if (!(l & MSR_IA32_APICBASE_BSP))
> +			bsp_physical_apicid = boot_cpu_data.initial_apicid;
> +	}
> +}

So, rigrously, we should not use rdmsr for MSR_IA32_APICBASE here since this can
return wrong value on some clustered system?

At least all the mpparse.c, amdtopology.c and visws_quirks.c has referred to
MP table only, so there's no issue by simply dropping this code.

> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 2793d1f..28bea2c 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -681,7 +681,7 @@ static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
>  /*
>   * Do minimum CPU detection early.
>   * Fields really needed: vendor, cpuid_level, family, model, mask,
> - * cache alignment.
> + * cache alignment, initial_apicid.
>   * The others are not touched to avoid unwanted side effects.
>   *
>   * WARNING: this function is only called on the BP.  Don't add code here
> @@ -725,6 +725,9 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
>  		this_cpu->c_bsp_init(c);
>
>  	setup_force_cpu_cap(X86_FEATURE_ALWAYS);
> +
> +	if (c->cpuid_level >= 0x00000001)
> +		c->initial_apicid = (cpuid_ebx(1) >> 24) & 0xFF;
>  }

Can the initial APID IDs obtained in this way using cpuid duplicate on some
clustered system?

Can we consider each apic->get_apic_id() method return *initial* APIC ID?
According to 8.4 Multiple-Processor (MP) Initialization, Intel System Programming
Guide, the APID IDs written into MADT and MP table are the initial ones.
So, APID IDs to be compared with these must be the initial ones.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
