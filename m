Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c3vF4-0007yj-83
 for kexec@lists.infradead.org; Tue, 08 Nov 2016 01:30:27 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 1/2] Revert "kdump,
 vmcoreinfo: report memory sections virtual addresses"
Date: Tue,  8 Nov 2016 09:29:55 +0800
Message-Id: <1478568596-30060-1-git-send-email-bhe@redhat.com>
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

This reverts commit 0549a3c02efb350776bc869685a361045efd3a29.

Commit 0549a3c tells user space utility - makedumpfile the randomized
base address of these memmory sections when mm kaslr enabled. However
below patchset makes makedumpfile not need them any more. Besides we
should use VMCOREINFO_NUMBER to export value of variable so that we
can use the existing number_table mechanism of Makedumpfile to fetch
it. So revert it now. If needed, can add it later.

http://lists.infradead.org/pipermail/kexec/2016-October/017540.html
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 3 ---
 include/linux/kexec.h              | 6 ------
 2 files changed, 9 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 8c1f218..5a294e4 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -337,9 +337,6 @@ void arch_crash_save_vmcoreinfo(void)
 #endif
 	vmcoreinfo_append_str("KERNELOFFSET=%lx\n",
 			      kaslr_offset());
-	VMCOREINFO_PAGE_OFFSET(PAGE_OFFSET);
-	VMCOREINFO_VMALLOC_START(VMALLOC_START);
-	VMCOREINFO_VMEMMAP_START(VMEMMAP_START);
 }
 
 /* arch-dependent functionality related to kexec file-based syscall */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 406c33d..d743777 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -259,12 +259,6 @@ phys_addr_t paddr_vmcoreinfo_note(void);
 	vmcoreinfo_append_str("NUMBER(%s)=%ld\n", #name, (long)name)
 #define VMCOREINFO_CONFIG(name) \
 	vmcoreinfo_append_str("CONFIG_%s=y\n", #name)
-#define VMCOREINFO_PAGE_OFFSET(value) \
-	vmcoreinfo_append_str("PAGE_OFFSET=%lx\n", (unsigned long)value)
-#define VMCOREINFO_VMALLOC_START(value) \
-	vmcoreinfo_append_str("VMALLOC_START=%lx\n", (unsigned long)value)
-#define VMCOREINFO_VMEMMAP_START(value) \
-	vmcoreinfo_append_str("VMEMMAP_START=%lx\n", (unsigned long)value)
 
 extern struct kimage *kexec_image;
 extern struct kimage *kexec_crash_image;
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
