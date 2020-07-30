Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k18gy-00051U-Gg
 for kexec@lists.infradead.org; Thu, 30 Jul 2020 13:33:53 +0000
Received: by mail-pl1-x643.google.com with SMTP id d1so14127955plr.8
 for <kexec@lists.infradead.org>; Thu, 30 Jul 2020 06:33:52 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
Subject: [PATCHv4 2/2] powerpc/pseries: update device tree before ejecting
 hotplug uevents
Date: Thu, 30 Jul 2020 21:33:25 +0800
Message-Id: <1596116005-27511-2-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1596116005-27511-1-git-send-email-kernelfans@gmail.com>
References: <1596116005-27511-1-git-send-email-kernelfans@gmail.com>
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
Cc: Nathan Lynch <nathanl@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org, Pingfan Liu <kernelfans@gmail.com>, Nathan Fontenot <nfont@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>

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
This bug is introduced by commit 063b8b1251fd
("powerpc/pseries/memory-hotplug: Only update DT once per memory DLPAR
request"), which tried to combine all the dt updating into one.

To fix this issue, meanwhile not to introduce a quadratic runtime
complexity by the model:
  dlpar_memory_add_by_count
    for_each_drmem_lmb             <--
      dlpar_add_lmb
        drmem_update_dt(_v1|_v2)
          for_each_drmem_lmb       <--
The dt should still be only updated once, and just before the last memory
online/offline event is ejected to user space. Achieve this by tracing the
num of lmb added or removed.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Nathan Lynch <nathanl@linux.ibm.com>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org
To: linuxppc-dev@lists.ozlabs.org
---
v3 -> v4: resolve a quadratic runtime complexity issue.
          This series is applied on next-test branch
 arch/powerpc/platforms/pseries/hotplug-memory.c | 88 ++++++++++++++++++-------
 1 file changed, 66 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 1a3ac3b..e07d5b1 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -350,13 +350,13 @@ static bool lmb_is_removable(struct drmem_lmb *lmb)
 	return true;
 }
 
-static int dlpar_add_lmb(struct drmem_lmb *);
+static int dlpar_add_lmb(struct drmem_lmb *lmb, bool dt_update);
 
