Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QMQTf-0002Qq-Eu
	for kexec@lists.infradead.org; Tue, 17 May 2011 20:02:50 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp09.in.ibm.com (8.14.4/8.13.1) with ESMTP id p4HJuBxu016618
	for <kexec@lists.infradead.org>; Wed, 18 May 2011 01:26:11 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4HK2hgM3379296
	for <kexec@lists.infradead.org>; Wed, 18 May 2011 01:32:43 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p4HK2g7g018800
	for <kexec@lists.infradead.org>; Wed, 18 May 2011 06:02:42 +1000
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: [PATCH v2 3/8] makedumpfile: Load the module symbol data from vmcore.
Date: Wed, 18 May 2011 01:31:53 +0530
Message-ID: <20110517200143.12740.52724.stgit@mars.in.ibm.com>
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

This patch enables makedumpfile to load module symbol data from vmcore. This
info is required during kernel module data filtering process. Traverse the
modules list and load all module's symbol info data in the memory for fast
lookup.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Prerna Saxena <prerna@linux.vnet.ibm.com>
---

 makedumpfile.c |  305 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.h |   52 ++++++++++
 2 files changed, 357 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 2274b18..7601e3d 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -26,6 +26,7 @@ struct srcfile_table	srcfile_table;
 struct dwarf_info	dwarf_info;
 struct vm_table		vt = { 0 };
 struct DumpInfo		*info = NULL;
+struct module_sym_table	mod_st = { 0 };
 
 char filename_stdout[] = FILENAME_STDOUT;
 int message_level;
@@ -1512,6 +1513,54 @@ err_out:
 	return FALSE;
 }
 
+static struct module_info *
+get_loaded_module(char *mod_name)
+{
+	unsigned int i;
+	struct module_info *modules;
+
+	modules = mod_st.modules;
+	if (strcmp(mod_name, modules[mod_st.current_mod].name)) {
+		for (i = 0; i < mod_st.num_modules; i++) {
+			if (!strcmp(mod_name, modules[i].name))
+				break;
+		}
+		if (i == mod_st.num_modules)
+			return NULL;
+		/* set the current_mod for fast lookup next time */
+		mod_st.current_mod = i;
+	}
+
+	return &modules[mod_st.current_mod];
+}
+
+int
+sym_in_module(char *symname, unsigned long long *symbol_addr)
+{
+	int i;
+	struct module_info *module_ptr;
+	struct symbol_info *sym_info;
+
+	if (!mod_st.num_modules
+		|| !strcmp(dwarf_info.module_name, "vmlinux")
+		|| !strcmp(dwarf_info.module_name, "xen-syms"))
+		return FALSE;
+
+	module_ptr = get_loaded_module(dwarf_info.module_name);
+	if (!module_ptr)
+		return FALSE;
+	sym_info = module_ptr->sym_info;
+	if (!sym_info)
+		return FALSE;
+	for (i = 1; i < module_ptr->num_syms; i++) {
+		if (sym_info[i].name && !strcmp(sym_info[i].name, symname)) {
+			*symbol_addr = sym_info[i].value;
+			return TRUE;
+		}
+	}
+	return FALSE;
+}
+
 unsigned long long
 get_symbol_addr(char *symname)
 {
@@ -1524,6 +1573,13 @@ get_symbol_addr(char *symname)
 	Elf_Scn *scn = NULL;
 	char *sym_name = NULL;
 
+	/*
+	 * If we are looking for module symbol then traverse through
+	 * mod_st.modules for symbol lookup
+	 */
+	if (sym_in_module(symname, &symbol))
+		return symbol;
+
 	if (!init_dwarf_info())
 		return 0;
 
@@ -2335,6 +2391,7 @@ get_symbol_info(void)
 	SYMBOL_INIT(log_buf_len, "log_buf_len");
 	SYMBOL_INIT(log_end, "log_end");
 	SYMBOL_INIT(max_pfn, "max_pfn");
+	SYMBOL_INIT(modules, "modules");
 
 	if (SYMBOL(node_data) != NOT_FOUND_SYMBOL)
 		SYMBOL_ARRAY_TYPE_INIT(node_data, "node_data");
@@ -2437,6 +2494,20 @@ get_structure_info(void)
 
 	OFFSET_INIT(vm_struct.addr, "vm_struct", "addr");
 
+	/*
+	 * Get offset of the module members.
+	 */
+	SIZE_INIT(module, "module");
+	OFFSET_INIT(module.strtab, "module", "strtab");
+	OFFSET_INIT(module.symtab, "module", "symtab");
+	OFFSET_INIT(module.num_symtab, "module", "num_symtab");
+	OFFSET_INIT(module.list, "module", "list");
+	OFFSET_INIT(module.name, "module", "name");
+	OFFSET_INIT(module.module_core, "module", "module_core");
+	OFFSET_INIT(module.core_size, "module", "core_size");
+	OFFSET_INIT(module.module_init, "module", "module_init");
+	OFFSET_INIT(module.init_size, "module", "init_size");
+
 	ENUM_NUMBER_INIT(NR_FREE_PAGES, "NR_FREE_PAGES");
 	ENUM_NUMBER_INIT(N_ONLINE, "N_ONLINE");
 
@@ -7254,6 +7325,240 @@ writeout_multiple_dumpfiles(void)
 	return ret;
 }
 
