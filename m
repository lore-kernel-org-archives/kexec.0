Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5M6N-0004FU-Iq
 for kexec@lists.infradead.org; Tue, 11 Aug 2020 04:41:32 +0000
Received: by mail-pl1-x641.google.com with SMTP id r4so6220202pls.2
 for <kexec@lists.infradead.org>; Mon, 10 Aug 2020 21:41:29 -0700 (PDT)
From: Orson Zhai <orsonzhai@gmail.com>
Subject: [RFC PATCH] printk: Change timestamp to triplet as mono, boot and real
Date: Tue, 11 Aug 2020 12:40:22 +0800
Message-Id: <1597120822-11999-1-git-send-email-orsonzhai@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Prarit Bhargava <prarit@redhat.com>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>
Cc: zhang.lyra@gmail.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ruifeng.zhang1@unisoc.com, Orson Zhai <orson.zhai@unisoc.com>, cixi.geng1@unisoc.com

From: Thomas Gleixner <tglx@linutronix.de>

Timestamps printed in kernel log are retrieved by local_clock which reads
jiffies as a referrence clock source.
But it is diffcult to be synchronized with logs generated out of kernel,
say some remote processors (Modem) in the Soc of mobile phones. 
Jiffies will be unchanged when system is in suspend mode but Modem will
not.

So timestamps are required to be compensated with suspend time in some
complecated scenarios especially for Android system. As an initial
implementation was rejected by Linus, Thomas made this patch [1] 2 yeas
ago to replace ts_nsec with a struct ts that consists 3 types of time:
mono, boot and real.

This is an updated version which comes from patch [1] written by Thomas
and suggestion [2] about VMCORE_INFO given by Linus.

It provides the prerequisite code to print kernel logs with boot or real
timestamp in the future.

[1] https://lore.kernel.org/lkml/alpine.DEB.2.20.1711142341130.2221@nanos/
[2] https://lore.kernel.org/lkml/CA+55aFz-VvPBoW0RvDW4eN5YhwaUzcMvsYzrqEC41QdfOdiF4Q@mail.gmail.com/

Cc. Thomas Gleixner <tglx@linutronix.de>
Cc. Linus Torvalds <torvalds@linux-foundation.org>
Cc. Prarit Bhargava <prarit@redhat.com>
Cc. Petr Mladek <pmladek@suse.com>
Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
Tested-by: Cixi Geng <cixi.geng1@unisoc.com>
---
This patch has been tested in qemu-x86-system. One problem is the timestamp
in kernel log will be printed [    0.000000] for longer time than before. 

