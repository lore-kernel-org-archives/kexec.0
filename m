Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtphv-00085X-Us
 for kexec@lists.infradead.org; Fri, 10 Jul 2020 09:52:55 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v4 0/4] printk: replace ringbuffer
In-Reply-To: <20200710091137.GN4751@alley>
References: <20200707145932.8752-1-john.ogness@linutronix.de>
 <20200708152005.GF4751@alley> <87wo3d9nlo.fsf@jogness.linutronix.de>
 <20200710091137.GN4751@alley>
Date: Fri, 10 Jul 2020 11:58:34 +0206
Message-ID: <87o8onhf31.fsf@jogness.linutronix.de>
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
Cc: Andrea Parri <parri.andrea@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On 2020-07-10, Petr Mladek <pmladek@suse.com> wrote:
>> The next series in the printk-rework (move LOG_CONT handling from
>> writers to readers) makes some further changes that, while not
>> incompatible, could affect the output of existing tools. It may be a
>> good idea to let the new ringbuffer sit in linux-next until the next
>> series has been discussed/reviewed/merged. After the next series,
>> everything will be in place (with regard to userspace tools) to
>> finish the rework.
>
> I know that it might be premature question. But I wonder what kind
> of changes are expected because of the continuous lines.

I will be posting the next series quite soon, so I think it will be
better to discuss it when we have a working example in front of us.

> Do you expect some changes in the ring buffer structures so that
> the debugging tools would need yet another update to actually
> access the data?

The next series will be modifying the ringbuffer to allow data-less
records. This is necessary to support the thousands of

    pr_cont("\n");

calls in the kernel code. Failed dataring allocations will still be
detected because the message flags for those records will be 0. For the
above pr_cont() line, they will be LOG_NEWLINE|LOG_CONT.

Since the dump tools need to make changes for the new ringbuffer anyway,
I think it would be good to hammer out the accepted LOG_CONT
implementation first, just in case we do need to make any subtle
internal changes.

> Or do you expect backward compatible changes that would allow
> to pass related parts of the continuous lines via syslog/dev_kmsg
> interface and join them later in userspace?

For users of console, non-extended netconsole, syslog, and kmsg_dump,
there will be no external changes whatsoever. These interfaces have no
awareness of sequence numbers, which will allow the kernel to
re-assemble the LOG_CONT messages for them.

Users of /dev/kmsg and extended netconsole see sequence numbers. Offlist
we discussed various hacks how to get around this without causing errors
for existing software, but it was all ugly.

IMHO users of these sequence number interfaces need to see all the
records individually and reassemble the LOG_CONT messages themselves if
they want to. I believe that is the only sane path forward. To do this,
the caller id will no longer be optional to the sequence number output
since that is vital information to re-assemble the LOG_CONT messages.

Keep in mind that current software already needs to be able to handle
the caller id being shown. Also, currently in mainline there is no
guarantee that LOG_CONT messages are contiguous. So current software
must also be ready to accept broken up LOG_CONT messages. This is why I
think it would be acceptable to make this change for /dev/kmsg and
extended netconsole. But I understand it is controversial since tools
like systemd and dmesg use /dev/kmsg. Until they are modified to
re-assemble LOG_CONT messages, they will present the user with the
ugliness of LOG_CONT pieces (always, rather than as is now rarely).

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
