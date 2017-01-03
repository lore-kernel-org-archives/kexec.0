Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cOYTI-0000Zh-AN
 for kexec@lists.infradead.org; Tue, 03 Jan 2017 23:26:27 +0000
Received: by mail-qk0-f171.google.com with SMTP id t184so391425516qkd.0
 for <kexec@lists.infradead.org>; Tue, 03 Jan 2017 15:26:04 -0800 (PST)
Subject: Re: [PATCHv6 00/11] CONFIG_DEBUG_VIRTUAL for arm64
References: <1483464113-1587-1-git-send-email-labbott@redhat.com>
 <edc8eaa2-5414-506c-1dad-f2404ef19c81@gmail.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <b3de65da-8a74-2510-268e-34516cc2de77@redhat.com>
Date: Tue, 3 Jan 2017 15:25:53 -0800
MIME-Version: 1.0
In-Reply-To: <edc8eaa2-5414-506c-1dad-f2404ef19c81@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Florian Fainelli <f.fainelli@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, x86@kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org, Andrey Ryabinin <aryabinin@virtuozzo.com>, David Vrabel <david.vrabel@citrix.com>, Kees Cook <keescook@chromium.org>, Marc Zyngier <marc.zyngier@arm.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Christoffer Dall <christoffer.dall@linaro.org>

On 01/03/2017 02:56 PM, Florian Fainelli wrote:
> On 01/03/2017 09:21 AM, Laura Abbott wrote:
>> Happy New Year!
>>
>> This is a very minor rebase from v5. It only moves a few headers around.
>> I think this series should be ready to be queued up for 4.11.
> 
> FWIW:
> 
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> 

Thanks!

> How do we get this series included? I would like to get the ARM 32-bit
> counterpart included as well (will resubmit rebased shortly), but I have
> no clue which tree this should be going through.
> 

I was assuming this would go through the arm64 tree unless Catalin/Will
have an objection to that.

> Thanks!
> 
>>
>> Thanks,
>> Laura
>>
>> Laura Abbott (11):
>>   lib/Kconfig.debug: Add ARCH_HAS_DEBUG_VIRTUAL
>>   mm/cma: Cleanup highmem check
>>   arm64: Move some macros under #ifndef __ASSEMBLY__
>>   arm64: Add cast for virt_to_pfn
>>   mm: Introduce lm_alias
>>   arm64: Use __pa_symbol for kernel symbols
>>   drivers: firmware: psci: Use __pa_symbol for kernel symbol
>>   kexec: Switch to __pa_symbol
>>   mm/kasan: Switch to using __pa_symbol and lm_alias
>>   mm/usercopy: Switch to using lm_alias
>>   arm64: Add support for CONFIG_DEBUG_VIRTUAL
>>
>>  arch/arm64/Kconfig                        |  1 +
>>  arch/arm64/include/asm/kvm_mmu.h          |  4 +-
>>  arch/arm64/include/asm/memory.h           | 66 +++++++++++++++++++++----------
>>  arch/arm64/include/asm/mmu_context.h      |  6 +--
>>  arch/arm64/include/asm/pgtable.h          |  2 +-
>>  arch/arm64/kernel/acpi_parking_protocol.c |  3 +-
>>  arch/arm64/kernel/cpu-reset.h             |  2 +-
>>  arch/arm64/kernel/cpufeature.c            |  3 +-
>>  arch/arm64/kernel/hibernate.c             | 20 +++-------
>>  arch/arm64/kernel/insn.c                  |  2 +-
>>  arch/arm64/kernel/psci.c                  |  3 +-
>>  arch/arm64/kernel/setup.c                 |  9 +++--
>>  arch/arm64/kernel/smp_spin_table.c        |  3 +-
>>  arch/arm64/kernel/vdso.c                  |  8 +++-
>>  arch/arm64/mm/Makefile                    |  2 +
>>  arch/arm64/mm/init.c                      | 12 +++---
>>  arch/arm64/mm/kasan_init.c                | 22 +++++++----
>>  arch/arm64/mm/mmu.c                       | 33 ++++++++++------
>>  arch/arm64/mm/physaddr.c                  | 30 ++++++++++++++
>>  arch/x86/Kconfig                          |  1 +
>>  drivers/firmware/psci.c                   |  2 +-
>>  include/linux/mm.h                        |  4 ++
>>  kernel/kexec_core.c                       |  2 +-
>>  lib/Kconfig.debug                         |  5 ++-
>>  mm/cma.c                                  | 15 +++----
>>  mm/kasan/kasan_init.c                     | 15 +++----
>>  mm/usercopy.c                             |  4 +-
>>  27 files changed, 180 insertions(+), 99 deletions(-)
>>  create mode 100644 arch/arm64/mm/physaddr.c
>>
> 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
