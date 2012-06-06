Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e32.co.us.ibm.com ([32.97.110.150])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1ScD7D-0005dB-Ik
 for kexec@lists.infradead.org; Wed, 06 Jun 2012 10:05:24 +0000
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Wed, 6 Jun 2012 04:05:20 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 7A22C3E40049
 for <kexec@lists.infradead.org>; Wed,  6 Jun 2012 10:04:55 +0000 (WET)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q56A4r6P176644
 for <kexec@lists.infradead.org>; Wed, 6 Jun 2012 04:04:54 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q56A5h49012598
 for <kexec@lists.infradead.org>; Wed, 6 Jun 2012 04:05:43 -0600
Subject: [PATCH 1/7] Initialize and setup eppic
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Wed, 06 Jun 2012 15:34:48 +0530
Message-ID: <20120606100448.12534.22340.stgit@aravinda>
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

This patch contains routines which initialize eppic and register call
back function which will be called whenever a new eppic macro is loaded
using eppic_load() API. The registered call back function executes the
eppic macro as soon as it is loaded.

The -ltinfo is included in LIBS in the Makefile, because eppic
currently calls few functions in libtinfo and the compiler complains
about it, if not included. I think the paths where libeppic calls
libtinfo functions are not exercised by makedumpfile.

Including -ltinfo will increase the size of makedumpfile static
version

TODO:
	- Check out a way to get rid of -ltinfo

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 Makefile          |    6 ++--
 extension_eppic.c |   84 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 extension_eppic.h |   23 +++++++++++++++
 3 files changed, 110 insertions(+), 3 deletions(-)
 create mode 100644 extension_eppic.c
 create mode 100644 extension_eppic.h

diff --git a/Makefile b/Makefile
index 7337c58..bdfdbab 100644
--- a/Makefile
+++ b/Makefile
@@ -40,12 +40,12 @@ CFLAGS_ARCH += -m32
 endif
 
 SRC	= makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h sadump_info.h
-SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c
-OBJ_PART = print_info.o dwarf_info.o elf_info.o erase_info.o sadump_info.o
+SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c extension_eppic.c
+OBJ_PART = print_info.o dwarf_info.o elf_info.o erase_info.o sadump_info.o extension_eppic.o
 SRC_ARCH = arch/arm.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c
 OBJ_ARCH = arch/arm.o arch/x86.o arch/x86_64.o arch/ia64.o arch/ppc64.o arch/s390x.o arch/ppc.o
 
-LIBS = -ldw -lbz2 -lebl -ldl -lelf -lz
+LIBS = -ldw -lbz2 -lebl -ldl -lelf -lz -leppic -ltinfo
 ifneq ($(LINKTYPE), dynamic)
 LIBS := -static $(LIBS)
 endif
diff --git a/extension_eppic.c b/extension_eppic.c
new file mode 100644
index 0000000..f6c7ff1
--- /dev/null
+++ b/extension_eppic.c
@@ -0,0 +1,84 @@
+/*
+ * extension_eppic.c
+ *
+ * Created by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
+ *
+ * Copyright (C) 2012  IBM Corporation
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
+#include <stdio.h>
+#include <string.h>
+#include <sys/types.h>
+#include <fcntl.h>
+
+#include "extension_eppic.h"
+
+/*
+ * Most of the functions included in this file performs similar
+ * functionality as in the applications/crash/eppic.c file part of
+ * eppic, but uses DWARF instead of gdb. Few of the functions are
+ * reused directly which are acknowledged in the comment before the
+ * function.
+ */
+
+/*
+ * This is the call back function called when a new eppic macro is
+ * loaded. This will execute the loaded eppic macro.
+ *
+ * "fname" is considered as the entry point of an eppic macro only if
+ * the following functions are defined:
+ *
+ *  fname_help()
+ *  fname_usage()
+ *
+ * These functions have no relevance in makedumpfile context as
+ * makedumpfile automatically executes the eppic macro by calling the
+ * entry point and user will not have any option to execute the usage
+ * or help functions. However they are required to identify the entry
+ * points in the eppic macro.
+ */
+void
+reg_callback(char *name, int load)
+{
+	char fname[MAX_SYMNAMELEN];
+
+	/* Nothing to process for unload request */
+	if (!load)
+		return;
+
+	snprintf(fname, sizeof(fname), "%s_help", name);
+	if (eppic_chkfname(fname, 0)) {
+		snprintf(fname, sizeof(fname), "%s_usage", name);
+		if(eppic_chkfname(fname, 0))
+			eppic_cmd(name, NULL, 0);
+	}
+	return;
+}
+
+
+/* Initialize eppic */
+int
+eppic_init()
+{
+	if (eppic_open() >= 0) {
+
+		/* Register call back functions */
+		eppic_apiset(NULL, 3, sizeof(long), 0);
+
+		/* set the new function callback */
+		eppic_setcallback(reg_callback);
+
+		return 0;
+	}
+	return 1;
+}
+
diff --git a/extension_eppic.h b/extension_eppic.h
new file mode 100644
index 0000000..ca74ce4
--- /dev/null
+++ b/extension_eppic.h
@@ -0,0 +1,23 @@
+/*
+ * extension_eppic.h
+ *
+ * Created by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
+ *
+ * Copyright (C) 2012  IBM Corporation
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
+#ifndef _EXTENSION_EPPIC_H
+#define _EXTENSION_EPPIC_H
+
+#include "eppic_api.h"
+
+#endif /* _EXTENSION_EPPIC_H */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
