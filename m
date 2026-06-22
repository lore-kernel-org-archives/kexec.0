Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00822CD98F2
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 20:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tt14Am1aq6WCxvZ7y5Ut2dATkB63IfpDSrVIWZNzDLw=; b=mYEHhhX2Byl0kx387U/LgB0feO
	9iNKQEBR8RyOdb9PJlOUcwSwyqFr+ICdOPdd+nwGdXSBDlSV4xe1/9s1BR/aCgWiN15Wke0PYKNtt
	HEejJ3S+Y2C4Wviflu4tQ7R7bL01rr20C70q6umZvIPT4hKlUMUB0BQPi/IrF5JEdZS3cBxS40ovy
	RmMl++6qkYxrkQXqQgFrO6F03WhgFCaQfMGRHllZs2KjHn7iXk22L4WUQN/keFYL1CxsmBmx6dBqZ
	M1bo1c7shtgRmB6ElujwON6IWJnDz6fQe2QEontwjAOpvnTlfOaIQVwnqVMs0KkGvzOHrJASt/Sfj
	hZJUoN0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblgd-00000005Nhj-3nfg;
	Mon, 22 Jun 2026 20:56:07 +0000
Received: from esa3.hc555-34.eu.iphmx.com ([207.54.77.50])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblga-00000005Ng5-1gKG
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 20:56:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1782161764; x=1813697764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U3Qbo2q57n8CW/e8ejX/AQ02a8k2HgRuSf18/FEiKIg=;
  b=AAz17VWliOxGWMfdBiBh6PeyN6rNXhKDDEZvokR11ssErpCcLUD2q9yh
   W9L/G42BOl60MZmz4DzmK9Arb4RhbIWvY3ix/t5UgO0BAPbf3zDp41aKI
   TON9X8TMjb02i1JHB5JO1Kcnq1b1dXpSy2OhLhFgRFfVhLBrI2SU/MIj6
   l3jcW0gqkCzg0Kbim2jpTKkJwJ7e9lQu2GwYE/YLd6O1kwTVkZdPmal8p
   P1rXiXYZOGnuuYWj6mXBbBiVjBNi+g3zOLIF2ULqMGIQFfHgY972TiILx
   Y6nyTbFCgb3hcQcOmPUiOMnvQf6y3+YFWFZWFTiOzV90rMGRwiSeIIGEf
   g==;
X-CSE-ConnectionGUID: B1yY6297TSGtNIuxNcrDEw==
X-CSE-MsgGUID: zX0820jBTe+xC8ycm15NaA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 23:56:02 +0300
X-CSE-ConnectionGUID: DynWD401ROGLTxzhgvNQsQ==
X-CSE-MsgGUID: irbo1vBcQzSUF2l++TS2TA==
Received: from unknown (HELO epgd034.me-corp.lan) ([10.154.54.3])
  by ces01_data.me-corp.lan with SMTP; 23 Jun 2026 00:01:10 +0300
Received: by epgd034.me-corp.lan (sSMTP sendmail emulation); Mon, 22 Jun 2026 23:56:00 +0300
From: Pnina Feder <pnina.feder@mobileye.com>
To: kexec@lists.infradead.org
Cc: horms@kernel.org,
	Pnina Feder <pnina.feder@mobileye.com>
