Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mo-p00-ob6.rzone.de ([2a01:238:20a:202:53f0::1])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qof7B-0004qS-Ed
	for kexec@lists.infradead.org; Wed, 03 Aug 2011 17:20:19 +0000
Received: from probook.site
	(dslb-084-057-077-220.pools.arcor-ip.net [84.57.77.220])
	by post.strato.de (mrclete mo30) (RZmta 26.2)
	with (EDH-RSA-DES-CBC3-SHA encrypted) ESMTPA id n02a66n73GD3W9
	for <kexec@lists.infradead.org>; Wed, 3 Aug 2011 19:19:24 +0200 (MEST)
Date: Wed, 3 Aug 2011 19:19:23 +0200
From: Olaf Hering <olaf@aepfle.de>
Subject: [PATCH] fix Xen detection for xenfs in pv_ops kernel
Message-ID: <20110803171923.GA21404@aepfle.de>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

The pv_ops kernel in mainline Linux provides xenfs which has to be
mounted at /proc/xen.  It creates /proc/xen/capabilities unconditionally
which makes it impossible to distinguish PVonHVM guests from PV guests.
Use code from xen-detect.c to check wether kexec runs on a PV guest.
Without this change PVonHVM guests will be detected incorrectly as plain
PV guests.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 kexec/crashdump-xen.c |   79 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 2 deletions(-)

Index: kexec-tools.git/kexec/crashdump-xen.c
===================================================================
--- kexec-tools.git.orig/kexec/crashdump-xen.c
+++ kexec-tools.git/kexec/crashdump-xen.c
@@ -10,6 +10,8 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <fcntl.h>
+#include <setjmp.h>
+#include <signal.h>
 #include "kexec.h"
 #include "crashdump.h"
 #include "kexec-syscall.h"
@@ -27,13 +29,86 @@ struct crash_note_info {
 
 static int xen_phys_cpus;
 static struct crash_note_info *xen_phys_notes;
+
+/* based on code from xen-detect.c */
 static int is_dom0;
+static jmp_buf xen_sigill_jmp;
+void xen_sigill_handler(int sig)
+{
+	longjmp(xen_sigill_jmp, 1);
+}
+
+static void xen_cpuid(uint32_t idx, uint32_t *regs, int pv_context)
+{
+	asm volatile (
+#ifdef __i386__
+#define R(x) "%%e"#x"x"
+#else
+#define R(x) "%%r"#x"x"
+#endif
+	"push "R(a)"; push "R(b)"; push "R(c)"; push "R(d)"\n\t"
+	"test %1,%1 ; jz 1f ; ud2a ; .ascii \"xen\" ; 1: cpuid\n\t"
+	"mov %%eax,(%2); mov %%ebx,4(%2)\n\t"
+	"mov %%ecx,8(%2); mov %%edx,12(%2)\n\t"
+	"pop "R(d)"; pop "R(c)"; pop "R(b)"; pop "R(a)"\n\t"
+	: : "a" (idx), "c" (pv_context), "S" (regs) : "memory" );
+}
+
+static int check_for_xen(int pv_context)
+{
+	uint32_t regs[4];
+	char signature[13];
+	uint32_t base;
+
+	for (base = 0x40000000; base < 0x40010000; base += 0x100)
+	{
+		xen_cpuid(base, regs, pv_context);
+
+		*(uint32_t *)(signature + 0) = regs[1];
+		*(uint32_t *)(signature + 4) = regs[2];
+		*(uint32_t *)(signature + 8) = regs[3];
+		signature[12] = '\0';
+
+		if (strcmp("XenVMMXenVMM", signature) == 0 && regs[0] >= (base + 2))
+			goto found;
+	}
+
+	return 0;
+
+found:
+	xen_cpuid(base + 1, regs, pv_context);
+	return regs[0];
+}
+
+static int xen_detect_pv_guest(void)
+{
+	struct sigaction act, oldact;
+	int is_pv = -1;
+
+	if (setjmp(xen_sigill_jmp))
+		return is_pv;
+
+	memset(&act, 0, sizeof(act));
+	act.sa_handler = xen_sigill_handler;
+	sigemptyset (&act.sa_mask);
+	if (sigaction(SIGILL, &act, &oldact))
+		return is_pv;
+	if (check_for_xen(1))
+		is_pv = 1;
+	sigaction(SIGILL, &oldact, NULL);
+	return is_pv;
+}
 
+/*
+ * Return 1 if its a PV guest.
+ * This includes dom0, which is the only PV guest where kexec/kdump works.
+ * HVM guests have to be handled as native hardware.
+ */
 int xen_present(void)
 {
 	if (!is_dom0) {
-		if (access("/proc/xen/capabilities", F_OK) == 0)
-			is_dom0 = 1;
+		if (access("/proc/xen", F_OK) == 0)
+			is_dom0 = xen_detect_pv_guest();
 		else
 			is_dom0 = -1;
 	}

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
