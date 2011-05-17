Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QMQWs-0002UD-JX
	for kexec@lists.infradead.org; Tue, 17 May 2011 20:06:10 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp02.au.ibm.com (8.14.4/8.13.1) with ESMTP id p4HK0IJX023418
	for <kexec@lists.infradead.org>; Wed, 18 May 2011 06:00:18 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4HK5oTB1081588
	for <kexec@lists.infradead.org>; Wed, 18 May 2011 06:05:50 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p4HK638F008796
	for <kexec@lists.infradead.org>; Wed, 18 May 2011 06:06:03 +1000
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: [PATCH v2 6/8] makedumpfile: Read and process 'for' command from
	config file.
Date: Wed, 18 May 2011 01:35:19 +0530
Message-ID: <20110517200514.12740.86690.stgit@mars.in.ibm.com>
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

This patch adds support to read and process 'for' command from config file
to filter multiple memory locations that are accessible through an array,
link list or list_head.

The syntax for 'for' (loop construct) filter command is:

for <id> in {<ArrayVar> |
	     <StructVar> via <NextMember> |
	     <ListHeadVar> within <StructName>:<ListHeadMember>}
	erase <id>[.MemberExpression] [size <SizeExpression>|nullify]
	[erase <id> ...]
	[...]
endfor

Updated filter.conf(8) man page that describes the syntax for loop construct.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Prerna Saxena <prerna@linux.vnet.ibm.com>
---

 makedumpfile.c      |  533 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 makedumpfile.conf   |   67 ++++++
 makedumpfile.conf.8 |  212 ++++++++++++++++++++
 makedumpfile.h      |   19 ++
 4 files changed, 814 insertions(+), 17 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 1c7237a..a616bae 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -7788,13 +7788,20 @@ free_config_entry(struct config_entry *ce)
 void
 free_config(struct config *config)
 {
+	int i;
 	if (config) {
 		if (config->module_name)
 			free(config->module_name);
+		for (i = 0; i < config->num_filter_symbols; i++) {
+			if (config->filter_symbol[i])
+				free_config_entry(config->filter_symbol[i]);
+			if (config->size_symbol[i])
+				free_config_entry(config->size_symbol[i]);
+		}
 		if (config->filter_symbol)
-			free_config_entry(config->filter_symbol);
+			free(config->filter_symbol);
 		if (config->size_symbol)
-			free_config_entry(config->size_symbol);
+			free(config->size_symbol);
 		free(config);
 	}
 }
@@ -7851,7 +7858,16 @@ create_config_entry(const char *token, unsigned short flag, int line)
 			/* First node is always a symbol name */
 			ptr->flag |= SYMBOL_ENTRY;
 		}
