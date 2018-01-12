Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ea2AB-0007IJ-Ie
 for kexec@lists.infradead.org; Fri, 12 Jan 2018 16:26:41 +0000
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] kdump: Write a correct address of mem_section into vmcoreinfo
Date: Fri, 12 Jan 2018 19:25:32 +0300
Message-Id: <20180112162532.35896-1-kirill.shutemov@linux.intel.com>
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
To: Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Baoquan He <bhe@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-mm@kvack.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

Depending on configuration mem_section can now be an array or a pointer
to an array allocated dynamically. In most cases, we can continue to refer
to it as 'mem_section' regardless of what it is.

But there's one exception: '&mem_section' means "address of the array" if
mem_section is an array, but if mem_section is a pointer, it would mean
"address of the pointer".

We've stepped onto this in kdump code. VMCOREINFO_SYMBOL(mem_section)
writes down address of pointer into vmcoreinfo, not array as we wanted.

Let's introduce VMCOREINFO_SYMBOL_ARRAY() that would handle the
situation correctly for both cases.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 83e3c48729d9 ("mm/sparsemem: Allocate mem_section at runtime for CONFIG_SPARSEMEM_EXTREME=y")
Cc: stable@vger.kernel.org
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Dave Young <dyoung@redhat.com>
---
 include/linux/crash_core.h | 2 ++
 kernel/crash_core.c        | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 06097ef30449..b511f6d24b42 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -42,6 +42,8 @@ phys_addr_t paddr_vmcoreinfo_note(void);
 	vmcoreinfo_append_str("PAGESIZE=%ld\n", value)
 #define VMCOREINFO_SYMBOL(name) \
 	vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #name, (unsigned long)&name)
+#define VMCOREINFO_SYMBOL_ARRAY(name) \
+	vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #name, (unsigned long)name)
 #define VMCOREINFO_SIZE(name) \
 	vmcoreinfo_append_str("SIZE(%s)=%lu\n", #name, \
 			      (unsigned long)sizeof(name))
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index b3663896278e..4f63597c824d 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -410,7 +410,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_SYMBOL(contig_page_data);
 #endif
 #ifdef CONFIG_SPARSEMEM
-	VMCOREINFO_SYMBOL(mem_section);
+	VMCOREINFO_SYMBOL_ARRAY(mem_section);
 	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
 	VMCOREINFO_STRUCT_SIZE(mem_section);
 	VMCOREINFO_OFFSET(mem_section, section_mem_map);
-- 
2.15.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
