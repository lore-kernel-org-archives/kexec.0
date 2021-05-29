Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmwkk-0052Mg-1z
 for kexec@lists.infradead.org; Sat, 29 May 2021 11:03:41 +0000
From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 4/4] time: Fix spelling mistakes
Date: Sat, 29 May 2021 19:03:05 +0800
Message-ID: <20210529110305.9446-5-thunder.leizhen@huawei.com>
In-Reply-To: <20210529110305.9446-1-thunder.leizhen@huawei.com>
References: <20210529110305.9446-1-thunder.leizhen@huawei.com>
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
To: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Balbir Singh <bsingharora@gmail.com>, Barry Song <song.bao.hua@hisilicon.com>, Christoph Hellwig <hch@lst.de>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Eric Biederman <ebiederm@xmission.com>, "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Masami Hiramatsu <mhiramat@kernel.org>, Jessica Yu <jeyu@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, Oleg Nesterov <oleg@redhat.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, kgdb-bugreport <kgdb-bugreport@lists.sourceforge.net>, kexec <kexec@lists.infradead.org>, linux-crypto <linux-crypto@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>

Fix some spelling mistakes in comments:
wit ==> with
initialy ==> initially
syncrhonized ==> synchronized
therefor ==> therefore

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/timekeeping.h | 2 +-
 include/linux/timer.h       | 2 +-
 kernel/time/alarmtimer.c    | 2 +-
 kernel/time/timer.c         | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 78a98bdff76d..01bd6ff322be 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -28,7 +28,7 @@ extern int do_sys_settimeofday64(const struct timespec64 *tv,
  * For other references, use the functions with "real", "clocktai",
  * "boottime" and "raw" suffixes.
  *
- * To get the time in a different format, use the ones wit
+ * To get the time in a different format, use the ones with
  * "ns", "ts64" and "seconds" suffix.
  *
  * See Documentation/core-api/timekeeping.rst for more details.
diff --git a/include/linux/timer.h b/include/linux/timer.h
index fda13c9d1256..a7f7c7cac4c0 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -56,7 +56,7 @@ struct timer_list {
  *
  * Note: Because enqueuing of timers can migrate the timer from one
  * CPU to another, pinned timers are not guaranteed to stay on the
- * initialy selected CPU.  They move to the CPU on which the enqueue
+ * initially selected CPU.  They move to the CPU on which the enqueue
  * function is invoked via mod_timer() or add_timer().  If the timer
  * should be placed on a particular CPU, then add_timer_on() has to be
  * used.
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 5897828b9d7e..a400139b9a9c 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -35,7 +35,7 @@
 
 /**
  * struct alarm_base - Alarm timer bases
- * @lock:		Lock for syncrhonized access to the base
+ * @lock:		Lock for synchronized access to the base
  * @timerqueue:		Timerqueue head managing the list of events
  * @get_ktime:		Function to read the time correlating to the base
  * @get_timespec:	Function to read the namespace time correlating to the base
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 84332f01dc57..df6585281713 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -62,7 +62,7 @@ EXPORT_SYMBOL(jiffies_64);
 
 /*
  * The timer wheel has LVL_DEPTH array levels. Each level provides an array of
- * LVL_SIZE buckets. Each level is driven by its own clock and therefor each
+ * LVL_SIZE buckets. Each level is driven by its own clock and therefore each
  * level has a different granularity.
  *
  * The level granularity is:		LVL_CLK_DIV ^ lvl
@@ -70,7 +70,7 @@ EXPORT_SYMBOL(jiffies_64);
  *
  * The array level of a newly armed timer depends on the relative expiry
  * time. The farther the expiry time is away the higher the array level and
- * therefor the granularity becomes.
+ * therefore the granularity becomes.
  *
  * Contrary to the original timer wheel implementation, which aims for 'exact'
  * expiry of the timers, this implementation removes the need for recascading
-- 
2.25.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
