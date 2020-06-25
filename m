Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joTki-0003Mz-VT
 for kexec@lists.infradead.org; Thu, 25 Jun 2020 15:25:25 +0000
Date: Thu, 25 Jun 2020 17:25:23 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: record_printk_text tricks: was: [PATCH v3 3/3] printk: use the
 lockless ringbuffer
Message-ID: <20200625152523.GJ8444@alley>
References: <20200618144919.9806-1-john.ogness@linutronix.de>
 <20200618144919.9806-4-john.ogness@linutronix.de>
 <20200625120946.GG6156@alley>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200625120946.GG6156@alley>
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
Cc: Andrea Parri <parri.andrea@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu 2020-06-25 14:09:46, Petr Mladek wrote:
> On Thu 2020-06-18 16:55:19, John Ogness wrote:
> > Replace the existing ringbuffer usage and implementation with
> > lockless ringbuffer usage. Even though the new ringbuffer does not
> > require locking, all existing locking is left in place. Therefore,
> > this change is purely replacing the underlining ringbuffer.
> 
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > +static size_t record_print_text(struct printk_record *r, bool syslog,
> > +				bool time)

[...]

> > +static size_t get_record_text_size(struct printk_info *info,
> > +				   unsigned int line_count,
> > +				   bool syslog, bool time)
> > +{

Nit: This should get called get_record_print_text_size(). It will make
it more clear that it counts the prefixes added for printing.

Best Regards,
Petr

PS: I have finished review of this 3rd patch. I am going to look at
the 2nd patch the following week if I find the courage ;-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