+static unsigned int
+get_num_modules(unsigned long head, unsigned int *num)
+{
+	unsigned long cur;
+	unsigned int num_modules = 0;
+
+	if (!num)
+		return FALSE;
+
+	if (!readmem(VADDR, head + OFFSET(list_head.next), &cur, sizeof cur)) {
+		ERRMSG("Can't get next list_head.\n");
+		return FALSE;
+	}
+	while (cur != head) {
+		num_modules++;
+		if (!readmem(VADDR, cur + OFFSET(list_head.next),
+					&cur, sizeof cur)) {
+			ERRMSG("Can't get next list_head.\n");
+			return FALSE;
+		}
+	}
+	*num = num_modules;
+	return TRUE;
+}
+
+static void
+free_symbol_info(struct module_info *module)
+{
+	int i;
+
+	if (module->num_syms) {
+		for (i = 1; i < module->num_syms; i++)
+			if (module->sym_info[i].name)
+				free(module->sym_info[i].name);
+		free(module->sym_info);
+	}
+}
+
+static void
+clean_module_symbols(void)
+{
+	int i;
+
+	for (i = 0; i < mod_st.num_modules; i++)
+		free_symbol_info(&mod_st.modules[i]);
+
+	if (mod_st.num_modules) {
+		free(mod_st.modules);
+		mod_st.modules = NULL;
+		mod_st.num_modules = 0;
+	}
+}
+
+static int
+load_module_symbols(void)
+{
+	unsigned long head, cur, cur_module;
+	unsigned long symtab, strtab;
+	unsigned long mod_base, mod_init;
+	unsigned int mod_size, mod_init_size;
+	unsigned char *module_struct_mem, *module_core_mem;
+	unsigned char *module_init_mem = NULL;
+	unsigned char *symtab_mem;
+	char *module_name, *strtab_mem, *nameptr;
+	struct module_info *modules = NULL;
+	struct symbol_info *sym_info;
+	unsigned int num_symtab;
+	unsigned int i = 0, nsym;
+
+	head = SYMBOL(modules);
+	if (!get_num_modules(head, &mod_st.num_modules)) {
+		ERRMSG("Can't get module count\n");
+		return FALSE;
+	}
+	if (!mod_st.num_modules) {
+		return FALSE;
+	}
+	mod_st.modules = calloc(mod_st.num_modules,
+					sizeof(struct module_info));
+	if (!mod_st.modules) {
+		ERRMSG("Can't allocate memory for module info\n");
+		return FALSE;
+	}
+	modules = mod_st.modules;
+
+	/* Allocate buffer to read struct module data from vmcore. */
+	if ((module_struct_mem = calloc(1, SIZE(module))) == NULL) {
+		ERRMSG("Failed to allocate buffer for module\n");
+		return FALSE;
+	}
+
+	if (!readmem(VADDR, head + OFFSET(list_head.next), &cur, sizeof cur)) {
+		ERRMSG("Can't get next list_head.\n");
+		return FALSE;
+	}
+
+	/* Travese the list and read module symbols */
+	while (cur != head) {
+		cur_module = cur - OFFSET(module.list);
+		if (!readmem(VADDR, cur_module, module_struct_mem,
+							SIZE(module))) {
+			ERRMSG("Can't get module info.\n");
+			return FALSE;
+		}
+
+		module_name = (char *)(module_struct_mem + OFFSET(module.name));
+		if (strlen(module_name) < MOD_NAME_LEN)
+			strcpy(modules[i].name, module_name);
+		else
+			strncpy(modules[i].name, module_name, MOD_NAME_LEN-1);
+
+		mod_init = ULONG(module_struct_mem +
+						OFFSET(module.module_init));
+		mod_init_size = UINT(module_struct_mem +
+						OFFSET(module.init_size));
+		mod_base = ULONG(module_struct_mem +
+						OFFSET(module.module_core));
+		mod_size = UINT(module_struct_mem +
+						OFFSET(module.core_size));
+
+		DEBUG_MSG("Module: %s, Base: 0x%lx, Size: %u\n",
+				module_name, mod_base, mod_size);
+		if (mod_init_size > 0) {
+			module_init_mem = calloc(1, mod_init_size);
+			if (module_init_mem == NULL) {
+				ERRMSG("Can't allocate memory for module "
+								"init\n");
+				return FALSE;
+			}
+			if (!readmem(VADDR, mod_init, module_init_mem,
+							mod_init_size)) {
+				ERRMSG("Can't access module init in memory.\n");
+				return FALSE;
+			}
+		}
+
+		if ((module_core_mem = calloc(1, mod_size)) == NULL) {
+			ERRMSG("Can't allocate memory for module\n");
+			return FALSE;
+		}
+		if (!readmem(VADDR, mod_base, module_core_mem, mod_size)) {
+			ERRMSG("Can't access module in memory.\n");
+			return FALSE;
+		}
+
+		num_symtab = UINT(module_struct_mem +
+						OFFSET(module.num_symtab));
+		if (!num_symtab) {
+			ERRMSG("%s: Symbol info not available\n", module_name);
+			return FALSE;
+		}
+		modules[i].num_syms = num_symtab;
+		DEBUG_MSG("num_sym: %d\n", num_symtab);
+
+		symtab = ULONG(module_struct_mem + OFFSET(module.symtab));
+		strtab = ULONG(module_struct_mem + OFFSET(module.strtab));
+
+		/* check if symtab and strtab are inside the module space. */
+		if (!IN_RANGE(symtab, mod_base, mod_size) &&
+			!IN_RANGE(symtab, mod_init, mod_init_size)) {
+			ERRMSG("%s: module symtab is outseide of module "
+				"address space\n", module_name);
+			return FALSE;
+		}
+		if (IN_RANGE(symtab, mod_base, mod_size))
+			symtab_mem = module_core_mem + (symtab - mod_base);
+		else
+			symtab_mem = module_init_mem + (symtab - mod_init);
+
+		if (!IN_RANGE(strtab, mod_base, mod_size) &&
+			!IN_RANGE(strtab, mod_init, mod_init_size)) {
+			ERRMSG("%s: module strtab is outseide of module "
+				"address space\n", module_name);
+			return FALSE;
+		}
+		if (IN_RANGE(strtab, mod_base, mod_size))
+			strtab_mem = (char *)(module_core_mem
+						+ (strtab - mod_base));
+		else
+			strtab_mem = (char *)(module_init_mem
+						+ (strtab - mod_init));
+
+		modules[i].sym_info = calloc(num_symtab,
+						sizeof(struct symbol_info));
+		if (modules[i].sym_info == NULL) {
+			ERRMSG("Can't allocate memory to store sym info\n");
+			return FALSE;
+		}
+		sym_info = modules[i].sym_info;
+
+		/* symbols starts from 1 */
+		for (nsym = 1; nsym < num_symtab; nsym++) {
+			Elf32_Sym *sym32;
+			Elf64_Sym *sym64;
+			/*
+			 * We can not depend on info->flag_elf64_memory if
+			 * the input vmcore file is kdump-compressed format.
+			 * We will fix this in the next patch and remove the
+			 * dependancy on info->flag_elf64_memory.
+			 */
+			if (info->flag_elf64_memory) {
+				sym64 = (Elf64_Sym *) (symtab_mem
+						+ (nsym * sizeof(Elf64_Sym)));
+				sym_info[nsym].value =
+					(unsigned long long) sym64->st_value;
+				nameptr = strtab_mem + sym64->st_name;
+			}
+			else {
+				sym32 = (Elf32_Sym *) (symtab_mem
+						+ (nsym * sizeof(Elf32_Sym)));
+				sym_info[nsym].value =
+					(unsigned long long) sym32->st_value;
+				nameptr = strtab_mem + sym32->st_name;
+			}
+			if (strlen(nameptr))
+				sym_info[nsym].name = strdup(nameptr);
+			DEBUG_MSG("\t[%d] %llx %s\n", nsym,
+						sym_info[nsym].value, nameptr);
+		}
+
+		if (!readmem(VADDR, cur + OFFSET(list_head.next),
+					&cur, sizeof cur)) {
+			ERRMSG("Can't get next list_head.\n");
+			return FALSE;
+		}
+		i++;
+		free(module_core_mem);
+		if (mod_init_size > 0)
+			free(module_init_mem);
+	} while (cur != head);
+	free(module_struct_mem);
+	return TRUE;
+}
+
 int
 create_dumpfile(void)
 {
diff --git a/makedumpfile.h b/makedumpfile.h
index 3fda754..8ad1287 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1012,6 +1012,33 @@ struct vm_table {
 };
 extern struct vm_table		vt;
 
+/*
+ * Loaded module symbols info.
+ */
+#define MOD_NAME_LEN	64
+#define IN_RANGE(addr, mbase, sz) \
+	(((unsigned long)(addr) >= (unsigned long)mbase) \
+	&& ((unsigned long)addr < (unsigned long)(mbase + sz)))
+
+struct symbol_info {
+	char			*name;
+	unsigned long long	value;
+};
+
+struct module_info {
+	char			name[MOD_NAME_LEN];
+	unsigned int		num_syms;
+	struct symbol_info	*sym_info;
+};
+
+struct module_sym_table {
+	unsigned int		num_modules;
+	unsigned int		current_mod;
+	struct module_info	*modules;
+};
+
+extern struct module_sym_table	mod_st;
+
 struct symbol_table {
 	unsigned long long	mem_map;
 	unsigned long long	vmem_map;
@@ -1052,6 +1079,12 @@ struct symbol_table {
 	unsigned long long	frametable_pg_dir;
 	unsigned long long	max_page;
 	unsigned long long	alloc_bitmap;
+
+	/*
+	 * for loading module symbol data
+	 */
+
+	unsigned long long	modules;
 };
 
 struct size_table {
@@ -1069,6 +1102,11 @@ struct size_table {
 	 */
 	long	page_info;
 	long	domain;
+
+	/*
+	 * for loading module symbol data
+	 */
+	long	module;
 };
 
 struct offset_table {
@@ -1123,6 +1161,20 @@ struct offset_table {
 		long	next_in_list;
 	} domain;
 
+	/*
+	 * for loading module symbol data
+	 */
+	struct module {
+		long	list;
+		long	name;
+		long	module_core;
+		long	core_size;
+		long	module_init;
+		long	init_size;
+		long	num_symtab;
+		long	symtab;
+		long	strtab;
+	} module;
 };
 
 /*


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
