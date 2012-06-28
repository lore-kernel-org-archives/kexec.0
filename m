Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SkIfa-0005O7-KN
 for kexec@lists.infradead.org; Thu, 28 Jun 2012 17:38:19 +0000
Received: by pbbrq13 with SMTP id rq13so3656417pbb.36
 for <kexec@lists.infradead.org>; Thu, 28 Jun 2012 10:38:17 -0700 (PDT)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [RFC PATCH 02/10] Add debuginfo interface for enum type size
Date: Fri, 29 Jun 2012 02:38:13 +0900
Message-ID: <20120628173813.19702.18946.stgit@fedora-machine>
In-Reply-To: <20120628173757.19702.75678.stgit@fedora-machine>
References: <20120628173757.19702.75678.stgit@fedora-machine>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

This is needed in this patch set to determine whether or not a certain
enumeration type exists from a given debuginfo. The interface is a
simple extension from the existing one for enumeration value.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 dwarf_info.c   |   29 +++++++++++++++++++++--------
 dwarf_info.h   |    1 +
 makedumpfile.h |   13 +++++++++++--
 3 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/dwarf_info.c b/dwarf_info.c
index 1429858..98efc26 100644
--- a/dwarf_info.c
+++ b/dwarf_info.c
@@ -75,7 +75,8 @@ is_search_structure(int cmd)
 static int
 is_search_number(int cmd)
 {
-	if (cmd == DWARF_INFO_GET_ENUM_NUMBER)
+	if ((cmd == DWARF_INFO_GET_ENUM_NUMBER)
+	    || (cmd == DWARF_INFO_GET_ENUMERATION_TYPE_SIZE))
 		return TRUE;
 	else
 		return FALSE;
@@ -647,7 +648,7 @@ search_structure(Dwarf_Die *die, int *found)
 static void
 search_number(Dwarf_Die *die, int *found)
 {
-	int tag;
+	int tag, bytesize;
 	Dwarf_Word const_value;
 	Dwarf_Attribute attr;
 	Dwarf_Die child, *walker;
@@ -658,6 +659,22 @@ search_number(Dwarf_Die *die, int *found)
 		if (tag != DW_TAG_enumeration_type)
 			continue;
 
+		if (dwarf_info.cmd == DWARF_INFO_GET_ENUMERATION_TYPE_SIZE) {
+			name = dwarf_diename(die);
+
+			if (!name || strcmp(name, dwarf_info.struct_name))
+				continue;
+
+			if ((bytesize = dwarf_bytesize(die)) <= 0)
+				continue;
+
+			*found = TRUE;
+
+			dwarf_info.struct_size = bytesize;
+
+			return;
+		}
+
 		if (dwarf_child(die, &child) != 0)
 			continue;
 
@@ -1026,13 +1043,9 @@ out:
  * Get the size of structure.
  */
 long
-get_structure_size(char *structname, int flag_typedef)
+get_structure_size(char *structname, int cmd)
 {
-	if (flag_typedef)
-		dwarf_info.cmd = DWARF_INFO_GET_TYPEDEF_SIZE;
-	else
-		dwarf_info.cmd = DWARF_INFO_GET_STRUCT_SIZE;
-
+	dwarf_info.cmd = cmd;
 	dwarf_info.struct_name = structname;
 	dwarf_info.struct_size = NOT_FOUND_STRUCTURE;
 
diff --git a/dwarf_info.h b/dwarf_info.h
index 1e07484..b445738 100644
--- a/dwarf_info.h
+++ b/dwarf_info.h
@@ -47,6 +47,7 @@ enum {
 	DWARF_INFO_CHECK_SYMBOL_ARRAY_TYPE,
 	DWARF_INFO_GET_SYMBOL_TYPE,
 	DWARF_INFO_GET_MEMBER_TYPE,
+	DWARF_INFO_GET_ENUMERATION_TYPE_SIZE,
 };
 
 char *get_dwarf_module_name(void);
diff --git a/makedumpfile.h b/makedumpfile.h
index 6f5489d..95c0abc 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -225,14 +225,23 @@ do { \
 #define ARRAY_LENGTH(X)		(array_table.X)
 #define SIZE_INIT(X, Y) \
 do { \
-	if ((SIZE(X) = get_structure_size(Y, 0)) == FAILED_DWARFINFO) \
+	if ((SIZE(X) = get_structure_size(Y, DWARF_INFO_GET_STRUCT_SIZE)) \
+	     == FAILED_DWARFINFO) \
 		return FALSE; \
 } while (0)
 #define TYPEDEF_SIZE_INIT(X, Y) \
 do { \
-	if ((SIZE(X) = get_structure_size(Y, 1)) == FAILED_DWARFINFO) \
+	if ((SIZE(X) = get_structure_size(Y, DWARF_INFO_GET_TYPEDEF_SIZE)) \
+	     == FAILED_DWARFINFO) \
 		return FALSE; \
 } while (0)
+#define ENUM_TYPE_SIZE_INIT(X, Y) \
+do { \
+	if ((SIZE(X) = get_structure_size(Y,	\
+		DWARF_INFO_GET_ENUMERATION_TYPE_SIZE))	\
+	     == FAILED_DWARFINFO)			\
+ 		return FALSE; \
+ } while (0)
 #define OFFSET_INIT(X, Y, Z) \
 do { \
 	if ((OFFSET(X) = get_member_offset(Y, Z, DWARF_INFO_GET_MEMBER_OFFSET)) \


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
