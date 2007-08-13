Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IKUYD-00071e-Pn
	for kexec@lists.infradead.org; Mon, 13 Aug 2007 03:41:24 -0400
Subject: [RFC][PATCH 3/3] Embed vmcoreinfo into kernel file
In-reply-to: <20070813163212oomichi@mail.jp.nec.com>
Message-Id: <20070813163934oomichi@mail.jp.nec.com>
References: <20070813163212oomichi@mail.jp.nec.com>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Mon, 13 Aug 2007 16:39:34 +0900
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
To: kexec-ml <kexec@lists.infradead.org>
Cc: Don Zickus <dzickus@redhat.com>, Bernhard Walle <bwalle@suse.de>, Vivek Goyal <vgoyal@in.ibm.com>, Neil Horman <nhorman@redhat.com>, Dan Aloni <da-x@monatomic.org>


Patches:
- [3/3] patch for makedumpfile-v1.1.6.

---
Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>

---
diff -puN backup/v1.1.6/ia64.c makedumpfile/ia64.c
--- backup/v1.1.6/ia64.c	2007-08-13 12:01:55.000000000 +0900
+++ makedumpfile/ia64.c	2007-08-13 12:03:00.000000000 +0900
@@ -70,6 +70,10 @@ get_machdep_info_ia64()
 	else
 		info->vmalloc_start = KERNEL_VMALLOC_BASE;
 
+	if ((vt.mem_flags & MEMORY_PAGETABLE_4L)
+	    || (vt.mem_flags & MEMORY_PAGETABLE_3L))
+		return TRUE;
+
 	/*
 	 * Check the pgtable (3 Levels or 4 Levels).
 	 */
diff -puN backup/v1.1.6/makedumpfile.c makedumpfile/makedumpfile.c
--- backup/v1.1.6/makedumpfile.c	2007-08-13 12:01:55.000000000 +0900
+++ makedumpfile/makedumpfile.c	2007-08-13 12:03:00.000000000 +0900
@@ -608,7 +608,7 @@ open_files_for_creating_dumpfile()
 	if (info->flag_read_vmcoreinfo) {
 		if (!open_vmcoreinfo("r"))
 			return FALSE;
-	} else if (info->dump_level > DL_EXCLUDE_ZERO) {
+	} else if (dwarf_info.vmlinux_name) {
 		if (!open_kernel_file())
 			return FALSE;
 	}
@@ -2053,8 +2053,17 @@ read_vmcoreinfo_basic_info()
 				return FALSE;
 			}
 		}
-		if (get_release && page_size)
-			break;
+		if (strncmp(buf, STR_CONFIG_X86_PAE,
+		    strlen(STR_CONFIG_X86_PAE)) == 0)
+			vt.mem_flags |= MEMORY_X86_PAE;
+
+		if (strncmp(buf, STR_CONFIG_PGTABLE_3,
+		    strlen(STR_CONFIG_PGTABLE_3)) == 0)
+			vt.mem_flags |= MEMORY_PAGETABLE_4L;
+
+		if (strncmp(buf, STR_CONFIG_PGTABLE_4,
+		    strlen(STR_CONFIG_PGTABLE_4)) == 0)
+			vt.mem_flags |= MEMORY_PAGETABLE_3L;
 	}
 	info->page_size = page_size;
 	info->page_shift = ffs(info->page_size) - 1;
@@ -2215,6 +2224,173 @@ read_vmcoreinfo()
 	return TRUE;
 }
 
