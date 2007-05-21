Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hq4FT-00086L-Dy
	for kexec@lists.infradead.org; Mon, 21 May 2007 05:32:22 -0400
Subject: Re: [PATCH] [makedumpfile] Implement memory regions on IA64
In-reply-to: <20070516202000oomichi@mail.jp.nec.com>
Message-Id: <20070521183227oomichi@mail.jp.nec.com>
References: <20070516202000oomichi@mail.jp.nec.com>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Mon, 21 May 2007 18:32:27 +0900
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
To: Bernhard Walle <bwalle@suse.de>
Cc: Jay Lan <jlan@sgi.com>, Kexec Mailing List <kexec@lists.infradead.org>


Hi Bernhard,

2007/05/16 20:20:00 +0900, "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp> wrote:
>I propose that makedumpfile distinguishes the page table (3L or 4L)
>by checking the defined file name of pud_t.
>I'm trying for the above implementation.
>I will send you the patch when it is complete.

The attached patch is for the above implementation.
It works fine with linux-2.6.18.
Could you test it with your environment ?

Please apply the attached patch with the following makedumpfile:

makedumpfile-1.1.3
 + 2007/05/11 by Ken'ichi, 01-vaddr_to_offset_ia64.patch 
 + 2007/05/11 by Ken'ichi, 02-ia64-discontigmem.patch
 + 2007/05/16 by Bernhard, [Re: Implement memory regions on IA64] patch
 + 2007/05/21 by Ken'ichi, [Re: Fix missing last node] patch


Thanks
Ken'ichi Ohmichi

--
diff -puN makedumpfile.org/ia64.c makedumpfile/ia64.c
--- makedumpfile.org/ia64.c	2007-05-21 19:20:06.000000000 +0900
+++ makedumpfile/ia64.c	2007-05-21 19:34:06.000000000 +0900
@@ -62,6 +62,15 @@ get_machdep_info_ia64(struct DumpInfo *i
 	info->section_size_bits = _SECTION_SIZE_BITS;
 	info->max_physmem_bits  = _MAX_PHYSMEM_BITS;
 
+	if (!strncmp(SRCFILE(pud_t), STR_PUD_T_4L, strlen(STR_PUD_T_4L)))
+		info->mem_flags |= MEMORY_4LAYER_PAGETABLE;
+
+	else if (!strncmp(SRCFILE(pud_t), STR_PUD_T_3L, strlen(STR_PUD_T_3L)))
+		info->mem_flags |= MEMORY_3LAYER_PAGETABLE;
+
+	else
+		MSG("Can't distinguish the pgtable.\n");
+
 	return TRUE;
 }
 
diff -puN makedumpfile.org/makedumpfile.c makedumpfile/makedumpfile.c
--- makedumpfile.org/makedumpfile.c	2007-05-21 19:20:06.000000000 +0900
+++ makedumpfile/makedumpfile.c	2007-05-21 19:28:54.000000000 +0900
@@ -26,6 +26,7 @@ struct symbol_table	symbol_table;
 struct size_table	size_table;
 struct offset_table	offset_table;
 struct array_table	array_table;
+struct srcfile_table	srcfile_table;
 
 struct dwarf_info	dwarf_info;
 struct vm_table		*vt = 0;
@@ -1141,6 +1142,15 @@ is_search_symbol(int cmd)
 		return FALSE;
 }
 
