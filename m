Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VWA3L-00022v-Cu
 for kexec@lists.infradead.org; Tue, 15 Oct 2013 19:13:12 +0000
Date: Tue, 15 Oct 2013 15:12:17 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 1/2] x86, apic: Add boot_cpu_is_bsp() to check if boot
 cpu is BSP
Message-ID: <20131015191217.GN31215@redhat.com>
References: <20131015054214.13666.11737.stgit@localhost6.localdomain6>
 <20131015054322.13666.31465.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131015054322.13666.31465.stgit@localhost6.localdomain6>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: fengguang.wu@intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, akpm@linux-foundation.org, hpa@linux.intel.com, jingbai.ma@hp.com

On Tue, Oct 15, 2013 at 02:43:22PM +0900, HATAYAMA Daisuke wrote:
> Kexec can enter the kdump 2nd kernel on AP if crash happens on AP. To
> check if boot cpu is BSP, introduce a helper function
> boot_cpu_is_bsp().
> 
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> ---
>  arch/x86/include/asm/mpspec.h |    7 +++++++
>  arch/x86/kernel/apic/apic.c   |   16 ++++++++++++++++
>  arch/x86/kernel/setup.c       |    2 ++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
> index 626cf70..54d5f98 100644
> --- a/arch/x86/include/asm/mpspec.h
> +++ b/arch/x86/include/asm/mpspec.h
> @@ -47,11 +47,18 @@ extern int mp_bus_id_to_type[MAX_MP_BUSSES];
>  extern DECLARE_BITMAP(mp_bus_not_pci, MAX_MP_BUSSES);
>  
>  extern unsigned int boot_cpu_physical_apicid;
> +extern bool boot_cpu_is_bsp;
>  extern unsigned int max_physical_apicid;
>  extern int mpc_default_type;
>  extern unsigned long mp_lapic_addr;
>  
>  #ifdef CONFIG_X86_LOCAL_APIC
> +extern void boot_cpu_is_bsp_init(void);
> +#else
> +static inline void boot_cpu_is_bsp_init(void) { };
> +#endif
> +
> +#ifdef CONFIG_X86_LOCAL_APIC
>  extern int smp_found_config;
>  #else
>  # define smp_found_config 0
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index a7eb82d..62ee365 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -64,6 +64,12 @@ unsigned disabled_cpus;
>  unsigned int boot_cpu_physical_apicid = -1U;
>  
>  /*

[..]
> + * Indicates whether the processor that is doing the boot up, is BSP
> + * processor or not.
> + */
> +bool boot_cpu_is_bsp;

Should we set it to true by default? I think in most of the cases boot cpu
is going to be bsp too?

> +
> +/*
>   * The highest APIC ID seen during enumeration.
>   */
>  unsigned int max_physical_apicid;
> @@ -2589,3 +2595,13 @@ static int __init lapic_insert_resource(void)
>   * that is using request_resource
>   */
>  late_initcall(lapic_insert_resource);
> +
> +void __init boot_cpu_is_bsp_init(void)
> +{
> +	if (cpu_has_apic) {
> +		u32 l, h;
> +
> +		rdmsr_safe(MSR_IA32_APICBASE, &l, &h);
> +		boot_cpu_is_bsp = (l & MSR_IA32_APICBASE_BSP) ? true : false;

I came across following thread.

https://lkml.org/lkml/2012/4/18/370

Can we hit above read msr on old P5 class machines? Or is it safe to
call unconditionally.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
