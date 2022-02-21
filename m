From: Sourabh Jain <sourabhjain@linux.ibm.com>
Date: Mon, 21 Feb 2022 14:16:19 +0530
Subject: [RFC PATCH 0/5] Avoid kdump service reload on CPU hotplug events
Message-ID: <20220221084624.85792-1-sourabhjain@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On hotplug event (CPU/memory) the CPU information prepared for the kdump kernel
becomes stale unless it is prepared again. To keep the CPU information
up-to-date a kdump service reload is triggered via the udev rule.

The above approach has two downsides:

1) The udev rules are prone to races if hotplug event is frequent. The time is
   taken to settle down all the kdump service reload requested is significant
   when multiple CPU/memory hotplug is performed at the same time. This creates
   a window where kernel crash might not lead to successfully dump collection.

2) Unnecessary CPU cycles are consumed to reload all the kdump components
   including initrd, vmlinux, FDT, etc. whereas only one component needs to
   update that is FDT.

How this patch series solve the above issue?
--------------------------------------------
As mentioned above the only kexec segment that gets updated during
the kdump service reload (due to hotplug event) is FDT. So, instead
of re-creating the FDT on every hotplug event, it is just created
once and updated on every hotplug event. This FDT is referred as kexec
crash FDT.


How kexec crash FDT is managed?
-------------------------------
During the kernel boot, a hole is allocated for kexec crash FDT in the kdump
reserved region. On kdump service start a fresh copy of kdump FDT
(created by kexec tool or kernel-based on which system call is used) is
copied to the pre-allocated hole for kexec crash FDT. Once a kexec crash
FDT is loaded all the subsequent updates needed due to CPU hot-add event
can directly be done to kexec crash FDT without reloading all the kexec
segment again. A hook is added on the CPU hot-add path to update the kexec
crash FDT.


How kexec crash FDT is accessed in kexec_load and kexec_file_load system call?
------------------------------------------------------------------------------
Since kexec_file_load creates all kexec segments are prepared in the kernel,
it can easily access the kexec crash FDT with help of two global variables,
that holds the start address and the size of the kexec crash FDT.

In kexec_load system call, the kexec segments are prepared by the kexec tool in
userspace. The start address and the size of kexec crash fdt is provided to
userspace via two sysfs files /sys/kernel/kexec_crash_fdt and
/sys/kernel/kexec_crash_fdt_size.


A couple of minor changes are required to realise the benefit of the patch
series:

- disalble the udev rule:

  comment out the below line in kdump udev rule file:
  RHEL: /usr/lib/udev/rules.d/98-kexec.rules
  # SUBSYSTEM=="cpu", ACTION=="online", GOTO="kdump_reload_cpu"

- kexec tool needs to be updated with patch for kexec_load system call
  to work (not needed if -s option is used during kexec panic load):

---
From 37aa38713c163b31d9c6e80ddc059424c9fcd66d Mon Sep 17 00:00:00 2001
From: Sourabh Jain <sourabhjain@linux.ibm.com>
Date: Mon, 22 Nov 2021 14:12:52 +0530
Subject: [PATCH] kexec/ppc64: use pre-allocated memory hole for kexec crash
 FDT

Enabled kexec to use the per allocated memory hole for kexec crash FDT
which is exported via /sys/kernel/kexec_crash_fdt and
/sys/kernel/kexec_crash_fdt_size sysfs files. Using this pre-allocated
memory hole for kdump fdt will allow the kernel to keep the kdump fdt
up-to-date with the latest CPU information.

In case a pre-allocated memory hole is used for kdump fdt, the kdump fdt
the segment is not included in SHA calculation because kdump fdt will be
modified by the kernel.

To maintain the backward compatibility, we fall back to the old option of
finding hole for kdump fdt segment if the pre-allocated buffer is not provided
by the kernel.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 kexec/arch/ppc64/kexec-elf-ppc64.c | 11 +++++--
 kexec/arch/ppc64/kexec-ppc64.c     | 49 ++++++++++++++++++++++++++++++
 kexec/kexec.c                      |  9 ++++++
 kexec/kexec.h                      |  4 +++
 4 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index 695b8b0..8e66ef0 100644
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -329,8 +329,15 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	if (result < 0)
 		return result;
 
