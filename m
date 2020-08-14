Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6YJt-0004Ok-DT
 for kexec@lists.infradead.org; Fri, 14 Aug 2020 11:56:26 +0000
Message-Id: <20200814115512.041422402@linutronix.de>
Date: Fri, 14 Aug 2020 12:19:34 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 1/2] timekeeping: Utilize local_clock() for NMI safe
 timekeeper during early boot
References: <20200814101933.574326079@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline;
 filename*0*=utf-8''timekeeping--Utilize-local_clock---for-NMI-safe-timekeepe; 
 filename*1*=r-during-early-boot.patch
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: Prarit Bhargava <prarit@redhat.com>, Petr Mladek <pmladek@suse.com>, Baoquan He <bhe@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kexec@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, John Stultz <john.stultz@linaro.org>, Orson Zhai <orsonzhai@gmail.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

During early boot the NMI safe timekeeper returns 0 until the first
clocksource becomes available.

This prevents it from being used for printk or other facilities which today
use sched clock. sched clock can be available way before timekeeping is
initialized.

The obvious workaround for this is to utilize the early sched clock in the
default dummy clock read function until a clocksource becomes available.

After switching to the clocksource clock MONOTONIC and BOOTTIME will not
jump because the timekeeping_init() bases clock MONOTONIC on sched clock
and the offset between clock MONOTONIC and BOOTTIME is zero during boot.

Clock REALTIME cannot provide useful timestamps during early boot up to
the point where a persistent clock becomes available, which is either in
timekeeping_init() or later when the RTC driver which might depend on I2C
or other subsystems is initialized.

There is a minor difference to sched_clock() vs. suspend/resume. As the
timekeeper clock source might not be accessible during suspend, after
timekeeping_suspend() timestamps freeze up to the point where
timekeeping_resume() is invoked. OTOH this is true for some sched clock
implementations as well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timekeeping.c |   33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -53,6 +53,9 @@ static struct {
 static DEFINE_RAW_SPINLOCK(timekeeper_lock);
 static struct timekeeper shadow_timekeeper;
 
+/* flag for if timekeeping is suspended */
+int __read_mostly timekeeping_suspended;
+
 /**
  * struct tk_fast - NMI safe timekeeper
  * @seq:	Sequence counter for protecting updates. The lowest bit
@@ -72,26 +75,40 @@ static u64 cycles_at_suspend;
 
 static u64 dummy_clock_read(struct clocksource *cs)
 {
-	return cycles_at_suspend;
+	if (timekeeping_suspended)
+		return cycles_at_suspend;
+	return local_clock();
 }
 
 static struct clocksource dummy_clock = {
 	.read = dummy_clock_read,
 };
 
+/*
+ * Boot time initialization which allows local_clock() to be utilized
+ * during early boot when clocksources are not available. local_clock()
+ * returns nanoseconds already so no conversion is required, hence mult=1
+ * and shift=0. When the first proper clocksource is installed then
+ * the fast time keepers are updated with the correct values.
+ */
+#define FAST_TK_INIT						\
+	{							\
+		.clock		= &dummy_clock,			\
+		.mask		= CLOCKSOURCE_MASK(64),		\
+		.mult		= 1,				\
+		.shift		= 0,				\
+	}
+
 static struct tk_fast tk_fast_mono ____cacheline_aligned = {
-	.base[0] = { .clock = &dummy_clock, },
-	.base[1] = { .clock = &dummy_clock, },
+	.base[0] = FAST_TK_INIT,
+	.base[1] = FAST_TK_INIT,
 };
 
 static struct tk_fast tk_fast_raw  ____cacheline_aligned = {
-	.base[0] = { .clock = &dummy_clock, },
-	.base[1] = { .clock = &dummy_clock, },
+	.base[0] = FAST_TK_INIT,
+	.base[1] = FAST_TK_INIT,
 };
 
-/* flag for if timekeeping is suspended */
-int __read_mostly timekeeping_suspended;
-
 static inline void tk_normalize_xtime(struct timekeeper *tk)
 {
 	while (tk->tkr_mono.xtime_nsec >= ((u64)NSEC_PER_SEC << tk->tkr_mono.shift)) {


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
