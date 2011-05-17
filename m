Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QMQUy-0002S6-JE
	for kexec@lists.infradead.org; Tue, 17 May 2011 20:04:10 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp08.in.ibm.com (8.14.4/8.13.1) with ESMTP id p4HJx74Z027572
	for <kexec@lists.infradead.org>; Wed, 18 May 2011 01:29:07 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4HK431Y4227222
	for <kexec@lists.infradead.org>; Wed, 18 May 2011 01:34:03 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p4HK42C6013275
	for <kexec@lists.infradead.org>; Wed, 18 May 2011 01:34:03 +0530
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: [PATCH v2 4/8] makedumpfile: Introduce routines to get type name from
	debuginfo.
Date: Wed, 18 May 2011 01:33:22 +0530
Message-ID: <20110517200247.12740.45844.stgit@mars.in.ibm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Dave Anderson <anderson@redhat.com>, Prerna Saxena <prerna@linux.vnet.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

This patch implements following routines that returns type, type name and
size of kernel symbol/member using dwarf info:

	char *get_symbol_type_name();
	char *get_member_type_name();
	long get_pointer_size();

These routines will be used to resolve symbol/member information specified
through filter config commands.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Prerna Saxena <prerna@linux.vnet.ibm.com>
---

 makedumpfile.c |  142 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 makedumpfile.h |   13 +++++
 2 files changed, 148 insertions(+), 7 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 7601e3d..f7d37cc 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -30,6 +30,7 @@ struct module_sym_table	mod_st = { 0 };
 
 char filename_stdout[] = FILENAME_STDOUT;
 int message_level;
+long pointer_size;
 
 /*
  * Forward declarations
@@ -1822,6 +1823,41 @@ check_array_type(Dwarf *dwarfd, Dwarf_Die *die)
 	return TRUE;
 }
 
+static int
+get_dwarf_base_type(Dwarf *dwarfd, Dwarf_Die *die)
+{
+	int tag;
+	const char *name;
+
+	while (get_die_type(dwarfd, die, die)) {
+		tag = dwarf_tag(die);
+		switch (tag) {
+		case DW_TAG_array_type:
+			dwarf_info.type_flag |= TYPE_ARRAY;
+			break;
+		case DW_TAG_pointer_type:
+			dwarf_info.type_flag |= TYPE_PTR;
+			break;
+		case DW_TAG_structure_type:
+			dwarf_info.type_flag |= TYPE_STRUCT;
+			break;
+		case DW_TAG_base_type:
+			dwarf_info.type_flag |= TYPE_BASE;
+			break;
+		}
+	}
+
+	name = dwarf_diename(die);
+	if (name)
+		dwarf_info.type_name = strdup(name);
+	else if (dwarf_info.type_flag == TYPE_PTR)
+		dwarf_info.type_name = strdup("void");
+
+	dwarf_info.struct_size = dwarf_bytesize(die);
+
+	return TRUE;
+}
+
 /*
  * Function for searching struct page.union.struct.mapping.
  */
