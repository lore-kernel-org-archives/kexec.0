From: Sourabh Jain <sourabhjain@linux.ibm.com>
Date: Mon, 21 Mar 2022 13:34:17 +0530
Subject: [RFC v3 PATCH 0/5] In kernel handling of CPU hotplug events for crash
 kernel
Message-ID: <20220321080422.56255-1-sourabhjain@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

This patch series implements the crash hotplug handler on PowerPC introduced
by https://lkml.org/lkml/2022/3/3/674 patch series.


The Problem:
============
Post hotplug/DLPAR events the capture kernel holds stale information about the
system. Dump collection with stale capture kernel might end up in dump capture
failure or an inaccurate dump collection.


Existing solution:
==================
The existing solution to keep the capture kernel up-to-date is observe the
hotplug event via udev rule and trigger a full capture kernel reload post
hotplug event. 

Shortcomings:
------------------------------------------------
- Leaves a window where kernel crash might not lead to successful dump
  collection.
- Reloading all kexec components for each hotplug is inefficient. Since only
  one or two kexec components need to be updated due to hotplug event reloading
  all kexec component is redundant.
- udev rules are prone to races if hotplug events are frequent.

More about issues with an existing solution is posted here:
 - https://lkml.org/lkml/2020/12/14/532
 - https://lists.ozlabs.org/pipermail/linuxppc-dev/2022-February/240254.html

Proposed Solution:
==================
Instead of reloading all kexec segments on hotplug event, this patch series
focuses on updating only the relevant kexec segment. Once the kexec
segments are loaded in the kernel reserved area then an arch-specific hotplug handler
will update the relevant kexec segment based on hotplug event type.

As mentioned above this patch series implemented a PowerPC crash hotplug
handler for the CPU. The crash hotplug handler memory is in our TODO list.


A couple of minor changes are required to realize the benefit of the patch
series:

- disalble the udev rule:

  comment out the below line in kdump udev rule file:
  RHEL: /usr/lib/udev/rules.d/98-kexec.rules
  # SUBSYSTEM=="cpu", ACTION=="online", GOTO="kdump_reload_cpu"

- kexec tool needs to be updated with patch for kexec_load system call
  to work (not needed if -s option is used during kexec panic load):

---
diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index 695b8b0..1dc6490 100644
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -45,6 +45,29 @@ uint64_t initrd_base, initrd_size;
 unsigned char reuse_initrd = 0;
 const char *ramdisk;
 
+#define MAX_CORE 256
+#define PER_CORE_NODE_SIZE 1500
+
+/**
+ * get_crash_fdt_mem_sz() - calcuate mem size for crash kernel FDT
+ * @fdt: pointer to crash kernel FDT
+ *
+ * Calculate the buffer space needed to add more CPU nodes in FDT after
+ * capture kenrel load due to hot add events.
+ *
+ * Some assumption are made to calculate the additional buffer size needed
+ * to accommodate future hot add CPUs to the crash FDT. The maximum core count
+ * in the system would not go beyond MAX_CORE and memory needed to store per core
+ * date in FDT is PER_CORE_NODE_SIZE.
+ *
+ * Certainly MAX_CORE count can be replaced with possible core count and
+ * PER_CORE_NODE_SIZE to some standard value instead of randomly observed
+ * core size value on Power9 LPAR.
+ */
+static unsigned int get_crash_fdt_mem_sz(void *fdt) {
+	return fdt_totalsize(fdt) + (PER_CORE_NODE_SIZE * MAX_CORE);
+}
+
 int elf_ppc64_probe(const char *buf, off_t len)
 {
 	struct mem_ehdr ehdr;
@@ -179,6 +202,7 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	uint64_t max_addr, hole_addr;
 	char *seg_buf = NULL;
 	off_t seg_size = 0;
+	unsigned int mem_sz = 0;
 	struct mem_phdr *phdr;
 	size_t size;
 #ifdef NEED_RESERVE_DTB
@@ -329,7 +353,13 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	if (result < 0)
 		return result;
 
-	my_dt_offset = add_buffer(info, seg_buf, seg_size, seg_size,
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		mem_sz = get_crash_fdt_mem_sz((void *)seg_buf);
+		fdt_set_totalsize(seg_buf, mem_sz);
+		info->fdt_index = info->nr_segments;
+	}
+
+	my_dt_offset = add_buffer(info, seg_buf, seg_size, mem_sz,
 				0, 0, max_addr, -1);
 
 #ifdef NEED_RESERVE_DTB
diff --git a/kexec/kexec.c b/kexec/kexec.c
index f63b36b..846b1a8 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -672,6 +672,9 @@ static void update_purgatory(struct kexec_info *info)
 		if (info->segment[i].mem == (void *)info->rhdr.rel_addr) {
 			continue;
 		}
+		if (info->fdt_index == i)
+			continue;
+
 		sha256_update(&ctx, info->segment[i].buf,
 			      info->segment[i].bufsz);
 		nullsz = info->segment[i].memsz - info->segment[i].bufsz;
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 595dd68..0906a1b 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -169,6 +169,7 @@ struct kexec_info {
 	int command_line_len;
 
 	int skip_checks;
+       // Given that we might need to update mutliple kexec segments
+       // then having array to keep indexes of all hotplug kexec segments
+       // will be helpful.
+	unsigned int fdt_index;
 };
 
 struct arch_map_entry {
---

---
Changelog:

v1 -> v2:
  - Use generic hotplug handler introduced by https://lkml.org/lkml/2022/2/9/1406, a
    significant change from v1.

v2 -> v3
  - Move fdt_index and fdt_index_vaild variables to kimage_arch struct.
  - Rebase patche on top of https://lkml.org/lkml/2022/3/3/674 [v5]
  - Fixed warning reported by checpatch script
---

Sourabh Jain (5):
  powerpc/kexec: make update_cpus_node non-static
  powerpc/crash hp: introduce a new config option CRASH_HOTPLUG
  powrepc/crash hp: update kimage struct
  powerpc/crash hp: add crash hotplug support for kexec_file_load
  powerpc/crash hp: add crash hotplug support for kexec_load

 arch/powerpc/Kconfig              |  11 +++
 arch/powerpc/include/asm/kexec.h  |   3 +
 arch/powerpc/kexec/core_64.c      | 153 ++++++++++++++++++++++++++++++
 arch/powerpc/kexec/elf_64.c       |  40 ++++++++
 arch/powerpc/kexec/file_load_64.c |  87 -----------------
 5 files changed, 207 insertions(+), 87 deletions(-)

-- 
2.35.1


