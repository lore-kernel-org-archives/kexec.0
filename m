Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAcSP-0002Hs-IY
 for kexec@lists.infradead.org; Tue, 25 Aug 2020 17:10:02 +0000
Date: Tue, 25 Aug 2020 19:09:55 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 1/7][next] printk: ringbuffer: rename
 DESC_COMMITTED_MASK flag
Message-ID: <20200825170955.GX4353@alley>
References: <20200824103538.31446-1-john.ogness@linutronix.de>
 <20200824103538.31446-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200824103538.31446-2-john.ogness@linutronix.de>
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

On Mon 2020-08-24 12:41:32, John Ogness wrote:
> The flag DESC_COMMITTED_MASK has a much longer name compared to the
> other state flags and also is in past tense form, rather than in
> command form. Rename the flag to DESC_COMMIT_MASK in order to match
> the other state flags.

I am not a native speaker. But the command form sounds a bit misleading to me.

I see that the new name will make more sense after adding the state "FINAL".
But "FINAL" will not be a command form either.

I am fine with the change but I would prefer a better commit message.
What about something like?

"A comming support for continuous lines will allow to reopen records
with DESC_COMMITTED_MASK set. As a result, the flag will not longer
describe the final committed state. Rename it to DESC_COMMIT_MASK
as a preparation step."


With the updated commit message:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
