Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U2GCd-00035l-2g
 for kexec@lists.infradead.org; Mon, 04 Feb 2013 07:10:56 +0000
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Mon, 4 Feb 2013 02:10:54 -0500
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 948FB38C8045
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 02:10:52 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r147AphV65405142
 for <kexec@lists.infradead.org>; Mon, 4 Feb 2013 02:10:51 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r147Ao2Z020361
 for <kexec@lists.infradead.org>; Mon, 4 Feb 2013 02:10:51 -0500
Subject: [PATCH v4 8/9] Hack for the limitation when compiled with -static
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Mon, 04 Feb 2013 12:40:47 +0530
Message-ID: <20130204071047.9292.50668.stgit@aravinda>
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

For programs compiled with -static option, there is no
dynamic section in the ELF file. Hence, the functions in the
main executable cannot be invoked by dynamically loaded
libraries as they cannot be resolved.

The eppic extension for makedumpfile, which is dynamically
loaded when -eppic flag is specified, needs to call few
functions in makedumpfile. This will not work if makedumpfile
is compiled with -static flag.

This patch is a hack which overcomes this limitation by passing
the address of the functions required by the dynamically loaded
library, eppic_makedumpfile.so, during initialization. The
dynamically loaded library branches to the function address
eliminating the need to resolve functions.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 erase_info.c      |   16 +++++++++++++++-
 erase_info.h      |   16 ++++++++++++++++
 extension_eppic.c |   51 ++++++++++++++++++++++++++-------------------------
 extension_eppic.h |   24 ++++++++++++++++++++++--
 4 files changed, 79 insertions(+), 28 deletions(-)

diff --git a/erase_info.c b/erase_info.c
index 2cdc855..61fe637 100644
--- a/erase_info.c
+++ b/erase_info.c
@@ -26,6 +26,20 @@
 struct erase_info	*erase_info = NULL;
 unsigned long		num_erase_info = 1; /* Node 0 is unused. */
 
+struct call_back eppic_cb = {
+	&get_domain,
+	&readmem,
+	&get_die_attr_type,
+	&get_die_name,
+	&get_die_offset,
+	&get_die_length,
+	&get_die_member,
+	&get_die_nfields,
+	&get_symbol_addr,
+	&update_filter_info_raw
+};
+
+
 /*
  * flags for config_entry.flag
  */ 
@@ -1882,7 +1896,7 @@ process_eppic_file(char *name_config)
 	if (!eppic_unload)
 		ERRMSG("Could not find eppic_unload function\n");
 
