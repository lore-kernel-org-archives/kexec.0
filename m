Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e39.co.us.ibm.com ([32.97.110.160])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U2GC4-0002qs-SZ
 for kexec@lists.infradead.org; Mon, 04 Feb 2013 07:10:21 +0000
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Mon, 4 Feb 2013 00:10:19 -0700
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id A6FAF1FF0044
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 00:09:44 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1479juN522676
 for <kexec@lists.infradead.org>; Mon, 4 Feb 2013 00:09:45 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1479jkA026914
 for <kexec@lists.infradead.org>; Mon, 4 Feb 2013 00:09:45 -0700
Subject: [PATCH v4 1/9] Initialize and setup eppic
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Mon, 04 Feb 2013 12:39:41 +0530
Message-ID: <20130204070941.9292.33785.stgit@aravinda>
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

This patch contains routines which initialize eppic and register call
back function which will be called whenever a new eppic macro is loaded
using eppic_load() API. The registered call back function executes the
eppic macro as soon as it is loaded.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 Makefile          |    5 +++
 extension_eppic.c |   84 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 extension_eppic.h |   23 +++++++++++++++
 3 files changed, 111 insertions(+), 1 deletions(-)
 create mode 100644 extension_eppic.c
 create mode 100644 extension_eppic.h

diff --git a/Makefile b/Makefile
index e6c4e5d..5b8df31 100644
--- a/Makefile
+++ b/Makefile
@@ -69,7 +69,7 @@ $(OBJ_ARCH): $(SRC_ARCH)
 	$(CC) $(CFLAGS_ARCH) -c -o ./$@ ./$(@:.o=.c) 
 
 makedumpfile: $(SRC) $(OBJ_PART) $(OBJ_ARCH)
-	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJ_PART) $(OBJ_ARCH) -o $@ $< $(LIBS)
+	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJ_PART) $(OBJ_ARCH) -rdynamic -o $@ $< $(LIBS)
 	echo .TH MAKEDUMPFILE 8 \"$(DATE)\" \"makedumpfile v$(VERSION)\" \"Linux System Administrator\'s Manual\" > temp.8
 	grep -v "^.TH MAKEDUMPFILE 8" makedumpfile.8 >> temp.8
 	mv temp.8 makedumpfile.8
@@ -79,6 +79,9 @@ makedumpfile: $(SRC) $(OBJ_PART) $(OBJ_ARCH)
 	mv temp.5 makedumpfile.conf.5
 	gzip -c ./makedumpfile.conf.5 > ./makedumpfile.conf.5.gz
 
+eppic_makedumpfile.so: extension_eppic.c
+	$(CC) $(CFLAGS) -shared -rdynamic -o $@ extension_eppic.c -fPIC -leppic -ltinfo
+
 clean:
 	rm -f $(OBJ) $(OBJ_PART) $(OBJ_ARCH) makedumpfile makedumpfile.8.gz makedumpfile.conf.5.gz
 
diff --git a/extension_eppic.c b/extension_eppic.c
new file mode 100644
index 0000000..fc47b1f
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
+		if (eppic_chkfname(fname, 0))
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
