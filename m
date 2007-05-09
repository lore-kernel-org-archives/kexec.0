Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound-dub.frontbridge.com ([213.199.154.16]
	helo=outbound5-dub-R.bigfish.com)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hltto-0005rm-GJ
	for kexec@lists.infradead.org; Wed, 09 May 2007 22:40:45 +0100
Message-ID: <46423FCB.4080200@am.sony.com>
Date: Wed, 09 May 2007 14:40:27 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: [patch 2/2] kexec rename dprintf to dbgprintf
References: <20070507235727.631477448@am.sony.com>>
	<463FBE27.4060402@am.sony.com> <20070508061204.GD8170@verge.net.au>
In-Reply-To: <20070508061204.GD8170@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

The recently introduce kexec debug routine dprintf clashes with an existing
libc symbol.  Rename dprintf to dbgprintf.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 kexec/arch/i386/crashdump-x86.c   |    4 ++--
 kexec/arch/i386/kexec-bzImage.c   |    8 ++++----
 kexec/arch/i386/x86-linux-setup.c |    4 ++--
 kexec/arch/ppc64/kexec-ppc64.c    |    2 +-
 kexec/crashdump-elf.c             |   16 ++++++++--------
 kexec/kexec.h                     |    4 ++--
 6 files changed, 19 insertions(+), 19 deletions(-)

