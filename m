Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XOI7i-0001GZ-VS
 for kexec@lists.infradead.org; Mon, 01 Sep 2014 03:17:43 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v6 5/8] prepare the dump loads for kcore analysis
Date: Mon,  1 Sep 2014 11:15:37 +0800
Message-Id: <1409541340-2719-6-git-send-email-bhe@redhat.com>
In-Reply-To: <1409541340-2719-1-git-send-email-bhe@redhat.com>
References: <1409541340-2719-1-git-send-email-bhe@redhat.com>
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
To: kexec@lists.infradead.org
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, Baoquan He <bhe@redhat.com>, vgoyal@redhat.com

In kcore, only  "System Ram" and "kernel text" program segments
are needed. And to be more precise, exclude the crashkernel
memory range.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86_64.c  |   6 +--
 elf_info.c     | 140 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 elf_info.h     |   1 +
 makedumpfile.h |   8 ++++
 4 files changed, 152 insertions(+), 3 deletions(-)

diff --git a/arch/x86_64.c b/arch/x86_64.c
index 771d457..4788f55 100644
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -20,7 +20,7 @@
 #include "../makedumpfile.h"
 
 int
-is_vmalloc_addr(ulong vaddr)
+is_vmalloc_addr_x86_64(ulong vaddr)
 {
 	/*
 	 *  vmalloc, virtual memmap, and module space as VMALLOC space.
@@ -56,7 +56,7 @@ get_phys_base_x86_64(void)
 
 	for (i = 0; get_pt_load(i, &phys_start, NULL, &virt_start, NULL); i++) {
 		if ((virt_start >= __START_KERNEL_map) &&
-		    !(is_vmalloc_addr(virt_start))) {
+		    !(is_vmalloc_addr_x86_64(virt_start))) {
 
 			info->phys_base = phys_start -
 			    (virt_start & ~(__START_KERNEL_map));
@@ -281,7 +281,7 @@ vaddr_to_paddr_x86_64(unsigned long vaddr)
 	else
 		phys_base = 0;
 
-	if (is_vmalloc_addr(vaddr)) {
+	if (is_vmalloc_addr_x86_64(vaddr)) {
 		if ((paddr = vtop4_x86_64(vaddr)) == NOT_PADDR) {
 			ERRMSG("Can't convert a virtual address(%lx) to " \
 			    "physical address.\n", vaddr);
diff --git a/elf_info.c b/elf_info.c
index d50124d..4dfdf22 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -777,6 +777,146 @@ get_elf_loads(int fd, char *filename)
 	return TRUE;
 }
 
+static int exclude_segment(struct pt_load_segment **pt_loads, unsigned int	*num_pt_loads, uint64_t start, uint64_t end)
+{
+        int i, j, tidx = -1;
+	unsigned long long	vstart, vend, kvstart, kvend;
+        struct pt_load_segment temp_seg = {0};
+	kvstart = (ulong)start | PAGE_OFFSET;
+	kvend = (ulong)end | PAGE_OFFSET;
+	unsigned long size;
+
+        for (i = 0; i < (*num_pt_loads); i++) {
+                vstart = (*pt_loads)[i].virt_start;
+                vend = (*pt_loads)[i].virt_end;
+                if (kvstart <  vend && kvend > vstart) {
+                        if (kvstart != vstart && kvend != vend) {
+				/* Split load segment */
+				temp_seg.phys_start = end +1;
+				temp_seg.phys_end = (*pt_loads)[i].phys_end;
+				temp_seg.virt_start = kvend + 1;
+				temp_seg.virt_end = vend;
+				temp_seg.file_offset = (*pt_loads)[i].file_offset + temp_seg.virt_start - (*pt_loads)[i].virt_start;
+
+				(*pt_loads)[i].virt_end = kvstart - 1;
+				(*pt_loads)[i].phys_end =  start -1;
+
+				tidx = i+1;
+                        } else if (kvstart != vstart) {
+				(*pt_loads)[i].phys_end = start - 1;
+				(*pt_loads)[i].virt_end = kvstart - 1;
+                        } else {
+				(*pt_loads)[i].phys_start = end + 1;
+				(*pt_loads)[i].virt_start = kvend + 1;
+                        }
+                }
+        }
+        /* Insert split load segment, if any. */
+	if (tidx >= 0) {
+		size = (*num_pt_loads + 1) * sizeof((*pt_loads)[0]);
+		(*pt_loads) = realloc((*pt_loads), size);
+		if  (!(*pt_loads) ) {
+		    ERRMSG("Cannot realloc %ld bytes: %s\n",
+		            size + 0UL, strerror(errno));
+			exit(1);
+		}
+		for (j = (*num_pt_loads - 1); j >= tidx; j--)
+		        (*pt_loads)[j+1] = (*pt_loads)[j];
+		(*pt_loads)[tidx] = temp_seg;
+		(*num_pt_loads)++;
+        }
+        return 0;
+}
+
+static int
+process_dump_load(struct pt_load_segment	*pls)
+{
+	unsigned long long paddr;
+
+	paddr = vaddr_to_paddr(pls->virt_start);
+	pls->phys_start  = paddr;
+	pls->phys_end    = paddr + (pls->virt_end - pls->virt_start);
+	DEBUG_MSG("process_dump_load\n");
+	DEBUG_MSG("  phys_start : %llx\n", pls->phys_start);
+	DEBUG_MSG("  phys_end   : %llx\n", pls->phys_end);
+	DEBUG_MSG("  virt_start : %llx\n", pls->virt_start);
+	DEBUG_MSG("  virt_end   : %llx\n", pls->virt_end);
+
+	return TRUE;
+}
+
+int get_kcore_dump_loads()
+{
+	struct pt_load_segment	*pls;
+	int i, j, loads=0;
+
+	for (i = 0; i < num_pt_loads; ++i) {
+		struct pt_load_segment *p = &pt_loads[i];
+		if (is_vmalloc_addr(p->virt_start))
+			continue;
+		loads++;
+	}
+
+	if (!loads) {
+		ERRMSG("Can't get the correct number of PT_LOAD. %s\n",
+		    strerror(errno));
+		return FALSE;
+	}
+
+	pls = calloc(sizeof(struct pt_load_segment), loads);
+	if (pls == NULL) {
+		ERRMSG("Can't allocate memory for the PT_LOAD. %s\n",
+		    strerror(errno));
+		return FALSE;
+	}
+
+	for (i = 0, j=0; i < num_pt_loads; ++i) {
+		struct pt_load_segment *p = &pt_loads[i];
+		if (is_vmalloc_addr(p->virt_start))
+			continue;
+		if (j >= loads)
+			return FALSE;
+
+		if (j == 0) {
+			offset_pt_load_memory = p->file_offset;
+			if (offset_pt_load_memory == 0) {
+				ERRMSG("Can't get the offset of page data.\n");
+				return FALSE;
+			}
+		}
+
+		pls[j] = *p;
+		process_dump_load(&pls[j]);
+		j++;
+	}
+
+	free(pt_loads);
+	pt_loads = pls;
+	num_pt_loads = loads;
+
+	for (i=0; i<crash_reserved_mem_nr; i++)
+	{
+		exclude_segment(&pt_loads, &num_pt_loads, crash_reserved_mem[i].start, crash_reserved_mem[i].end);
+	}
+
+	max_file_offset = 0;
+	for (i = 0; i < num_pt_loads; ++i) {
+		struct pt_load_segment *p = &pt_loads[i];
+		max_file_offset = MAX(max_file_offset,
+				      p->file_offset + p->phys_end - p->phys_start);
+	}
+
+	for (i = 0; i < num_pt_loads; ++i) {
+		struct pt_load_segment *p = &pt_loads[i];
+		DEBUG_MSG("LOAD (%d)\n", i);
+		DEBUG_MSG("  phys_start : %llx\n", p->phys_start);
+		DEBUG_MSG("  phys_end   : %llx\n", p->phys_end);
+		DEBUG_MSG("  virt_start : %llx\n", p->virt_start);
+		DEBUG_MSG("  virt_end   : %llx\n", p->virt_end);
+	}
+
+	return TRUE;
+}
 
 /*
  * Get ELF information about /proc/vmcore.
diff --git a/elf_info.h b/elf_info.h
index 3ce0138..ba27fdf 100644
--- a/elf_info.h
+++ b/elf_info.h
@@ -46,6 +46,7 @@ int get_elf_info(int fd, char *filename);
 void free_elf_info(void);
 int get_elf_loads(int fd, char *filename);
 int set_kcore_vmcoreinfo(uint64_t vmcoreinfo_addr, uint64_t vmcoreinfo_len);
+int get_kcore_dump_loads();
 
 int is_elf64_memory(void);
 int is_xen_memory(void);
diff --git a/makedumpfile.h b/makedumpfile.h
index ed584af..e83bd95 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -765,6 +765,7 @@ unsigned long long vaddr_to_paddr_arm(unsigned long vaddr);
 #define get_machdep_info()	get_machdep_info_arm()
 #define get_versiondep_info()	TRUE
 #define vaddr_to_paddr(X)	vaddr_to_paddr_arm(X)
+#define is_vmalloc_addr(X)	TRUE
 #endif /* arm */
 
 #ifdef __x86__
