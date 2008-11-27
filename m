Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L5iMB-0001VV-Kr
	for kexec@lists.infradead.org; Thu, 27 Nov 2008 15:00:40 +0000
Date: Thu, 27 Nov 2008 16:00:34 +0100
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] Parse 64 bit VMCOREINFO on 32 bit userland
Message-ID: <20081127160034.121f5911@hale.suse.de>
Mime-Version: 1.0
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

This bug fixes the problem that on a 32 bit userland makedumpfile (as common
on the PPC platform) the parsing of the 64 bit VMCOREINFO fails with:

   # makedumpfile -c /home/sachin/dump/vmcore vmcore.filtered
   read_vmcoreinfo_symbol: Invalid data in /tmp/vmcoreinfowVoyJK:
   SYMBOL(mem_section)=c000000000bb4400

We just need to assume that the symbols are always 'unsigned long long' (64 bit)
instead of 'unsigned long' (native pointer size on Linux platforms).


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 makedumpfile.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -13,7 +13,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
-#include <stdlib.h>
 #include "makedumpfile.h"
 
 struct symbol_table	symbol_table;
@@ -2274,7 +2273,7 @@ read_vmcoreinfo_basic_info(void)
 unsigned long
 read_vmcoreinfo_symbol(char *str_symbol)
 {
-	unsigned long symbol = NOT_FOUND_SYMBOL;
+	unsigned long long symbol = NOT_FOUND_SYMBOL;
 	char buf[BUFSIZE_FGETS], *endp;
 	unsigned int i;
 
@@ -2291,8 +2290,8 @@ read_vmcoreinfo_symbol(char *str_symbol)
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
