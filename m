Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K5LDb-0003i3-VQ
	for kexec@lists.infradead.org; Sun, 08 Jun 2008 13:46:00 +0000
Message-Id: <20080608134629.963591078@halley.suse.de>
Date: Sun, 08 Jun 2008 15:46:31 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: [patch 3/3] Use reserve_bootmem_generic() to reserve crashkernel
	memory on x86_64
References: <20080608134628.757299158@halley.suse.de>
Content-Disposition: inline; filename=use-bootmem-generic
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
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
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, anderson@redhat.com, hpa@zytor.com, tglx@linutronix.de, vgoyal@redhat.com

This patch uses reserve_bootmem_generic() instead of reserve_bootmem()
to reserve the crashkernel memory on x86_64. That's necessary for NUMA
machines, see 00212fef814612245ed0261cbac8426d0c9a31a5:

  [PATCH] Fix kdump Crash Kernel boot memory reservation for NUMA machines

  This patch will fix a boot memory reservation bug that trashes memory on
  the ES7000 when loading the kdump crash kernel.

  The code in arch/x86_64/kernel/setup.c to reserve boot memory for the crash
  kernel uses the non-numa aware "reserve_bootmem" function instead of the
  NUMA aware "reserve_bootmem_generic".  I checked to make sure that no other
  function was using "reserve_bootmem" and found none, except the ones that
  had NUMA ifdef'ed out.

  I have tested this patch only on an ES7000 with NUMA on and off (numa=off)
  in a single (non-NUMA) and multi-cell (NUMA) configurations.

  Signed-off-by: Amul Shah <amul.shah@unisys.com>
  Looks-good-to: Vivek Goyal <vgoyal@in.ibm.com>
  Cc: Andi Kleen <ak@muc.de>
  Signed-off-by: Andrew Morton <akpm@osdl.org>
  Signed-off-by: Linus Torvalds <torvalds@osdl.org>

The switch-back to reserve_bootmem() was accidentally introduced in
5c3391f9f749023a49c64d607da4fb49263690eb when adding the BOOTMEM_EXCLUSIVE
parameter.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 arch/x86/kernel/setup_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/setup_64.c
+++ b/arch/x86/kernel/setup_64.c
@@ -243,7 +243,7 @@ static void __init reserve_crashkernel(v
 			return;
 		}
 
-		if (reserve_bootmem(crash_base, crash_size,
+		if (reserve_bootmem_generic(crash_base, crash_size,
 					BOOTMEM_EXCLUSIVE) < 0) {
 			printk(KERN_INFO "crashkernel reservation failed - "
 					"memory is in use\n");


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
