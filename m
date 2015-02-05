Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwym04.jp.fujitsu.com ([211.128.242.43])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YJIIY-0000sM-Ij
 for kexec@lists.infradead.org; Thu, 05 Feb 2015 09:00:31 +0000
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by kw-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id E877BAC063A
 for <kexec@lists.infradead.org>; Thu,  5 Feb 2015 18:00:02 +0900 (JST)
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 9640EE08002
 for <kexec@lists.infradead.org>; Thu,  5 Feb 2015 18:00:02 +0900 (JST)
Date: Thu, 05 Feb 2015 17:59:43 +0900 (JST)
Message-Id: <20150205.175943.381586636.d.hatayama@jp.fujitsu.com>
Subject: [PATCH] kernel/panic/kexec: fix "crash_kexec_post_notifiers"
 option issue in oops path
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Mime-Version: 1.0
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
To: ebiederm@xmission.com, vgoyal@redhat.com
Cc: masami.hiramatsu.pt@hitachi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

The commit f06e5153f4ae2e2f3b0300f0e260e40cb7fefd45 introduced
"crash_kexec_post_notifiers" kernel boot option, which toggles
wheather panic() calls crash_kexec() before or after panic_notifiers
and dump kmsg.

The problem is that the commit overlooks panic_on_oops kernel boot
option. If it is enabled, crash_kexec() is called directly without
going through panic() in oops path.

To fix this issue, this patch adds a check to
"crash_kexec_post_notifiers" in the condition of kexec_should_crash().

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 include/linux/kernel.h | 3 +++
 kernel/kexec.c         | 2 ++
 kernel/panic.c         | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 64ce58b..f47379f 100644
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
index 9a8a01a..0ecf252 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -84,6 +84,8 @@ struct resource crashk_low_res = {
 
 int kexec_should_crash(struct task_struct *p)
 {
+	if (crash_kexec_post_notifiers)
+		return 0;
 	if (in_interrupt() || !p->pid || is_global_init(p) || panic_on_oops)
 		return 1;
 	return 0;
diff --git a/kernel/panic.c b/kernel/panic.c
index 4d8d6f9..6582546 100644
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
