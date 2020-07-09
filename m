Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtUUK-0006HL-Mj
 for kexec@lists.infradead.org; Thu, 09 Jul 2020 11:13:13 +0000
Date: Thu, 9 Jul 2020 13:13:11 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [printk] 18a2dc6982: ltp.kmsg01.fail
Message-ID: <20200709111310.GD11164@alley>
References: <20200707145932.8752-5-john.ogness@linutronix.de>
 <20200709071411.GR3874@shao2-debian>
 <20200709083323.GA572@jagdpanzerIV.localdomain>
 <874kqhm1v8.fsf@jogness.linutronix.de>
 <20200709105906.GC11164@alley>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200709105906.GC11164@alley>
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

On Thu 2020-07-09 12:59:06, Petr Mladek wrote:
> On Thu 2020-07-09 12:20:35, John Ogness wrote:
> > On 2020-07-09, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> > > On (20/07/09 15:14), kernel test robot wrote:
> > > [..]
> > >
> > > Took me a while to find the FAIL-ed test:
> > >
> > >> kmsg01.c:393: INFO: TEST: read returns EPIPE when messages get overwritten
> > >> kmsg01.c:398: INFO: first seqno: 0
> > >> kmsg01.c:411: INFO: first seqno now: 881
> > >> kmsg01.c:425: FAIL: read returned: 77: SUCCESS (0)
> > >
> > > So this is seq number related
> > > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/logging/kmsg/kmsg01.c#L383
> > 
> > Excellent test.
> > 
> > Since the messages are above the expected average size, the dataring is
> > wrapping before the descriptor ring. This means that the initial
> > descriptors are still there, but their data is gone. Initially I would
> > generate an EPIPE for this, but it was changed. Here is the thread [0]
> > we had about this.
> 
> I see. IMHO, the following should do the job. The check is done only
> when the above prb_read_valid() succeeded. Therefore the printk_record
> has to include a valid value. And it must be the first valid record
> when some messages were lost.
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 62fc1abd9c4d..5d4760b5c671 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -775,9 +775,9 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
>  		logbuf_lock_irq();
>  	}
>  
> -	if (user->seq < prb_first_seq(prb)) {
> +	if (user->seq < r->info->seq) {
>  		/* our last seen message is gone, return error and reset */
> -		user->seq = prb_first_seq(prb);
> +		user->seq = r->info->seq;
>  		ret = -EPIPE;
>  		logbuf_unlock_irq();
>  		goto out;

I though more about it. IMHO, it will be better to modify
prb_first_seq() to do the same cycle as prb_next_seq()
and return seq number of the first valid entry.

IMHO, basically any caller in printk.c expects this behavior.
For example, devkmsg user would expect reading valid entry after doing
SEEK_SET. I would also expect to get valid record right after opening
devkmsg, etc.

The current prb_first_seq() is needed only _prb_read_valid(). For,
this I would rename the original function to prb_tail_seq().

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
