Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cBnZN-0004dJ-Gy
 for kexec@lists.infradead.org; Tue, 29 Nov 2016 18:56:00 +0000
Received: by mail-qk0-f175.google.com with SMTP id x190so184716779qkb.0
 for <kexec@lists.infradead.org>; Tue, 29 Nov 2016 10:55:36 -0800 (PST)
From: Laura Abbott <labbott@redhat.com>
Subject: [PATCHv4 00/10] CONFIG_DEBUG_VIRTUAL for arm64
Date: Tue, 29 Nov 2016 10:55:19 -0800
Message-Id: <1480445729-27130-1-git-send-email-labbott@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, x86@kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org, Laura Abbott <labbott@redhat.com>, David Vrabel <david.vrabel@citrix.com>, Kees Cook <keescook@chromium.org>, Marc Zyngier <marc.zyngier@arm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Christoffer Dall <christoffer.dall@linaro.org>


Hi,

This is v4 of the series to add CONFIG_DEBUG_VIRTUAL for arm64. This mostly
expanded on __pa_symbol conversion with a few new sites found. There's also
some reworking done to avoid calling __va too early. __va relies on having
memstart_addr set so very early code in early_fixmap_init and early KASAN
initialization can't just call __va(__Ipa_symbol(...)) to get the linear map
alias. I found this while testing with DEBUG_VM.

All of this could use probably use more testing under more configurations.
KVM, Xen, kexec, hibernate should all be tested.

Thanks,
Laura

Laura Abbott (10):
  lib/Kconfig.debug: Add ARCH_HAS_DEBUG_VIRTUAL
  mm/cma: Cleanup highmem check
  arm64: Move some macros under #ifndef __ASSEMBLY__
  arm64: Add cast for virt_to_pfn
  arm64: Use __pa_symbol for kernel symbols
  xen: Switch to using __pa_symbol
  kexec: Switch to __pa_symbol
  mm/kasan: Switch to using __pa_symbol and lm_alias
  mm/usercopy: Switch to using lm_alias
  arm64: Add support for CONFIG_DEBUG_VIRTUAL

 arch/arm64/Kconfig                        |  1 +
 arch/arm64/include/asm/kvm_mmu.h          |  4 +-
 arch/arm64/include/asm/memory.h           | 67 ++++++++++++++++++++++---------
 arch/arm64/include/asm/mmu_context.h      |  6 +--
 arch/arm64/include/asm/pgtable.h          |  2 +-
 arch/arm64/kernel/acpi_parking_protocol.c |  2 +-
 arch/arm64/kernel/cpu-reset.h             |  2 +-
 arch/arm64/kernel/cpufeature.c            |  2 +-
 arch/arm64/kernel/hibernate.c             | 13 +++---
 arch/arm64/kernel/insn.c                  |  2 +-
 arch/arm64/kernel/psci.c                  |  2 +-
 arch/arm64/kernel/setup.c                 |  8 ++--
 arch/arm64/kernel/smp_spin_table.c        |  2 +-
 arch/arm64/kernel/vdso.c                  |  4 +-
 arch/arm64/mm/Makefile                    |  2 +
 arch/arm64/mm/init.c                      | 11 ++---
 arch/arm64/mm/kasan_init.c                | 21 ++++++----
 arch/arm64/mm/mmu.c                       | 32 +++++++++------
 arch/arm64/mm/physaddr.c                  | 28 +++++++++++++
 arch/x86/Kconfig                          |  1 +
 drivers/firmware/psci.c                   |  2 +-
 drivers/xen/xenbus/xenbus_dev_backend.c   |  2 +-
 drivers/xen/xenfs/xenstored.c             |  2 +-
 include/linux/mm.h                        |  4 ++
 kernel/kexec_core.c                       |  2 +-
 lib/Kconfig.debug                         |  5 ++-
 mm/cma.c                                  | 15 +++----
 mm/kasan/kasan_init.c                     | 12 +++---
 mm/usercopy.c                             |  4 +-
 29 files changed, 167 insertions(+), 93 deletions(-)
 create mode 100644 arch/arm64/mm/physaddr.c

-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
