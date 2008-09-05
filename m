Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mta23.gyao.ne.jp ([125.63.38.249] helo=mx.gate01.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KbQpR-00006D-CM
	for kexec@lists.infradead.org; Fri, 05 Sep 2008 02:13:41 +0000
Received: from [124.34.33.190] (helo=master.linux-sh.org)
	by pop55.isp.us-com.jp with esmtp (Mail 4.69) id 1KbQpO-0008BV-9I
	for kexec@lists.infradead.org; Fri, 05 Sep 2008 11:13:38 +0900
Received: from localhost (unknown [127.0.0.1])
	by master.linux-sh.org (Postfix) with ESMTP id 64DFA63754
	for <kexec@lists.infradead.org>; Fri,  5 Sep 2008 02:13:11 +0000 (UTC)
Received: from master.linux-sh.org ([127.0.0.1])
	by localhost (master.linux-sh.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T8bF3BBENG1O for <kexec@lists.infradead.org>;
	Fri,  5 Sep 2008 11:13:11 +0900 (JST)
Date: Fri, 5 Sep 2008 11:13:10 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: [PATCH] kexec/kexec.h: Bring put/get_unaligned() back from the dead.
Message-ID: <20080905021310.GA20338@linux-sh.org>
MIME-Version: 1.0
Content-Disposition: inline
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

This re-enables the fairly generic put/get_unaligned() routines in
kexec.h, while tidying up the variable shadowing clash that results
when using it in places like machine_apply_elf_rel().

Needed for SH ELF relocations.

IA64 still does its own put_unaligned64(), which should likely also be
converted over to using put_unaligned() directly.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 kexec/kexec.h |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/kexec/kexec.h b/kexec/kexec.h
index 7db8227..8421c29 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -6,6 +6,7 @@
 #include <sys/types.h>
 #include <stdio.h>
 #include <stdint.h>
+#include <string.h>
 #define USE_BSD
 #include <byteswap.h>
 #include <endian.h>
@@ -56,43 +57,41 @@
 #endif
 
 
-#if 0
 /*
- * This function doesn't actually exist.  The idea is that when someone uses the macros
- * below with an unsupported size (datatype), the linker will alert us to the problem via
- * an unresolved reference error.
+ * This function doesn't actually exist.  The idea is that when someone
+ * uses the macros below with an unsupported size (datatype), the linker
+ * will alert us to the problem via an unresolved reference error.
  */
 extern unsigned long bad_unaligned_access_length (void);
 
 #define get_unaligned(loc) \
 ({ \
-	__typeof__(*(loc)) value; \
+	__typeof__(*(loc)) _v; \
 	size_t size = sizeof(*(loc)); \
 	switch(size) {  \
 	case 1: case 2: case 4: case 8: \
-		memcpy(&value, (loc), size); \
+		memcpy(&_v, (loc), size); \
 		break; \
 	default: \
-		value = bad_unaligned_access_length(); \
+		_v = bad_unaligned_access_length(); \
 		break; \
 	} \
-	value; \
+	_v; \
 })
 
 #define put_unaligned(value, loc) \
 do { \
 	size_t size = sizeof(*(loc)); \
-	__typeof__(*(loc)) val = value; \
+	__typeof__(*(loc)) _v = value; \
 	switch(size) { \
 	case 1: case 2: case 4: case 8: \
-		memcpy((loc), &val, size); \
+		memcpy((loc), &_v, size); \
 		break; \
 	default: \
 		bad_unaligned_access_length(); \
 		break; \
 	} \
 } while(0)
-#endif
 
 extern unsigned long long mem_min, mem_max;
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
