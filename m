Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TxBqR-0005mc-K7
 for kexec@lists.infradead.org; Mon, 21 Jan 2013 07:31:04 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id DA5FD3EE0BB
 for <kexec@lists.infradead.org>; Mon, 21 Jan 2013 16:30:55 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id C244445DEB5
 for <kexec@lists.infradead.org>; Mon, 21 Jan 2013 16:30:55 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id AB1F445DEB2
 for <kexec@lists.infradead.org>; Mon, 21 Jan 2013 16:30:55 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 9C2DB1DB803C
 for <kexec@lists.infradead.org>; Mon, 21 Jan 2013 16:30:55 +0900 (JST)
Received: from m021.s.css.fujitsu.com (m021.s.css.fujitsu.com [10.0.81.61])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 52B4C1DB803B
 for <kexec@lists.infradead.org>; Mon, 21 Jan 2013 16:30:55 +0900 (JST)
Date: Mon, 21 Jan 2013 16:30:46 +0900 (JST)
Message-Id: <20130121.163046.468065730.d.hatayama@jp.fujitsu.com>
Subject: [PATCH] makedumpfile, sadump: fix warning messages in building time
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

Recent gcc outputs the following warning messages when compiles
sadump_info.c because a given pointer is compared as conditional but
they are static string objects and are alreays converted into true.

./sadump_info.c: In function 'sadump_virt_phys_base':
./sadump_info.c:926: warning: the address of 'buf' will always evaluate as 'true'
./sadump_info.c:933: warning: the address of 'buf' will always evaluate as 'true'

But this is within our intension so enclose the occurence of static
strings by static inline function to surpress the compiler's checking.

I borrowed this code from crash utility.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 makedumpfile.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/makedumpfile.h b/makedumpfile.h
index d2bdc0c..a0c5b7d 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -213,7 +213,9 @@ isAnon(unsigned long mapping)
 	sizeof(Elf64_Ehdr)+sizeof(Elf64_Phdr)+sizeof(Elf64_Phdr)
 #define MIN_ELF_HEADER_SIZE \
 	MAX(MIN_ELF32_HEADER_SIZE, MIN_ELF64_HEADER_SIZE)
-#define STRNEQ(A, B)	(A && B && \
+static inline int string_exists(char *s) { return (s ? TRUE : FALSE); }
+#define STRNEQ(A, B)	(string_exists((char *)(A)) &&			\
+			string_exists((char *)(B)) &&			\
 	(strncmp((char *)(A), (char *)(B), strlen((char *)(B))) == 0))
 
 #define USHORT(ADDR)	*((unsigned short *)(ADDR))
-- 
1.7.7.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
