Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jy3vt-0000j6-UO
 for kexec@lists.infradead.org; Wed, 22 Jul 2020 01:52:34 +0000
Received: by mail-pg1-x543.google.com with SMTP id w2so350095pgg.10
 for <kexec@lists.infradead.org>; Tue, 21 Jul 2020 18:52:33 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
Subject: [PATCHv3 2/2] powerpc/pseries: update device tree before ejecting
 hotplug uevents
Date: Wed, 22 Jul 2020 09:52:10 +0800
Message-Id: <1595382730-10565-2-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1595382730-10565-1-git-send-email-kernelfans@gmail.com>
References: <1595382730-10565-1-git-send-email-kernelfans@gmail.com>
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
To: linuxppc-dev@lists.ozlabs.org
Cc: Nathan Lynch <nathanl@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org, Hari Bathini <hbathini@linux.ibm.com>, Pingfan Liu <kernelfans@gmail.com>

A bug is observed on pseries by taking the following steps on rhel:
-1. drmgr -c mem -r -q 5
-2. echo c > /proc/sysrq-trigger

And then, the failure looks like:
kdump: saving to /sysroot//var/crash/127.0.0.1-2020-01-16-02:06:14/
kdump: saving vmcore-dmesg.txt
kdump: saving vmcore-dmesg.txt complete
kdump: saving vmcore
 Checking for memory holes                         : [  0.0 %] /                   Checking for memory holes                         : [100.0 %] |                   Excluding unnecessary pages                       : [100.0 %] \                   Copying data                                      : [  0.3 %] -          eta: 38s[   44.337636] hash-mmu: mm: Hashing failure ! EA=0x7fffba400000 access=0x8000000000000004 current=makedumpfile
[   44.337663] hash-mmu:     trap=0x300 vsid=0x13a109c ssize=1 base psize=2 psize 2 pte=0xc000000050000504
[   44.337677] hash-mmu: mm: Hashing failure ! EA=0x7fffba400000 access=0x8000000000000004 current=makedumpfile
[   44.337692] hash-mmu:     trap=0x300 vsid=0x13a109c ssize=1 base psize=2 psize 2 pte=0xc000000050000504
[   44.337708] makedumpfile[469]: unhandled signal 7 at 00007fffba400000 nip 00007fffbbc4d7fc lr 000000011356ca3c code 2
[   44.338548] Core dump to |/bin/false pipe failed
/lib/kdump-lib-initramfs.sh: line 98:   469 Bus error               $CORE_COLLECTOR /proc/vmcore $_mp/$KDUMP_PATH/$HOST_IP-$DATEDIR/vmcore-incomplete
kdump: saving vmcore failed

* Root cause *
  After analyzing, it turns out that in the current implementation,
when hot-removing lmb, the KOBJ_REMOVE event ejects before the dt updating as
the code __remove_memory() comes before drmem_update_dt().
So in kdump kernel, when read_from_oldmem() resorts to
pSeries_lpar_hpte_insert() to install hpte, but fails with -2 due to
non-exist pfn. And finally, low_hash_fault() raise SIGBUS to process, as it
can be observed "Bus error"

From a viewpoint of listener and publisher, the publisher notifies the
listener before data is ready.  This introduces a problem where udev
launches kexec-tools (due to KOBJ_REMOVE) and loads a stale dt before
updating. And in capture kernel, makedumpfile will access the memory based
on the stale dt info, and hit a SIGBUS error due to an un-existed lmb.

* Fix *
  In order to fix this issue, update dt before __remove_memory(), and
accordingly the same rule in hot-add path.

This will introduce extra dt updating payload for each involved lmb when hotplug.
But it should be fine since drmem_update_dt() is memory based operation and
hotplug is not a hot path.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Nathan Lynch <nathanl@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kexec@lists.infradead.org
---
v2 -> v3: rebase onto ppc next-test branch
---
 arch/powerpc/platforms/pseries/hotplug-memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 1a3ac3b..def8cb3f 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -372,6 +372,7 @@ static int dlpar_remove_lmb(struct drmem_lmb *lmb)
 	invalidate_lmb_associativity_index(lmb);
 	lmb_clear_nid(lmb);
 	lmb->flags &= ~DRCONF_MEM_ASSIGNED;
+	drmem_update_dt();
 
 	__remove_memory(nid, base_addr, block_sz);
 
@@ -607,6 +608,7 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
 
 	lmb_set_nid(lmb);
 	lmb->flags |= DRCONF_MEM_ASSIGNED;
+	drmem_update_dt();
 
 	block_sz = memory_block_size_bytes();
 
@@ -625,6 +627,7 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
 		invalidate_lmb_associativity_index(lmb);
 		lmb_clear_nid(lmb);
 		lmb->flags &= ~DRCONF_MEM_ASSIGNED;
+		drmem_update_dt();
 
 		__remove_memory(nid, base_addr, block_sz);
 	}
@@ -877,9 +880,6 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 		break;
 	}
 
-	if (!rc)
-		rc = drmem_update_dt();
-
 	unlock_device_hotplug();
 	return rc;
 }
-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
