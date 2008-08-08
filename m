Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KRSyn-0001Mz-8w
	for kexec@lists.infradead.org; Fri, 08 Aug 2008 14:30:10 +0000
Date: Fri, 8 Aug 2008 10:30:06 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -v2 7/8] kexec jump: ftrace_enabled_save/restore
In-Reply-To: <20080808141700.GF3840@redhat.com>
Message-ID: <alpine.DEB.1.10.0808081026240.22796@gandalf.stny.rr.com>
References: <1218178368.22039.80.camel@caritas-dev.intel.com>
	<20080808141700.GF3840@redhat.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Huang Ying <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu



On Fri, 8 Aug 2008, Vivek Goyal wrote:

> On Fri, Aug 08, 2008 at 02:52:48PM +0800, Huang Ying wrote:
> > Add ftrace_enabled_save/restore, used to disable ftrace for a
> > while. This is used by kexec jump.
> > 
> > Signed-off-by: Huang Ying <ying.huang@intel.com>
> > 
> 
> 
> CCing Steven Rostedt for ftrace related changes.

Thanks,


> 
> > ---
> >  include/linux/ftrace.h |   18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -98,6 +98,24 @@ static inline void tracer_disable(void)
> >  #endif
> >  }
> >  
> > +static inline int ftrace_enabled_save(void)
> > +{
> > +#ifdef CONFIG_FTRACE
> > +	int saved_ftrace_enabled = ftrace_enabled;
> > +	ftrace_enabled = 0;
> > +	return saved_ftrace_enabled;
> > +#else
> > +	return 0;
> > +#endif
> > +}
> > +
> > +static inline void ftrace_enabled_restore(int enabled)
> > +{
> > +#ifdef CONFIG_FTRACE
> > +	ftrace_enabled = enabled;
> > +#endif
> > +}
> > +
> >  #ifdef CONFIG_FRAME_POINTER
> >  /* TODO: need to fix this for ARM */
> >  # define CALLER_ADDR0 ((unsigned long)__builtin_return_address(0))

The only problem with this approach is what happens if the user changes 
the enabled in between these two calls. This would make ftrace 
inconsistent.

I have a patch from the -rt tree that handles what you want. It is 
attached below. Not sure how well it will apply to mainline.

I really need to go through the rt patch set and start submitting a bunch 
of clean-up/fixes to mainline. We've been meaning to do it, just have been 
distracted :-(

-- Steve

From: Steven Rostedt <srostedt@redhat.com>
Subject: ftrace: cpu hotplug fix

Peter Zijlstra found that taking down and bringing up a new CPU caused
ftrace to crash the kernel. This was due to some arch calls that were
being traced by the function tracer before the smp_processor_id was set
up. Since the function tracer uses smp_processor_id it caused a triple
fault.

Instead of adding notrace all over the architecture code to prevent
this problem, it is easier to simply disable the function tracer
when bringing up a new CPU.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
---
 include/linux/ftrace.h            |   11 ++++++++---
 kernel/cpu.c                      |    9 +++++++++
 kernel/trace/ftrace.c             |   23 +++++++++++++++++++++++
 kernel/trace/trace_irqsoff.c      |    3 +++
 kernel/trace/trace_sched_wakeup.c |    2 +-
 5 files changed, 44 insertions(+), 4 deletions(-)

Index: linux-2.6.26/include/linux/ftrace.h
===================================================================
--- linux-2.6.26.orig/include/linux/ftrace.h
+++ linux-2.6.26/include/linux/ftrace.h
@@ -33,10 +33,15 @@ void clear_ftrace_function(void);
 
 extern void ftrace_stub(unsigned long a0, unsigned long a1);
 
+void ftrace_enable(void);
+void ftrace_disable(void);
+
 #else /* !CONFIG_FTRACE */
-# define register_ftrace_function(ops) do { } while (0)
-# define unregister_ftrace_function(ops) do { } while (0)
-# define clear_ftrace_function(ops) do { } while (0)
+# define register_ftrace_function(ops)		do { } while (0)
+# define unregister_ftrace_function(ops)	do { } while (0)
+# define clear_ftrace_function(ops)		do { } while (0)
+# define ftrace_enable()			do { } while (0)
+# define ftrace_disable()			do { } while (0)
 #endif /* CONFIG_FTRACE */
 
 #ifdef CONFIG_DYNAMIC_FTRACE
Index: linux-2.6.26/kernel/cpu.c
===================================================================
--- linux-2.6.26.orig/kernel/cpu.c
+++ linux-2.6.26/kernel/cpu.c
@@ -14,6 +14,7 @@
 #include <linux/kthread.h>
 #include <linux/stop_machine.h>
 #include <linux/mutex.h>
+#include <linux/ftrace.h>
 
 /* Serializes the updates to cpu_online_map, cpu_present_map */
 static DEFINE_MUTEX(cpu_add_remove_lock);
@@ -300,8 +301,16 @@ static int __cpuinit _cpu_up(unsigned in
 		goto out_notify;
 	}
 
+	/*
+	 * Disable function tracing while bringing up a new CPU.
+	 * We don't want to trace functions that can not handle a
+	 * smp_processor_id() call.
+	 */
+	ftrace_disable();
+
 	/* Arch-specific enabling code. */
 	ret = __cpu_up(cpu);
+	ftrace_enable();
 	if (ret != 0)
 		goto out_notify;
 	BUG_ON(!cpu_online(cpu));
Index: linux-2.6.26/kernel/trace/ftrace.c
===================================================================
--- linux-2.6.26.orig/kernel/trace/ftrace.c
+++ linux-2.6.26/kernel/trace/ftrace.c
@@ -151,6 +151,29 @@ static int __unregister_ftrace_function(
 	return ret;
 }
 
+static int save_ftrace_enabled;
+
+void ftrace_disable(void)
+{
+	mutex_lock(&ftrace_sysctl_lock);
+
+	save_ftrace_enabled = ftrace_enabled;
+	ftrace_enabled = 0;
+}
+
+void ftrace_enable(void)
+{
+	/* ftrace_enable must be paired with ftrace_disable */
+	if (!mutex_is_locked(&ftrace_sysctl_lock)) {
+		WARN_ON(1);
+		return;
+	}
+
+	ftrace_enabled = save_ftrace_enabled;
+
+	mutex_unlock(&ftrace_sysctl_lock);
+}
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 static struct task_struct *ftraced_task;
Index: linux-2.6.26/kernel/trace/trace_irqsoff.c
===================================================================
--- linux-2.6.26.orig/kernel/trace/trace_irqsoff.c
+++ linux-2.6.26/kernel/trace/trace_irqsoff.c
@@ -77,6 +77,9 @@ irqsoff_tracer_call(unsigned long ip, un
 	long disabled;
 	int cpu;
 
+	if (unlikely(!ftrace_enabled))
+		return;
+
 	/*
 	 * Does not matter if we preempt. We test the flags
 	 * afterward, to see if irqs are disabled or not.
Index: linux-2.6.26/kernel/trace/trace_sched_wakeup.c
===================================================================
--- linux-2.6.26.orig/kernel/trace/trace_sched_wakeup.c
+++ linux-2.6.26/kernel/trace/trace_sched_wakeup.c
@@ -44,7 +44,7 @@ wakeup_tracer_call(unsigned long ip, uns
 	int resched;
 	int cpu;
 
-	if (likely(!wakeup_task))
+	if (likely(!wakeup_task) || !ftrace_enabled)
 		return;
 
 	resched = need_resched();

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
