Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtVcQ-0004w3-Ig
 for kexec@lists.infradead.org; Thu, 09 Jul 2020 12:25:39 +0000
Date: Thu, 9 Jul 2020 14:25:35 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [printk] 18a2dc6982: ltp.kmsg01.fail
Message-ID: <20200709122448.GJ4751@alley>
References: <20200707145932.8752-5-john.ogness@linutronix.de>
 <20200709071411.GR3874@shao2-debian>
 <20200709083323.GA572@jagdpanzerIV.localdomain>
 <874kqhm1v8.fsf@jogness.linutronix.de>
 <20200709105906.GC11164@alley> <20200709111310.GD11164@alley>
 <87zh89kkek.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87zh89kkek.fsf@jogness.linutronix.de>
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
Cc: Andrea Parri <parri.andrea@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, kernel test robot <rong.a.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, lkp@lists.01.org, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu 2020-07-09 13:23:07, John Ogness wrote:
> On 2020-07-09, Petr Mladek <pmladek@suse.com> wrote:
> > I though more about it. IMHO, it will be better to modify
> > prb_first_seq() to do the same cycle as prb_next_seq()
> > and return seq number of the first valid entry.
> 
> Exactly!
> 
> Here is a patch that does just that. I added a prb_first_valid_seq()
> function and made prb_first_seq() static. (The ringbuffer still needs
> prb_first_seq() for itself.)

The fix looks fine to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

It means that we have two fixes on top of the original patchset. Could
you please send v5 with the two fixes integrated? I would just squash
them into the 4th patch.

Best Regards,
Petr


PS: I know that I am hurrying maybe too much at the moment.
Well, I will have vacation last two week in July. I think that this is
in good enough state for linux-next and I would like to have it there
at least few days before I leave.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
