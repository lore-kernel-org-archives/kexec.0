Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JfBAd-0004UO-4j
	for kexec@lists.infradead.org; Fri, 28 Mar 2008 09:46:47 +0000
Message-Id: <47ECBE75.8040101@mxs.nes.nec.co.jp>
Date: Fri, 28 Mar 2008 18:46:29 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: [PATCH] add page flags values to vmcoreinfo
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0425116987=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kexec-ml <kexec@lists.infradead.org>, Christoph Lameter <clameter@sgi.com>

--===============0425116987==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi,

This patch adds some values of page flags to the vmcoreinfo data.

The vmcoreinfo data has the minimum debugging information only
for dump filtering. makedumpfile (dump filtering command) gets
it to distinguish unnecessary pages, and makedumpfile creates
a small dumpfile.

An old makedumpfile (v1.2.4 or before) had assumed some values
of page flags internally, and this implementation could not follow
the change of these values. For example, Christoph Lameter is
changing these values by the follwing patch:
http://lkml.org/lkml/2008/2/29/463

So a new makedumpfile (v1.2.5) came to need these values and I
created this patch to let the kernel output them. This patch is
for linux-2.6.25-rc7.

Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
---
diff -rpuN linux-2.6.25-rc6.org/kernel/kexec.c linux-2.6.25-rc6/kernel/kexec.c
--- linux-2.6.25-rc6.org/kernel/kexec.c	2008-03-19 12:12:54.000000000 +0900
+++ linux-2.6.25-rc6/kernel/kexec.c	2008-03-19 12:14:49.000000000 +0900
@@ -1406,6 +1406,9 @@ static int __init crash_save_vmcoreinfo_
 	VMCOREINFO_LENGTH(zone.free_area, MAX_ORDER);
 	VMCOREINFO_LENGTH(free_area.free_list, MIGRATE_TYPES);
 	VMCOREINFO_NUMBER(NR_FREE_PAGES);
+	VMCOREINFO_NUMBER(PG_lru);
+	VMCOREINFO_NUMBER(PG_private);
+	VMCOREINFO_NUMBER(PG_swapcache);
 
 	arch_crash_save_vmcoreinfo();
 




--===============0425116987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0425116987==--