+int
+is_search_srcfile(int cmd)
+{
+	if (cmd == DWARF_INFO_GET_TYPEDEF_SRCNAME)
+		return TRUE;
+	else
+		return FALSE;
+}
+
 static void
 search_structure(Dwarf *dwarfd, Dwarf_Die *die, int *found)
 {
@@ -1190,6 +1200,49 @@ search_structure(Dwarf *dwarfd, Dwarf_Di
 }
 
 static void
+search_srcfile(Dwarf *dwarfd, Dwarf_Die *die, int *found)
+{
+	int tag = 0, rtag = 0;
+	char *src_name = NULL;
+	const char *name;
+
+	switch (dwarf_info.cmd) {
+	case DWARF_INFO_GET_TYPEDEF_SRCNAME:
+		rtag = DW_TAG_typedef;
+		break;
+	}
+
+	/*
+	 * If we get to here then we don't have any more
+	 * children, check to see if this is a relevant tag
+	 */
+	do {
+		tag  = dwarf_tag(die);
+		name = dwarf_diename(die);
+
+		if ((tag != rtag) || (!name)
+		    || strcmp(name, dwarf_info.decl_name))
+			continue;
+
+		src_name = (char *)dwarf_decl_file(die);
+
+		if (!src_name)
+			break;
+
+	} while (!dwarf_siblingof(die, die));
+
+	if (!src_name)
+		return;
+
+	/*
+	 * Found the demanded one.
+	 */
+	strncpy(dwarf_info.src_name, src_name, LEN_SRCFILE);
+
+	*found = TRUE;
+}
+
+static void
 search_symbol(Dwarf *dwarfd, Dwarf_Die *die, int *found)
 {
 	int tag;
@@ -1250,6 +1303,9 @@ search_die_tree(Dwarf *dwarfd, Dwarf_Die
 
 	else if (is_search_symbol(dwarf_info.cmd))
 		search_symbol(dwarfd, die, found);
+
+	else if (is_search_srcfile(dwarf_info.cmd))
+		search_srcfile(dwarfd, die, found);
 }
 
 int
@@ -1390,6 +1446,23 @@ get_array_length(char *name01, char *nam
 	return dwarf_info.array_length;
 }
 
+/*
+ * Get the source filename.
+ */
+int
+get_source_filename(char *decl_name, char *src_name, int cmd)
+{
+	dwarf_info.cmd = cmd;
+	dwarf_info.decl_name = decl_name;
+
+	if (!get_debug_info())
+		return FALSE;
+
+	strncpy(src_name, dwarf_info.src_name, LEN_SRCFILE);
+
+	return TRUE;
+}
+
 int
 get_symbol_info(struct DumpInfo *info)
 {
@@ -1420,174 +1493,6 @@ get_symbol_info(struct DumpInfo *info)
 	return TRUE;
 }
 
-
-int
-read_kernel_config(struct DumpInfo *info)
-{
-	int ii, ret, end, found=0;
-	unsigned long size, bufsz;
-	char *pos, *ln, *buf, *head, *tail, *val, *uncomp;
-	char line[512];
-	z_stream stream;
-	unsigned long kernel_config_data;
-
-	kernel_config_data = get_symbol_addr(info, "kernel_config_data");
-	if (kernel_config_data <= 0) {
-		ERRMSG("Can't read kernel cofiguration from kernel binary");
-		return FALSE;
-	}
-
-	/* We don't know how large IKCONFIG is, so we start with
-	 * 32k, if we can't find MAGIC_END assume we didn't read
-	 * enough, double it and try again.
-	 */
-	ii = 32;
-
-again:
-	size = ii * 1024;
-
-	if ((buf = (char *)malloc(size)) == NULL) {
-		MSG("cannot malloc IKCONFIG input buffer\n");
-		return FALSE;
-	}
-
-        if (!readmem(info, kernel_config_data, buf, size)) {
-		MSG("cannot read kernel_config_data\n");
-		goto out2;
-	}
-
-	/* Find the start */
-	if (strstr(buf, MAGIC_START))
-		head = buf + MAGIC_SIZE + 10; /* skip past MAGIC_START and gzip header */
-	else {
-		MSG("could not find MAGIC_START!\n");
-		goto out2;
-	}
-
-	tail = head;
-
-	end = strlen(MAGIC_END);
-
-	/* Find the end*/
-	while (tail < (buf + (size - 1))) {
-
-		if (strncmp(tail, MAGIC_END, end)==0) {
-			found = 1;
-			break;
-		}
-		tail++;
-	}
-
-	if (found) {
-		bufsz = tail - head;
-		size = 10 * bufsz;
-		if ((uncomp = (char *)malloc(size)) == NULL) {
-			MSG("cannot malloc IKCONFIG output buffer\n");
-			goto out2;
-		}
-	} else {
-		if (ii > 512) {
-			MSG("could not find MAGIC_END!\n");
-			goto out2;
-		} else {
-			free(buf);
-			ii *= 2;
-			goto again;
-		}
-	}
-
-
-	/* initialize zlib */
-	stream.next_in = (Bytef *)head;
-	stream.avail_in = (uInt)bufsz;
-
-	stream.next_out = (Bytef *)uncomp;
-	stream.avail_out = (uInt)size;
-
-	stream.zalloc = NULL;
-	stream.zfree = NULL;
-	stream.opaque = NULL;
-
-	ret = inflateInit2(&stream, -MAX_WBITS);
-	if (ret != Z_OK) {
-		ERRMSG("error while reading kernel config, inflateInit2 "
-				"returned %d\n", ret);
-		goto out1;
-	}
-
-	ret = inflate(&stream, Z_FINISH);
-
-	if (ret != Z_STREAM_END) {
-		inflateEnd(&stream);
-		if (ret == Z_NEED_DICT ||
-		   (ret == Z_BUF_ERROR && stream.avail_in == 0)) {
-			ERRMSG("error while reading kernel config, stream.avail_in = 0,"
-					"inflate returned %d\n", ret);
-			goto out1;
-		}
-		ERRMSG("error while reading kernel config, inflate returned"
-				"with %d\n", ret);
-		goto out1;
-	}
-	size = stream.total_out;
-
-	ret = inflateEnd(&stream);
-
-	pos = uncomp;
-
-	do {
-		ret = sscanf(pos, "%511[^\n]\n%n", line, &ii);
-		if (ret > 0) {
-			pos += ii;
-
-			ln = line;
-
-			/* skip leading whitespace */
-			while (is_blank(*ln))
-				ln++;
-
-			/* skip comments */
-			if (*ln == '#')
-				continue;
-
-			/* Find '=' */
-			if ((head = strchr(ln, '=')) != NULL) {
-				*head = '\0';
-				val = head + 1;
-
-				head--;
-
-				/* skip trailing whitespace */
-				while (is_blank(*head)) {
-					*head = '\0';
-					head--;
-				}
-
-				/* skip whitespace */
-				while (is_blank(*val))
-					val++;
-
-			} else /* Bad line, skip it */
-				continue;
-
-			if (strcmp(ln, "CONFIG_PGTABLE_4") == 0)
-				info->mem_flags |= MEMORY_4LAYER_PAGETABLE;
-		}
-	} while (ret > 0);
-
-
-	free(uncomp);
-	free(buf);
-	return TRUE;
-
-out1:
-	free(uncomp);
-out2:
-	free(buf);
-
-	return FALSE;
-}
-
 int
 get_structure_info(struct DumpInfo *info)
 {
@@ -1653,6 +1558,14 @@ get_structure_info(struct DumpInfo *info
 }
 
 int
+get_srcfile_info(struct DumpInfo *info)
+{
+	TYPEDEF_SRCFILE_INIT(pud_t, "pud_t");
+
+	return TRUE;
+}
+
+int
 is_sparsemem_extreme(struct DumpInfo *info)
 {
 	if (ARRAY_LENGTH(mem_section)
@@ -1722,6 +1635,9 @@ generate_config(struct DumpInfo *info)
 	if (!get_structure_info(info))
 		return FALSE;
 
+	if (!get_srcfile_info(info))
+		return FALSE;
+
 	if ((SYMBOL(system_utsname) == NOT_FOUND_SYMBOL)
 	    && (SYMBOL(init_uts_ns) == NOT_FOUND_SYMBOL)) {
 		ERRMSG("Can't get the symbol of system_utsname.\n");
@@ -1807,6 +1723,11 @@ generate_config(struct DumpInfo *info)
 
 	WRITE_ARRAY_LENGTH("zone.free_area", zone.free_area);
 
+	/*
+	 * write the source file of 1st kernel
+	 */
+	WRITE_SRCFILE("pud_t", pud_t);
+
 	return TRUE;
 }
 
@@ -1920,6 +1841,30 @@ read_config_structure(struct DumpInfo *i
 }
 
 int
+read_config_string(struct DumpInfo *info, char *str_in, char *str_out)
+{
+	char buf[BUFSIZE_FGETS];
+	unsigned int i;
+
+	if (fseek(info->file_configfile, 0, SEEK_SET) < 0) {
+		ERRMSG("Can't seek the config file(%s). %s\n",
+		    info->name_configfile, strerror(errno));
+		return FALSE;
+	}
+
+	while (fgets(buf, BUFSIZE_FGETS, info->file_configfile)) {
+		i = strlen(buf);
+		if (buf[i - 1] == '\n')
+			buf[i - 1] = '\0';
+		if (strncmp(buf, str_in, strlen(str_in)) == 0) {
+			strncpy(str_out, buf + strlen(str_in), BUFSIZE_FGETS - strlen(str_in));
+			break;
+		}
+	}
+	return TRUE;
+}
+
+int
 read_config(struct DumpInfo *info)
 {
 	if (!read_config_basic_info(info))
@@ -1974,6 +1919,8 @@ read_config(struct DumpInfo *info)
 	READ_ARRAY_LENGTH("mem_section", mem_section);
 	READ_ARRAY_LENGTH("zone.free_area", zone.free_area);
 
+	READ_SRCFILE("pud_t", pud_t);
+
 	return TRUE;
 }
 
@@ -2455,6 +2402,9 @@ initial(struct DumpInfo *info)
 		}
 		if (!get_structure_info(info))
 			return FALSE;
+
+		if (!get_srcfile_info(info))
+			return FALSE;
 	}
 
 	if (!get_machdep_kernel_start(info))
@@ -2463,9 +2413,6 @@ initial(struct DumpInfo *info)
 	if (!check_release(info))
 		return FALSE;
 
-	if (!read_kernel_config(info))
-		return FALSE;
-
 	if (!get_machdep_info(info))
 		return FALSE;
 
diff -puN makedumpfile.org/makedumpfile.h makedumpfile/makedumpfile.h
--- makedumpfile.org/makedumpfile.h	2007-05-21 19:20:06.000000000 +0900
+++ makedumpfile/makedumpfile.h	2007-05-21 19:36:43.000000000 +0900
@@ -69,14 +69,7 @@ enum {
  * Flags
  */
 #define MEMORY_4LAYER_PAGETABLE	(1 << 0)
-
-/*
- * For kernel configuration
- */
-#define MAGIC_START  "IKCFG_ST"
-#define MAGIC_END    "IKCFG_ED"
-#define MAGIC_SIZE   (sizeof(MAGIC_START) - 1)
-
+#define MEMORY_3LAYER_PAGETABLE	(1 << 1)
 
 static inline int
 test_bit(int nr, unsigned long addr)
@@ -87,12 +80,6 @@ test_bit(int nr, unsigned long addr)
 	return ((mask & addr) != 0);
 }
 
-static inline int
-is_blank(int c)
-{
-	return c == ' ' || c == '\t';
-}
-
 #define isLRU(flags)		test_bit(PG_lru, flags)
 #define isPrivate(flags)	test_bit(PG_private, flags)
 #define isSwapCache(flags)	test_bit(PG_swapcache, flags)
@@ -288,6 +275,29 @@ do { \
 } while (0)
 
 /*
+ * for source file name
+ */
+#define SRCFILE(X)		(srcfile_table.X)
+#define	TYPEDEF_SRCFILE_INIT(decl_name, str_decl_name) \
+do { \
+	get_source_filename(str_decl_name, SRCFILE(decl_name), DWARF_INFO_GET_TYPEDEF_SRCNAME); \
+} while (0)
+
+#define WRITE_SRCFILE(str_decl_name, decl_name) \
+do { \
+	if (strlen(SRCFILE(decl_name))) { \
+		fprintf(info->file_configfile, "%s%s\n", \
+		    STR_SRCFILE(str_decl_name), SRCFILE(decl_name)); \
+	} \
+} while (0)
+
+#define READ_SRCFILE(str_decl_name, decl_name) \
+do { \
+	if (!read_config_string(info, STR_SRCFILE(str_decl_name), SRCFILE(decl_name))) \
+		return FALSE; \
+} while (0)
+
+/*
  * kernel version
  */
 #define VERSION_2_6_15		(15)
@@ -309,6 +319,7 @@ do { \
 #define STR_SIZE(X)	"SIZE("X")="
 #define STR_OFFSET(X)	"OFFSET("X")="
 #define STR_LENGTH(X)	"LENGTH("X")="
+#define STR_SRCFILE(X)	"SRCFILE("X")="
 
 /*
  * common value
@@ -412,6 +423,12 @@ do { \
 #define MASK_PUD   	((1UL << REGION_SHIFT) - 1) & (~((1UL << PUD_SHIFT) - 1))
 #define MASK_PGD_4L	((1UL << REGION_SHIFT) - 1) & (~((1UL << PGDIR_SHIFT_4L) - 1))
 
+/*
+ * Key for distinguishing PGTABLE_3L or PGTABLE_4L.
+ */
+#define STR_PUD_T_3L	"include/asm-generic/pgtable-nopud.h"
+#define STR_PUD_T_4L	"include/asm/page.h"
+
 #endif          /* ia64 */
 
 /*
@@ -679,10 +696,19 @@ struct array_table {
 	} zone;
 };
 
+#define LEN_SRCFILE				(50)
+struct srcfile_table {
+	/*
+	 * typedef
+	 */
+	char	pud_t[LEN_SRCFILE];
+};
+
 extern struct symbol_table	symbol_table;
 extern struct size_table	size_table;
 extern struct offset_table	offset_table;
 extern struct array_table	array_table;
+extern struct srcfile_table	srcfile_table;
 
 /*
  * Debugging information
@@ -693,6 +719,7 @@ extern struct array_table	array_table;
 #define DWARF_INFO_GET_MEMBER_ARRAY_LENGTH	(4)
 #define DWARF_INFO_GET_SYMBOL_ARRAY_LENGTH	(5)
 #define DWARF_INFO_CHECK_SYMBOL_ARRAY_TYPE	(6)
+#define DWARF_INFO_GET_TYPEDEF_SRCNAME		(7)
 
 struct dwarf_info {
 	unsigned int	cmd;		/* IN */
@@ -701,14 +728,17 @@ struct dwarf_info {
 	char	*struct_name;		/* IN */
 	char	*symbol_name;		/* IN */
 	char	*member_name;		/* IN */
+	char	*decl_name;		/* IN */
 	long	struct_size;		/* OUT */
 	long	member_offset;		/* OUT */
 	long	array_length;		/* OUT */
+	char	src_name[LEN_SRCFILE];	/* OUT */
 };
 
 extern struct dwarf_info	dwarf_info;
 
 int readmem();
+off_t paddr_to_offset();
 unsigned long long vaddr_to_paddr();
 unsigned long long paddr_to_vaddr();
 
_

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
