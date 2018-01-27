Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1efHqF-0006do-Sy
 for kexec@lists.infradead.org; Sat, 27 Jan 2018 04:11:49 +0000
Date: Sat, 27 Jan 2018 12:11:29 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH V2] print kdump kernel loaded status in stack dump
Message-ID: <20180127041129.GA29016@dhcp-128-65.nay.redhat.com>
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
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@linux.intel.com>, sergey.senozhatsky@gmail.com
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

It is useful to print kdump kernel loaded status in dump_stack() 
especially when panic happens so that we can differenciate 
kdump kernel early hang and a normal panic in a bug report.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
[v1 -> v2] merge the status in other line as Andi Kleen suggested
 kernel/printk/printk.c |    3 +++
---
 kernel/printk/printk.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- linux-x86.orig/kernel/printk/printk.c
+++ linux-x86/kernel/printk/printk.c
@@ -48,6 +48,7 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
+#include <linux/kexec.h>
 
 #include <linux/uaccess.h>
 #include <asm/sections.h>
@@ -3118,9 +3119,11 @@ void __init dump_stack_set_arch_desc(con
  */
 void dump_stack_print_info(const char *log_lvl)
 {
-	printk("%sCPU: %d PID: %d Comm: %.20s %s %s %.*s\n",
+	printk("%sCPU: %d PID: %d Comm: %.20s %s%s %s %.*s\n",
 	       log_lvl, raw_smp_processor_id(), current->pid, current->comm,
-	       print_tainted(), init_utsname()->release,
+	       kexec_crash_loaded() ? "Kdump: loaded " : "",
+	       print_tainted(),
+	       init_utsname()->release,
 	       (int)strcspn(init_utsname()->version, " "),
 	       init_utsname()->version);
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