+int
+get_pt_note_info(int *flag_elf64, off_t *offset, unsigned long *size)
+{
+	Elf64_Phdr phdr64;
+	Elf32_Phdr phdr32;
+	int i, phnum, num_load, elf_format;
+
+	(*offset) = 0;
+	(*size)   = 0;
+
+	elf_format = check_elf_format(info->fd_memory, info->name_memory,
+	    &phnum, &num_load);
+
+	if (elf_format == ELF64)
+		(*flag_elf64) = TRUE;
+	else if (elf_format == ELF32)
+		(*flag_elf64) = FALSE;
+	else {
+		return FALSE;
+	}
+	for (i = 0; i < phnum; i++) {
+		if (flag_elf64) { /* ELF64 */
+			if (!get_elf64_phdr(info->fd_memory, info->name_memory,
+			    i, &phdr64)) {
+				ERRMSG("Can't find Phdr %d.\n", i);
+				return FALSE;
+			}
+			if (phdr64.p_type != PT_NOTE)
+				continue;
+
+			(*offset) = phdr64.p_offset;
+			(*size)   = phdr64.p_filesz;
+			break;
+		} else {         /* ELF32 */
+			if (!get_elf32_phdr(info->fd_memory, info->name_memory,
+			    i, &phdr32)) {
+				ERRMSG("Can't find Phdr %d.\n", i);
+				return FALSE;
+			}
+			if (phdr32.p_type != PT_NOTE)
+				continue;
+
+			(*offset) = phdr32.p_offset;
+			(*size)   = phdr32.p_filesz;
+			break;
+		}
+	}
+	if (offset == 0 || size == 0) {
+		ERRMSG("Can't find PT_NOTE Phdr.\n");
+		return FALSE;
+	}
+	return TRUE;
+}
+
+int
+is_vmcoreinfo_in_vmcore(int *flag_found)
+{
+	off_t offset, off_note;
+	int flag_elf64;
+	unsigned long sz_note;
+	char buf[VMCOREINFO_NOTE_NAME_BYTES];
+	Elf64_Nhdr note64;
+	Elf32_Nhdr note32;
+
+	const off_t failed = (off_t)-1;
+
+	(*flag_found) = FALSE;
+
+	/*
+	 * Get information about PT_NOTE segment.
+	 */
+	if (!get_pt_note_info(&flag_elf64, &off_note, &sz_note))
+		return FALSE;
+
+	offset = off_note;
+	while (offset < off_note + sz_note) {
+		if (lseek(info->fd_memory, offset, SEEK_SET) == failed) {
+			ERRMSG("Can't seek the dump memory(%s). %s\n",
+			    info->name_memory, strerror(errno));
+			return FALSE;
+		}
+		if (flag_elf64) {
+			if (read(info->fd_memory, &note64, sizeof(note64))
+			    != sizeof(note64)) {
+				ERRMSG("Can't read the dump memory(%s). %s\n",
+				    info->name_memory, strerror(errno));
+				return FALSE;
+			}
+		} else {
+			if (read(info->fd_memory, &note32, sizeof(note32))
+			    != sizeof(note32)) {
+				ERRMSG("Can't read the dump memory(%s). %s\n",
+				    info->name_memory, strerror(errno));
+				return FALSE;
+			}
+		}
+		if (read(info->fd_memory, &buf, sizeof(buf)) != sizeof(buf)) {
+			ERRMSG("Can't read the dump memory(%s). %s\n",
+			    info->name_memory, strerror(errno));
+			return FALSE;
+		}
+		if (strncmp(VMCOREINFO_NOTE_NAME, buf,
+		    VMCOREINFO_NOTE_NAME_BYTES)) {
+			offset += sizeof(Elf64_Nhdr)
+			    + ((note64.n_namesz + 3) & ~3)
+			    + ((note64.n_descsz + 3) & ~3);
+			continue;
+		}
+		if (flag_elf64) {
+			info->offset_vmcoreinfo = offset + (sizeof(note64)
+			    + ((note64.n_namesz + 3) & ~3));
+			info->size_vmcoreinfo = note64.n_descsz;
+		} else {
+			info->offset_vmcoreinfo = offset + (sizeof(note64)
+			    + ((note32.n_namesz + 3) & ~3));
+			info->size_vmcoreinfo = note32.n_descsz;
+		}
+		(*flag_found) = TRUE;
+		break;
+	}
+	return TRUE;
+}
+
+/*
+ * Extract vmcoreinfo from /proc/vmcore and output it to /tmp/vmcoreinfo.tmp.
+ */
+int
+copy_vmcoreinfo()
+{
+	int fd;
+	char buf[VMCOREINFO_BYTES];
+	const off_t failed = (off_t)-1;
+
+	if (!info->offset_vmcoreinfo || !info->size_vmcoreinfo)
+		return FALSE;
+
+	if ((fd = open(info->name_vmcoreinfo, O_RDWR|O_CREAT,
+	    S_IRUSR|S_IWUSR)) < 0) {
+		ERRMSG("Can't open the vmcoreinfo file(%s). %s\n",
+		    info->name_vmcoreinfo, strerror(errno));
+		return FALSE;
+	}
+	if (lseek(info->fd_memory, info->offset_vmcoreinfo, SEEK_SET)
+	    == failed) {
+		ERRMSG("Can't seek the dump memory(%s). %s\n",
+		    info->name_memory, strerror(errno));
+		return FALSE;
+	}
+	if (read(info->fd_memory, &buf, info->size_vmcoreinfo)
+	    != info->size_vmcoreinfo) {
+		ERRMSG("Can't read the dump memory(%s). %s\n",
+		    info->name_memory, strerror(errno));
+		return FALSE;
+	}
+	if (write(fd, &buf, info->size_vmcoreinfo) != info->size_vmcoreinfo) {
+		ERRMSG("Can't write the vmcoreinfo file(%s). %s\n",
+		    info->name_vmcoreinfo, strerror(errno));
+		return FALSE;
+	}
+	if (close(fd) < 0) {
+		ERRMSG("Can't close the vmcoreinfo file(%s). %s\n",
+		    info->name_vmcoreinfo, strerror(errno));
+		return FALSE;
+	}
+	return TRUE;
+}
+
 /*
  * Get the number of online nodes.
  */
