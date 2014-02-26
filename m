Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WIlgE-0008NY-9i
 for kexec@lists.infradead.org; Wed, 26 Feb 2014 21:06:15 +0000
Date: Wed, 26 Feb 2014 22:05:46 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [PATCH] makedumpfile: Fix string append in dump_log_entry()
Message-ID: <20140226220546.4030cdbf@hananiah.suse.cz>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

To quote the sprintf(3) man page:

    Some programs imprudently rely on code such as the following

        sprintf(buf, "%s some further text", buf);

    to append text to buf.  However, the standards explicitly note that
    the results are undefined if source and destination buffers overlap
    when calling sprintf(), snprintf(), vsprintf(), and vsnprintf().
    Depending on the version of gcc(1) used, and the compiler options
    employed, calls such as the above will not produce the expected results.

The original code is actually miscompiled on openSUSE 13.1.

It's also overkill to call sprintf() for something that can be done
with a simple assignment.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
---
 makedumpfile.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 579be61..013fce7 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3866,7 +3866,7 @@ reset_bitmap_of_free_pages(unsigned long node_zones, struct cycle *cycle)
 static int
 dump_log_entry(char *logptr, int fp)
 {
-	char *msg, *p;
+	char *msg, *p, *bufp;
 	unsigned int i, text_len;
 	unsigned long long ts_nsec;
 	char buf[BUFSIZE];
@@ -3881,18 +3881,19 @@ dump_log_entry(char *logptr, int fp)
 
 	msg = logptr + SIZE(printk_log);
 
-	sprintf(buf, "[%5lld.%06ld] ", nanos, rem/1000);
+	bufp = buf;
+	bufp += sprintf(buf, "[%5lld.%06ld] ", nanos, rem/1000);
 
 	for (i = 0, p = msg; i < text_len; i++, p++) {
 		if (isprint(*p) || isspace(*p))
-			sprintf(buf, "%s%c", buf, *p);
+			*bufp++ = *p;
 		else
-			sprintf(buf, "%s\\x%02x", buf, *p);
+			bufp += sprintf(bufp, "\\x%02x", *p);
 	}
 
-	sprintf(buf, "%s\n", buf);
+	*bufp++ = '\n';
 
-	if (write(info->fd_dumpfile, buf, strlen(buf)) < 0)
+	if (write(info->fd_dumpfile, buf, bufp - buf) < 0)
 		return FALSE;
 	else
 		return TRUE;
-- 
1.8.4.5

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
