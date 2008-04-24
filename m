Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Joppz-0004cm-UZ
	for kexec@lists.infradead.org; Thu, 24 Apr 2008 01:01:24 +0000
Date: Thu, 24 Apr 2008 11:01:20 +1000
From: Simon Horman <horms@verge.net.au>
Subject: [patch] <sys/mman.h> is not needed by any kexec/ source
Message-ID: <20080424010118.GB7278@verge.net.au>
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
Cc: Jamey Sharp <jamey@thetovacompany.com>, "Eric W. Biederman" <ebiederm@xmission.com>

This continues the work that Jamey Sharp did on i386 to
cover all other architectures.

Cc: Jamey Sharp <jamey@thetovacompany.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

Index: kexec-tools-testing-merge/kexec/arch/ia64/kexec-elf-ia64.c
===================================================================
--- kexec-tools-testing-merge.orig/kexec/arch/ia64/kexec-elf-ia64.c	2008-04-24 09:34:21.000000000 +1000
+++ kexec-tools-testing-merge/kexec/arch/ia64/kexec-elf-ia64.c	2008-04-24 09:34:59.000000000 +1000
@@ -31,7 +31,6 @@
 #include <stdint.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/mman.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <getopt.h>
Index: kexec-tools-testing-merge/kexec/arch/mips/kexec-elf-mips.c
===================================================================
--- kexec-tools-testing-merge.orig/kexec/arch/mips/kexec-elf-mips.c	2008-04-24 09:34:21.000000000 +1000
+++ kexec-tools-testing-merge/kexec/arch/mips/kexec-elf-mips.c	2008-04-24 09:34:59.000000000 +1000
@@ -17,7 +17,6 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/mman.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <getopt.h>
Index: kexec-tools-testing-merge/kexec/arch/ppc/kexec-dol-ppc.c
===================================================================
--- kexec-tools-testing-merge.orig/kexec/arch/ppc/kexec-dol-ppc.c	2008-04-24 09:34:21.000000000 +1000
+++ kexec-tools-testing-merge/kexec/arch/ppc/kexec-dol-ppc.c	2008-04-24 09:34:59.000000000 +1000
@@ -13,7 +13,6 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/mman.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <getopt.h>
Index: kexec-tools-testing-merge/kexec/arch/ppc/kexec-elf-ppc.c
===================================================================
--- kexec-tools-testing-merge.orig/kexec/arch/ppc/kexec-elf-ppc.c	2008-04-24 09:34:21.000000000 +1000
+++ kexec-tools-testing-merge/kexec/arch/ppc/kexec-elf-ppc.c	2008-04-24 09:34:59.000000000 +1000
@@ -13,7 +13,6 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/mman.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <getopt.h>
Index: kexec-tools-testing-merge/kexec/arch/ppc64/kexec-elf-ppc64.c
===================================================================
--- kexec-tools-testing-merge.orig/kexec/arch/ppc64/kexec-elf-ppc64.c	2008-04-24 09:34:21.000000000 +1000
+++ kexec-tools-testing-merge/kexec/arch/ppc64/kexec-elf-ppc64.c	2008-04-24 09:34:59.000000000 +1000
@@ -27,7 +27,6 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/mman.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <getopt.h>
Index: kexec-tools-testing-merge/kexec/arch/ppc64/kexec-zImage-ppc64.c
===================================================================
--- kexec-tools-testing-merge.orig/kexec/arch/ppc64/kexec-zImage-ppc64.c	2008-04-24 09:34:21.000000000 +1000
+++ kexec-tools-testing-merge/kexec/arch/ppc64/kexec-zImage-ppc64.c	2008-04-24 09:34:59.000000000 +1000
@@ -25,7 +25,6 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/mman.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <getopt.h>
Index: kexec-tools-testing-merge/kexec/arch/sh/kexec-netbsd-sh.c
===================================================================
--- kexec-tools-testing-merge.orig/kexec/arch/sh/kexec-netbsd-sh.c	2008-04-24 09:34:21.000000000 +1000
+++ kexec-tools-testing-merge/kexec/arch/sh/kexec-netbsd-sh.c	2008-04-24 09:34:59.000000000 +1000
@@ -15,7 +15,6 @@
 #include <stdint.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/mman.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <getopt.h>
Index: kexec-tools-testing-merge/kexec/arch/sh/kexec-zImage-sh.c
===================================================================
--- kexec-tools-testing-merge.orig/kexec/arch/sh/kexec-zImage-sh.c	2008-04-24 09:34:22.000000000 +1000
+++ kexec-tools-testing-merge/kexec/arch/sh/kexec-zImage-sh.c	2008-04-24 09:34:59.000000000 +1000
@@ -15,7 +15,6 @@
 #include <stdint.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/mman.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <getopt.h>
Index: kexec-tools-testing-merge/kexec/arch/x86_64/crashdump-x86_64.c
===================================================================
--- kexec-tools-testing-merge.orig/kexec/arch/x86_64/crashdump-x86_64.c	2008-04-24 09:34:22.000000000 +1000
+++ kexec-tools-testing-merge/kexec/arch/x86_64/crashdump-x86_64.c	2008-04-24 09:34:59.000000000 +1000
@@ -27,7 +27,6 @@
 #include <fcntl.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/mman.h>
 #include <unistd.h>
 #include "../../kexec.h"
 #include "../../kexec-elf.h"
Index: kexec-tools-testing-merge/kexec/arch/x86_64/kexec-elf-x86_64.c
===================================================================
--- kexec-tools-testing-merge.orig/kexec/arch/x86_64/kexec-elf-x86_64.c	2008-04-24 09:34:22.000000000 +1000
+++ kexec-tools-testing-merge/kexec/arch/x86_64/kexec-elf-x86_64.c	2008-04-24 09:34:59.000000000 +1000
@@ -25,7 +25,6 @@
 #include <limits.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/mman.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <getopt.h>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
