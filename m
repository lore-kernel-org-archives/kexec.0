Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e36.co.us.ibm.com ([32.97.110.154])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1ScD8S-0005sF-JL
 for kexec@lists.infradead.org; Wed, 06 Jun 2012 10:06:41 +0000
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Wed, 6 Jun 2012 04:06:39 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 2BFE819D804E
 for <kexec@lists.infradead.org>; Wed,  6 Jun 2012 10:06:32 +0000 (WET)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
 id q56A6W20221124
 for <kexec@lists.infradead.org>; Wed, 6 Jun 2012 04:06:32 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q56A6V0K003224
 for <kexec@lists.infradead.org>; Wed, 6 Jun 2012 04:06:32 -0600
Subject: [PATCH 5/7] Implement apimember and apigetrtype call back functions
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Wed, 06 Jun 2012 15:36:27 +0530
Message-ID: <20120606100627.12534.36358.stgit@aravinda>
In-Reply-To: <20120606095709.12534.63967.stgit@aravinda>
References: <20120606095709.12534.63967.stgit@aravinda>
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
To: kexec@lists.infradead.org
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp, buendgen@de.ibm.com

The patch includes functionality for apimember and apigetrtype eppic
callback routines along with helper functions to fetch information
related to the member of the structure/union

Whenever a structure/union member is accessed inside the eppic macro,
eppic will query makedumpfile through call back functions requesting
more information on the structure or union member. The information
includes member name, offset from structure, data type and size.
makedumpfile will get all these information using DWARF and pass
back to eppic using libeppic API calls.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 dwarf_info.c      |  203 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 dwarf_info.h      |    7 ++
 extension_eppic.c |  177 +++++++++++++++++++++++++++++++++++++++++++++-
 extension_eppic.h |    2 +
 4 files changed, 385 insertions(+), 4 deletions(-)

