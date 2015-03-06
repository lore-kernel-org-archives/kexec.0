Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwkm02.jp.fujitsu.com ([202.219.69.169])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YTvBE-0006Si-LX
 for kexec@lists.infradead.org; Fri, 06 Mar 2015 16:32:53 +0000
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
 by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 3FD0EAC0D54
 for <kexec@lists.infradead.org>;
 Sat,  7 Mar 2015 01:32:27 +0900 (JST)
Message-ID: <54F9D645.2050008@jp.fujitsu.com>
Date: Sat, 07 Mar 2015 01:31:01 +0900
From: =?ISO-2022-JP?B?IkhhdGF5YW1hLCBEYWlzdWtlLxskQkgqOzMbKEIgGyRCQmdKZRsoQg==?=
 =?ISO-2022-JP?B?Ig==?= <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH v2] kernel/panic/kexec: fix "crash_kexec_post_notifiers" option
 issue in oops path
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
To: ebiederm@xmission.com, Vivek Goyal <vgoyal@redhat.com>
Cc: masami.hiramatsu.pt@hitachi.com, hidehiro.kawai.ez@hitachi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bhe@redhat.com

The commit f06e5153f4ae2e2f3b0300f0e260e40cb7fefd45 introduced
"crash_kexec_post_notifiers" kernel boot option, which toggles
wheather panic() calls crash_kexec() before panic_notifiers and dump
kmsg or after.

The problem is that the commit overlooks panic_on_oops kernel boot
option. If it is enabled, crash_kexec() is called directly without
going through panic() in oops path.

To fix this issue, this patch adds a check to
"crash_kexec_post_notifiers" in the condition of kexec_should_crash().

Also, put a comment in kexec_should_crash() to explain not obvious
things on this patch.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Acked-by: Baoquan He <bhe@redhat.com>
Tested-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Reviewed-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
---
 include/linux/kernel.h |  3 +++
 kernel/kexec.c         | 11 +++++++++++
 kernel/panic.c         |  2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d6d630d..07483c7 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -426,6 +426,9 @@ extern int panic_on_unrecovered_nmi;
 extern int panic_on_io_nmi;
 extern int panic_on_warn;
 extern int sysctl_panic_on_stackoverflow;
+
+extern bool crash_kexec_post_notifiers;
+
 /*
  * Only to be used by arch init code. If the user over-wrote the default
  * CONFIG_PANIC_TIMEOUT, honor it.
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 38c25b1..5bf6077 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -84,6 +84,17 @@ struct resource crashk_low_res = {

 int kexec_should_crash(struct task_struct *p)
 {
+	/*
+	 * If crash_kexec_post_notifiers is enabled, don't run
+	 * crash_kexec() here yet, which must be run after panic
+	 * notifiers in panic().
+	 */
+	if (crash_kexec_post_notifiers)
+		return 0;
+	/*
+	 * There are 4 panic() calls in do_exit() path, each of which
+	 * calls corresponds to each of these 4 conditions.
+	 */
 	if (in_interrupt() || !p->pid || is_global_init(p) || panic_on_oops)
 		return 1;
 	return 0;
diff --git a/kernel/panic.c b/kernel/panic.c
index 8136ad7..79ca912 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -32,7 +32,7 @@ static unsigned long tainted_mask;
 static int pause_on_oops;
 static int pause_on_oops_flag;
 static DEFINE_SPINLOCK(pause_on_oops_lock);
-static bool crash_kexec_post_notifiers;
+bool crash_kexec_post_notifiers;
 int panic_on_warn __read_mostly;

 int panic_timeout = CONFIG_PANIC_TIMEOUT;
-- 
1.9.3



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
