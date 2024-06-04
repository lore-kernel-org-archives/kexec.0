Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFB3C25B78
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 20:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EFwnj2OkMXedKdJH3F0SpT/PogoaUI7fuMosV+fmvAA=; b=yfcG7z5Mz8XNYd
	b6HEehmamf+CMTHHsb8yXpNoOSA2wI1rk0XNeAH/1zegNQBOxvJxlfBBlXn7JxVNHK60nXwELvcmh
	DOhHIrINz5YAfaz0f6ssB4RbcaKh1Yh2qADIFQS711IMVvIwILJEUhlojJ13qvycNseLbni9hKJsk
	cpCi4QYeHrogElwTNKBB/eDnL1uENrIwdO+bdr0t7NhxuOptd5aJzLUthEGAv2EuyuvUWNBFRrCxZ
	4AY4/08onDhw43JUzojIX/Z6Jl2fwEbOsI3vD5zqIncNUBpqSWZsXQpSw9NI2I1hTYa4fKiHn/R3o
	LRkuTOqsKXjpou5VrLEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEaPk-00000003gDz-3no5;
	Tue, 04 Jun 2024 20:05:48 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEaPh-00000003gCx-1Qxv
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 20:05:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4881ECE114D;
	Tue,  4 Jun 2024 20:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2A3C2BBFC;
	Tue,  4 Jun 2024 20:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717531542;
	bh=QLqs9WHSOcHHhkgiaiakjAA0F6yNAaoAq+qiyxzHWdI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=MJGAjhvB+Xghx5Zt1mN7lrbKgKYJzpdLiUP3UIYJTEVSzjDezPhUgxLfWeM+XSlxy
	 d7xQl557WklPewcEGbPNvc68StJMzAdeLB89n0HTzoaPD+GB/rb+s5orzTYSRNvGX1
	 yYcNKwEAATao/C0+n7oqXcoW3CWefkgZPjiljdFbdpaeTqy7jwriWyqJaMRbMTgDm7
	 KRWPAr66+yOe8gDXKFHlz/pBlEKCQ6zUDpaPeKCi3mxboYTq03gu77u9XALv//oi4T
	 e5ceTYkB2tAVYKVDc+Nr2tmfgufFvl0B1pSoRxoLagUhZ6UswqK5DT2uCJG+eY7vFR
	 yVdi8y//tvCKg==
Mime-Version: 1.0
Date: Tue, 04 Jun 2024 23:05:34 +0300
Message-Id: <D1RI46IG5GSA.17H7M0DIQGRQ0@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 10/19] x86: Secure Launch SMP bringup support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-11-ross.philipson@oracle.com>
In-Reply-To: <20240531010331.134441-11-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_130545_748322_08DD383C 
X-CRM114-Status: GOOD (  34.69  )
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

On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> On Intel, the APs are left in a well documented state after TXT performs
> the late launch. Specifically they cannot have #INIT asserted on them so
> a standard startup via INIT/SIPI/SIPI cannot be performed. Instead the
> early SL stub code uses MONITOR and MWAIT to park the APs. The realmode/init.c
> code updates the jump address for the waiting APs with the location of the
> Secure Launch entry point in the RM piggy after it is loaded and fixed up.
> As the APs are woken up by writing the monitor, the APs jump to the Secure
> Launch entry point in the RM piggy which mimics what the real mode code would
> do then jumps to the standard RM piggy protected mode entry point.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/include/asm/realmode.h      |  3 ++
>  arch/x86/kernel/smpboot.c            | 58 +++++++++++++++++++++++++++-
>  arch/x86/realmode/init.c             |  3 ++
>  arch/x86/realmode/rm/header.S        |  3 ++
>  arch/x86/realmode/rm/trampoline_64.S | 32 +++++++++++++++
>  5 files changed, 97 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
> index 87e5482acd0d..339b48e2543d 100644
> --- a/arch/x86/include/asm/realmode.h
> +++ b/arch/x86/include/asm/realmode.h
> @@ -38,6 +38,9 @@ struct real_mode_header {
>  #ifdef CONFIG_X86_64
>  	u32	machine_real_restart_seg;
>  #endif
> +#ifdef CONFIG_SECURE_LAUNCH
> +	u32	sl_trampoline_start32;
> +#endif
>  };
>  
>  /* This must match data at realmode/rm/trampoline_{32,64}.S */
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 0c35207320cb..adb521221d6c 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -60,6 +60,7 @@
>  #include <linux/stackprotector.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/mc146818rtc.h>
> +#include <linux/slaunch.h>
>  
>  #include <asm/acpi.h>
>  #include <asm/cacheinfo.h>
> @@ -868,6 +869,56 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_SECURE_LAUNCH
> +
> +static bool slaunch_is_txt_launch(void)
> +{
> +	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) ==
> +	    (SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT))
> +		return true;
> +
> +	return false;
> +}

static inline bool slaunch_is_txt_launch(void)
{
	u32 mask =  SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT;

	return slaunch_get_flags() & mask == mask;
}