Subject: [PATCH 02/10] util_lib: Add vmcoreinfo parser and memory reader
Date: Mon, 22 Jun 2026 23:54:40 +0300
Message-ID: <20260622205550.1087163-3-pnina.feder@mobileye.com>
In-Reply-To: <20260622205550.1087163-1-pnina.feder@mobileye.com>
References: <20260622205550.1087163-1-pnina.feder@mobileye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_135604_761931_7E3774C1 
X-CRM114-Status: GOOD (  27.47  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Add the foundational utility libraries for parsing vmcore files:

- vmcore_info: Parser for vmcoreinfo note section. Supports SYMBOL(),
  OFFSET(), SIZE(), NUMBER(), LENGTH() lookups via hash table.
  Provides cached get_page_size()/get_page_shift() accessors.
  Handles plain KEY=VALUE entries like PAGESIZE and OSRELEASE.

- memory: Virtual-to-physical address translation dispatcher and
  readmem() for reading from vmcore via kernel or user virtual
  addresses, or physical addresses.Uses paddr_to_offset() from
  elf_info for physical-to-file-offset mapping.

- vmcore_tasks_util: Shared macros, typedefs, and debug helpers
  used by vmcore_info and memory (debug verbosity levels, type
  accessors, __weak definition).

These files are placed in util_lib/ but are currently only built by
the vmcore_tasks Makefile. Integration into the main util_lib build
can be done later if other tools need them.

Signed-off-by: Pnina Feder <pnina.feder@mobileye.com>
---
 util_lib/include/memory.h            |  37 +++
 util_lib/include/vmcore_info.h       |  72 +++++
 util_lib/include/vmcore_tasks_util.h |  62 +++++
 util_lib/memory.c                    | 327 +++++++++++++++++++++++
 util_lib/vmcore_info.c               | 382 +++++++++++++++++++++++++++
 5 files changed, 880 insertions(+)
 create mode 100644 util_lib/include/memory.h
 create mode 100644 util_lib/include/vmcore_info.h
 create mode 100644 util_lib/include/vmcore_tasks_util.h
 create mode 100644 util_lib/memory.c
 create mode 100644 util_lib/vmcore_info.c

diff --git a/util_lib/include/memory.h b/util_lib/include/memory.h
new file mode 100644
index 00000000..492e0d79
--- /dev/null
+++ b/util_lib/include/memory.h
@@ -0,0 +1,37 @@
+#ifndef _MEMORY_H_
+#define _MEMORY_H_
+
+#include <stdint.h>
+#include <errno.h>
+#include <sys/types.h>
+
+#include "vmcore_info.h"
+
+#define KVADDR             (0x1)
+#define UVADDR             (0x2)
+#define PADDR              (0x3)
+
+/* Page size */
+#define SYS_PAGE_SIZE       (get_page_size())
+#define page_off(vaddr)  ((vaddr) & (SYS_PAGE_SIZE - 1))
+
+/* Set the current user context (mm_pgd) for UVADDR reads */
+void set_context(uint64_t mm_pgd);
+
+/* Get current context */
+uint64_t get_context(void);
+
+/* Arch-overridable functions (weak in memory.c, strong in arch/) */
+uint64_t get_page_offset(void);
+bool is_kvaddr(uint64_t vaddr);
+bool vtop_direct(uint64_t kvaddr, uint64_t *paddr);
+
+/* Arch vtop function pointer for page table walk (set by arch_init) */
+typedef bool (*vtop_fn_t)(uint64_t pgd, uint64_t vaddr, uint64_t *paddr);
+extern vtop_fn_t mem_vtop;
+
+ssize_t readmem(uint64_t addr, void *buffer, size_t size, char *type, int memtype);
+
+int memory_config_init(void);
+
+#endif /* _MEMORY_H_ */
\ No newline at end of file
diff --git a/util_lib/include/vmcore_info.h b/util_lib/include/vmcore_info.h
new file mode 100644
index 00000000..26c92701
--- /dev/null
+++ b/util_lib/include/vmcore_info.h
@@ -0,0 +1,72 @@
+#ifndef VMCORE_INFO_H
+#define VMCORE_INFO_H
+
+#include <stdint.h>
+#include <stdbool.h>
+#include <stddef.h>
+
+/* Maximum number of entries per table */
+#define VMCI_MAX_ENTRIES 256
+#define VMCI_MAX_KEY_LEN 64
+
+/* Single entry in a table */
+struct vmci_entry {
+	char key[VMCI_MAX_KEY_LEN];
+	uint64_t value;
+	bool valid;
+};
+
+/* Table for one type of entries */
+struct vmci_table {
+	struct vmci_entry entries[VMCI_MAX_ENTRIES];
+	int count;
+};
+
+/* All vmcoreinfo tables */
+struct vmcoreinfo {
+	struct vmci_table symbols;   /* SYMBOL entries */
+	struct vmci_table sizes;     /* SIZE entries */
+	struct vmci_table offsets;   /* OFFSET entries */
+	struct vmci_table numbers;   /* NUMBER entries */
+	struct vmci_table lengths;   /* LENGTH entries */
+	char osrelease[256];
+	char pagesize[16];
+	int vmcore_fd;
+	bool initialized;
+};
+
+/* Initialize vmcoreinfo from raw data */
+int vmcoreinfo_init(const char *data, size_t size);
+
+/* Cleanup */
+void vmcoreinfo_cleanup(void);
+
+/* Getters - crash if not found */
+uint64_t SYMBOL(const char *name);
+uint64_t SIZE(const char *name);
+uint64_t OFFSET(const char *name);
+uint64_t NUMBER(const char *name);
+uint64_t LENGTH(const char *name);
+
+/* Check if entry exists */
+bool SYMBOL_EXISTS(const char *name);
+bool SIZE_EXISTS(const char *name);
+bool OFFSET_EXISTS(const char *name);
+bool NUMBER_EXISTS(const char *name);
+bool LENGTH_EXISTS(const char *name);
+
+/* Cached system values */
+unsigned long get_page_size(void);
+unsigned int get_page_shift(void);
+
+/* Get OS release string */
+const char *vmcoreinfo_osrelease(void);
+
+/* Vmcore file descriptor - global access */
+void vmcore_set_fd(int fd);
+int vmcore_fd(void);
+
+/* Debug: dump all entries */
+void vmcoreinfo_dump(void);
+
+#endif /* VMCORE_INFO_H */
\ No newline at end of file
diff --git a/util_lib/include/vmcore_tasks_util.h b/util_lib/include/vmcore_tasks_util.h
new file mode 100644
index 00000000..95c0ad8a
--- /dev/null
+++ b/util_lib/include/vmcore_tasks_util.h
@@ -0,0 +1,62 @@
+#ifndef VMCORE_TASKS_UTIL_H
+#define VMCORE_TASKS_UTIL_H
+
+#include <sys/types.h>
+#include <stdint.h>
+#include <stdio.h>
+
+#ifndef __weak
+#define __weak __attribute__((weak))
+#endif
+
+/* Debug verbosity levels */
+#define DBG_NONE    0
+#define DBG_INFO    1
+#define DBG_VERBOSE 2
+#define DBG_TRACE   3
+#define DBG_MEM     4
+
+extern int debug_level;
+
+#define pr_info(...) \
+	do { \
+		if (debug_level >= DBG_INFO) \
+			fprintf(stderr, "[INFO] " __VA_ARGS__); \
+	} while (0)
+
+#define pr_verbose(...) \
+	do { \
+		if (debug_level >= DBG_VERBOSE) \
+			fprintf(stderr, "[VERBOSE] " __VA_ARGS__); \
+	} while (0)
+
+#define pr_trace(...) \
+	do { \
+		if (debug_level >= DBG_TRACE) \
+			fprintf(stderr, "[TRACE] " __VA_ARGS__); \
+	} while (0)
+
+#define pr_mem(...) \
+	do { \
+		if (debug_level >= DBG_MEM) \
+			fprintf(stderr, "[MEM] " __VA_ARGS__); \
+	} while (0)
+
+#define is_info()    (debug_level >= DBG_INFO)
+#define is_verbose() (debug_level >= DBG_VERBOSE)
+#define is_trace()   (debug_level >= DBG_TRACE)
+#define is_mem()     (debug_level >= DBG_MEM)
+
+typedef unsigned long int ulong;
+typedef unsigned short int ushort;
+typedef unsigned int uint;
+
+#define ULONG(ADDR) *((ulong *)((char *)(ADDR)))
+#define UINT32(ADDR) *((uint32_t *)((char *)(ADDR)))
+#define UINT16(ADDR) *((uint16_t *)((char *)(ADDR)))
+#define UINT64(ADDR) *((uint64_t *)((char *)(ADDR)))
+#define UCHAR(ADDR) *((unsigned char *)((char *)(ADDR)))
+#define VOID_PTR(ADDR) *((void **)((char *)(ADDR)))
+#define UINT(ADDR) *((uint *)((char *)(ADDR)))
+
+#endif /* VMCORE_TASKS_UTIL_H */
diff --git a/util_lib/memory.c b/util_lib/memory.c
new file mode 100644
index 00000000..60986cc4
--- /dev/null
+++ b/util_lib/memory.c
@@ -0,0 +1,327 @@
+#include <stdint.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/param.h>
+
+#include "memory.h"
+#include "vmcore_info.h"
+#include "elf_info.h"
+#include "vmcore_tasks_util.h"
+
+/* Arch vtop function pointer (set by arch_init) */
+vtop_fn_t mem_vtop;
+
+/* Memory layout (from vmcoreinfo) */
+static uint64_t page_offset;           // PAGE_OFFSET
+static uint64_t phys_offset;         // Physical RAM base
+static uint64_t va_pa_offset;          // Linear mapping offset
+    
+static uint64_t number_vmalloc_start;         // VMALLOC_START
+static uint64_t number_vmalloc_end;           // VMALLOC_END
+static uint64_t number_vmemmap_start;         // VMEMMAP_START
+static uint64_t number_vmemmap_end;           // VMEMMAP_END
+static uint64_t number_modules_vaddr;         // MODULES_VADDR
+static uint64_t number_modules_end;           // MODULES_END
+
+static uint64_t number_kernel_link_addr;      // KERNEL_LINK_ADDR (Linux >= 5.13)
+static uint64_t number_va_kernel_pa_offset;   // Kernel VA to PA offset (Linux >= 6.4)
+    
+/* Kernel page table base (from symbol) */
+static uint64_t symbol_swapper_pg_dir;        // Kernel PGD virtual address
+static uint64_t kernel_pgd_paddr;             // Kernel PGD physical address
+
+/* Kernel version for conditional logic */
+static const char *kernel_version;        // e.g., LINUX(5,13,0)
+static uint64_t current_context_pgd = 0;
+
+void set_context(uint64_t mm_pgd)
+{
+	current_context_pgd = mm_pgd;
+}
+
+uint64_t get_context(void)
+{
+	return current_context_pgd;
+}
+
+
+/**
+ * Check if address is in vmalloc/vmemmap/modules region
+ * (requires page table walk)
+ */
+static bool is_vmalloc_addr(uint64_t vaddr)
+{
+	if (number_vmalloc_start &&
+	    vaddr >= number_vmalloc_start && vaddr <= number_vmalloc_end)
+		return true;
+
+	if (number_vmemmap_start &&
+	    vaddr >= number_vmemmap_start && vaddr <= number_vmemmap_end)
+		return true;
+
+	if (number_modules_vaddr &&
+	    vaddr >= number_modules_vaddr && vaddr <= number_modules_end)
+		return true;
+
+	return false;
+}
+
+__weak uint64_t get_page_offset(void)
+{
+	return NUMBER("PAGE_OFFSET");
+}
+
+/* Check if address is a kernel virtual address */
+__weak bool is_kvaddr(uint64_t vaddr)
+{
+	if (is_vmalloc_addr(vaddr))
+		return true;
+	return (vaddr >= page_offset);
+}
+
+/*
+ * Direct translation for linear-mapped addresses (fast path)
+ * No page table walk needed
+ */
+__weak bool vtop_direct(uint64_t kvaddr, uint64_t *paddr)
+{
+	/* 
+	 * Linux >= 5.13 on RISCV: kernel text uses different offset
+	 * Only check if KERNEL_LINK_ADDR exists and address is in that range
+	 */
+	if(number_kernel_link_addr && kvaddr >= number_kernel_link_addr) {
+		*paddr = kvaddr - number_va_kernel_pa_offset;
+		return true;
+	}
+
+	/* Standard linear mapping: VA = PA + PAGE_OFFSET - PHYS_OFFSET */
+ 	*paddr = kvaddr - va_pa_offset;
+
+	return true;
+}
+
+/*
+ * High-level kvaddr to paddr translation
+ * Handles both direct mapping and page table walk
+ */
+static bool kvtop(uint64_t kvaddr, uint64_t *paddr)
+{
+	/* Validate it's a kernel address */
+	if (!is_kvaddr(kvaddr)){
+		fprintf(stderr, "kvtop: Address 0x%llx is not a kernel virtual address\n",
+			(unsigned long long)kvaddr);
+		return false;
+	}
+
+	/* Fast path: direct-mapped address */
+	if (!is_vmalloc_addr(kvaddr)) {
+		return vtop_direct(kvaddr, paddr);
+	}
+
+	/* Slow path: page table walk required */
+	if (!mem_vtop) {
+		fprintf(stderr, "kvtop: mem_vtop function pointer is NULL\n");
+		return false;
+	}
+	return mem_vtop(kernel_pgd_paddr, kvaddr, paddr);
+}
+
+static bool uvtop(uint64_t uvaddr, uint64_t mm_pgd, uint64_t *paddr)
+{
+	uint64_t pgd_paddr;
+	/* Get physical address of process's PGD */
+	if (!kvtop(mm_pgd, &pgd_paddr)) {
+		fprintf(stderr, "uvtop: failed to translate mm_pgd 0x%llx to physical\n",
+			(unsigned long long)mm_pgd);
+		return false;
+	}
+
+	if (!mem_vtop) {
+		fprintf(stderr, "uvtop: mem_vtop function pointer is NULL\n");
+		return false;
+	}
+
+	if (!mem_vtop(pgd_paddr, uvaddr, paddr)) {
+		/* Page not present - this is common for sleeping processes.
+		* The caller (backtrace code) should handle this gracefully.
+		* Only log in debug mode to avoid spam for expected cases.
+		*/
+		pr_trace("uvtop: page table walk failed for user addr 0x%llx (page not present?)\n",
+			 (unsigned long long)uvaddr);
+		return false;
+	}
+
+	return true;
+}
+
+
+/*
+ * Parse vmcoreinfo to get required values
+ * Returns 0 on success, -1 on error
+ */
+int memory_config_init(void)
+{
+	kernel_version = vmcoreinfo_osrelease();
+	page_offset = get_page_offset();
+	
+	/* Physical RAM base - different names on different archs */
+	if (NUMBER_EXISTS("phys_ram_base"))
+		phys_offset = NUMBER("phys_ram_base");
+	else if (NUMBER_EXISTS("PHYS_OFFSET"))
+		phys_offset = NUMBER("PHYS_OFFSET");
+	else
+		phys_offset = 0;  /* x86 and some others start at 0 */
+	
+	if(NUMBER_EXISTS("VMALLOC_START")) {
+		number_vmalloc_start = NUMBER("VMALLOC_START");
+		if (NUMBER_EXISTS("VMALLOC_END"))
+			number_vmalloc_end = NUMBER("VMALLOC_END");
+		else
+			number_vmalloc_end = 0;
+	} else {
+		number_vmalloc_start = 0;
+		number_vmalloc_end = 0;
+	}
+	
+	/* VMEMMAP region - may not exist on all configs */
+	if (NUMBER_EXISTS("VMEMMAP_START")) {
+		number_vmemmap_start = NUMBER("VMEMMAP_START");
+		if (NUMBER_EXISTS("VMEMMAP_END"))
+			number_vmemmap_end = NUMBER("VMEMMAP_END");
+		else
+			number_vmemmap_end = 0;
+	} else {
+		number_vmemmap_start = 0;
+		number_vmemmap_end = 0;
+	}
+	
+	if (NUMBER_EXISTS("KERNEL_LINK_ADDR")) {
+		number_kernel_link_addr = NUMBER("KERNEL_LINK_ADDR");
+		
+		/* va_kernel_pa_offset exists only on linux 6.4+ */
+		if (NUMBER_EXISTS("va_kernel_pa_offset"))
+			number_va_kernel_pa_offset = NUMBER("va_kernel_pa_offset");
+		else
+			number_va_kernel_pa_offset = number_kernel_link_addr - phys_offset;
+	} else {
+		number_kernel_link_addr = 0;
+	}
+
+	/* MODULES region - Linux >= 5.13 has separate, older uses VMALLOC */
+	if (NUMBER_EXISTS("MODULES_VADDR"))
+		number_modules_vaddr = NUMBER("MODULES_VADDR");
+	else
+		number_modules_vaddr = number_vmalloc_start;
+
+	if (NUMBER_EXISTS("MODULES_END"))
+		number_modules_end = NUMBER("MODULES_END");
+	else
+		number_modules_end = number_vmalloc_end;
+
+	symbol_swapper_pg_dir = SYMBOL("swapper_pg_dir");
+
+	/* Calculate va_pa_offset if not directly available */
+	va_pa_offset = page_offset - phys_offset;
+
+	if (!vtop_direct(symbol_swapper_pg_dir, &kernel_pgd_paddr))
+		return -1;
+
+	return 0;
+}
+
+static ssize_t read_phys(uint64_t paddr, void *buffer, size_t size)
+{
+	uint64_t file_offset;
+	ssize_t ret;
+	int fd = vmcore_fd();
+	if (fd < 0) {
+		fprintf(stderr, "read_phys: invalid vmcore fd\n");
+		return -1;
+	}
+	file_offset = paddr_to_offset(paddr);
+
+	/* paddr_to_offset returns (uint64_t)-1 on error */
+	if (file_offset == (uint64_t)-1) {
+		fprintf(stderr, "read_phys: failed to translate paddr 0x%llx to file offset\n",
+	        	(unsigned long long)paddr);
+		return -1;
+	}
+
+	pr_mem("read_phys: paddr=0x%llx -> file_offset=0x%llx size=%zu\n",
+	       (unsigned long long)paddr, (unsigned long long)file_offset, size);
+	
+	ret = pread(fd, buffer, size, file_offset);
+
+	if (ret < 0 || (size_t)ret != size) {
+		fprintf(stderr, "read_phys: Failed to read %zu bytes from paddr 0x%llx: %s\n",
+			size, (unsigned long long)paddr, strerror(errno));
+		return -1;
+	}
+	return ret;
+}
+
+ssize_t readmem(uint64_t addr, void *buffer, size_t size, char *type, int memtype)
+{
+	uint64_t paddr;
+	ssize_t ret;
+	size_t bytes_read = 0;
+	size_t chunk_size;
+	pr_mem("readmem: Reading %zu bytes from addr 0x%llx (%s)\n",
+	       size, (unsigned long long)addr, type ? type : "unknown");
+	if (!buffer) {
+		fprintf(stderr, "readmem: NULL buffer\n");
+		return -1;
+	}
+	if (size == 0) {
+		fprintf(stderr, "readmem: zero size requested\n");
+		return -1;
+	}
+
+	/* Direct physical address read */
+	if(memtype == PADDR){
+		ret = read_phys(addr, buffer, size);
+		return ret;
+	}
+
+	while(bytes_read < size) {
+		chunk_size =  MIN(size - bytes_read, SYS_PAGE_SIZE - page_off(addr + bytes_read));
+		/* Convert virtual address to paddr */
+		switch (memtype)
+		{
+		case KVADDR:
+			if (!kvtop(addr + bytes_read, &paddr)) {
+				fprintf(stderr, "readmem: kvtop failed for addr 0x%llx\n", (unsigned long long)(addr + bytes_read));
+				return -1;
+			}
+			break;
+		case UVADDR:
+			if (!current_context_pgd) {
+				fprintf(stderr, "readmem: mm_pgd is zero for UVADDR read\n");
+				return -1;
+			}
+			if (!uvtop(addr + bytes_read, current_context_pgd, &paddr)) {
+				/* uvtop already logged in debug mode.
+				 * For user addresses, page-not-present is common
+				 * for sleeping processes - caller should handle gracefully.
+				 */
+				return -1;
+			}
+			break;
+		default:
+			fprintf(stderr, "readmem: Unknown memory type %d\n", memtype);
+			return -1;
+			break;
+		}
+		ret = read_phys(paddr, (char *)buffer + bytes_read, chunk_size);
+		if (ret < 0 || (size_t)ret != chunk_size) {
+			fprintf(stderr, "readmem: Failed to read memory at addr 0x%llx (read %zd, expected %zu)\n",
+				(unsigned long long)(addr + bytes_read), ret, chunk_size);
+			return -1;
+		}
+		bytes_read += ret;
+	}
+	return (ssize_t)bytes_read;
+}
diff --git a/util_lib/vmcore_info.c b/util_lib/vmcore_info.c
new file mode 100644
index 00000000..a1e1d51f
--- /dev/null
+++ b/util_lib/vmcore_info.c
@@ -0,0 +1,382 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <ctype.h>
+
+#include "vmcore_info.h"
+#include "vmcore_tasks_util.h"
+
+/* Global vmcoreinfo instance */
+static struct vmcoreinfo vmci = {0};
+
+/* Cached page size — read once from vmcoreinfo */
+static unsigned long cached_page_size = 0;
+static unsigned int cached_page_shift = 0;
+
+unsigned long get_page_size(void)
+{
+	if (cached_page_size)
+		return cached_page_size;
+
+	if (vmci.pagesize[0] != '\0') {
+		cached_page_size = strtoul(vmci.pagesize, NULL, 0);
+	}
+
+	if (cached_page_size == 0 || (cached_page_size & (cached_page_size - 1)) != 0) {
+		fprintf(stderr, "Warning: invalid PAGESIZE='%s', defaulting to 4096\n",
+			vmci.pagesize);
+		cached_page_size = 4096;
+	}
+
+	unsigned long tmp = cached_page_size;
+	while (tmp > 1) {
+		tmp >>= 1;
+		cached_page_shift++;
+	}
+
+	return cached_page_size;
+}
+
+unsigned int get_page_shift(void)
+{
+	if (!cached_page_size)
+		get_page_size();  /* ensure initialized */
+	return cached_page_shift;
+}
+
+/* Simple hash function for faster lookups */
+static unsigned int hash_key(const char *key)
+{
+	unsigned int hash = 5381;
+	int c;
+	while ((c = *key++))
+		hash = ((hash << 5) + hash) + c;
+	return hash % VMCI_MAX_ENTRIES;
+}
+
+/* Add entry to a table */
+static int table_add(struct vmci_table *table, const char *key, uint64_t value)
+{
+	if (table->count >= VMCI_MAX_ENTRIES) {
+		fprintf(stderr, "vmcoreinfo: table full, cannot add '%s'\n", key);
+		return -1;
+	}
+
+	/* Use hash for initial position, linear probe on collision */
+	unsigned int idx = hash_key(key);
+	int attempts = 0;
+	
+	while (table->entries[idx].valid && attempts < VMCI_MAX_ENTRIES) {
+		/* Check for duplicate key */
+		if (strcmp(table->entries[idx].key, key) == 0) {
+			/* Update existing entry */
+			table->entries[idx].value = value;
+			return 0;
+		}
+		idx = (idx + 1) % VMCI_MAX_ENTRIES;
+		attempts++;
+	}
+
+	if (attempts >= VMCI_MAX_ENTRIES) {
+		fprintf(stderr, "vmcoreinfo: hash table full\n");
+		return -1;
+	}
+
+	if (strlen(key) >= VMCI_MAX_KEY_LEN) {
+		fprintf(stderr, "vmcoreinfo: key '%s' truncated to %d chars\n",
+			key, VMCI_MAX_KEY_LEN - 1);
+	}
+	strncpy(table->entries[idx].key, key, VMCI_MAX_KEY_LEN - 1);
+	table->entries[idx].key[VMCI_MAX_KEY_LEN - 1] = '\0';
+	table->entries[idx].value = value;
+	table->entries[idx].valid = true;
+	table->count++;
+
+	return 0;
+}
+
+/* Lookup entry in a table */
+static struct vmci_entry *table_lookup(struct vmci_table *table, const char *key)
+{
+	unsigned int idx = hash_key(key);
+	int attempts = 0;
+
+	while (attempts < VMCI_MAX_ENTRIES) {
+		if (!table->entries[idx].valid)
+			return NULL; // empty slot means key was never inserted
+		if (strcmp(table->entries[idx].key, key) == 0)
+			return &table->entries[idx];
+		idx = (idx + 1) % VMCI_MAX_ENTRIES;
+		attempts++;
+	}
+
+	return NULL;
+}
+
+/* Parse a single line of vmcoreinfo */
+static void parse_line(char *line)
+{
+	char *eq = strchr(line, '=');
+	if (!eq)
+		return;
+
+	*eq = '\0';
+	char *key_part = line;
+	char *value_str = eq + 1;
+
+	/* Trim whitespace from value */
+	while (*value_str && isspace(*value_str))
+		value_str++;
+
+	/* Detect type and extract key */
+	if (strncmp(key_part, "SYMBOL(", 7) == 0) {
+		char *end = strchr(key_part + 7, ')');
+		if (end) {
+			*end = '\0';
+			uint64_t val = strtoull(value_str, NULL, 16);
+			table_add(&vmci.symbols, key_part + 7, val);
+		}
+	}
+	else if (strncmp(key_part, "SIZE(", 5) == 0) {
+		char *end = strchr(key_part + 5, ')');
+		if (end) {
+			*end = '\0';
+			uint64_t val = strtoull(value_str, NULL, 10);
+			table_add(&vmci.sizes, key_part + 5, val);
+		}
+	}
+	else if (strncmp(key_part, "OFFSET(", 7) == 0) {
+		char *end = strchr(key_part + 7, ')');
+		if (end) {
+			*end = '\0';
+			uint64_t val = strtoull(value_str, NULL, 10);
+			table_add(&vmci.offsets, key_part + 7, val);
+		}
+	}
+	else if (strncmp(key_part, "NUMBER(", 7) == 0) {
+		char *end = strchr(key_part + 7, ')');
+		if (end) {
+			*end = '\0';
+			/* NUMBER can be hex or decimal */
+			uint64_t val;
+			if (strncmp(value_str, "0x", 2) == 0 || strncmp(value_str, "0X", 2) == 0)
+				val = strtoull(value_str, NULL, 16);
+			else
+				val = strtoull(value_str, NULL, 0); /* auto-detect base */
+			table_add(&vmci.numbers, key_part + 7, val);
+		}
+	}
+	else if (strncmp(key_part, "LENGTH(", 7) == 0) {
+		char *end = strchr(key_part + 7, ')');
+		if (end) {
+			*end = '\0';
+			uint64_t val = strtoull(value_str, NULL, 10);
+			table_add(&vmci.lengths, key_part + 7, val);
+		}
+	}
+	else if (strncmp(key_part, "OSRELEASE", 9) == 0) {
+		strncpy(vmci.osrelease, value_str, sizeof(vmci.osrelease) - 1);
+		vmci.osrelease[sizeof(vmci.osrelease) - 1] = '\0';
+	}
+	else if (strncmp(key_part, "PAGESIZE", 8) == 0) {
+		strncpy(vmci.pagesize, value_str, sizeof(vmci.pagesize) - 1);
+		vmci.pagesize[sizeof(vmci.pagesize) - 1] = '\0';
+	}
+	else if (strcmp(key_part, "CRASHTIME") == 0) {
+		long long sval = strtoll(value_str, NULL, 10);
+		table_add(&vmci.numbers, "CRASHTIME", (uint64_t)(int64_t)sval);
+	}
+}
+
+int vmcoreinfo_init(const char *data, size_t size)
+{
+	if (!data || size == 0)
+		return -1;
+
+	if (vmci.initialized) {
+		fprintf(stderr, "vmcoreinfo: already initialized, reinitializing\n");
+		return -1;
+	}
+
+	/* Clear existing data */
+	memset(&vmci, 0, sizeof(vmci));
+
+	/* Make a mutable copy */
+	char *buf = malloc(size + 1);
+	if (!buf)
+		return -1;
+
+	memcpy(buf, data, size);
+	buf[size] = '\0';
+
+	/* Parse line by line */
+	char *line = buf;
+	char *end = buf + size;
+
+	while (line < end) {
+		/* Find end of line */
+		char *eol = strchr(line, '\n');
+		if (eol)
+			*eol = '\0';
+		else
+			eol = end - 1;
+
+		/* Skip empty lines */
+		if (*line)
+			parse_line(line);
+
+		line = eol + 1;
+	}
+
+	free(buf);
+	vmci.initialized = true;
+
+	return 0;
+}
+
+void vmcoreinfo_cleanup(void)
+{
+	memset(&vmci, 0, sizeof(vmci));
+}
+
+/* Getter implementations - crash if not found */
+uint64_t SYMBOL(const char *name)
+{
+	struct vmci_entry *e = table_lookup(&vmci.symbols, name);
+	if (!e) {
+		fprintf(stderr, "FATAL: SYMBOL '%s' not found in vmcoreinfo\n", name);
+		abort();
+	}
+	return e->value;
+}
+
+uint64_t SIZE(const char *name)
+{
+	struct vmci_entry *e = table_lookup(&vmci.sizes, name);
+	if (!e) {
+		fprintf(stderr, "FATAL: SIZE '%s' not found in vmcoreinfo\n", name);
+		abort();
+	}
+	return e->value;
+}
+
+uint64_t OFFSET(const char *name)
+{
+	struct vmci_entry *e = table_lookup(&vmci.offsets, name);
+	if (!e) {
+		fprintf(stderr, "FATAL: OFFSET '%s' not found in vmcoreinfo\n", name);
+		abort();
+	}
+	return e->value;
+}
+
+uint64_t NUMBER(const char *name)
+{
+	struct vmci_entry *e = table_lookup(&vmci.numbers, name);
+	if (!e) {
+		fprintf(stderr, "FATAL: NUMBER '%s' not found in vmcoreinfo\n", name);
+		abort();
+	}
+	return e->value;
+}
+
+uint64_t LENGTH(const char *name)
+{
+	struct vmci_entry *e = table_lookup(&vmci.lengths, name);
+	if (!e) {
+		fprintf(stderr, "FATAL: LENGTH '%s' not found in vmcoreinfo\n", name);
+		abort();
+	}
+	return e->value;
+}
+
+/* Existence checks */
+bool SYMBOL_EXISTS(const char *name)
+{
+	return table_lookup(&vmci.symbols, name) != NULL;
+}
+
+bool SIZE_EXISTS(const char *name)
+{
+	return table_lookup(&vmci.sizes, name) != NULL;
+}
+
+bool OFFSET_EXISTS(const char *name)
+{
+	return table_lookup(&vmci.offsets, name) != NULL;
+}
+
+bool NUMBER_EXISTS(const char *name)
+{
+	return table_lookup(&vmci.numbers, name) != NULL;
+}
+
+bool LENGTH_EXISTS(const char *name)
+{
+	return table_lookup(&vmci.lengths, name) != NULL;
+}
+
+const char *vmcoreinfo_osrelease(void)
+{
+	if (vmci.osrelease[0] == '\0') {
+		fprintf(stderr, "FATAL: OSRELEASE not found in vmcoreinfo\n");
+		abort();
+	}
+	return vmci.osrelease;
+}
+
+/* Debug helper */
+void vmcoreinfo_dump(void)
+{
+	int i;
+
+	pr_trace("=== VMCOREINFO DUMP ===\n");
+	pr_trace("OSRELEASE: %s\n", vmci.osrelease);
+	pr_trace("PAGESIZE: %s\n", vmci.pagesize);
+	pr_trace("SYMBOLS (%d entries):\n", vmci.symbols.count);
+
+	for (i = 0; i < VMCI_MAX_ENTRIES; i++) {
+		if (vmci.symbols.entries[i].valid)
+			pr_trace("  %s = 0x%llx\n", vmci.symbols.entries[i].key,
+			       (unsigned long long) vmci.symbols.entries[i].value);
+	}
+
+	pr_trace("SIZES (%d entries):\n", vmci.sizes.count);
+	for (i = 0; i < VMCI_MAX_ENTRIES; i++) {
+		if (vmci.sizes.entries[i].valid)
+			pr_trace("  %s = %llu\n", vmci.sizes.entries[i].key,
+			       (unsigned long long) vmci.sizes.entries[i].value);
+	}
+
+	pr_trace("OFFSETS (%d entries):\n", vmci.offsets.count);
+	for (i = 0; i < VMCI_MAX_ENTRIES; i++) {
+		if (vmci.offsets.entries[i].valid)
+			pr_trace("  %s = %llu\n", vmci.offsets.entries[i].key,
+			       (unsigned long long) vmci.offsets.entries[i].value);
+	}
+
+	pr_trace("NUMBERS (%d entries):\n", vmci.numbers.count);
+	for (i = 0; i < VMCI_MAX_ENTRIES; i++) {
+		if (vmci.numbers.entries[i].valid)
+			pr_trace("  %s = 0x%llx\n", vmci.numbers.entries[i].key,
+			       (unsigned long long) vmci.numbers.entries[i].value);
+	}
+
+	pr_trace("LENGTHS (%d entries):\n", vmci.lengths.count);
+	for (i = 0; i < VMCI_MAX_ENTRIES; i++) {
+		if (vmci.lengths.entries[i].valid)
+			pr_trace("  %s = %llu\n", vmci.lengths.entries[i].key,
+			       (unsigned long long)vmci.lengths.entries[i].value);
+	}
+}
+
+/* Vmcore file descriptor management */
+void vmcore_set_fd(int fd)
+{
+	vmci.vmcore_fd = fd;
+}
+
+int vmcore_fd(void)
+{
+	return vmci.vmcore_fd;
+}
\ No newline at end of file
-- 
2.43.0