@@ -2892,12 +3068,20 @@ get_mem_map()
 int
 initial()
 {
+	int vmcoreinfo_in_vmcore = FALSE;
+
 	if (!get_elf_info())
 		return FALSE;
 
 	if (!get_phys_base())
 		return FALSE;
 
+	if (info->dump_level <= DL_EXCLUDE_ZERO) {
+		if (!get_mem_map_without_mm())
+			return FALSE;
+		else
+			return TRUE;
+	}
 	/*
 	 * Get the debug information for analysis from the vmcoreinfo file 
 	 */
@@ -2907,22 +3091,53 @@ initial()
 	/*
 	 * Get the debug information for analysis from the kernel file 
 	 */
-	} else {
-		if (info->dump_level <= DL_EXCLUDE_ZERO) {
-			if (!get_mem_map_without_mm())
-				return FALSE;
-			else
-				return TRUE;
-		} else {
-			if (!get_symbol_info())
-				return FALSE;
-		}
+	} else if (info->flag_vmlinux) {
+		if (!get_symbol_info())
+			return FALSE;
+
 		if (!get_structure_info())
 			return FALSE;
 
 		if (!get_srcfile_info())
 			return FALSE;
+	/*
+	 * Get the debug information for analysis from /proc/vmcore
+	 */
+	} else {
+		/*
+		 * Check weather /proc/vmcore contains vmcoreinfo,
+		 * and get both the offset and the size.
+		 */
+		if (!is_vmcoreinfo_in_vmcore(&vmcoreinfo_in_vmcore))
+			return FALSE;
+
+		if (!vmcoreinfo_in_vmcore) {
+			MSG("%s doesn't contain vmcoreinfo.\n", info->name_memory);
+			MSG("'-x' or '-i' must be specified.\n");
+			return FALSE;
+		}
+		/*
+		 * Copy vmcoreinfo to /tmp/vmcoreinfo.
+		 */
+		if ((info->name_vmcoreinfo
+		    = malloc(sizeof(FILENAME_VMCOREINFO))) == NULL) {
+			ERRMSG("Can't allocate memory for the filename. %s\n",
+			    strerror(errno));
+			return FALSE;
+		}
+		strcpy(info->name_vmcoreinfo, FILENAME_VMCOREINFO);
+		if (!copy_vmcoreinfo())
+			return FALSE;
+		/*
+		 * Read vmcoreinfo from /tmp/vmcoreinfo.
+		 */
+		if (!open_vmcoreinfo("r"))
+			return FALSE;
+		if (!read_vmcoreinfo())
+			return FALSE;
+		unlink(info->name_vmcoreinfo);
 	}
+
 	if (!get_machdep_info())
 		return FALSE;
 
