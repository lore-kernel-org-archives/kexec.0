Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOIXj-00BQIn-Eh
 for kexec@lists.infradead.org; Mon, 22 Mar 2021 11:16:22 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH next v1 2/3] printk: remove safe buffers
In-Reply-To: <YFbY8kF7ilYoxvYp@google.com>
References: <20210316233326.10778-1-john.ogness@linutronix.de>
 <20210316233326.10778-3-john.ogness@linutronix.de>
 <YFbY8kF7ilYoxvYp@google.com>
Date: Mon, 22 Mar 2021 12:16:15 +0100
Message-ID: <87k0pzmoao.fsf@jogness.linutronix.de>
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
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Alistair Popple <alistair@popple.id.au>, Jordan Niethe <jniethe5@gmail.com>, Peter Zijlstra <peterz@infradead.org>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Yue Hu <huyue2@yulong.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Rafael Aquini <aquini@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, "Paul E. McKenney" <paulmck@kernel.org>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org

On 2021-03-21, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
>> @@ -369,7 +70,10 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
>>  	 * Use the main logbuf even in NMI. But avoid calling console
>>  	 * drivers that might have their own locks.
>>  	 */
>> -	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK)) {
>> +	if (this_cpu_read(printk_context) &
>> +	    (PRINTK_NMI_DIRECT_CONTEXT_MASK |
>> +	     PRINTK_NMI_CONTEXT_MASK |
>> +	     PRINTK_SAFE_CONTEXT_MASK)) {
>
> Do we need printk_nmi_direct_enter/exit() and
> PRINTK_NMI_DIRECT_CONTEXT_MASK?  Seems like all printk_safe() paths
> are now DIRECT - we store messages to the prb, but don't call console
> drivers.

I was planning on waiting until the kthreads are introduced, in which
case printk_safe.c is completely removed. But I suppose I could switch
the 1 printk_nmi_direct_enter() user to printk_nmi_enter() so that
PRINTK_NMI_DIRECT_CONTEXT_MASK can be removed now. I would do this in a
4th patch of the series.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
