Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TWOii-00066P-P6
 for kexec@lists.infradead.org; Thu, 08 Nov 2012 09:48:21 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 6115A3EE0BD
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:19 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 49B3245DE4F
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:19 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 32D9E45DE4E
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:19 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 1F81C1DB8037
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:19 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id CCF781DB802F
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:18 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 02/10] Add debuginfo interface for enum type size
Date: Thu, 08 Nov 2012 18:48:18 +0900
Message-ID: <20121108094818.30421.23629.stgit@localhost6.localdomain6>
In-Reply-To: <20121108094609.30421.40556.stgit@localhost6.localdomain6>
References: <20121108094609.30421.40556.stgit@localhost6.localdomain6>
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
Cc: kumagai-atsushi@mxc.nes.nec.co.jp

This is need to determine if a specified enumeration type is present
in a given debug information.

In this patch set, I'll use this to check if enum pageflags is
present.

The newly introduced interface is a simple extension from the existing
one for enumeration value.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 dwarf_info.c   |   18 +++++++++++++++++-
 dwarf_info.h   |    1 +
 makedumpfile.h |   13 +++++++++++--
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/dwarf_info.c b/dwarf_info.c
index 94b920a..09a8e1e 100644
--- a/dwarf_info.c
+++ b/dwarf_info.c
@@ -607,7 +607,7 @@ search_structure(Dwarf_Die *die, int *found)
 static void
 search_number(Dwarf_Die *die, int *found)
 {
-	int tag;
+	int tag, bytesize;
 	Dwarf_Word const_value;
 	Dwarf_Attribute attr;
 	Dwarf_Die child, *walker;
@@ -618,6 +618,22 @@ search_number(Dwarf_Die *die, int *found)
 		if (tag != DW_TAG_enumeration_type)
 			continue;
 
+		if (dwarf_info.cmd == DWARF_INFO_GET_ENUMERATION_TYPE_SIZE) {
+		   		   name = dwarf_diename(die);
+
+			if (!name || strcmp(name, dwarf_info.struct_name))
+			   	     continue;
+
+			if ((bytesize = dwarf_bytesize(die)) <= 0)
+			   	      	continue;
+
+			*found = TRUE;
+
+			dwarf_info.struct_size = bytesize;
+
+			return;
+				}
+
 		if (dwarf_child(die, &child) != 0)
 			continue;
 
diff --git a/dwarf_info.h b/dwarf_info.h
index 8d0084d..185cbb6 100644
--- a/dwarf_info.h
+++ b/dwarf_info.h
@@ -46,6 +46,7 @@ enum {
 	DWARF_INFO_CHECK_SYMBOL_ARRAY_TYPE,
 	DWARF_INFO_GET_SYMBOL_TYPE,
 	DWARF_INFO_GET_MEMBER_TYPE,
+	DWARF_INFO_GET_ENUMERATION_TYPE_SIZE,
 };
 
 char *get_dwarf_module_name(void);
diff --git a/makedumpfile.h b/makedumpfile.h
index 97aca2a..20f4d99 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -256,14 +256,23 @@ do { \
 #define ARRAY_LENGTH(X)		(array_table.X)
 #define SIZE_INIT(X, Y) \
 do { \
-	if ((SIZE(X) = get_structure_size(Y, 0)) == FAILED_DWARFINFO) \
+	if ((SIZE(X) = get_structure_size(Y, DWARF_INFO_GET_STRUCT_SIZE))	\
+		== FAILED_DWARFINFO) \
 		return FALSE; \
 } while (0)
 #define TYPEDEF_SIZE_INIT(X, Y) \
 do { \
-	if ((SIZE(X) = get_structure_size(Y, 1)) == FAILED_DWARFINFO) \
+	if ((SIZE(X) = get_structure_size(Y, DWARF_INFO_GET_TYPEDEF_SIZE)) \
+		== FAILED_DWARFINFO) \
 		return FALSE; \
 } while (0)
+#define ENUM_TYPE_SIZE_INIT(X, Y) \
+do { \
+	if ((SIZE(X) = get_structure_size(Y,	\
+		DWARF_INFO_GET_ENUMERATION_TYPE_SIZE))	\
+			== FAILED_DWARFINFO)				\
+	return FALSE; \
+} while (0)
 #define OFFSET_INIT(X, Y, Z) \
 do { \
 	if ((OFFSET(X) = get_member_offset(Y, Z, DWARF_INFO_GET_MEMBER_OFFSET)) \


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