> +
> +/*
> + * TXT AP startup is quite different than normal. The APs cannot have #INIT
> + * asserted on them or receive SIPIs. The early Secure Launch code has parked
> + * the APs using monitor/mwait. This will wake the APs by writing the monitor
> + * and have them jump to the protected mode code in the rmpiggy where the rest
> + * of the SMP boot of the AP will proceed normally.
> + */
> +static void slaunch_wakeup_cpu_from_txt(int cpu, int apicid)
> +{
> +	struct sl_ap_wake_info *ap_wake_info;
> +	struct sl_ap_stack_and_monitor *stack_monitor = NULL;

struct sl_ap_stack_and_monitor *stack_monitor; /* note: no initialization */
struct sl_ap_wake_info *ap_wake_info;


> +
> +	ap_wake_info = slaunch_get_ap_wake_info();
> +
> +	stack_monitor = (struct sl_ap_stack_and_monitor *)__va(ap_wake_info->ap_wake_block +
> +							       ap_wake_info->ap_stacks_offset);
> +
> +	for (unsigned int i = TXT_MAX_CPUS - 1; i >= 0; i--) {
> +		if (stack_monitor[i].apicid == apicid) {
> +			/* Write the monitor */

I'd remove this comment.

> +			stack_monitor[i].monitor = 1;
> +			break;
> +		}
> +	}
> +}
> +
> +#else
> +
> +static inline bool slaunch_is_txt_launch(void)
> +{
> +	return false;
> +}
> +
> +static inline void slaunch_wakeup_cpu_from_txt(int cpu, int apicid)
> +{
> +}
> +
> +#endif  /* !CONFIG_SECURE_LAUNCH */
> +
>  /*
>   * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
>   * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
> @@ -877,7 +928,7 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
>  static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
>  {
>  	unsigned long start_ip = real_mode_header->trampoline_start;
> -	int ret;
> +	int ret = 0;
>  
>  #ifdef CONFIG_X86_64
>  	/* If 64-bit wakeup method exists, use the 64-bit mode trampoline IP */
> @@ -922,12 +973,15 @@ static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
>  
>  	/*
>  	 * Wake up a CPU in difference cases:
> +	 * - Intel TXT DRTM launch uses its own method to wake the APs
>  	 * - Use a method from the APIC driver if one defined, with wakeup
>  	 *   straight to 64-bit mode preferred over wakeup to RM.
>  	 * Otherwise,
>  	 * - Use an INIT boot APIC message
>  	 */
> -	if (apic->wakeup_secondary_cpu_64)
> +	if (slaunch_is_txt_launch())
> +		slaunch_wakeup_cpu_from_txt(cpu, apicid);
> +	else if (apic->wakeup_secondary_cpu_64)
>  		ret = apic->wakeup_secondary_cpu_64(apicid, start_ip);
>  	else if (apic->wakeup_secondary_cpu)
>  		ret = apic->wakeup_secondary_cpu(apicid, start_ip);
> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> index f9bc444a3064..d95776cb30d3 100644
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -4,6 +4,7 @@
>  #include <linux/memblock.h>
>  #include <linux/cc_platform.h>
>  #include <linux/pgtable.h>
> +#include <linux/slaunch.h>
>  
>  #include <asm/set_memory.h>
>  #include <asm/realmode.h>
> @@ -210,6 +211,8 @@ void __init init_real_mode(void)
>  
>  	setup_real_mode();
>  	set_real_mode_permissions();
> +
> +	slaunch_fixup_jump_vector();
>  }
>  
>  static int __init do_init_real_mode(void)
> diff --git a/arch/x86/realmode/rm/header.S b/arch/x86/realmode/rm/header.S
> index 2eb62be6d256..3b5cbcbbfc90 100644
> --- a/arch/x86/realmode/rm/header.S
> +++ b/arch/x86/realmode/rm/header.S
> @@ -37,6 +37,9 @@ SYM_DATA_START(real_mode_header)
>  #ifdef CONFIG_X86_64
>  	.long	__KERNEL32_CS
>  #endif
> +#ifdef CONFIG_SECURE_LAUNCH
> +	.long	pa_sl_trampoline_start32
> +#endif
>  SYM_DATA_END(real_mode_header)
>  
>  	/* End signature, used to verify integrity */
> diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
> index 14d9c7daf90f..b0ce6205d7ea 100644
> --- a/arch/x86/realmode/rm/trampoline_64.S
> +++ b/arch/x86/realmode/rm/trampoline_64.S
> @@ -122,6 +122,38 @@ SYM_CODE_END(sev_es_trampoline_start)
>  
>  	.section ".text32","ax"
>  	.code32
> +#ifdef CONFIG_SECURE_LAUNCH
> +	.balign 4
> +SYM_CODE_START(sl_trampoline_start32)
> +	/*
> +	 * The early secure launch stub AP wakeup code has taken care of all
> +	 * the vagaries of launching out of TXT. This bit just mimics what the
> +	 * 16b entry code does and jumps off to the real startup_32.
> +	 */
> +	cli
> +	wbinvd
> +
> +	/*
> +	 * The %ebx provided is not terribly useful since it is the physical
> +	 * address of tb_trampoline_start and not the base of the image.
> +	 * Use pa_real_mode_base, which is fixed up, to get a run time
> +	 * base register to use for offsets to location that do not have
> +	 * pa_ symbols.
> +	 */
> +	movl    $pa_real_mode_base, %ebx
> +
> +	LOCK_AND_LOAD_REALMODE_ESP lock_pa=1
> +
> +	lgdt    tr_gdt(%ebx)
> +	lidt    tr_idt(%ebx)
> +
> +	movw	$__KERNEL_DS, %dx	# Data segment descriptor
> +
> +	/* Jump to where the 16b code would have jumped */
> +	ljmpl	$__KERNEL32_CS, $pa_startup_32
> +SYM_CODE_END(sl_trampoline_start32)
> +#endif
> +
>  	.balign 4
>  SYM_CODE_START(startup_32)
>  	movl	%edx, %ss

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
