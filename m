Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WOT2q-0004oh-Uv
 for kexec@lists.infradead.org; Fri, 14 Mar 2014 14:25:10 +0000
Message-Id: <d93ee70631a04cd35cc7c484ec0467406d6f0c46.1394805652.git.petr@tesarici.cz>
In-Reply-To: <cover.1394805652.git.petr@tesarici.cz>
References: <cover.1394805652.git.petr@tesarici.cz>
From: Petr Tesarik <ptesarik@suse.cz>
Date: Wed, 12 Mar 2014 16:59:27 +0100
Subject: [PATCH 2/3] Prevent buffer overflow in dump_log_entry
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

One message may be longer than BUFSIZE. In that case, the output
buffer overflows, causing stack corruption. Solve it by flushing
the buffer when it gets full.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
---
 makedumpfile.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index fc4ce19..261e1ad 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3885,6 +3885,12 @@ dump_log_entry(char *logptr, int fp)
 	bufp += sprintf(buf, "[%5lld.%06ld] ", nanos, rem/1000);
 
 	for (i = 0, p = msg; i < text_len; i++, p++) {
+		if (bufp - buf >= sizeof(buf) - 6) {
+			if (write(info->fd_dumpfile, buf, bufp - buf) < 0)
+				return FALSE;
+			bufp = buf;
+		}
+
 		if (isprint(*p) || isspace(*p))
 			bufp =+ sprintf(bufp, "%c", *p);
 		else
-- 
1.8.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
