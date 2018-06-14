Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fTNvc-0002sK-0w
 for kexec@lists.infradead.org; Thu, 14 Jun 2018 08:48:24 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 2/2 V2] Support kdump when AMD secure memory encryption is
 active
Date: Thu, 14 Jun 2018 16:47:48 +0800
Message-Id: <20180614084748.9617-3-lijiang@redhat.com>
In-Reply-To: <20180614084748.9617-1-lijiang@redhat.com>
References: <20180614084748.9617-1-lijiang@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: thomas.lendacky@amd.com, dyoung@redhat.com, kexec@lists.infradead.org

When sme enabled on AMD server, we also need to support kdump. Because
the memory is encrypted in the first kernel, we will remap the old memory
encrypted to the second kernel(crash kernel), and sme is also enabled in
the second kernel, otherwise the old memory encrypted can not be decrypted.
Because simply changing the value of a C-bit on a page will not
automatically encrypt the existing contents of a page, and any data in the
page prior to the C-bit modification will become unintelligible. A page of
memory that is marked encrypted will be automatically decrypted when read
from DRAM and will be automatically encrypted when written to DRAM.

For the kdump, it is necessary to distinguish whether the memory is
encrypted. Furthermore, we should also know which part of the memory is
encrypted or decrypted. We will appropriately remap the memory according
to the specific situation in order to tell cpu how to deal with the data(
encrypted or unencrypted). For example, when sme enabled, if the old memory
is encrypted, we will remap the old memory in encrypted way, which will
automatically decrypt the old memory encrypted when we read those data from
the remapping address.

 ----------------------------------------------
| first-kernel | second-kernel | kdump support |
|      (mem_encrypt=on|off)    |   (yes|no)    |
|--------------+---------------+---------------|
|     on       |     on        |     yes       |
|     off      |     off       |     yes       |
|     on       |     off       |     no        |
|     off      |     on        |     no        |
|______________|_______________|_______________|

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
Some changes based on V1:
1. remove the '#ifdef' stuff throughout this patch.
2. put some logic into the early_memremap_pgprot_adjust() and clean the
previous unnecessary changes, for example: arch/x86/include/asm/dmi.h,
arch/x86/kernel/acpi/boot.c, drivers/acpi/tables.c.
3. rewrite two functions, copy_oldmem_page() and
copy_oldmem_page_encrypted().
4. distingish sme_active() and sev_active(), when a distinction doesn't
need, mem_encrypt_active() will be used.
5. clean compile warning in copy_device_table().

 arch/x86/kernel/crash_dump_64.c | 42 +++++++++++++++++++++++++++++++----------
 arch/x86/mm/ioremap.c           |  4 ++++
 drivers/iommu/amd_iommu_init.c  | 14 +++++++++++++-
 fs/proc/vmcore.c                | 20 +++++++++++++++-----
 include/linux/crash_dump.h      |  5 +++++
 kernel/kexec_core.c             | 12 ++++++++++++
 6 files changed, 81 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index 4f2e077..a2c7b13 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -11,6 +11,23 @@
 #include <linux/uaccess.h>
 #include <linux/io.h>
 
+static ssize_t copy_to(void *to, void *vaddr, unsigned long offset,
+		       size_t size, int userbuf)
+{
+	if (userbuf) {
+		if (copy_to_user(to, vaddr + offset, size)) {
+			iounmap(vaddr);
+			return -ENOMEM;
+		}
+	} else
+		memcpy(to, vaddr + offset, size);
+
+	set_iounmap_nonlazy();
+	iounmap(vaddr);
+
+	return size;
+}
+
 /**
  * copy_oldmem_page - copy one page from "oldmem"
  * @pfn: page frame number to be copied
@@ -36,15 +53,20 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 	if (!vaddr)
 		return -ENOMEM;
 
-	if (userbuf) {
-		if (copy_to_user(buf, vaddr + offset, csize)) {
-			iounmap(vaddr);
-			return -EFAULT;
-		}
-	} else
-		memcpy(buf, vaddr + offset, csize);
+	return copy_to(buf, vaddr, offset, csize, userbuf);
+}
 
-	set_iounmap_nonlazy();
-	iounmap(vaddr);
-	return csize;
+ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
+		size_t csize, unsigned long offset, int userbuf)
+{
+	void  *vaddr;
+
+	if (!csize)
+		return 0;
+
+	vaddr = ioremap_encrypted(pfn << PAGE_SHIFT, PAGE_SIZE);
+	if (!vaddr)
+		return -ENOMEM;
+
+	return copy_to(buf, vaddr, offset, csize, userbuf);
 }
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 24e0920..e365fc4 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -24,6 +24,7 @@
 #include <asm/pgalloc.h>
 #include <asm/pat.h>
 #include <asm/setup.h>
+#include <linux/crash_dump.h>
 
 #include "physaddr.h"
 
@@ -696,6 +697,9 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
 	if (encrypted_prot && memremap_should_map_decrypted(phys_addr, size))
 		encrypted_prot = false;
 
+	if (sme_active() && is_kdump_kernel())
+		encrypted_prot = false;
+
 	return encrypted_prot ? pgprot_encrypted(prot)
 			      : pgprot_decrypted(prot);
 }
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 904c575..5e535a6 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -889,11 +889,23 @@ static bool copy_device_table(void)
 	}
 
 	old_devtb_phys = entry & PAGE_MASK;
+	/*
+	 *  When sme enable in the first kernel, old_devtb_phys includes the
+	 *  memory encryption mask(sme_me_mask), we must remove the memory
+	 *  encryption mask to obtain the true physical address in kdump mode.
+	 */
+	if (mem_encrypt_active() && is_kdump_kernel())
+		old_devtb_phys = __sme_clr(old_devtb_phys);
 	if (old_devtb_phys >= 0x100000000ULL) {
 		pr_err("The address of old device table is above 4G, not trustworthy!\n");
 		return false;
 	}
