Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-f172.google.com ([209.85.222.172])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqmLY-00AvXL-Do
 for kexec@lists.infradead.org; Wed, 09 Jun 2021 00:45:30 +0000
Received: by mail-qk1-f172.google.com with SMTP id k4so22212805qkd.0
 for <kexec@lists.infradead.org>; Tue, 08 Jun 2021 17:45:28 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v15 04/15] arm64: kexec: flush image and lists during kexec
 load time
Date: Tue,  8 Jun 2021 20:44:08 -0400
Message-Id: <20210609004419.936873-5-pasha.tatashin@soleen.com>
In-Reply-To: <20210609004419.936873-1-pasha.tatashin@soleen.com>
References: <20210609004419.936873-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, maz@kernel.org, james.morse@arm.com, vladimir.murzin@arm.com, matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de, selindag@gmail.com, tyhicks@linux.microsoft.com, kernelfans@gmail.com, akpm@linux-foundation.org, madvenka@linux.microsoft.com

Currently, during kexec load we are copying relocation function and
flushing it. However, we can also flush kexec relocation buffers and
if new kernel image is already in place (i.e. crash kernel), we can
also flush the new kernel image itself.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/machine_kexec.c | 49 +++++++++++++++----------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 90a335c74442..3a034bc25709 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -59,23 +59,6 @@ void machine_kexec_cleanup(struct kimage *kimage)
 	/* Empty routine needed to avoid build errors. */
 }
 
-int machine_kexec_post_load(struct kimage *kimage)
-{
-	void *reloc_code = page_to_virt(kimage->control_code_page);
-
-	memcpy(reloc_code, arm64_relocate_new_kernel,
-	       arm64_relocate_new_kernel_size);
-	kimage->arch.kern_reloc = __pa(reloc_code);
-	kexec_image_info(kimage);
-
-	/* Flush the reloc_code in preparation for its execution. */
-	__flush_dcache_area(reloc_code, arm64_relocate_new_kernel_size);
-	flush_icache_range((uintptr_t)reloc_code, (uintptr_t)reloc_code +
-			   arm64_relocate_new_kernel_size);
-
-	return 0;
-}
-
 /**
  * machine_kexec_prepare - Prepare for a kexec reboot.
  *
@@ -152,6 +135,29 @@ static void kexec_segment_flush(const struct kimage *kimage)
 	}
 }
 
+int machine_kexec_post_load(struct kimage *kimage)
+{
+	void *reloc_code = page_to_virt(kimage->control_code_page);
+
+	/* If in place flush new kernel image, else flush lists and buffers */
+	if (kimage->head & IND_DONE)
+		kexec_segment_flush(kimage);
+	else
+		kexec_list_flush(kimage);
+
+	memcpy(reloc_code, arm64_relocate_new_kernel,
+	       arm64_relocate_new_kernel_size);
+	kimage->arch.kern_reloc = __pa(reloc_code);
+	kexec_image_info(kimage);
+
+	/* Flush the reloc_code in preparation for its execution. */
+	__flush_dcache_area(reloc_code, arm64_relocate_new_kernel_size);
+	flush_icache_range((uintptr_t)reloc_code, (uintptr_t)reloc_code +
+			   arm64_relocate_new_kernel_size);
+
+	return 0;
+}
+
 /**
  * machine_kexec - Do the kexec reboot.
  *
@@ -169,13 +175,6 @@ void machine_kexec(struct kimage *kimage)
 	WARN(in_kexec_crash && (stuck_cpus || smp_crash_stop_failed()),
 		"Some CPUs may be stale, kdump will be unreliable.\n");
 
-	/* Flush the kimage list and its buffers. */
-	kexec_list_flush(kimage);
-
-	/* Flush the new image if already in place. */
-	if ((kimage != kexec_crash_image) && (kimage->head & IND_DONE))
-		kexec_segment_flush(kimage);
-
 	pr_info("Bye!\n");
 
 	local_daif_mask();
@@ -250,8 +249,6 @@ void arch_kexec_protect_crashkres(void)
 {
 	int i;
 
-	kexec_segment_flush(kexec_crash_image);
-
 	for (i = 0; i < kexec_crash_image->nr_segments; i++)
 		set_memory_valid(
 			__phys_to_virt(kexec_crash_image->segment[i].mem),
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
