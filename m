Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U2GCB-0002tW-Ft
 for kexec@lists.infradead.org; Mon, 04 Feb 2013 07:10:28 +0000
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Mon, 4 Feb 2013 02:10:24 -0500
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id B883938C8026
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 02:10:14 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r147AEnH297272
 for <kexec@lists.infradead.org>; Mon, 4 Feb 2013 02:10:14 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r147ACsU006121
 for <kexec@lists.infradead.org>; Mon, 4 Feb 2013 02:10:14 -0500
Subject: [PATCH v4 4/9] Implement apigetctype call back function
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Mon, 04 Feb 2013 12:40:09 +0530
Message-ID: <20130204071009.9292.25685.stgit@aravinda>
In-Reply-To: <20130204070724.9292.6640.stgit@aravinda>
References: <20130204070724.9292.6640.stgit@aravinda>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org
Cc: LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, ananth@in.ibm.com, buendgen@de.ibm.com

libeppic will call apigetctype call back function whenever it
encounters a token in the eppic macro. The call back function will use
DWARF to query information related to the requested token and will
pass it back to eppic using libeppic API calls. If the token does not
exist, then apigetctype call returns 0.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 dwarf_info.c      |  109 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 dwarf_info.h      |    9 ++++
 extension_eppic.c |   28 +++++++++++++-
 3 files changed, 145 insertions(+), 1 deletions(-)

diff --git a/dwarf_info.c b/dwarf_info.c
index 09a8e1e..2d28f87 100644
--- a/dwarf_info.c
+++ b/dwarf_info.c
@@ -51,6 +51,7 @@ struct dwarf_info {
 	long	enum_number;		/* OUT */
 	unsigned char	type_flag;	/* OUT */
 	char	src_name[LEN_SRCFILE];	/* OUT */
+	Dwarf_Off die_offset;		/* OUT */
 };
 static struct dwarf_info	dwarf_info;
 
@@ -102,6 +103,22 @@ is_search_typedef(int cmd)
 }
 
 static int
+is_search_domain(int cmd)
+{
+	if ((cmd == DWARF_INFO_GET_DOMAIN_STRUCT)
+		|| (cmd == DWARF_INFO_GET_DOMAIN_TYPEDEF)
+		|| (cmd == DWARF_INFO_GET_DOMAIN_ARRAY)
+		|| (cmd == DWARF_INFO_GET_DOMAIN_UNION)
+		|| (cmd == DWARF_INFO_GET_DOMAIN_ENUM)
+		|| (cmd == DWARF_INFO_GET_DOMAIN_REF)
+		|| (cmd == DWARF_INFO_GET_DOMAIN_STRING)
+		|| (cmd == DWARF_INFO_GET_DOMAIN_BASE))
+		return TRUE;
+	else
+		return FALSE;
+}
+
+static int
 process_module (Dwfl_Module *dwflmod,
 		void **userdata __attribute__ ((unused)),
 		const char *name __attribute__ ((unused)),
@@ -750,6 +767,74 @@ search_symbol(Dwarf_Die *die, int *found)
 }
 
 static void
+search_domain(Dwarf_Die *die, int *found)
+{
+	int tag;
+	const char *name;
+	short flag = 0;
+	Dwarf_Die die_type;
+
+	do {
+		tag  = dwarf_tag(die);
+		name = dwarf_diename(die);
+
+		/*
+		 * Descend into members and search for the
+		 * needed domain there.
+		 */
+		if ((!name) || strcmp(name, dwarf_info.symbol_name)) {
+			if (!get_die_type(die, &die_type))
+				continue;
+
+			if (is_container(&die_type)) {
+				Dwarf_Die child;
+
+				if (dwarf_child(&die_type, &child) != 0)
+					continue;
+
+				search_domain(&child, found);
+
+				if (*found)
+					return;
+			}
+		}
+
+		if ((!name) || strcmp(name, dwarf_info.symbol_name))
+			continue;
+
+		switch (dwarf_info.cmd) {
+		case DWARF_INFO_GET_DOMAIN_STRUCT:
+			if (tag == DW_TAG_structure_type)
+				flag = 1;
+			break;
+		case DWARF_INFO_GET_DOMAIN_UNION:
+			if (tag == DW_TAG_union_type)
+				flag = 1;
+			break;
+		case DWARF_INFO_GET_DOMAIN_TYPEDEF:
+			if (tag == DW_TAG_typedef)
+				flag = 1;
+			break;
+		/* TODO
+		 * Implement functionality for the rest of the domains
+		 */
+		}
+
+		if (!flag)
+			continue;
+
+		dwarf_info.struct_size = dwarf_bytesize(die);
+
+		if (dwarf_info.struct_size > 0) {
+			if (found)
+				*found = TRUE;
+			dwarf_info.die_offset = dwarf_dieoffset(die);
+			break;
+		}
+	} while (!dwarf_siblingof(die, die));
+}
+
+static void
 search_die_tree(Dwarf_Die *die, int *found)
 {
 	Dwarf_Die child;
@@ -774,6 +859,9 @@ search_die_tree(Dwarf_Die *die, int *found)
 
 	else if (is_search_typedef(dwarf_info.cmd))
 		search_typedef(die, found);
+
+	else if (is_search_domain(dwarf_info.cmd))
+		search_domain(die, found);
 }
 
 static int
