Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W2zKk-0004AB-K0
 for kexec@lists.infradead.org; Tue, 14 Jan 2014 08:26:51 +0000
Date: Tue, 14 Jan 2014 16:26:24 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH] vmcore-dmesg: print white-space characters
Message-ID: <20140114082624.GA2351@dhcp-17-89.nay.redhat.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

Some sort of space like "\t" "\n" are used in kernel log. But we treat
them as non-printables and output "\x20%x" for each non-printable. So
let's fix it.

Signed-off-by: WANG Chao <chaowang@redhat.com>
---
 vmcore-dmesg/vmcore-dmesg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
index df14c89..0345660 100644
--- a/vmcore-dmesg/vmcore-dmesg.c
+++ b/vmcore-dmesg/vmcore-dmesg.c
@@ -16,6 +16,7 @@
 #include <elf.h>
 #include <stdbool.h>
 #include <inttypes.h>
+#include <ctype.h>
 
 /* The 32bit and 64bit note headers make it clear we don't care */
 typedef Elf32_Nhdr Elf_Nhdr;
@@ -668,7 +669,7 @@ static void dump_dmesg_structured(int fd)
 		for (i = 0; i < text_len; i++) {
 			unsigned char c = log_text(msg)[i];
 
-			if (c < ' ' || c >= 128)
+			if (!isprint(c) && !isspace(c))
 				len += sprintf(out_buf + len, "\\x%02x", c);
 			else
 				out_buf[len++] = c;
-- 
1.8.4.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
