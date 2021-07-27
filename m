Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-dm6nam10on2052.outbound.protection.outlook.com
 ([40.107.93.52] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m8Vhu-00GZRw-Ia
 for kexec@lists.infradead.org; Tue, 27 Jul 2021 22:37:52 +0000
Subject: Re: [PATCH 00/11] Implement generic prot_guest_has() helper function
From: Tom Lendacky <thomas.lendacky@amd.com>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
Message-ID: <fc88728a-76e0-2493-1d82-9b228a67de63@amd.com>
Date: Tue, 27 Jul 2021 17:37:43 -0500
In-Reply-To: <cover.1627424773.git.thomas.lendacky@amd.com>
Content-Language: en-US
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
Cc: Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Daniel Vetter <daniel@ffwll.ch>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Young <dyoung@redhat.com>, David Airlie <airlied@linux.ie>, Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Thomas Zimmermann <tzimmermann@suse.de>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>

On 7/27/21 5:26 PM, Tom Lendacky wrote:
> This patch series provides a generic helper function, prot_guest_has(),
> to replace the sme_active(), sev_active(), sev_es_active() and
> mem_encrypt_active() functions.
> 
> It is expected that as new protected virtualization technologies are
> added to the kernel, they can all be covered by a single function call
> instead of a collection of specific function calls all called from the
> same locations.
> 
> The powerpc and s390 patches have been compile tested only. Can the
> folks copied on this series verify that nothing breaks for them.

I wanted to get this out before I head out on vacation at the end of the
week. I'll only be out for a week, but I won't be able to respond to any
feedback until I get back.

I'm still not a fan of the name prot_guest_has() because it is used for
some baremetal checks, but really haven't been able to come up with
anything better. So take it with a grain of salt where the sme_active()
calls are replaced by prot_guest_has().

Also, let me know if the treewide changes in patch #7 need to be further
split out by tree.

Thanks,
Tom

> 
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
> Cc: Will Deacon <will@kernel.org>
> 
> ---
> 
> Patches based on:
>   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
>   commit 79e920060fa7 ("Merge branch 'WIP/fixes'")
> 
> Tom Lendacky (11):
>   mm: Introduce a function to check for virtualization protection
>     features
>   x86/sev: Add an x86 version of prot_guest_has()
>   powerpc/pseries/svm: Add a powerpc version of prot_guest_has()
>   x86/sme: Replace occurrences of sme_active() with prot_guest_has()
>   x86/sev: Replace occurrences of sev_active() with prot_guest_has()
>   x86/sev: Replace occurrences of sev_es_active() with prot_guest_has()
>   treewide: Replace the use of mem_encrypt_active() with
>     prot_guest_has()
>   mm: Remove the now unused mem_encrypt_active() function
>   x86/sev: Remove the now unused mem_encrypt_active() function
>   powerpc/pseries/svm: Remove the now unused mem_encrypt_active()
>     function
>   s390/mm: Remove the now unused mem_encrypt_active() function
> 
>  arch/Kconfig                               |  3 ++
>  arch/powerpc/include/asm/mem_encrypt.h     |  5 --
>  arch/powerpc/include/asm/protected_guest.h | 30 +++++++++++
>  arch/powerpc/platforms/pseries/Kconfig     |  1 +
>  arch/s390/include/asm/mem_encrypt.h        |  2 -
>  arch/x86/Kconfig                           |  1 +
>  arch/x86/include/asm/kexec.h               |  2 +-
>  arch/x86/include/asm/mem_encrypt.h         | 13 +----
>  arch/x86/include/asm/protected_guest.h     | 27 ++++++++++
>  arch/x86/kernel/crash_dump_64.c            |  4 +-
>  arch/x86/kernel/head64.c                   |  4 +-
>  arch/x86/kernel/kvm.c                      |  3 +-
>  arch/x86/kernel/kvmclock.c                 |  4 +-
>  arch/x86/kernel/machine_kexec_64.c         | 19 +++----
>  arch/x86/kernel/pci-swiotlb.c              |  9 ++--
>  arch/x86/kernel/relocate_kernel_64.S       |  2 +-
>  arch/x86/kernel/sev.c                      |  6 +--
>  arch/x86/kvm/svm/svm.c                     |  3 +-
>  arch/x86/mm/ioremap.c                      | 16 +++---
>  arch/x86/mm/mem_encrypt.c                  | 60 +++++++++++++++-------
>  arch/x86/mm/mem_encrypt_identity.c         |  3 +-
>  arch/x86/mm/pat/set_memory.c               |  3 +-
>  arch/x86/platform/efi/efi_64.c             |  9 ++--
>  arch/x86/realmode/init.c                   |  8 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 +-
>  drivers/gpu/drm/drm_cache.c                |  4 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c        |  4 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_msg.c        |  6 +--
>  drivers/iommu/amd/init.c                   |  7 +--
>  drivers/iommu/amd/iommu.c                  |  3 +-
>  drivers/iommu/amd/iommu_v2.c               |  3 +-
>  drivers/iommu/iommu.c                      |  3 +-
>  fs/proc/vmcore.c                           |  6 +--
>  include/linux/mem_encrypt.h                |  4 --
>  include/linux/protected_guest.h            | 37 +++++++++++++
>  kernel/dma/swiotlb.c                       |  4 +-
>  36 files changed, 218 insertions(+), 104 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/protected_guest.h
>  create mode 100644 arch/x86/include/asm/protected_guest.h
>  create mode 100644 include/linux/protected_guest.h
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
