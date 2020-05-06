Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWSXg-0006oM-O5
 for kexec@lists.infradead.org; Wed, 06 May 2020 22:29:30 +0000
From: Rafael Aquini <aquini@redhat.com>
Subject: [PATCH] kernel: add panic_on_taint
Date: Wed,  6 May 2020 18:28:15 -0400
Message-Id: <20200506222815.274570-1-aquini@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: keescook@chromium.org, bhe@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org, kexec@lists.infradead.org, mcgrof@kernel.org, cai@lca.pw, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, dyoung@redhat.com

Analogously to the introduction of panic_on_warn, this patch
introduces a kernel option named panic_on_taint in order to
provide a simple and generic way to stop execution and catch
a coredump when the kernel gets tainted by any given taint flag.

This is useful for debugging sessions as it avoids rebuilding
the kernel to explicitly add calls to panic() or BUG() into
code sites that introduce the taint flags of interest.
Another, perhaps less frequent, use for this option would be
as a mean for assuring a security policy (in paranoid mode)
case where no single taint is allowed for the running system.

Suggested-by: Qian Cai <cai@lca.pw>
Signed-off-by: Rafael Aquini <aquini@redhat.com>
---
 Documentation/admin-guide/kdump/kdump.rst     | 10 ++++++
 .../admin-guide/kernel-parameters.txt         |  3 ++
 Documentation/admin-guide/sysctl/kernel.rst   | 36 +++++++++++++++++++
 include/linux/kernel.h                        |  1 +
 kernel/panic.c                                |  7 ++++
 kernel/sysctl.c                               |  7 ++++
 6 files changed, 64 insertions(+)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index ac7e131d2935..de3cf6d377cc 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -521,6 +521,16 @@ will cause a kdump to occur at the panic() call.  In cases where a user wants
 to specify this during runtime, /proc/sys/kernel/panic_on_warn can be set to 1
 to achieve the same behaviour.
 
+Trigger Kdump on add_taint()
+============================
+
+The kernel parameter, panic_on_taint, calls panic() from within add_taint(),
+whenever the value set in this bitmask matches with the bit flag being set
+by add_taint(). This will cause a kdump to occur at the panic() call.
+In cases where a user wants to specify this during runtime,
+/proc/sys/kernel/panic_on_taint can be set to a respective bitmask value
+to achieve the same behaviour.
+
 Contact
 =======
 
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7bc83f3d9bdf..75c02c1841b2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3404,6 +3404,9 @@
 	panic_on_warn	panic() instead of WARN().  Useful to cause kdump
 			on a WARN().
 
+	panic_on_taint	panic() when the kernel gets tainted, if the taint
+			flag being set matches with the assigned bitmask.
+
 	crash_kexec_post_notifiers
 			Run kdump after running panic-notifiers and dumping
 			kmsg. This only for the users who doubt kdump always
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 0d427fd10941..5b880102f2e3 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -658,6 +658,42 @@ a kernel rebuild when attempting to kdump at the location of a WARN().
 = ================================================
 
 
+panic_on_taint
+==============
+
+Bitmask for calling panic() in the add_taint() path.
+This is useful to avoid a kernel rebuild when attempting to
+kdump at the insertion of any specific TAINT flags.
+When set to 0 (default) add_taint() default behavior is maintained.
+
+====== ============================
+bit  0 TAINT_PROPRIETARY_MODULE
+bit  1 TAINT_FORCED_MODULE
+bit  2 TAINT_CPU_OUT_OF_SPEC
+bit  3 TAINT_FORCED_RMMOD
+bit  4 TAINT_MACHINE_CHECK
+bit  5 TAINT_BAD_PAGE
+bit  6 TAINT_USER
+bit  7 TAINT_DIE
+bit  8 TAINT_OVERRIDDEN_ACPI_TABLE
+bit  9 TAINT_WARN
+bit 10 TAINT_CRAP
+bit 11 TAINT_FIRMWARE_WORKAROUND
+bit 12 TAINT_OOT_MODULE
+bit 13 TAINT_UNSIGNED_MODULE
+bit 14 TAINT_SOFTLOCKUP
+bit 15 TAINT_LIVEPATCH
+bit 16 TAINT_AUX
+bit 17 TAINT_RANDSTRUCT
+bit 18 TAINT_FLAGS_COUNT
+====== ============================
+
+So, for example, to panic if the kernel gets tainted due to
+occurrences of bad pages and/or machine check errors, a user can::
+
+  echo 48 > /proc/sys/kernel/panic_on_taint
+
+
 panic_print
 ===========
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 9b7a8d74a9d6..518b9fd381c2 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -528,6 +528,7 @@ extern int panic_on_oops;
 extern int panic_on_unrecovered_nmi;
 extern int panic_on_io_nmi;
 extern int panic_on_warn;
+extern unsigned long panic_on_taint;
 extern int sysctl_panic_on_rcu_stall;
 extern int sysctl_panic_on_stackoverflow;
 
diff --git a/kernel/panic.c b/kernel/panic.c
index b69ee9e76cb2..e2d4771ab911 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -44,6 +44,7 @@ static int pause_on_oops_flag;
 static DEFINE_SPINLOCK(pause_on_oops_lock);
 bool crash_kexec_post_notifiers;
 int panic_on_warn __read_mostly;
+unsigned long panic_on_taint __read_mostly;
 
 int panic_timeout = CONFIG_PANIC_TIMEOUT;
 EXPORT_SYMBOL_GPL(panic_timeout);
@@ -434,6 +435,11 @@ void add_taint(unsigned flag, enum lockdep_ok lockdep_ok)
 		pr_warn("Disabling lock debugging due to kernel taint\n");
 
 	set_bit(flag, &tainted_mask);
+
+	if (unlikely(tainted_mask & panic_on_taint)) {
+		panic_on_taint = 0;
+		panic("panic_on_taint set ...");
+	}
 }
 EXPORT_SYMBOL(add_taint);
 
@@ -675,6 +681,7 @@ core_param(panic, panic_timeout, int, 0644);
 core_param(panic_print, panic_print, ulong, 0644);
 core_param(pause_on_oops, pause_on_oops, int, 0644);
 core_param(panic_on_warn, panic_on_warn, int, 0644);
+core_param(panic_on_taint, panic_on_taint, ulong, 0644);
 core_param(crash_kexec_post_notifiers, crash_kexec_post_notifiers, bool, 0644);
 
 static int __init oops_setup(char *s)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8a176d8727a3..b80ab660d727 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1217,6 +1217,13 @@ static struct ctl_table kern_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "panic_on_taint",
+		.data		= &panic_on_taint,
+		.maxlen		= sizeof(unsigned long),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+	},
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
 	{
 		.procname	= "timer_migration",
-- 
2.25.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
