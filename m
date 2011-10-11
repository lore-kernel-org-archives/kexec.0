Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RDe4d-0003GH-Db
	for kexec@lists.infradead.org; Tue, 11 Oct 2011 15:16:57 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 551CE3EE0AE
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:16:53 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 371BA45DE55
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:16:53 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 203B545DE54
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:16:53 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 12E0A1DB8049
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:16:53 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.240.81.145])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id C16981DB8040
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:16:52 +0900 (JST)
Received: from m105.css.fujitsu.com (m105 [127.0.0.1])
	by m105.s.css.fujitsu.com (Postfix) with ESMTP id 923459C800A
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:16:52 +0900 (JST)
Received: from localhost (unknown [10.124.102.140])
	by m105.s.css.fujitsu.com (Postfix) with ESMTP id 3639B9C8001
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:16:52 +0900 (JST)
Date: Wed, 12 Oct 2011 00:16:46 +0900 (   )
Message-Id: <20111012.001646.39159763.d.hatayama@jp.fujitsu.com>
Subject: [PATCH 07/12] Initialize debug information for ELF note extraction
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20111012.001338.193691420.d.hatayama@jp.fujitsu.com>
References: <20111012.001338.193691420.d.hatayama@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Initialize symbol and type information for acessing VMCORE(s) data.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 makedumpfile.c |  168 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.h |  130 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 298 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 1686dff..4044bce 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -19,6 +19,7 @@
 #include "elf_info.h"
 #include "erase_info.h"
 #include "sadump_info.h"
+#include <stddef.h>
 #include <sys/time.h>
 
 struct symbol_table	symbol_table;
@@ -809,6 +810,19 @@ get_symbol_info(void)
 	SYMBOL_INIT(log_end, "log_end");
 	SYMBOL_INIT(max_pfn, "max_pfn");
 	SYMBOL_INIT(modules, "modules");
+	SYMBOL_INIT(linux_banner, "linux_banner");
+	SYMBOL_INIT(bios_cpu_apicid, "bios_cpu_apicid");
+	SYMBOL_INIT(x86_bios_cpu_apicid, "x86_bios_cpu_apicid");
+	if (SYMBOL(x86_bios_cpu_apicid) == NOT_FOUND_SYMBOL)
+		SYMBOL_INIT(x86_bios_cpu_apicid,
+			    "per_cpu__x86_bios_cpu_apicid");
+	SYMBOL_INIT(x86_bios_cpu_apicid_early_ptr,
+		    "x86_bios_cpu_apicid_early_ptr");
+	SYMBOL_INIT(x86_bios_cpu_apicid_early_map,
+		    "x86_bios_cpu_apicid_early_map");
+	SYMBOL_INIT(crash_notes, "crash_notes");
+	SYMBOL_INIT(__per_cpu_load, "__per_cpu_load");
+	SYMBOL_INIT(__per_cpu_offset, "__per_cpu_offset");
 
 	if (SYMBOL(node_data) != NOT_FOUND_SYMBOL)
 		SYMBOL_ARRAY_TYPE_INIT(node_data, "node_data");
@@ -818,6 +832,8 @@ get_symbol_info(void)
 		SYMBOL_ARRAY_LENGTH_INIT(mem_section, "mem_section");
 	if (SYMBOL(node_memblk) != NOT_FOUND_SYMBOL)
 		SYMBOL_ARRAY_LENGTH_INIT(node_memblk, "node_memblk");
+	if (SYMBOL(__per_cpu_offset) != NOT_FOUND_SYMBOL)
+		SYMBOL_ARRAY_LENGTH_INIT(__per_cpu_offset, "__per_cpu_offset");
 
 	return TRUE;
 }
@@ -934,6 +950,158 @@ get_structure_info(void)
 
 	TYPEDEF_SIZE_INIT(nodemask_t, "nodemask_t");
 
