Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S0NZQ-0000u9-Cb
 for kexec@lists.infradead.org; Thu, 23 Feb 2012 01:34:08 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id CCD003EE0B5
 for <kexec@lists.infradead.org>; Thu, 23 Feb 2012 10:34:06 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id A70D545DE54
 for <kexec@lists.infradead.org>; Thu, 23 Feb 2012 10:34:06 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 90EA645DE4D
 for <kexec@lists.infradead.org>; Thu, 23 Feb 2012 10:34:06 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 849001DB803A
 for <kexec@lists.infradead.org>; Thu, 23 Feb 2012 10:34:06 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 34F141DB802C
 for <kexec@lists.infradead.org>; Thu, 23 Feb 2012 10:34:06 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH makedumpfile v2 2/4] Avoid LONG_MAX/ULONG_MAX redefinitions
Date: Thu, 23 Feb 2012 10:34:05 +0900
Message-ID: <20120223013405.5041.35977.stgit@localhost6.localdomain6>
In-Reply-To: <20120223012940.5041.61104.stgit@localhost6.localdomain6>
References: <20120223012940.5041.61104.stgit@localhost6.localdomain6>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org, crash-utility@redhat.com

common.h locally defines LONG_MAX and ULONG_MAX. But when importing
lzo library's headers, ulimit.h that is imported implicitly is also
imported so the two definitions collide, and the warning message below
is displayed.

gcc -g -O2 -Wall -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -DVERSION='"1.4.2"' -DRELEASE_DATE='"25 January 2012"' -D__x86_64__ -DUSELZO  print_info.o dwarf_info.o elf_info.o erase_info.o sadump_info.o arch/arm.o arch/x86.o arch/x86_64.o arch/ia64.o arch/ppc64.o arch/s390x.o -o makedumpfile makedumpfile.c -llzo2 -ldw -lbz2 -lebl -ldl -lelf -lz
In file included from makedumpfile.h:37:0,
                 from makedumpfile.c:16:
common.h:23:0: warning: "LONG_MAX" redefined
/usr/lib/gcc/x86_64-redhat-linux/4.5.1/include/limits.h:132:0: note: this is the location of the previous definition
common.h:24:0: warning: "ULONG_MAX" redefined
/usr/lib/gcc/x86_64-redhat-linux/4.5.1/include/limits.h:136:0: note: this is the location of the previous definition

To avoid this problem, check if each has already defiend before
defining it.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 common.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/common.h b/common.h
index a4cc2f7..6ad3ca7 100644
--- a/common.h
+++ b/common.h
@@ -20,8 +20,12 @@
 #define FALSE		(0)
 #define ERROR		(-1)
 
+#ifndef LONG_MAX
 #define LONG_MAX	((long)(~0UL>>1))
+#endif
+#ifndef ULONG_MAX
 #define ULONG_MAX	(~0UL)
+#endif
 #define ULONGLONG_MAX	(~0ULL)
 
 #define MAX(a,b)	((a) > (b) ? (a) : (b))


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
