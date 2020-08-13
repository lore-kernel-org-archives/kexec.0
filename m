Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k612N-0001Zy-9Q
 for kexec@lists.infradead.org; Thu, 13 Aug 2020 00:24:08 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
In-Reply-To: <20200812163908.GH12903@alley>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de> <20200811160551.GC12903@alley>
 <20200812163908.GH12903@alley>
Date: Thu, 13 Aug 2020 02:30:02 +0206
Message-ID: <87v9hn2y1p.fsf@jogness.linutronix.de>
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
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On 2020-08-12, Petr Mladek <pmladek@suse.com> wrote:
> So, I have one crazy idea to add one more state bit so that we
> could have:
>
>   + committed: set when the data are written into the data ring.
>   + final: set when the data block could not longer get reopened
>   + reuse: set when the desctiptor/data block could get reused
>
> "final" bit will define when the descriptor could not longer
> get reopened (cleared committed bit) and the data block could
> not get extended.

I had not thought of extending data blocks. That is clever!

I implemented this solution for myself and am currently running more
tests. Some things that I changed from your suggestion:

1. I created a separate prb_reserve_cont() function. The reason for this
is because the caller needs to understand what is happening. The caller
is getting an existing record with existing data and must append new
data. The @text_len field of the info reports how long the existing data
is. So the LOG_CONT handling code in printk.c looks something like this:

        if (lflags & LOG_CONT) {
                struct prb_reserved_entry e;
                struct printk_record r;

                prb_rec_init_wr(&r, text_len, 0);

                if (prb_reserve_cont(&e, prb, &r, caller_id)) {
                        memcpy(&r.text_buf[r.info->text_len], text, text_len);
                        r.info->text_len += text_len;

                        if (lflags & LOG_NEWLINE)
                                r.info->flags |= LOG_NEWLINE;

                        if (r.info->flags & LOG_NEWLINE)
                                prb_commit_finalize(&e);
                        else
                                prb_commit(&e);

                        return text_len;
                }
        }

This seemed simpler than trying to extend prb_reserve() to secretly
support LOG_CONT records.

2. I haven't yet figured out how to preserve calling context when a
newline appears. For example:

pr_info("text");
pr_cont(" 1");
pr_cont(" 2\n");
pr_cont("3");
pr_cont(" 4\n");

For "3" the calling context (info, timestamp) is lost because with "2"
the record is finalized. Perhaps the above is invalid usage of LOG_CONT?

3. There are some memory barriers introduced, but it looks like it
shouldn't add too much complexity.

I will continue to refine my working version and post a patch so that we
have something to work with. This looks to be the most promising way
forward. Thanks.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
