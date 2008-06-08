Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K5LDb-0003i0-VW
	for kexec@lists.infradead.org; Sun, 08 Jun 2008 13:46:12 +0000
Message-Id: <20080608134629.414662758@halley.suse.de>
Date: Sun, 08 Jun 2008 15:46:29 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: [patch 1/3] Add return value to reserve_bootmem_node()
References: <20080608134628.757299158@halley.suse.de>
Content-Disposition: inline; filename=reserve-bootmem-node-return
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

This patch changes the function reserve_bootmem_node() from void to int,
returning -ENOMEM if the allocation fails.


Signed-off-by: Bernhard Walle <bwalle@suse.de>;

---
 include/linux/bootmem.h |    2 +-
 mm/bootmem.c            |    6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

--- a/include/linux/bootmem.h
+++ b/include/linux/bootmem.h
@@ -94,7 +94,7 @@ extern unsigned long init_bootmem_node(p
 				       unsigned long freepfn,
 				       unsigned long startpfn,
 				       unsigned long endpfn);
-extern void reserve_bootmem_node(pg_data_t *pgdat,
+extern int reserve_bootmem_node(pg_data_t *pgdat,
 				 unsigned long physaddr,
 				 unsigned long size,
 				 int flags);
--- a/mm/bootmem.c
+++ b/mm/bootmem.c
@@ -442,15 +442,17 @@ unsigned long __init init_bootmem_node(p
 	return init_bootmem_core(pgdat, freepfn, startpfn, endpfn);
 }
 
-void __init reserve_bootmem_node(pg_data_t *pgdat, unsigned long physaddr,
+int __init reserve_bootmem_node(pg_data_t *pgdat, unsigned long physaddr,
 				 unsigned long size, int flags)
 {
 	int ret;
 
 	ret = can_reserve_bootmem_core(pgdat->bdata, physaddr, size, flags);
 	if (ret < 0)
-		return;
+		return -ENOMEM;
 	reserve_bootmem_core(pgdat->bdata, physaddr, size, flags);
+
+	return 0;
 }
 
 void __init free_bootmem_node(pg_data_t *pgdat, unsigned long physaddr,


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
