Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SjZxs-0003Dl-9l
 for kexec@lists.infradead.org; Tue, 26 Jun 2012 17:54:12 +0000
Received: by bkwj4 with SMTP id j4so213795bkw.36
 for <kexec@lists.infradead.org>; Tue, 26 Jun 2012 10:54:09 -0700 (PDT)
From: Aleksey Makarov <aleksey.makarov@gmail.com>
Subject: [PATCH 1/2] Check format string of die()
Date: Wed, 27 Jun 2012 00:53:42 +0700
Message-Id: <1340733223-25382-1-git-send-email-aleksey.makarov@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
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
Cc: Aleksey Makarov <aleksey.makarov@gmail.com>

Use gcc's __attribute__ to check format string.

Signed-off-by: Aleksey Makarov <aleksey.makarov@gmail.com>
---
 kexec/kexec.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/kexec/kexec.h b/kexec/kexec.h
index 279dfdf..d24b3fa 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -215,7 +215,8 @@ extern int file_types;
 
 #define KEXEC_OPT_STR "hvdfxluet:p"
 
-extern void die(char *fmt, ...);
+extern void die(char *fmt, ...)
+	__attribute__ ((format (printf, 1, 2)));
 extern void *xmalloc(size_t size);
 extern void *xrealloc(void *ptr, size_t size);
 extern char *slurp_file(const char *filename, off_t *r_size);
-- 
1.7.7.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
