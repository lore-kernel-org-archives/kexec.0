Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e39.co.us.ibm.com ([32.97.110.160])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UEy40-0006GE-2A
 for kexec@lists.infradead.org; Mon, 11 Mar 2013 08:26:33 +0000
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Mon, 11 Mar 2013 02:26:29 -0600
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 8BAB8C90025
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2013 04:26:25 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2B8QPS2333740
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2013 04:26:25 -0400
Received: from d01av05.pok.ibm.com (loopback [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2B8QOlr012475
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2013 04:26:25 -0400
Subject: [PATCH] makedumpfile: Add support to module symbols
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Mon, 11 Mar 2013 13:56:21 +0530
Message-ID: <20130311082621.10740.20589.stgit@aravinda>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org
Cc: tachibana@mxm.nes.nec.co.jp, ananth@in.ibm.com, buendgen@de.ibm.com

Current version of makedumpfile/eppic integration patches
works only for symbols in vmlinux. This patch adds support
to module symbols.

I have tested the patch on dynamically linked version of
makedumpfile with EPPIC_LEGACY_MODE=1. However it should
work on non-legacy mode also.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 erase_info.c      |  115 +++++++++++++++++++++++++++++++++++++++++++++++------
 erase_info.h      |    4 +-
 extension_eppic.c |    3 +
 extension_eppic.h |    2 -
 4 files changed, 109 insertions(+), 15 deletions(-)

diff --git a/erase_info.c b/erase_info.c
index 61fe637..2fa8387 100644
--- a/erase_info.c
+++ b/erase_info.c
@@ -35,7 +35,7 @@ struct call_back eppic_cb = {
 	&get_die_length,
 	&get_die_member,
 	&get_die_nfields,
-	&get_symbol_addr,
+	&get_symbol_addr_all,
 	&update_filter_info_raw
 };
 
@@ -161,13 +161,27 @@ get_loaded_module(char *mod_name)
 	return &modules[mod_st.current_mod];
 }
 
+static unsigned long long
+find_module_symbol(struct module_info *module_ptr, char *symname)
+{
+	int i;
+	struct symbol_info *sym_info;
+
+	sym_info = module_ptr->sym_info;
+	if (!sym_info)
+		return FALSE;
+	for (i = 1; i < module_ptr->num_syms; i++) {
+		if (sym_info[i].name && !strcmp(sym_info[i].name, symname))
+			return sym_info[i].value;
+	}
+	return NOT_FOUND_SYMBOL;
+}
+
 static int
 sym_in_module(char *symname, unsigned long long *symbol_addr)
 {
-	int i;
 	char *module_name;
 	struct module_info *module_ptr;
-	struct symbol_info *sym_info;
 
 	module_name = get_dwarf_module_name();
 	if (!mod_st.num_modules
@@ -178,16 +192,11 @@ sym_in_module(char *symname, unsigned long long *symbol_addr)
 	module_ptr = get_loaded_module(module_name);
 	if (!module_ptr)
 		return FALSE;
-	sym_info = module_ptr->sym_info;
-	if (!sym_info)
+	*symbol_addr = find_module_symbol(module_ptr, symname);
+	if (*symbol_addr == NOT_FOUND_SYMBOL)
 		return FALSE;
-	for (i = 1; i < module_ptr->num_syms; i++) {
-		if (sym_info[i].name && !strcmp(sym_info[i].name, symname)) {
-			*symbol_addr = sym_info[i].value;
-			return TRUE;
-		}
-	}
-	return FALSE;
+	else
+		return TRUE;
 }
 
 static unsigned int
@@ -1858,6 +1867,88 @@ process_config_file(const char *name_config)
 	return TRUE;
 }
 
+/*
+ * Search for symbol in modules as well as vmlinux
+ */
+unsigned long long
+get_symbol_addr_all(char *name) {
+
+	short vmlinux_searched = 0;
+	unsigned long long symbol_addr = 0;
+	unsigned int i, current_mod;
+	struct module_info *modules;
+
+	/* Search in vmlinux if debuginfo is set to vmlinux */
+	if (!strcmp(get_dwarf_module_name(), "vmlinux")) {
+		symbol_addr = get_symbol_addr(name);
+		if (symbol_addr)
+			return symbol_addr;
+
+		vmlinux_searched = 1;
+	}
+
+	/*
+	 * Proceed the search in modules. Try in the module
+	 * which resulted in a hit in the previous search
+	 */
+
+	modules = mod_st.modules;
+	current_mod = mod_st.current_mod;
+
+	if (strcmp(get_dwarf_module_name(), modules[current_mod].name)) {
+		if (!set_dwarf_debuginfo(modules[current_mod].name,
+				info->system_utsname.release, NULL, -1)) {
+			ERRMSG("Cannot set to current module %s\n",
+					modules[current_mod].name);
+			return NOT_FOUND_SYMBOL;
+		}
+	}
+
+	symbol_addr = find_module_symbol(&modules[current_mod], name);
+	if (symbol_addr)
+		return symbol_addr;
+
+	/* Search in all modules */
+	for (i = 0; i < mod_st.num_modules; i++) {
+
+		/* Already searched. Skip */
+		if (i == current_mod)
+			continue;
+
+		if (!set_dwarf_debuginfo(modules[i].name,
+				info->system_utsname.release, NULL, -1)) {
+			ERRMSG("Skipping Module section %s\n", modules[i].name);
+			continue;
+		}
+
+		symbol_addr = find_module_symbol(&modules[i], name);
+
+		if (!symbol_addr)
+			continue;
+
+		/*
+		 * Symbol found. Set the current_mod to this module index, a
+		 * minor optimization for fast lookup next time
+		 */
+		mod_st.current_mod = i;
+		return symbol_addr;
+	}
+
+	/* Symbol not found in any module. Set debuginfo back to vmlinux  */
+	set_dwarf_debuginfo("vmlinux", NULL, info->name_vmlinux,
+			info->fd_vmlinux);
+
+	/*
+	 * Search vmlinux if not already searched. This can happen when
+	 * this function is called with debuginfo set to a particular
+	 * kernel module and we are looking for symbol in vmlinux
+	 */
+	if (!vmlinux_searched)
+		return get_symbol_addr(name);
+	else
+		return NOT_FOUND_SYMBOL;
+}
+
 
 /* Process the eppic macro using eppic library */
 static int
diff --git a/erase_info.h b/erase_info.h
index 1822034..b1a8895 100644
--- a/erase_info.h
+++ b/erase_info.h
@@ -31,6 +31,8 @@ struct erase_info {
 	int		erased;		/* 1= erased, 0= Not erased */
 };
 
+unsigned long long get_symbol_addr_all(char *);
+
 struct call_back {
     long (*get_domain)(char *, int, unsigned long long *);
     int (*readmem)(int type_addr, unsigned long long addr, void *bufptr,
@@ -43,7 +45,7 @@ struct call_back {
     int (*get_die_member)(unsigned long long die_off, int index, long *offset,
             char **name, int *nbits, int *fbits, unsigned long long *m_die);
     int (*get_die_nfields)(unsigned long long die_off);
-    unsigned long long (*get_symbol_addr)(char *symname);
+	unsigned long long (*get_symbol_addr_all)(char *symname);
     int (*update_filter_info_raw)(unsigned long long, int, int);
 };
 
diff --git a/extension_eppic.c b/extension_eppic.c
index e8591fd..a1981eb 100644
--- a/extension_eppic.c
+++ b/extension_eppic.c
@@ -307,7 +307,8 @@ apigetval(char *name, ull *val, VALUE_S *value)
 {
 	ull ptr = 0;
 
-	ptr = GET_SYMBOL_ADDR(name);
+	ptr = GET_SYMBOL_ADDR_ALL(name);
+
 	if (!ptr)
 		return 0;
 
diff --git a/extension_eppic.h b/extension_eppic.h
index 6edc318..caa44dc 100644
--- a/extension_eppic.h
+++ b/extension_eppic.h
@@ -89,7 +89,7 @@ struct call_back *cb;
 #define GET_DIE_LENGTH cb->get_die_length
 #define GET_DIE_MEMBER cb->get_die_member
 #define GET_DIE_NFIELDS cb->get_die_nfields
-#define GET_SYMBOL_ADDR cb->get_symbol_addr
+#define GET_SYMBOL_ADDR_ALL cb->get_symbol_addr_all
 #define UPDATE_FILTER_INFO_RAW cb->update_filter_info_raw
 
 #endif /* _EXTENSION_EPPIC_H */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
