Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KqKDv-0008TY-Dw
	for kexec@lists.infradead.org; Thu, 16 Oct 2008 04:12:32 +0000
Message-ID: <48F6BECE.60500@mxs.nes.nec.co.jp>
Date: Thu, 16 Oct 2008 13:10:54 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: [PATCH] Add vmlist.addr to vmcoreinfo for x86 vmalloc translation.
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2143002087=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Worth, Kevin" <kevin.worth@hp.com>, kexec-ml <kexec@lists.infradead.org>

--===============2143002087==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Andrew,

This patch adds both symbol 'vmlist' and offset 'vm_struct.addr' to
the vmcoreinfo[1] data for i386 vmalloc translation.

makedumpfile[2] needs VMALLOC_START value for distinguishing a vmalloc
address or not, because it should choose suitable translation method.
If applying this patch, makedumpfile will be able to take VMALLOC_START
value from 'vmlist.addr'.

This patch is for linux-2.6.27 and its CodingStyle have been checked by
checkpatch.pl.


vmcoreinfo[1]:
The vmcoreinfo data has the minimum debugging information only for dump
filtering. makedumpfile[2] uses it to distinguish unnecessary pages and
creates a small dumpfile.

makedumpfile[2]:
dump filtering command
https://sourceforge.net/projects/makedumpfile/


Thanks
Ken'ichi Ohmichi

Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
---
--- a/kernel/kexec.c	2008-10-10 07:13:53.000000000 +0900
+++ b/kernel/kexec.c	2008-10-15 13:12:50.000000000 +0900
@@ -1371,6 +1371,7 @@ static int __init crash_save_vmcoreinfo_
 	VMCOREINFO_SYMBOL(node_online_map);
 	VMCOREINFO_SYMBOL(swapper_pg_dir);
 	VMCOREINFO_SYMBOL(_stext);
+	VMCOREINFO_SYMBOL(vmlist);
 
 #ifndef CONFIG_NEED_MULTIPLE_NODES
 	VMCOREINFO_SYMBOL(mem_map);
@@ -1406,6 +1407,7 @@ static int __init crash_save_vmcoreinfo_
 	VMCOREINFO_OFFSET(free_area, free_list);
 	VMCOREINFO_OFFSET(list_head, next);
 	VMCOREINFO_OFFSET(list_head, prev);
+	VMCOREINFO_OFFSET(vm_struct, addr);
 	VMCOREINFO_LENGTH(zone.free_area, MAX_ORDER);
 	VMCOREINFO_LENGTH(free_area.free_list, MIGRATE_TYPES);
 	VMCOREINFO_NUMBER(NR_FREE_PAGES);
_


--===============2143002087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============2143002087==--
