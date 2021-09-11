Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mP5vL-00FEht-08
 for kexec@lists.infradead.org; Sat, 11 Sep 2021 16:32:16 +0000
From: Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH] Refer FDT tokens with symbolic names
Date: Sat, 11 Sep 2021 22:02:00 +0530
Message-Id: <20210911163200.71394-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, Sourabh Jain <sourabhjain@linux.ibm.com>

Replace hardcoded FDT structure block tokens with proper names to
improve code readability.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 kexec/fs2dt.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
index 1a43058..993b73b 100644
--- a/kexec/fs2dt.c
+++ b/kexec/fs2dt.c
@@ -32,6 +32,7 @@
 #include <stdio.h>
 #include "kexec.h"
 #include "fs2dt.h"
+#include "libfdt/fdt.h"
 
 #define MAXPATH 1024		/* max path name length */
 #define NAMESPACE 16384		/* max bytes for property names */
@@ -306,7 +307,7 @@ static void add_dyn_reconf_usable_mem_property__(int fd)
 	 * Add linux,drconf-usable-memory property.
 	 */
 	dt_reserve(&dt, 4+((rlen + 3)/4));
-	*dt++ = cpu_to_be32(3);
+	*dt++ = cpu_to_be32(FDT_PROP);
 	*dt++ = cpu_to_be32(rlen);
 	*dt++ = cpu_to_be32(propnum("linux,drconf-usable-memory"));
 	pad_structure_block(rlen);
@@ -380,7 +381,7 @@ static void add_usable_mem_property(int fd, size_t len)
 	 * No add linux,usable-memory property.
 	 */
 	dt_reserve(&dt, 4+((rlen + 3)/4));
-	*dt++ = cpu_to_be32(3);
+	*dt++ = cpu_to_be32(FDT_PROP);
 	*dt++ = cpu_to_be32(rlen);
 	*dt++ = cpu_to_be32(propnum("linux,usable-memory"));
 	pad_structure_block(rlen);
@@ -451,7 +452,7 @@ static void putprops(char *fn, struct dirent **nlist, int numlist)
 		len = statbuf.st_size;
 
 		dt_reserve(&dt, 4+((len + 3)/4));
-		*dt++ = cpu_to_be32(3);
+		*dt++ = cpu_to_be32(FDT_PROP);
 		*dt++ = cpu_to_be32(len);
 		*dt++ = cpu_to_be32(propnum(fn));
 		pad_structure_block(len);
@@ -586,7 +587,7 @@ static void putnode(void)
 	 * So round up & include the \0:
 	 */
 	dt_reserve(&dt, 1+((plen + 4)/4));
-	*dt++ = cpu_to_be32(1);
+	*dt++ = cpu_to_be32(FDT_BEGIN_NODE);
 	strcpy((void *)dt, *basename ? basename : "");
 	dt += ((plen + 4)/4);
 
@@ -602,7 +603,7 @@ static void putnode(void)
 		uint64_t bevalue;
 
 		dt_reserve(&dt, 12); /* both props, of 6 words ea. */
-		*dt++ = cpu_to_be32(3);
+		*dt++ = cpu_to_be32(FDT_PROP);
 		*dt++ = cpu_to_be32(len);
 		*dt++ = cpu_to_be32(propnum("linux,initrd-start"));
 		pad_structure_block(len);
@@ -612,7 +613,7 @@ static void putnode(void)
 		dt += (len + 3)/4;
 
 		len = 8;
-		*dt++ = cpu_to_be32(3);
+		*dt++ = cpu_to_be32(FDT_PROP);
 		*dt++ = cpu_to_be32(len);
 		*dt++ = cpu_to_be32(propnum("linux,initrd-end"));
 
@@ -656,7 +657,7 @@ static void putnode(void)
 
 		/* add new bootargs */
 		dt_reserve(&dt, 4+((cmd_len+3)/4));
-		*dt++ = cpu_to_be32(3);
+		*dt++ = cpu_to_be32(FDT_PROP);
 		*dt++ = cpu_to_be32(cmd_len);
 		*dt++ = cpu_to_be32(propnum("bootargs"));
 		pad_structure_block(cmd_len);
@@ -757,7 +758,7 @@ no_debug:
 	}
 
 	dt_reserve(&dt, 1);
-	*dt++ = cpu_to_be32(2);
+	*dt++ = cpu_to_be32(FDT_END_NODE);
 	dn[-1] = '\0';
 	free(namelist);
 }
@@ -796,7 +797,7 @@ static void add_boot_block(char **bufp, off_t *sizep)
 	len = _ALIGN(len, 4);
 	bb->totalsize = cpu_to_be32(be32_to_cpu(bb->off_dt_strings) + len);
 
-	bb->magic = cpu_to_be32(0xd00dfeed);
+	bb->magic = cpu_to_be32(FDT_MAGIC);
 	bb->version = cpu_to_be32(BOOT_BLOCK_VERSION);
 	bb->last_comp_version = cpu_to_be32(BOOT_BLOCK_LAST_COMP_VERSION);
 
@@ -844,7 +845,7 @@ void create_flatten_tree(char **bufp, off_t *sizep, const char *cmdline)
 
 	putnode();
 	dt_reserve(&dt, 1);
-	*dt++ = cpu_to_be32(9);
+	*dt++ = cpu_to_be32(FDT_END);
 
 	add_boot_block(bufp, sizep);
 	free(dt_base);
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
