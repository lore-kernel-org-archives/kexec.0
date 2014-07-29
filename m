Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.nebula.fi ([2001:1bc8:100c:f220::66])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XC9in-0007Mf-MQ
 for kexec@lists.infradead.org; Tue, 29 Jul 2014 15:53:50 +0000
Received: from posti.hankala.fi (posti.hankala.fi [83.150.85.27])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by smtp.nebula.fi (Postfix) with ESMTPS id D41F6D00DB3
 for <kexec@lists.infradead.org>; Tue, 29 Jul 2014 18:51:07 +0300 (EEST)
Received: from posti.hankala.fi (localhost [127.0.0.1])
 by posti.hankala.fi (Postfix) with ESMTPS id E7C3EFBC
 for <kexec@lists.infradead.org>; Tue, 29 Jul 2014 15:51:03 +0000 (UTC)
Received: (from visa@localhost)
 by posti.hankala.fi (8.14.7/8.14.7/Submit) id s6TFp3PH074182
 for kexec@lists.infradead.org; Tue, 29 Jul 2014 15:51:03 GMT
 (envelope-from visa@hankala.org)
Date: Tue, 29 Jul 2014 15:51:03 +0000
From: Visa Hankala <visa@hankala.org>
Subject: [PATCH] kexec: Fix callback parameter types
Message-ID: <20140729154001.Sx1ujgo15C8oflxb@hankala.org>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Commit 4362bfaca4d8d2a4380532880f0d08c2bf14184e changed
kexec_iomem_for_each_line() to pass 'base' and 'length' parameters of
the callback function as unsigned long long integers instead of unsigned
longs. Some of the functions were not updated. This patch corrects the
remaining instances.

Signed-off-by: Visa Hankala <visa@hankala.org>
---
 kexec/arch/i386/crashdump-x86.c |    4 ++--
 kexec/arch/sh/crashdump-sh.c    |    4 ++--
 kexec/arch/sh/kexec-sh.c        |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 77bdad5..82bf239 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -1041,8 +1041,8 @@ int get_max_crash_kernel_limit(uint64_t *start, uint64_t *end)
 
 static int crashkernel_mem_callback(void *UNUSED(data), int nr,
                                           char *UNUSED(str),
-                                          unsigned long base,
-                                          unsigned long length)
+                                          unsigned long long base,
+                                          unsigned long long length)
 {
 	if (nr >= CRASH_RESERVED_MEM_NR)
 		return 1;
diff --git a/kexec/arch/sh/crashdump-sh.c b/kexec/arch/sh/crashdump-sh.c
index fe11b17..9e6af6b 100644
--- a/kexec/arch/sh/crashdump-sh.c
+++ b/kexec/arch/sh/crashdump-sh.c
@@ -34,8 +34,8 @@ static struct memory_range crash_memory_range[CRASH_MAX_MEMORY_RANGES];
 static int crash_sh_range_nr;
 static int crash_sh_memory_range_callback(void *UNUSED(data), int UNUSED(nr),
 					  char *str,
-					  unsigned long base,
-					  unsigned long length)
+					  unsigned long long base,
+					  unsigned long long length)
 {
 
 	struct memory_range *range = crash_memory_range;
diff --git a/kexec/arch/sh/kexec-sh.c b/kexec/arch/sh/kexec-sh.c
index aea5dfb..ce341c8 100644
--- a/kexec/arch/sh/kexec-sh.c
+++ b/kexec/arch/sh/kexec-sh.c
@@ -24,8 +24,8 @@ static struct memory_range memory_range[MAX_MEMORY_RANGES];
 
 static int kexec_sh_memory_range_callback(void *UNUSED(data), int nr,
 					  char *UNUSED(str),
-					  unsigned long base,
-					  unsigned long length)
+					  unsigned long long base,
+					  unsigned long long length)
 {
 	if (nr < MAX_MEMORY_RANGES) {
 		memory_range[nr].start = base;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
