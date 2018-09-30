Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g6S8Z-0002BC-2X
 for kexec@lists.infradead.org; Sun, 30 Sep 2018 03:11:18 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH v8 RESEND 1/4] x86/ioremap: add a function ioremap_encrypted()
 to remap kdump old memory
Date: Sun, 30 Sep 2018 11:10:30 +0800
Message-Id: <20180930031033.22110-2-lijiang@redhat.com>
In-Reply-To: <20180930031033.22110-1-lijiang@redhat.com>
References: <20180930031033.22110-1-lijiang@redhat.com>
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
Cc: thomas.lendacky@amd.com, jroedel@suse.de, brijesh.singh@amd.com, bhe@redhat.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, bp@suse.de, dyoung@redhat.com, akpm@linux-foundation.org, dan.j.williams@intel.com

When SME is enabled on AMD machine, the memory is encrypted in the first
kernel. In this case, SME also needs to be enabled in kdump kernel, and
the old memory has to be remapped with the memory encryption mask.

Here we only talk about the case that SME is active in the first kernel,
and only care it's active too in kdump kernel. there are four cases that
need considered.

a. dump vmcore
   It is encrypted in the first kernel, and needs be read out in kdump
   kernel.

b. crash notes
   When dumping vmcore, the people usually need to read the useful
   information from notes, and the notes is also encrypted.

c. iommu device table
   It is allocated by kernel, need fill its pointer into mmio of amd iommu.
   It's encrypted in the first kernel, need read the old content to analyze
   and get useful information.

d. mmio of amd iommu
   Register reported by amd firmware, it's not RAM, which won't be
   encrypted in both the first kernel and kdump kernel.

To achieve the goal, the solution is:
1. add a new bool parameter "encrypted" to __ioremap_caller()
   It is a low level function, and check the newly added parameter, if it's
   true and in kdump kernel, will remap the memory with sme mask.

2. add a new function ioremap_encrypted() to explicitly passed in a "true"
   value for "encrypted".
   For above a, b, c, kdump kernel will call ioremap_encrypted();

3. adjust all existed ioremap wrapper functions, passed in "false" for
   encrypted to make them as before.

   ioremap_encrypted()\
   ioremap_cache()     |
   ioremap_prot()      |
   ioremap_wt()        |->__ioremap_caller()
   ioremap_wc()        |
   ioremap_uc()        |
   ioremap_nocache()  /

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
Changes since v7:
1. Remove a redundant header file "linux/crash_dump.h".(Suggested by
Borislav)
2. Modify code style issue.(Suggested by Borislav)
3. Improve patch log.(Suggested by Baoquan)

 arch/x86/include/asm/io.h |  2 ++
 arch/x86/mm/ioremap.c     | 24 ++++++++++++++++--------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 6de64840dd22..b7b0bf36c400 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -192,6 +192,8 @@ extern void __iomem *ioremap_cache(resource_size_t offset, unsigned long size);
 #define ioremap_cache ioremap_cache
 extern void __iomem *ioremap_prot(resource_size_t offset, unsigned long size, unsigned long prot_val);
 #define ioremap_prot ioremap_prot
+extern void __iomem *ioremap_encrypted(resource_size_t phys_addr, unsigned long size);
+#define ioremap_encrypted ioremap_encrypted
 
 /**
  * ioremap     -   map bus memory into CPU space
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index c63a545ec199..24e0920a9b25 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -131,7 +131,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
  * caller shouldn't need to know that small detail.
  */
 static void __iomem *__ioremap_caller(resource_size_t phys_addr,
-		unsigned long size, enum page_cache_mode pcm, void *caller)
+		unsigned long size, enum page_cache_mode pcm,
+		void *caller, bool encrypted)
 {
 	unsigned long offset, vaddr;
 	resource_size_t last_addr;
@@ -199,7 +200,7 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
 	 * resulting mapping.
 	 */
 	prot = PAGE_KERNEL_IO;
-	if (sev_active() && mem_flags.desc_other)
+	if ((sev_active() && mem_flags.desc_other) || encrypted)
 		prot = pgprot_encrypted(prot);
 
 	switch (pcm) {
@@ -291,7 +292,7 @@ void __iomem *ioremap_nocache(resource_size_t phys_addr, unsigned long size)
 	enum page_cache_mode pcm = _PAGE_CACHE_MODE_UC_MINUS;
 
 	return __ioremap_caller(phys_addr, size, pcm,
-				__builtin_return_address(0));
+				__builtin_return_address(0), false);
 }
 EXPORT_SYMBOL(ioremap_nocache);
 
@@ -324,7 +325,7 @@ void __iomem *ioremap_uc(resource_size_t phys_addr, unsigned long size)
 	enum page_cache_mode pcm = _PAGE_CACHE_MODE_UC;
 
 	return __ioremap_caller(phys_addr, size, pcm,
-				__builtin_return_address(0));
+				__builtin_return_address(0), false);
 }
 EXPORT_SYMBOL_GPL(ioremap_uc);
 
@@ -341,7 +342,7 @@ EXPORT_SYMBOL_GPL(ioremap_uc);
 void __iomem *ioremap_wc(resource_size_t phys_addr, unsigned long size)
 {
 	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WC,
-					__builtin_return_address(0));
+					__builtin_return_address(0), false);
 }
 EXPORT_SYMBOL(ioremap_wc);
 
@@ -358,14 +359,21 @@ EXPORT_SYMBOL(ioremap_wc);
 void __iomem *ioremap_wt(resource_size_t phys_addr, unsigned long size)
 {
 	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WT,
-					__builtin_return_address(0));
+					__builtin_return_address(0), false);
 }
 EXPORT_SYMBOL(ioremap_wt);
 
+void __iomem *ioremap_encrypted(resource_size_t phys_addr, unsigned long size)
+{
+	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WB,
+				__builtin_return_address(0), true);
+}
+EXPORT_SYMBOL(ioremap_encrypted);
+
 void __iomem *ioremap_cache(resource_size_t phys_addr, unsigned long size)
 {
 	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WB,
-				__builtin_return_address(0));
+				__builtin_return_address(0), false);
 }
 EXPORT_SYMBOL(ioremap_cache);
 
@@ -374,7 +382,7 @@ void __iomem *ioremap_prot(resource_size_t phys_addr, unsigned long size,
 {
 	return __ioremap_caller(phys_addr, size,
 				pgprot2cachemode(__pgprot(prot_val)),
-				__builtin_return_address(0));
+				__builtin_return_address(0), false);
 }
 EXPORT_SYMBOL(ioremap_prot);
 
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
