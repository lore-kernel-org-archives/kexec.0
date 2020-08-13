Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k67uV-0003JA-VY
 for kexec@lists.infradead.org; Thu, 13 Aug 2020 07:44:28 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
In-Reply-To: <20200813051853.GA510@jagdpanzerIV.localdomain>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de> <20200811160551.GC12903@alley>
 <20200812163908.GH12903@alley> <87v9hn2y1p.fsf@jogness.linutronix.de>
 <20200813051853.GA510@jagdpanzerIV.localdomain>
Date: Thu, 13 Aug 2020 09:50:25 +0206
Message-ID: <875z9nvvl2.fsf@jogness.linutronix.de>
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
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On 2020-08-13, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> This is not an unseen pattern, I'm afraid. And the problem here can
> be more general:
>
> 	pr_info("text");
> 	pr_cont("1");
> 	exception/IRQ/NMI
> 		pr_alert("text\n");
> 	pr_cont("2");
> 	pr_cont("\n");
>
> I guess the solution would be to store "last log_level" in task_struct
> and get current (new) timestamp for broken cont line?

(Warning: new ideas ahead)

The fundamental problem is that there is no real association between
the cont parts. So any interruption results in a broken record. If we
really want to do this correctly, we need real association.

With the new finalize flag for records, I thought about perhaps adding
support for chaining data blocks.

A data block currently stores an unsigned long for the ID of the
associated descriptor. But it could optionally include a second unsigned
long, which is the lpos of the next text part. All the data blocks of a
chain would point back to the same descriptor. The descriptor would only
point to the first data block of the chain and include a flag that it is
using chained data blocks.

Then we would only need to track the sequence number of the open record
and new data blocks could be added to the data block chain of the
correct record. Readers cannot see the record until it is finalized.

Also, since only finalized records can be invalidated, there are no
races of chains becoming invalidated while being appended.

My concerns about this idea:

- What if the printk user does not correctly terminate the cont message?
  There is no mechanism to allow that open record to be force-finalized
  so that readers can read newer records.

- For tasks, the sequence number of the open record could be stored on
  the task_struct. For non-tasks, we could use a global per-cpu variable
  where each CPU stores 2 sequence numbers: the sequence number of the
  open record for the non-task and the sequence number of the open
  record for an interrupting NMI. Is that sufficient?

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
