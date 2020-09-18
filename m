Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJ726-0003Ja-Nu
 for kexec@lists.infradead.org; Fri, 18 Sep 2020 03:25:59 +0000
Date: Fri, 18 Sep 2020 11:25:46 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH] Only allow to set crash_kexec_post_notifiers on boot time
Message-ID: <20200918032546.GA4180@dhcp-128-65.nay.redhat.com>
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
To: Andrew Morton <akpm@linux-foundation.org>, bhe@redhat.com, Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org

crash_kexec_post_notifiers enables running various panic notifier
before kdump kernel booting. This increases risks of kdump failure.
It is well documented in kernel-parameters.txt. We do not suggest
people to enable it together with kdump unless he/she is really sure.
This is also not suggested to be enabled by default when users are
not aware in distributions.

But unfortunately it is enabled by default in systemd, see below
discussions in a systemd report, we can not convince systemd to change
it:
https://github.com/systemd/systemd/issues/16661

Actually we have got reports about kdump kernel hangs in both s390x
and powerpcle cases caused by the systemd change,  also some x86 cases
could also be caused by the same (although that is in Hyper-V code
instead of systemd, that need to be addressed separately).

Thus to avoid the auto enablement here just disable the param writable
permission in sysfs.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 kernel/panic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index aef8872ba843..bea44fc4eb3b 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -695,7 +695,7 @@ core_param(panic, panic_timeout, int, 0644);
 core_param(panic_print, panic_print, ulong, 0644);
 core_param(pause_on_oops, pause_on_oops, int, 0644);
 core_param(panic_on_warn, panic_on_warn, int, 0644);
-core_param(crash_kexec_post_notifiers, crash_kexec_post_notifiers, bool, 0644);
+core_param(crash_kexec_post_notifiers, crash_kexec_post_notifiers, bool, 0444);
 
 static int __init oops_setup(char *s)
 {
-- 
2.26.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
