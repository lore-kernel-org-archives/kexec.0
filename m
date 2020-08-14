Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6YJt-0004Oo-B4
 for kexec@lists.infradead.org; Fri, 14 Aug 2020 11:56:28 +0000
Message-Id: <20200814115512.159981360@linutronix.de>
Date: Fri, 14 Aug 2020 12:19:35 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 2/2] timekeeping: Provide multi-timestamp accessor to NMI safe
 timekeeper
References: <20200814101933.574326079@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline;
 filename="printk_Change_timestamp_to_triplet_as_mono_boot_and_real.patch"
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

printk wants to store various timestamps (MONOTONIC, REALTIME, BOOTTIME) to
make correlation of dmesg from several systems easier.

Provide an interface to retrieve all three timestamps in one go.

There are some caveats:

1) Boot time and late sleep time injection

  Boot time is a racy access on 32bit systems if the sleep time injection
  happens late during resume and not in timekeeping_resume(). That could be
  avoided by expanding struct tk_read_base with boot offset for 32bit and
  adding more overhead to the update. As this is a hard to observe once per
  resume event which can be filtered with reasonable effort using the
  accurate mono/real timestamps, it's probably not worth the trouble.

  Aside of that it might be possible on 32 and 64 bit to observe the
  following when the sleep time injection happens late:

  CPU 0				         CPU 1
  timekeeping_resume()
  ktime_get_fast_timestamps()
    mono, real = __ktime_get_real_fast()
  					 inject_sleep_time()
  					   update boot offset
  	boot = mono + bootoffset;
  
  That means that boot time already has the sleep time adjustment, but
  real time does not. On the next readout both are in sync again.
  
  Preventing this for 64bit is not really feasible without destroying the
  careful cache layout of the timekeeper because the sequence count and
  struct tk_read_base would then need two cache lines instead of one.

2) Suspend/resume timestamps

   Access to the time keeper clock source is disabled accross the innermost
   steps of suspend/resume. The accessors still work, but the timestamps
   are frozen until time keeping is resumed which happens very early.

   For regular suspend/resume there is no observable difference vs. sched
   clock, but it might affect some of the nasty low level debug printks.

   OTOH, access to sched clock is not guaranteed accross suspend/resume on
   all systems either so it depends on the hardware in use.

   If that turns out to be a real problem then this could be mitigated by
   using sched clock in a similar way as during early boot. But it's not as
   trivial as on early boot because it needs some careful protection
   against the clock monotonic timestamp jumping backwards on resume.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/timekeeping.h |   15 ++++++++
 kernel/time/timekeeping.c   |   76 +++++++++++++++++++++++++++++++++++++-------
 2 files changed, 80 insertions(+), 11 deletions(-)

--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -222,6 +222,18 @@ extern bool timekeeping_rtc_skipresume(v
 
 extern void timekeeping_inject_sleeptime64(const struct timespec64 *delta);
 
+/*
+ * struct ktime_timestanps - Simultaneous mono/boot/real timestamps
+ * @mono:	Monotonic timestamp
+ * @boot:	Boottime timestamp
+ * @real:	Realtime timestamp
+ */
+struct ktime_timestamps {
+	u64		mono;
+	u64		boot;
+	u64		real;
+};
+
 /**
  * struct system_time_snapshot - simultaneous raw/real time capture with
  *				 counter value
@@ -280,6 +292,9 @@ extern int get_device_system_crosststamp
  */
 extern void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot);
 
+/* NMI safe mono/boot/realtime timestamps */
+extern void ktime_get_fast_timestamps(struct ktime_timestamps *snap);
+
 /*
  * Persistent clock related interfaces
  */
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -527,29 +527,29 @@ u64 notrace ktime_get_boot_fast_ns(void)
 }
 EXPORT_SYMBOL_GPL(ktime_get_boot_fast_ns);
 
-
 /*
  * See comment for __ktime_get_fast_ns() vs. timestamp ordering
  */
