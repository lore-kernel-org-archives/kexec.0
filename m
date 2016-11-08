Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c3vF4-0008AW-7X
 for kexec@lists.infradead.org; Tue, 08 Nov 2016 01:30:27 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 2/2] kexec: Change to export the value of phys_base instead of
 symbol address
Date: Tue,  8 Nov 2016 09:29:56 +0800
Message-Id: <1478568596-30060-2-git-send-email-bhe@redhat.com>
In-Reply-To: <1478568596-30060-1-git-send-email-bhe@redhat.com>
References: <1478568596-30060-1-git-send-email-bhe@redhat.com>
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
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: panand@redhat.com, akpm@linux-foundation.org, Baoquan He <bhe@redhat.com>, ats-kumagai@wm.jp.nec.com, takahiro.akashi@linaro.org, mingo@redhat.com, anderson@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, thgarnie@google.com

Currently in x86_64, the symbol address of phys_base is exported to vmcoreinfo.
Dave Anderson complained this is really useless for his Crash implementation.
Because in user-space utility Crash and Makedumpfile which exported vmcore
information is mainly used for, value of phys_base is needed to covert virtual
address of exported kernel symbol to physical address. Especially init_level4_pgt,
if we want to access and go over the page table to look up a PA corresponding
to VA, firstly we need calculate
  page_dir = SYMBOL(init_level4_pgt) - __START_KERNEL_map + phys_base;

Now in Crash and Makedumpfile, we have to analyze the vmcore elf program header
to get value of phys_base. As Dave said, it would be preferable if it were readily
availabl in vmcoreinfo rather than depending upon the PT_LOAD semantics.

Hence in this patch change to export the value of phys_base instead of its
virtual address.

And people also complained that KERNEL_IMAGE_SIZE exporting is x86_64 only, should
be moved into arch dependent function arch_crash_save_vmcoreinfo. Do the moving
in this patch.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 3 ++-
 kernel/kexec_core.c                | 3 ---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 5a294e4..307b1f4 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -328,7 +328,7 @@ void machine_kexec(struct kimage *image)
 
 void arch_crash_save_vmcoreinfo(void)
 {
-	VMCOREINFO_SYMBOL(phys_base);
+	VMCOREINFO_NUMBER(phys_base);
 	VMCOREINFO_SYMBOL(init_level4_pgt);
 
 #ifdef CONFIG_NUMA
@@ -337,6 +337,7 @@ void arch_crash_save_vmcoreinfo(void)
 #endif
 	vmcoreinfo_append_str("KERNELOFFSET=%lx\n",
 			      kaslr_offset());
+	VMCOREINFO_NUMBER(KERNEL_IMAGE_SIZE);
 }
 
 /* arch-dependent functionality related to kexec file-based syscall */
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 5616755..8ad3a29e 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1467,9 +1467,6 @@ static int __init crash_save_vmcoreinfo_init(void)
 #endif
 	VMCOREINFO_NUMBER(PG_head_mask);
 	VMCOREINFO_NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE);
-#ifdef CONFIG_X86
-	VMCOREINFO_NUMBER(KERNEL_IMAGE_SIZE);
-#endif
 #ifdef CONFIG_HUGETLB_PAGE
 	VMCOREINFO_NUMBER(HUGETLB_PAGE_DTOR);
 #endif
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