-	old_devtb = memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
+	if (mem_encrypt_active() && is_kdump_kernel())
+		old_devtb = (void *)ioremap_encrypted(old_devtb_phys,
+						     dev_table_size);
+	else
+		old_devtb = memremap(old_devtb_phys,
+				    dev_table_size, MEMREMAP_WB);
 	if (!old_devtb)
 		return false;
 
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index a45f0af..4d0c884 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -25,6 +25,8 @@
 #include <linux/uaccess.h>
 #include <asm/io.h>
 #include "internal.h"
+#include <linux/mem_encrypt.h>
+#include <asm/pgtable.h>
 
 /* List representing chunks of contiguous memory areas and their offsets in
  * vmcore file.
@@ -86,7 +88,8 @@ static int pfn_is_ram(unsigned long pfn)
 
 /* Reads a page from the oldmem device from given offset. */
 static ssize_t read_from_oldmem(char *buf, size_t count,
-				u64 *ppos, int userbuf)
+				u64 *ppos, int userbuf,
+				bool encrypted)
 {
 	unsigned long pfn, offset;
 	size_t nr_bytes;
@@ -108,8 +111,13 @@ static ssize_t read_from_oldmem(char *buf, size_t count,
 		if (pfn_is_ram(pfn) == 0)
 			memset(buf, 0, nr_bytes);
 		else {
-			tmp = copy_oldmem_page(pfn, buf, nr_bytes,
+			if (encrypted)
+				tmp = copy_oldmem_page_encrypted(pfn, buf,
+					       nr_bytes, offset, userbuf);
+			else
+				tmp = copy_oldmem_page(pfn, buf, nr_bytes,
 						offset, userbuf);
+
 			if (tmp < 0)
 				return tmp;
 		}
@@ -143,7 +151,7 @@ void __weak elfcorehdr_free(unsigned long long addr)
  */
 ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0);
+	return read_from_oldmem(buf, count, ppos, 0, sev_active());
 }
 
 /*
@@ -151,7 +159,7 @@ ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
  */
 ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0);
+	return read_from_oldmem(buf, count, ppos, 0, sme_active());
 }
 
 /*
@@ -161,6 +169,7 @@ int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
 				  unsigned long from, unsigned long pfn,
 				  unsigned long size, pgprot_t prot)
 {
+	prot = pgprot_encrypted(prot);
 	return remap_pfn_range(vma, from, pfn, size, prot);
 }
 
@@ -235,7 +244,8 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 					    m->offset + m->size - *fpos,
 					    buflen);
 			start = m->paddr + *fpos - m->offset;
-			tmp = read_from_oldmem(buffer, tsz, &start, userbuf);
+			tmp = read_from_oldmem(buffer, tsz, &start, userbuf,
+						mem_encrypt_active());
 			if (tmp < 0)
 				return tmp;
 			buflen -= tsz;
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index f7ac2aa..28b0a7c 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -25,6 +25,11 @@ extern int remap_oldmem_pfn_range(struct vm_area_struct *vma,
 
 extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
 						unsigned long, int);
+extern ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
+					  size_t csize, unsigned long offset,
+					  int userbuf);
+#define copy_oldmem_page_encrypted copy_oldmem_page_encrypted
+
 void vmcore_cleanup(void);
 
 /* Architecture code defines this if there are other possible ELF
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 20fef1a..3c22a9b 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -471,6 +471,16 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
 		}
 	}
 
+	if (pages) {
+		unsigned int count, i;
+
+		pages->mapping = NULL;
+		set_page_private(pages, order);
+		count = 1 << order;
+		for (i = 0; i < count; i++)
+			SetPageReserved(pages + i);
+		arch_kexec_post_alloc_pages(page_address(pages), 1 << order, 0);
+	}
 	return pages;
 }
 
@@ -865,6 +875,7 @@ static int kimage_load_crash_segment(struct kimage *image,
 			result  = -ENOMEM;
 			goto out;
 		}
+		arch_kexec_post_alloc_pages(page_address(page), 1, 0);
 		ptr = kmap(page);
 		ptr += maddr & ~PAGE_MASK;
 		mchunk = min_t(size_t, mbytes,
@@ -882,6 +893,7 @@ static int kimage_load_crash_segment(struct kimage *image,
 			result = copy_from_user(ptr, buf, uchunk);
 		kexec_flush_icache_page(page);
 		kunmap(page);
+		arch_kexec_pre_free_pages(page_address(page), 1);
 		if (result) {
 			result = -EFAULT;
 			goto out;
-- 
2.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