diff --git a/dwarf_info.c b/dwarf_info.c
index 32170ad..9029e46 100644
--- a/dwarf_info.c
+++ b/dwarf_info.c
@@ -465,6 +465,26 @@ get_dwarf_base_type(Dwarf_Die *die)
 }
 
 /*
+ * Get the die, given the offset
+ */
+static int
+get_die_from_offset(Dwarf_Off offset, Dwarf_Die *die)
+{
+	if (!init_dwarf_info())
+		return FALSE;
+
+	if ((!offset) || (!die))
+		return FALSE;
+
+	if (!dwarf_offdie(dwarf_info.dwarfd, offset, die)) {
+		ERRMSG("Can't find the DIE.\n");
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+/*
  * Function for searching struct page.union.struct.mapping.
  */
 static int
@@ -1266,6 +1286,189 @@ get_domain(char *symname, int cmd, unsigned long long *die)
 }
 
 /*
+ * Get the number of fields in a structure or union provided the
+ * die offset of the structure or union
+ */
+int
+get_die_nfields(unsigned long long die_off)
+{
+	int tag, nfields = 0;
+	Dwarf_Die result, child, *die;
+
+	if (!get_die_from_offset((Dwarf_Off) die_off, &result)) {
+		ERRMSG("Can't find the DIE.\n");
+		return -1;
+	}
+
+	die = &result;
+	tag = dwarf_tag(die);
+	if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type) {
+		ERRMSG("DIE is not of structure or union type.\n");
+		return -1;
+	}
+
+	if (dwarf_child(die, &child) != 0)
+		return -1;
+
+	/* Find the number of fields in the structure */
+	die = &child;
+	do {
+		tag = dwarf_tag(die);
+		if (tag == DW_TAG_member)
+			nfields++;
+		else
+			continue;
+	} while (!dwarf_siblingof(die, die));
+
+	return nfields;
+}
+
+/*
+ * Get the information of the structure member given by index
+ */
+int
+get_die_member(unsigned long long die_off, int index, long *offset,
+		char **name, int *nbits, int *fbits, unsigned long long *m_die)
+{
+	int tag, size, nfields = 0;
+	Dwarf_Die result, child, die_base, *die;
+
+	if (!offset || !nbits || !fbits || !name || !m_die)
+		return -1;
+
+	if (!get_die_from_offset((Dwarf_Off) die_off, &result)) {
+		ERRMSG("Can't find the DIE.\n");
+		return -1;
+	}
+
+	die = &result;
+	tag = dwarf_tag(die);
+	if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type) {
+		ERRMSG("DIE is not of structure or union type.\n");
+		return -1;
+	}
+
+	if (dwarf_child(die, &child) != 0)
+		return -1;
+
+	/* Find the correct field in the structure */
+	die = &child;
+	do {
+		tag = dwarf_tag(die);
+		if (tag == DW_TAG_member) {
+			if (nfields == index)
+				break;
+			else
+				nfields++;
+		}
+	} while (!dwarf_siblingof(die, die));
+
+	if (nfields != index) {
+		ERRMSG("No member found at index %d.\n", index);
+		return -1;
+	}
+
+	/* Fill in the required info for the member */
+	if(!get_data_member_location(die, offset))
+		*offset = 0;
+
+	*name = dwarf_diename(die);
+	*m_die = dwarf_dieoffset(die);
+
+	get_die_type(die, &die_base);
+	if (dwarf_tag(&die_base) == DW_TAG_array_type) {
+		dwarf_info.array_length = 0;
+		get_data_array_length(die);
+		size = dwarf_info.array_length;
+	} else {
+		size = dwarf_bytesize(&die_base);
+	}
+
+	/* TODO
+	 * Correctly update fbits and nbits
+	 */
+	*nbits = *fbits = 0;
+
+	if (size < 0)
+		return 0;
+	else
+		return size;
+}
+
+/*
+ * Get the die attribute type
+ */
+int
+get_die_attr_type(unsigned long long die_off, int *type_flag,
+		unsigned long long *die_attr_off)
+{
+	Dwarf_Die result;
+
+	if (!die_attr_off)
+		return FALSE;
+
+	if (!get_die_from_offset((Dwarf_Off) die_off, &result)) {
+		ERRMSG("Can't find the DIE.\n");
+		return FALSE;
+	}
+
+	if (!get_die_type(&result, &result))
+		return FALSE;
+
+	*die_attr_off = dwarf_dieoffset(&result);
+	*type_flag = dwarf_tag(&result);
+	return TRUE;
+}
+
+/*
+ * Get name attribute given the die offset
+ */
+char *
+get_die_name(unsigned long long die_off)
+{
+	Dwarf_Die result;
+
+	if (!die_off)
+		return NULL;
+
+	if (!get_die_from_offset((Dwarf_Off) die_off, &result)) {
+		ERRMSG("Can't find the DIE.\n");
+		return NULL;
+	}
+
+	return dwarf_diename(&result);
+}
+
+/*
+ * Get length attribute given the die offset
+ */
+int
+get_die_length(unsigned long long die_off, int flag)
+{
+	Dwarf_Die result, die_base;
+
+	if (!die_off)
+		return FALSE;
+
+	if (!get_die_from_offset((Dwarf_Off) die_off, &result)) {
+		ERRMSG("Can't find the DIE.\n");
+		return FALSE;
+	}
+
+	if (flag)
+		return dwarf_bytesize(&result);
+
+	get_die_type(&result, &die_base);
+	if (dwarf_tag(&die_base) == DW_TAG_array_type) {
+		dwarf_info.array_length = 0;
+		get_data_array_length(&result);
+		return dwarf_info.array_length;
+	} else {
+		return dwarf_bytesize(&die_base);
+	}
+}
+
+/*
  * Set the dwarf_info with kernel/module debuginfo file information.
  */
 int
diff --git a/dwarf_info.h b/dwarf_info.h
index 1f0d896..ac4feff 100644
--- a/dwarf_info.h
+++ b/dwarf_info.h
@@ -70,6 +70,13 @@ long get_array_length(char *name01, char *name02, unsigned int cmd);
 long get_enum_number(char *enum_name);
 int get_source_filename(char *structname, char *src_name, int cmd);
 long get_domain(char *symname, int cmd, unsigned long long *die);
