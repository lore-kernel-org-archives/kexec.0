Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
From: Lei Wen <leiwen@marvell.com>
Subject: [PATCH] ARM: kdump: copy kernel relocation code at the kexec prepare
	stage
Date: Thu, 15 Sep 2011 22:32:09 -0700
Message-Id: <1316151129-30491-1-git-send-email-leiwen@marvell.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Chao Xie <chao.xie@marvell.com>, Yu Tang <ytang5@marvell.com>, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org

This copy really don't need to do at the very second before the kernel
would crash.

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 arch/arm/kernel/machine_kexec.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index e59bbd4..f60fc90 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -32,6 +32,21 @@ static atomic_t waiting_for_crash_ipi;
 
 int machine_kexec_prepare(struct kimage *image)
 {
+	unsigned long page_list;
+	void *reboot_code_buffer;
+	page_list = image->head & PAGE_MASK;
+
+	reboot_code_buffer = page_address(image->control_code_page);
+
+	/* Prepare parameters for reboot_code_buffer*/
+	kexec_start_address = image->start;
+	kexec_indirection_page = page_list;
+	kexec_mach_type = machine_arch_type;
+	kexec_boot_atags = image->start - KEXEC_ARM_ZIMAGE_OFFSET + KEXEC_ARM_ATAGS_OFFSET;
+
+	/* copy our kernel relocation code to the control code page */
+	memcpy(reboot_code_buffer,
+	       relocate_new_kernel, relocate_new_kernel_size);
 	return 0;
 }
 
@@ -82,29 +97,14 @@ void (*kexec_reinit)(void);
 
 void machine_kexec(struct kimage *image)
 {
-	unsigned long page_list;
 	unsigned long reboot_code_buffer_phys;
 	void *reboot_code_buffer;
 
-
-	page_list = image->head & PAGE_MASK;
-
 	/* we need both effective and real address here */
 	reboot_code_buffer_phys =
 	    page_to_pfn(image->control_code_page) << PAGE_SHIFT;
 	reboot_code_buffer = page_address(image->control_code_page);
 
-	/* Prepare parameters for reboot_code_buffer*/
-	kexec_start_address = image->start;
-	kexec_indirection_page = page_list;
-	kexec_mach_type = machine_arch_type;
-	kexec_boot_atags = image->start - KEXEC_ARM_ZIMAGE_OFFSET + KEXEC_ARM_ATAGS_OFFSET;
-
-	/* copy our kernel relocation code to the control code page */
-	memcpy(reboot_code_buffer,
-	       relocate_new_kernel, relocate_new_kernel_size);
-
-
 	flush_icache_range((unsigned long) reboot_code_buffer,
 			   (unsigned long) reboot_code_buffer + KEXEC_CONTROL_PAGE_SIZE);
 	printk(KERN_INFO "Bye!\n");
-- 
1.7.0.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