-	if (eppic_init()) {
+	if (eppic_init(&eppic_cb)) {
 		ERRMSG("Init failed \n");
 		return FALSE;
 	}
diff --git a/erase_info.h b/erase_info.h
index 2a9c43d..1822034 100644
--- a/erase_info.h
+++ b/erase_info.h
@@ -31,6 +31,22 @@ struct erase_info {
 	int		erased;		/* 1= erased, 0= Not erased */
 };
 
+struct call_back {
+    long (*get_domain)(char *, int, unsigned long long *);
+    int (*readmem)(int type_addr, unsigned long long addr, void *bufptr,
+             size_t size);
+    int (*get_die_attr_type)(unsigned long long die_off, int *type_flag,
+            unsigned long long *die_attr_off);
+    char * (*get_die_name)(unsigned long long die_off);
+    unsigned long long (*get_die_offset)(char *sysname);
+    int (*get_die_length)(unsigned long long die_off, int flag);
+    int (*get_die_member)(unsigned long long die_off, int index, long *offset,
+            char **name, int *nbits, int *fbits, unsigned long long *m_die);
+    int (*get_die_nfields)(unsigned long long die_off);
+    unsigned long long (*get_symbol_addr)(char *symname);
+    int (*update_filter_info_raw)(unsigned long long, int, int);
+};
+
 extern struct erase_info	*erase_info;
 extern unsigned long		num_erase_info;
 
diff --git a/extension_eppic.c b/extension_eppic.c
index 331a7e6..e8591fd 100644
--- a/extension_eppic.c
+++ b/extension_eppic.c
@@ -3,7 +3,7 @@
  *
  * Created by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
  *
- * Copyright (C) 2012  IBM Corporation
+ * Copyright (C) 2012, 2013  IBM Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -23,7 +23,6 @@
 
 #include "makedumpfile.h"
 #include "extension_eppic.h"
-#include "print_info.h"
 
 /*
  * Most of the functions included in this file performs similar
@@ -103,7 +102,7 @@ eppic_setupidx(TYPE_S *t, int ref, int nidx, int *idxlst)
 static int
 apigetmem(ull iaddr, void *p, int nbytes)
 {
-	return readmem(VADDR, iaddr, p, nbytes);
+	return READMEM(VADDR, iaddr, p, nbytes);
 }
 
 static int
@@ -124,7 +123,7 @@ drilldown(ull offset, type_t *t)
 	ull die_off = offset, t_die_off;
 	char *tstr = NULL;
 
-	while (get_die_attr_type(die_off, &type_flag, &t_die_off)) {
+	while (GET_DIE_ATTR_TYPE(die_off, &type_flag, &t_die_off)) {
 		switch (type_flag) {
 		/* typedef inserts a level of reference to the actual type */
 		case DW_TAG_pointer_type:
@@ -134,7 +133,7 @@ drilldown(ull offset, type_t *t)
 			 * This could be a void *, in which case the drill
 			 * down stops here
 			 */
-			if (!get_die_attr_type(die_off, &type_flag,
+			if (!GET_DIE_ATTR_TYPE(die_off, &type_flag,
 						&t_die_off)) {
 				/* make it a char* */
 				eppic_parsetype("char", t, ref);
@@ -163,8 +162,8 @@ drilldown(ull offset, type_t *t)
 			}
 
 			/* handle multi-dimensional array */
-			len = get_die_length(die_off, FALSE);
-			t_len = get_die_length(t_die_off, FALSE);
+			len = GET_DIE_LENGTH(die_off, FALSE);
+			t_len = GET_DIE_LENGTH(t_die_off, FALSE);
 			if (len > 0 && t_len > 0)
 				idxlst[nidx++] = len / t_len;
 			die_off = t_die_off;
@@ -174,7 +173,7 @@ drilldown(ull offset, type_t *t)
 			die_off = t_die_off;
 			break;
 		case DW_TAG_base_type:
-			eppic_parsetype(tstr = get_die_name(t_die_off), t, 0);
+			eppic_parsetype(tstr = GET_DIE_NAME(t_die_off), t, 0);
 			goto out;
 		case DW_TAG_union_type:
 			eppic_type_mkunion(t);
@@ -193,9 +192,9 @@ drilldown(ull offset, type_t *t)
 	}
 
 label:
-	eppic_type_setsize(t, get_die_length(t_die_off, TRUE));
+	eppic_type_setsize(t, GET_DIE_LENGTH(t_die_off, TRUE));
 	eppic_type_setidx(t, (ull)t_die_off);
-	tstr = get_die_name(t_die_off);
+	tstr = GET_DIE_NAME(t_die_off);
 
 out:
 	eppic_setupidx(t, ref, nidx, idxlst);
@@ -219,9 +218,9 @@ apimember(char *mname, ull idx, type_t *tm, member_t *m, ull *last_index)
 	ull m_die, die_off = idx;
 	char *name;
 
-	nfields = get_die_nfields(die_off);
+	nfields = GET_DIE_NFIELDS(die_off);
 	/*
-	 * get_die_nfields() returns < 0 if the die is not structure type
+	 * GET_DIE_NFIELDS() returns < 0 if the die is not structure type
 	 * or union type
 	 */
 	if (nfields <= 0)
@@ -236,7 +235,7 @@ apimember(char *mname, ull idx, type_t *tm, member_t *m, ull *last_index)
 		index = 0;
 
 	while (index < nfields) {
-		size = get_die_member(die_off, index, &offset, &name, &nbits,
+		size = GET_DIE_MEMBER(die_off, index, &offset, &name, &nbits,
 				&fbits, &m_die);
 
 		if (size < 0)
@@ -267,13 +266,13 @@ apigetctype(int ctype, char *name, type_t *tout)
 
 	switch (ctype) {
 	case V_TYPEDEF:
-		size = get_domain(name, DWARF_INFO_GET_DOMAIN_TYPEDEF, &die);
+		size = GET_DOMAIN(name, DWARF_INFO_GET_DOMAIN_TYPEDEF, &die);
 		break;
 	case V_STRUCT:
-		size = get_domain(name, DWARF_INFO_GET_DOMAIN_STRUCT, &die);
+		size = GET_DOMAIN(name, DWARF_INFO_GET_DOMAIN_STRUCT, &die);
 		break;
 	case V_UNION:
-		size = get_domain(name, DWARF_INFO_GET_DOMAIN_UNION, &die);
+		size = GET_DOMAIN(name, DWARF_INFO_GET_DOMAIN_UNION, &die);
 		break;
 	/* TODO
 	 * Implement for all the domains
@@ -308,7 +307,7 @@ apigetval(char *name, ull *val, VALUE_S *value)
 {
 	ull ptr = 0;
 
-	ptr = get_symbol_addr(name);
+	ptr = GET_SYMBOL_ADDR(name);
 	if (!ptr)
 		return 0;
 
@@ -321,7 +320,7 @@ apigetval(char *name, ull *val, VALUE_S *value)
 	ull type;
 	TYPE_S *stype;
 
-	type = get_die_offset(name);
+	type = GET_DIE_OFFSET(name);
 	stype = eppic_gettype(value);
 
 	apigetrtype(type, stype);
@@ -333,7 +332,7 @@ apigetval(char *name, ull *val, VALUE_S *value)
 	*val = eppic_getval(value);
 
 	if (!eppic_typeislocal(stype) && eppic_type_getidx(stype) > 100) {
-		char *tname = get_die_name(eppic_type_getidx(stype));
+		char *tname = GET_DIE_NAME(eppic_type_getidx(stype));
 		if (tname)
 			eppic_chktype(stype, tname);
 	}
@@ -356,7 +355,7 @@ static uint8_t
 apigetuint8(void *ptr)
 {
 	uint8_t val;
-	if (!readmem(VADDR, (unsigned long)ptr, (char *)&val, sizeof(val)))
+	if (!READMEM(VADDR, (unsigned long)ptr, (char *)&val, sizeof(val)))
 		return (uint8_t) -1;
 	return val;
 }
@@ -365,7 +364,7 @@ static uint16_t
 apigetuint16(void *ptr)
 {
 	uint16_t val;
-	if (!readmem(VADDR, (unsigned long)ptr, (char *)&val, sizeof(val)))
+	if (!READMEM(VADDR, (unsigned long)ptr, (char *)&val, sizeof(val)))
 		return (uint16_t) -1;
 	return val;
 }
@@ -374,7 +373,7 @@ static uint32_t
 apigetuint32(void *ptr)
 {
 	uint32_t val;
-	if (!readmem(VADDR, (unsigned long)ptr, (char *)&val, sizeof(val)))
+	if (!READMEM(VADDR, (unsigned long)ptr, (char *)&val, sizeof(val)))
 		return (uint32_t) -1;
 	return val;
 }
@@ -383,7 +382,7 @@ static uint64_t
 apigetuint64(void *ptr)
 {
 	uint64_t val;
-	if (!readmem(VADDR, (unsigned long)ptr, (char *)&val, sizeof(val)))
+	if (!READMEM(VADDR, (unsigned long)ptr, (char *)&val, sizeof(val)))
 		return (uint64_t) -1;
 	return val;
 }
@@ -423,15 +422,17 @@ eppic_memset(VALUE_S *vaddr, VALUE_S *vch, VALUE_S *vlen)
 	 * Set the value at address from iaddr till iaddr + nbytes
 	 * to the value specified in variable ch
 	 */
-	update_filter_info_raw(addr, ch, len);
+	UPDATE_FILTER_INFO_RAW(addr, ch, len);
 	return eppic_makebtype(1);
 }
 
 
 /* Initialize eppic */
 int
-eppic_init()
+eppic_init(void *fun_ptr)
 {
+	cb = (struct call_back *)fun_ptr;
+
 	if (eppic_open() >= 0) {
 
 		/* Register call back functions */
diff --git a/extension_eppic.h b/extension_eppic.h
index 0a53646..6edc318 100644
--- a/extension_eppic.h
+++ b/extension_eppic.h
@@ -3,7 +3,7 @@
  *
  * Created by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
  *
- * Copyright (C) 2012  IBM Corporation
+ * Copyright (C) 2012, 2013  IBM Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -19,6 +19,7 @@
 #define _EXTENSION_EPPIC_H
 
 #include "eppic_api.h"
+#include "erase_info.h"
 
 /*
  * MEMBER_S, ENUM_S, DEF_S and TYPE_S are extracts from eppic header
@@ -70,6 +71,25 @@ typedef TYPE_S {
 	ull rtype;  /* type_t a reference refers too */
 } type_t;
 
-extern int update_filter_info_raw(unsigned long long, int, int);
+#define ERRMSG(x...) \
+do { \
+		fprintf(stderr, __FUNCTION__); \
+		fprintf(stderr, ": "); \
+		fprintf(stderr, x); \
+} while (0)
+
+
+struct call_back *cb;
+
+#define GET_DOMAIN cb->get_domain
+#define READMEM cb->readmem
+#define GET_DIE_ATTR_TYPE cb->get_die_attr_type
+#define GET_DIE_NAME cb->get_die_name
+#define GET_DIE_OFFSET cb->get_die_offset
+#define GET_DIE_LENGTH cb->get_die_length
+#define GET_DIE_MEMBER cb->get_die_member
+#define GET_DIE_NFIELDS cb->get_die_nfields
+#define GET_SYMBOL_ADDR cb->get_symbol_addr
+#define UPDATE_FILTER_INFO_RAW cb->update_filter_info_raw
 
 #endif /* _EXTENSION_EPPIC_H */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
