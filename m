Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnlYb-008UKI-4X
 for kexec@lists.infradead.org; Thu, 18 Nov 2021 17:50:46 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [RFC v1 5/8] crash hp: kexec_file changes for use by crash hotplug
 handler
Date: Thu, 18 Nov 2021 12:49:45 -0500
Message-Id: <20211118174948.37435-6-eric.devolder@oracle.com>
In-Reply-To: <20211118174948.37435-1-eric.devolder@oracle.com>
References: <20211118174948.37435-1-eric.devolder@oracle.com>
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

Three minor changes are made to this file to facilitate re-using
the functions from within a crash hotplug handler.

The prototype for kexec_calculate_store_digests() was hoisted to
linux/kexec.h and the function made non-static.

The crash_prepare_elf64_headers() had the struct kimage parameter
added so that the check for the offlinecpu could be performed and
this routine re-used by the crash hotplug handler.

Finally, kexec_add_buffer() changed slightly so that it does not
attempt to add the buffer to the kimage when being called from
the crash hotplug handler.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kernel/kexec_file.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 8347fc158d2b..c9e8e5b94382 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -29,8 +29,6 @@
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
 
-static int kexec_calculate_store_digests(struct kimage *image);
-
 /*
  * Currently this is the only default function that is exported as some
  * architectures need it to do additional handlings.
@@ -674,6 +672,12 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
 	struct kexec_segment *ksegment;
 	int ret;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	/* When servicing a hotplug event, do not add buffers to the image */
+	if (kbuf->image->hotplug_event)
+		return 0;
+#endif
+
 	/* Currently adding segment this way is allowed only in file mode */
 	if (!kbuf->image->file_mode)
 		return -EINVAL;
@@ -713,7 +717,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
 }
 
 /* Calculate and store the digest of segments */
-static int kexec_calculate_store_digests(struct kimage *image)
+int kexec_calculate_store_digests(struct kimage *image)
 {
 	struct crypto_shash *tfm;
 	struct shash_desc *desc;
@@ -1260,8 +1264,8 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 	return 0;
 }
 
-int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
-			  void **addr, unsigned long *sz)
+int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
+	int kernel_map, void **addr, unsigned long *sz)
 {
 	Elf64_Ehdr *ehdr;
 	Elf64_Phdr *phdr;
@@ -1308,6 +1312,11 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
 
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
