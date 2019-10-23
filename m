Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iNHUR-0002w0-3J
 for kexec@lists.infradead.org; Wed, 23 Oct 2019 14:19:57 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 1/2 v5] x86/kdump: always reserve the low 1MiB when the
 crashkernel option is specified
Date: Wed, 23 Oct 2019 22:19:11 +0800
Message-Id: <20191023141912.29110-2-lijiang@redhat.com>
In-Reply-To: <20191023141912.29110-1-lijiang@redhat.com>
References: <20191023141912.29110-1-lijiang@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: jgross@suse.com, Thomas.Lendacky@amd.com, bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, dhowells@redhat.com, mingo@redhat.com, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, vgoyal@redhat.com

Kdump kernel will reuse the first 640k region because the real mode
trampoline has to work in this area. When the vmcore is dumped, the
old memory in this area may be accessed, therefore, kernel has to
copy the contents of the first 640k area to a backup region so that
kdump kernel can read the old memory from the backup area of the
first 640k area, which is done in the purgatory().

But, the current handling of copying the first 640k area runs into
problems when SME is enabled, kernel does not properly copy these
old memory to the backup area in the purgatory(), thereby, kdump
kernel reads out the encrypted contents, because the kdump kernel
must access the first kernel's memory with the encryption bit set
when SME is enabled in the first kernel. Please refer to this link:

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204793

Finally, it causes the following errors, and the crash tool gets
invalid pointers when parsing the vmcore.

crash> kmem -s|grep -i invalid
kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac099f0c5a4
kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac099f0c5a4
crash>

To avoid the above errors, when the crashkernel option is specified,
lets reserve the remaining low 1MiB memory(after reserving real mode
memory) so that the allocated memory does not fall into the low 1MiB
area, which makes us not to copy the first 640k content to a backup
region in purgatory(). This indicates that it does not need to be
included in crash dumps or used for anything except the processor
trampolines that must live in the low 1MiB.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
BTW:I also tried to fix the above problem in purgatory(), but there
are too many restricts in purgatory() context, for example: i can't
allocate new memory to create the identity mapping page table for
SME situation.

Currently, there are two places where the first 640k area is needed,
the first one is in the find_trampoline_placement(), another one is
in the reserve_real_mode(), and their content doesn't matter.

In addition, also need to clean all the code related to the backup
region later.

 arch/x86/realmode/init.c |  2 ++
 include/linux/kexec.h    |  2 ++
 kernel/kexec_core.c      | 13 +++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 7dce39c8c034..064cc79a015d 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -3,6 +3,7 @@
 #include <linux/slab.h>
 #include <linux/memblock.h>
 #include <linux/mem_encrypt.h>
+#include <linux/kexec.h>
 
 #include <asm/set_memory.h>
 #include <asm/pgtable.h>
@@ -34,6 +35,7 @@ void __init reserve_real_mode(void)
 
 	memblock_reserve(mem, size);
 	set_real_mode_mem(mem);
+	kexec_reserve_low_1MiB();
 }
 
 static void __init setup_real_mode(void)
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 1776eb2e43a4..30acf1d738bc 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -306,6 +306,7 @@ extern void __crash_kexec(struct pt_regs *);
 extern void crash_kexec(struct pt_regs *);
 int kexec_should_crash(struct task_struct *);
 int kexec_crash_loaded(void);
+void __init kexec_reserve_low_1MiB(void);
 void crash_save_cpu(struct pt_regs *regs, int cpu);
 extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
 
@@ -397,6 +398,7 @@ static inline void __crash_kexec(struct pt_regs *regs) { }
 static inline void crash_kexec(struct pt_regs *regs) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 static inline int kexec_crash_loaded(void) { return 0; }
+static inline void __init kexec_reserve_low_1MiB(void) { }
 #define kexec_in_progress false
 #endif /* CONFIG_KEXEC_CORE */
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 15d70a90b50d..5bd89f1fee42 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -37,6 +37,7 @@
 #include <linux/compiler.h>
 #include <linux/hugetlb.h>
 #include <linux/frame.h>
+#include <linux/memblock.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -70,6 +71,18 @@ struct resource crashk_low_res = {
 	.desc  = IORES_DESC_CRASH_KERNEL
 };
 
+/*
+ * When the crashkernel option is specified, only use the low
+ * 1MiB for the real mode trampoline.
+ */
+void __init kexec_reserve_low_1MiB(void)
+{
+	if (strstr(boot_command_line, "crashkernel=")) {
+		memblock_reserve(0, 1<<20);
+		pr_info("Reserving the low 1MiB of memory for crashkernel\n");
+	}
+}
+
 int kexec_should_crash(struct task_struct *p)
 {
 	/*
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
