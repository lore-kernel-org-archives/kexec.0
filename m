Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IUdgl-0007Ta-Ms
	for kexec@lists.infradead.org; Mon, 10 Sep 2007 08:28:11 +0100
Subject: [PATCH 3/3] [-mm patch] Use the existing ia64_tpa() instead of asm
	code
In-reply-to: <20070910162305oomichi@mail.jp.nec.com>
Message-Id: <20070910162813oomichi@mail.jp.nec.com>
References: <20070910162305oomichi@mail.jp.nec.com>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Mon, 10 Sep 2007 16:28:13 +0900
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>


[3/3] Use the existing ia64_tpa() instead of asm code.


Thanks
Ken'ichi Ohmichi

---
Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>

---
diff -rpuN a/arch/ia64/kernel/machine_kexec.c b/arch/ia64/kernel/machine_kexec.c
--- a/arch/ia64/kernel/machine_kexec.c	2007-09-10 23:30:33.000000000 +0900
+++ b/arch/ia64/kernel/machine_kexec.c	2007-09-10 23:31:37.000000000 +0900
@@ -21,6 +21,7 @@
 #include <asm/setup.h>
 #include <asm/delay.h>
 #include <asm/meminit.h>
+#include <asm/processor.h>
 
 typedef NORET_TYPE void (*relocate_new_kernel_t)(
 					unsigned long indirection_page,
@@ -149,9 +150,6 @@ void arch_crash_save_vmcoreinfo(void)
 
 unsigned long paddr_vmcoreinfo_note(void)
 {
-	unsigned long vaddr, paddr;
-	vaddr = (unsigned long)(char *)&vmcoreinfo_note;
-	asm volatile ("tpa %0 = %1" : "=r"(paddr) : "r"(vaddr) : "memory");
-	return paddr;
+	return ia64_tpa((unsigned long)(char *)&vmcoreinfo_note);
 }
 
_

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
