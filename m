Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T19Jp-0000yL-Dx
 for kexec@lists.infradead.org; Tue, 14 Aug 2012 05:05:31 +0000
Date: Tue, 14 Aug 2012 14:03:57 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makedumpfile -g with recent kernels
Message-Id: <20120814140357.f03d55103281db3cccfc8572@mxc.nes.nec.co.jp>
In-Reply-To: <5020C8D9.7060303@canonical.com>
References: <4FFAA199.5040608@canonical.com>
 <20120802141251.2efc0e407259254e6ef60586@mxc.nes.nec.co.jp>
 <501A38F1.8030801@canonical.com>
 <20120806145418.5fc2e5473aeb94f0348b023e@mxc.nes.nec.co.jp>
 <501F74C9.9070508@canonical.com>
 <20120807152356.1c2dbacbe323c2706cc6e6e8@mxc.nes.nec.co.jp>
 <5020C8D9.7060303@canonical.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: stefan.bader@canonical.com
Cc: kexec@lists.infradead.org

Hello Stefan,

On Tue, 07 Aug 2012 09:50:49 +0200
Stefan Bader <stefan.bader@canonical.com> wrote:

> > 
> >          case DWARF_INFO_GET_MEMBER_OFFSET:
> >                  if ((!name) || strcmp(name, dwarf_info.member_name))
> >                          continue;
> >                  /*
> >                   * Get the member offset.
> >                   */
> >                  if (dwarf_tag(die) == DW_TAG_union_type)
> >                          offset = 0;
> >                  else if (!get_data_member_location(walker, &offset))
> >                          continue;
> >                  dwarf_info.member_offset = offset;
> >                  return TRUE;
> > 
> > And about your code:
> > 
> >>        case DWARF_INFO_GET_MEMBER_OFFSET_1ST_UNION:
> >>                 if (!get_die_type(walker, &die_type))
> >>                         continue;
> >>                 if (dwarf_tag(&die_type) != DW_TAG_union_type)
> >>                         continue;
> >>
> >>                 /*
> >>                  * At this point it is clear that this is a union.
> >>                  * Though unions have no offset elements (the offset
> >>                  * is always 0. So get_data_member_location would fail.
> >>                  */
> >>                  dwarf_info.member_offset = 0;
> >>                  return TRUE;
> > 
> > It's wrong that unions have no offset elements.
> > Correctly, members of union have no offset elements.
> 
> That code was just based on the (incorrect) assumption that we talk about
> *_OFFSET_1ST_UNION and thinking those were the dies that had no offset tags.
> But the members having no offset makes much more sense. But then (without
> looking at dwarf output), if it is only the members of unions that need the
> change (and now I understand why it is checking die and not die_type), the first
> union should always have an offset and that call would only descent into
> structures while looking for the first union and never go past a union.

Did you point out the case like the example below ?
(names of unions are only for explanation.)

Example:
	struct EXAMPLE {                  // top layer
		int A;
		union ONE {               // the target of *_OFFSET_1ST_UNION
			int B;
			union TWO {       // but, my code reaches here
				int C;
			};
		};
	};


Certainly, my change for *_OFFSET_1ST_UNION is wrong.
I changed is_anonymous_container() and attach the fixed patch to this mail.
I'll merge it into the next version unless you have any comment.


Thanks
Atsushi Kumagai

---
 dwarf_info.c   |  122 +++++++++++++++++++-------------------------------------
 dwarf_info.h   |    1 -
 makedumpfile.c |    8 ----
 makedumpfile.h |    6 ---
 4 files changed, 42 insertions(+), 95 deletions(-)

diff --git a/dwarf_info.c b/dwarf_info.c
index 1429858..fb11e49 100644
--- a/dwarf_info.c
+++ b/dwarf_info.c
@@ -64,7 +64,6 @@ is_search_structure(int cmd)
 	if ((cmd == DWARF_INFO_GET_STRUCT_SIZE)
 	    || (cmd == DWARF_INFO_GET_MEMBER_OFFSET)
 	    || (cmd == DWARF_INFO_GET_MEMBER_TYPE)
-	    || (cmd == DWARF_INFO_GET_MEMBER_OFFSET_IN_UNION)
 	    || (cmd == DWARF_INFO_GET_MEMBER_OFFSET_1ST_UNION)
 	    || (cmd == DWARF_INFO_GET_MEMBER_ARRAY_LENGTH))
 		return TRUE;