diff -puN backup/v1.1.6/makedumpfile.h makedumpfile/makedumpfile.h
--- backup/v1.1.6/makedumpfile.h	2007-08-13 12:01:55.000000000 +0900
+++ makedumpfile/makedumpfile.h	2007-08-13 12:03:00.000000000 +0900
@@ -70,6 +70,7 @@ enum {
  */
 #define MEMORY_PAGETABLE_4L	(1 << 0)
 #define MEMORY_PAGETABLE_3L	(1 << 1)
+#define MEMORY_X86_PAE		(1 << 2)
 
 /*
  * Type of address
@@ -366,15 +367,26 @@ do { \
 #define LATEST_VERSION		(0x02060016)	/* linux-2.6.22 */
 
 /*
+ * vmcoreinfo in /proc/vmcore
+ */
+#define VMCOREINFO_BYTES		(4096)
+#define VMCOREINFO_NOTE_NAME		"VMCOREINFO"
+#define VMCOREINFO_NOTE_NAME_BYTES	(sizeof(VMCOREINFO_NOTE_NAME))
+#define FILENAME_VMCOREINFO		"/tmp/vmcoreinfo.tmp"
+
+/*
  * field name of vmcoreinfo file
  */
-#define STR_OSRELEASE	"OSRELEASE="
-#define STR_PAGESIZE	"PAGESIZE="
-#define STR_SYMBOL(X)	"SYMBOL("X")="
-#define STR_SIZE(X)	"SIZE("X")="
-#define STR_OFFSET(X)	"OFFSET("X")="
-#define STR_LENGTH(X)	"LENGTH("X")="
-#define STR_SRCFILE(X)	"SRCFILE("X")="
+#define STR_OSRELEASE		"OSRELEASE="
+#define STR_PAGESIZE		"PAGESIZE="
+#define STR_SYMBOL(X)		"SYMBOL("X")="
+#define STR_SIZE(X)		"SIZE("X")="
+#define STR_OFFSET(X)		"OFFSET("X")="
+#define STR_LENGTH(X)		"LENGTH("X")="
+#define STR_SRCFILE(X)		"SRCFILE("X")="
+#define STR_CONFIG_X86_PAE	"CONFIG_X86_PAE=y"
+#define STR_CONFIG_PGTABLE_4	"CONFIG_PGTABLE_4=y"
+#define STR_CONFIG_PGTABLE_3	"CONFIG_PGTABLE_3=y"
 
 /*
  * common value
@@ -664,6 +676,12 @@ struct DumpInfo {
 	char			release[STRLEN_OSRELEASE];
 
 	/*
+	 * vmcoreinfo in dump memory image info:
+	 */
+	off_t			offset_vmcoreinfo;
+	unsigned long		size_vmcoreinfo;
+
+	/*
 	 * for Xen extraction
 	 */
 	unsigned long xen_heap_start;	/* start mfn of xen heap area */
diff -puN backup/v1.1.6/x86.c makedumpfile/x86.c
--- backup/v1.1.6/x86.c	2007-08-13 12:01:55.000000000 +0900
+++ makedumpfile/x86.c	2007-08-13 12:03:00.000000000 +0900
@@ -21,10 +21,11 @@ int
 get_machdep_info_x86()
 {
 	/* PAE */
-	if ((SYMBOL(pkmap_count) != NOT_FOUND_SYMBOL)
-	    && (SYMBOL(pkmap_count_next) != NOT_FOUND_SYMBOL)
-	    && ((SYMBOL(pkmap_count_next)-SYMBOL(pkmap_count))/sizeof(int))
-	    == 512) {
+	if ((vt.mem_flags & MEMORY_X86_PAE)
+	    || ((SYMBOL(pkmap_count) != NOT_FOUND_SYMBOL)
+	      && (SYMBOL(pkmap_count_next) != NOT_FOUND_SYMBOL)
+	      && ((SYMBOL(pkmap_count_next)-SYMBOL(pkmap_count))/sizeof(int))
+	      == 512)) {
 		DEBUG_MSG("\n");
 		DEBUG_MSG("PAE          : ON\n");
 		info->section_size_bits = _SECTION_SIZE_BITS_PAE;
_

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
