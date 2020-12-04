Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkyzL-0007TC-28
 for kexec@lists.infradead.org; Fri, 04 Dec 2020 00:30:21 +0000
From: Jinyang He <hejinyang@loongson.cn>
Subject: [PATCH] kexec: mips: Fix mem parameters
Date: Fri,  4 Dec 2020 08:29:47 +0800
Message-Id: <1607041787-375-1-git-send-email-hejinyang@loongson.cn>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Youling Tang <tangyouling@loongson.cn>, kexec@lists.infradead.org

"mem=" is useful to indicate the memory region when capture kernel boot.
Otherwise, capture kernel will breakdown the memory of panic kernel.
Although it can be add by user, adding "mem" by software is a better way.
What's more, "mem" should contain elfcorehdr range. Elfcorehdr memory
should be managed by kernel.

Fixes: 7bd251654aad ("kexec-tools: mips: Remove commandline parameter "mem"")
Signed-off-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Jinyang He <hejinyang@loongson.cn>
---
 kexec/arch/mips/crashdump-mips.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
index a135386..56b8fe8 100644
--- a/kexec/arch/mips/crashdump-mips.c
+++ b/kexec/arch/mips/crashdump-mips.c
@@ -243,6 +243,33 @@ static void ultoa(unsigned long i, char *str)
 	}
 }
 
+/* Adds the appropriate mem= options to command line, indicating the
+ * memory region the new kernel can use to boot into. */
+static int cmdline_add_mem(char *cmdline, unsigned long addr,
+		unsigned long size)
+{
+	int cmdlen, len;
+	char str[50], *ptr;
+
+	addr = addr/1024;
+	size = size/1024;
+	ptr = str;
+	strcpy(str, " mem=");
+	ptr += strlen(str);
+	ultoa(size, ptr);
+	strcat(str, "K@");
+	ptr = str + strlen(str);
+	ultoa(addr, ptr);
+	strcat(str, "K");
+	len = strlen(str);
+	cmdlen = strlen(cmdline) + len;
+	if (cmdlen > (COMMAND_LINE_SIZE - 1))
+		die("Command line overflow\n");
+	strcat(cmdline, str);
+
+	return 0;
+}
+
 /* Adds the elfcorehdr= command line parameter to command line. */
 static int cmdline_add_elfcorehdr(char *cmdline, unsigned long addr)
 {
@@ -373,6 +400,8 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	 * backup segment is after elfcorehdr, so use elfcorehdr as top of
 	 * kernel's available memory
 	 */
+	cmdline_add_mem(mod_cmdline, crash_reserved_mem.start,
+		crash_reserved_mem.end - crash_reserved_mem.start);
 	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
 
 	dbgprintf("CRASH MEMORY RANGES:\n");
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
