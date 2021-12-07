Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mugWE-009wHr-SE
 for kexec@lists.infradead.org; Tue, 07 Dec 2021 19:52:56 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [RFC v2 5/6] crash hp: kexec_file changes for crash hotplug support
Date: Tue,  7 Dec 2021 14:52:03 -0500
Message-Id: <20211207195204.1582-6-eric.devolder@oracle.com>
In-Reply-To: <20211207195204.1582-1-eric.devolder@oracle.com>
References: <20211207195204.1582-1-eric.devolder@oracle.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com, dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de, rppt@kernel.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, eric.devolder@oracle.com

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


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
