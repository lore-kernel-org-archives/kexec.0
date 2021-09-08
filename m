Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com
 ([40.107.223.70] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mO6Ww-007kbp-NH
 for kexec@lists.infradead.org; Wed, 08 Sep 2021 22:59:00 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v3 0/8] Implement generic cc_platform_has() helper function
Date: Wed, 8 Sep 2021 17:58:31 -0500
Message-ID: <cover.1631141919.git.thomas.lendacky@amd.com>
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
To: linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Christoph Hellwig <hch@infradead.org>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Baoquan
 He <bhe@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Daniel Vetter <daniel@ffwll.ch>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Young <dyoung@redhat.com>, David Airlie <airlied@linux.ie>, Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Thomas Zimmermann <tzimmermann@suse.de>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>

This patch series provides a generic helper function, cc_platform_has(),
to replace the sme_active(), sev_active(), sev_es_active() and
mem_encrypt_active() functions.

It is expected that as new confidential computing technologies are
added to the kernel, they can all be covered by a single function call
instead of a collection of specific function calls all called from the
same locations.

The powerpc and s390 patches have been compile tested only. Can the
folks copied on this series verify that nothing breaks for them. Also,
a new file, arch/powerpc/platforms/pseries/cc_platform.c, has been
created for powerpc to hold the out of line function.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Will Deacon <will@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>

---

Patches based on:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
  4b93c544e90e ("thunderbolt: test: split up test cases in tb_test_credit_alloc_all")

Changes since v2:
- Changed the name from prot_guest_has() to cc_platform_has()
- Took the cc_platform_has() function out of line. Created two new files,
  cc_platform.c, in both x86 and ppc to implment the function. As a
  result, also changed the attribute defines into enums.
- Removed any received Reviewed-by's and Acked-by's given changes in this
  version.
- Added removal of new instances of mem_encrypt_active() usage in powerpc
  arch.
- Based on latest Linux tree to pick up powerpc changes related to the
  mem_encrypt_active() function.

Changes since v1:
- Moved some arch ioremap functions within #ifdef CONFIG_AMD_MEM_ENCRYPT
  in prep for use of prot_guest_has() by TDX.
- Added type includes to the the protected_guest.h header file to prevent
  build errors outside of x86.
- Made amd_prot_guest_has() EXPORT_SYMBOL_GPL
- Used amd_prot_guest_has() in place of checking sme_me_mask in the
  arch/x86/mm/mem_encrypt.c file.

Tom Lendacky (8):
  x86/ioremap: Selectively build arch override encryption functions
  mm: Introduce a function to check for confidential computing features
  x86/sev: Add an x86 version of cc_platform_has()
  powerpc/pseries/svm: Add a powerpc version of cc_platform_has()
  x86/sme: Replace occurrences of sme_active() with cc_platform_has()
  x86/sev: Replace occurrences of sev_active() with cc_platform_has()
  x86/sev: Replace occurrences of sev_es_active() with cc_platform_has()
  treewide: Replace the use of mem_encrypt_active() with
    cc_platform_has()

 arch/Kconfig                                 |  3 +
 arch/powerpc/include/asm/mem_encrypt.h       |  5 --
 arch/powerpc/platforms/pseries/Kconfig       |  1 +
 arch/powerpc/platforms/pseries/Makefile      |  2 +
 arch/powerpc/platforms/pseries/cc_platform.c | 26 ++++++
 arch/powerpc/platforms/pseries/svm.c         |  5 +-
 arch/s390/include/asm/mem_encrypt.h          |  2 -
 arch/x86/Kconfig                             |  1 +
 arch/x86/include/asm/io.h                    |  8 ++
 arch/x86/include/asm/kexec.h                 |  2 +-
 arch/x86/include/asm/mem_encrypt.h           | 14 +---
 arch/x86/kernel/Makefile                     |  3 +
 arch/x86/kernel/cc_platform.c                | 21 +++++
 arch/x86/kernel/crash_dump_64.c              |  4 +-
 arch/x86/kernel/head64.c                     |  4 +-
 arch/x86/kernel/kvm.c                        |  3 +-
 arch/x86/kernel/kvmclock.c                   |  4 +-
 arch/x86/kernel/machine_kexec_64.c           | 19 +++--
 arch/x86/kernel/pci-swiotlb.c                |  9 +-
 arch/x86/kernel/relocate_kernel_64.S         |  2 +-
 arch/x86/kernel/sev.c                        |  6 +-
 arch/x86/kvm/svm/svm.c                       |  3 +-
 arch/x86/mm/ioremap.c                        | 18 ++--
 arch/x86/mm/mem_encrypt.c                    | 57 +++++++------
 arch/x86/mm/mem_encrypt_identity.c           |  3 +-
 arch/x86/mm/pat/set_memory.c                 |  3 +-
 arch/x86/platform/efi/efi_64.c               |  9 +-
 arch/x86/realmode/init.c                     |  8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  4 +-
 drivers/gpu/drm/drm_cache.c                  |  4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c          |  4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c          |  6 +-
 drivers/iommu/amd/init.c                     |  7 +-
 drivers/iommu/amd/iommu.c                    |  3 +-
 drivers/iommu/amd/iommu_v2.c                 |  3 +-
 drivers/iommu/iommu.c                        |  3 +-
 fs/proc/vmcore.c                             |  6 +-
 include/linux/cc_platform.h                  | 88 ++++++++++++++++++++
 include/linux/mem_encrypt.h                  |  4 -
 kernel/dma/swiotlb.c                         |  4 +-
 40 files changed, 267 insertions(+), 114 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/cc_platform.c
 create mode 100644 arch/x86/kernel/cc_platform.c
 create mode 100644 include/linux/cc_platform.h


base-commit: 4b93c544e90e2b28326182d31ee008eb80e02074
-- 
2.33.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
