Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-dm3nam03on0062.outbound.protection.outlook.com
 ([104.47.41.62] helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dIgQC-0007uj-2U
 for kexec@lists.infradead.org; Wed, 07 Jun 2017 19:15:14 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v6 09/34] x86/mm: Simplify p[gum]d_page() macros
Date: Wed, 07 Jun 2017 14:14:45 -0500
Message-ID: <20170607191445.28645.15664.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <20170607191309.28645.15241.stgit@tlendack-t1.amdoffice.net>
References: <20170607191309.28645.15241.stgit@tlendack-t1.amdoffice.net>
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
To: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Radim =?utf-8?b?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Dave Young <dyoung@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Dmitry Vyukov <dvyukov@google.com>

Create a pgd_pfn() macro similar to the p[um]d_pfn() macros and then
use the p[gum]d_pfn() macros in the p[gum]d_page() macros instead of
duplicating the code.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/pgtable.h |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index f5af95a..96b6b83 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -195,6 +195,11 @@ static inline unsigned long p4d_pfn(p4d_t p4d)
 	return (p4d_val(p4d) & p4d_pfn_mask(p4d)) >> PAGE_SHIFT;
 }
 
+static inline unsigned long pgd_pfn(pgd_t pgd)
+{
+	return (pgd_val(pgd) & PTE_PFN_MASK) >> PAGE_SHIFT;
+}
+
 static inline int p4d_large(p4d_t p4d)
 {
 	/* No 512 GiB pages yet */
@@ -699,8 +704,7 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
  * Currently stuck as a macro due to indirect forward reference to
  * linux/mmzone.h's __section_mem_map_addr() definition:
  */
-#define pmd_page(pmd)		\
-	pfn_to_page((pmd_val(pmd) & pmd_pfn_mask(pmd)) >> PAGE_SHIFT)
+#define pmd_page(pmd)	pfn_to_page(pmd_pfn(pmd))
 
 /*
  * the pmd page can be thought of an array like this: pmd_t[PTRS_PER_PMD]
@@ -768,8 +772,7 @@ static inline unsigned long pud_page_vaddr(pud_t pud)
  * Currently stuck as a macro due to indirect forward reference to
  * linux/mmzone.h's __section_mem_map_addr() definition:
  */
-#define pud_page(pud)		\
-	pfn_to_page((pud_val(pud) & pud_pfn_mask(pud)) >> PAGE_SHIFT)
+#define pud_page(pud)	pfn_to_page(pud_pfn(pud))
 
 /* Find an entry in the second-level page table.. */
 static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
@@ -819,8 +822,7 @@ static inline unsigned long p4d_page_vaddr(p4d_t p4d)
  * Currently stuck as a macro due to indirect forward reference to
  * linux/mmzone.h's __section_mem_map_addr() definition:
  */
-#define p4d_page(p4d)		\
-	pfn_to_page((p4d_val(p4d) & p4d_pfn_mask(p4d)) >> PAGE_SHIFT)
+#define p4d_page(p4d)	pfn_to_page(p4d_pfn(p4d))
 
 /* Find an entry in the third-level page table.. */
 static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
@@ -854,7 +856,7 @@ static inline unsigned long pgd_page_vaddr(pgd_t pgd)
  * Currently stuck as a macro due to indirect forward reference to
  * linux/mmzone.h's __section_mem_map_addr() definition:
  */
-#define pgd_page(pgd)		pfn_to_page(pgd_val(pgd) >> PAGE_SHIFT)
+#define pgd_page(pgd)	pfn_to_page(pgd_pfn(pgd))
 
 /* to find an entry in a page-table-directory. */
 static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
