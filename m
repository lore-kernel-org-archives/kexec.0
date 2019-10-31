Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iQ1Fd-0003Da-Ow
 for kexec@lists.infradead.org; Thu, 31 Oct 2019 03:35:59 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 1/2 RESEND v8] x86/kdump: always reserve the low 1M when the
 crashkernel option is specified
Date: Thu, 31 Oct 2019 11:35:16 +0800
Message-Id: <20191031033517.11282-2-lijiang@redhat.com>
In-Reply-To: <20191031033517.11282-1-lijiang@redhat.com>
References: <20191031033517.11282-1-lijiang@redhat.com>
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
Cc: jgross@suse.com, Thomas.Lendacky@amd.com, bhe@redhat.com, horms@verge.net.au, x86@kernel.org, kexec@lists.infradead.org, dhowells@redhat.com, mingo@redhat.com, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, d.hatayama@fujitsu.com, vgoyal@redhat.com

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
lets reserve the remaining low 1M memory(after reserving real mode
memory) so that the allocated memory does not fall into the low 1M
area, which makes us not to copy the first 640k content to a backup
region in purgatory(). This indicates that it does not need to be
included in crash dumps or used for anything except the processor
trampolines that must live in the low 1M.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 arch/x86/include/asm/crash.h |  8 ++++++++
 arch/x86/kernel/crash.c      | 15 +++++++++++++++
 arch/x86/realmode/init.c     |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/crash.h b/arch/x86/include/asm/crash.h
index 0acf5ee45a21..88eadd08ad70 100644
--- a/arch/x86/include/asm/crash.h
+++ b/arch/x86/include/asm/crash.h
@@ -2,10 +2,18 @@
 #ifndef _ASM_X86_CRASH_H
 #define _ASM_X86_CRASH_H
 
+struct kimage;
+
 int crash_load_segments(struct kimage *image);
 int crash_copy_backup_region(struct kimage *image);
 int crash_setup_memmap_entries(struct kimage *image,
 		struct boot_params *params);
 void crash_smp_send_stop(void);
 
+#ifdef CONFIG_KEXEC_CORE
+void __init crash_reserve_low_1M(void);
+#else
+static inline void __init crash_reserve_low_1M(void) { }
+#endif
+
 #endif /* _ASM_X86_CRASH_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index eb651fbde92a..db2301afade5 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -24,6 +24,7 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/memblock.h>
 
 #include <asm/processor.h>
 #include <asm/hardirq.h>
@@ -39,6 +40,7 @@
 #include <asm/virtext.h>
 #include <asm/intel_pt.h>
 #include <asm/crash.h>
+#include <asm/cmdline.h>
 
 /* Used while preparing memory map entries for second kernel */
 struct crash_memmap_data {
@@ -68,6 +70,19 @@ static inline void cpu_crash_vmclear_loaded_vmcss(void)
 	rcu_read_unlock();
 }
 
+/*
+ * When the crashkernel option is specified, only use the low
+ * 1M for the real mode trampoline.
+ */
+void __init crash_reserve_low_1M(void)
+{
+	if (cmdline_find_option(boot_command_line, "crashkernel",
+				NULL, 0) > 0) {
+		memblock_reserve(0, 1<<20);
+		pr_info("Reserving the low 1M of memory for crashkernel\n");
+	}
+}
+
 #if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
 
 static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 7dce39c8c034..262f83cad355 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -8,6 +8,7 @@
 #include <asm/pgtable.h>
 #include <asm/realmode.h>
 #include <asm/tlbflush.h>
+#include <asm/crash.h>
 
 struct real_mode_header *real_mode_header;
 u32 *trampoline_cr4_features;
@@ -34,6 +35,7 @@ void __init reserve_real_mode(void)
 
 	memblock_reserve(mem, size);
 	set_real_mode_mem(mem);
+	crash_reserve_low_1M();
 }
 
 static void __init setup_real_mode(void)
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
