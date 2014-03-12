Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WOT2q-0004og-Uy
 for kexec@lists.infradead.org; Fri, 14 Mar 2014 14:25:10 +0000
Message-Id: <2786fe8b53311bcf6f4167b0088a7d8a99a000a4.1394805652.git.petr@tesarici.cz>
In-Reply-To: <cover.1394805652.git.petr@tesarici.cz>
References: <cover.1394805652.git.petr@tesarici.cz>
From: Petr Tesarik <ptesarik@suse.cz>
Date: Wed, 12 Mar 2014 17:01:13 +0100
Subject: [PATCH 3/3] Optimize one-character output in dump_log_entry
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

Using sprintf to copy one character to the output buffer is overkill.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
---
 makedumpfile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 261e1ad..a98258c 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3892,12 +3892,12 @@ dump_log_entry(char *logptr, int fp)
 		}
 
 		if (isprint(*p) || isspace(*p))
-			bufp =+ sprintf(bufp, "%c", *p);
+			*bufp++ = *p;
 		else
 			bufp += sprintf(bufp, "\\x%02x", *p);
 	}
 
-	bufp += sprintf(bufp, "\n");
+	*bufp++ = '\n';
 
 	if (write(info->fd_dumpfile, buf, bufp - buf) < 0)
 		return FALSE;
-- 
1.8.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
