Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from duke.felloff.net ([216.126.196.34])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fi70u-0002vc-NS
 for kexec@lists.infradead.org; Tue, 24 Jul 2018 23:46:46 +0000
Message-ID: <72596CBDC14AF81E1B081E6F724BFA83@felloff.net>
Subject: non-elf multiboot image support on x86
Date: Wed, 25 Jul 2018 01:46:24 +0200
From: cinap_lenrek@felloff.net
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

ok, this patch get me to load plan9 kernel.

also adds acpi memory types to multiboot memory map
instead of marking them as reserved. this is needed
for the kernel to locate acpi tables in lack of a
explicit rsd pointer.

sorry, not attaching this as a file as the list
appears to block my mails with file attachments.

--
cinap

here we go...

diff --git a/kexec/arch/i386/kexec-multiboot-x86.c b/kexec/arch/i386/kexec-multiboot-x86.c
index 69027e2..e1b9703 100644
--- a/kexec/arch/i386/kexec-multiboot-x86.c
+++ b/kexec/arch/i386/kexec-multiboot-x86.c
@@ -8,7 +8,6 @@
  *  TODO:  
  *    - smarter allocation of new segments
  *    - proper support for the MULTIBOOT_VIDEO_MODE bit
- *    - support for the MULTIBOOT_AOUT_KLUDGE bit
  *
  *
  *  Copyright (C) 2003  Tim Deegan (tjd21 at cl.cam.ac.uk)
@@ -59,6 +58,7 @@
 /* Static storage */
 static char headerbuf[MULTIBOOT_SEARCH];
 static struct multiboot_header *mbh = NULL;
+static off_t mbh_offset = 0;
 
 #define MIN(_x,_y) (((_x)<=(_y))?(_x):(_y))
 
@@ -67,10 +67,6 @@ int multiboot_x86_probe(const char *buf, off_t buf_len)
 /* Is it a good idea to try booting this file? */
 {
 	int i, len;
-	/* First of all, check that this is an ELF file */
-	if ((i=elf_x86_probe(buf, buf_len)) < 0) {
-		return i;
-	}
 	/* Now look for a multiboot header in the first 8KB */
 	len = MULTIBOOT_SEARCH;
 	if (len > buf_len) {
@@ -81,10 +77,10 @@ int multiboot_x86_probe(const char *buf, off_t buf_len)
 		/* Short file */
 		return -1;
 	}
-	for (i = 0; i <= (len - 12); i += 4)
+	for (mbh_offset = 0; mbh_offset <= (len - 12); mbh_offset += 4)
 	{
 		/* Search for a multiboot header */
-		mbh = (struct multiboot_header *)(headerbuf + i);
+		mbh = (struct multiboot_header *)(headerbuf + mbh_offset);
 		if (mbh->magic != MULTIBOOT_MAGIC 
 		    || ((mbh->magic+mbh->flags+mbh->checksum) & 0xffffffff))
 		{
@@ -92,13 +88,34 @@ int multiboot_x86_probe(const char *buf, off_t buf_len)
 			continue;
 		}
 		if (mbh->flags & MULTIBOOT_AOUT_KLUDGE) {
-			/* Requires options we don't support */
-			fprintf(stderr, 
-				"Found a multiboot header, but it uses "
-				"a non-ELF header layout,\n"
-				"and I can't do that (yet).  Sorry.\n");
-			return -1;
-		} 
+			if (mbh->load_addr & 0xfff) {
+				fprintf(stderr, "multiboot load address not 4k aligned\n");
+				return -1;
+			}
+			if (mbh->load_addr > mbh->header_addr) {
+				fprintf(stderr, "multiboot header address > load address\n");
+				return -1;
+			}
+			if (mbh->load_end_addr < mbh->load_addr) {
+				fprintf(stderr, "multiboot load end address < load address\n");
+				return -1;
+			}
+			if (mbh->bss_end_addr < mbh->load_end_addr) {
+				fprintf(stderr, "multiboot bss end address < load end address\n");
+				return -1;
+			}
+			if (mbh->load_end_addr - mbh->header_addr < len - mbh_offset) {
+				fprintf(stderr, "multiboot file truncated\n");
+				return -1;
+			}
+			if (mbh->entry_addr < mbh->load_addr || mbh->entry_addr >= mbh->load_end_addr) {
+				fprintf(stderr, "multiboot entry out of range\n");
+				return -1;
+			}
+		} else {
+			if ((i=elf_x86_probe(buf, buf_len)) < 0)
+				return i;
+		}
 		if (mbh->flags & MULTIBOOT_UNSUPPORTED) {
 			/* Requires options we don't support */
 			fprintf(stderr, 
@@ -154,7 +171,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 	struct AddrRangeDesc *mmap;
 	int command_line_len;
 	int i, result;
-	uint32_t u;
+	uint32_t u, entry;
 	int opt;
 	int modules, mod_command_line_space;
 	/* See options.h -- add any more there, too. */
@@ -211,8 +228,18 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 	}
 	command_line_len = strlen(command_line) + 1;
 	
-	/* Load the ELF executable */
-	elf_exec_build_load(info, &ehdr, buf, len, 0);
+	if (mbh->flags & MULTIBOOT_AOUT_KLUDGE) {
+		add_segment(info,
+			buf + (mbh_offset - (mbh->header_addr - mbh->load_addr)),
+			mbh->load_end_addr - mbh->load_addr,
+			mbh->load_addr,
+			mbh->bss_end_addr - mbh->load_addr);
+		entry = mbh->entry_addr;
+	} else {
+		/* Load the ELF executable */
+		elf_exec_build_load(info, &ehdr, buf, len, 0);
+		entry = ehdr.e_entry;
+	}
 
 	/* Load the setup code */
 	elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size, 0,
@@ -259,7 +286,8 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 		mmap[i].base_addr_high  = range[i].start >> 32;
 		mmap[i].length_low     = length & 0xffffffff;
 		mmap[i].length_high    = length >> 32;
-		if (range[i].type == RANGE_RAM) {
+		switch (range[i].type) {
+		case RANGE_RAM:
 			mmap[i].Type = 1; /* RAM */
 			/*
                          * Is this the "low" memory?  Can't just test
@@ -277,7 +305,15 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 			if ((range[i].start <= 0x100000)
 			    && (range[i].end > mem_upper + 0x100000))
 				mem_upper = range[i].end - 0x100000;
-		} else {
+			break;
+		case RANGE_ACPI:
+			mmap[i].Type = 3;
+			break;
+		case RANGE_ACPI_NVS:
+			mmap[i].Type = 4;
+			break;
+		case RANGE_RESERVED:
+		default:
 			mmap[i].Type = 2;  /* Not RAM (reserved) */
 		}
 	}
@@ -384,7 +420,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 	elf_rel_get_symbol(&info->rhdr, "entry32_regs", &regs, sizeof(regs));
 	regs.eax = 0x2BADB002;
 	regs.ebx = mbi_offset;
-	regs.eip = ehdr.e_entry;
+	regs.eip = entry;
 	elf_rel_set_symbol(&info->rhdr, "entry32_regs", &regs, sizeof(regs));
 
 out:


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
