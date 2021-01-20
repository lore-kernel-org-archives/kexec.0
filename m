Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l22co-00008z-Rp
 for kexec@lists.infradead.org; Wed, 20 Jan 2021 01:49:36 +0000
Subject: Re: [PATCH V3] MIPS: Loongson64: Add kexec/kdump support
References: <20201221120220.3186744-1-chenhuacai@kernel.org>
 <a671a323-768b-b461-2ce4-ecc1e92d4cc6@loongson.cn>
 <CAAhV-H4GDxhg1YqWy-g7VuCeE7BZ0ibaVSr1ibzJqXjuaBn3_w@mail.gmail.com>
 <20210107172620.GA13201@alpha.franken.de>
 <1085845b-2c5a-dbb6-62b7-28b55aeacb4c@loongson.cn>
 <20210119210821.GA15589@alpha.franken.de>
From: Jinyang He <hejinyang@loongson.cn>
Message-ID: <65453f03-4bfe-8458-7884-cdd6ecb3e83b@loongson.cn>
Date: Wed, 20 Jan 2021 09:49:19 +0800
MIME-Version: 1.0
In-Reply-To: <20210119210821.GA15589@alpha.franken.de>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Baoquan He <bhe@redhat.com>, Youling Tang <tangyouling@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, kexec@lists.infradead.org, "open list:MIPS" <linux-mips@vger.kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On 01/20/2021 05:08 AM, Thomas Bogendoerfer wrote:

> On Fri, Jan 08, 2021 at 06:07:39PM +0800, Jinyang He wrote:
>> Unlike the cavium-octeon platform, the Loongson64 platform needs some
>> changes. Before the kernel starts, (before entering the kernel_entry), each
>> CPU has its own state (the SMP system). For Loongson64, only the boot CPU
>> will enter the kernel_entry, and other CPUs will query their mailbox value
>> in a loop. This is what the BIOS does for the CPU. Here is different from
>> cavium-octeon. All CPUs will enter the kernel_entry on cavium-octeon
>> platform. Then the kernel_entry_setup, the co-CPUs will enter the query
>> loop. I saw the kernel_entry_setup of other platforms, such as ip27, malta,
>> and generic. They are not like cavium-octeon and the co-CPUs entering the
>> loop may be earlier than entering kernel_entry. So I have reason to guess
>> that most SMP system platform CPUs are similar to Loongson64.
>>
>> relocate_kernel.S is like BIOS doing s omething for the CPU. It allows the
>> boot CPU to start from the new kernel_entry and makes the co-CPUs enter a
>> loop. The already existing infrastructure may be more suitable for non-smp
>> platforms. Although we can do something with plat_smp_ops.kexec_nonboot_cpu,
>> more new problems will arise in that case. The kexec process actually runs
>> on a copy of relocate_kernel.S, which will bring a lot of problems...
>>
>> Above all just my personal thoughts.
> thank you for describing current state. So it looks like kexec and SMP
> is probably only working for Octeon and maybe some MIPS VPE based SMP
> systems, but not with "real" cores.
>
> How about the patch below as preparation for your loongson64 kexec patch ?
> You only need to put write a kexec_smp_wait_final macro and the rest of
> your patch stays the same...
>
> Thomas.

Thank you for this patch. By applying your patch and the revised Huacai's
patch, kexec works well on the Loongson-3A4000. I compared the assembly
code, too. It's the same as the previous patch doing. I think it's correct.
Huacai, how do you think about it?

Thanks, :-)
Jinyang
>
>  From 81d3e1e24a0dae48f310b8d819d625f88139ef9b Mon Sep 17 00:00:00 2001
> From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Date: Tue, 19 Jan 2021 21:58:55 +0100
> Subject: [PATCH] MIPS: Use macro for kexec_smp_wait specials
>
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>   .../include/asm/mach-cavium-octeon/kernel-entry-init.h   | 8 ++++++++
>   arch/mips/kernel/relocate_kernel.S                       | 9 ++++-----
>   2 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> index c38b38ce5a3d..b071a7353ee1 100644
> --- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> +++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> @@ -157,4 +157,12 @@
>   	.macro	smp_slave_setup
>   	.endm
>   
> +#define USE_KEXEC_SMP_WAIT_FINAL
> +	.macro  kexec_smp_wait_final
> +	.set push
> +	.set noreorder
> +	synci		0($0)
> +	.set pop
> +	.endm
> +
>   #endif /* __ASM_MACH_CAVIUM_OCTEON_KERNEL_ENTRY_H */
> diff --git a/arch/mips/kernel/relocate_kernel.S b/arch/mips/kernel/relocate_kernel.S
> index ac870893ba2d..f3c908abdbb8 100644
> --- a/arch/mips/kernel/relocate_kernel.S
> +++ b/arch/mips/kernel/relocate_kernel.S
> @@ -11,6 +11,8 @@
>   #include <asm/stackframe.h>
>   #include <asm/addrspace.h>
>   
> +#include <kernel-entry-init.h>
> +
>   LEAF(relocate_new_kernel)
>   	PTR_L a0,	arg0
>   	PTR_L a1,	arg1
> @@ -125,11 +127,8 @@ LEAF(kexec_smp_wait)
>   1:	LONG_L		s0, (t0)
>   	bne		s0, zero,1b
>   
> -#ifdef CONFIG_CPU_CAVIUM_OCTEON
> -	.set push
> -	.set noreorder
> -	synci		0($0)
> -	.set pop
> +#ifdef USE_KEXEC_SMP_WAIT_FINAL
> +	kexec_smp_wait_final
>   #else
>   	sync
>   #endif


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
