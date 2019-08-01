Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1htB4c-0005I8-5c
 for kexec@lists.infradead.org; Thu, 01 Aug 2019 13:24:52 +0000
Received: by mail-ed1-x543.google.com with SMTP id k8so69118128edr.11
 for <kexec@lists.infradead.org>; Thu, 01 Aug 2019 06:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190731153857.4045-1-pasha.tatashin@soleen.com>
In-Reply-To: <20190731153857.4045-1-pasha.tatashin@soleen.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 1 Aug 2019 09:24:36 -0400
Message-ID: <CA+CK2bBVsU1hhgPB4cO8ZcjL_Y+v59W+-m4rLZPEKfpgvvvEpg@mail.gmail.com>
Subject: Re: [RFC v2 0/8] arm64: MMU enabled kexec relocation
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>, James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, James Morse <james.morse@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Bhupesh Sharma <bhsharma@redhat.com>

I will send a new version soon, so please do not spend time reviewing
this work.  In the new version I will fix MMU at EL2 issue by doing
what we are doing in hibernation: reduce to EL1 to do the copying, and
escalate back to to EL2 to branch to new kernel. Also, this will
simplify copying function by actually doing the linear copy as ttbr1
and ttbr0 are always available this way.

Thank you,
Pasha

On Wed, Jul 31, 2019 at 11:38 AM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> Changelog from previous RFC:
> - Added trans_table support for both hibernate and kexec.
> - Fixed performance issue, where enabling MMU did not yield the
>   actual performance improvement.
>
> Bug:
> With the current state, this patch series works on kernels booted with EL1
> mode, but for some reason, when elevated to EL2 mode reboot freezes in
> both QEMU and on real hardware.
>
> The freeze happens in:
>
> arch/arm64/kernel/relocate_kernel.S
>         turn_on_mmu()
>
> Right after sctlr_el2 is written (MMU on EL2 is enabled)
>
>         msr     sctlr_el2, \tmp1
>
> I've been studying all the relevant control registers for EL2, but do not
> see what might be causing this hang:
>
> MAIR_EL2 is set to be exactly the same as MAIR_EL1 0xbbff440c0400
>
> TCR_EL2        0x80843510
> Enabled bits:
> PS      Physical Address Size. (0b100   44 bits, 16TB.)
> SH0     Shareability    11 Inner Shareable
> ORGN0   Normal memory, Outer Write-Back Read-Allocate Write-Allocate Cach.
> IRGN0   Normal memory, Inner Write-Back Read-Allocate Write-Allocate Cach.
> T0SZ    01 0000
>
> SCTLR_EL2       0x30e5183f
> RES1    : Reserve ones
> M       : MMU enabled
> A       : Align check
> C       : Cacheability control
> SA      : SP Alignment check enable
> IESB    : Implicit Error Synchronization event
> I       : Instruction access Cacheability
>
> TTBR0_EL2      0x1b3069000 (address of trans_table)
>
> Any suggestion of what else might be missing that causes this freeze when
> MMU is enabled in EL2?
>
> =====
> Here is the current data from the real hardware:
> (because of bug, I forced EL1 mode by setting el2_switch always to zero in
> cpu_soft_restart()):
>
> For this experiment, the size of kernel plus initramfs is 25M. If initramfs
> was larger, than the improvements would be even greater, as time spent in
> relocation is proportional to the size of relocation.
>
> Previously:
> kernel shutdown 0.022131328s
> relocation      0.440510736s
> kernel startup  0.294706768s
>
> Relocation was taking: 58.2% of reboot time
>
> Now:
> kernel shutdown 0.032066576s
> relocation      0.022158152s
> kernel startup  0.296055880s
>
> Now: Relocation takes 6.3% of reboot time
>
> Total reboot is x2.16 times faster.
>
> Previous approaches and discussions
> -----------------------------------
> https://lore.kernel.org/lkml/20190709182014.16052-1-pasha.tatashin@soleen.com
> reserve space for kexec to avoid relocation, involves changes to generic code
> to optimize a problem that exists on arm64 only:
>
> https://lore.kernel.org/lkml/20190716165641.6990-1-pasha.tatashin@soleen.com
> The first attempt to enable MMU, some bugs that prevented performance
> improvement. The page tables unnecessary configured idmap for the whole
> physical space.
>
> Pavel Tatashin (8):
>   kexec: quiet down kexec reboot
>   arm64, mm: transitional tables
>   arm64: hibernate: switch to transtional page tables.
>   kexec: add machine_kexec_post_load()
>   arm64, kexec: move relocation function setup and clean up
>   arm64, kexec: add expandable argument to relocation function
>   arm64, kexec: configure transitional page table for kexec
>   arm64, kexec: enable MMU during kexec relocation
>
>  arch/arm64/Kconfig                     |   4 +
>  arch/arm64/include/asm/kexec.h         |  24 ++-
>  arch/arm64/include/asm/pgtable-hwdef.h |   1 +
>  arch/arm64/include/asm/trans_table.h   |  66 ++++++
>  arch/arm64/kernel/asm-offsets.c        |  10 +
>  arch/arm64/kernel/cpu-reset.S          |   4 +-
>  arch/arm64/kernel/cpu-reset.h          |   8 +-
>  arch/arm64/kernel/hibernate.c          | 261 ++++++------------------
>  arch/arm64/kernel/machine_kexec.c      | 168 ++++++++++++---
>  arch/arm64/kernel/relocate_kernel.S    | 238 +++++++++++++++-------
>  arch/arm64/mm/Makefile                 |   1 +
>  arch/arm64/mm/trans_table.c            | 272 +++++++++++++++++++++++++
>  kernel/kexec.c                         |   4 +
>  kernel/kexec_core.c                    |   8 +-
>  kernel/kexec_file.c                    |   4 +
>  kernel/kexec_internal.h                |   2 +
>  16 files changed, 756 insertions(+), 319 deletions(-)
>  create mode 100644 arch/arm64/include/asm/trans_table.h
>  create mode 100644 arch/arm64/mm/trans_table.c
>
> --
> 2.22.0
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
