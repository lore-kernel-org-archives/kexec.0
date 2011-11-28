Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by bombadil.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RV9mD-00070o-LT
 for kexec@lists.infradead.org; Mon, 28 Nov 2011 22:34:19 +0000
Date: Mon, 28 Nov 2011 14:34:02 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kexec: do not call kmsg_dump in crashdump
Message-Id: <20111128143402.ac7c3385.akpm@linux-foundation.org>
In-Reply-To: <m1aa7fq3wp.fsf@fess.ebiederm.org>
References: <20111125081959.GA2505@darkstar.nay.redhat.com>
 <m1aa7fq3wp.fsf@fess.ebiederm.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org

On Mon, 28 Nov 2011 14:27:02 -0800
ebiederm@xmission.com (Eric W. Biederman) wrote:

> Dave Young <dyoung@redhat.com> writes:
> 
> > mtd/ram oops dumper will make more functions envolved. In case crash kexec, 
> > we should avoid kmsg dumper to ensure crashdump success.
> >
> > kill kmsg_dump callback while crash dumping 
> 
> Agreed.
> 
> There is a similar?  Or possibly the same patch already queued in
> Andrews tree.

Below.

I've been sitting on this for ages because we couldn't seem to decide
whether it was desirable.  I think we decided a couple of weeks ago to
merge it so I have it planned for 3.3 unless we re-re-re-decide again.


From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: kexec: remove KMSG_DUMP_KEXEC

KMSG_DUMP_KEXEC is useless because we already save kernel messages inside
/proc/vmcore, and it is unsafe to allow modules to do other stuffs in a
crash dump scenario.

[akpm@linux-foundation.org: fix powerpc build]
Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>
Reported-by: Vivek Goyal <vgoyal@redhat.com>
Acked-by: Vivek Goyal <vgoyal@redhat.com>
Acked-by: Jarod Wilson <jarod@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/platforms/pseries/nvram.c |    1 -
 drivers/char/ramoops.c                 |    3 +--
 drivers/mtd/mtdoops.c                  |    3 +--
 include/linux/kmsg_dump.h              |    1 -
 kernel/kexec.c                         |    3 ---
 5 files changed, 2 insertions(+), 9 deletions(-)

diff -puN arch/powerpc/platforms/pseries/nvram.c~kexec-remove-kmsg_dump_kexec arch/powerpc/platforms/pseries/nvram.c
--- a/arch/powerpc/platforms/pseries/nvram.c~kexec-remove-kmsg_dump_kexec
+++ a/arch/powerpc/platforms/pseries/nvram.c
@@ -636,7 +636,6 @@ static void oops_to_nvram(struct kmsg_du
 		/* These are almost always orderly shutdowns. */
 		return;
 	case KMSG_DUMP_OOPS:
-	case KMSG_DUMP_KEXEC:
 		break;
 	case KMSG_DUMP_PANIC:
 		panicking = true;
diff -puN drivers/char/ramoops.c~kexec-remove-kmsg_dump_kexec drivers/char/ramoops.c
--- a/drivers/char/ramoops.c~kexec-remove-kmsg_dump_kexec
+++ a/drivers/char/ramoops.c
@@ -83,8 +83,7 @@ static void ramoops_do_dump(struct kmsg_
 	struct timeval timestamp;
 
 	if (reason != KMSG_DUMP_OOPS &&
-	    reason != KMSG_DUMP_PANIC &&
-	    reason != KMSG_DUMP_KEXEC)
+	    reason != KMSG_DUMP_PANIC)
 		return;
 
 	/* Only dump oopses if dump_oops is set */
diff -puN drivers/mtd/mtdoops.c~kexec-remove-kmsg_dump_kexec drivers/mtd/mtdoops.c
--- a/drivers/mtd/mtdoops.c~kexec-remove-kmsg_dump_kexec
+++ a/drivers/mtd/mtdoops.c
@@ -308,8 +308,7 @@ static void mtdoops_do_dump(struct kmsg_
 	char *dst;
 
 	if (reason != KMSG_DUMP_OOPS &&
-	    reason != KMSG_DUMP_PANIC &&
-	    reason != KMSG_DUMP_KEXEC)
+	    reason != KMSG_DUMP_PANIC)
 		return;
 
 	/* Only dump oopses if dump_oops is set */
diff -puN include/linux/kmsg_dump.h~kexec-remove-kmsg_dump_kexec include/linux/kmsg_dump.h
--- a/include/linux/kmsg_dump.h~kexec-remove-kmsg_dump_kexec
+++ a/include/linux/kmsg_dump.h
@@ -18,7 +18,6 @@
 enum kmsg_dump_reason {
 	KMSG_DUMP_OOPS,
 	KMSG_DUMP_PANIC,
-	KMSG_DUMP_KEXEC,
 	KMSG_DUMP_RESTART,
 	KMSG_DUMP_HALT,
 	KMSG_DUMP_POWEROFF,
diff -puN kernel/kexec.c~kexec-remove-kmsg_dump_kexec kernel/kexec.c
--- a/kernel/kexec.c~kexec-remove-kmsg_dump_kexec
+++ a/kernel/kexec.c
@@ -32,7 +32,6 @@
 #include <linux/console.h>
 #include <linux/vmalloc.h>
 #include <linux/swap.h>
-#include <linux/kmsg_dump.h>
 #include <linux/syscore_ops.h>
 
 #include <asm/page.h>
@@ -1094,8 +1093,6 @@ void crash_kexec(struct pt_regs *regs)
 		if (kexec_crash_image) {
 			struct pt_regs fixed_regs;
 
-			kmsg_dump(KMSG_DUMP_KEXEC);
-
 			crash_setup_regs(&fixed_regs, regs);
 			crash_save_vmcoreinfo();
 			machine_crash_shutdown(&fixed_regs);
_


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
