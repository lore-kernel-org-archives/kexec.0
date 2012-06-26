Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mo6-p00-ob.rzone.de ([2a01:238:20a:202:5300::1])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SjYGC-0006pL-4Z
 for kexec@lists.infradead.org; Tue, 26 Jun 2012 16:05:01 +0000
Received: from probook.site
 (dslb-084-057-095-153.pools.arcor-ip.net [84.57.95.153])
 by smtp.strato.de (jorabe mo39) (RZmta 29.19 DYNA|AUTH)
 with (DHE-RSA-AES256-SHA encrypted) ESMTPA id q03f3do5QEENdU
 for <kexec@lists.infradead.org>; Tue, 26 Jun 2012 18:04:55 +0200 (CEST)
Date: Tue, 26 Jun 2012 18:04:55 +0200
From: Olaf Hering <olaf@aepfle.de>
Subject: misc fixes for kexec available via git pull
Message-ID: <20120626160454.GA23459@aepfle.de>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

I sent the individual patches a few days ago. Appearently they did not
make it to the list. Maybe because I was not subscribed at that time.

So here is the 'git request-pull -p' output.

Olaf

The following changes since commit c423dc9db2d052d997e85e741b16ca919ee3011e:

  Support kernel_noload uImage type (2012-06-18 10:47:04 +0900)

are available in the git repository at:
  git://github.com/olafhering/kexec-tools.git misc

Olaf Hering (5):
      Fix xen_cpuid() inline asm to not clobber stack's red zone
      fixed strncat size argument on ppc64
      fix message and indenting in putnode in ppc64
      fix comment typo in do_bzImage_load on x86
      fix comment typo in locate_hole

 kexec/arch/i386/kexec-bzImage.c |    2 +-
 kexec/arch/ppc64/fs2dt.c        |   22 +++++++++-------------
 kexec/crashdump-xen.c           |   21 ++++++++++++---------
 kexec/kexec.c                   |    2 +-
 4 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index 6998587..fd214a3 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -194,7 +194,7 @@ int do_bzImage_load(struct kexec_info *info,
 	}
 
 	/* Load the trampoline.  This must load at a higher address
-	 * the the argument/parameter segment or the kernel will stomp
+	 * than the argument/parameter segment or the kernel will stomp
 	 * it's gdt.
 	 *
 	 * x86_64 purgatory code has got relocations type R_X86_64_32S
diff --git a/kexec/arch/ppc64/fs2dt.c b/kexec/arch/ppc64/fs2dt.c
index d2b6b18..9750c34 100644
--- a/kexec/arch/ppc64/fs2dt.c
+++ b/kexec/arch/ppc64/fs2dt.c
@@ -499,7 +499,7 @@ static void putnode(void)
 
 	basename = strrchr(pathname,'/');
 
-	strcat(pathname, "/");
+	strncat(pathname, "/", MAXPATH - strlen(pathname) - 1);
 	dn = pathname + strlen(pathname);
 
 	putprops(dn, namelist, numlist);
@@ -560,7 +560,7 @@ static void putnode(void)
 			char *old_param;
 
 			strcpy(filename, pathname);
-			strcat(filename, "bootargs");
+			strncat(filename, "bootargs", MAXPATH - strlen(filename) - 1);
 			fp = fopen(filename, "r");
 			if (fp) {
 				if (getline(&last_cmdline, &cmd_len, fp) == -1)
@@ -599,16 +599,14 @@ static void putnode(void)
 		 * pseries/hvcterminal is supported.
 		 */
 		strcpy(filename, pathname);
-		strncat(filename, "linux,stdout-path", MAXPATH);
+		strncat(filename, "linux,stdout-path", MAXPATH - strlen(filename) - 1);
 		fd = open(filename, O_RDONLY);
 		if (fd == -1) {
-			printf("Unable to find %s, printing from purgatory is diabled\n",
-														filename);
+			printf("Unable to find %s, printing from purgatory is disabled\n", filename);
 			goto no_debug;
 		}
 		if (fstat(fd, &statbuf)) {
-			printf("Unable to stat %s, printing from purgatory is diabled\n",
-														filename);
+			printf("Unable to stat %s, printing from purgatory is disabled\n", filename);
 			close(fd);
 			goto no_debug;
 
@@ -623,17 +621,15 @@ static void putnode(void)
 		read(fd, buff, statbuf.st_size);
 		close(fd);
 		strncpy(filename, "/proc/device-tree/", MAXPATH);
-		strncat(filename, buff, MAXPATH);
-		strncat(filename, "/compatible", MAXPATH);
+		strncat(filename, buff, MAXPATH - strlen(filename) - 1);
+		strncat(filename, "/compatible", MAXPATH - strlen(filename) - 1);
 		fd = open(filename, O_RDONLY);
 		if (fd == -1) {
-			printf("Unable to find %s printing from purgatory is diabled\n",
-														filename);
+			printf("Unable to find %s printing from purgatory is disabled\n", filename);
 			goto no_debug;
 		}
 		if (fstat(fd, &statbuf)) {
-			printf("Unable to stat %s printing from purgatory is diabled\n",
-														filename);
+			printf("Unable to stat %s printing from purgatory is disabled\n", filename);
 			close(fd);
 			goto no_debug;
 		}
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
diff --git a/kexec/kexec.c b/kexec/kexec.c
index d2d05a8..715e0ba 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -201,7 +201,7 @@ unsigned long locate_hole(struct kexec_info *info,
 		die("Invalid hole end argument of 0 specified to locate_hole");
 	}
 
-	/* Set an intial invalid value for the hole base */
+	/* Set an initial invalid value for the hole base */
 	hole_base = ULONG_MAX;
 
 	/* Align everything to at least a page size boundary */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
