Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVIUl-008bH6-5M
 for kexec@lists.infradead.org; Tue, 28 Sep 2021 19:10:31 +0000
From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH 1/8] x86/ioremap: Selectively build arch override encryption
 functions
Date: Tue, 28 Sep 2021 21:10:02 +0200
Message-Id: <20210928191009.32551-2-bp@alien8.de>
In-Reply-To: <20210928191009.32551-1-bp@alien8.de>
References: <20210928191009.32551-1-bp@alien8.de>
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Daniel Vetter <daniel@ffwll.ch>, Dave Young <dyoung@redhat.com>, David Airlie <airlied@linux.ie>, Heiko Carstens <hca@linux.ibm.com>, Joerg Roedel <joro@8bytes.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Tom Lendacky <thomas.lendacky@amd.com>, Thomas Zimmermann <tzimmermann@suse.de>, Vasily Gorbik <gor@linux.ibm.com>, VMware Graphics <linux-graphics-maintainer@vmware.com>, Will Deacon <will@kernel.org>, Christoph Hellwig <hch@infradead.org>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org

From: Tom Lendacky <thomas.lendacky@amd.com>

In preparation for other uses of the cc_platform_has() function
besides AMD's memory encryption support, selectively build the
AMD memory encryption architecture override functions only when
CONFIG_AMD_MEM_ENCRYPT=y. These functions are:

- early_memremap_pgprot_adjust()
- arch_memremap_can_ram_remap()

Additionally, routines that are only invoked by these architecture
override functions can also be conditionally built. These functions are:

- memremap_should_map_decrypted()
- memremap_is_efi_data()
- memremap_is_setup_data()
- early_memremap_is_setup_data()

And finally, phys_mem_access_encrypted() is conditionally built as well,
but requires a static inline version of it when CONFIG_AMD_MEM_ENCRYPT is
not set.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/io.h | 8 ++++++++
 arch/x86/mm/ioremap.c     | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 841a5d104afa..5c6a4af0b911 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -391,6 +391,7 @@ extern void arch_io_free_memtype_wc(resource_size_t start, resource_size_t size)
 #define arch_io_reserve_memtype_wc arch_io_reserve_memtype_wc
 #endif
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
 extern bool arch_memremap_can_ram_remap(resource_size_t offset,
 					unsigned long size,
 					unsigned long flags);
@@ -398,6 +399,13 @@ extern bool arch_memremap_can_ram_remap(resource_size_t offset,
 
 extern bool phys_mem_access_encrypted(unsigned long phys_addr,
 				      unsigned long size);
+#else
+static inline bool phys_mem_access_encrypted(unsigned long phys_addr,
+					     unsigned long size)
+{
+	return true;
+}
+#endif
 
 /**
  * iosubmit_cmds512 - copy data to single MMIO location, in 512-bit units
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 60ade7dd71bd..ccff76cedd8f 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -508,6 +508,7 @@ void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr)
 	memunmap((void *)((unsigned long)addr & PAGE_MASK));
 }
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
 /*
  * Examine the physical address to determine if it is an area of memory
  * that should be mapped decrypted.  If the memory is not part of the
@@ -746,7 +747,6 @@ bool phys_mem_access_encrypted(unsigned long phys_addr, unsigned long size)
 	return arch_memremap_can_ram_remap(phys_addr, size, 0);
 }
 
-#ifdef CONFIG_AMD_MEM_ENCRYPT
 /* Remap memory with encryption */
 void __init *early_memremap_encrypted(resource_size_t phys_addr,
 				      unsigned long size)
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
