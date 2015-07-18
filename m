Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn1on0135.outbound.protection.outlook.com
 ([157.56.110.135] helo=na01-bn1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZGYQR-0007mM-QV
 for kexec@lists.infradead.org; Sat, 18 Jul 2015 20:09:36 +0000
From: Scott Wood <scottwood@freescale.com>
Subject: [RFC PATCH 00/17] powerpc/fsl-book3e-64: kexec/kdump support
Date: Sat, 18 Jul 2015 15:08:37 -0500
Message-ID: <1437250134-307-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
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
To: linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <scottwood@freescale.com>, Tiejun Chen <tiejun.chen@intel.com>, kexec@lists.infradead.org

This patchset adds support for kexec and kdump to e5500 and e6500 based
systems running 64-bit kernels.  It depends on
http://patchwork.ozlabs.org/patch/496952/ ("powerpc/fsl-booke-64: Allow
booting from the secondary thread") and the kexec-tools patch
http://lists.infradead.org/pipermail/kexec/2015-July/014048.html ("ppc64:
Add a flag to tell the kernel it's booting from kexec").

Scott Wood (11):
  powerpc/85xx: Load all early TLB entries at once
  powerpc/85xx: Don't use generic timebase sync on 64-bit
  crypto: caam: Blacklist CAAM when kexec is enabled
  powerpc/fsl-corenet: Disable coreint if kexec is enabled
  powerpc/fsl-booke-64: Don't limit ppc64_rma_size to one TLB entry
  powerpc/e6500: kexec: Handle hardware threads
  powerpc/book3e/kdump: Enable crash_kexec_wait_realmode
  powerpc/book3e-64: Don't limit paca to 256 MiB
  powerpc/book3e-64/kexec: Enable SMP release
  powerpc/booke: Only use VIRT_PHYS_OFFSET on booke32
  powerpc/book3e-64/kexec: Set "r4 = 0" when entering spinloop

Tiejun Chen (6):
  powerpc/85xx: Implement 64-bit kexec support
  powerpc/book3e-64: rename interrupt_end_book3e with __end_interrupts
  powerpc/booke64: Fix args to copy_and_flush
  powerpc/book3e: support CONFIG_RELOCATABLE
  powerpc/book3e-64/kexec: create an identity TLB mapping
  powerpc/book3e-64: Enable kexec

 arch/powerpc/Kconfig                          |  2 +-
 arch/powerpc/include/asm/exception-64e.h      |  4 +-
 arch/powerpc/include/asm/page.h               |  7 +--
 arch/powerpc/include/asm/smp.h                |  1 +
 arch/powerpc/kernel/crash.c                   |  6 +--
 arch/powerpc/kernel/exceptions-64e.S          | 17 +++---
 arch/powerpc/kernel/head_64.S                 | 58 ++++++++++++++++++--
 arch/powerpc/kernel/machine_kexec_64.c        | 19 +++++++
 arch/powerpc/kernel/misc_64.S                 | 62 ++++++++++++++++++++-
 arch/powerpc/kernel/paca.c                    |  6 ++-
 arch/powerpc/kernel/setup_64.c                | 22 +++++++-
 arch/powerpc/mm/fsl_booke_mmu.c               | 35 ++++++++----
 arch/powerpc/mm/mmu_decl.h                    |  4 +-
 arch/powerpc/mm/tlb_nohash.c                  | 41 +++++++++++---
 arch/powerpc/mm/tlb_nohash_low.S              | 63 ++++++++++++++++++++++
 arch/powerpc/platforms/85xx/corenet_generic.c |  4 ++
 arch/powerpc/platforms/85xx/smp.c             | 77 +++++++++++++++++++++++++--
 drivers/crypto/caam/Kconfig                   |  2 +-
 18 files changed, 385 insertions(+), 45 deletions(-)

-- 
2.1.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
