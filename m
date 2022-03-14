From: Sourabh Jain <sourabhjain@linux.ibm.com>
Date: Tue, 15 Mar 2022 04:17:28 +0530
Subject: [RFC v2 PATCH 5/5] powerpc/crash hp: add crash hotplug support for
 kexec_load
In-Reply-To: <20220314224728.79990-1-sourabhjain@linux.ibm.com>
References: <20220314224728.79990-1-sourabhjain@linux.ibm.com>
Message-ID: <20220314224728.79990-6-sourabhjain@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

The kernel changes needed to add support for crash hotplug support for
kexec_load system calls are similar to kexec_file_load (which has already
been implemented in earlier patches). Since kexec segment array is
prepared by kexec tool in the userspace, the kernel does aware of which
index FDT segment is present.

The only change was done to enabled crash hotplug support for kexec_load is
updated the crash hotplug handler to identify the FDT segment from kexec
segment array.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/kexec/core_64.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index a4defb84720f..bb449f6e380f 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -480,7 +480,9 @@ int update_cpus_node(void *fdt)
 void arch_crash_hotplug_handler(struct kimage *image,
         unsigned int hp_action, unsigned long a, unsigned long b)
 {
-        void *fdt;
+        void *fdt, *ptr;
+        unsigned int n;
+        unsigned long mem, memsz;
 
 	/* No action needed for CPU hot-unplug */
 	if (hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
@@ -492,6 +494,23 @@ void arch_crash_hotplug_handler(struct kimage *image,
 		return;
 	}
 
+	/* Sine kexec segments for kexec_load system call is prepred by
+	 * kexec tool in userspace we need loop through all the segments
+	 * to find out segment index corresponds FDT segment. In case of
+	 * kexec_file_load it is discovered during the load itself.
+	 */
+        if (!image->fdt_index_valid) {
+                for (n = 0; n < image->nr_segments; n++) {
+                        mem = image->segment[n].mem;
+                        memsz = image->segment[n].memsz;
+                        ptr = __va(mem);
+                        if (ptr && fdt_magic(ptr) == FDT_MAGIC) {
+                                image->fdt_index = n;
+                                image->fdt_index_valid = true;
+                        }
+                }
+        }
+
         /* Must have valid FDT index */
         if (!image->fdt_index_valid) {
                 pr_err("crash hp: unable to locate FDT segment");
-- 
2.35.1


