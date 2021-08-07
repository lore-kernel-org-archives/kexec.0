Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx.aristanetworks.com ([162.210.129.12]
 helo=smtp.aristanetworks.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mCBzu-00E1jq-MN
 for kexec@lists.infradead.org; Sat, 07 Aug 2021 02:23:41 +0000
From: Kevin Mitchell <kevmitch@arista.com>
Subject: [PATCH] x86: allow i386 kexec to load x86_64 bzImage anywhere
Date: Fri,  6 Aug 2021 19:21:54 -0700
Message-Id: <20210807022154.425449-1-kevmitch@arista.com>
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
Cc: dyoung@redhat.com, kexec@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, bhe@redhat.com, ebiederm@xmission.com, Kevin Mitchell <kevmitch@arista.com>

In linux-5.2, the following commit allows the kdump kernel to be loaded
at a higher address than 896M

9ca5c8e632ce ("x86/kdump: Have crashkernel=X reserve under 4G by
default")

While this limit does indeed seem unnecessary for x86_64 kernels, it
still is required to boot to or from i386 kernels. Therefore,
kexec-tools continues to enforce it when using the i386 bzImage loader.

However, the i386 bzImage loader may also be used to load an x86_64
kernel from i386 user space to be kexeced by an x86_64 kernel. In this
case, the limit was incorrectly enforced.

This commit adds an additional check for an x86_64 image kexeced by an
x86_64 kernel in the i386 loader and bumps the limit to the maximum
addressable 4G in that case.

Signed-off-by: Kevin Mitchell <kevmitch@arista.com>
---
 kexec/arch/i386/kexec-bzImage.c | 41 ++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index df8985d..7b8e36e 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -22,6 +22,7 @@
 #include <string.h>
 #include <stdlib.h>
 #include <errno.h>
+#include <limits.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -114,6 +115,7 @@ int do_bzImage_load(struct kexec_info *info,
 	struct entry32_regs regs32;
 	struct entry16_regs regs16;
 	unsigned int relocatable_kernel = 0;
+	unsigned int kernel64 = 0;
 	unsigned long kernel32_load_addr;
 	char *modified_cmdline;
 	unsigned long cmdline_end;
@@ -155,6 +157,13 @@ int do_bzImage_load(struct kexec_info *info,
 		dbgprintf("bzImage is relocatable\n");
 	}
 
+	if ((setup_header.protocol_version >= 0x020C) &&
+	    (info->kexec_flags & KEXEC_ARCH_X86_64) &&
+	    (setup_header.xloadflags & 1)) {
+		kernel64 = 1;
+		dbgprintf("loading x86_64 bzImage from an x86_64 kernel\n");
+	}
+
 	/* Can't use bzImage for crash dump purposes with real mode entry */
 	if((info->kexec_flags & KEXEC_ON_CRASH) && real_mode_entry) {
 		fprintf(stderr, "Can't use bzImage for crash dump purposes"
@@ -197,17 +206,17 @@ int do_bzImage_load(struct kexec_info *info,
 	/* Load the trampoline.  This must load at a higher address
 	 * than the argument/parameter segment or the kernel will stomp
 	 * it's gdt.
-	 *
-	 * x86_64 purgatory code has got relocations type R_X86_64_32S
-	 * that means purgatory got to be loaded within first 2G otherwise
-	 * overflow takes place while applying relocations.
 	 */
-	if (!real_mode_entry && relocatable_kernel)
+	if (!real_mode_entry && relocatable_kernel) {
+		/* x86_64 purgatory could be anywhere */
+		unsigned long purg_max_addr = kernel64 ? ULONG_MAX : 0x7fffffff;
+
 		elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size,
-					0x3000, 0x7fffffff, -1, 0);
-	else
+					0x3000, purg_max_addr, -1, 0);
+	} else {
 		elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size,
 					0x3000, 640*1024, -1, 0);
+	}
 	dbgprintf("Loaded purgatory at addr 0x%lx\n", info->rhdr.rel_addr);
 
 	/* The argument/parameter segment */
@@ -277,14 +286,20 @@ int do_bzImage_load(struct kexec_info *info,
 	if (real_mode->protocol_version >=0x0205 && relocatable_kernel) {
 		/* Relocatable bzImage */
 		unsigned long kern_align = real_mode->kernel_alignment;
-		unsigned long kernel32_max_addr = DEFAULT_BZIMAGE_ADDR_MAX;
+		unsigned long kernel_max_addr = DEFAULT_BZIMAGE_ADDR_MAX;
 
-		if (kernel32_max_addr > real_mode->initrd_addr_max)
-			kernel32_max_addr = real_mode->initrd_addr_max;
+		/*
+		 * x86_64 kernels can be kexeced by an x86_64 kernel
+		 * from any addressable location
+		 */
+		if (kernel64)
+			kernel_max_addr = ULONG_MAX;
+		else if (kernel_max_addr > real_mode->initrd_addr_max)
+			kernel_max_addr = real_mode->initrd_addr_max;
 
 		kernel32_load_addr = add_buffer(info, kernel + kern16_size,
 						size, size, kern_align,
-						0x100000, kernel32_max_addr,
+						0x100000, kernel_max_addr,
 						1);
 	}
 	else {
@@ -296,9 +311,9 @@ int do_bzImage_load(struct kexec_info *info,
 	dbgprintf("Loaded 32bit kernel at 0x%lx\n", kernel32_load_addr);
 
 	/* Tell the kernel what is going on */
-	setup_linux_bootloader_parameters(info, real_mode, setup_base,
+	setup_linux_bootloader_parameters_high(info, real_mode, setup_base,
 		kern16_size_needed, command_line, command_line_len,
-		initrd, initrd_len);
+		initrd, initrd_len, kernel64); /* put x86_64 initrd high too */
 
 	if (real_mode_entry && real_mode->protocol_version >= 0x0201) {
 		real_mode->loader_flags |= 0x80; /* CAN_USE_HEAP */
-- 
2.32.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
