Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pd0-x231.google.com ([2607:f8b0:400e:c02::231])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YQESQ-0004Q0-4d
 for kexec@lists.infradead.org; Tue, 24 Feb 2015 12:19:23 +0000
Received: by pdjy10 with SMTP id y10so33025000pdj.6
 for <kexec@lists.infradead.org>; Tue, 24 Feb 2015 04:19:00 -0800 (PST)
From: Roman Pen <r.peniaev@gmail.com>
Subject: [PATCH 1/1] kexec: iomem: fix callbacks params for sh and x86 archs
Date: Tue, 24 Feb 2015 21:18:47 +0900
Message-Id: <1424780328-31722-1-git-send-email-r.peniaev@gmail.com>
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
Cc: kexec@lists.infradead.org, Roman Pen <r.peniaev@gmail.com>

Commit 4362bfac changes params for kexec_iomem_for_each_line from
'unsigned long' to 'unsigned long long'.

This patch fixes forgotten changes for sh and x86 archs.
Bug causes incorrect parsing of memory ranges.

Signed-off-by: Roman Pen <r.peniaev@gmail.com>
Cc: kexec@lists.infradead.org
---
 kexec/arch/i386/crashdump-x86.c | 4 ++--
 kexec/arch/sh/crashdump-sh.c    | 4 ++--
 kexec/arch/sh/kexec-sh.c        | 4 ++--
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
-- 
2.2.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
