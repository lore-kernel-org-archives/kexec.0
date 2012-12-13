Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mo6-p00-ob.rzone.de ([2a01:238:20a:202:5300::1])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TjB1y-0002Gy-GH
 for kexec@lists.infradead.org; Thu, 13 Dec 2012 15:49:04 +0000
From: Olaf Hering <olaf@aepfle.de>
Subject: [PATCH 1/5] Fix xen_cpuid() inline asm to not clobber stack's red zone
Date: Thu, 13 Dec 2012 16:48:46 +0100
Message-Id: <1355413730-18190-1-git-send-email-olaf@aepfle.de>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Olaf Hering <olaf@aepfle.de>

Port xen-unstable changeset 24344:72f4e4cb7440 to kexec-tools:

  Pushing stuff onto the stack on x86-64 when we do not specify
  -mno-red-zone is unsafe. Since the complicated asm is due to register
  pressure on i386, we simply implement an all-new simpler alternative
  for x86-64.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 kexec/crashdump-xen.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/kexec/crashdump-xen.c b/kexec/crashdump-xen.c
index 9dfabf8..d8bd0f4 100644
--- a/kexec/crashdump-xen.c
+++ b/kexec/crashdump-xen.c
@@ -41,18 +41,21 @@ void xen_sigill_handler(int sig)
 
 static void xen_cpuid(uint32_t idx, uint32_t *regs, int pv_context)
 {
-	asm volatile (
 #ifdef __i386__
-#define R(x) "%%e"#x"x"
+    /* Use the stack to avoid reg constraint failures with some gcc flags */
+    asm volatile (
+        "push %%eax; push %%ebx; push %%ecx; push %%edx\n\t"
+        "test %1,%1 ; jz 1f ; ud2a ; .ascii \"xen\" ; 1: cpuid\n\t"
+        "mov %%eax,(%2); mov %%ebx,4(%2)\n\t"
+        "mov %%ecx,8(%2); mov %%edx,12(%2)\n\t"
+        "pop %%edx; pop %%ecx; pop %%ebx; pop %%eax\n\t"
+        : : "a" (idx), "c" (pv_context), "S" (regs) : "memory" );
 #else
-#define R(x) "%%r"#x"x"
+    asm volatile (
+        "test %5,%5 ; jz 1f ; ud2a ; .ascii \"xen\" ; 1: cpuid\n\t"
+        : "=a" (regs[0]), "=b" (regs[1]), "=c" (regs[2]), "=d" (regs[3])
+        : "0" (idx), "1" (pv_context), "2" (0) );
 #endif
-	"push "R(a)"; push "R(b)"; push "R(c)"; push "R(d)"\n\t"
-	"test %1,%1 ; jz 1f ; ud2a ; .ascii \"xen\" ; 1: cpuid\n\t"
-	"mov %%eax,(%2); mov %%ebx,4(%2)\n\t"
-	"mov %%ecx,8(%2); mov %%edx,12(%2)\n\t"
-	"pop "R(d)"; pop "R(c)"; pop "R(b)"; pop "R(a)"\n\t"
-	: : "a" (idx), "c" (pv_context), "S" (regs) : "memory" );
 }
 
 static int check_for_xen(int pv_context)
-- 
1.8.0.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