@@ -775,9 +776,11 @@ unsigned long long vaddr_to_paddr_x86(unsigned long vaddr);
 #define get_machdep_info()	get_machdep_info_x86()
 #define get_versiondep_info()	get_versiondep_info_x86()
 #define vaddr_to_paddr(X)	vaddr_to_paddr_x86(X)
+#define is_vmalloc_addr(X)	TRUE
 #endif /* x86 */
 
 #ifdef __x86_64__
+int is_vmalloc_addr_x86_64(ulong vaddr);
 int get_phys_base_x86_64(void);
 int get_machdep_info_x86_64(void);
 int get_versiondep_info_x86_64(void);
@@ -786,6 +789,7 @@ unsigned long long vaddr_to_paddr_x86_64(unsigned long vaddr);
 #define get_machdep_info()	get_machdep_info_x86_64()
 #define get_versiondep_info()	get_versiondep_info_x86_64()
 #define vaddr_to_paddr(X)	vaddr_to_paddr_x86_64(X)
+#define is_vmalloc_addr(X)	is_vmalloc_addr_x86_64(X)
 #endif /* x86_64 */
 
 #ifdef __powerpc64__ /* powerpc64 */
@@ -796,6 +800,7 @@ unsigned long long vaddr_to_paddr_ppc64(unsigned long vaddr);
 #define get_machdep_info()	get_machdep_info_ppc64()
 #define get_versiondep_info()	get_versiondep_info_ppc64()
 #define vaddr_to_paddr(X)	vaddr_to_paddr_ppc64(X)
