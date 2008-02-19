Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JRKJ6-0001ZD-Sj
	for kexec@lists.infradead.org; Tue, 19 Feb 2008 04:42:17 +0000
From: Simon Horman <horms@verge.net.au>
Subject: Use zlib if present
Message-Id: <20080219044208.278434FB0B@tabatha.lab.ultramonkey.org>
Date: Tue, 19 Feb 2008 13:42:08 +0900 (JST)
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Jeremy Kerr <jk@ozlabs.org>

Hi,

This fixes a minor regression that occured with Jeremy's recent
reworking of the build system. I guess he wasn't dealing with
compressed images and thus didn't notice that zlib support had
been disabled.

The fix involves updating an #ifdef to use the new symbol,
and ensuring that -lz is passed to the linker as neccessary.

Cc: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Simon Horman <horms@verge.net.au>

--- 

 kexec/Makefile |    1 +
 kexec/kexec.c  |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)
Index: kexec-tools-testing/kexec/kexec.c
===================================================================
--- kexec-tools-testing.orig/kexec/kexec.c	2008-02-19 12:21:04.000000000 +0900
+++ kexec-tools-testing/kexec/kexec.c	2008-02-19 12:21:15.000000000 +0900
@@ -32,7 +32,7 @@
 
 #include "config.h"
 
-#ifdef HAVE_ZLIB_H
+#ifdef HAVE_LIBZ
 #include <zlib.h>
 #endif
 #include <sha256.h>
@@ -446,7 +446,7 @@ char *slurp_file_len(const char *filenam
 	return buf;
 }
 
-#if HAVE_ZLIB_H
+#if HAVE_LIBZ
 char *slurp_decompress_file(const char *filename, off_t *r_size)
 {
 	gzFile fp;
Index: kexec-tools-testing/kexec/Makefile
===================================================================
--- kexec-tools-testing.orig/kexec/Makefile	2008-02-19 12:40:05.000000000 +0900
+++ kexec-tools-testing/kexec/Makefile	2008-02-19 12:41:23.000000000 +0900
@@ -36,6 +36,7 @@ KEXEC_MANPAGE = $(MANDIR)/man8/kexec.8
 
 -include $(KEXEC_DEPS)
 
+$(KEXEC): LDFLAGS+=$(LIBS)
 $(KEXEC): $(KEXEC_OBJS) $(UTIL_LIB)
 	@$(MKDIR) -p $(@D)
 	$(LINK.o) -o $@ $^

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
