Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ecRqx-0008Vy-38
 for kexec@lists.infradead.org; Fri, 19 Jan 2018 08:16:49 +0000
Date: Fri, 19 Jan 2018 16:16:28 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] print kdump kernel loaded status in stack dump
Message-ID: <20180119081628.GB3985@dhcp-128-65.nay.redhat.com>
References: <20180117045057.GA4994@dhcp-128-65.nay.redhat.com>
 <878tcvt592.fsf@linux.intel.com>
 <20180119054538.GA484@jagdpanzerIV>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180119054538.GA484@jagdpanzerIV>
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
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: pmladek@suse.com, Andi Kleen <ak@linux.intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, sergey.senozhatsky@gmail.com, akpm@linux-foundation.org

On 01/19/18 at 02:45pm, Sergey Senozhatsky wrote:
> On (01/18/18 10:02), Andi Kleen wrote:
> > Dave Young <dyoung@redhat.com> writes:
> > >  		printk("%sHardware name: %s\n",
> > >  		       log_lvl, dump_stack_arch_desc_str);
> > > +	if (kexec_crash_loaded())
> > > +		printk("%skdump kernel loaded\n", log_lvl);
> > 
> > Oops/warnings are getting longer and longer, often scrolling away
> > from the screen, and if the kernel crashes backscroll does not work
> > anymore, so precious information is lost.
> 
> true. I even ended up having a console_reflush_on_panic() function. it
> simply re-prints with a delay [so I can at least read the oops] logbuf
> entries every once in a while, staring with the first oops_in_progress
> record.
> 

If too many messages printed on screen, then the next flush will 
still scroll up.  I thought about adding an option to improve
printk_delay so it can delay every n lines, eg. 25 rows. Maybe that
idea works for this issue?

BTW, if kdump is used then we should avoid adding extra stuff in panic
path.

> something like below [it's completely hacked up, but at least gives
> an idea]
> 
> ---
> 
>  include/linux/console.h |  1 +
>  kernel/panic.c          |  7 +++++++
>  kernel/printk/printk.c  | 39 ++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/console.h b/include/linux/console.h
> index b8920a031a3e..502e3f539448 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -168,6 +168,7 @@ extern void console_unlock(void);
>  extern void console_conditional_schedule(void);
>  extern void console_unblank(void);
>  extern void console_flush_on_panic(void);
> +extern void console_reflush_on_panic(void);
>  extern struct tty_driver *console_device(int *);
>  extern void console_stop(struct console *);
>  extern void console_start(struct console *);
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 2cfef408fec9..39cd59bbfaab 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -137,6 +137,7 @@ void panic(const char *fmt, ...)
>  	va_list args;
>  	long i, i_next = 0;
>  	int state = 0;
> +	int reflush_tick = 0;
>  	int old_cpu, this_cpu;
>  	bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;
>  
> @@ -298,6 +299,12 @@ void panic(const char *fmt, ...)
>  			i_next = i + 3600 / PANIC_BLINK_SPD;
>  		}
>  		mdelay(PANIC_TIMER_STEP);
> +
> +		reflush_tick++;
> +		if (reflush_tick == 32) { /* don't reflush too often */
> +			console_reflush_on_panic();
> +			reflush_tick = 0;
> +		}
>  	}
>  }
>  
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 9cb943c90d98..ef3f28d4c741 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -426,6 +426,10 @@ static u32 log_next_idx;
>  static u64 console_seq;
>  static u32 console_idx;
>  
> +/* index and sequence number of the record which started the oops print out */
> +static u64 log_oops_seq;
> +static u32 log_oops_idx;
> +
>  /* the next printk record to read after the last 'clear' command */
>  static u64 clear_seq;
>  static u32 clear_idx;
> @@ -1736,6 +1740,15 @@ static inline void printk_delay(void)
>  	}
>  }
>  
> +/*
> + * Why do we have printk_delay() in vprintk_emit()
> + * and not in console_unlock()?
> + */
> +static inline void console_unlock_delay(void)
> +{
> +	printk_delay();
> +}
> +
>  /*
>   * Continuation lines are buffered, and not committed to the record buffer
>   * until the line is complete, or a race forces it. The line fragments
> @@ -1849,6 +1862,7 @@ asmlinkage int vprintk_emit(int facility, int level,
>  
>  	/* This stops the holder of console_sem just where we want him */
>  	logbuf_lock_irqsave(flags);
> +
>  	/*
>  	 * The printf needs to come first; we need the syslog
>  	 * prefix which might be passed-in as a parameter.
> @@ -1890,7 +1904,11 @@ asmlinkage int vprintk_emit(int facility, int level,
>  		lflags |= LOG_PREFIX|LOG_NEWLINE;
>  
>  	printed_len = log_output(facility, level, lflags, dict, dictlen, text, text_len);
> -
> +	/* Oops... */
> +	if (oops_in_progress && !log_oops_seq) {
> +		log_oops_seq = log_next_seq;
> +		log_oops_idx = log_next_idx;
> +	}
>  	logbuf_unlock_irqrestore(flags);
>  
>  	/* If called from the scheduler, we can not call up(). */
> @@ -2396,6 +2414,7 @@ void console_unlock(void)
>  
>  		stop_critical_timings();	/* don't trace print latency */
>  		call_console_drivers(ext_text, ext_len, text, len);
> +		console_unlock_delay();
>  		start_critical_timings();
>  
>  		if (console_lock_spinning_disable_and_check()) {
> @@ -2495,6 +2514,24 @@ void console_flush_on_panic(void)
>  	console_unlock();
>  }
>  
> +/**
> + * console_reflush_on_panic - re-flush console content starting from the
> + * first oops_in_progress record
> + */
> +void console_reflush_on_panic(void)
> +{
> +	unsigned long flags;
> +
> +	logbuf_lock_irqsave(flags);
> +	console_seq = log_oops_seq;
> +	console_idx = log_oops_idx;
> +	logbuf_unlock_irqrestore(flags);
> +
> +	if (!printk_delay_msec)
> +		printk_delay_msec = 273; /* I can't read any faster */
> +	console_flush_on_panic();
> +}
> +
>  /*
>   * Return the console tty driver structure and its associated index
>   */
> -- 
> 2.16.0
> 

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