@@ -447,75 +446,41 @@ get_dwarf_base_type(Dwarf_Die *die)
 	return TRUE;
 }
 
-/*
- * Function for searching struct page.union.struct.mapping.
- */
 static int
-__search_mapping(Dwarf_Die *die, long *offset)
+is_anonymous_container(Dwarf_Die *die)
 {
-	int tag;
-	const char *name;
-	Dwarf_Die child, *walker;
-
-	if (dwarf_child(die, &child) != 0)
+	if (dwarf_diename(die))
 		return FALSE;
-
-	walker = &child;
-	do {
-		tag  = dwarf_tag(walker);
-		name = dwarf_diename(walker);
-
-		if (tag != DW_TAG_member)
-			continue;
-		if ((!name) || strcmp(name, dwarf_info.member_name))
-			continue;
-		if (!get_data_member_location(walker, offset))
-			continue;
+	if (dwarf_tag(die) == DW_TAG_structure_type)
+		return TRUE;
+	if (dwarf_info.cmd != DWARF_INFO_GET_MEMBER_OFFSET_1ST_UNION
+	    && dwarf_tag(die) == DW_TAG_union_type)
 		return TRUE;
-
-	} while (!dwarf_siblingof(walker, walker));
-
 	return FALSE;
 }
 
-/*
- * Function for searching struct page.union.struct.
- */
-static int
-search_mapping(Dwarf_Die *die, long *offset)
+static void
+adjust_member_offset(Dwarf_Die *die)
 {
-	Dwarf_Die child, *walker;
-	Dwarf_Die die_struct;
-
-	if (dwarf_child(die, &child) != 0)
-		return FALSE;
-
-	walker = &child;
-
-	do {
-		if (dwarf_tag(walker) != DW_TAG_member)
-			continue;
-		if (!get_die_type(walker, &die_struct))
-			continue;
-		if (dwarf_tag(&die_struct) != DW_TAG_structure_type)
-			continue;
-		if (__search_mapping(&die_struct, offset))
-			return TRUE;
-	} while (!dwarf_siblingof(walker, walker));
+	long offset;
 
-	return FALSE;
+	if (dwarf_info.member_offset == NOT_FOUND_STRUCTURE)
+		return;
+	if (!get_data_member_location(die, &offset))
+		return;
+	dwarf_info.member_offset += offset;
 }
 
-static void
+static int
 search_member(Dwarf_Die *die)
 {
 	int tag;
-	long offset, offset_union;
+	long offset;
 	const char *name;
-	Dwarf_Die child, *walker, die_union;
+	Dwarf_Die child, *walker, die_type;
 
 	if (dwarf_child(die, &child) != 0)
-		return;
+		return FALSE;
 
 	walker = &child;
 
@@ -526,6 +491,20 @@ search_member(Dwarf_Die *die)
 		if (tag != DW_TAG_member)
 			continue;
 
+		/*
+		 * Descend into anonymous members and search for member
+		 * there.
+		 */
+		if (!name) {
+			if (!get_die_type(walker, &die_type))
+				continue;
+			if (is_anonymous_container(&die_type))
+				if (search_member(&die_type)) {
+					adjust_member_offset(walker);
+					return TRUE;
+				}
+		}
+
 		switch (dwarf_info.cmd) {
 		case DWARF_INFO_GET_MEMBER_TYPE:
 			if ((!name) || strcmp(name, dwarf_info.member_name))
@@ -535,39 +514,23 @@ search_member(Dwarf_Die *die)
 			 */
 			if (!get_dwarf_base_type(walker))
 				continue;
-			return;
+			return TRUE;
 		case DWARF_INFO_GET_MEMBER_OFFSET:
 			if ((!name) || strcmp(name, dwarf_info.member_name))
 				continue;
 			/*
 			 * Get the member offset.
 			 */
-			if (!get_data_member_location(walker, &offset))
+			if (dwarf_tag(die) == DW_TAG_union_type)
+				offset = 0;
+			else if (!get_data_member_location(walker, &offset))
 				continue;
 			dwarf_info.member_offset = offset;
-			return;
-		case DWARF_INFO_GET_MEMBER_OFFSET_IN_UNION:
-			if (!get_die_type(walker, &die_union))
-				continue;
-			if (dwarf_tag(&die_union) != DW_TAG_union_type)
-				continue;
-			/*
-			 * Search page.mapping in union.
-			 */
-			if (!search_mapping(&die_union, &offset_union))
-				continue;
-
-			/*
-			 * Get the member offset.
-			 */
-			if (!get_data_member_location(walker, &offset))
- 				continue;
-			dwarf_info.member_offset = offset + offset_union;
- 			return;
+			return TRUE;
 		case DWARF_INFO_GET_MEMBER_OFFSET_1ST_UNION:
-			if (!get_die_type(walker, &die_union))
+			if (!get_die_type(walker, &die_type))
 				continue;
-			if (dwarf_tag(&die_union) != DW_TAG_union_type)
+			if (dwarf_tag(&die_type) != DW_TAG_union_type)
 				continue;
 			/*
 			 * Get the member offset.
@@ -575,7 +538,7 @@ search_member(Dwarf_Die *die)
 			if (!get_data_member_location(walker, &offset))
 				continue;
 			dwarf_info.member_offset = offset;
-			return;
+			return TRUE;
 		case DWARF_INFO_GET_MEMBER_ARRAY_LENGTH:
 			if ((!name) || strcmp(name, dwarf_info.member_name))
 				continue;
@@ -584,14 +547,14 @@ search_member(Dwarf_Die *die)
 			 */
 			if (!get_data_array_length(walker))
 				continue;
-			return;
+			return TRUE;
 		}
 	} while (!dwarf_siblingof(walker, walker));
 
 	/*
 	 * Return even if not found.
 	 */
