Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Isr0w-0007cn-7M
	for kexec@lists.infradead.org; Thu, 15 Nov 2007 21:33:09 -0500
Message-Id: <473D0176.6090702@mxs.nes.nec.co.jp>
Date: Fri, 16 Nov 2007 11:33:26 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: [PATCH 5/5] Add the array length of "free_list" for filtering free
	pages
References: <473CFE14.3010400@mxs.nes.nec.co.jp>
In-Reply-To: <473CFE14.3010400@mxs.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0554134197=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: lkml <linux-kernel@vger.kernel.org>, kexec-ml <kexec@lists.infradead.org>

--===============0554134197==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


This patch adds the array length of "free_area.free_list" to the vmcoreinfo
data so that makedumpfile (dump filtering command) can exclude all free pages
in linux-2.6.24.

makedumpfile creates a small dumpfile by excluding unnecessary pages for the
analysis. To distinguish unnecessary pages, makedumpfile gets the vmcoreinfo
data which has the minimum debugging information only for dump filtering.

In 2.6.24-rc1 or later, the free_area.free_list is an array which has one list
for each migrate types instead of a single list. makedumpfile needs the array
length of "free_area.free_list" and the vmcoreinfo data should contain it.


Signed-off-by: Huang Ying <ying.huang@intel.com>
Tested-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
---
diff -rpuN a/kernel/kexec.c b/kernel/kexec.c
--- a/kernel/kexec.c	2007-11-12 11:15:26.000000000 +0900
+++ b/kernel/kexec.c	2007-11-12 11:16:09.000000000 +0900
@@ -1404,6 +1404,7 @@ static int __init crash_save_vmcoreinfo_
 	VMCOREINFO_OFFSET(list_head, next);
 	VMCOREINFO_OFFSET(list_head, prev);
 	VMCOREINFO_LENGTH(zone.free_area, MAX_ORDER);
+	VMCOREINFO_LENGTH(free_area.free_list, MIGRATE_TYPES);
 	VMCOREINFO_NUMBER(NR_FREE_PAGES);
 
 	arch_crash_save_vmcoreinfo();
_



--===============0554134197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0554134197==--
