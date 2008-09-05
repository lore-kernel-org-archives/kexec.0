Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mta23.gyao.ne.jp ([125.63.38.249] helo=mx.gate01.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KbQq1-0001Xk-RC
	for kexec@lists.infradead.org; Fri, 05 Sep 2008 02:14:18 +0000
Received: from [124.34.33.190] (helo=master.linux-sh.org)
	by pop56.isp.us-com.jp with esmtp (Mail 4.69) id 1KbQpz-0006vv-Vx
	for kexec@lists.infradead.org; Fri, 05 Sep 2008 11:14:16 +0900
Received: from localhost (unknown [127.0.0.1])
	by master.linux-sh.org (Postfix) with ESMTP id 1D10763754
	for <kexec@lists.infradead.org>; Fri,  5 Sep 2008 02:13:49 +0000 (UTC)
Received: from master.linux-sh.org ([127.0.0.1])
	by localhost (master.linux-sh.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NobIKu0G7FqN for <kexec@lists.infradead.org>;
	Fri,  5 Sep 2008 11:13:48 +0900 (JST)
Date: Fri, 5 Sep 2008 11:13:48 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: [PATCH] sh: Add ELF relocation support for R_SH_DIR32/R_SH_REL32
	relocs.
Message-ID: <20080905021348.GB20338@linux-sh.org>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Simple handler for the common SHcompact ELF relocations.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 kexec/arch/sh/kexec-elf-rel-sh.c |   45 +++++++++++++++++++++++++++++++++----
 1 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/kexec/arch/sh/kexec-elf-rel-sh.c b/kexec/arch/sh/kexec-elf-rel-sh.c
index 3e16b28..c1aaa60 100644
--- a/kexec/arch/sh/kexec-elf-rel-sh.c
+++ b/kexec/arch/sh/kexec-elf-rel-sh.c
@@ -1,3 +1,15 @@
+/*
+ * kexec-elf-rel-sh.c - ELF relocations for SuperH
+ * Copyright (C) 2008 Paul Mundt
+ *
+ * Based on the SHcompact module loader (arch/sh/kernel/module.c) in the
+ * Linux kernel, which is written by:
+ *
+ *	Copyright (C) 2003 - 2008 Kaz Kojima & Paul Mundt
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
 #include <stdio.h>
 #include <elf.h>
 #include "../../kexec.h"
@@ -5,14 +17,37 @@
 
 int machine_verify_elf_rel(struct mem_ehdr *ehdr)
 {
+	/* Intentionally don't bother with endianness validation, it's
+	 * configurable */
 
-        die("machine_verify_elf_rel is not implemented\n");
-	return 0;
+	if (ehdr->ei_class != ELFCLASS32)
+		return 0;
+	if (ehdr->e_machine != EM_SH)
+		return 0;
+
+	return 1;
 }
 
 void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type,
-	void *location, unsigned long address, unsigned long value)
+	void *orig_loc, unsigned long address, unsigned long relocation)
 {
-        die("Unknown rela relocation: %lu\n", r_type);
-	return;
+	uint32_t *location = orig_loc;
+	uint32_t value;
+
+	switch (r_type) {
+	case R_SH_DIR32:
+		value = get_unaligned(location);
+		value += relocation;
+		put_unaligned(value, location);
+		break;
+	case R_SH_REL32:
+		relocation = (relocation - (uint32_t)location);
+		value = get_unaligned(location);
+		value += relocation;
+		put_unaligned(value, location);
+		break;
+	default:
+	        die("Unknown rela relocation: %lu\n", r_type);
+		break;
+	}
 }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
