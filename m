Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtp4F-0000tk-AZ
 for kexec@lists.infradead.org; Fri, 10 Jul 2020 09:11:40 +0000
Date: Fri, 10 Jul 2020 11:11:37 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v4 0/4] printk: replace ringbuffer
Message-ID: <20200710091137.GN4751@alley>
References: <20200707145932.8752-1-john.ogness@linutronix.de>
 <20200708152005.GF4751@alley>
 <87wo3d9nlo.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87wo3d9nlo.fsf@jogness.linutronix.de>
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

On Thu 2020-07-09 09:09:31, John Ogness wrote:
> On 2020-07-08, Petr Mladek <pmladek@suse.com> wrote:
> > OK, I think that we are ready to try this in linux-next.
> > I am going to push it there via printk/linux.git.
> >
> > [...]
> > 
> > Of course, there are still many potential problems. The following comes
> > to my mind:
> >
> > [...]
> >
> >    + Debugging tools accessing the buffer directly would need to
> >      understand the new structure. Fortunately John provided
> >      patches for the most prominent ones.
> 
> The next series in the printk-rework (move LOG_CONT handling from
> writers to readers) makes some further changes that, while not
> incompatible, could affect the output of existing tools. It may be a
> good idea to let the new ringbuffer sit in linux-next until the next
> series has been discussed/reviewed/merged. After the next series,
> everything will be in place (with regard to userspace tools) to finish
> the rework.

I know that it might be premature question. But I wonder what kind
of changes are expected because of the continuous lines.

Do you expect some changes in the ring buffer structures so that
the debugging tools would need yet another update to actually
access the data?

Or do you expect backward compatible changes that would allow
to pass related parts of the continuous lines via syslog/dev_kmsg
interface and join them later in userspace?

IMHO, it would make sense to wait only when the structures need
some modification. Concatenating related parts on the userspace
side will need to stay optional anyway.

As I say, this might be premature question. I just do not want
to unnecessary delay mainlining the current state. It would get
much wider testing there. And it is great when the changes might
be done in "small" steps.

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
