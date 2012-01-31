Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-gy0-f177.google.com ([209.85.160.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Rs7fn-0001GO-Dg
 for kexec@lists.infradead.org; Tue, 31 Jan 2012 06:58:36 +0000
Received: by ghbg20 with SMTP id g20so976739ghb.36
 for <kexec@lists.infradead.org>; Mon, 30 Jan 2012 22:58:34 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch] kexec: make some functions static
Date: Tue, 31 Jan 2012 14:58:09 +0800
Message-Id: <1327993089-23630-1-git-send-email-xiyou.wangcong@gmail.com>
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
Cc: WANG Cong <xiyou.wangcong@gmail.com>

The following functions/variables can become static.

Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

---
diff --git a/kexec/kexec.c b/kexec/kexec.c
index abbe940..89e725e 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -49,7 +49,7 @@
 
 unsigned long long mem_min = 0;
 unsigned long long mem_max = ULONG_MAX;
-unsigned long kexec_flags = 0;
+static unsigned long kexec_flags = 0;
 
 void die(char *fmt, ...)
 {
@@ -62,7 +62,7 @@ void die(char *fmt, ...)
 	exit(1);
 }
 
-char *xstrdup(const char *str)
+static char *xstrdup(const char *str)
 {
 	char *new = strdup(str);
 	if (!new)
@@ -765,7 +765,7 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 	return result;
 }
 
-int k_unload (unsigned long kexec_flags)
+static int k_unload (unsigned long kexec_flags)
 {
 	int result;
 	long native_arch;
@@ -1006,7 +1006,7 @@ char *get_command_line(void)
 }
 
 /* check we retained the initrd */
-void check_reuse_initrd(void)
+static void check_reuse_initrd(void)
 {
 	char *line = get_command_line();
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
