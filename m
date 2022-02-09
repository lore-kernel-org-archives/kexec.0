From: Eric DeVolder <eric.devolder@oracle.com>
Date: Wed,  9 Feb 2022 14:57:01 -0500
Subject: [PATCH v4 05/10] crash hp: introduce helper functions
 un/map_crash_pages
In-Reply-To: <20220209195706.51522-1-eric.devolder@oracle.com>
References: <20220209195706.51522-1-eric.devolder@oracle.com>
Message-ID: <20220209195706.51522-6-eric.devolder@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

This change introduces two new functions un/map_crash_pages()
which are used to enable/disable access to the segments in the
crash memory region. (Upon loading of a crash kernel, the
crash memory regions are made inaccessible for integrity purposes.)

For example, on x86_64, one of the segments is the elfcorehdr,
which contains the list of CPUs and memories. This segment
needs to be modified in response to hotplug events. These functions
are used to obtain (and subsequenntly release) access to the crash
memory region in order to make the modifications.

QUESTION: These might need to be in arch/x86 as I'm not certain
the implementatin is valid for all archs?

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 include/linux/kexec.h |  2 ++
 kernel/crash_core.c   | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index b11d75a6b2bc..e00c373c4095 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -324,6 +324,8 @@ struct kimage {
 };
 
 #ifdef CONFIG_CRASH_HOTPLUG
+void *map_crash_pages(unsigned long paddr, unsigned long size);
+void unmap_crash_pages(void **ptr);
 void arch_crash_hotplug_handler(struct kimage *image,
 	unsigned int hp_action, unsigned long a, unsigned long b);
 #define KEXEC_CRASH_HP_REMOVE_CPU   0
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 256cf6db573c..0ff06d0698ad 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
+#include <linux/highmem.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -491,3 +492,34 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+#ifdef CONFIG_CRASH_HOTPLUG
+void *map_crash_pages(unsigned long paddr, unsigned long size)
+{
+	/*
+	 * NOTE: The addresses and sizes passed to this routine have
+	 * already been fully aligned on page boundaries. There is no
+	 * need for massaging the address or size.
+	 */
+	void *ptr = NULL;
+
+	/* NOTE: requires arch_kexec_[un]protect_crashkres() for write access */
+	if (size > 0) {
+		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
+
+		ptr = kmap(page);
+	}
+
+	return ptr;
+}
+
+void unmap_crash_pages(void **ptr)
+{
+	if (ptr) {
+		if (*ptr)
+			kunmap(*ptr);
+		*ptr = NULL;
+	}
+}
+#endif
+
-- 
2.27.0


