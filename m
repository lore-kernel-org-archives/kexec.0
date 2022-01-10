From: Eric DeVolder <eric.devolder@oracle.com>
Date: Mon, 10 Jan 2022 14:57:26 -0500
Subject: [PATCH v3 5/6] crash hp: kexec_file changes for crash hotplug support
In-Reply-To: <20220110195727.1682-1-eric.devolder@oracle.com>
References: <20220110195727.1682-1-eric.devolder@oracle.com>
Message-ID: <20220110195727.1682-6-eric.devolder@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Two important changes to note:

The kexec_calculate_store_digests() changed to specifically EXCLUDE
the elfcorehdr segment from its list of segments to check.
This is an important change as it allows, in a hotplug environment,
for the elfcorehdr segment (which contains the list of CPUs and
memory regions) to change dynamically without the need to update
purgatory (with the hash/digests of the segments it checks) as well.

The crash_prepare_elf64_headers() changed to look for the offline'd
CPU and exclude it. This due to the fact that the offline'd CPU is
still in the for_each_present_cpu() list at this point in time on
the cpu hotplug handler path.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kernel/kexec_file.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 8347fc158d2b..339995d42169 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -765,6 +765,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+		/* This segment excluded to allow future changes via hotplug */
+		if (image->elf_index_valid && (j == image->elf_index))
+			continue;
+#endif
+
 		ksegment = &image->segment[i];
 		/*
 		 * Skip purgatory as it will be modified once we put digest
@@ -1260,8 +1266,8 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 	return 0;
 }
 
-int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
-			  void **addr, unsigned long *sz)
+int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
+	int kernel_map, void **addr, unsigned long *sz)
 {
 	Elf64_Ehdr *ehdr;
 	Elf64_Phdr *phdr;
@@ -1308,6 +1314,11 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
 
 	/* Prepare one phdr of type PT_NOTE for each present CPU */
 	for_each_present_cpu(cpu) {
+#ifdef CONFIG_CRASH_HOTPLUG
+		/* Skip the soon-to-be offlined cpu */
+		if (image->hotplug_event && (cpu == image->offlinecpu))
+			continue;
+#endif
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
-- 
2.27.0


