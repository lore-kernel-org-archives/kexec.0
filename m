Return-path: <kexec-bounces@lists.infradead.org>
Received: from tyo200.gate.nec.co.jp ([210.143.35.50])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IlHf7-0002wY-Hu
	for kexec@lists.infradead.org; Fri, 26 Oct 2007 06:23:16 +0100
Received: from tyo202.gate.nec.co.jp ([10.7.69.202])
	by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l9Q5L3lR029854
	for <kexec@lists.infradead.org>; Fri, 26 Oct 2007 14:21:03 +0900 (JST)
Message-Id: <472178DE.9080409@mxs.nes.nec.co.jp>
Date: Fri, 26 Oct 2007 14:19:26 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: [PATCH] Dump filtering supports x86_64 sparsemem(Re: Linux
	v2.6.24-rc1)
References: <alpine.LFD.0.999.0710232057080.30120@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.0.999.0710232057080.30120@woody.linux-foundation.org>
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
To: lkml <linux-kernel@vger.kernel.org>
Cc: kexec-ml <kexec@lists.infradead.org>


Hi,

This patch adds the symbol "init_level4_pgt" to the vmcoreinfo data so
that makedumpfile (dump filtering command) supports x86_64 sparsemem 
kernel of linux-2.6.24.

makedumpfile creates a small dumpfile by excluding unnecessary pages for
the analysis. It checks attributes in page structures and distinguishes
necessary pages and unnecessary ones. To check them, makedumpfile gets
the vmcoreinfo data which has the minimum debugging information only for
dump filtering.

For older x86_64 kernel (linux-2.6.23 or before), makedumpfile translates
the virtual address of page structure into physical address by subtracting
PAGE_OFFSET from virtual address, but this translation isn't effective for
linux-2.6.24 sparsemem kernel, because its page structures are in virtual
memmap area. makedumpfile should translate their virtual address by 4-levels
paging and it needs the symbol "init_level4_pgt".


Thanks
Ken'ichi Ohmichi 

---
Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>

---
diff -rpuN a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
--- a/arch/x86/kernel/machine_kexec_64.c	2007-10-26 11:05:34.000000000 +0900
+++ b/arch/x86/kernel/machine_kexec_64.c	2007-10-26 11:16:24.000000000 +0900
@@ -233,6 +233,8 @@ NORET_TYPE void machine_kexec(struct kim
 
 void arch_crash_save_vmcoreinfo(void)
 {
+	VMCOREINFO_SYMBOL(init_level4_pgt);
+
 #ifdef CONFIG_ARCH_DISCONTIGMEM_ENABLE
 	VMCOREINFO_SYMBOL(node_data);
 	VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
_





_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
