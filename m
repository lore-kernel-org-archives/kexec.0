Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxogT-0003u1-Az
 for kexec@lists.infradead.org; Fri, 08 Jan 2021 10:07:54 +0000
From: Jinyang He <hejinyang@loongson.cn>
Subject: Re: [PATCH V3] MIPS: Loongson64: Add kexec/kdump support
References: <20201221120220.3186744-1-chenhuacai@kernel.org>
 <a671a323-768b-b461-2ce4-ecc1e92d4cc6@loongson.cn>
 <CAAhV-H4GDxhg1YqWy-g7VuCeE7BZ0ibaVSr1ibzJqXjuaBn3_w@mail.gmail.com>
 <20210107172620.GA13201@alpha.franken.de>
Message-ID: <1085845b-2c5a-dbb6-62b7-28b55aeacb4c@loongson.cn>
Date: Fri, 8 Jan 2021 18:07:39 +0800
MIME-Version: 1.0
In-Reply-To: <20210107172620.GA13201@alpha.franken.de>
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
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Huacai Chen <chenhuacai@kernel.org>
Cc: Baoquan He <bhe@redhat.com>, Youling Tang <tangyouling@loongson.cn>, kexec@lists.infradead.org, "open list:MIPS" <linux-mips@vger.kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

Hi, Thomas,

On 01/08/2021 01:26 AM, Thomas Bogendoerfer wrote:
>>>> --- a/arch/mips/kernel/relocate_kernel.S
>>>> +++ b/arch/mips/kernel/relocate_kernel.S
>>>> @@ -6,6 +6,7 @@
>>>>
>>>>    #include <asm/asm.h>
>>>>    #include <asm/asmmacro.h>
>>>> +#include <asm/cpu.h>
>>>>    #include <asm/regdef.h>
>>>>    #include <asm/mipsregs.h>
>>>>    #include <asm/stackframe.h>
>>>> @@ -133,6 +134,33 @@ LEAF(kexec_smp_wait)
>>>>    #else
>>>>        sync
>>>>    #endif
>>>> +
>>>> +#ifdef CONFIG_CPU_LOONGSON64
> Is there a reason why you can't use the already existing infrastructure
> the way cavium-octeon is doing it ? If you can't please explain why
> so we can find a way to extend it. But having some sort of poking
> loongson registers in generic MIPS code is a non starter.
>
> Thomas.
>

Unlike the cavium-octeon platform, the Loongson64 platform needs some 
changes. Before the kernel starts, (before entering the kernel_entry), 
each CPU has its own state (the SMP system). For Loongson64, only the 
boot CPU will enter the kernel_entry, and other CPUs will query their 
mailbox value in a loop. This is what the BIOS does for the CPU. Here is 
different from cavium-octeon. All CPUs will enter the kernel_entry on 
cavium-octeon platform. Then the kernel_entry_setup, the co-CPUs will 
enter the query loop. I saw the kernel_entry_setup of other platforms, 
such as ip27, malta, and generic. They are not like cavium-octeon and 
the co-CPUs entering the loop may be earlier than entering kernel_entry. 
So I have reason to guess that most SMP system platform CPUs are similar 
to Loongson64.

relocate_kernel.S is like BIOS doing s omething for the CPU. It allows 
the boot CPU to start from the new kernel_entry and makes the co-CPUs 
enter a loop. The already existing infrastructure may be more suitable 
for non-smp platforms. Although we can do something with 
plat_smp_ops.kexec_nonboot_cpu, more new problems will arise in that 
case. The kexec process actually runs on a copy of relocate_kernel.S, 
which will bring a lot of problems...

Above all just my personal thoughts.

Thanks,
Jinyang


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
