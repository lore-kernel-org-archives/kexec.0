Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZJjU6-0006SZ-0b
 for kexec@lists.infradead.org; Mon, 27 Jul 2015 14:34:30 +0000
Received: by wibxm9 with SMTP id xm9so119716296wib.1
 for <kexec@lists.infradead.org>; Mon, 27 Jul 2015 07:34:08 -0700 (PDT)
Date: Mon, 27 Jul 2015 16:34:06 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [V2 PATCH 1/3] x86/panic: Fix re-entrance problem due to panic
 on NMI
Message-ID: <20150727143405.GF11317@dhcp22.suse.cz>
References: <20150727015850.4928.87717.stgit@softrs>
 <20150727015850.4928.50289.stgit@softrs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150727015850.4928.50289.stgit@softrs>
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
To: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Mon 27-07-15 10:58:50, Hidehiro Kawai wrote:
[...]
> diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> index d05bd2e..5b32d81 100644
> --- a/arch/x86/kernel/nmi.c
> +++ b/arch/x86/kernel/nmi.c
> @@ -230,7 +230,8 @@ void unregister_nmi_handler(unsigned int type, const char *name)
>  	}
>  #endif
>  
> -	if (panic_on_unrecovered_nmi)
> +	if (panic_on_unrecovered_nmi &&
> +	    atomic_cmpxchg(&panicking_cpu, -1, raw_smp_processor_id()) == -1)
>  		panic("NMI: Not continuing");

Spreading the check to all NMI callers is quite ugly. Wouldn't it be
better to introduce nmi_panic() which wouldn't be __noreturn unlike the
regular panic. The check could be also relaxed a bit and nmi_panic would
return only if the ongoing panic is the current cpu when we really have
to return and allow the preempted panic to finish.

Something like
---
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 5582410727cb..409091c48e6c 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -253,6 +253,7 @@ static inline void might_fault(void) { }
 extern struct atomic_notifier_head panic_notifier_list;
 extern long (*panic_blink)(int state);
 __printf(1, 2)
+void nmi_panic(const char *fmt, ...) __cold;
 void panic(const char *fmt, ...)
 	__noreturn __cold;
 extern void oops_enter(void);
diff --git a/kernel/panic.c b/kernel/panic.c
index 04e91ff7560b..4c1ff7e19cdc 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -60,6 +60,8 @@ void __weak panic_smp_self_stop(void)
 		cpu_relax();
 }
 
+static atomic_t panic_cpu = ATOMIC_INIT(-1);
+
 /**
  *	panic - halt the system
  *	@fmt: The text string to print
@@ -70,11 +72,11 @@ void __weak panic_smp_self_stop(void)
  */
 void panic(const char *fmt, ...)
 {
-	static DEFINE_SPINLOCK(panic_lock);
 	static char buf[1024];
 	va_list args;
 	long i, i_next = 0;
 	int state = 0;
+	int this_cpu, old_cpu;
 
 	/*
 	 * Disable local interrupts. This will prevent panic_smp_self_stop
@@ -94,7 +96,9 @@ void panic(const char *fmt, ...)
 	 * stop themself or will wait until they are stopped by the 1st CPU
 	 * with smp_send_stop().
 	 */
-	if (!spin_trylock(&panic_lock))
+	this_cpu = raw_smp_processor_id();
+	old_cpu = atomic_cmpxchg(&panic_cpu, -1, this_cpu);
+	if (old_cpu != -1 && old_cpu != this_cpu)
 		panic_smp_self_stop();
 
 	console_verbose();
@@ -201,9 +205,20 @@ void panic(const char *fmt, ...)
 		mdelay(PANIC_TIMER_STEP);
 	}
 }
-
 EXPORT_SYMBOL(panic);
 
+void nmi_panic(const char *fmt, ...)
+{
+	/*
+	 * We have to back off if the NMI has preempted an ongoing panic and
+	 * allow it to finish
+	 */
+	if (atomic_read(&panic_cpu) == raw_smp_processor_id())
+		return;
+
+	panic();
+}
+EXPORT_SYMBOL(nmi_panic);
 
 struct tnt {
 	u8	bit;
-- 
Michal Hocko
SUSE Labs

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
