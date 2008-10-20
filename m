Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Krr9Y-0007AJ-Jp
	for kexec@lists.infradead.org; Mon, 20 Oct 2008 09:34:20 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id m9K9VAWG022028
	for <kexec@lists.infradead.org>; Mon, 20 Oct 2008 05:31:10 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9K9YI1F058914
	for <kexec@lists.infradead.org>; Mon, 20 Oct 2008 05:34:18 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9K9YHco003841
	for <kexec@lists.infradead.org>; Mon, 20 Oct 2008 05:34:17 -0400
Message-ID: <48FC5097.5090908@in.ibm.com>
Date: Mon, 20 Oct 2008 15:04:15 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] Support for relocatable kdump kernel
References: <18684.5062.154465.668614@drongo.ozlabs.ibm.com>
	<1224485038.9055.34.camel@localhost>
In-Reply-To: <1224485038.9055.34.camel@localhost>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: michael@ellerman.id.au
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, kexec <kexec@lists.infradead.org>

Michael Ellerman wrote:
>>> -------- Forwarded Message --------
>>> The purgatory code compares the signature and sets the __kdump_flag in
>>> head_64.S.  During the boot up, kernel code checks __kdump_flag and if it
>>> is set, the kernel will behave as relocatable kdump kernel. This kernel
>>> will boot at the address where it was loaded by kexec-tools ie at the
>>> address reserved through crashkernel boot parameter
>>>
>>> CONFIG_CRASH_DUMP depends on CONFIG_RELOCATABLE option to build kdump
>>> kernel as relocatable. So the same kernel can be used as production and
>>> kdump kernel.
> 
> Those two statements aren't really related. A CONFIG_RELOCATABLE kernel
> can be used as both a kdump and a normal kernel, and we need to make
> sure that a CONFIG_CRASH_DUMP kernel can be used as both - ie. that
> there's no code that uses CONFIG_CRASH_DUMP to do anything we /don't/
> want in a normal kernel.
> 
Hi Mike,

Thank you very much for the detailed review.

