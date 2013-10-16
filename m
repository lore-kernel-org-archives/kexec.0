Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VWFOT-0002li-Qy
 for kexec@lists.infradead.org; Wed, 16 Oct 2013 00:55:23 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 7C6C13EE0BB
 for <kexec@lists.infradead.org>; Wed, 16 Oct 2013 09:54:52 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 6CD9B45DE6A
 for <kexec@lists.infradead.org>; Wed, 16 Oct 2013 09:54:52 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 45A5A45DE5A
 for <kexec@lists.infradead.org>; Wed, 16 Oct 2013 09:54:52 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 38717E08004
 for <kexec@lists.infradead.org>; Wed, 16 Oct 2013 09:54:52 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id D10F31DB8048
 for <kexec@lists.infradead.org>; Wed, 16 Oct 2013 09:54:51 +0900 (JST)
Message-ID: <525DE35A.7040205@jp.fujitsu.com>
Date: Wed, 16 Oct 2013 09:52:42 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] x86, apic: Add boot_cpu_is_bsp() to check if boot
 cpu is BSP
References: <20131015054214.13666.11737.stgit@localhost6.localdomain6>
 <20131015054322.13666.31465.stgit@localhost6.localdomain6>
 <20131015191217.GN31215@redhat.com>
In-Reply-To: <20131015191217.GN31215@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: fengguang.wu@intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, akpm@linux-foundation.org, hpa@linux.intel.com, jingbai.ma@hp.com

(2013/10/16 4:12), Vivek Goyal wrote:
> On Tue, Oct 15, 2013 at 02:43:22PM +0900, HATAYAMA Daisuke wrote:
>> Kexec can enter the kdump 2nd kernel on AP if crash happens on AP. To
>> check if boot cpu is BSP, introduce a helper function
>> boot_cpu_is_bsp().
>>
>> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
>> ---
>>   arch/x86/include/asm/mpspec.h |    7 +++++++
>>   arch/x86/kernel/apic/apic.c   |   16 ++++++++++++++++
>>   arch/x86/kernel/setup.c       |    2 ++
>>   3 files changed, 25 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
>> index 626cf70..54d5f98 100644
>> --- a/arch/x86/include/asm/mpspec.h
>> +++ b/arch/x86/include/asm/mpspec.h
>> @@ -47,11 +47,18 @@ extern int mp_bus_id_to_type[MAX_MP_BUSSES];
>>   extern DECLARE_BITMAP(mp_bus_not_pci, MAX_MP_BUSSES);
>>
>>   extern unsigned int boot_cpu_physical_apicid;
>> +extern bool boot_cpu_is_bsp;
>>   extern unsigned int max_physical_apicid;
>>   extern int mpc_default_type;
>>   extern unsigned long mp_lapic_addr;
>>
>>   #ifdef CONFIG_X86_LOCAL_APIC
>> +extern void boot_cpu_is_bsp_init(void);
>> +#else
>> +static inline void boot_cpu_is_bsp_init(void) { };
>> +#endif
>> +
>> +#ifdef CONFIG_X86_LOCAL_APIC
>>   extern int smp_found_config;
>>   #else
>>   # define smp_found_config 0
>> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
>> index a7eb82d..62ee365 100644
>> --- a/arch/x86/kernel/apic/apic.c
>> +++ b/arch/x86/kernel/apic/apic.c
>> @@ -64,6 +64,12 @@ unsigned disabled_cpus;
>>   unsigned int boot_cpu_physical_apicid = -1U;
>>
>>   /*
>
> [..]
>> + * Indicates whether the processor that is doing the boot up, is BSP
>> + * processor or not.
>> + */
>> +bool boot_cpu_is_bsp;
>
> Should we set it to true by default? I think in most of the cases boot cpu
> is going to be bsp too?
>

Agreed. Most likely value should be default.

The reason why I wrote so would be that -- if there's reason -- I wanted to
write it uniform to other variables around it and wanted to avoid to let it
have static storage in binary file.

>> +
>> +/*
>>    * The highest APIC ID seen during enumeration.
>>    */
>>   unsigned int max_physical_apicid;
>> @@ -2589,3 +2595,13 @@ static int __init lapic_insert_resource(void)
>>    * that is using request_resource
>>    */
>>   late_initcall(lapic_insert_resource);
>> +
>> +void __init boot_cpu_is_bsp_init(void)
>> +{
>> +	if (cpu_has_apic) {
>> +		u32 l, h;
>> +
>> +		rdmsr_safe(MSR_IA32_APICBASE, &l, &h);
>> +		boot_cpu_is_bsp = (l & MSR_IA32_APICBASE_BSP) ? true : false;
>
> I came across following thread.
>
> https://lkml.org/lkml/2012/4/18/370
>
> Can we hit above read msr on old P5 class machines? Or is it safe to
> call unconditionally.
>

No, it's dangerous to cause #UD, and current implementation doesn't check
exception value returned by rdmsr_safe. It's meaningless to call rdmsr_safe.

At least, checking boot_cpu_data.x86 >= 6 satisfies support of IA32_APIC_BASE
MSR and this at the same time satisfies support of rdmsr instruction since the
instruction was introduced at Pentium processor. So,

if (boot_cpu_data.x86 >= 6 && cpu_has_apic()) {
     u32 l, h;

     rdmsr(MSR_IA32_APICBASE, &l, &h);
     boot_cpu_is_bsp = (l & MSR_IA32_APICBASE_BSP) ? true : false;  
}

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