@@ -1166,6 +1254,27 @@ get_source_filename(char *structname, char *src_name, int cmd)
 }
 
 /*
+ * Get the domain information of the symbol
+ */
+long
+get_domain(char *symname, int cmd, unsigned long long *die)
+{
+	dwarf_info.cmd         = cmd;
+	dwarf_info.symbol_name = symname;
+	dwarf_info.type_name   = NULL;
+	dwarf_info.struct_size = NOT_FOUND_STRUCTURE;
+	dwarf_info.die_offset  = 0;
+
+	if (!get_debug_info())
+		return 0;
+
+	if (die)
+		*die = (unsigned long long) dwarf_info.die_offset;
+
+	return dwarf_info.struct_size;
+}
+
+/*
  * Set the dwarf_info with kernel/module debuginfo file information.
  */
 int
diff --git a/dwarf_info.h b/dwarf_info.h
index 185cbb6..074b5cc 100644
--- a/dwarf_info.h
+++ b/dwarf_info.h
@@ -47,6 +47,14 @@ enum {
 	DWARF_INFO_GET_SYMBOL_TYPE,
 	DWARF_INFO_GET_MEMBER_TYPE,
 	DWARF_INFO_GET_ENUMERATION_TYPE_SIZE,
+	DWARF_INFO_GET_DOMAIN_STRUCT,
+	DWARF_INFO_GET_DOMAIN_TYPEDEF,
+	DWARF_INFO_GET_DOMAIN_ARRAY,
+	DWARF_INFO_GET_DOMAIN_UNION,
+	DWARF_INFO_GET_DOMAIN_ENUM,
+	DWARF_INFO_GET_DOMAIN_REF,
+	DWARF_INFO_GET_DOMAIN_STRING,
+	DWARF_INFO_GET_DOMAIN_BASE,
 };
 
 char *get_dwarf_module_name(void);
@@ -61,6 +69,7 @@ char *get_member_type_name(char *structname, char *membername, int cmd, long *si
 long get_array_length(char *name01, char *name02, unsigned int cmd);
 long get_enum_number(char *enum_name);
 int get_source_filename(char *structname, char *src_name, int cmd);
+long get_domain(char *symname, int cmd, unsigned long long *die);
 int set_dwarf_debuginfo(char *mod_name, char *os_release, char *name_debuginfo, int fd_debuginfo);
 
 #endif  /* DWARF_INFO_H */
diff --git a/extension_eppic.c b/extension_eppic.c
index 26c945f..6e9fff8 100644
--- a/extension_eppic.c
+++ b/extension_eppic.c
@@ -91,7 +91,33 @@ apimember(char *mname, ull pidx, type_t *tm,
 static int
 apigetctype(int ctype, char *name, type_t *tout)
 {
-	return 0;
+	long size = 0;
+	unsigned long long die = 0;
+
+	switch (ctype) {
+	case V_TYPEDEF:
+		size = get_domain(name, DWARF_INFO_GET_DOMAIN_TYPEDEF, &die);
+		break;
+	case V_STRUCT:
+		size = get_domain(name, DWARF_INFO_GET_DOMAIN_STRUCT, &die);
+		break;
+	case V_UNION:
+		size = get_domain(name, DWARF_INFO_GET_DOMAIN_UNION, &die);
+		break;
+	/* TODO
+	 * Implement for all the domains
+	 */
+	}
+
+	if (size <= 0 || !die)
+		return 0;
+
+	/* populate */
+	eppic_type_settype(tout, ctype);
+	eppic_type_setsize(tout, size);
+	eppic_type_setidx(tout, (ull)(unsigned long)die);
+	eppic_pushref(tout, 0);
+	return 1;
 }
 
 static char *


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
