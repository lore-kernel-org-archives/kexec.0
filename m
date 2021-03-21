Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lNqbV-009cYZ-9m
 for kexec@lists.infradead.org; Sun, 21 Mar 2021 05:26:23 +0000
Received: by mail-pf1-x42b.google.com with SMTP id x26so8724052pfn.0
 for <kexec@lists.infradead.org>; Sat, 20 Mar 2021 22:26:19 -0700 (PDT)
Date: Sun, 21 Mar 2021 14:26:10 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH next v1 2/3] printk: remove safe buffers
Message-ID: <YFbY8kF7ilYoxvYp@google.com>
References: <20210316233326.10778-1-john.ogness@linutronix.de>
 <20210316233326.10778-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210316233326.10778-3-john.ogness@linutronix.de>
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
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Alistair Popple <alistair@popple.id.au>, Jordan Niethe <jniethe5@gmail.com>, Peter Zijlstra <peterz@infradead.org>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Yue Hu <huyue2@yulong.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Rafael Aquini <aquini@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, "Paul E. McKenney" <paulmck@kernel.org>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org

On (21/03/17 00:33), John Ogness wrote:
[..]
>  void printk_nmi_direct_enter(void)
>  {
> @@ -324,27 +44,8 @@ void printk_nmi_direct_exit(void)
>  	this_cpu_and(printk_context, ~PRINTK_NMI_DIRECT_CONTEXT_MASK);
>  }
>  
> -#else
> -
> -static __printf(1, 0) int vprintk_nmi(const char *fmt, va_list args)
> -{
> -	return 0;
> -}
> -
>  #endif /* CONFIG_PRINTK_NMI */
>  
> -/*
> - * Lock-less printk(), to avoid deadlocks should the printk() recurse
> - * into itself. It uses a per-CPU buffer to store the message, just like
> - * NMI.
> - */
> -static __printf(1, 0) int vprintk_safe(const char *fmt, va_list args)
> -{
> -	struct printk_safe_seq_buf *s = this_cpu_ptr(&safe_print_seq);
> -
> -	return printk_safe_log_store(s, fmt, args);
> -}
> -
>  /* Can be preempted by NMI. */
>  void __printk_safe_enter(void)
>  {
> @@ -369,7 +70,10 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
>  	 * Use the main logbuf even in NMI. But avoid calling console
>  	 * drivers that might have their own locks.
>  	 */
> -	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK)) {
> +	if (this_cpu_read(printk_context) &
> +	    (PRINTK_NMI_DIRECT_CONTEXT_MASK |
> +	     PRINTK_NMI_CONTEXT_MASK |
> +	     PRINTK_SAFE_CONTEXT_MASK)) {

Do we need printk_nmi_direct_enter/exit() and PRINTK_NMI_DIRECT_CONTEXT_MASK?
Seems like all printk_safe() paths are now DIRECT - we store messages to the
prb, but don't call console drivers.

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
