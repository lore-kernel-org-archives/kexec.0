Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e38.co.us.ibm.com ([32.97.110.159])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TWSL6-0006By-5X
 for kexec@lists.infradead.org; Thu, 08 Nov 2012 13:40:13 +0000
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Thu, 8 Nov 2012 06:40:10 -0700
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 5D12AC40001
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 06:40:04 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qA8De6xX136872
 for <kexec@lists.infradead.org>; Thu, 8 Nov 2012 06:40:06 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qA8De4SU028965
 for <kexec@lists.infradead.org>; Thu, 8 Nov 2012 06:40:06 -0700
Subject: [PATCH v2 7/7] Support fully typed symbol access mode
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Thu, 08 Nov 2012 19:09:58 +0530
Message-ID: <20121108133958.28410.19033.stgit@aravinda>
In-Reply-To: <20121108133554.28410.99763.stgit@aravinda>
References: <20121108133554.28410.99763.stgit@aravinda>
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
Cc: LChouinard@s2sys.com, mahesh@linux.vnet.ibm.com, tachibana@mxm.nes.nec.co.jp, ananth@in.ibm.com, buendgen@de.ibm.com

Eppic enables access to symbols in two ways. The first, is a more
natural mode in that it makes symbols available as fully typed
entities. The second, is generic and treats all symbols as an address
to data which then needs to be cast to the proper type explicitly. The
former obviously enables an easier cut & pasting of target code into
eppic code.

Currently generic symbol access mode is supported. This patch extends
the functionality to include support for fully typed symbol access mode
(which will be the default mode) in eppic macros. User can switch to
generic symbol access mode by setting the following environmental
variable - EPPIC_LEGACY_MODE. libeppic.a will take care of handling
EPPIC_LEGACY_MODE. libeppic.a will pass NULL to VALUE_S* argument of
apigetval() call back function if EPPIC_LEGACY_MODE is set.

Refer to http://code.google.com/p/eppic/ for more information.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 dwarf_info.c      |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 dwarf_info.h      |    2 ++
 extension_eppic.c |   24 ++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/dwarf_info.c b/dwarf_info.c
index 7d07c41..84331f0 100644
--- a/dwarf_info.c
+++ b/dwarf_info.c
@@ -119,6 +119,15 @@ is_search_domain(int cmd)
 }
 
 static int
+is_search_die(int cmd)
+{
+	if (cmd == DWARF_INFO_GET_DIE)
+		return TRUE;
+	else
+		return FALSE;
+}
+
+static int
 process_module (Dwfl_Module *dwflmod,
 		void **userdata __attribute__ ((unused)),
 		const char *name __attribute__ ((unused)),
@@ -844,6 +853,25 @@ search_domain(Dwarf_Die *die, int *found)
 }
 
 static void
+search_die(Dwarf_Die *die, int *found)
+{
+	const char *name;
+
+	do {
+		name = dwarf_diename(die);
+
+		if ((!name) || strcmp(name, dwarf_info.symbol_name))
+			continue;
+
+		if (found)
+			*found = TRUE;
+
+		dwarf_info.die_offset = dwarf_dieoffset(die);
+		return;
+	} while (!dwarf_siblingof(die, die));
+}
+
+static void
 search_die_tree(Dwarf_Die *die, int *found)
 {
 	Dwarf_Die child;
@@ -871,6 +899,9 @@ search_die_tree(Dwarf_Die *die, int *found)
 
 	else if (is_search_domain(dwarf_info.cmd))
 		search_domain(die, found);
+
+	else if (is_search_die(dwarf_info.cmd))
+		search_die(die, found);
 }
 
 static int
@@ -1431,6 +1462,27 @@ get_die_name(unsigned long long die_off)
 }
 
 /*
+ * Get the die offset given the die name
+ */
+unsigned long long
+get_die_offset(char *sysname)
+{
+	dwarf_info.cmd         = DWARF_INFO_GET_DIE;
+	dwarf_info.symbol_name = sysname;
+	dwarf_info.type_name   = NULL;
+	dwarf_info.struct_size = NOT_FOUND_STRUCTURE;
+	dwarf_info.die_offset  = 0;
+
+	if (!sysname)
+		return 0;
+
+	if (!get_debug_info())
+		return 0;
+
+	return (unsigned long long)dwarf_info.die_offset;
+}
+
+/*
  * Get length attribute given the die offset
  */
 int
diff --git a/dwarf_info.h b/dwarf_info.h
index ce95aeb..7f02e87 100644
--- a/dwarf_info.h
+++ b/dwarf_info.h
@@ -54,6 +54,7 @@ enum {
 	DWARF_INFO_GET_DOMAIN_REF,
 	DWARF_INFO_GET_DOMAIN_STRING,
 	DWARF_INFO_GET_DOMAIN_BASE,
+	DWARF_INFO_GET_DIE,
 };
 
 char *get_dwarf_module_name(void);
@@ -75,6 +76,7 @@ int get_die_member(unsigned long long die_off, int index, long *offset,
 int get_die_attr_type(unsigned long long die_off, int *type_flag,
 	unsigned long long *die_attr_off);
 char *get_die_name(unsigned long long die_off);
+unsigned long long get_die_offset(char *sysname);
 int get_die_length(unsigned long long die_off, int flag);
 int set_dwarf_debuginfo(char *mod_name, char *os_release, char *name_debuginfo, int fd_debuginfo);
 
diff --git a/extension_eppic.c b/extension_eppic.c
index 037c1bf..331a7e6 100644
--- a/extension_eppic.c
+++ b/extension_eppic.c
@@ -313,6 +313,30 @@ apigetval(char *name, ull *val, VALUE_S *value)
 		return 0;
 
 	*val = ptr;
+
+	if (!value)
+		return 1;
+
+	/* Support for fully typed symbol access */
+	ull type;
+	TYPE_S *stype;
+
+	type = get_die_offset(name);
+	stype = eppic_gettype(value);
+
+	apigetrtype(type, stype);
+
+	eppic_pushref(stype, 1);
+	eppic_setmemaddr(value, *val);
+	eppic_do_deref(1, value, value);
+
+	*val = eppic_getval(value);
+
+	if (!eppic_typeislocal(stype) && eppic_type_getidx(stype) > 100) {
+		char *tname = get_die_name(eppic_type_getidx(stype));
+		if (tname)
+			eppic_chktype(stype, tname);
+	}
 	return 1;
 }
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
