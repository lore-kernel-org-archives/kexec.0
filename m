Return-path: <kexec-bounces@lists.infradead.org>
Received: from serv1.oss.ntt.co.jp ([222.151.198.98])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IiTH9-0001Pn-Fy
	for kexec@lists.infradead.org; Thu, 18 Oct 2007 12:10:54 +0100
Subject: [PATCH] kmap leak fix for x86_32 kdump
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>
Date: Thu, 18 Oct 2007 20:10:16 +0900
Message-Id: <1192705816.23637.12.camel@sebastian.kern.oss.ntt.co.jp>
Mime-Version: 1.0
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
Errors-To: kexec-bounces@lists.infradead.org
To: vgoyal@in.ibm.com, hari@in.ibm.com
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org

copy_oldmem_page should not return leaving a page frame from the
previous kernel mapped.

Signed-off-by: Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>
---

diff -urNp linux-2.6.23-git13-orig/arch/x86/kernel/crash_dump_32.c linux-2.6.23-git13/arch/x86/kernel/crash_dump_32.c
--- linux-2.6.23-git13-orig/arch/x86/kernel/crash_dump_32.c	2007-10-18 19:42:54.000000000 +0900
+++ linux-2.6.23-git13/arch/x86/kernel/crash_dump_32.c	2007-10-18 19:49:25.000000000 +0900
@@ -47,6 +47,7 @@ ssize_t copy_oldmem_page(unsigned long p
 		if (!kdump_buf_page) {
 			printk(KERN_WARNING "Kdump: Kdump buffer page not"
 				" allocated\n");
+			kunmap_atomic(vaddr, KM_PTE0);
 			return -EFAULT;
 		}
 		copy_page(kdump_buf_page, vaddr);



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
