Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga07.intel.com ([134.134.136.100])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVIe3-008dej-GF
 for kexec@lists.infradead.org; Tue, 28 Sep 2021 19:20:04 +0000
Subject: Re: [PATCH v4 0/8] Implement generic cc_platform_has() helper function
References: <20210928191009.32551-1-bp@alien8.de>
From: "Kuppuswamy, Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <80593893-c63b-d481-45f1-42a3a6fd762a@linux.intel.com>
Date: Tue, 28 Sep 2021 12:19:49 -0700
MIME-Version: 1.0
In-Reply-To: <20210928191009.32551-1-bp@alien8.de>
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
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Daniel Vetter <daniel@ffwll.ch>, Dave Young <dyoung@redhat.com>, David Airlie <airlied@linux.ie>, Heiko Carstens <hca@linux.ibm.com>, Joerg Roedel <joro@8bytes.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Tom Lendacky <thomas.lendacky@amd.com>, Thomas Zimmermann <tzimmermann@suse.de>, Vasily Gorbik <gor@linux.ibm.com>, VMware Graphics <linux-graphics-maintainer@vmware.com>, Will Deacon <will@kernel.org>, Christoph Hellwig <hch@infradead.org>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org



On 9/28/21 12:10 PM, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Hi all,
> 
> here's v4 of the cc_platform_has() patchset with feedback incorporated.
> 
> I'm going to route this through tip if there are no objections.

Intel CC support patch is not included in this series. You want me
to address the issue raised by Joerg before merging it?

> 
> Thx.
> 
> Tom Lendacky (8):
>    x86/ioremap: Selectively build arch override encryption functions
>    arch/cc: Introduce a function to check for confidential computing
>      features
>    x86/sev: Add an x86 version of cc_platform_has()
>    powerpc/pseries/svm: Add a powerpc version of cc_platform_has()
>    x86/sme: Replace occurrences of sme_active() with cc_platform_has()
>    x86/sev: Replace occurrences of sev_active() with cc_platform_has()
>    x86/sev: Replace occurrences of sev_es_active() with cc_platform_has()
>    treewide: Replace the use of mem_encrypt_active() with
>      cc_platform_has()
> 
>   arch/Kconfig                                 |  3 +
>   arch/powerpc/include/asm/mem_encrypt.h       |  5 --
>   arch/powerpc/platforms/pseries/Kconfig       |  1 +
>   arch/powerpc/platforms/pseries/Makefile      |  2 +
>   arch/powerpc/platforms/pseries/cc_platform.c | 26 ++++++
>   arch/powerpc/platforms/pseries/svm.c         |  5 +-
>   arch/s390/include/asm/mem_encrypt.h          |  2 -
>   arch/x86/Kconfig                             |  1 +
>   arch/x86/include/asm/io.h                    |  8 ++
>   arch/x86/include/asm/kexec.h                 |  2 +-
>   arch/x86/include/asm/mem_encrypt.h           | 12 +--
>   arch/x86/kernel/Makefile                     |  6 ++
>   arch/x86/kernel/cc_platform.c                | 69 +++++++++++++++
>   arch/x86/kernel/crash_dump_64.c              |  4 +-
>   arch/x86/kernel/head64.c                     |  9 +-
>   arch/x86/kernel/kvm.c                        |  3 +-
>   arch/x86/kernel/kvmclock.c                   |  4 +-
>   arch/x86/kernel/machine_kexec_64.c           | 19 +++--
>   arch/x86/kernel/pci-swiotlb.c                |  9 +-
>   arch/x86/kernel/relocate_kernel_64.S         |  2 +-
>   arch/x86/kernel/sev.c                        |  6 +-
>   arch/x86/kvm/svm/svm.c                       |  3 +-
>   arch/x86/mm/ioremap.c                        | 18 ++--
>   arch/x86/mm/mem_encrypt.c                    | 55 ++++--------
>   arch/x86/mm/mem_encrypt_identity.c           |  9 +-
>   arch/x86/mm/pat/set_memory.c                 |  3 +-
>   arch/x86/platform/efi/efi_64.c               |  9 +-
>   arch/x86/realmode/init.c                     |  8 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  4 +-
>   drivers/gpu/drm/drm_cache.c                  |  4 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_drv.c          |  4 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_msg.c          |  6 +-
>   drivers/iommu/amd/init.c                     |  7 +-
>   drivers/iommu/amd/iommu.c                    |  3 +-
>   drivers/iommu/amd/iommu_v2.c                 |  3 +-
>   drivers/iommu/iommu.c                        |  3 +-
>   fs/proc/vmcore.c                             |  6 +-
>   include/linux/cc_platform.h                  | 88 ++++++++++++++++++++
>   include/linux/mem_encrypt.h                  |  4 -
>   kernel/dma/swiotlb.c                         |  4 +-
>   40 files changed, 310 insertions(+), 129 deletions(-)
>   create mode 100644 arch/powerpc/platforms/pseries/cc_platform.c
>   create mode 100644 arch/x86/kernel/cc_platform.c
>   create mode 100644 include/linux/cc_platform.h
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