-	return;
+	return FALSE;
 }
 
 static void
@@ -636,7 +599,6 @@ search_structure(Dwarf_Die *die, int *found)
 		break;
 	case DWARF_INFO_GET_MEMBER_TYPE:
 	case DWARF_INFO_GET_MEMBER_OFFSET:
-	case DWARF_INFO_GET_MEMBER_OFFSET_IN_UNION:
 	case DWARF_INFO_GET_MEMBER_OFFSET_1ST_UNION:
 	case DWARF_INFO_GET_MEMBER_ARRAY_LENGTH:
 		search_member(die);
diff --git a/dwarf_info.h b/dwarf_info.h
index 1e07484..8d0084d 100644
--- a/dwarf_info.h
+++ b/dwarf_info.h
@@ -37,7 +37,6 @@
 enum {
 	DWARF_INFO_GET_STRUCT_SIZE,
 	DWARF_INFO_GET_MEMBER_OFFSET,
-	DWARF_INFO_GET_MEMBER_OFFSET_IN_UNION,
 	DWARF_INFO_GET_MEMBER_OFFSET_1ST_UNION,
 	DWARF_INFO_GET_MEMBER_ARRAY_LENGTH,
 	DWARF_INFO_GET_SYMBOL_ARRAY_LENGTH,
diff --git a/makedumpfile.c b/makedumpfile.c
index d024e95..d32ce55 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -874,17 +874,9 @@ get_structure_info(void)
 	SIZE_INIT(page, "page");
 	OFFSET_INIT(page.flags, "page", "flags");
 	OFFSET_INIT(page._count, "page", "_count");
-
 	OFFSET_INIT(page.mapping, "page", "mapping");
 
 	/*
-	 * On linux-2.6.16 or later, page.mapping is defined
-	 * in anonymous union.
-	 */
-	if (OFFSET(page.mapping) == NOT_FOUND_STRUCTURE)
-		OFFSET_IN_UNION_INIT(page.mapping, "page", "mapping");
-
-	/*
 	 * Some vmlinux(s) don't have debugging information about
 	 * page.mapping. Then, makedumpfile assumes that there is
 	 * "mapping" next to "private(unsigned long)" in the first
diff --git a/makedumpfile.h b/makedumpfile.h
index 6f5489d..4bf502f 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -239,12 +239,6 @@ do { \
 	     == FAILED_DWARFINFO) \
 		return FALSE; \
 } while (0)
-#define OFFSET_IN_UNION_INIT(X, Y, Z) \
-do { \
-	if ((OFFSET(X) = get_member_offset(Y, Z, DWARF_INFO_GET_MEMBER_OFFSET_IN_UNION)) \
-	     == FAILED_DWARFINFO) \
-		return FALSE; \
-} while (0)
 #define SYMBOL_ARRAY_LENGTH_INIT(X, Y) \
 do { \
 	if ((ARRAY_LENGTH(X) = get_array_length(Y, NULL, DWARF_INFO_GET_SYMBOL_ARRAY_LENGTH)) == FAILED_DWARFINFO) \
-- 
1.7.9.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
