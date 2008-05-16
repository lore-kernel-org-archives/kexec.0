Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.245])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JwnZi-0005Hl-I3
	for kexec@lists.infradead.org; Fri, 16 May 2008 00:13:31 +0000
Received: by rv-out-0708.google.com with SMTP id b17so737470rvf.42
	for <kexec@lists.infradead.org>; Thu, 15 May 2008 17:13:29 -0700 (PDT)
Date: Thu, 15 May 2008 17:13:37 -0700
From: Jamey Sharp <jamey@thetovacompany.com>
Subject: [PATCH] Open slurped files in binary mode, on systems where that
	matters.
Message-ID: <20080516001337.GA6312@oh.minilop.net>
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

Signed-off-by: Jamey Sharp <jamey@thetovacompany.com>
---
This patch shouldn't hurt any system that doesn't distinguish between
binary and text files, and helps when running on Windows.

 kexec/kexec.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index de9765e..1da6c1e 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -30,6 +30,9 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <fcntl.h>
+#ifndef _O_BINARY
+#define _O_BINARY 0
+#endif
 #include <getopt.h>
 
 #include "config.h"
@@ -386,7 +389,7 @@ char *slurp_file(const char *filename, off_t *r_size)
 		*r_size = 0;
 		return 0;
 	}
-	fd = open(filename, O_RDONLY);
+	fd = open(filename, O_RDONLY | _O_BINARY);
 	if (fd < 0) {
 		die("Cannot open `%s': %s\n",
 			filename, strerror(errno));
@@ -431,7 +434,7 @@ char *slurp_file_len(const char *filename, off_t size)
 
 	if (!filename)
 		return 0;
-	fd = open(filename, O_RDONLY);
+	fd = open(filename, O_RDONLY | _O_BINARY);
 	if (fd < 0) {
 		fprintf(stderr, "Cannot open %s: %s\n", filename,
 				strerror(errno));
-- 
1.5.4.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
