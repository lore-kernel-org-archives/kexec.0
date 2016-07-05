Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bKOfC-000421-Uo
 for kexec@lists.infradead.org; Tue, 05 Jul 2016 11:37:16 +0000
Subject: [V3 PATCH 2/2] kexec: Use core_param for crash_kexec_post_notifiers
 boot option
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Tue, 05 Jul 2016 20:33:27 +0900
Message-ID: <20160705113327.5864.43139.stgit@softrs>
In-Reply-To: <20160705113323.5864.66834.stgit@softrs>
References: <20160705113323.5864.66834.stgit@softrs>
MIME-Version: 1.0
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
To: Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, Michal Hocko <mhocko@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Tejun Heo <tj@kernel.org>, Daniel Walker <dwalker@fifo99.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>

crash_kexec_post_notifiers ia a boot option which controls whether
the 1st kernel calls panic notifiers or not before booting the 2nd
kernel.  However, there is no need to limit it to being modifiable
only at boot time.  So, use core_param instead of early_param.

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
---
 kernel/panic.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index da8062d2..0d0edeb 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -134,6 +134,7 @@ void panic(const char *fmt, ...)
 	long i, i_next = 0;
 	int state = 0;
 	int old_cpu, this_cpu;
+	bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;
 
 	/*
 	 * Disable local interrupts. This will prevent panic_smp_self_stop
@@ -186,7 +187,7 @@ void panic(const char *fmt, ...)
 	 *
 	 * Bypass the panic_cpu check and call __crash_kexec directly.
 	 */
-	if (!crash_kexec_post_notifiers) {
+	if (!_crash_kexec_post_notifiers) {
 		printk_nmi_flush_on_panic();
 		__crash_kexec(NULL);
 	}
@@ -212,7 +213,7 @@ void panic(const char *fmt, ...)
 	 *
 	 * Bypass the panic_cpu check and call __crash_kexec directly.
 	 */
-	if (crash_kexec_post_notifiers)
+	if (_crash_kexec_post_notifiers)
 		__crash_kexec(NULL);
 
 	bust_spinlocks(0);
@@ -592,13 +593,7 @@ EXPORT_SYMBOL(__stack_chk_fail);
 core_param(panic, panic_timeout, int, 0644);
 core_param(pause_on_oops, pause_on_oops, int, 0644);
 core_param(panic_on_warn, panic_on_warn, int, 0644);
-
-static int __init setup_crash_kexec_post_notifiers(char *s)
-{
-	crash_kexec_post_notifiers = true;
-	return 0;
-}
-early_param("crash_kexec_post_notifiers", setup_crash_kexec_post_notifiers);
+core_param(crash_kexec_post_notifiers, crash_kexec_post_notifiers, bool, 0644);
 
 static int __init oops_setup(char *s)
 {



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