+#define is_vmalloc_addr(X)	TRUE
 #endif          /* powerpc64 */
 
 #ifdef __powerpc32__ /* powerpc32 */
@@ -805,6 +810,7 @@ unsigned long long vaddr_to_paddr_ppc(unsigned long vaddr);
 #define get_machdep_info()	get_machdep_info_ppc()
 #define get_versiondep_info()	TRUE
 #define vaddr_to_paddr(X)	vaddr_to_paddr_ppc(X)
+#define is_vmalloc_addr(X)	TRUE
 #endif          /* powerpc32 */
 
 #ifdef __s390x__ /* s390x */
@@ -814,6 +820,7 @@ unsigned long long vaddr_to_paddr_s390x(unsigned long vaddr);
 #define get_machdep_info()	get_machdep_info_s390x()
 #define get_versiondep_info()	TRUE
 #define vaddr_to_paddr(X)	vaddr_to_paddr_s390x(X)
+#define is_vmalloc_addr(X)	TRUE
 #endif          /* s390x */
 
 #ifdef __ia64__ /* ia64 */
@@ -825,6 +832,7 @@ unsigned long long vaddr_to_paddr_ia64(unsigned long vaddr);
 #define get_versiondep_info()	TRUE
 #define vaddr_to_paddr(X)	vaddr_to_paddr_ia64(X)
 #define VADDR_REGION(X)		(((unsigned long)(X)) >> REGION_SHIFT)
+#define is_vmalloc_addr(X)	TRUE
 #endif          /* ia64 */
 
 typedef unsigned long long mdf_pfn_t;
-- 
1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
