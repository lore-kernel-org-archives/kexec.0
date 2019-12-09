Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ieFRc-0008Kb-KE
 for kexec@lists.infradead.org; Mon, 09 Dec 2019 09:35:10 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH v5 1/3] printk-rb: new printk ringbuffer
 implementation (writer)
References: <20191128015235.12940-1-john.ogness@linutronix.de>
 <20191128015235.12940-2-john.ogness@linutronix.de>
 <20191209092756.GH88619@google.com>
Date: Mon, 09 Dec 2019 10:34:59 +0100
In-Reply-To: <20191209092756.GH88619@google.com> (Sergey Senozhatsky's message
 of "Mon, 9 Dec 2019 18:27:56 +0900")
Message-ID: <87muc1zvss.fsf@linutronix.de>
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
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Petr Mladek <pmladek@suse.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, kexec@lists.infradead.org

On 2019-12-09, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>> + * Sample reader code::
>> + *
>> + *	struct printk_info info;
>> + *	char text_buf[32];
>> + *	char dict_buf[32];
>> + *	u64 next_seq = 0;
>> + *	struct printk_record r = {
>> + *		.info		= &info,
>> + *		.text_buf	= &text_buf[0],
>> + *		.dict_buf	= &dict_buf[0],
>> + *		.text_buf_size	= sizeof(text_buf),
>> + *		.dict_buf_size	= sizeof(dict_buf),
>> + *	};
>> + *
>> + *	while (prb_read_valid(&rb, next_seq, &r)) {
>> + *		if (info.seq != next_seq)
>> + *			pr_warn("lost %llu records\n", info.seq - next_seq);
>> + *
>> + *		if (info.text_len > r.text_buf_size) {
>> + *			pr_warn("record %llu text truncated\n", info.seq);
>> + *			text_buf[sizeof(text_buf) - 1] = 0;
>> + *		}
>> + *
>> + *		if (info.dict_len > r.dict_buf_size) {
>> + *			pr_warn("record %llu dict truncated\n", info.seq);
>> + *			dict_buf[sizeof(dict_buf) - 1] = 0;
>> + *		}
>> + *
>> + *		pr_info("%llu: %llu: %s;%s\n", info.seq, info.ts_nsec,
>> + *			&text_buf[0], info.dict_len ? &dict_buf[0] : "");
>> + *
>> + *		next_seq = info.seq + 1;
>> + *	}
>> + */
>
> Will this loop ever end? :)
>
> pr_info() adds data to ringbuffer, which prb_read_valid() reads, so
> pr_info() can add more data, which prb_read_valid() will read, so
> pr_info()...

The sample code is assuming that @rb is not the same ringbuffer used by
kernel/printk/printk.c. (For example, the test module is doing that to
stress test the ringbuffer code without actually affecting printk.) I
can add a sentence to clarify that.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