-static __always_inline u64 __ktime_get_real_fast_ns(struct tk_fast *tkf)
+static __always_inline u64 __ktime_get_real_fast(struct tk_fast *tkf, u64 *mono)
 {
 	struct tk_read_base *tkr;
+	u64 basem, baser, delta;
 	unsigned int seq;
-	u64 now;
 
 	do {
 		seq = raw_read_seqcount_latch(&tkf->seq);
 		tkr = tkf->base + (seq & 0x01);
-		now = ktime_to_ns(tkr->base_real);
+		basem = ktime_to_ns(tkr->base);
+		baser = ktime_to_ns(tkr->base_real);
 
-		now += timekeeping_delta_to_ns(tkr,
-				clocksource_delta(
-					tk_clock_read(tkr),
-					tkr->cycle_last,
-					tkr->mask));
+		delta = timekeeping_delta_to_ns(tkr,
+				clocksource_delta(tk_clock_read(tkr),
+				tkr->cycle_last, tkr->mask));
 	} while (read_seqcount_retry(&tkf->seq, seq));
 
-	return now;
+	if (mono)
+		*mono = basem + delta;
+	return baser + delta;
 }
 
 /**
@@ -557,11 +557,65 @@ static __always_inline u64 __ktime_get_r
  */
 u64 ktime_get_real_fast_ns(void)
 {
-	return __ktime_get_real_fast_ns(&tk_fast_mono);
+	return __ktime_get_real_fast(&tk_fast_mono, NULL);
 }
 EXPORT_SYMBOL_GPL(ktime_get_real_fast_ns);
 
 /**
+ * ktime_get_fast_timestamps: - NMI safe timestamps
+ * @snapshot:	Pointer to timestamp storage
+ *
+ * Stores clock monotonic, boottime and realtime timestamps.
+ *
+ * Boot time is a racy access on 32bit systems if the sleep time injection
+ * happens late during resume and not in timekeeping_resume(). That could
+ * be avoided by expanding struct tk_read_base with boot offset for 32bit
+ * and adding more overhead to the update. As this is a hard to observe
+ * once per resume event which can be filtered with reasonable effort using
+ * the accurate mono/real timestamps, it's probably not worth the trouble.
+ *
+ * Aside of that it might be possible on 32 and 64 bit to observe the
+ * following when the sleep time injection happens late:
+ *
+ * CPU 0				CPU 1
+ * timekeeping_resume()
+ * ktime_get_fast_timestamps()
+ *	mono, real = __ktime_get_real_fast()
+ *					inject_sleep_time()
+ *					   update boot offset
+ *	boot = mono + bootoffset;
+ *
+ * That means that boot time already has the sleep time adjustment, but
+ * real time does not. On the next readout both are in sync again.
+ *
+ * Preventing this for 64bit is not really feasible without destroying the
+ * careful cache layout of the timekeeper because the sequence count and
+ * struct tk_read_base would then need two cache lines instead of one.
+ *
+ * Access to the time keeper clock source is disabled accross the innermost
+ * steps of suspend/resume. The accessors still work, but the timestamps
+ * are frozen until time keeping is resumed which happens very early.
+ *
+ * For regular suspend/resume there is no observable difference vs. sched
+ * clock, but it might affect some of the nasty low level debug printks.
+ *
+ * OTOH, access to sched clock is not guaranteed accross suspend/resume on
+ * all systems either so it depends on the hardware in use.
+ *
+ * If that turns out to be a real problem then this could be mitigated by
+ * using sched clock in a similar way as during early boot. But it's not as
+ * trivial as on early boot because it needs some careful protection
+ * against the clock monotonic timestamp jumping backwards on resume.
+ */
+void ktime_get_fast_timestamps(struct ktime_timestamps *snapshot)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+
+	snapshot->real = __ktime_get_real_fast(&tk_fast_mono, &snapshot->mono);
+	snapshot->boot = snapshot->mono + ktime_to_ns(data_race(tk->offs_boot));
+}
+
+/**
  * halt_fast_timekeeper - Prevent fast timekeeper from accessing clocksource.
  * @tk: Timekeeper to snapshot.
  *


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
