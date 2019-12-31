Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga17.intel.com ([192.55.52.151])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1imPsS-0007qF-DL
 for kexec@lists.infradead.org; Tue, 31 Dec 2019 22:20:37 +0000
Subject: [PATCH v2 3/4] efi: Fix efi_memmap_alloc() leaks
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 31 Dec 2019 14:04:33 -0800
Message-ID: <157782987346.367056.16932641815225610530.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157782985777.367056.14741265874314204783.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157782985777.367056.14741265874314204783.stgit@dwillia2-desk3.amr.corp.intel.com>
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
To: mingo@redhat.com
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Taku Izumi <izumi.taku@jp.fujitsu.com>

With efi_fake_memmap() and efi_arch_mem_reserve() the efi table may be
updated and replaced multiple times. When that happens a previous
dynamically allocated efi memory map can be garbage collected. Use the
new EFI_MEMMAP_{SLAB,MEMBLOCK} flags to detect when a dynamically
allocated memory map is being replaced.

Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/firmware/efi/memmap.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 2b81ee6858a9..188ab3cd5c52 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -29,6 +29,28 @@ static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
 	return PFN_PHYS(page_to_pfn(p));
 }
 
+static void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
+{
+	if (WARN_ON(slab_is_available() && (flags & EFI_MEMMAP_MEMBLOCK)))
+		return;
+
+	if (flags & EFI_MEMMAP_MEMBLOCK) {
+		memblock_free(phys, size);
+	} else if (flags & EFI_MEMMAP_SLAB) {
+		struct page *p = pfn_to_page(PHYS_PFN(phys));
+		unsigned int order = get_order(size);
+
+		free_pages((unsigned long) page_address(p), order);
+	}
+}
+
+static void __init efi_memmap_free(void)
+{
+	__efi_memmap_free(efi.memmap.phys_map,
+			efi.memmap.desc_size * efi.memmap.nr_map,
+			efi.memmap.flags);
+}
+
 /**
  * efi_memmap_alloc - Allocate memory for the EFI memory map
  * @num_entries: Number of entries in the allocated map.
@@ -209,6 +231,8 @@ int __init efi_memmap_install(phys_addr_t addr, unsigned int nr_map,
 	data.desc_size = efi.memmap.desc_size;
 	flags |= efi.memmap.flags & EFI_MEMMAP_LATE;
 
+	efi_memmap_free();
+
 	return __efi_memmap_init(&data, flags);
 }
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
