Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TyTf0-000504-GT
 for kexec@lists.infradead.org; Thu, 24 Jan 2013 20:44:36 +0000
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v7 3/7] kexec, x86: Fix bzImage real-mode booting
Date: Thu, 24 Jan 2013 12:44:20 -0800
Message-Id: <1359060264-10671-4-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359060264-10671-1-git-send-email-yinghai@kernel.org>
References: <1359060264-10671-1-git-send-email-yinghai@kernel.org>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org

We need to keep space for bss, heap/stack before command line.
otherwise command_line will be cleared by kernel 16bit init code.

also need to set 32bit start in real_mode header, kernel 16bit code
need to jump there.

Also don't touch regs16 if --real-mode is not specified.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 kexec/arch/i386/kexec-bzImage.c |   63 +++++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index 4cc394d..1a33d47 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -130,6 +130,8 @@ int do_bzImage_load(struct kexec_info *info,
 	unsigned long kernel32_load_addr;
 	char *modified_cmdline;
 	unsigned long cmdline_end;
+	unsigned long kern16_size_needed;
+	unsigned long heap_size = 0;
 
 	/*
 	 * Find out about the file I am about to load.
@@ -221,9 +223,31 @@ int do_bzImage_load(struct kexec_info *info,
 		elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size,
 					0x3000, 640*1024, -1, 0);
 	dbgprintf("Loaded purgatory at addr 0x%lx\n", info->rhdr.rel_addr);
+
 	/* The argument/parameter segment */
-	setup_size = kern16_size + command_line_len + PURGATORY_CMDLINE_SIZE;
+	if (real_mode_entry) {
+		/* need to include size for bss and heap etc */
+		if (setup_header.protocol_version >= 0x0201)
+			kern16_size_needed = setup_header.heap_end_ptr;
+		else
+			kern16_size_needed = kern16_size + 8192; /* bss */
+		if (kern16_size_needed < kern16_size)
+			kern16_size_needed = kern16_size;
+		if (kern16_size_needed > 0xfffc)
+			die("kern16_size_needed is more then 64k\n");
+		heap_size = 0xfffc - kern16_size_needed; /* less 64k */
+		heap_size &= ~(0x200 - 1);
+		kern16_size_needed += heap_size;
+	} else {
+		kern16_size_needed = kern16_size;
+		/* need to bigger than size of struct bootparams */
+		if (kern16_size_needed < 4096)
+			kern16_size_needed = 4096;
+	}
+	setup_size = kern16_size_needed + command_line_len +
+			 PURGATORY_CMDLINE_SIZE;
 	real_mode = xmalloc(setup_size);
+	memset(real_mode, 0, setup_size);
 	memcpy(real_mode, kernel, kern16_size);
 	if (!real_mode_entry)
 		clean_boot_params((unsigned char *)real_mode, kern16_size);
@@ -279,11 +303,18 @@ int do_bzImage_load(struct kexec_info *info,
 
 	/* Tell the kernel what is going on */
 	setup_linux_bootloader_parameters(info, real_mode, setup_base,
-		kern16_size, command_line, command_line_len,
+		kern16_size_needed, command_line, command_line_len,
 		initrd, initrd_len);
 
+	if (real_mode_entry && real_mode->protocol_version >= 0x0201) {
+		real_mode->loader_flags |= 0x80; /* CAN_USE_HEAP */
+		real_mode->heap_end_ptr += heap_size - 0x200; /*stack*/
+	}
+
 	/* Get the initial register values */
-	elf_rel_get_symbol(&info->rhdr, "entry16_regs", &regs16, sizeof(regs16));
+	if (real_mode_entry)
+		elf_rel_get_symbol(&info->rhdr, "entry16_regs",
+					 &regs16, sizeof(regs16));
 	elf_rel_get_symbol(&info->rhdr, "entry32_regs", &regs32, sizeof(regs32));
 	/*
 
@@ -302,16 +333,18 @@ int do_bzImage_load(struct kexec_info *info,
 	/*
 	 * Initialize the 16bit start information.
 	 */
-	regs16.ds = regs16.es = regs16.fs = regs16.gs = setup_base >> 4;
-	regs16.cs = regs16.ds + 0x20;
-	regs16.ip = 0;
-	/* XXX: Documentation/i386/boot.txt says 'ss' must equal 'ds' */
-	regs16.ss = (elf_rel_get_addr(&info->rhdr, "stack_end") - 64*1024) >> 4;
-	/* XXX: Documentation/i386/boot.txt says 'sp' must equal heap_end */
-	regs16.esp = 0xFFFC;
 	if (real_mode_entry) {
+		regs16.ds = regs16.es = regs16.fs = regs16.gs = setup_base >> 4;
+		regs16.cs = regs16.ds + 0x20;
+		regs16.ip = 0;
+		/* XXX: Documentation/i386/boot.txt says 'ss' must equal 'ds' */
+		regs16.ss = (elf_rel_get_addr(&info->rhdr, "stack_end") - 64*1024) >> 4;
+		/* XXX: Documentation/i386/boot.txt says 'sp' must equal heap_end */
+		regs16.esp = 0xFFFC;
+
 		printf("Starting the kernel in real mode\n");
 		regs32.eip = elf_rel_get_addr(&info->rhdr, "entry16");
+		real_mode->kernel_start = kernel32_load_addr;
 	}
 	if (real_mode_entry && kexec_debug) {
 		unsigned long entry16_debug, pre32, first32;
@@ -331,10 +364,14 @@ int do_bzImage_load(struct kexec_info *info,
 	
 		regs32.eip = entry16_debug;
 	}
-	elf_rel_set_symbol(&info->rhdr, "entry16_regs", &regs16, sizeof(regs16));
-	elf_rel_set_symbol(&info->rhdr, "entry16_debug_regs", &regs16, sizeof(regs16));
+	if (real_mode_entry) {
+		elf_rel_set_symbol(&info->rhdr, "entry16_regs",
+					 &regs16, sizeof(regs16));
+		elf_rel_set_symbol(&info->rhdr, "entry16_debug_regs",
+					 &regs16, sizeof(regs16));
+	}
 	elf_rel_set_symbol(&info->rhdr, "entry32_regs", &regs32, sizeof(regs32));
-	cmdline_end = setup_base + kern16_size + command_line_len - 1;
+	cmdline_end = setup_base + kern16_size_needed + command_line_len - 1;
 	elf_rel_set_symbol(&info->rhdr, "cmdline_end", &cmdline_end,
 			   sizeof(unsigned long));
 
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