+int get_die_nfields(unsigned long long die_off);
+int get_die_member(unsigned long long die_off, int index, long *offset,
+	char **name, int *nbits, int *fbits, unsigned long long *m_die);
+int get_die_attr_type(unsigned long long die_off, int *type_flag,
+	unsigned long long *die_attr_off);
+char *get_die_name(unsigned long long die_off);
+int get_die_length(unsigned long long die_off, int flag);
 int set_dwarf_debuginfo(char *mod_name, char *os_release, char *name_debuginfo, int fd_debuginfo);
 
 #endif  /* DWARF_INFO_H */
diff --git a/extension_eppic.c b/extension_eppic.c
index fb6eecb..0f9e3c2 100644
--- a/extension_eppic.c
+++ b/extension_eppic.c
@@ -19,9 +19,11 @@
 #include <string.h>
 #include <sys/types.h>
 #include <fcntl.h>
+#include <dwarf.h>
 
 #include "makedumpfile.h"
 #include "extension_eppic.h"
+#include "print_info.h"
 
 /*
  * Most of the functions included in this file performs similar
@@ -66,6 +68,36 @@ reg_callback(char *name, int load)
 }
 
 /*
+ * This function is a copy of eppic_setupidx() function in
+ * applications/crash/eppic.c file from eppic source code
+ * repository.
+ *
+ * set idx value to actual array indexes from specified size
+ */
+static void
+eppic_setupidx(TYPE_S *t, int ref, int nidx, int *idxlst)
+{
+	/* put the idxlst in index size format */
+	if (nidx) {
+		int i;
+		for (i = 0; i < nidx - 1; i++) {
+			/* kludge for array dimensions of [1] */
+			if (idxlst[i + 1] == 0) {
+				idxlst[i + 1] = 1;
+			}
+			idxlst[i] = idxlst[i] / idxlst[i + 1];
+		}
+
+		/* divide by element size for last element bound */
+		if (ref)
+			idxlst[i] /= eppic_defbsize();
+		else
+			idxlst[i] /= eppic_type_getsize(t);
+		eppic_type_setidxlst(t, idxlst);
+	}
+}
+
+/*
  * Call back functions for eppic to query the dump image
  */
 
@@ -81,11 +113,148 @@ apiputmem(ull iaddr, void *p, int nbytes)
 	return 1;
 }
 
+/*
+ * Drill down the type of the member and update eppic with information
+ * about the member
+ */
 static char *
