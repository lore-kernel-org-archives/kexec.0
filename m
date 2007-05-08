Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HlIvy-0001dL-EG
	for kexec@lists.infradead.org; Tue, 08 May 2007 07:12:28 +0100
Date: Tue, 8 May 2007 15:12:05 +0900
From: Simon Horman <horms@verge.net.au>
Subject: use dprintf
Message-ID: <20070508061204.GD8170@verge.net.au>
References: <20070507235727.631477448@am.sony.com>>
	<463FBE27.4060402@am.sony.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <463FBE27.4060402@am.sony.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: kexec@lists.infradead.org

Use the new fprintf macro where possible

Cc: Geoff Levand <geoffrey.levand@am.sony.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

--- 
 kexec/arch/i386/crashdump-x86.c   |    5 ++---
 kexec/arch/i386/kexec-bzImage.c   |    9 ++++-----
 kexec/arch/i386/x86-linux-setup.c |    6 +++---
 kexec/crashdump-elf.c             |   30 ++++++++++++++----------------
 4 files changed, 23 insertions(+), 27 deletions(-)

Index: kexec-tools-testing-geoff-levand/kexec/arch/i386/crashdump-x86.c
===================================================================
--- kexec-tools-testing-geoff-levand.orig/kexec/arch/i386/crashdump-x86.c	2007-05-08 12:08:53.000000000 +0900
+++ kexec-tools-testing-geoff-levand/kexec/arch/i386/crashdump-x86.c	2007-05-08 12:10:58.000000000 +0900
@@ -515,8 +515,7 @@ int load_crashdump_segments(struct kexec
 	memset(tmp, 0, sz);
 	info->backup_start = add_buffer(info, tmp, sz, sz, align,
 				0, max_addr, -1);
-	dfprintf(stdout, "Created backup segment at 0x%lx\n",
-				info->backup_start);
+	dprintf("Created backup segment at 0x%lx\n", info->backup_start);
 	if (delete_memmap(memmap_p, info->backup_start, sz) < 0)
 		return -1;
 
@@ -545,7 +544,7 @@ int load_crashdump_segments(struct kexec
 	 */
 	elfcorehdr = add_buffer(info, tmp, sz, 16*1024, align, min_base,
 							max_addr, -1);
-	dfprintf(stdout, "Created elf header segment at 0x%lx\n", elfcorehdr);
+	dprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
 	if (delete_memmap(memmap_p, elfcorehdr, sz) < 0)
 		return -1;
 	cmdline_add_memmap(mod_cmdline, memmap_p);
Index: kexec-tools-testing-geoff-levand/kexec/arch/i386/kexec-bzImage.c
===================================================================
--- kexec-tools-testing-geoff-levand.orig/kexec/arch/i386/kexec-bzImage.c	2007-05-08 12:08:53.000000000 +0900
+++ kexec-tools-testing-geoff-levand/kexec/arch/i386/kexec-bzImage.c	2007-05-08 12:10:58.000000000 +0900
@@ -136,7 +136,7 @@ int do_bzImage_load(struct kexec_info *i
 
 	if (setup_header.protocol_version >= 0x0205) {
 		relocatable_kernel = setup_header.relocatable_kernel;
-		dfprintf(stdout, "bzImage is relocatable\n");
+		dprintf("bzImage is relocatable\n");
 	}
 
 	/* Can't use bzImage for crash dump purposes with real mode entry */
@@ -192,8 +192,7 @@ int do_bzImage_load(struct kexec_info *i
 	else
 		elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size,
 					0x3000, 640*1024, -1, 0);
-	dfprintf(stdout, "Loaded purgatory at addr 0x%lx\n",
-				info->rhdr.rel_addr);
+	dprintf("Loaded purgatory at addr 0x%lx\n", info->rhdr.rel_addr);
 	/* The argument/parameter segment */
 	setup_size = kern16_size + command_line_len;
 	real_mode = xmalloc(setup_size);
@@ -215,7 +214,7 @@ int do_bzImage_load(struct kexec_info *i
 		add_segment(info, real_mode, setup_size, SETUP_BASE, setup_size);
 		setup_base = SETUP_BASE;
 	}
-	dfprintf(stdout, "Loaded real-mode code and command line at 0x%lx\n",
+	dprintf("Loaded real-mode code and command line at 0x%lx\n",
 			setup_base);
 
 	/* Verify purgatory loads higher than the parameters */
@@ -247,7 +246,7 @@ int do_bzImage_load(struct kexec_info *i
 				kernel32_load_addr, size);
 	}
 		
-	dfprintf(stdout, "Loaded 32bit kernel at 0x%lx\n", kernel32_load_addr);
+	dprintf("Loaded 32bit kernel at 0x%lx\n", kernel32_load_addr);
 
 	/* Tell the kernel what is going on */
 	setup_linux_bootloader_parameters(info, real_mode, setup_base,
Index: kexec-tools-testing-geoff-levand/kexec/arch/i386/x86-linux-setup.c
===================================================================
--- kexec-tools-testing-geoff-levand.orig/kexec/arch/i386/x86-linux-setup.c	2007-05-08 12:08:53.000000000 +0900
+++ kexec-tools-testing-geoff-levand/kexec/arch/i386/x86-linux-setup.c	2007-05-08 12:10:58.000000000 +0900
@@ -61,7 +61,7 @@ void setup_linux_bootloader_parameters(
 	initrd_addr_max = DEFAULT_INITRD_ADDR_MAX;
 	if (real_mode->protocol_version >= 0x0203) {
 		initrd_addr_max = real_mode->initrd_addr_max;
-		dfprintf(stdout, "initrd_addr_max is 0x%lx\n", initrd_addr_max);
+		dprintf("initrd_addr_max is 0x%lx\n", initrd_addr_max);
 	}
 
 	/* Load the initrd if we have one */
@@ -69,8 +69,8 @@ void setup_linux_bootloader_parameters(
 		initrd_base = add_buffer(info,
 			initrd_buf, initrd_size, initrd_size,
 			4096, INITRD_BASE, initrd_addr_max, -1);
-		dfprintf(stdout, "Loaded initrd at 0x%lx size 0x%lx\n",
-					initrd_base, initrd_size);
+		dprintf("Loaded initrd at 0x%lx size 0x%lx\n", initrd_base,
+			initrd_size);
 	} else {
 		initrd_base = 0;
 		initrd_size = 0;
Index: kexec-tools-testing-geoff-levand/kexec/crashdump-elf.c
===================================================================
--- kexec-tools-testing-geoff-levand.orig/kexec/crashdump-elf.c	2007-05-08 12:08:53.000000000 +0900
+++ kexec-tools-testing-geoff-levand/kexec/crashdump-elf.c	2007-05-08 12:12:03.000000000 +0900
@@ -4,22 +4,20 @@
 #endif
 
 #if (ELF_WIDTH == 64)
-#define dfprintf_phdr(fh, prefix, phdr)					\
+#define dprintf_phdr(prefix, phdr)					\
 do {									\
-	dfprintf((fh),							\
-		 "%s: p_type = %u, p_offset = 0x%lx p_paddr = 0x%lx "	\
-		 "p_vaddr = 0x%lx p_filesz = 0x%lx p_memsz = 0x%lx\n",	\
-		 (prefix), (phdr)->p_type, (phdr)->p_offset, (phdr)->p_paddr, \
-		 (phdr)->p_vaddr, (phdr)->p_filesz, (phdr)->p_memsz);	\
+	dprintf("%s: p_type = %u, p_offset = 0x%lx p_paddr = 0x%lx "	\
+		"p_vaddr = 0x%lx p_filesz = 0x%lx p_memsz = 0x%lx\n",	\
+		(prefix), (phdr)->p_type, (phdr)->p_offset, (phdr)->p_paddr, \
+		(phdr)->p_vaddr, (phdr)->p_filesz, (phdr)->p_memsz);	\
 } while(0)
 #else
-#define dfprintf_phdr(fh, prefix, phdr)					\
+#define dprintf_phdr(prefix, phdr)					\
 do {									\
-	dfprintf((fh),							\
-		 "%s: p_type = %u, p_offset = 0x%x " "p_paddr = 0x%x "	\
-		 "p_vaddr = 0x%x p_filesz = 0x%x p_memsz = 0x%x\n",	\
-		 (prefix), (phdr)->p_type, (phdr)->p_offset, (phdr)->p_paddr, \
-		 (phdr)->p_vaddr, (phdr)->p_filesz, (phdr)->p_memsz);	\
+	dprintf("%s: p_type = %u, p_offset = 0x%x " "p_paddr = 0x%x "	\
+		"p_vaddr = 0x%x p_filesz = 0x%x p_memsz = 0x%x\n",	\
+		(prefix), (phdr)->p_type, (phdr)->p_offset, (phdr)->p_paddr, \
+		(phdr)->p_vaddr, (phdr)->p_filesz, (phdr)->p_memsz);	\
 } while(0)
 #endif
 
@@ -145,7 +143,7 @@ int FUNC(struct kexec_info *info,
 
 		/* Increment number of program headers. */
 		(elf->e_phnum)++;
-		dfprintf_phdr(stdout, "Elf header", phdr);
+		dprintf_phdr("Elf header", phdr);
 	}
 
 	/* Setup an PT_LOAD type program header for the region where
@@ -162,7 +160,7 @@ int FUNC(struct kexec_info *info,
 		phdr->p_filesz	= phdr->p_memsz	= info->kern_size;
 		phdr->p_align	= 0;
 		(elf->e_phnum)++;
-		dfprintf_phdr(stdout, "Kernel text Elf header", phdr);
+		dprintf_phdr("Kernel text Elf header", phdr);
 	}
 
 	/* Setup PT_LOAD type program header for every system RAM chunk.
@@ -203,9 +201,9 @@ int FUNC(struct kexec_info *info,
 
 		/* Increment number of program headers. */
 		(elf->e_phnum)++;
-		dfprintf_phdr(stdout, "Elf header", phdr);
+		dprintf_phdr("Elf header", phdr);
 	}
 	return 0;
 }
 
-#undef dfprintf_phdr
+#undef dprintf_phdr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