For 64 bit powerpc, we are going to support only relocatable kdump 
kernel (as per Paulus' suggestions). To enable CRASH_DUMP one needs 
CONFIG_RELOCATABLE to be enabled first.

>>>  #ifdef CONFIG_CRASH_DUMP
>>> +#ifdef CONFIG_RELOCATABLE
>>> +
>>> +static inline void reserve_kdump_trampoline(void) { ; }
>>> +static inline void setup_kdump_trampoline(void) { ; }
>>> +
>>> +#else
>>>  
>>>  extern void reserve_kdump_trampoline(void);
>>>  extern void setup_kdump_trampoline(void);
>>>  
>>> +#endif /* CONFIG_RELOCATABLE */
> 
> You've disabled the else case with your Kconfig changes, so you should
> just rip all that code out.

I made Kconfig changes only to the 64 bit powerpc path and still the 32 
bit powerpc code uses the legacy kdump code. So we need to retain some 
of legacy kdump code.

> 
>>>  static inline void reserve_kdump_trampoline(void) { ; }
>>> diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
>>> index a323c9b..eaf9d6d 100644
>>> --- a/arch/powerpc/kernel/crash_dump.c
>>> +++ b/arch/powerpc/kernel/crash_dump.c
>>> @@ -27,6 +27,7 @@
>>>  #define DBG(fmt...)
>>>  #endif
>>>  
>>> +#ifndef CONFIG_RELOCATABLE
>>>  void __init reserve_kdump_trampoline(void)
>>>  {
>>>  	lmb_reserve(0, KDUMP_RESERVE_LIMIT);
>>> @@ -65,6 +66,7 @@ void __init setup_kdump_trampoline(void)
>>>  
>>>  	DBG(" <- setup_kdump_trampoline()\n");
>>>  }
>>> +#endif /* CONFIG_RELOCATABLE */
>>>  
>>>  #ifdef CONFIG_PROC_VMCORE
>>>  static int __init parse_elfcorehdr(char *p)
>>> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
>>> index e409338..5b12b10 100644
>>> --- a/arch/powerpc/kernel/head_64.S
>>> +++ b/arch/powerpc/kernel/head_64.S
>>> @@ -97,6 +97,14 @@ __secondary_hold_spinloop:
>>>  __secondary_hold_acknowledge:
>>>  	.llong	0x0
>>>  
>>> +	/* This flag is set only for kdump kernels so that */
>>> +	/* it will be relocatable. Purgatory code user space kexec-tools */
>>> +	/* sets this flag. Do not move this variable as purgatory code */
>>> +	/* relies on the position of this variables */
>>> +	.globl	__kdump_flag
>>> +__kdump_flag:
>>> +	.llong	0x0
> 
> I guess the __ matches the other flags here, it's not the prettiest
> though. For client code (like in iommu.c) it'd be nice to have static
> inline, perhaps is_kdump_kernel() that hides this.
> 
Do you expect a function to do the checking in iommu.c?

>>>  #ifdef CONFIG_PPC_ISERIES
>>>  	/*
>>>  	 * At offset 0x20, there is a pointer to iSeries LPAR data.
>>> @@ -1384,8 +1392,13 @@ _STATIC(__after_prom_start)
>>>  	/* process relocations for the final address of the kernel */
>>>  	lis	r25,PAGE_OFFSET@highest	/* compute virtual base of kernel */
>>>  	sldi	r25,r25,32
>>> +#ifdef CONFIG_CRASH_DUMP
>>> +	ld	r7,__kdump_flag-_stext(r26)
>>> +	cmpldi	cr0,r7,1	/* relocatable kernel ? */
> 
> You don't use the signature here?

kexec-tools check the signature and based on the signature it sets 
__kdump_flag to 1 (or 0). So kernel code just checks whether its set or not.

> 
>>> +	bne	1f
>>>  	add	r25,r25,r26
>>> -	mr	r3,r25
>>> +#endif
>>> +1:	mr	r3,r25
>>>  	bl	.relocate
>>>  #endif
>>>  
>>> @@ -1401,9 +1414,21 @@ _STATIC(__after_prom_start)
>>>  	beq	9f			/* have already put us at zero */
>>>  	li	r6,0x100		/* Start offset, the first 0x100 */
>>>  					/* bytes were copied earlier.	 */
>>> -#ifdef CONFIG_RELOCATABLE
>>> +
>>> +#ifdef CONFIG_CRASH_DUMP
>>> +/*
>>> + * Check if the kernel has to be running as relocatable kernel based on the
>>> + * variable __kdump_flag, if it is set the kernel is treated as relocatble
>>> + * kernel, otherwise it will be moved to PHYSICAL_START
>>> + */
>>> +	ld	r7,__kdump_flag-_stext(r26)
>>> +	cmpldi	cr0,r7,1
>>> +	bne	regular
>>> +
>>>  	li	r5,__end_interrupts - _stext	/* just copy interrupts */
>>> -#else
>>> +	b	5f
>>> +regular:
>>> +#endif
>>>  	lis	r5,(copy_to_here - _stext)@ha
>>>  	addi	r5,r5,(copy_to_here - _stext)@l /* # bytes of memory to copy */
> 
> I'm jet lagged to hell, so I'm not sure I can trust my parsing of this.
> But I think this definitely breaks CONFIG_RELOCATABLE without
> CRASH_DUMP, and I'm not sure it's right otherwise.
>
Hmmm, I compiled and tried the kernel with 3 config option combinations: 
1. CONFIG_RELOCATABLE and CONFIG_CRASH_DUMP 2. CONFIG_RELOCATABLE 3. 
Without CONFIG_RELOCATABLE (without CONFIG_CRASH_DUMP)

All of the above 3 combinations worked. This patch relies on Pauls' 
patch5 in the relocatable kernel patcheset.

Regards,
Mohan.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