-apimember(char *mname, ull pidx, type_t *tm,
-		member_t *m, ull *lidx)
+drilldown(ull offset, type_t *t)
 {
-	return 0;
+	int type_flag, len = 0, t_len = 0, nidx = 0;
+	int fctflg = 0, ref = 0, *idxlst = 0;
+	ull die_off = offset, t_die_off;
+	char *tstr = NULL;
+
+	while (get_die_attr_type(die_off, &type_flag, &t_die_off))
+	{
+		switch (type_flag) {
+			/* typedef inserts a level of reference to the actual type */
+			case DW_TAG_pointer_type:
+				ref++;
+				die_off = t_die_off;
+				/*
+				 * This could be a void *, in which case the drill
+				 * down stops here
+				 */
+				if (!get_die_attr_type(die_off, &type_flag, &t_die_off)) {
+					/* make it a char* */
+					eppic_parsetype("char", t, ref);
+					return eppic_strdup("");
+				}
+				break;
+			/* Handle pointer to function */
+			case DW_TAG_subroutine_type:
+				fctflg = 1;
+				die_off = t_die_off;
+				break;
+			/* Handle arrays */
+			case DW_TAG_array_type:
+				if (!idxlst) {
+					if (!(idxlst = eppic_calloc(sizeof(int) * \
+									(MAX_ARRAY_DIMENSION + 1)))) {
+						ERRMSG("Out of memory\n");
+						return NULL;
+					}
+				}
+				if (nidx >= MAX_ARRAY_DIMENSION) {
+					ERRMSG("Too many array indexes. Max=%d\n",
+							MAX_ARRAY_DIMENSION);
+					return NULL;
+				}
+
+				/* handle multi-dimensional array */
+				len = get_die_length(die_off, FALSE);
+				t_len = get_die_length(t_die_off, FALSE);
+				if (len > 0 && t_len > 0)
+					idxlst[nidx++] = len / t_len;
+				die_off = t_die_off;
+				break;
+			/* Handle typedef */
+			case DW_TAG_typedef:
+				die_off = t_die_off;
+				break;
+			case DW_TAG_base_type:
+				eppic_parsetype(tstr = get_die_name(t_die_off), t, 0);
+				goto out;
+			case DW_TAG_union_type:
+				eppic_type_mkunion(t);
+				goto label;
+			case DW_TAG_enumeration_type:
+				eppic_type_mkenum(t);
+				goto label;
+			case DW_TAG_structure_type:
+				eppic_type_mkstruct(t);
+				goto label;
+			/* Unknown TAG ? */
+			default:
+				die_off = t_die_off;
+				break;
+		}
+	}
+
+label:
+	eppic_type_setsize(t, get_die_length(t_die_off, TRUE));
+	eppic_type_setidx(t, (ull)t_die_off);
+	tstr = get_die_name(t_die_off);
+
+out:
+	eppic_setupidx(t, ref, nidx, idxlst);
+	if (fctflg)
+		eppic_type_setfct(t, 1);
+	eppic_pushref(t, ref + (nidx ? 1 : 0));
+	if (tstr)
+		return eppic_strdup(tstr);
+	return eppic_strdup("");
+}
+
+/*
+ * Get the type, size and position information for a member of a structure.
+ */
+static char *
+apimember(char *mname, ull idx, type_t *tm, member_t *m, ull *last_index)
+{
+	int index, nfields = -1, size;
+	int nbits = 0, fbits = 0;
+	long offset;
+	ull m_die, die_off = idx;
+	char *name;
+
+	nfields = get_die_nfields(die_off);
+	/*
+	 * get_die_nfields() returns < 0 if the die is not structure type
+	 * or union type
+	 */
+	if (nfields <= 0)
+		return NULL;
+
+	/* if we're being asked the next member in a getfirst/getnext sequence */
+	if (mname && !mname[0] && last_index && (*last_index))
+		index = *last_index;
+	else
+		index = 0;
+
+	while(index < nfields) {
+		size = get_die_member(die_off, index, &offset, &name, &nbits,
+				&fbits, &m_die);
+
+		if (size < 0)
+			return NULL;
+
+		if (!mname || !mname[0] || !strcmp(mname, name)) {
+			eppic_member_ssize(m, size);
+			if (name)
+				eppic_member_sname(m, name);
+			else
+				eppic_member_sname(m, "");
+			eppic_member_soffset(m, offset);
+			eppic_member_snbits(m, nbits);
+			eppic_member_sfbit(m, fbits);
+			*last_index = index + 1;
+			return drilldown(m_die, tm);
+		}
+		index++;
+	}
+	return NULL;
 }
 
 static int
@@ -120,7 +289,7 @@ apigetctype(int ctype, char *name, type_t *tout)
 static char *
 apigetrtype(ull idx, type_t *t)
 {
-	return "";
+	return drilldown(idx, t);
 }
 
 static int
diff --git a/extension_eppic.h b/extension_eppic.h
index 45f4028..805015a 100644
--- a/extension_eppic.h
+++ b/extension_eppic.h
@@ -29,6 +29,8 @@ int eppic_init(void);    /* Eppic initialize */
  * for makedumpfile extension.
  */
 
+#define MAX_ARRAY_DIMENSION 16
+
 /* member information */
 typedef MEMBER_S {
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
