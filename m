Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ic8vt-00034C-EB
 for kexec@lists.infradead.org; Tue, 03 Dec 2019 14:13:42 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH v5 1/3] printk-rb: new printk ringbuffer
 implementation (writer)
References: <20191128015235.12940-1-john.ogness@linutronix.de>
 <20191128015235.12940-2-john.ogness@linutronix.de>
 <20191202154841.qikvuvqt4btudxzg@pathway.suse.cz>
Date: Tue, 03 Dec 2019 15:13:36 +0100
In-Reply-To: <20191202154841.qikvuvqt4btudxzg@pathway.suse.cz> (Petr Mladek's
 message of "Mon, 2 Dec 2019 16:48:41 +0100")
Message-ID: <87fti1bipb.fsf@linutronix.de>
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
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, kexec@lists.infradead.org

On 2019-12-02, Petr Mladek <pmladek@suse.com> wrote:
>> +/*
>> + * Sanity checker for reserve size. The ringbuffer code assumes that a data
>> + * block does not exceed the maximum possible size that could fit within the
>> + * ringbuffer. This function provides that basic size check so that the
>> + * assumption is safe.
>> + */
>> +static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
>> +{
>> +	struct prb_data_block *db = NULL;
>> +
>> +	/* Writers are not allowed to write data-less records. */
>> +	if (size == 0)
>> +		return false;
>
> I would personally let this decision to the API caller.
>
> The code actually have to support data-less records. They are used
> when the descriptor is reserved but the data block can't get reserved.

Exactly. Data-less records are how the ringbuffer identifies that data
has been lost. If users were allowed to store data-less records, that
destinction is no longer possible (unless I created some extra field in
the descriptor). Does it even make sense for printk to store data-less
records explicitly?

The current printk implementation silently ignores empty messages.

> The above statement might create false feeling that it could not
> happen later in the code. It might lead to bugs in writer code.

Then let me change the statement to describe that data-less records are
used internally by the ringbuffer and cannot be explicitly created by
writers.

> Also reader API users might not expect to get a "valid" data-less
> record.

Readers will never see them. The reader API implementation skips over
data-less records.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
