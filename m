Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L5zKf-00034u-Rc
	for kexec@lists.infradead.org; Fri, 28 Nov 2008 09:08:14 +0000
Date: Fri, 28 Nov 2008 10:08:09 +0100
Subject: [patch] [PATCH] Parse 64 bit VMCOREINFO on 32 bit userland
Message-ID: <20081128090809.GA27442@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
From: bwalle@suse.de (Bernhard Walle)
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
Cc: oomichi@mxs.nes.nec.co.jp

This bug fixes the problem that on a 32 bit userland makedumpfile (as common
on the PPC platform) the parsing of the 64 bit VMCOREINFO fails with:

   # makedumpfile -c /home/sachin/dump/vmcore vmcore.filtered
   read_vmcoreinfo_symbol: Invalid data in /tmp/vmcoreinfowVoyJK:
   SYMBOL(mem_section)=c000000000bb4400

We just need to assume that the symbols are always 'unsigned long long' (64 bit)
instead of 'unsigned long' (native pointer size on Linux platforms).


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 makedumpfile.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2271,10 +2271,10 @@ read_vmcoreinfo_basic_info(void)
 	return TRUE;
 }
 
-unsigned long
+unsigned long long
 read_vmcoreinfo_symbol(char *str_symbol)
 {
-	unsigned long symbol = NOT_FOUND_SYMBOL;
+	unsigned long long symbol = NOT_FOUND_SYMBOL;
 	char buf[BUFSIZE_FGETS], *endp;
 	unsigned int i;
 
@@ -2291,8 +2291,8 @@ read_vmcoreinfo_symbol(char *str_symbol)
 		if (buf[i - 1] == '\n')
 			buf[i - 1] = '\0';
 		if (strncmp(buf, str_symbol, strlen(str_symbol)) == 0) {
-			symbol = strtoul(buf + strlen(str_symbol), &endp, 16);
-			if ((!symbol || symbol == ULONG_MAX)
+			symbol = strtoull(buf + strlen(str_symbol), &endp, 16);
+			if ((!symbol || symbol == ULONGLONG_MAX)
 			    || strlen(endp) != 0) {
 				ERRMSG("Invalid data in %s: %s",
 				    info->name_vmcoreinfo, buf);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