+	SIZE_INIT(percpu_data, "percpu_data");
+
+	/*
+	 * Get offset of the elf_prstatus members.
+	 */
+	SIZE_INIT(elf_prstatus, "elf_prstatus");
+	OFFSET_INIT(elf_prstatus.pr_reg, "elf_prstatus", "pr_reg");
+
+	/*
+	 * Get offset of the user_regs_struct members.
+	 */
+	SIZE_INIT(user_regs_struct, "user_regs_struct");
+
+#ifdef __x86__
+	if (SIZE(user_regs_struct) != NOT_FOUND_STRUCTURE) {
+		OFFSET_INIT(user_regs_struct.bx, "user_regs_struct", "bx");
+		OFFSET_INIT(user_regs_struct.cx, "user_regs_struct", "cx");
+		OFFSET_INIT(user_regs_struct.dx, "user_regs_struct", "dx");
+		OFFSET_INIT(user_regs_struct.si, "user_regs_struct", "si");
+		OFFSET_INIT(user_regs_struct.di, "user_regs_struct", "di");
+		OFFSET_INIT(user_regs_struct.bp, "user_regs_struct", "bp");
+		OFFSET_INIT(user_regs_struct.ax, "user_regs_struct", "ax");
+		OFFSET_INIT(user_regs_struct.ds, "user_regs_struct", "ds");
+		OFFSET_INIT(user_regs_struct.es, "user_regs_struct", "es");
+		OFFSET_INIT(user_regs_struct.fs, "user_regs_struct", "fs");
+		OFFSET_INIT(user_regs_struct.gs, "user_regs_struct", "gs");
+		OFFSET_INIT(user_regs_struct.orig_ax, "user_regs_struct",
+			    "orig_ax");
+		OFFSET_INIT(user_regs_struct.ip, "user_regs_struct", "ip");
+		OFFSET_INIT(user_regs_struct.cs, "user_regs_struct", "cs");
+		OFFSET_INIT(user_regs_struct.flags, "user_regs_struct",
+			    "flags");
+		OFFSET_INIT(user_regs_struct.sp, "user_regs_struct", "sp");
+		OFFSET_INIT(user_regs_struct.ss, "user_regs_struct", "ss");
+
+		if (OFFSET(user_regs_struct.bx) == NOT_FOUND_STRUCTURE)
+			OFFSET_INIT(user_regs_struct.bx, "user_regs_struct", "ebx");
+		if (OFFSET(user_regs_struct.bx) == NOT_FOUND_STRUCTURE)
+			OFFSET_INIT(user_regs_struct.cx, "user_regs_struct", "ecx");
+		if (OFFSET(user_regs_struct.bx) == NOT_FOUND_STRUCTURE)
+			OFFSET_INIT(user_regs_struct.dx, "user_regs_struct", "edx");
+		if (OFFSET(user_regs_struct.bx) == NOT_FOUND_STRUCTURE)
+			OFFSET_INIT(user_regs_struct.si, "user_regs_struct", "esi");
+		if (OFFSET(user_regs_struct.bx) == NOT_FOUND_STRUCTURE)
+			OFFSET_INIT(user_regs_struct.di, "user_regs_struct", "edi");
+		if (OFFSET(user_regs_struct.bx) == NOT_FOUND_STRUCTURE)
+			OFFSET_INIT(user_regs_struct.bp, "user_regs_struct", "ebp");
+		if (OFFSET(user_regs_struct.bx) == NOT_FOUND_STRUCTURE)
+			OFFSET_INIT(user_regs_struct.ax, "user_regs_struct", "eax");
+		if (OFFSET(user_regs_struct.bx) == NOT_FOUND_STRUCTURE)
+			OFFSET_INIT(user_regs_struct.orig_ax, "user_regs_struct", "orig_eax");
+		if (OFFSET(user_regs_struct.bx) == NOT_FOUND_STRUCTURE)
+			OFFSET_INIT(user_regs_struct.ip, "user_regs_struct", "eip");
+		if (OFFSET(user_regs_struct.bx) == NOT_FOUND_STRUCTURE)
+			OFFSET_INIT(user_regs_struct.flags, "user_regs_struct", "eflags");
+		if (OFFSET(user_regs_struct.bx) == NOT_FOUND_STRUCTURE)
+			OFFSET_INIT(user_regs_struct.sp, "user_regs_struct", "esp");
+	} else {
+		/*
+		 * Note: Sometimes kernel debuginfo doesn't contain
+		 * user_regs_struct structure information. Instead, we
+		 * take offsets from actual datatype.
+		 */
+		OFFSET(user_regs_struct.bx) = offsetof(struct user_regs_struct, bx);
+		OFFSET(user_regs_struct.cx) = offsetof(struct user_regs_struct, cx);
+		OFFSET(user_regs_struct.dx) = offsetof(struct user_regs_struct, dx);
+		OFFSET(user_regs_struct.si) = offsetof(struct user_regs_struct, si);
+		OFFSET(user_regs_struct.di) = offsetof(struct user_regs_struct, di);
+		OFFSET(user_regs_struct.bp) = offsetof(struct user_regs_struct, bp);
+		OFFSET(user_regs_struct.ax) = offsetof(struct user_regs_struct, ax);
+		OFFSET(user_regs_struct.ds) = offsetof(struct user_regs_struct, ds);
+		OFFSET(user_regs_struct.es) = offsetof(struct user_regs_struct, es);
+		OFFSET(user_regs_struct.fs) = offsetof(struct user_regs_struct, fs);
+		OFFSET(user_regs_struct.gs) = offsetof(struct user_regs_struct, gs);
+		OFFSET(user_regs_struct.orig_ax) = offsetof(struct user_regs_struct, orig_ax);
+		OFFSET(user_regs_struct.ip) = offsetof(struct user_regs_struct, ip);
+		OFFSET(user_regs_struct.cs) = offsetof(struct user_regs_struct, cs);
+		OFFSET(user_regs_struct.flags) = offsetof(struct user_regs_struct, flags);
+		OFFSET(user_regs_struct.sp) = offsetof(struct user_regs_struct, sp);
+		OFFSET(user_regs_struct.ss) = offsetof(struct user_regs_struct, ss);
+	}
+#endif /* __x86__ */
+
+#ifdef __x86_64__
+	if (SIZE(user_regs_struct) != NOT_FOUND_STRUCTURE) {
+		OFFSET_INIT(user_regs_struct.r15, "user_regs_struct", "r15");
+		OFFSET_INIT(user_regs_struct.r14, "user_regs_struct", "r14");
+		OFFSET_INIT(user_regs_struct.r13, "user_regs_struct", "r13");
+		OFFSET_INIT(user_regs_struct.r12, "user_regs_struct", "r12");
+		OFFSET_INIT(user_regs_struct.bp, "user_regs_struct", "bp");
+		OFFSET_INIT(user_regs_struct.bx, "user_regs_struct", "bx");
+		OFFSET_INIT(user_regs_struct.r11, "user_regs_struct", "r11");
+		OFFSET_INIT(user_regs_struct.r10, "user_regs_struct", "r10");
+		OFFSET_INIT(user_regs_struct.r9, "user_regs_struct", "r9");
+		OFFSET_INIT(user_regs_struct.r8, "user_regs_struct", "r8");
+		OFFSET_INIT(user_regs_struct.ax, "user_regs_struct", "ax");
+		OFFSET_INIT(user_regs_struct.cx, "user_regs_struct", "cx");
+		OFFSET_INIT(user_regs_struct.dx, "user_regs_struct", "dx");
+		OFFSET_INIT(user_regs_struct.si, "user_regs_struct", "si");
+		OFFSET_INIT(user_regs_struct.di, "user_regs_struct", "di");
+		OFFSET_INIT(user_regs_struct.orig_ax, "user_regs_struct",
+			    "orig_ax");
+		OFFSET_INIT(user_regs_struct.ip, "user_regs_struct", "ip");
+		OFFSET_INIT(user_regs_struct.cs, "user_regs_struct", "cs");
+		OFFSET_INIT(user_regs_struct.flags, "user_regs_struct",
+			    "flags");
+		OFFSET_INIT(user_regs_struct.sp, "user_regs_struct", "sp");
+		OFFSET_INIT(user_regs_struct.ss, "user_regs_struct", "ss");
+		OFFSET_INIT(user_regs_struct.fs_base, "user_regs_struct",
+			    "fs_base");
+		OFFSET_INIT(user_regs_struct.gs_base, "user_regs_struct",
+			    "gs_base");
+		OFFSET_INIT(user_regs_struct.ds, "user_regs_struct", "ds");
+		OFFSET_INIT(user_regs_struct.es, "user_regs_struct", "es");
+		OFFSET_INIT(user_regs_struct.fs, "user_regs_struct", "fs");
+		OFFSET_INIT(user_regs_struct.gs, "user_regs_struct", "gs");
+	} else {
+		/*
+		 * Note: Sometimes kernel debuginfo doesn't contain
+		 * user_regs_struct structure information. Instead, we
+		 * take offsets from actual datatype.
+		 */
+		OFFSET(user_regs_struct.r15) = offsetof(struct user_regs_struct, r15);
+		OFFSET(user_regs_struct.r14) = offsetof(struct user_regs_struct, r14);
+		OFFSET(user_regs_struct.r13) = offsetof(struct user_regs_struct, r13);
+		OFFSET(user_regs_struct.r12) = offsetof(struct user_regs_struct, r12);
+		OFFSET(user_regs_struct.bp) = offsetof(struct user_regs_struct, bp);
+		OFFSET(user_regs_struct.bx) = offsetof(struct user_regs_struct, bx);
+		OFFSET(user_regs_struct.r11) = offsetof(struct user_regs_struct, r11);
+		OFFSET(user_regs_struct.r10) = offsetof(struct user_regs_struct, r10);
+		OFFSET(user_regs_struct.r9) = offsetof(struct user_regs_struct, r9);
+		OFFSET(user_regs_struct.r8) = offsetof(struct user_regs_struct, r8);
+		OFFSET(user_regs_struct.ax) = offsetof(struct user_regs_struct, ax);
+		OFFSET(user_regs_struct.cx) = offsetof(struct user_regs_struct, cx);
+		OFFSET(user_regs_struct.dx) = offsetof(struct user_regs_struct, dx);
+		OFFSET(user_regs_struct.si) = offsetof(struct user_regs_struct, si);
+		OFFSET(user_regs_struct.di) = offsetof(struct user_regs_struct, di);
+		OFFSET(user_regs_struct.orig_ax) = offsetof(struct user_regs_struct, orig_ax);
+		OFFSET(user_regs_struct.ip) = offsetof(struct user_regs_struct, ip);
+		OFFSET(user_regs_struct.cs) = offsetof(struct user_regs_struct, cs);
+		OFFSET(user_regs_struct.flags) = offsetof(struct user_regs_struct, flags);
+		OFFSET(user_regs_struct.sp) = offsetof(struct user_regs_struct, sp);
+		OFFSET(user_regs_struct.ss) = offsetof(struct user_regs_struct, ss);
+		OFFSET(user_regs_struct.fs_base) = offsetof(struct user_regs_struct, fs_base);
+		OFFSET(user_regs_struct.gs_base) = offsetof(struct user_regs_struct, gs_base);
+		OFFSET(user_regs_struct.ds) = offsetof(struct user_regs_struct, ds);
+		OFFSET(user_regs_struct.es) = offsetof(struct user_regs_struct, es);
+		OFFSET(user_regs_struct.fs) = offsetof(struct user_regs_struct, fs);
+		OFFSET(user_regs_struct.gs) = offsetof(struct user_regs_struct, gs);
+	}
+#endif /* __x86_64__ */
+
 	return TRUE;
 }
 
