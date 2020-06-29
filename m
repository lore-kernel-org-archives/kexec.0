Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jq1go-0003oT-1V
 for kexec@lists.infradead.org; Mon, 29 Jun 2020 21:51:46 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: syslog size unread: was: [PATCH v3 3/3] printk: use the lockless
 ringbuffer
References: <20200618144919.9806-1-john.ogness@linutronix.de>
 <20200618144919.9806-4-john.ogness@linutronix.de>
 <20200625152042.GI8444@alley>
Date: Mon, 29 Jun 2020 23:51:40 +0200
In-Reply-To: <20200625152042.GI8444@alley> (Petr Mladek's message of "Thu, 25
 Jun 2020 17:20:42 +0200")
Message-ID: <87k0zp8rrn.fsf@jogness.linutronix.de>
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

On 2020-06-25, Petr Mladek <pmladek@suse.com> wrote:
> On Thu 2020-06-18 16:55:19, John Ogness wrote:
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -1609,11 +1633,15 @@ int do_syslog(int type, char __user *buf, int len, int source)
>>  		break;
>>  	/* Number of chars in the log buffer */
>>  	case SYSLOG_ACTION_SIZE_UNREAD:
>> +		if (source != SYSLOG_FROM_PROC) {
>> +			text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
>> +			if (!text)
>> +				return -ENOMEM;
>
> The buffer is needed only to count lines to count the size of added
> prefixes. Could we use the new prb_read_valid_info() that allows to
> get the number of lines without actually reading the buffer?

Yes!

For the next version I introduce a macro to iterate just the meta data:

#define prb_for_each_info(from, rb, s, i, lc) \
for ((s) = from; prb_read_valid_info(rb, s, i, lc); (s) = (i)->seq + 1)

This can be used in all 3 locations where prb_count_lines() is used. In
all three places, there is no need to be copying the data. And for
SYSLOG_ACTION_SIZE_UNREAD, there is no need for the record and kmalloc'd
buffer.

This also means that prb_count_lines() will become a private static
helper of the ringbuffer.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
