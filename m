From: Huang Shijie <shijie@os.amperecomputing.com>
Date: Wed,  9 Feb 2022 09:26:42 +0000
Subject: [PATCH] arm64: crash_core: Export MODULES, VMALLOC, and VMEMMAP ranges
Message-ID: <20220209092642.9181-1-shijie@os.amperecomputing.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

The following interrelated ranges are needed by the kdump crash tool:
	MODULES_VADDR ~ MODULES_END,
	VMALLOC_START ~ VMALLOC_END,
	VMEMMAP_START ~ VMEMMAP_END

Since these values change from time to time, it is preferable to export
them via vmcoreinfo than to change the crash's code frequently.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 Documentation/admin-guide/kdump/vmcoreinfo.rst | 8 ++++++++
 arch/arm64/kernel/crash_core.c                 | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 3861a25faae1..a339af45a22e 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -494,6 +494,14 @@ architecture which is used to lookup the page-tables for the Virtual
 addresses in the higher VA range (refer to ARMv8 ARM document for
 more details).
 
+MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_END
+-------------
+
+Used to get the correct ranges:
+	MODULES_VADDR ~ MODULES_END-1 : Kernel module space.
+	VMALLOC_START ~ VMALLOC_END-1 : vmalloc() / ioremap() space.
+	VMEMMAP_START ~ VMEMMAP_END-1 : vmemmap region, used for struct page array.
+
 arm
 ===
 
diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
index 314391a156ee..2b65aae332ce 100644
--- a/arch/arm64/kernel/crash_core.c
+++ b/arch/arm64/kernel/crash_core.c
@@ -20,6 +20,12 @@ void arch_crash_save_vmcoreinfo(void)
 {
 	VMCOREINFO_NUMBER(VA_BITS);
 	/* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
+	vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
+	vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
+	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
+	vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
+	vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
+	vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
 	vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
 						kimage_voffset);
 	vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
-- 
2.30.2