@@ -1902,6 +1938,15 @@ search_member(Dwarf *dwarfd, Dwarf_Die *die)
 			continue;
 
 		switch (dwarf_info.cmd) {
+		case DWARF_INFO_GET_MEMBER_TYPE:
+			if ((!name) || strcmp(name, dwarf_info.member_name))
+				continue;
+			/*
+			 * Get the member offset.
+			 */
+			if (!get_dwarf_base_type(dwarfd, walker))
+				continue;
+			return;
 		case DWARF_INFO_GET_MEMBER_OFFSET:
 			if ((!name) || strcmp(name, dwarf_info.member_name))
 				continue;
@@ -1964,6 +2009,7 @@ is_search_structure(int cmd)
 {
 	if ((cmd == DWARF_INFO_GET_STRUCT_SIZE)
 	    || (cmd == DWARF_INFO_GET_MEMBER_OFFSET)
+	    || (cmd == DWARF_INFO_GET_MEMBER_TYPE)
 	    || (cmd == DWARF_INFO_GET_MEMBER_OFFSET_IN_UNION)
 	    || (cmd == DWARF_INFO_GET_MEMBER_OFFSET_1ST_UNION)
 	    || (cmd == DWARF_INFO_GET_MEMBER_ARRAY_LENGTH))
@@ -1985,6 +2031,7 @@ int
 is_search_symbol(int cmd)
 {
 	if ((cmd == DWARF_INFO_GET_SYMBOL_ARRAY_LENGTH)
+	    || (cmd == DWARF_INFO_GET_SYMBOL_TYPE)
 	    || (cmd == DWARF_INFO_CHECK_SYMBOL_ARRAY_TYPE))
 		return TRUE;
 	else
@@ -2041,6 +2088,7 @@ search_structure(Dwarf *dwarfd, Dwarf_Die *die, int *found)
 	switch (dwarf_info.cmd) {
 	case DWARF_INFO_GET_STRUCT_SIZE:
 		break;
+	case DWARF_INFO_GET_MEMBER_TYPE:
 	case DWARF_INFO_GET_MEMBER_OFFSET:
 	case DWARF_INFO_GET_MEMBER_OFFSET_IN_UNION:
 	case DWARF_INFO_GET_MEMBER_OFFSET_1ST_UNION:
@@ -2173,6 +2221,9 @@ search_symbol(Dwarf *dwarfd, Dwarf_Die *die, int *found)
 	case DWARF_INFO_CHECK_SYMBOL_ARRAY_TYPE:
 		check_array_type(dwarfd, die);
 		break;
+	case DWARF_INFO_GET_SYMBOL_TYPE:
+		get_dwarf_base_type(dwarfd, die);
+		break;
 	}
 }
 
@@ -2249,6 +2300,10 @@ get_debug_info(void)
 	 */
 	while (dwarf_nextcu(dwarfd, off, &next_off, &header_size,
 	    &abbrev_offset, &address_size, &offset_size) == 0) {
+		if (dwarf_info.cmd == DWARF_INFO_GET_PTR_SIZE) {
+			dwarf_info.struct_size = address_size;
+			break;
+		}
 		off += header_size;
 		if (dwarf_offdie(dwarfd, off, &cu_die) == NULL) {
 			ERRMSG("Can't get CU die.\n");
@@ -2287,6 +2342,47 @@ get_structure_size(char *structname, int flag_typedef)
 }
 
 /*
+ * Get the size of pointer.
+ */
+long
+get_pointer_size()
+{
+	dwarf_info.cmd = DWARF_INFO_GET_PTR_SIZE;
+	/* reuse struct_size member to report pointer size */
+	dwarf_info.struct_size = NOT_FOUND_STRUCTURE;
+
+	if (!get_debug_info())
+		return FAILED_DWARFINFO;
+
+	return dwarf_info.struct_size;
+}
+
+/*
+ * Get the type of given symbol.
+ */
+char *
+get_symbol_type_name(char *symname, int cmd, long *size,
+					unsigned long *flag)
+{
+	dwarf_info.cmd = cmd;
+	dwarf_info.symbol_name = symname;
+	dwarf_info.type_name = NULL;
+	dwarf_info.struct_size = NOT_FOUND_STRUCTURE;
+	dwarf_info.type_flag = 0;
+
+	if (!get_debug_info())
+		return NULL;
+
+	if (size)
+		*size = dwarf_info.struct_size;
+
+	if (flag)
+		*flag = dwarf_info.type_flag;
+
+	return dwarf_info.type_name;
+}
+
+/*
  * Get the offset of member.
  */
 long
@@ -2305,6 +2401,35 @@ get_member_offset(char *structname, char *membername, int cmd)
 }
 
 /*
+ * Get the type name and size of member.
+ */
+char *
+get_member_type_name(char *structname, char *membername, int cmd, long *size,
+						unsigned long *flag)
+{
+	dwarf_info.cmd = cmd;
+	dwarf_info.struct_name = structname;
+	dwarf_info.struct_size = NOT_FOUND_STRUCTURE;
+	dwarf_info.member_name = membername;
+	dwarf_info.type_name = NULL;
+	dwarf_info.type_flag = 0;
+
+	if (!get_debug_info())
+		return NULL;
+
+	if (dwarf_info.struct_size == NOT_FOUND_STRUCTURE)
+		return NULL;
+
+	if (size)
+		*size = dwarf_info.struct_size;
+
+	if (flag)
+		*flag = dwarf_info.type_flag;
+
+	return dwarf_info.type_name;
+}
+
+/*
  * Get the length of array.
  */
 long
@@ -2402,6 +2527,8 @@ get_symbol_info(void)
 	if (SYMBOL(node_memblk) != NOT_FOUND_SYMBOL)
 		SYMBOL_ARRAY_LENGTH_INIT(node_memblk, "node_memblk");
 
+	pointer_size = get_pointer_size();
+
 	return TRUE;
 }
 
@@ -7519,13 +7646,16 @@ load_module_symbols(void)
 		for (nsym = 1; nsym < num_symtab; nsym++) {
 			Elf32_Sym *sym32;
 			Elf64_Sym *sym64;
-			/*
-			 * We can not depend on info->flag_elf64_memory if
-			 * the input vmcore file is kdump-compressed format.
-			 * We will fix this in the next patch and remove the
-			 * dependancy on info->flag_elf64_memory.
+			/* If case of ELF vmcore then the word size can be
+			 * determined using info->flag_elf64_memory flag.
+			 * But in case of kdump-compressed dump, kdump header
+			 * does not carry word size info. May be in future
+			 * this info will be available in kdump header.
+			 * Until then, in order to make this logic work on both
+			 * situation we depend on pointer_size that is
+			 * extracted from vmlinux dwarf information.
 			 */
-			if (info->flag_elf64_memory) {
+			if ((pointer_size * 8) == 64) {
 				sym64 = (Elf64_Sym *) (symtab_mem
 						+ (nsym * sizeof(Elf64_Sym)));
 				sym_info[nsym].value =
diff --git a/makedumpfile.h b/makedumpfile.h
index 8ad1287..62c7ff5 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1242,7 +1242,10 @@ enum {
 	DWARF_INFO_GET_TYPEDEF_SIZE,
 	DWARF_INFO_GET_TYPEDEF_SRCNAME,
 	DWARF_INFO_GET_ENUM_NUMBER,
-	DWARF_INFO_CHECK_SYMBOL_ARRAY_TYPE
+	DWARF_INFO_CHECK_SYMBOL_ARRAY_TYPE,
+	DWARF_INFO_GET_SYMBOL_TYPE,
+	DWARF_INFO_GET_MEMBER_TYPE,
+	DWARF_INFO_GET_PTR_SIZE,
 };
 
 struct dwarf_info {
@@ -1257,13 +1260,21 @@ struct dwarf_info {
 	Elf	*elfd;			/* OUT */
 	Dwarf	*dwarfd;		/* OUT */
 	Dwfl	*dwfl;			/* OUT */
+	char	*type_name;		/* OUT */
 	long	struct_size;		/* OUT */
 	long	member_offset;		/* OUT */
 	long	array_length;		/* OUT */
 	long	enum_number;		/* OUT */
+	unsigned char	type_flag;	/* OUT */
 	char	src_name[LEN_SRCFILE];	/* OUT */
 };
 
+/* flags for dwarf_info.type_flag */
+#define TYPE_BASE	0x01
+#define TYPE_ARRAY	0x02
+#define TYPE_PTR	0x04
+#define TYPE_STRUCT	0x08
+
 extern struct dwarf_info	dwarf_info;
 
 int readmem(int type_addr, unsigned long long addr, void *bufptr, size_t size);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
