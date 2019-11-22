Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iYDZ7-0007Gi-5h
 for kexec@lists.infradead.org; Fri, 22 Nov 2019 18:21:59 +0000
Received: by mail-yw1-xc44.google.com with SMTP id g77so2716058ywb.10
 for <kexec@lists.infradead.org>; Fri, 22 Nov 2019 10:21:56 -0800 (PST)
From: minyard@acm.org
Subject: [PATCH] powerpc: Fix issue with missing registers in kdump
Date: Fri, 22 Nov 2019 12:21:44 -0600
Message-Id: <20191122182144.20633-1-minyard@acm.org>
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
To: kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

When powerpc saved the registers on an SMP system, it was doing so
correctly.  But after the crash, the register information was blank.
The issue was that the data was still in the CPU caches on the
CPUs, but once the jump to the crash kernel was done, the data was
never flushed to main memory, so that data was lost.

Add a cache flush after the CPU register notes are saved to fix
the issue.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
I found this problem on an older (3.10) kernel on a Freescale
T1042D4RDB system, and I couldn't find any discussion or change that
dealt with anything like this.  It appears to still be an issue,
though I'm not sure and I'm not sure this is the right way to fix the
problem.

I've tried reproducing on end of tree, but I've run into a couple of
issues.  The file
 /proc/device-tree/soc@ffe000000/fman@400000/fman-firmware/fsl,firmware
will only return 4096 bytes at a time (apparently it didn't in 3.10),
but the kexec command tries to read it in one big read in
kexec/arch/ppc/fs2dt.c:

       if (read(fd, dt, len) != len)
                die("unrecoverable error: could not read \"%s\": %s\n",
                    pathname, strerror(errno));

I hacked around that and now it hangs before printing anything in the
new kernel.  Since the above was broken, I doubt this has been tested
in a while, so no surprise, I guess.  

So I can't test this out on a current kernel, and I'm not sure what to
do at this point.  I have it fixed for our current use, but getting a
fix upstream would be good.

 arch/powerpc/kernel/crash.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index d488311efab1..f6e345b8c33d 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -24,6 +24,7 @@
 #include <asm/smp.h>
 #include <asm/setjmp.h>
 #include <asm/debug.h>
+#include <asm/cacheflush.h>
 
 /*
  * The primary CPU waits a while for all secondary CPUs to enter. This is to
@@ -75,8 +76,21 @@ void crash_ipi_callback(struct pt_regs *regs)
 
 	hard_irq_disable();
 	if (!cpumask_test_cpu(cpu, &cpus_state_saved)) {
+		char *buf;
+
 		crash_save_cpu(regs, cpu);
 		cpumask_set_cpu(cpu, &cpus_state_saved);
+
+		/*
+		 * Flush the crash note region data, otherwise the
+		 * data gets left in the CPU cache and then
+		 * invalidated, so the crashing cpu will never see it
+		 * in the new kernel.
+		 */
+		buf = (char *) per_cpu_ptr(crash_notes, cpu);
+		if (buf)
+			flush_dcache_range((unsigned long) buf,
+				(unsigned long) buf + sizeof(note_buf_t));
 	}
 
 	atomic_inc(&cpus_in_crash);
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