-		if (flag & FILTER_ENTRY) {
+		if (flag & ITERATION_ENTRY) {
+			/* Max depth for iteration entry is 1 */
+			if (depth > 0) {
+				ERRMSG("Config error at %d: Invalid iteration "
+					"variable entry.\n", line);
+				goto err_out;
+			}
+			ptr->name = strdup(cur);
+		}
+		if (flag & (FILTER_ENTRY | LIST_ENTRY)) {
 			ptr->name = strdup(cur);
 		}
 		if (flag & SIZE_ENTRY) {
@@ -8050,6 +8066,7 @@ get_config_token(char *expected_token, unsigned char flag, int *line,
 static int
 read_size_entry(struct config *config, int line)
 {
+	int idx = config->num_filter_symbols - 1;
 	char *token = get_config_token(NULL, 0, &line, NULL, NULL);
 
 	if (!token || IS_KEYWORD(token)) {
@@ -8057,12 +8074,19 @@ read_size_entry(struct config *config, int line)
 		" 'size' keyword.\n", line);
 		return FALSE;
 	}
-	config->size_symbol = create_config_entry(token, SIZE_ENTRY, line);
-	if (!config->size_symbol) {
+	config->size_symbol[idx] = create_config_entry(token, SIZE_ENTRY, line);
+	if (!config->size_symbol[idx]) {
 		ERRMSG("Error at line %d: Failed to read size symbol\n",
 									line);
 		return FALSE;
 	}
+	if (config->iter_entry && config->size_symbol[idx]->name &&
+					(!strcmp(config->size_symbol[idx]->name,
+					config->iter_entry->name))) {
+		config->size_symbol[idx]->flag &= ~SYMBOL_ENTRY;
+		config->size_symbol[idx]->flag |= VAR_ENTRY;
+		config->size_symbol[idx]->refer_to = config->iter_entry;
+	}
 	return TRUE;
 }
 
@@ -8076,6 +8100,7 @@ read_size_entry(struct config *config, int line)
 static int
 read_filter_entry(struct config *config, int line)
 {
+	int size, idx;
 	char *token = get_config_token(NULL, 0, &line, NULL, NULL);
 
 	if (!token || IS_KEYWORD(token)) {
@@ -8083,15 +8108,41 @@ read_filter_entry(struct config *config, int line)
 		" 'erase' command.\n", line);
 		return FALSE;
 	}
-	config->filter_symbol =
+
+	idx = config->num_filter_symbols;
+	config->num_filter_symbols++;
+	size = config->num_filter_symbols * sizeof(struct config_entry *);
+	config->filter_symbol = realloc(config->filter_symbol, size);
+	config->size_symbol = realloc(config->size_symbol, size);
+
+	if (!config->filter_symbol || !config->size_symbol) {
+		ERRMSG("Can't get memory to read config symbols.\n");
+		return FALSE;
+	}
+	config->filter_symbol[idx] = NULL;
+	config->size_symbol[idx] = NULL;
+
+	config->filter_symbol[idx] =
 			create_config_entry(token, FILTER_ENTRY, line);
-	if (!config->filter_symbol) {
+	if (!config->filter_symbol[idx]) {
 		ERRMSG("Error at line %d: Failed to read filter symbol\n",
 									line);
 		return FALSE;
 	}
+	if (config->iter_entry) {
+		if (strcmp(config->filter_symbol[idx]->name,
+				config->iter_entry->name)) {
+			ERRMSG("Config error at %d: unused iteration"
+				" variable '%s'.\n", line,
+				config->iter_entry->name);
+			return FALSE;
+		}
+		config->filter_symbol[idx]->flag &= ~SYMBOL_ENTRY;
+		config->filter_symbol[idx]->flag |= VAR_ENTRY;
+		config->filter_symbol[idx]->refer_to = config->iter_entry;
+	}
 	if (get_config_token("nullify", 0, &line, NULL, NULL)) {
-		config->filter_symbol->nullify = 1;
+		config->filter_symbol[idx]->nullify = 1;
 	}
 	else if (get_config_token("size", 0, &line, NULL, NULL)) {
 		if (!read_size_entry(config, line))
@@ -8100,6 +8151,150 @@ read_filter_entry(struct config *config, int line)
 	return TRUE;
 }
 
+static int
+add_traversal_entry(struct config_entry *ce, char *member, int line)
+{
+	if (!ce)
+		return FALSE;
+
+	while (ce->next)
+		ce = ce->next;
+
+	ce->next = create_config_entry(member, LIST_ENTRY, line);
+	if (ce->next == NULL) {
+		ERRMSG("Error at line %d: Failed to read 'via' member\n",
+									line);
+		return FALSE;
+	}
+
+	ce->next->flag |= TRAVERSAL_ENTRY;
+	ce->next->flag &= ~SYMBOL_ENTRY;
+	return TRUE;
+}
+
+static int
+read_list_entry(struct config *config, int line)
+{
+	char *token = get_config_token(NULL, 0, &line, NULL, NULL);
+
+	if (!token || IS_KEYWORD(token)) {
+		ERRMSG("Config error at %d: expected list symbol after"
+		" 'in' keyword.\n", line);
+		return FALSE;
+	}
+	config->list_entry = create_config_entry(token, LIST_ENTRY, line);
+	if (!config->list_entry) {
+		ERRMSG("Error at line %d: Failed to read list symbol\n",
+									line);
+		return FALSE;
+	}
+	/* Check if user has provided 'via' or 'within' keyword */
+	if (get_config_token("via", 0, &line, NULL, NULL)) {
+		/* next token is traversal member NextMember */
+		token = get_config_token(NULL, 0, &line, NULL, NULL);
+		if (!token) {
+			ERRMSG("Config error at %d: expected member name after"
+			" 'via' keyword.\n", line);
+			return FALSE;
+		}
+		if (!add_traversal_entry(config->list_entry, token, line))
+			return FALSE;
+	}
+	else if (get_config_token("within", 0, &line, NULL, NULL)) {
+		char *s_name, *lh_member;
+		/* next value is StructName:ListHeadMember */
+		s_name = get_config_token(NULL, 0, &line, NULL, NULL);
+		if (!s_name || IS_KEYWORD(s_name)) {
+			ERRMSG("Config error at %d: expected struct name after"
+			" 'within' keyword.\n", line);
+			return FALSE;
+		}
+		lh_member = strchr(s_name, ':');
+		if (lh_member) {
+			*lh_member++ = '\0';
+			if (!strlen(lh_member)) {
+				ERRMSG("Config error at %d: expected list_head"
+					" member after ':'.\n", line);
+				return FALSE;
+			}
+			config->iter_entry->next =
+				create_config_entry(lh_member,
+							ITERATION_ENTRY, line);
+			if (!config->iter_entry->next)
+				return FALSE;
+			config->iter_entry->next->flag &= ~SYMBOL_ENTRY;
+		}
+		if (!strlen(s_name)) {
+			ERRMSG("Config error at %d: Invalid token found "
+				"after 'within' keyword.\n", line);
+			return FALSE;
+		}
+		config->iter_entry->type_name = strdup(s_name);
+	}
+	return TRUE;
+}
+
+/*
+ * Read the iteration entry (LoopConstruct). The syntax is:
+ *
+ *	for <id> in {<ArrayVar> |
+ *		    <StructVar> via <NextMember> |
+ *		    <ListHeadVar> within <StructName>:<ListHeadMember>}
+ *		erase <id>[.MemberExpression] [size <SizeExpression>|nullify]
+ *		[erase <id>...]
+ *		[...]
+ *	endfor
+ */
+static int
+read_iteration_entry(struct config *config, int line)
+{
+	int eof = 0;
+	char *token = get_config_token(NULL, 0, &line, NULL, NULL);
+
+	if (!token || IS_KEYWORD(token)) {
+		ERRMSG("Config error at %d: expected iteration VAR entry after"
+		" 'for' keyword.\n", line);
+		return FALSE;
+	}
+	config->iter_entry =
+		create_config_entry(token, ITERATION_ENTRY, line);
+	if (!config->iter_entry) {
+		ERRMSG("Error at line %d: "
+			"Failed to read iteration VAR entry.\n", line);
+		return FALSE;
+	}
+	if (!get_config_token("in", 0, &line, NULL, NULL)) {
+		char *token;
+		token = get_config_token(NULL, 0, &line, NULL, NULL);
+		if (token)
+			ERRMSG("Config error at %d: Invalid token '%s'.\n",
+								line, token);
+		ERRMSG("Config error at %d: expected token 'in'.\n", line);
+		return FALSE;
+	}
+	if (!read_list_entry(config, line))
+		return FALSE;
+
+	while (!get_config_token("endfor", 0, &line, NULL, &eof) && !eof) {
+		if (get_config_token("erase", 0, &line, NULL, NULL)) {
+			if (!read_filter_entry(config, line))
+				return FALSE;
+		}
+		else {
+			token = get_config_token(NULL, 0, &line, NULL, NULL);
+			ERRMSG("Config error at %d: "
+				"Invalid token '%s'.\n", line, token);
+			return FALSE;
+		}
+	}
+	if (eof) {
+		ERRMSG("Config error at %d: No matching 'endfor' found.\n",
+									line);
+		return FALSE;
+	}
+	return TRUE;
+}
+
 /*
  * Configuration file 'makedumpfile.conf' contains filter commands.
  * Every individual filter command is considered as a config entry. A config
@@ -8125,6 +8320,13 @@ get_config(int skip)
 		if (!read_filter_entry(config, line_count))
 			goto err_out;
 	}
+	else if (get_config_token("for", 0, &line_count, &cur_module, &eof)) {
+		if (cur_module)
+			config->module_name = strdup(cur_module);
+
+		if (!read_iteration_entry(config, line_count))
+			goto err_out;
+	}
 	else {
 		if (!eof) {
 			token = get_config_token(NULL, 0, &line_count,
@@ -8193,6 +8395,24 @@ resolve_config_entry(struct config_entry *ce, unsigned long long base_addr,
 				ce->array_length = 0;
 		}
 	}
+	else if (ce->flag & VAR_ENTRY) {
+		/* iteration variable.
+		 * read the value from ce->refer_to
+		 */
+		ce->addr = ce->refer_to->addr;
+		ce->sym_addr = ce->refer_to->sym_addr;
+		ce->size = ce->refer_to->size;
+		ce->type_flag = ce->refer_to->type_flag;
+		if (!ce->type_name)
+			ce->type_name = strdup(ce->refer_to->type_name);
+
+		/* This entry has been changed hence next entry needs to
+		 * be resolved accordingly.
+		 */
+		if (ce->next)
+			ce->next->flag &= ~ENTRY_RESOLVED;
+		return TRUE;
+	}
 	else {
 		/* find the member offset */
 		ce->offset = get_member_offset(base_struct_name,
@@ -8216,9 +8436,58 @@ resolve_config_entry(struct config_entry *ce, unsigned long long base_addr,
 				ce->line, base_struct_name, ce->name);
 		return FALSE;
 	}
+	if (!strcmp(ce->type_name, "list_head")) {
+		ce->type_flag |= TYPE_LIST_HEAD;
+		/* If this list head expression is a LIST entry then
+		 * mark the next entry as TRAVERSAL_ENTRY, if any.
+		 * Error out if next entry is not a last node.
+		 */
+		if ((ce->flag & LIST_ENTRY) && ce->next) {
+			if (ce->next->next) {
+				ERRMSG("Config error at %d: Only one traversal"
+					" entry is allowed for list_head type"
+					" LIST entry", ce->line);
+				return FALSE;
+			}
+			ce->next->flag |= TRAVERSAL_ENTRY;
+		}
+	}
 	ce->addr = ce->sym_addr;
 	if (ce->size < 0)
 		ce->size = 0;
+	if ((ce->flag & LIST_ENTRY) && !ce->next) {
+		/* This is the last node of LIST entry.
+		 * For the list entry symbol, the allowed data types are:
+		 * Array, Structure Pointer (with 'next' member) and list_head.
+		 *
+		 * If this is a struct or list_head data type then
+		 * create a leaf node entry with 'next' member.
+		 */
+		if ((ce->type_flag & TYPE_BASE)
+					&& (strcmp(ce->type_name, "void")))
+			return FALSE;
+
+		if ((ce->type_flag & TYPE_LIST_HEAD)
+			|| ((ce->type_flag & (TYPE_STRUCT | TYPE_ARRAY))
+							== TYPE_STRUCT)) {
+			if (!(ce->flag & TRAVERSAL_ENTRY)) {
+				ce->next = create_config_entry("next",
+							LIST_ENTRY, ce->line);
+				if (ce->next == NULL)
+					return FALSE;
+
+				ce->next->flag |= TRAVERSAL_ENTRY;
+				ce->next->flag &= ~SYMBOL_ENTRY;
+			}
+		}
+		if (ce->flag & TRAVERSAL_ENTRY) {
+			/* type name of traversal entry should match with
+			 * that of parent node.
+			 */
+			if (strcmp(base_struct_name, ce->type_name))
+				return FALSE;
+		}
+	}
 	if ((ce->type_flag & (TYPE_ARRAY | TYPE_PTR)) == TYPE_PTR) {
 		/* If it's a pointer variable (not array) then read the
 		 * pointer value. */
@@ -8227,7 +8496,7 @@ resolve_config_entry(struct config_entry *ce, unsigned long long base_addr,
 		/*
 		 * if it is a void pointer then reset the size to 0
 		 * User need to provide a size to filter data referenced
-		 * by 'void *' pointer.
+		 * by 'void *' pointer or nullify option.
 		 */
 		if (!strcmp(ce->type_name, "void"))
 			ce->size = 0;
@@ -8286,6 +8555,8 @@ resolve_config_entry(struct config_entry *ce, unsigned long long base_addr,
 		free(val);
 	}
 	ce->flag |= ENTRY_RESOLVED;
+	if (ce->next)
+		ce->next->flag &= ~ENTRY_RESOLVED;
 	return TRUE;
 }
 
@@ -8294,18 +8565,87 @@ get_config_symbol_addr(struct config_entry *ce,
 			unsigned long long base_addr,
 			char *base_struct_name)
 {
+	unsigned long long addr = 0;
+
 	if (!(ce->flag & ENTRY_RESOLVED)) {
 		if (!resolve_config_entry(ce, base_addr, base_struct_name))
 			return 0;
 	}
 
+	if ((ce->flag & LIST_ENTRY)) {
+		/* handle List entry differently */
+		if (!ce->next) {
+			/* leaf node. */
+			if (ce->type_flag & TYPE_ARRAY) {
+				if (ce->index == ce->array_length)
+					return 0;
+				if (!(ce->type_flag & TYPE_PTR))
+					return (ce->addr +
+							(ce->index * ce->size));
+				/* Array of pointers.
+				 *
+				 * Array may contain NULL pointers at some
+				 * indexes. Hence return the next non-null
+				 * address value.
+				 */
+				while (ce->index < ce->array_length) {
+					addr = read_pointer_value(ce->addr +
+						(ce->index * pointer_size));
+					ce->index++;
+					if (addr)
+						break;
+				}
+				return addr;
+			}
+			else {
+				if (ce->addr == ce->cmp_addr)
+					return 0;
+
+				/* Set the leaf node as unresolved, so that
+				 * it will be resolved every time when
+				 * get_config_symbol_addr is called untill
+				 * it hits the exit condiftion.
+				 */
+				ce->flag &= ~ENTRY_RESOLVED;
+			}
+		}
+		else if ((ce->next->next == NULL) &&
+					!(ce->next->type_flag & TYPE_ARRAY)) {
+			/* the next node is leaf node. for non-array element
+			 * Set the sym_addr and addr of this node with that of
+			 * leaf node.
+			 */
+			addr = ce->addr;
+			ce->addr = ce->next->addr;
+
+			if (!(ce->type_flag & TYPE_LIST_HEAD)) {
+				if (addr == ce->next->cmp_addr)
+					return 0;
+
+				if (!ce->next->cmp_addr) {
+					/* safeguard against circular
+					 * link-list
+					 */
+					ce->next->cmp_addr = addr;
+				}
+
+				/* Force resolution of traversal node */
+				if (ce->addr && !resolve_config_entry(ce->next,
+						ce->addr, ce->type_name))
+					return 0;
+
+				return addr;
+			}
+		}
+	}
+
 	if (ce->next && ce->addr) {
 		/* Populate nullify flag down the list */
 		ce->next->nullify = ce->nullify;
 		return get_config_symbol_addr(ce->next, ce->addr,
 							ce->type_name);
 	}
-	else if (ce->nullify) {
+	else if (!ce->next && ce->nullify) {
 		/* nullify is applicable to pointer type */
 		if (ce->type_flag & TYPE_PTR)
 			return ce->sym_addr;
@@ -8340,6 +8680,48 @@ get_config_symbol_size(struct config_entry *ce,
 	}
 }
 
+static int
+resolve_list_entry(struct config_entry *ce, unsigned long long base_addr,
+			char *base_struct_name, char **out_type_name,
+			unsigned char *out_type_flag)
+{
+	if (!(ce->flag & ENTRY_RESOLVED)) {
+		if (!resolve_config_entry(ce, base_addr, base_struct_name))
+			return FALSE;
+	}
+
+	if (ce->next && (ce->next->flag & TRAVERSAL_ENTRY) &&
+				(ce->type_flag & TYPE_ARRAY)) {
+		/*
+		 * We are here because user has provided
+		 * traversal member for ArrayVar using 'via' keyword.
+		 *
+		 * Print warning and continue.
+		 */
+		ERRMSG("Warning: line %d: 'via' keyword not required "
+			"for ArrayVar.\n", ce->next->line);
+		free_config_entry(ce->next);
+		ce->next = NULL;
+	}
+	if ((ce->type_flag & TYPE_LIST_HEAD) && ce->next &&
+			(ce->next->flag & TRAVERSAL_ENTRY)) {
+		/* set cmp_addr for list empty condition.  */
+		ce->next->cmp_addr = ce->sym_addr;
+	}
+	if (ce->next && ce->addr) {
+		return resolve_list_entry(ce->next, ce->addr,
+				ce->type_name, out_type_name, out_type_flag);
+	}
+	else {
+		ce->index = 0;
+		if (out_type_name)
+			*out_type_name = ce->type_name;
+		if (out_type_flag)
+			*out_type_flag = ce->type_flag;
+	}
+	return TRUE;
+}
+
 /*
  * Insert the filter info node using insertion sort.
  * If filter node for a given paddr is aready present then update the size
@@ -8420,6 +8802,107 @@ update_filter_info(struct config_entry *filter_symbol,
 	return TRUE;
 }
 
+int
+initialize_iteration_entry(struct config_entry *ie,
+				char *type_name, unsigned char type_flag)
+{
+	if (!(ie->flag & ITERATION_ENTRY))
+		return FALSE;
+
+	if (type_flag & TYPE_LIST_HEAD) {
+		if (!ie->type_name) {
+			ERRMSG("Config error at %d: Use 'within' keyword "
+				"to specify StructName:ListHeadMember.\n",
+				ie->line);
+			return FALSE;
+		}
+		/*
+		 * If the LIST entry is of list_head type and user has not
+		 * specified the member name where iteration entry is hooked
+		 * on to list_head, then we default to member name 'list'.
+		 */
+		if (!ie->next) {
+			ie->next = create_config_entry("list", ITERATION_ENTRY,
+								ie->line);
+			ie->next->flag &= ~SYMBOL_ENTRY;
+		}
+	}
+	else {
+		if (ie->type_name) {
+			/* looks like user has used 'within' keyword for
+			 * non-list_head VAR. Print the warning and continue.
+			 */
+			ERRMSG("Warning: line %d: 'within' keyword not "
+				"required for ArrayVar/StructVar.\n", ie->line);
+			free(ie->type_name);
+
+			/* remove the next list_head member from iteration
+			 * entry that would have added as part of 'within'
+			 * keyword processing.
+			 */
+			if (ie->next) {
+				free_config_entry(ie->next);
+				ie->next = NULL;
+			}
+		}
+		ie->type_name = strdup(type_name);
+	}
+
+	if (!ie->size) {
+		ie->size = get_structure_size(ie->type_name,
+						DWARF_INFO_GET_STRUCT_SIZE);
+		if (ie->size == FAILED_DWARFINFO) {
+			ERRMSG("Config error at %d: "
+				"Can't get size for type: %s.\n",
+				ie->line, ie->type_name);
+			return FALSE;
+		}
+		else if (ie->size == NOT_FOUND_STRUCTURE) {
+			ERRMSG("Config error at %d: "
+				"Can't find structure: %s.\n",
+				ie->line, ie->type_name);
+			return FALSE;
+		}
+	}
+	if (type_flag & TYPE_LIST_HEAD) {
+		if (!resolve_config_entry(ie->next, 0, ie->type_name))
+			return FALSE;
+
+		if (strcmp(ie->next->type_name, "list_head")) {
+			ERRMSG("Config error at %d: "
+				"Member '%s' is not of 'list_head' type.\n",
+				ie->next->line, ie->next->name);
+			return FALSE;
+		}
+	}
+	return TRUE;
+}
+
+int
+list_entry_empty(struct config_entry *le, struct config_entry *ie)
+{
+	unsigned long long addr;
+
+	/* Error out if arguments are not correct */
+	if (!(le->flag & LIST_ENTRY) || !(ie->flag & ITERATION_ENTRY)) {
+		ERRMSG("Invalid arguments\n");
+		return TRUE;
+	}
+	addr = get_config_symbol_addr(le, 0, NULL);
+	if (!addr)
+		return TRUE;
+
+	if (ie->next) {
+		/* we are dealing with list_head */
+		ie->next->addr = addr;
+		ie->addr = addr - ie->next->offset;
+		//resolve_iteration_entry(ie, addr);
+	}
+	else
+		ie->addr = addr;
+	return FALSE;
+}
+
 /*
  * Process the config entry that has been read by get_config.
  * return TRUE on success
@@ -8427,7 +8910,35 @@ update_filter_info(struct config_entry *filter_symbol,
 int
 process_config(struct config *config)
 {
-	update_filter_info(config->filter_symbol, config->size_symbol);
+	int i;
+	if (config->list_entry) {
+		unsigned char type_flag;
+		char *type_name = NULL;
+		/*
+		 * We are dealing with 'for' command.
+		 * - First resolve list entry.
+		 * - Initialize iteration entry for iteration.
+		 * - Populate iteration entry untill list entry empty.
+		 */
+		if (!resolve_list_entry(config->list_entry, 0, NULL,
+					&type_name, &type_flag)) {
+			return FALSE;
+		}
+		if (!initialize_iteration_entry(config->iter_entry,
+						type_name, type_flag)) {
+			return FALSE;
+		}
+
+		while (!list_entry_empty(config->list_entry,
+						config->iter_entry)) {
+			for (i = 0; i < config->num_filter_symbols; i++)
+				update_filter_info(config->filter_symbol[i],
+							config->size_symbol[i]);
+		}
+	}
+	else
+		update_filter_info(config->filter_symbol[0],
+						config->size_symbol[0]);
 
 	return TRUE;
 }
diff --git a/makedumpfile.conf b/makedumpfile.conf
index 3d47e25..03e604a 100644
--- a/makedumpfile.conf
+++ b/makedumpfile.conf
@@ -80,3 +80,70 @@
 ##	erase cred_jar.array
 ##	erase vmlist.addr nullify
 ##
+##
+## - To filter kernel data referred through Array/list_head Symbol
+## =================================================================
+## Syntax:
+## for <id> in { <ArrayVar> |
+##		 <StructVar> via <NextMember> |
+##		 <ListHeadVar> within <StructName>:<ListHeadMember> }
+##	erase <id>[.MemberExpression] [size <SizeExpression>|nullify]
+##	[erase <id> ...]
+##	[...]
+## endfor
+##
+## where
+##	<id>
+##		Arbitrary name used to temporarily point to elements of the
+##		list. Referred as iteration variable.
+##	<ArrayVar>
+##		A simple expression in the form of <Symbol>[.member[...]] that
+##		results into an array variable.
+##	<StructVar>
+##		A simple expression in the form of <Symbol>[.member[...]] that
+##		results into a variable that points to a structure.
+##	<NextMember>
+##		Member within <StructVar> that points to an object of same
+##		type that of <StructVar>.
+##	<ListHeadVar>
+##		A simple expression in the form of <Symbol>[.member[...]] that
+##		results into a variable of type struct list_head.
+##	<StructName>
+##		Name of the structure type that can be traversed using
+##		HEAD variable <ListHeadVar> and contains a member named
+##		<ListHeadMember>.
+##	<ListHeadMember>
+##		Name of a member in <StructName>, of type struct list_head.
+##	<MemberExpression>
+##		A simple expression in the form of [.member[...]] to specify a
+##		member or component of a member in <ArrayVar>, <StructVar> or
+##		<StructName>.
+##	<SizeExpression>
+##		One of the following:
+##		- An integer value.
+##		- <Symbol>[.member[...]]
+##		- <id>[.MemberExpresion]
+##
+## The <ArrayVar>, <StructVar> and <ListHeadVar> is also referred as LIST
+## entry
+##
+## Filter out the specified size of the data accessible through LIST entries.
+## e.g.
+##	[vmlinux]
+##	# Traversing <ListHeadVar>
+##	for m in modules.next within module:list
+##		erase m.holders_dir.name
+##	endfor
+##	# Traversing <ArrayVar>
+##	for lc in lowcore_ptr
+##		erase lc
+##	endfor
+##	# Traversing link-list
+##	for cj in cred_jar via slabp_cache
+##		erase cj.name
+##	endfor
+##	[z90crypt]
+##	for ap_dev in ap_device_list.next within ap_device:list
+##		erase ap_dev.reply.message size ap_dev.reply.length
+##	endfor
+##
diff --git a/makedumpfile.conf.8 b/makedumpfile.conf.8
index 0a7d22a..ef0e86a 100644
--- a/makedumpfile.conf.8
+++ b/makedumpfile.conf.8
@@ -48,17 +48,21 @@ will skip the section with a warning message.
 .SH FILTER COMMANDS
 .SS filter command
 .PP
-A filter command is an erase command. Each erase command must start with a new
-line. Each filter command describes data in the dump to be erased.
+A filter command is either an erase command or a loop construct. Each erase
+command and loop construct must start with a new line. Each filter command
+describes data in the dump to be erased. Syntax:
 
 .br
-<\fIEraseCommands\fR>
+<\fIEraseCommands\fR>|<\fILoopConstruct\fR>
 .br
 
 where
 .TP
 <\fIEraseCommands\fR>
 Described in the subsection \fBerase command\fR of this manual page.
+.TP
+<\fILoopConstruct\fR>
+Described in the subsection \fBLoop construct\fR of this manual page.
 .SS erase command
 .PP
 Erase specified size of a kernel data referred by specified kernel/module
@@ -207,6 +211,208 @@ erase mystruct2.addr size mystruct2.addr_size
 .br
 .B EOF
 
+.SS Loop construct
+.PP
+A Loop construct allows the user to traverse the linked list or array elements
+and erase the data contents referred by each element.
+
+.br
+\fBfor\fR <\fIid\fR> \fBin\fR {<\fIArrayVar\fR> |
+.br
+		   <\fIStructVar\fR> \fBvia\fR <\fINextMember\fR> |
+.br
+		   <\fIListHeadVar\fR> \fBwithin\fR
+<\fIStructName\fR>\fB:\fR<\fIListHeadMember\fR>}
+.br
+	\fBerase\fR <\fIid\fR>[.\fIMemberExpression\fR]
+[\fBsize\fR <\fISizeExpression\fR>|\fBnullify\fR]
+.br
+	[\fBerase\fR <\fIid\fR>...]
+.br
+	[...]
+.br
+\fBendfor\fR
+.PP
+where
+.PP
+.TP
+<\fIid\fR>
+Arbitrary name used to temporarily point to elements of the list. This is
+also called iteration variable.
+.TP
+<\fIArrayVar\fR>
+A simple expression in the form of <\fISymbol\fR>[.\fImember\fR[...]] that
+results into an array variable.
+.TP
+<\fIStructVar\fR>
+A simple expression in the form of <\fISymbol\fR>[.\fImember\fR[...]] that
+results into a variable that points to a structure.
+.TP
+<\fINextMember\fR>
+Member within <\fIStructVar\fR> that points to an object of same type that of
+<\fIStructVar\fR>.
+.TP
+<\fIListHeadVar\fR>
+A simple expression in the form of <\fISymbol\fR>[.\fImember\fR[...]] that
+results into a variable of type struct list_head.
+.TP
+<\fIStructName\fR>
+Name of the structure type that can be traversed using HEAD variable
+<\fIListHeadVar\fR> and contains a member named <\fIListHeadMember\fR>.
+.TP
+<\fIListHeadMember\fR>
+Name of a member in <\fIStructName\fR>, of type struct list_head.
+.TP
+<\fIMemberExpression\fR>
+A simple expression in the form of [.\fImember\fR[...]] to specify a member
+or component of an element in <\fIArrayVar\fR>, <\fIStructVar\fR>
+or <\fIStructName\fR>.
+.TP
+<\fISizeExpression\fR>
+Size value in the form of <\fISizeValue\fR>, <\fIid\fR>[.\fIMemberExpression\fR]
+or <\fISymbol\fR>[.\fImember\fR[...]].
+.PP
+The \fBfor\fR loop construct allows to iterate on list of elements in an array
+or linked lists. Each element in the list is assigned to iteration variable
+<\fIid\fR>. The type of the iteration variable is determined by that of the
+list elements. The entry specified after '\fBin\fR' terminal is called LIST
+entry. The LIST entry can be an array variable, structure variable/pointer or a
+struct list_head type variable. The set of \fBerase\fR commands specified
+between \fBfor\fR and \fBendfor\fR, will be executed for each element in the
+LIST entry.
+.PP
+If the LIST entry specified is an array variable, then the loop will be
+executed for each array element. The size of the array will be determined by
+using dwarf information.
+.PP
+If the LIST entry specified is a structure variable/pointer, then a traversal
+member (<\fINextMember\fR>) must be specified using '\fBvia\fR' terminal. The
+\fBfor\fR loop will continue until the value of traversal member is NULL or
+matches with address of the first node <\fIStructVar\fR> if it is a circular
+linked list.
+.PP
+If the LIST entry is specified using a struct list_head type variable, then
+\fBwithin\fR terminal must be used to specify the structure name
+<\fIStructName\fR> that is surrounding to it along with the struct list_head
+type member after '\fB:\fR' which is part of the linked list. In the erase
+statement <\fIid\fR> then denotes the structure that the list_head is
+contained in (ELEMENT_OF).
+.PP
+The below example illustrates how to use loop construct for traversing
+Array, linked list via next member and list_head.
+
+.B Example:
+.PP
+Assuming following piece of code is from kernel module 'mymodule':
+.br
+
+struct s1 {
+.br
+	struct *next;
+.br
+	struct list_head list;
+.br
+	char private[100];
+.br
+	void *key;
+.br
+	long key_size;
+.br
+};
+.br
+
+/* Global symbols */
+.br
+struct s1 mystruct1;
+.br
+static LIST_HEAD(s1_list_head);
+.br
+struct s1 myarray[100];
+.br
+
+void foo()
+.br
+{
+.br
+	struct s1 *s1_ptr;
+.br
+	...
+.br
+	...
+.br
+	s1_ptr = malloc(...);
+.br
+	...
+.br
+	...
+.br
+	list_add(&s1_ptr->list, &s1_list_head);
+.br
+	...
+.br
+}
+.br
+
+\fBmakedumpfile.conf:\fR
+.br
+[mymodule]
+.br
+# erase private fields from list starting with mystruct1 connected via
+.br
+# 'next' member:
+.br
+for mys1 in mystruct1 via next
+.br
+	erase mys1.private
+.br
+	erase mys1.key size mys1.key_size
+.br
+endfor
+.br
+
+# erase private fields from list starting with list_head variable
+.br
+# s1_list_head.
+.br
+for mys1 in s1_list_head.next within s1:list
+.br
+	erase mys1.private
+.br
+	erase mys1.key size mys1.key_size
+.br
+endfor
+.br
+
+# erase private fields from all elements of the array myarray:
+.br
+for mys1 in myarray
+.br
+	erase mys1.private
+.br
+	erase mys1.key size mys1.key_size
+.br
+endfor
+.br
+.B EOF
+.PP
+In the above example, the first \fBfor\fR construct traverses the linked list
+through a specified structure variable \fBmystruct1\fR of type \fBstruct s1\fR.
+The linked list can be traversed using '\fBnext\fR' member of \fBmystruct1\fR.
+Hence a \fBvia\fR terminal has been used to specify the traversal member
+name '\fBnext\fR'.
+.PP
+The second \fBfor\fR construct traverses the linked list through a specified
+struct list_head variable \fBs1_list_head.next\fR. The global symbol
+\fBs1_list_head\fR is a start address of the linked list and its \fBnext\fR
+member points to the address of struct list_head type member '\fBlist\fR' from
+\fBstruct s1\fR. Hence a \fBwithin\fR terminal is used to specify the structure
+name '\fBs1\fR' that can be traversed using \fBs1_list_head.next\fR variable
+along with the name of struct list_head type member '\fBlist\fR' which is part
+of the linked list that starts from \fBs1_list_head\fR global symbol.
+.PP
+The third \fBfor\fR construct traverses the array elements specified through
+a array variable \fBmyarray\fR.
+.br
 .SH SEE ALSO
 .PP
 makedumpfile(8)
diff --git a/makedumpfile.h b/makedumpfile.h
index 94f3521..1c61edb 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1275,6 +1275,7 @@ struct dwarf_info {
 #define TYPE_ARRAY	0x02
 #define TYPE_PTR	0x04
 #define TYPE_STRUCT	0x08
+#define TYPE_LIST_HEAD	0x10
 
 extern struct dwarf_info	dwarf_info;
 
@@ -1297,18 +1298,25 @@ struct config_entry {
 	unsigned long long	sym_addr;	/* Symbol address */
 	unsigned long long	addr;		/* Symbol address or
 						   value pointed by sym_addr */
+	unsigned long long	cmp_addr;	/* for LIST_ENTRY */
 	unsigned long		offset;
 	unsigned long		type_flag;
 	long			array_length;
+	long			index;
 	long			size;
 	int			line;	/* Line number in config file. */
+	struct config_entry	*refer_to;
 	struct config_entry	*next;
 };
 
 /* flags for config_entry.flag */
 #define FILTER_ENTRY	0x0001
 #define SIZE_ENTRY	0x0002
+#define ITERATION_ENTRY	0x0004
+#define LIST_ENTRY	0x0008
 #define SYMBOL_ENTRY	0x0010
+#define VAR_ENTRY	0x0020
+#define TRAVERSAL_ENTRY	0x0040
 #define ENTRY_RESOLVED	0x8000
 
 /*
@@ -1329,13 +1337,18 @@ struct filter_config {
 
 struct config {
 	char			*module_name;
-	struct config_entry	*filter_symbol;
-	struct config_entry	*size_symbol;
+	struct config_entry	*iter_entry;
+	struct config_entry	*list_entry;
+	int			num_filter_symbols;
+	struct config_entry	**filter_symbol;
+	struct config_entry	**size_symbol;
 };
 
 #define IS_KEYWORD(tkn)	\
 	(!strcmp(tkn, "erase") || !strcmp(tkn, "size") || \
-	!strcmp(tkn, "nullify"))
+	!strcmp(tkn, "nullify") || !strcmp(tkn, "for") || \
+	!strcmp(tkn, "in") || !strcmp(tkn, "within") || \
+	!strcmp(tkn, "endfor"))
 
 int readmem(int type_addr, unsigned long long addr, void *bufptr, size_t size);
 off_t paddr_to_offset(unsigned long long paddr);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
