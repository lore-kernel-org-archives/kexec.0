Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qni7M-0006ij-Ng
	for kexec@lists.infradead.org; Mon, 01 Aug 2011 02:20:34 +0000
Date: Mon, 1 Aug 2011 10:27:04 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH v2 4/8] makedumpfile: Introduce routines to get type
	name from debuginfo.
Message-Id: <20110801102704.efc244ac.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20110517200247.12740.45844.stgit@mars.in.ibm.com>
References: <20110517200247.12740.45844.stgit@mars.in.ibm.com>
Mime-Version: 1.0
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
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>, Prerna Saxena <prerna@linux.vnet.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>


Hi Mahesh,

A pointer size can been gotton by sizeof(void *), and pointer (virtual 
address) can been defined as "unsigned long".
I think we can make this patch simple. How about the attached patch ?


Thanks
Ken'ichi Ohmichi

diff --git a/makedumpfile.c b/makedumpfile.c
index 3ad2bd5..6955f64 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -34,7 +34,6 @@ struct erase_info	*erase_info = NULL;
 unsigned long		num_erase_info = 1; /* Node 0 is unused. */
 
 char filename_stdout[] = FILENAME_STDOUT;
-long pointer_size;
 char config_buf[BUFSIZE_FGETS];
 
 /*
@@ -2058,10 +2057,6 @@ get_debug_info(void)
 	 */
 	while (dwarf_nextcu(dwarfd, off, &next_off, &header_size,
 	    &abbrev_offset, &address_size, &offset_size) == 0) {
-		if (dwarf_info.cmd == DWARF_INFO_GET_PTR_SIZE) {
-			dwarf_info.struct_size = address_size;
-			break;
-		}
 		off += header_size;
 		if (dwarf_offdie(dwarfd, off, &cu_die) == NULL) {
 			ERRMSG("Can't get CU die.\n");
@@ -2105,14 +2100,7 @@ get_structure_size(char *structname, int flag_typedef)
 long
 get_pointer_size()
 {
-	dwarf_info.cmd = DWARF_INFO_GET_PTR_SIZE;
-	/* reuse struct_size member to report pointer size */
-	dwarf_info.struct_size = NOT_FOUND_STRUCTURE;
-
-	if (!get_debug_info())
-		return FAILED_DWARFINFO;
-
-	return dwarf_info.struct_size;
+	return sizeof(void *);
 }
 
 /*
@@ -2285,8 +2273,6 @@ get_symbol_info(void)
 	if (SYMBOL(node_memblk) != NOT_FOUND_SYMBOL)
 		SYMBOL_ARRAY_LENGTH_INIT(node_memblk, "node_memblk");
 
-	pointer_size = get_pointer_size();
-
 	return TRUE;
 }
 
@@ -7782,7 +7768,7 @@ load_module_symbols(void)
 			 * situation we depend on pointer_size that is
 			 * extracted from vmlinux dwarf information.
 			 */
-			if ((pointer_size * 8) == 64) {
+			if ((get_pointer_size() * 8) == 64) {
 				sym64 = (Elf64_Sym *) (symtab_mem
 						+ (nsym * sizeof(Elf64_Sym)));
 				sym_info[nsym].value =
@@ -7863,8 +7849,8 @@ print_config_entry(struct config_entry *ce)
 		DEBUG_MSG("Type Name: %s, ", ce->type_name);
 		DEBUG_MSG("flag: %x, ", ce->flag);
 		DEBUG_MSG("Type flag: %lx, ", ce->type_flag);
-		DEBUG_MSG("sym_addr: %llx, ", ce->sym_addr);
-		DEBUG_MSG("addr: %llx, ", ce->addr);
+		DEBUG_MSG("sym_addr: %lx, ", ce->sym_addr);
+		DEBUG_MSG("addr: %lx, ", ce->addr);
 		DEBUG_MSG("offset: %lx, ", ce->offset);
 		DEBUG_MSG("size: %zd\n", ce->size);
 
@@ -8399,29 +8385,16 @@ err_out:
 	return NULL;
 }
 
-static unsigned long long
+static unsigned long
 read_pointer_value(unsigned long long addr)
 {
-	uint32_t val_32;
-	uint64_t val_64;
+	unsigned long val;
 
-	switch (pointer_size) {
-	case 4:
-		if (!readmem(VADDR, addr, &val_32, sizeof(val_32))) {
-			ERRMSG("Can't read pointer value\n");
-			return 0;
-		}
-		return (unsigned long long)val_32;
-		break;
-	case 8:
-		if (!readmem(VADDR, addr, &val_64, sizeof(val_64))) {
-			ERRMSG("Can't read pointer value\n");
-			return 0;
-		}
-		return (unsigned long long)val_64;
-		break;
+	if (!readmem(VADDR, addr, &val, sizeof(val))) {
+		ERRMSG("Can't read pointer value\n");
+		return 0;
 	}
-	return 0;
+	return val;
 }
 
 int
@@ -8621,7 +8594,7 @@ get_config_symbol_addr(struct config_entry *ce,
 			unsigned long long base_addr,
 			char *base_struct_name)
 {
-	unsigned long long addr = 0;
+	unsigned long addr = 0;
 
 	if (!(ce->flag & ENTRY_RESOLVED)) {
 		if (!resolve_config_entry(ce, base_addr, base_struct_name))
@@ -8646,7 +8619,7 @@ get_config_symbol_addr(struct config_entry *ce,
 				 */
 				while (ce->index < ce->array_length) {
 					addr = read_pointer_value(ce->addr +
-						(ce->index * pointer_size));
+						(ce->index * get_pointer_size()));
 					ce->index++;
 					if (addr)
 						break;
@@ -8728,7 +8701,7 @@ get_config_symbol_size(struct config_entry *ce,
 	else {
 		if (ce->type_flag & TYPE_ARRAY) {
 			if (ce->type_flag & TYPE_PTR)
-				return ce->array_length * pointer_size;
+				return ce->array_length * get_pointer_size();
 			else
 				return ce->array_length * ce->size;
 		}
@@ -8909,7 +8882,7 @@ update_filter_info(struct config_entry *filter_symbol,
 		return FALSE;
 
 	if (filter_symbol->nullify)
-		size = pointer_size;
+		size = get_pointer_size();
 	else if (size_symbol) {
 		size = get_config_symbol_size(size_symbol, 0, NULL);
 		if (message_level & ML_PRINT_DEBUG_MSG)
diff --git a/makedumpfile.h b/makedumpfile.h
index 8c69235..80816b6 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1218,7 +1218,6 @@ enum {
 	DWARF_INFO_CHECK_SYMBOL_ARRAY_TYPE,
 	DWARF_INFO_GET_SYMBOL_TYPE,
 	DWARF_INFO_GET_MEMBER_TYPE,
-	DWARF_INFO_GET_PTR_SIZE,
 };
 
 struct dwarf_info {
@@ -1284,7 +1283,7 @@ struct config_entry {
 	unsigned short		flag;
 	unsigned short		nullify;
 	unsigned long long	sym_addr;	/* Symbol address */
-	unsigned long long	addr;		/* Symbol address or
+	unsigned long		addr;		/* Symbol address or
 						   value pointed by sym_addr */
 	unsigned long long	cmp_addr;	/* for LIST_ENTRY */
 	unsigned long		offset;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
