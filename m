Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAug9-0006gl-4d
 for kexec@lists.infradead.org; Wed, 26 Aug 2020 12:37:25 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v2 5/7][next] printk: ringbuffer: add
 finalization/extension support
In-Reply-To: <20200826100113.GA8849@jagdpanzerIV.localdomain>
References: <20200824103538.31446-1-john.ogness@linutronix.de>
 <20200824103538.31446-6-john.ogness@linutronix.de>
 <87lfi1ls2g.fsf@jogness.linutronix.de>
 <20200826100113.GA8849@jagdpanzerIV.localdomain>
Date: Wed, 26 Aug 2020 14:43:22 +0206
Message-ID: <87eentlh19.fsf@jogness.linutronix.de>
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
Cc: Andrea Parri <parri.andrea@gmail.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On 2020-08-26, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
>>> @@ -1157,6 +1431,14 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
>>>  		goto fail;
>>>  	}
>>>  
>>> +	/*
>>> +	 * New data is about to be reserved. Once that happens, previous
>>> +	 * descriptors are no longer able to be extended. Finalize the
>>> +	 * previous descriptor now so that it can be made available to
>>> +	 * readers (when committed).
>>> +	 */
>>> +	desc_finalize(desc_ring, DESC_ID(id - 1));
>>> +
>>>  	d = to_desc(desc_ring, id);
>>>  
>>>  	/*
>> 
>> Apparently this is not enough to guarantee that past descriptors are
>> finalized. I am able to reproduce a scenario where the finalization
>> of a certain descriptor never happens. That leaves the descriptor
>> permanently in the reserved queried state, which prevents any new
>> records from being created. I am investigating.
>
> Good to know. I also run into problems:
> - broken dmesg (and broken journalctl -f /dev/kmsg poll) and broken
>   syslog read
>
> $ strace dmesg
>
> ...
> openat(AT_FDCWD, "/dev/kmsg", O_RDONLY|O_NONBLOCK) = 3
> lseek(3, 0, SEEK_DATA)                  = 0
> read(3, 0x55dda8c240a8, 8191)           = -1 EAGAIN (Resource temporarily unavailable)
> close(3)                                = 0
> syslog(10 /* SYSLOG_ACTION_SIZE_BUFFER */) = 524288
> mmap(NULL, 528384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f43ea847000
> syslog(3 /* SYSLOG_ACTION_READ_ALL */, "", 524296) = 0

Yes, this a consequence of the problem. The tail is in the reserved
queried state, so readers will not advance beyond it.

This series makes a very naive assumption that the previous descriptor
is either in the reserved or committed queried states. The fact is, it
can be in any of the 4 queried states. Adding support for finalization
of all the states then gets quite complex, since any state transition
(cmpxchg) may have to deal with an unexpected FINAL flag.

The ringbuffer was designed so that descriptors are completely
self-contained. So adding logic where an action on one descriptor should
affect another descriptor is far more complex than I initially expected.

Keep in mind the finalization concept satisfies 3 things:

- denote if a record can be extended (i.e. transition back to reserved)
- denote if a reader may read the record
- denote if a writer may recycle a record

I have not yet given up on the idea of finalization (particularly
because it allows mainline LOG_CONT behavior to be preserved locklessy),
but I am no longer sure if this is the direction we want to take.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
