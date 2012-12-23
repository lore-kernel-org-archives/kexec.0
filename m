Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TmfqI-00017U-Ns
 for kexec@lists.infradead.org; Sun, 23 Dec 2012 07:19:27 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 1/3] die: Use const for fmt
Date: Sun, 23 Dec 2012 16:19:16 +0900
Message-Id: <1356247158-9671-2-git-send-email-horms@verge.net.au>
In-Reply-To: <1356247158-9671-1-git-send-email-horms@verge.net.au>
References: <1356247158-9671-1-git-send-email-horms@verge.net.au>
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
Cc: Simon Horman <horms@verge.net.au>

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 kexec/kexec.c |    2 +-
 kexec/kexec.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 22229d8..89ec182 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -53,7 +53,7 @@ unsigned long long mem_max = ULONG_MAX;
 static unsigned long kexec_flags = 0;
 int kexec_debug = 0;
 
-void die(char *fmt, ...)
+void die(const char *fmt, ...)
 {
 	va_list args;
 	va_start(args, fmt);
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 1f46bcb..94c62c1 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -220,7 +220,7 @@ extern int file_types;
 
 #define KEXEC_OPT_STR "hvdfxluet:p"
 
-extern void die(char *fmt, ...)
+extern void die(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
 extern void *xmalloc(size_t size);
 extern void *xrealloc(void *ptr, size_t size);
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
