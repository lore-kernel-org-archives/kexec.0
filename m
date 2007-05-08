Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HlM9J-00031k-D5
	for kexec@lists.infradead.org; Tue, 08 May 2007 10:38:27 +0100
Message-Id: <20070508093328.875240134@tabatha.lab.ultramonkey.org>
References: <20070508093114.767199973@tabatha.lab.ultramonkey.org>
Date: Tue, 08 May 2007 18:31:15 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [patch 1/3] Add kdump_elf_core_copy_regs()
Content-Disposition: inline; filename=ia64-kdump-merge-cpu-save.patch
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: fastboot@lists.osdl.org, kexec@lists.infradead.org, linux-ia64@vger.kernel.org
Cc: Nanhai Zou <nanhai.zou@intel.com>, Vivek Goyal <vgoyal@in.ibm.com>, Tony Luck <tony.luck@intel.com>

Facilitate using crash_save_cpu() on ia64 by adding
kdump_elf_core_copy_regs(). By default kdump_elf_core_copy_regs() is just
defined to be elf_core_copy_regs(), which is what crash_save_cpu()
previously used. ia64 (and other architectures) are able to define their
own implementations as needed.

Signed-off-by: Simon Horman <horms@verge.net.au>

--- 
* This patch applies on top of the note size calculation patch
  that can be found in mm and at
  http://lists.linux-foundation.org/pipermail/fastboot/2007-April/006792.html

  Porting this patch to not require that one is quite trivial.
  I can supply a port or a thread containing both patches if it helps.

 linux-2.6/include/linux/kexec.h |    5 +++++
 linux-2.6/kernel/kexec.c        |    2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

Index: linux-2.6/include/linux/kexec.h
===================================================================
--- linux-2.6.orig/include/linux/kexec.h	2007-05-08 17:49:35.000000000 +0900
+++ linux-2.6/include/linux/kexec.h	2007-05-08 17:49:51.000000000 +0900
@@ -128,6 +128,11 @@ extern struct kimage *kexec_crash_image;
 #define kexec_flush_icache_page(page)
 #endif
 
+#ifndef kexec_elf_core_copy_regs
+#define kexec_elf_core_copy_regs(elfregs, regs) \
+	elf_core_copy_regs(elfregs, regs)
+#endif
+
 #define KEXEC_ON_CRASH  0x00000001
 #define KEXEC_ARCH_MASK 0xffff0000
 
Index: linux-2.6/kernel/kexec.c
===================================================================
--- linux-2.6.orig/kernel/kexec.c	2007-05-08 17:49:35.000000000 +0900
+++ linux-2.6/kernel/kexec.c	2007-05-08 17:49:51.000000000 +0900
@@ -1117,7 +1117,7 @@ void crash_save_cpu(struct pt_regs *regs
 		return;
 	memset(&prstatus, 0, sizeof(prstatus));
 	prstatus.pr_pid = current->pid;
-	elf_core_copy_regs(&prstatus.pr_reg, regs);
+	kexec_elf_core_copy_regs(&prstatus.pr_reg, regs);
 	buf = append_elf_note(buf, KEXEC_CORE_NOTE_NAME, NT_PRSTATUS,
 		      	      &prstatus, sizeof(prstatus));
 	final_note(buf);

-- 

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
