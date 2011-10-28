Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RJj31-0003MU-Kk
	for kexec@lists.infradead.org; Fri, 28 Oct 2011 09:48:25 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 06B103EE0B5
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:22 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id E107F45DE4F
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:21 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id C8A3745DE4E
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:21 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id BC1271DB803B
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:21 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.240.81.147])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 7E0701DB802F
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:21 +0900 (JST)
Received: from m107.css.fujitsu.com (m107 [127.0.0.1])
	by m107.s.css.fujitsu.com (Postfix) with ESMTP id 4F87A86001F
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:21 +0900 (JST)
Received: from localhost6.localdomain6 (unknown [10.124.63.45])
	by m107.s.css.fujitsu.com (Postfix) with ESMTP id EB75986000E
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:20 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v2 03/14] Implement command-line processing
Date: Fri, 28 Oct 2011 18:48:20 +0900
Message-ID: <20111028094820.20940.871.stgit@localhost6.localdomain6>
In-Reply-To: <20111028094454.20940.1209.stgit@localhost6.localdomain6>
References: <20111028094454.20940.1209.stgit@localhost6.localdomain6>
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
To: kexec@lists.infradead.org

Introduce new long option --diskset=VMCORE, which is used for
specifying multiple VMCORE(s) generated on sadump diskset
configuration. --diskset and --split options can be specified at the
same time.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 Makefile       |    6 ++--
 makedumpfile.c |   39 ++++++++++++++++++++++++----
 sadump_info.c  |   78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sadump_info.h  |   61 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 176 insertions(+), 8 deletions(-)
 create mode 100644 sadump_info.c
 create mode 100644 sadump_info.h

diff --git a/Makefile b/Makefile
index f7f22e5..9b3ee9f 100644
--- a/Makefile
+++ b/Makefile
@@ -23,9 +23,9 @@ CFLAGS += -m64
 CFLAGS_ARCH += -m64
 endif
 
-SRC	= makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h
-SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c
-OBJ_PART = print_info.o dwarf_info.o elf_info.o erase_info.o
+SRC	= makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h sadump_info.h
+SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c
+OBJ_PART = print_info.o dwarf_info.o elf_info.o erase_info.o sadump_info.o
 SRC_ARCH = arch/arm.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c
 OBJ_ARCH = arch/arm.o arch/x86.o arch/x86_64.o arch/ia64.o arch/ppc64.o arch/s390x.o
 
diff --git a/makedumpfile.c b/makedumpfile.c
index 7b7c266..8a3a3d3 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -18,6 +18,7 @@
 #include "dwarf_info.h"
 #include "elf_info.h"
 #include "erase_info.h"
+#include "sadump_info.h"
 #include <sys/time.h>
 
 struct symbol_table	symbol_table;
@@ -6500,20 +6501,34 @@ check_param_for_creating_dumpfile(int argc, char *argv[])
 	if (info->name_filterconfig && !info->name_vmlinux)
 		return FALSE;
 
