Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h4RFk-0002iH-VV
 for kexec@lists.infradead.org; Thu, 14 Mar 2019 14:22:38 +0000
Received: by mail-pg1-f193.google.com with SMTP id k11so4075004pgb.8
 for <kexec@lists.infradead.org>; Thu, 14 Mar 2019 07:22:36 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS'
 to vmcoreinfo
References: <1552212242-9479-1-git-send-email-bhsharma@redhat.com>
 <1552212242-9479-3-git-send-email-bhsharma@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03569E6D@BPXM09GP.gisp.nec.co.jp>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <6dac3aec-3f18-de67-f620-aed063986a17@redhat.com>
Date: Thu, 14 Mar 2019 19:52:27 +0530
MIME-Version: 1.0
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC03569E6D@BPXM09GP.gisp.nec.co.jp>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, James Morse <james.morse@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Boris Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Dave Anderson <anderson@redhat.com>, Ingo Molnar <mingo@kernel.org>, Paul Mackerras <paulus@samba.org>

Hi Kazu,

On 03/13/2019 01:17 AM, Kazuhito Hagio wrote:
> Hi Bhupesh,
> 
> -----Original Message-----
>> Right now user-space tools like 'makedumpfile' and 'crash' need to rely
>> on a best-guess method of determining value of 'MAX_PHYSMEM_BITS'
>> supported by underlying kernel.
>>
>> This value is used in user-space code to calculate the bit-space
>> required to store a section for SPARESMEM (similar to the existing
>> calculation method used in the kernel implementation):
>>
>>    #define SECTIONS_SHIFT    (MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)
>>
>> Now, regressions have been reported in user-space utilities
>> like 'makedumpfile' and 'crash' on arm64, with the recently added
>> kernel support for 52-bit physical address space, as there is
>> no clear method of determining this value in user-space
>> (other than reading kernel CONFIG flags).
>>
>> As per suggestion from makedumpfile maintainer (Kazu), it makes more
>> sense to append 'MAX_PHYSMEM_BITS' to vmcoreinfo in the core code itself
>> rather than in arch-specific code, so that the user-space code for other
>> archs can also benefit from this addition to the vmcoreinfo and use it
>> as a standard way of determining 'SECTIONS_SHIFT' value in user-land.
>>
>> A reference 'makedumpfile' implementation which reads the
>> 'MAX_PHYSMEM_BITS' value from vmcoreinfo in a arch-independent fashion
>> is available here:
>>
>> [0]. https://github.com/bhupesh-sharma/makedumpfile/blob/remove-max-phys-mem-bit-v1/arch/ppc64.c#L471
>>
>> Cc: Boris Petkov <bp@alien8.de>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Dave Anderson <anderson@redhat.com>
>> Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
>> Cc: x86@kernel.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: kexec@lists.infradead.org
>> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
>> ---
>>   kernel/crash_core.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 093c9f917ed0..44b90368e183 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -467,6 +467,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>>   #define PAGE_OFFLINE_MAPCOUNT_VALUE	(~PG_offline)
>>   	VMCOREINFO_NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE);
>>   #endif
>> +	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
> 
> Some architectures define MAX_PHYSMEM_BITS only with CONFIG_SPARSEMEM,
> so we need to move this to the #ifdef section that exports some
> mem_section things.
> 
> Thanks!
> Kazu

Sorry for the late response, I wanted to make sure I check almost all  
archs to understand if a proposal would work for all.

As per my current understanding, we can protect the export of  
'MAX_PHYSMEM_BITS' via a #ifdef section against CONFIG_SPARSEMEM, and it  
should work for all archs. Here are some arguments to support the same,  
would request maintainers of various archs (in Cc) to correct me if I am  
missing something here:

1. SPARSEMEM is dependent upon on (!SELECT_MEMORY_MODEL &&  
ARCH_SPARSEMEM_ENABLE) || SPARSEMEM_MANUAL:

config SPARSEMEM
	def_bool y
	depends on (!SELECT_MEMORY_MODEL && ARCH_SPARSEMEM_ENABLE) ||  
SPARSEMEM_MANUAL

2. For a couple of archs, this option is already turned on by default in  
their respective defconfigs:

$ grep -nrw "CONFIG_SPARSEMEM_MANUAL" *
arch/ia64/configs/gensparse_defconfig:18:CONFIG_SPARSEMEM_MANUAL=y
arch/powerpc/configs/ppc64e_defconfig:30:CONFIG_SPARSEMEM_MANUAL=y

3. Note that other archs use ARCH_SPARSEMEM_DEFAULT to define if  
CONFIG_SPARSEMEM_MANUAL is set by default:

choice
	prompt "Memory model"
         ..
	default SPARSEMEM_MANUAL if ARCH_SPARSEMEM_DEFAULT

3a.

$ grep -nrw -A 2 "ARCH_SPARSEMEM_DEFAULT" *
arch/s390/Kconfig:621:config ARCH_SPARSEMEM_DEFAULT
arch/s390/Kconfig-622-	def_bool y
--
arch/x86/Kconfig:1623:config ARCH_SPARSEMEM_DEFAULT
arch/x86/Kconfig-1624-	def_bool y
arch/x86/Kconfig-1625-	depends on X86_64
--
arch/powerpc/Kconfig:614:config ARCH_SPARSEMEM_DEFAULT
arch/powerpc/Kconfig-615-	def_bool y
arch/powerpc/Kconfig-616-	depends on PPC_BOOK3S_64
--
arch/arm64/Kconfig:850:config ARCH_SPARSEMEM_DEFAULT
arch/arm64/Kconfig-851-	def_bool ARCH_SPARSEMEM_ENABLE
--
arch/sh/mm/Kconfig:138:config ARCH_SPARSEMEM_DEFAULT
arch/sh/mm/Kconfig-139-	def_bool y
--
arch/sparc/Kconfig:315:config ARCH_SPARSEMEM_DEFAULT
arch/sparc/Kconfig-316-	def_bool y if SPARC64
--
arch/arm/Kconfig:1591:config ARCH_SPARSEMEM_DEFAULT
arch/arm/Kconfig-1592-	def_bool ARCH_SPARSEMEM_ENABLE

Since most archs (except MIPS) set  
CONFIG_ARCH_SPARSEMEM_DEFAULT/CONFIG_ARCH_SPARSEMEM_ENABLE to y in the  
default configurations, so even though they don't protect  
'MAX_PHYSMEM_BITS' define in CONFIG_SPARSEMEM ifdef sections, we still  
would be ok protecting the 'MAX_PHYSMEM_BITS' vmcoreinfo export inside a  
CONFIG_SPARSEMEM ifdef section.

Thanks for your inputs, I will include this change in the v3.

Regards,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