-static int dlpar_remove_lmb(struct drmem_lmb *lmb)
+static int dlpar_remove_lmb(struct drmem_lmb *lmb, bool dt_update)
 {
 	unsigned long block_sz;
 	phys_addr_t base_addr;
-	int rc, nid;
+	int rc, ret, nid;
 
 	if (!lmb_is_removable(lmb))
 		return -EINVAL;
@@ -372,6 +372,11 @@ static int dlpar_remove_lmb(struct drmem_lmb *lmb)
 	invalidate_lmb_associativity_index(lmb);
 	lmb_clear_nid(lmb);
 	lmb->flags &= ~DRCONF_MEM_ASSIGNED;
+	if (dt_update) {
+		ret = drmem_update_dt();
+		if (ret)
+			pr_warn("%s fail to update dt, but continue\n", __func__);
+	}
 
 	__remove_memory(nid, base_addr, block_sz);
 
@@ -387,6 +392,7 @@ static int dlpar_memory_remove_by_count(u32 lmbs_to_remove)
 	int lmbs_removed = 0;
 	int lmbs_available = 0;
 	int rc;
+	bool dt_update = false;
 
 	pr_info("Attempting to hot-remove %d LMB(s)\n", lmbs_to_remove);
 
@@ -409,7 +415,7 @@ static int dlpar_memory_remove_by_count(u32 lmbs_to_remove)
 	}
 
 	for_each_drmem_lmb(lmb) {
-		rc = dlpar_remove_lmb(lmb);
+		rc = dlpar_remove_lmb(lmb, dt_update);
 		if (rc)
 			continue;
 
@@ -421,16 +427,27 @@ static int dlpar_memory_remove_by_count(u32 lmbs_to_remove)
 		lmbs_removed++;
 		if (lmbs_removed == lmbs_to_remove)
 			break;
+		/* combine dt updating */
+		else if (lmbs_removed == lmbs_to_remove - 1)
+			dt_update = true;
 	}
 
 	if (lmbs_removed != lmbs_to_remove) {
+		bool rollback_dt_update = false;
+
 		pr_err("Memory hot-remove failed, adding LMB's back\n");
 
 		for_each_drmem_lmb(lmb) {
 			if (!drmem_lmb_reserved(lmb))
 				continue;
 
-			rc = dlpar_add_lmb(lmb);
+			/*
+			 * Even if dlpar_remove_lmb() fails to update dt, it is
+			 * harmless to update dt here.
+			 */
+			if (--lmbs_removed == 0 && dt_update)
+				rollback_dt_update = true;
+			rc = dlpar_add_lmb(lmb, rollback_dt_update);
 			if (rc)
 				pr_err("Failed to add LMB back, drc index %x\n",
 				       lmb->drc_index);
@@ -468,7 +485,7 @@ static int dlpar_memory_remove_by_index(u32 drc_index)
 	for_each_drmem_lmb(lmb) {
 		if (lmb->drc_index == drc_index) {
 			lmb_found = 1;
-			rc = dlpar_remove_lmb(lmb);
+			rc = dlpar_remove_lmb(lmb, true);
 			if (!rc)
 				dlpar_release_drc(lmb->drc_index);
 
@@ -493,6 +510,7 @@ static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index)
 	struct drmem_lmb *lmb, *start_lmb, *end_lmb;
 	int lmbs_available = 0;
 	int rc;
+	bool dt_update = false;
 
 	pr_info("Attempting to hot-remove %u LMB(s) at %x\n",
 		lmbs_to_remove, drc_index);
@@ -519,7 +537,9 @@ static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index)
 		if (!(lmb->flags & DRCONF_MEM_ASSIGNED))
 			continue;
 
-		rc = dlpar_remove_lmb(lmb);
+		if (lmb == end_lmb)
+			dt_update = true;
+		rc = dlpar_remove_lmb(lmb, dt_update);
 		if (rc)
 			break;
 
@@ -527,14 +547,17 @@ static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index)
 	}
 
 	if (rc) {
-		pr_err("Memory indexed-count-remove failed, adding any removed LMBs\n");
+		bool rollback_dt_update = false;
 
+		pr_err("Memory indexed-count-remove failed, adding any removed LMBs\n");
 
 		for_each_drmem_lmb_in_range(lmb, start_lmb, end_lmb) {
 			if (!drmem_lmb_reserved(lmb))
 				continue;
-
-			rc = dlpar_add_lmb(lmb);
+			/* Since in removing path, dt is only updated if lmb == end_lmb */
+			if (lmb == end_lmb)
+				rollback_dt_update = true;
+			rc = dlpar_add_lmb(lmb, rollback_dt_update);
 			if (rc)
 				pr_err("Failed to add LMB, drc index %x\n",
 				       lmb->drc_index);
@@ -572,7 +595,7 @@ static inline int dlpar_memory_remove(struct pseries_hp_errorlog *hp_elog)
 {
 	return -EOPNOTSUPP;
 }
-static int dlpar_remove_lmb(struct drmem_lmb *lmb)
+static int dlpar_remove_lmb(struct drmem_lmb *lmb, bool dt_update)
 {
 	return -EOPNOTSUPP;
 }
@@ -591,10 +614,10 @@ static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index)
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
-static int dlpar_add_lmb(struct drmem_lmb *lmb)
+static int dlpar_add_lmb(struct drmem_lmb *lmb, bool dt_update)
 {
 	unsigned long block_sz;
-	int rc;
+	int rc, ret;
 
 	if (lmb->flags & DRCONF_MEM_ASSIGNED)
 		return -EINVAL;
@@ -607,6 +630,11 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
 
 	lmb_set_nid(lmb);
 	lmb->flags |= DRCONF_MEM_ASSIGNED;
+	if (dt_update) {
+		ret = drmem_update_dt();
+		if (ret)
+			pr_warn("%s fail to update dt, but continue\n", __func__);
+	}
 
 	block_sz = memory_block_size_bytes();
 
@@ -625,7 +653,11 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
 		invalidate_lmb_associativity_index(lmb);
 		lmb_clear_nid(lmb);
 		lmb->flags &= ~DRCONF_MEM_ASSIGNED;
-
+		if (dt_update) {
+			ret = drmem_update_dt();
+			if (ret)
+				pr_warn("%s fail to update dt during rollback, but continue\n", __func__);
+		}
 		__remove_memory(nid, base_addr, block_sz);
 	}
 
@@ -638,6 +670,7 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add)
 	int lmbs_available = 0;
 	int lmbs_added = 0;
 	int rc;
