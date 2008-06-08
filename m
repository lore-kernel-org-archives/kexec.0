Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K5LgC-0002qe-4i
	for kexec@lists.infradead.org; Sun, 08 Jun 2008 14:15:43 +0000
Date: Sun, 8 Jun 2008 16:16:07 +0200
Subject: [patch] [PATCH] Use BOOTMEM_EXCLUSIVE for i386
Message-ID: <20080608141607.GA25743@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
From: bwalle@suse.de (Bernhard Walle)
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, anderson@redhat.com, hpa@zytor.com, tglx@linutronix.de, vgoyal@redhat.com

This patch uses the BOOTMEM_EXCLUSIVE for crashkernel reservation also for i386
and prints a error message on failure.

The patch is still for 2.6.26 since it is only bug fixing. The unification of
reserve_crashkernel() between i386 and x86_64 should be done for 2.6.27.



Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 arch/x86/kernel/setup_32.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/setup_32.c
+++ b/arch/x86/kernel/setup_32.c
@@ -532,10 +532,16 @@ static void __init reserve_crashkernel(v
 					(unsigned long)(crash_size >> 20),
 					(unsigned long)(crash_base >> 20),
 					(unsigned long)(total_mem >> 20));
+
+			if (reserve_bootmem(crash_base, crash_size,
+					BOOTMEM_EXCLUSIVE) < 0) {
+				printk(KERN_INFO "crashkernel reservation "
+					"failed - memory is in use\n");
+				return;
+			}
+
 			crashk_res.start = crash_base;
 			crashk_res.end   = crash_base + crash_size - 1;
-			reserve_bootmem(crash_base, crash_size,
-					BOOTMEM_DEFAULT);
 		} else
 			printk(KERN_INFO "crashkernel reservation failed - "
 					"you have to specify a base address\n");

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
