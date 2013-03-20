Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-da0-x22a.google.com ([2607:f8b0:400e:c00::22a])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIIr7-0003eG-Hb
 for kexec@lists.infradead.org; Wed, 20 Mar 2013 13:15:02 +0000
Received: by mail-da0-f42.google.com with SMTP id n15so985987dad.29
 for <kexec@lists.infradead.org>; Wed, 20 Mar 2013 06:14:59 -0700 (PDT)
Message-ID: <5149B64C.7050405@gmail.com>
Date: Wed, 20 Mar 2013 21:14:52 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH] kexec: debug: Use dbgprintf() instead of #ifdef DEBUG
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
To: Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

When use -d option, dbgprintf() will be used to print the debug info.
And we don't have a DEBUG definition, so replace #ifdef DEBUG test
with dbgprinf().

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/i386/crashdump-x86.c    |    6 ++----
 kexec/arch/ppc64/crashdump-ppc64.c |   12 +++---------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 5462f8b..31748c2 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -929,10 +929,8 @@ static int cmdline_add_memmap_reserved(char *cmdline, unsigned long start,
 		die("Command line overflow\n");
 	strcat(cmdline, str_mmap);
 
-#ifdef DEBUG
-		printf("Command line after adding reserved memmap\n");
-		printf("%s\n", cmdline);
-#endif
+	dbgprintf("Command line after adding reserved memmap\n");
+	dbgprintf("%s\n", cmdline);
 	return 0;
 }
 
diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index 49cab12..6b2eb4c 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -472,24 +472,18 @@ void add_usable_mem_rgns(unsigned long long base, unsigned long long size)
 			if (base < ustart && end > uend) {
 				usablemem_rgns.ranges[i].start = base;
 				usablemem_rgns.ranges[i].end = end;
-#ifdef DEBUG
-				fprintf(stderr, "usable memory rgn %u: new base:%llx new size:%llx\n",
+				dbgprintf("usable memory rgn %u: new base:%llx new size:%llx\n",
 					i, base, size);
-#endif
 				return;
 			} else if (base < ustart) {
 				usablemem_rgns.ranges[i].start = base;
-#ifdef DEBUG
-				fprintf(stderr, "usable memory rgn %u: new base:%llx new size:%llx",
+				dbgprintf("usable memory rgn %u: new base:%llx new size:%llx",
 					i, base, usablemem_rgns.ranges[i].end - base);
-#endif
 				return;
 			} else if (end > uend){
 				usablemem_rgns.ranges[i].end = end;
-#ifdef DEBUG
-				fprintf(stderr, "usable memory rgn %u: new end:%llx, new size:%llx",
+				dbgprintf("usable memory rgn %u: new end:%llx, new size:%llx",
 					i, end, end - usablemem_rgns.ranges[i].start);
-#endif
 				return;
 			}
 		}
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