1 [    0.000000] microcode: microcode updated early to revision 0x28, date = 2019-11-12 
2 [    0.000000] Linux version 5.8.0+ (root@spreadtrum) (gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0, GNU ld (GNU Binutils for Ubuntu) 2.30) #2 SMP Fri Aug 7 21:30:51 CST 2020
3 [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.8.0+ root=UUID=4d889bca-be18-433d-9b86-c1c1714cc293 ro quiet splash vt.handoff=1
4 [    0.000000] KERNEL supported cpus: 
5 [    0.000000]   Intel GenuineIntel
....
223 [    0.000000]  Tracing variant of Tasks RCU enabled. 
224 [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies. 
225 [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4 
226 [    0.000000] NR_IRQS: 524544, nr_irqs: 456, preallocated irqs: 16 
227 [    0.059662] random: crng done (trusting CPU's manufacturer) 
         ^^^^^^^^
228 [    0.059662] Console: colour dummy device 80x25 
229 [    0.059662] printk: console [tty0] enabled 
230 [    0.059662] ACPI: Core revision 20200528 

compared to old log:

69 [    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000021fdfffff] usable
70 [    0.000000] efi: EFI v2.31 by American Megatrends
71 [    0.000000] efi: ESRT=0xdbf69818 ACPI=0xdaef8000 ACPI 2.0=0xdaef8000 SMBIOS=0xf0480
72 [    0.000000] SMBIOS 2.8 present.
73 [    0.000000] DMI: LENOVO ThinkCentre M4500t-N000/, BIOS FCKT58AUS 09/17/2014
74 [    0.000000] tsc: Fast TSC calibration using PIT
75 [    0.000000] tsc: Detected 3292.477 MHz processor
76 [    0.000503] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
        ^^^^^^^^
77 [    0.000504] e820: remove [mem 0x000a0000-0x000fffff] usable
78 [    0.000510] last_pfn = 0x21fe00 max_arch_pfn = 0x400000000
79 [    0.000513] MTRR default type: uncachable
 
 include/linux/crash_core.h  |  6 ++++--
 include/linux/timekeeping.h | 15 +++++++++++++++
 kernel/printk/printk.c      | 34 +++++++++++++++++++---------------
 kernel/time/timekeeping.c   | 36 +++++++++++++++++++++++++-----------
 4 files changed, 63 insertions(+), 28 deletions(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 525510a..85b96cd 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -50,9 +50,11 @@ phys_addr_t paddr_vmcoreinfo_note(void);
 #define VMCOREINFO_STRUCT_SIZE(name) \
 	vmcoreinfo_append_str("SIZE(%s)=%lu\n", #name, \
 			      (unsigned long)sizeof(struct name))
-#define VMCOREINFO_OFFSET(name, field) \
+#define VMCOREINFO_FIELD_OFFSET(name, field, offset) \
 	vmcoreinfo_append_str("OFFSET(%s.%s)=%lu\n", #name, #field, \
-			      (unsigned long)offsetof(struct name, field))
+			      (unsigned long)offsetof(struct name, offset))
+#define VMCOREINFO_OFFSET(name, field) \
+	VMCOREINFO_FIELD_OFFSET(name, field, field)
 #define VMCOREINFO_LENGTH(name, value) \
 	vmcoreinfo_append_str("LENGTH(%s)=%lu\n", #name, (unsigned long)value)
 #define VMCOREINFO_NUMBER(name) \
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index d5471d6..ecee06c 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -222,6 +222,18 @@ extern bool timekeeping_rtc_skipresume(void);
 
 extern void timekeeping_inject_sleeptime64(const struct timespec64 *delta);
 
+/*
+ * struct timestanps - Simultaneous mono/boot/real timestamps
+ * @mono:	Monotonic timestamp
+ * @boot:	Boottime timestamp
+ * @real:	Realtime timestamp
+ */
+struct timestamps {
+	u64		mono;
+	u64		boot;
+	u64		real;
+};
+
 /**
  * struct system_time_snapshot - simultaneous raw/real time capture with
  *				 counter value
@@ -280,6 +292,9 @@ extern int get_device_system_crosststamp(
  */
 extern void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot);
 
+/* NMI safe mono/boot/realtime timestamps */
+extern void ktime_get_fast_timestamps(struct timestamps *snap);
+
 /*
  * Persistent clock related interfaces
  */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9b75f6b..3db010b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -366,7 +366,8 @@ enum log_flags {
 };
 
 struct printk_log {
-	u64 ts_nsec;		/* timestamp in nanoseconds */
+	/* Timestamps in nanoseconds */
+	struct timestamps ts;
 	u16 len;		/* length of entire record */
 	u16 text_len;		/* length of text buffer */
 	u16 dict_len;		/* length of dictionary buffer */
@@ -614,7 +615,7 @@ static u32 truncate_msg(u16 *text_len, u16 *trunc_msg_len,
 
 /* insert record into the buffer, discard old ones, update heads */
 static int log_store(u32 caller_id, int facility, int level,
-		     enum log_flags flags, u64 ts_nsec,
+		     enum log_flags flags, struct timestamps *ts,
 		     const char *dict, u16 dict_len,
 		     const char *text, u16 text_len)
 {
@@ -657,10 +658,10 @@ static int log_store(u32 caller_id, int facility, int level,
 	msg->facility = facility;
 	msg->level = level & 7;
 	msg->flags = flags & 0x1f;
-	if (ts_nsec > 0)
-		msg->ts_nsec = ts_nsec;
+	if (ts && ts->mono  > 0)
+		msg->ts = *ts;
 	else
-		msg->ts_nsec = local_clock();
+		ktime_get_fast_timestamps(&msg->ts);
 #ifdef CONFIG_PRINTK_CALLER
 	msg->caller_id = caller_id;
 #endif
@@ -726,7 +727,7 @@ static void append_char(char **pp, char *e, char c)
 static ssize_t msg_print_ext_header(char *buf, size_t size,
 				    struct printk_log *msg, u64 seq)
 {
-	u64 ts_usec = msg->ts_nsec;
+	u64 ts_usec = msg->ts.mono;
 	char caller[20];
 #ifdef CONFIG_PRINTK_CALLER
 	u32 id = msg->caller_id;
@@ -1090,7 +1091,9 @@ void log_buf_vmcoreinfo_setup(void)
 	 * parse it and detect any changes to structure down the line.
 	 */
 	VMCOREINFO_STRUCT_SIZE(printk_log);
-	VMCOREINFO_OFFSET(printk_log, ts_nsec);
+	/* ts.mono used to be called "ts_nsec" */
+	VMCOREINFO_FIELD_OFFSET(printk_log, ts_nsec, ts.mono);
+	VMCOREINFO_OFFSET(printk_log, ts);
 	VMCOREINFO_OFFSET(printk_log, len);
 	VMCOREINFO_OFFSET(printk_log, text_len);
 	VMCOREINFO_OFFSET(printk_log, dict_len);
@@ -1300,12 +1303,13 @@ static size_t print_syslog(unsigned int level, char *buf)
 	return sprintf(buf, "<%u>", level);
 }
 
-static size_t print_time(u64 ts, char *buf)
+static size_t print_time(const struct timestamps *ts, char *buf)
 {
-	unsigned long rem_nsec = do_div(ts, 1000000000);
+	u64 mono = ts->mono;
+	unsigned long rem_nsec = do_div(mono, 1000000000);
 
 	return sprintf(buf, "[%5lu.%06lu]",
-		       (unsigned long)ts, rem_nsec / 1000);
+		       (unsigned long)mono, rem_nsec / 1000);
 }
 
 #ifdef CONFIG_PRINTK_CALLER
@@ -1330,7 +1334,7 @@ static size_t print_prefix(const struct printk_log *msg, bool syslog,
 		len = print_syslog((msg->facility << 3) | msg->level, buf);
 
 	if (time)
-		len += print_time(msg->ts_nsec, buf + len);
+		len += print_time(&msg->ts, buf + len);
 
 	len += print_caller(msg->caller_id, buf + len);
 
@@ -1855,7 +1859,7 @@ static struct cont {
 	char buf[LOG_LINE_MAX];
 	size_t len;			/* length == 0 means unused buffer */
 	u32 caller_id;			/* printk_caller_id() of first print */
-	u64 ts_nsec;			/* time of first print */
+	struct timestamps ts;		/* time of first print */
 	u8 level;			/* log level of first message */
 	u8 facility;			/* log facility of first message */
 	enum log_flags flags;		/* prefix, newline flags */
@@ -1867,7 +1871,7 @@ static void cont_flush(void)
 		return;
 
 	log_store(cont.caller_id, cont.facility, cont.level, cont.flags,
-		  cont.ts_nsec, NULL, 0, cont.buf, cont.len);
+		  &cont.ts, NULL, 0, cont.buf, cont.len);
 	cont.len = 0;
 }
 
@@ -1884,7 +1888,7 @@ static bool cont_add(u32 caller_id, int facility, int level,
 		cont.facility = facility;
 		cont.level = level;
 		cont.caller_id = caller_id;
-		cont.ts_nsec = local_clock();
+		ktime_get_fast_timestamps(&cont.ts);
 		cont.flags = flags;
 	}
 
@@ -1929,7 +1933,7 @@ static size_t log_output(int facility, int level, enum log_flags lflags, const c
 	}
 
 	/* Store it in the record log */
-	return log_store(caller_id, facility, level, lflags, 0,
+	return log_store(caller_id, facility, level, lflags, NULL,
 			 dict, dictlen, text, text_len);
 }
 
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 63a632f..e18858fa 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -510,29 +510,29 @@ u64 notrace ktime_get_boot_fast_ns(void)
 }
 EXPORT_SYMBOL_GPL(ktime_get_boot_fast_ns);
 
-
 /*
  * See comment for __ktime_get_fast_ns() vs. timestamp ordering
  */
-static __always_inline u64 __ktime_get_real_fast_ns(struct tk_fast *tkf)
+static notrace u64 __ktime_get_real_fast(struct tk_fast *tkf, u64 *mono)
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
@@ -540,11 +540,25 @@ static __always_inline u64 __ktime_get_real_fast_ns(struct tk_fast *tkf)
  */
 u64 ktime_get_real_fast_ns(void)
 {
-	return __ktime_get_real_fast_ns(&tk_fast_mono);
+	return __ktime_get_real_fast(&tk_fast_mono, NULL);
 }
 EXPORT_SYMBOL_GPL(ktime_get_real_fast_ns);
 
 /**
+ * ktime_get_fast_timestamps: - NMI safe timestamps
+ * @snap:	Pointer to timestamp storage
+ *
+ * Stores clock monotonic, boottime and realtime time stamps
+ */
+void ktime_get_fast_timestamps(struct timestamps *snap)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+
+	snap->real = __ktime_get_real_fast(&tk_fast_mono, &snap->mono);
+	snap->boot = snap->mono + ktime_to_ns(tk->offs_boot);
+}
+
+/**
  * halt_fast_timekeeper - Prevent fast timekeeper from accessing clocksource.
  * @tk: Timekeeper to snapshot.
  *
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