+	if (info->flag_sadump_diskset && !sadump_is_supported_arch())
+		return FALSE;
+
 	if ((argc == optind + 2) && !info->flag_flatten
-				 && !info->flag_split) {
+				 && !info->flag_split
+				 && !info->flag_sadump_diskset) {
 		/*
 		 * Parameters for creating the dumpfile from vmcore.
 		 */
 		info->name_memory   = argv[optind];
 		info->name_dumpfile = argv[optind+1];
 
-	} else if ((argc > optind + 2) && info->flag_split) {
+	} else if (info->flag_split && (info->flag_sadump_diskset
+					? (argc >= optind + 2)
+					: (argc > optind + 2))) {
+		int num_vmcore;
+
 		/*
 		 * Parameters for creating multiple dumpfiles from vmcore.
 		 */
-		info->num_dumpfile = argc - optind - 1;
-		info->name_memory  = argv[optind];
+		if (info->flag_sadump_diskset) {
+			num_vmcore = 0;
+			info->name_memory = sadump_head_disk_name_memory();
+		} else {
+			num_vmcore = 1;
+			info->name_memory = argv[optind];
+		}
+		info->num_dumpfile = argc - optind - num_vmcore;
 
 		if (info->flag_elf_dumpfile) {
 			MSG("Options for splitting dumpfile cannot be used with Elf format.\n");
@@ -6526,7 +6541,15 @@ check_param_for_creating_dumpfile(int argc, char *argv[])
 			return FALSE;
 		}
 		for (i = 0; i < info->num_dumpfile; i++)
-			SPLITTING_DUMPFILE(i) = argv[optind + 1 + i];
+			SPLITTING_DUMPFILE(i) = argv[optind + num_vmcore + i];
+
+	} else if ((argc == optind + 1) && !info->flag_split
+					&& info->flag_sadump_diskset) {
+		info->name_dumpfile = argv[optind];
+		info->name_memory = sadump_head_disk_name_memory();
+
+		DEBUG_MSG("name_dumpfile: %s\n", info->name_dumpfile);
+		DEBUG_MSG("name_memory: %s\n", info->name_memory);
 
 	} else if ((argc == optind + 1) && info->flag_flatten) {
 		/*
@@ -6594,6 +6617,7 @@ static struct option longopts[] = {
 	{"dump-dmesg", no_argument, NULL, 'M'}, 
 	{"config", required_argument, NULL, 'C'},
 	{"help", no_argument, NULL, 'h'},
+	{"diskset", required_argument, NULL, 'k'},
 	{0, 0, 0, 0}
 };
 
@@ -6661,6 +6685,11 @@ main(int argc, char *argv[])
 			info->flag_read_vmcoreinfo = 1;
 			info->name_vmcoreinfo = optarg;
 			break;
+		case 'k':
+			if (!sadump_add_diskset_info(optarg))
+				goto out;
+			info->flag_sadump_diskset = 1;
+			break;
 		case 'm':
 			message_level = atoi(optarg);
 			break;
diff --git a/sadump_info.c b/sadump_info.c
new file mode 100644
index 0000000..c94d233
--- /dev/null
+++ b/sadump_info.c
@@ -0,0 +1,78 @@
+/*
+ * sadump_info.c
+ *
+ * Created by: HATAYAMA, Daisuke <d.hatayama@jp.fujitsu.com>
+ *
+ * Copyright (C) 2011  FUJITSU LIMITED
+ * Copyright (C) 2011  NEC Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#if defined(__x86__) || defined(__x86_64__)
+
+#include "makedumpfile.h"
+#include "print_info.h"
+
+struct sadump_diskset_info {
+	char *name_memory;
+	int fd_memory;
+	struct sadump_part_header *sph_memory;
+	unsigned long data_offset;
+};
+
+struct sadump_info {
+	struct sadump_part_header *sph_memory;
+	struct sadump_header *sh_memory;
+	struct sadump_disk_set_header *sdh_memory;
+	struct sadump_media_header *smh_memory;
+	struct sadump_diskset_info *diskset_info;
+	int num_disks;
+	unsigned long sub_hdr_offset;
+	uint32_t smram_cpu_state_size;
+	unsigned long data_offset;
+};
+
+static struct sadump_info sadump_info = {};
+static struct sadump_info *si = &sadump_info;
+
+int
+sadump_add_diskset_info(char *name_memory)
+{
+	si->num_disks++;
+
+	si->diskset_info =
+		realloc(si->diskset_info,
+			si->num_disks*sizeof(struct sadump_diskset_info));
+	if (!si->diskset_info) {
+		ERRMSG("Can't allocate memory for sadump_diskset_info. %s\n",
+		       strerror(errno));
+		return FALSE;
+	}
+
+	si->diskset_info[si->num_disks - 1].name_memory = name_memory;
+
+	return TRUE;
+}
+
+char *
+sadump_head_disk_name_memory(void)
+{
+	return si->diskset_info[0].name_memory;
+}
+
+void
+free_sadump_info(void)
+{
+	if (si->diskset_info)
+		free(si->diskset_info);
+}
+
+#endif /* defined(__x86__) && defined(__x86_64__) */
diff --git a/sadump_info.h b/sadump_info.h
new file mode 100644
index 0000000..863956d
--- /dev/null
+++ b/sadump_info.h
@@ -0,0 +1,61 @@
+/*
+ * sadump_info.h
+ *
+ * Created by: HATAYAMA, Daisuke <d.hatayama@jp.fujitsu.com>
+ *
+ * Copyright (C) 2011  FUJITSU LIMITED
+ * Copyright (C) 2011  NEC Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _SADUMP_INFO_H
+#define _SADUMP_INFO_H
+
+#include "makedumpfile.h"
+
+#if defined(__x86__) || defined(__x86_64__)
+
+int sadump_add_diskset_info(char *name_memory);
+char *sadump_head_disk_name_memory(void);
+void free_sadump_info(void);
+
+static inline int sadump_is_supported_arch(void)
+{
+	return TRUE;
+}
+
+#else
+
+static inline int sadump_add_diskset_info(char *name_memory)
+{
+	return TRUE;
+}
+
+static inline char *
+sadump_head_disk_name_memory(void)
+{
+	return NULL;
+}
+
+static inline void free_sadump_info(void)
+{
+	return;
+}
+
+static inline int sadump_is_supported_arch(void)
+{
+	return FALSE;
+}
+
+#endif
+
+#endif /* _SADUMP_INFO_H */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
