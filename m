Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ra.tuxdriver.com ([70.61.120.52])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JMpvo-0000Qi-GJ
	for kexec@lists.infradead.org; Wed, 06 Feb 2008 19:27:47 +0000
Date: Wed, 6 Feb 2008 14:25:55 -0500
From: Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH],
	issue EOI to APIC prior to calling crash_kexec in die_nmi path
Message-ID: <20080206192555.GA24910@hmsendeavour.rdu.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc: kexec@lists.infradead.org, nhorman@tuxdriver.com

Hey all-
	A hang on kdump was reported to me awhile back, only when systems died
via nmi watchdog panic.  The hang wouldn't always be in the same place, but it
would usually be somewhere down in purgatory.  In looking at the code, it
occured to me that since, during an nmi interrupt, we won't be able to handle
additional interrupts, that we won't be able to halt the other processors on a
system like we try to do in machine_crash_shutdown.  As such, it appears that
leaving the other cpus running exposes us to the risk that another processor
will encounter an error and halt the system while we are trying to boot the
kdump kernel, and that can result in a hang.  I wrote the attached patch to end
the nmi interrupt prior to calling crash_kexec from within die_nmi, and testing
here has proven successfull.

Regards
Neil

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>


 traps_32.c |    2 ++
 traps_64.c |    5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)


diff --git a/arch/x86/kernel/traps_32.c b/arch/x86/kernel/traps_32.c
index 3cf7297..4443e8e 100644
--- a/arch/x86/kernel/traps_32.c
+++ b/arch/x86/kernel/traps_32.c
@@ -751,6 +751,8 @@ void __kprobes die_nmi(struct pt_regs *regs, const char *msg)
 	 * and might aswell get out now while we still can.
 	*/
 	if (!user_mode_vm(regs)) {
+		nmi_exit();
+		local_irq_enable();
 		current->thread.trap_no = 2;
 		crash_kexec(regs);
 	}
diff --git a/arch/x86/kernel/traps_64.c b/arch/x86/kernel/traps_64.c
index efc66df..0a50e70 100644
--- a/arch/x86/kernel/traps_64.c
+++ b/arch/x86/kernel/traps_64.c
@@ -608,8 +608,11 @@ void __kprobes die_nmi(char *str, struct pt_regs *regs, int do_panic)
 	 */
 	printk(str, smp_processor_id());
 	show_registers(regs);
-	if (kexec_should_crash(current))
+	if (kexec_should_crash(current)) {
+		nmi_exit();
+		local_irq_enable();
 		crash_kexec(regs);
+	}
 	if (do_panic || panic_on_oops)
 		panic("Non maskable interrupt");
 	oops_end(flags, NULL, SIGBUS);
-- 
/***************************************************
 *Neil Horman
 *nhorman@tuxdriver.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
