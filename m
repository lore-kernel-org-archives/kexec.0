Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxpY2-0001uj-Mk
 for kexec@lists.infradead.org; Tue, 21 Jul 2020 10:30:59 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH][next] printk: ringbuffer: support dataless records
In-Reply-To: <20200721025450.GA5678@jagdpanzerIV.localdomain>
References: <20200720140111.19935-1-john.ogness@linutronix.de>
 <20200721025450.GA5678@jagdpanzerIV.localdomain>
Date: Tue, 21 Jul 2020 12:36:55 +0206
Message-ID: <87lfjdw468.fsf@jogness.linutronix.de>
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
Cc: Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On 2020-07-21, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
>> @@ -1402,7 +1396,9 @@ static int prb_read(struct printk_ringbuffer *rb, u64 seq,
>>  	/* Copy text data. If it fails, this is a data-less record. */
>>  	if (!copy_data(&rb->text_data_ring, &desc.text_blk_lpos, desc.info.text_len,
>>  		       r->text_buf, r->text_buf_size, line_count)) {
>> -		return -ENOENT;
>> +		/* Report an error if there should have been data. */
>> +		if (desc.info.text_len != 0)
>> +			return -ENOENT;
>>  	}
>
> If this is a dataless record then should copy_data() return error?

You are correct. That makes more sense. I will send a v2.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
