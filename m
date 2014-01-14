Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W2zpQ-0004xp-Ef
 for kexec@lists.infradead.org; Tue, 14 Jan 2014 08:58:33 +0000
Date: Tue, 14 Jan 2014 16:58:06 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH] makedumpfile: --dump-dmesg characters printing fix
Message-ID: <20140114085806.GA8523@dhcp-17-89.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
Cc: kexec@lists.infradead.org

To keep the output of makedumpfile --dump-dmesg being consistent with
dmesg utility, this patch introduces two changes:

1. If a character is non-printable, print its hex value ("\\x%02x")
2. No special handling for "\n" ("\n" -> ".")

Signed-off-by: WANG Chao <chaowang@redhat.com>
---
 makedumpfile.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index ef08d91..73467ab 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3848,12 +3848,10 @@ dump_log_entry(char *logptr, int fp)
 	sprintf(buf, "[%5lld.%06ld] ", nanos, rem/1000);
 
 	for (i = 0, p = msg; i < text_len; i++, p++) {
-		if (*p == '\n')
-			sprintf(buf, "%s.", buf);
-		else if (isprint(*p) || isspace(*p))
+		if (isprint(*p) || isspace(*p))
 			sprintf(buf, "%s%c", buf, *p);
 		else
-			sprintf(buf, "%s.", buf);
+			sprintf(buf, "%s\\x%02x", buf, *p);
 	}
 
 	sprintf(buf, "%s\n", buf);
-- 
1.8.4.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