-	my_dt_offset = add_buffer(info, seg_buf, seg_size, seg_size,
-				0, 0, max_addr, -1);
+        if (kexec_crash_fdt) {
+                my_dt_offset = kexec_crash_fdt;
+                add_segment_phys_virt(info, seg_buf, seg_size,
+				      my_dt_offset, kexec_crash_fdt_size, 0);
+        }
+        else {
+                my_dt_offset = add_buffer(info, seg_buf, seg_size, seg_size,
+                                          0, 0, max_addr, -1);
+        }
 
 #ifdef NEED_RESERVE_DTB
 	/* patch reserve map address for flattened device-tree
diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index 5b17740..d4385bd 100644
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -24,6 +24,7 @@
 #include <errno.h>
 #include <stdint.h>
 #include <string.h>
+#include <fcntl.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <dirent.h>
@@ -373,6 +374,52 @@ void scan_reserved_ranges(unsigned long kexec_flags, int *range_index)
 	*range_index = i;
 }
 
+void get_kexec_crash_fdt_details(unsigned long kexec_flags)
+{
+	int fd, len;
+	char buf[MAXBYTES] = { 0 };
+
+	const char * const kexec_fdt_sysfs = "/sys/kernel/kexec_crash_fdt";
+	const char * const kexec_fdt_size_sysfs = "/sys/kernel/kexec_crash_fdt_size";
+
+        fd = open(kexec_fdt_sysfs, O_RDONLY);
+        if (fd < 0)
+                return;
+
+        len = read(fd, buf, MAXBYTES);
+        if (len < 0)
+                goto err_out;
+
+        kexec_crash_fdt = strtoul(buf, NULL, 16);
+
+	fd = open(kexec_fdt_size_sysfs, O_RDONLY);
+	if (fd < 0)
+		goto err_out;
+
+	len = read(fd, buf, MAXBYTES);
+	if (len < 0)
+		goto err_out;
+
+	kexec_crash_fdt_size = strtoul(buf, NULL, 10);
+
+        exclude_range[nr_exclude_ranges].start = kexec_crash_fdt;
+        exclude_range[nr_exclude_ranges].end = kexec_crash_fdt + \
+					       kexec_crash_fdt_size;
+        nr_exclude_ranges++;
+
+        if (nr_exclude_ranges >= max_memory_ranges)
+                realloc_memory_ranges();
+
+	goto out;
+
+err_out:
+	kexec_crash_fdt = kexec_fdt_size = 0;
+
+out:
+        close (fd);
+        return;
+}
+
 /* Return 0 if fname/value valid, -1 otherwise */
 int get_devtree_value(const char *fname, unsigned long long *value)
 {
@@ -804,6 +851,8 @@ int setup_memory_ranges(unsigned long kexec_flags)
 		goto out;
 	if (get_devtree_details(kexec_flags))
 		goto out;
+	if (kexec_flags & KEXEC_ON_CRASH)
+		get_kexec_crash_fdt_details(kexec_flags);
 
 	for (i = 0; i < nr_exclude_ranges; i++) {
 		/* If first exclude range does not start with 0, include the
diff --git a/kexec/kexec.c b/kexec/kexec.c
index f63b36b..89283f7 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -62,6 +62,10 @@ static unsigned long kexec_flags = 0;
 /* Flags for kexec file (fd) based syscall */
 static unsigned long kexec_file_flags = 0;
 int kexec_debug = 0;
+#if defined(__powerpc__) || defined(__powerpc64__)
+uint64_t kexec_crash_fdt;
+uint32_t kexec_cras_fdt_size;
+#endif
 
 void dbgprint_mem_range(const char *prefix, struct memory_range *mr, int nr_mr)
 {
@@ -672,6 +676,11 @@ static void update_purgatory(struct kexec_info *info)
 		if (info->segment[i].mem == (void *)info->rhdr.rel_addr) {
 			continue;
 		}
+
+#if defined(__powerpc__) || defined(__powerpc64__)
+		if (kexec_crash_fdt && (unsigned long)info->segment[i].mem == kexec_crash_fdt)
+			continue;
+#endif
 		sha256_update(&ctx, info->segment[i].buf,
 			      info->segment[i].bufsz);
 		nullsz = info->segment[i].memsz - info->segment[i].bufsz;
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 595dd68..48e8b9f 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -205,6 +205,10 @@ struct file_type {
 
 extern struct file_type file_type[];
 extern int file_types;
+#if defined(__powerpc__) || defined(__powerpc64__)
+extern uint64_t fdt;
+extern uint32_t fdt_size;
+#endif
 
 #define OPT_HELP		'h'
 #define OPT_VERSION		'v'
-- 
2.34.1
---


Sourabh Jain (5):
  powerpc/kdump: export functions from file_load_64.c
  powerpc/kdump: setup kexec crash FDT
  powerpc/kdump: update kexec crash FDT on CPU hot add event
  powerpc/kdump: enable kexec_file_load system call to use kexec crash
    FDT
  powerpc/kdump: export kexec crash FDT details via sysfs

 arch/powerpc/Kconfig                         |  11 +
 arch/powerpc/include/asm/kexec.h             |  10 +
 arch/powerpc/kexec/core_64.c                 | 318 +++++++++++++++++++
 arch/powerpc/kexec/elf_64.c                  |  22 +-
 arch/powerpc/kexec/file_load_64.c            | 239 +-------------
 arch/powerpc/platforms/pseries/hotplug-cpu.c |   7 +
 6 files changed, 369 insertions(+), 238 deletions(-)

-- 
2.34.1