diff --git a/makedumpfile.h b/makedumpfile.h
index 17ec590..433bc49 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -983,6 +983,18 @@ struct symbol_table {
 	 */
 
 	unsigned long long	modules;
+
+	/*
+	 * for sadump
+	 */
+	unsigned long long	linux_banner;
+	unsigned long long	bios_cpu_apicid;
+	unsigned long long	x86_bios_cpu_apicid;
+	unsigned long long	x86_bios_cpu_apicid_early_ptr;
+	unsigned long long	x86_bios_cpu_apicid_early_map;
+	unsigned long long	crash_notes;
+	unsigned long long	__per_cpu_offset;
+	unsigned long long	__per_cpu_load;
 };
 
 struct size_table {
@@ -1005,6 +1017,13 @@ struct size_table {
 	 * for loading module symbol data
 	 */
 	long	module;
+
+	/*
+	 * for sadump
+	 */
+	long	percpu_data;
+	long	elf_prstatus;
+	long	user_regs_struct;
 };
 
 struct offset_table {
@@ -1073,6 +1092,46 @@ struct offset_table {
 		long	symtab;
 		long	strtab;
 	} module;
+
+	/*
+	 * for loading elf_prstaus symbol data
+	 */
+	struct elf_prstatus_s {
+		long	pr_reg;
+	} elf_prstatus;
+
+	/*
+	 * for loading user_regs_struct symbol data
+	 */
+	struct user_regs_struct_s {
+		long	r15;
+		long	r14;
+		long	r13;
+		long	r12;
+		long	bp;
+		long	bx;
+		long	r11;
+		long	r10;
+		long	r9;
+		long	r8;
+		long	ax;
+		long	cx;
+		long	dx;
+		long	si;
+		long	di;
+		long	orig_ax;
+		long	ip;
+		long	cs;
+		long	flags;
+		long	sp;
+		long	ss;
+		long	fs_base;
+		long	gs_base;
+		long	ds;
+		long	es;
+		long	fs;
+		long	gs;
+	} user_regs_struct;
 };
 
 /*
@@ -1086,6 +1145,7 @@ struct array_table {
 	long	pgdat_list;
 	long	mem_section;
 	long	node_memblk;
+	long	__per_cpu_offset;
 
 	/*
 	 * Structure
@@ -1268,4 +1328,74 @@ is_dumpable(struct dump_bitmap *bitmap, unsigned long long pfn)
 	return is_on(bitmap->buf, pfn%PFN_BUFBITMAP);
 }
 
+#ifdef __x86__
+
+struct user_regs_struct {
+	unsigned long bx;
+	unsigned long cx;
+	unsigned long dx;
+	unsigned long si;
+	unsigned long di;
+	unsigned long bp;
+	unsigned long ax;
+	unsigned long ds;
+	unsigned long es;
+	unsigned long fs;
+	unsigned long gs;
+	unsigned long orig_ax;
+	unsigned long ip;
+	unsigned long cs;
+	unsigned long flags;
+	unsigned long sp;
+	unsigned long ss;
+};
+
+struct elf_prstatus {
+	char pad1[72];
+	struct user_regs_struct pr_reg;
+	char pad2[4];
+};
+
+#endif
+
+#ifdef __x86_64__
+
+struct user_regs_struct {
+	unsigned long r15;
+	unsigned long r14;
+	unsigned long r13;
+	unsigned long r12;
+	unsigned long bp;
+	unsigned long bx;
+	unsigned long r11;
+	unsigned long r10;
+	unsigned long r9;
+	unsigned long r8;
+	unsigned long ax;
+	unsigned long cx;
+	unsigned long dx;
+	unsigned long si;
+	unsigned long di;
+	unsigned long orig_ax;
+	unsigned long ip;
+	unsigned long cs;
+	unsigned long flags;
+	unsigned long sp;
+	unsigned long ss;
+	unsigned long fs_base;
+	unsigned long gs_base;
+	unsigned long ds;
+	unsigned long es;
+	unsigned long fs;
+	unsigned long gs;
+};
+
+struct elf_prstatus {
+	char pad1[112];
+	struct user_regs_struct pr_reg;
+	char pad2[4];
+};
+
+#endif
+
 #endif /* MAKEDUMPFILE_H */
-- 
1.7.4.4



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