--- ps3-kexec-tools.orig/kexec/arch/i386/crashdump-x86.c
+++ ps3-kexec-tools/kexec/arch/i386/crashdump-x86.c
@@ -515,7 +515,7 @@ int load_crashdump_segments(struct kexec
 	memset(tmp, 0, sz);
 	info->backup_start = add_buffer(info, tmp, sz, sz, align,
 				0, max_addr, -1);
-	dprintf("Created backup segment at 0x%lx\n", info->backup_start);
+	dbgprintf("Created backup segment at 0x%lx\n", info->backup_start);
 	if (delete_memmap(memmap_p, info->backup_start, sz) < 0)
 		return -1;
 
@@ -544,7 +544,7 @@ int load_crashdump_segments(struct kexec
 	 */
 	elfcorehdr = add_buffer(info, tmp, sz, 16*1024, align, min_base,
 							max_addr, -1);
-	dprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
+	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
 	if (delete_memmap(memmap_p, elfcorehdr, sz) < 0)
 		return -1;
 	cmdline_add_memmap(mod_cmdline, memmap_p);
--- ps3-kexec-tools.orig/kexec/arch/i386/kexec-bzImage.c
+++ ps3-kexec-tools/kexec/arch/i386/kexec-bzImage.c
@@ -136,7 +136,7 @@ int do_bzImage_load(struct kexec_info *i
 
 	if (setup_header.protocol_version >= 0x0205) {
 		relocatable_kernel = setup_header.relocatable_kernel;
-		dprintf("bzImage is relocatable\n");
+		dbgprintf("bzImage is relocatable\n");
 	}
 
 	/* Can't use bzImage for crash dump purposes with real mode entry */
@@ -192,7 +192,7 @@ int do_bzImage_load(struct kexec_info *i
 	else
 		elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size,
 					0x3000, 640*1024, -1, 0);
-	dprintf("Loaded purgatory at addr 0x%lx\n", info->rhdr.rel_addr);
+	dbgprintf("Loaded purgatory at addr 0x%lx\n", info->rhdr.rel_addr);
 	/* The argument/parameter segment */
 	setup_size = kern16_size + command_line_len;
 	real_mode = xmalloc(setup_size);
@@ -214,7 +214,7 @@ int do_bzImage_load(struct kexec_info *i
 		add_segment(info, real_mode, setup_size, SETUP_BASE, setup_size);
 		setup_base = SETUP_BASE;
 	}
-	dprintf("Loaded real-mode code and command line at 0x%lx\n",
+	dbgprintf("Loaded real-mode code and command line at 0x%lx\n",
 			setup_base);
 
 	/* Verify purgatory loads higher than the parameters */
@@ -246,7 +246,7 @@ int do_bzImage_load(struct kexec_info *i
 				kernel32_load_addr, size);
 	}
 		
-	dprintf("Loaded 32bit kernel at 0x%lx\n", kernel32_load_addr);
+	dbgprintf("Loaded 32bit kernel at 0x%lx\n", kernel32_load_addr);
 
 	/* Tell the kernel what is going on */
 	setup_linux_bootloader_parameters(info, real_mode, setup_base,
--- ps3-kexec-tools.orig/kexec/arch/i386/x86-linux-setup.c
+++ ps3-kexec-tools/kexec/arch/i386/x86-linux-setup.c
@@ -61,7 +61,7 @@ void setup_linux_bootloader_parameters(
 	initrd_addr_max = DEFAULT_INITRD_ADDR_MAX;
 	if (real_mode->protocol_version >= 0x0203) {
 		initrd_addr_max = real_mode->initrd_addr_max;
-		dprintf("initrd_addr_max is 0x%lx\n", initrd_addr_max);
+		dbgprintf("initrd_addr_max is 0x%lx\n", initrd_addr_max);
 	}
 
 	/* Load the initrd if we have one */
@@ -69,7 +69,7 @@ void setup_linux_bootloader_parameters(
 		initrd_base = add_buffer(info,
 			initrd_buf, initrd_size, initrd_size,
 			4096, INITRD_BASE, initrd_addr_max, -1);
-		dprintf("Loaded initrd at 0x%lx size 0x%lx\n", initrd_base,
+		dbgprintf("Loaded initrd at 0x%lx size 0x%lx\n", initrd_base,
 			initrd_size);
 	} else {
 		initrd_base = 0;
--- ps3-kexec-tools.orig/kexec/arch/ppc64/kexec-ppc64.c
+++ ps3-kexec-tools/kexec/arch/ppc64/kexec-ppc64.c
@@ -207,7 +207,7 @@ static int get_base_ranges(void)
 				((unsigned long long *)buf)[1];
 			base_memory_range[local_memory_ranges].type = RANGE_RAM;
 			local_memory_ranges++;
-			dprintf("%016llx-%016llx : %x\n",
+			dbgprintf("%016llx-%016llx : %x\n",
 				base_memory_range[local_memory_ranges-1].start,
 				base_memory_range[local_memory_ranges-1].end,
 				base_memory_range[local_memory_ranges-1].type);
--- ps3-kexec-tools.orig/kexec/crashdump-elf.c
+++ ps3-kexec-tools/kexec/crashdump-elf.c
@@ -4,17 +4,17 @@
 #endif
 
 #if (ELF_WIDTH == 64)
-#define dprintf_phdr(prefix, phdr)					\
+#define dbgprintf_phdr(prefix, phdr)					\
 do {									\
-	dprintf("%s: p_type = %u, p_offset = 0x%lx p_paddr = 0x%lx "	\
+	dbgprintf("%s: p_type = %u, p_offset = 0x%lx p_paddr = 0x%lx "	\
 		"p_vaddr = 0x%lx p_filesz = 0x%lx p_memsz = 0x%lx\n",	\
 		(prefix), (phdr)->p_type, (phdr)->p_offset, (phdr)->p_paddr, \
 		(phdr)->p_vaddr, (phdr)->p_filesz, (phdr)->p_memsz);	\
 } while(0)
 #else
-#define dprintf_phdr(prefix, phdr)					\
+#define dbgprintf_phdr(prefix, phdr)					\
 do {									\
-	dprintf("%s: p_type = %u, p_offset = 0x%x " "p_paddr = 0x%x "	\
+	dbgprintf("%s: p_type = %u, p_offset = 0x%x " "p_paddr = 0x%x "	\
 		"p_vaddr = 0x%x p_filesz = 0x%x p_memsz = 0x%x\n",	\
 		(prefix), (phdr)->p_type, (phdr)->p_offset, (phdr)->p_paddr, \
 		(phdr)->p_vaddr, (phdr)->p_filesz, (phdr)->p_memsz);	\
@@ -143,7 +143,7 @@ int FUNC(struct kexec_info *info,
 
 		/* Increment number of program headers. */
 		(elf->e_phnum)++;
-		dprintf_phdr("Elf header", phdr);
+		dbgprintf_phdr("Elf header", phdr);
 	}
 
 	/* Setup an PT_LOAD type program header for the region where
@@ -160,7 +160,7 @@ int FUNC(struct kexec_info *info,
 		phdr->p_filesz	= phdr->p_memsz	= info->kern_size;
 		phdr->p_align	= 0;
 		(elf->e_phnum)++;
-		dprintf_phdr("Kernel text Elf header", phdr);
+		dbgprintf_phdr("Kernel text Elf header", phdr);
 	}
 
 	/* Setup PT_LOAD type program header for every system RAM chunk.
@@ -201,9 +201,9 @@ int FUNC(struct kexec_info *info,
 
 		/* Increment number of program headers. */
 		(elf->e_phnum)++;
-		dprintf_phdr("Elf header", phdr);
+		dbgprintf_phdr("Elf header", phdr);
 	}
 	return 0;
 }
 
-#undef dprintf_phdr
+#undef dbgprintf_phdr
--- ps3-kexec-tools.orig/kexec/kexec.h
+++ ps3-kexec-tools/kexec/kexec.h
@@ -218,10 +218,10 @@ int parse_iomem_single(char *str, uint64
 #define MAX_LINE	160
 
 #ifdef DEBUG
-#define dprintf(_args...) do {printf(_args);} while(0)
+#define dbgprintf(_args...) do {printf(_args);} while(0)
 #else
 static inline int __attribute__ ((format (printf, 1, 2)))
-	dprintf(const char *fmt, ...) {return 0;}
+	dbgprintf(const char *fmt, ...) {return 0;}
 #endif
 
 #endif /* KEXEC_H */



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
