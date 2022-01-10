From: Frank van der Linden <fllinden@amazon.com>
Date: Mon, 10 Jan 2022 21:08:07 +0000
Subject: [PATCH 1/3] memblock: define functions to set the usable memory range
In-Reply-To: <20220110210809.3528-1-fllinden@amazon.com>
References: <20220110210809.3528-1-fllinden@amazon.com>
Message-ID: <20220110210809.3528-2-fllinden@amazon.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Some architectures might limit the usable memory range based
on a firmware property, like "linux,usable-memory-range"
for ARM crash kernels. This limit needs to be enforced after
firmware memory map processing has been done, which might be
e.g. FDT or EFI, or both.

Define an interface for it that is firmware type agnostic.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 include/linux/memblock.h |  2 ++
 mm/memblock.c            | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 34de69b3b8ba..6128efa50d33 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -481,6 +481,8 @@ phys_addr_t memblock_reserved_size(void);
 phys_addr_t memblock_start_of_DRAM(void);
 phys_addr_t memblock_end_of_DRAM(void);
 void memblock_enforce_memory_limit(phys_addr_t memory_limit);
+void memblock_set_usable_range(phys_addr_t base, phys_addr_t size);
+void memblock_enforce_usable_range(void);
 void memblock_cap_memory_range(phys_addr_t base, phys_addr_t size);
 void memblock_mem_limit_remove_map(phys_addr_t limit);
 bool memblock_is_memory(phys_addr_t addr);
diff --git a/mm/memblock.c b/mm/memblock.c
index 5096500b2647..cb961965f3ad 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -101,6 +101,7 @@ unsigned long max_low_pfn;
 unsigned long min_low_pfn;
 unsigned long max_pfn;
 unsigned long long max_possible_pfn;
+phys_addr_t usable_start, usable_size;
 
 static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
 static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_RESERVED_REGIONS] __initdata_memblock;
@@ -1715,6 +1716,42 @@ void __init memblock_cap_memory_range(phys_addr_t base, phys_addr_t size)
 			base + size, PHYS_ADDR_MAX);
 }
 
+/**
+ * memblock_set_usable_range - set usable memory range
+ * @base: physical address that is the start of the range
+ * @size: size of the range.
+ *
+ * Used when a firmware property limits the range of usable
+ * memory, like for the linux,usable-memory-range property
+ * used by ARM crash kernels.
+ */
+void __init memblock_set_usable_range(phys_addr_t base, phys_addr_t size)
+{
+	usable_start = base;
+	usable_size = size;
+}
+
+/**
+ * memblock_enforce_usable_range - cap memory ranges to usable range
+ *
+ * Some architectures call this during boot after firmware memory ranges
+ * have been scanned, to make sure they fall within the usable range
+ * set by memblock_set_usable_range.
+ *
+ * This may be called more than once if there are multiple firmware sources
+ * for memory ranges.
+ *
+ * Avoid "no memory registered" warning - the warning itself is
+ * useful, but we know this can be called with no registered
+ * memory (e.g. when the synthetic DT for the crash kernel has
+ * been parsed on EFI arm64 systems).
+ */
+void __init memblock_enforce_usable_range(void)
+{
+	if (memblock_memory->total_size)
+		memblock_cap_memory_range(usable_start, usable_size);
+}
+
 void __init memblock_mem_limit_remove_map(phys_addr_t limit)
 {
 	phys_addr_t max_addr;
-- 
2.32.0