+	bool dt_update = false;
 
 	pr_info("Attempting to hot-add %d LMB(s)\n", lmbs_to_add);
 
@@ -664,7 +697,7 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add)
 		if (rc)
 			continue;
 
-		rc = dlpar_add_lmb(lmb);
+		rc = dlpar_add_lmb(lmb, dt_update);
 		if (rc) {
 			dlpar_release_drc(lmb->drc_index);
 			continue;
@@ -678,16 +711,23 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add)
 		lmbs_added++;
 		if (lmbs_added == lmbs_to_add)
 			break;
+		else if (lmbs_added == lmbs_to_add - 1)
+			dt_update = true;
 	}
 
 	if (lmbs_added != lmbs_to_add) {
+		bool rollback_dt_update = false;
+
 		pr_err("Memory hot-add failed, removing any added LMBs\n");
 
 		for_each_drmem_lmb(lmb) {
 			if (!drmem_lmb_reserved(lmb))
 				continue;
 
-			rc = dlpar_remove_lmb(lmb);
+			if (--lmbs_added == 0 && dt_update)
+				rollback_dt_update = true;
+
+			rc = dlpar_remove_lmb(lmb, rollback_dt_update);
 			if (rc)
 				pr_err("Failed to remove LMB, drc index %x\n",
 				       lmb->drc_index);
@@ -725,7 +765,7 @@ static int dlpar_memory_add_by_index(u32 drc_index)
 			lmb_found = 1;
 			rc = dlpar_acquire_drc(lmb->drc_index);
 			if (!rc) {
-				rc = dlpar_add_lmb(lmb);
+				rc = dlpar_add_lmb(lmb, true);
 				if (rc)
 					dlpar_release_drc(lmb->drc_index);
 			}
@@ -751,6 +791,7 @@ static int dlpar_memory_add_by_ic(u32 lmbs_to_add, u32 drc_index)
 	struct drmem_lmb *lmb, *start_lmb, *end_lmb;
 	int lmbs_available = 0;
 	int rc;
+	bool dt_update = false;
 
 	pr_info("Attempting to hot-add %u LMB(s) at index %x\n",
 		lmbs_to_add, drc_index);
@@ -781,7 +822,9 @@ static int dlpar_memory_add_by_ic(u32 lmbs_to_add, u32 drc_index)
 		if (rc)
 			break;
 
-		rc = dlpar_add_lmb(lmb);
+		if (lmb == end_lmb)
+			dt_update = true;
+		rc = dlpar_add_lmb(lmb, dt_update);
 		if (rc) {
 			dlpar_release_drc(lmb->drc_index);
 			break;
@@ -794,10 +837,14 @@ static int dlpar_memory_add_by_ic(u32 lmbs_to_add, u32 drc_index)
 		pr_err("Memory indexed-count-add failed, removing any added LMBs\n");
 
 		for_each_drmem_lmb_in_range(lmb, start_lmb, end_lmb) {
+			bool rollback_dt_update = false;
+
 			if (!drmem_lmb_reserved(lmb))
 				continue;
 
-			rc = dlpar_remove_lmb(lmb);
+			if (lmb == end_lmb)
+				rollback_dt_update = true;
+			rc = dlpar_remove_lmb(lmb, rollback_dt_update);
 			if (rc)
 				pr_err("Failed to remove LMB, drc index %x\n",
 				       lmb->drc_index);
@@ -877,9 +924,6 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
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
