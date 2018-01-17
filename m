Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ebfgx-0005VN-W7
 for kexec@lists.infradead.org; Wed, 17 Jan 2018 04:51:18 +0000
Date: Wed, 17 Jan 2018 12:50:57 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH] print kdump kernel loaded status in stack dump
Message-ID: <20180117045057.GA4994@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: pmladek@suse.com, sergey.senozhatsky@gmail.com, rostedt@goodmis.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, kexec@lists.infradead.org

It is useful to print kdump kernel loaded status in dump_stack() 
especially when panic happens so that we can  differenciate 
kdump kernel early hang and a normal panic in a bug report.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 kernel/printk/printk.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-x86.orig/kernel/printk/printk.c
+++ linux-x86/kernel/printk/printk.c
@@ -48,6 +48,7 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
+#include <linux/kexec.h>
 
 #include <linux/uaccess.h>
 #include <asm/sections.h>
@@ -3127,6 +3128,8 @@ void dump_stack_print_info(const char *l
 	if (dump_stack_arch_desc_str[0] != '\0')
 		printk("%sHardware name: %s\n",
 		       log_lvl, dump_stack_arch_desc_str);
+	if (kexec_crash_loaded())
+		printk("%skdump kernel loaded\n", log_lvl);
 
 	print_worker_info(log_lvl, current);
 }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
