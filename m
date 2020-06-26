Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jopso-0005gv-1F
 for kexec@lists.infradead.org; Fri, 26 Jun 2020 15:03:15 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: buffer allocation: was: [PATCH v3 3/3] printk: use the lockless
 ringbuffer
References: <20200618144919.9806-1-john.ogness@linutronix.de>
 <20200618144919.9806-4-john.ogness@linutronix.de>
 <20200625082838.GF6156@alley>
Date: Fri, 26 Jun 2020 17:02:48 +0200
In-Reply-To: <20200625082838.GF6156@alley> (Petr Mladek's message of "Thu, 25
 Jun 2020 10:28:38 +0200")
Message-ID: <87sgeh3m5j.fsf@jogness.linutronix.de>
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
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -1176,11 +1068,46 @@ static void __init set_percpu_data_ready(void)
>>  	__printk_percpu_data_ready = true;
>>  }
>>  
>> +static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
>> +				     struct printk_record *r)
>> +{
>> +	struct prb_reserved_entry e;
>> +	struct printk_record dest_r;
>> +
>> +	prb_rec_init_wr(&dest_r, r->info->text_len, r->info->dict_len);
>> +
>> +	if (!prb_reserve(&e, rb, &dest_r))
>> +		return 0;
>> +
>> +	memcpy(&dest_r.text_buf[0], &r->text_buf[0], dest_r.text_buf_size);
>> +	if (dest_r.dict_buf) {
>> +		memcpy(&dest_r.dict_buf[0], &r->dict_buf[0],
>> +		       dest_r.dict_buf_size);
>> +	}
>> +	dest_r.info->facility = r->info->facility;
>> +	dest_r.info->level = r->info->level;
>> +	dest_r.info->flags = r->info->flags;
>> +	dest_r.info->ts_nsec = r->info->ts_nsec;
>> +	dest_r.info->caller_id = r->info->caller_id;
>> +
>> +	prb_commit(&e);
>> +
>> +	return prb_record_text_space(&e);
>> +}
>> +
>> +static char setup_text_buf[CONSOLE_EXT_LOG_MAX] __initdata;
>> +static char setup_dict_buf[CONSOLE_EXT_LOG_MAX] __initdata;
>> +
>>  void __init setup_log_buf(int early)
>>  {
>> +	struct prb_desc *new_descs;
>> +	struct printk_info info;
>> +	struct printk_record r;
>>  	unsigned long flags;
>> +	char *new_dict_buf;
>>  	char *new_log_buf;
>>  	unsigned int free;
>> +	u64 seq;
>>  
>>  	/*
>>  	 * Some archs call setup_log_buf() multiple times - first is very
>> @@ -1201,17 +1128,50 @@ void __init setup_log_buf(int early)
>>  
>>  	new_log_buf = memblock_alloc(new_log_buf_len, LOG_ALIGN);
>>  	if (unlikely(!new_log_buf)) {
>> -		pr_err("log_buf_len: %lu bytes not available\n",
>> +		pr_err("log_buf_len: %lu text bytes not available\n",
>>  			new_log_buf_len);
>>  		return;
>>  	}
>>  
>> +	new_dict_buf = memblock_alloc(new_log_buf_len, LOG_ALIGN);
>> +	if (unlikely(!new_dict_buf)) {
>> +		/* dictionary failure is allowed */
>> +		pr_err("log_buf_len: %lu dict bytes not available\n",
>> +			new_log_buf_len);
>> +	}
>> +
>> +	new_descs = memblock_alloc((new_log_buf_len >> PRB_AVGBITS) *
>> +				   sizeof(struct prb_desc), LOG_ALIGN);
>> +	if (unlikely(!new_descs)) {
>> +		pr_err("log_buf_len: %lu desc bytes not available\n",
>> +			new_log_buf_len >> PRB_AVGBITS);
>> +		if (new_dict_buf)
>> +			memblock_free(__pa(new_dict_buf), new_log_buf_len);
>> +		memblock_free(__pa(new_log_buf), new_log_buf_len);
>> +		return;
>> +	}
>> +
>> +	prb_rec_init_rd(&r, &info,
>> +			&setup_text_buf[0], sizeof(setup_text_buf),
>> +			&setup_dict_buf[0], sizeof(setup_dict_buf));
>> +
>>  	logbuf_lock_irqsave(flags);
>> +
>> +	prb_init(&printk_rb_dynamic,
>> +		 new_log_buf, bits_per(new_log_buf_len) - 1,
>> +		 new_dict_buf, bits_per(new_log_buf_len) - 1,
>
> This does not check whether new_dict_buf was really allocated.

Thank you.

> I suggest to make it easy and switch to the new buffers only when
> all three could get allocated.

Agreed.

> Well, I still feel a bit uneasy about these PRB_AVGBITS operations,
> including new_log_buf_len >> PRB_AVGBITS used above.
>
> A more safe design would be to add some sanity checks at the beginning
> of the function. And maybe convert new_log_buf_let to number of bits.
> Then operate with the number of bits in the rest of the function.  It
> might be easier to make sure that we are on the safe side.

I will clean it up with additional checks and temporary variables.

>>  	log_buf_len = new_log_buf_len;
>>  	log_buf = new_log_buf;
>>  	new_log_buf_len = 0;
>> -	free = __LOG_BUF_LEN - log_next_idx;
>> -	memcpy(log_buf, __log_buf, __LOG_BUF_LEN);
>> +
>> +	free = __LOG_BUF_LEN;
>> +	prb_for_each_record(0, &printk_rb_static, seq, &r)
>> +		free -= add_to_rb(&printk_rb_dynamic, &r);
>> +
>> +	prb = &printk_rb_dynamic;
>
> This might deserve a comment that this is safe (no lost message)
> because it is called early enough when everything is still running
> on the boot CPU.

I will add a comment and an extra check to make sure.

Once everything is lockless, new messages could appear (for example, due
to NMI messages). The simple check should probably change to a loop. But
let us not worry about that at this point.

Below is a new version of the relevant patch snippets against mainline
just to show you how I plan to make it look for the next version.

John Ogness

--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ @@
+#define PRB_AVGBITS 5	/* 32 character average length */
+
+#if CONFIG_LOG_BUF_SHIFT <= PRB_AVGBITS
+#error CONFIG_LOG_BUF_SHIFT value too small.
+#endif
+_DEFINE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
+		 PRB_AVGBITS, PRB_AVGBITS, &__log_buf[0]);
+
@@ @@
 void __init setup_log_buf(int early)
 {
+	unsigned int new_descs_count;
+	struct prb_desc *new_descs;
+	struct printk_info info;
+	struct printk_record r;
+	size_t new_descs_size;
 	unsigned long flags;
+	char *new_dict_buf;
 	char *new_log_buf;
 	unsigned int free;
+	u64 seq;
 
 	/*
 	 * Some archs call setup_log_buf() multiple times - first is very
@@ @@ void __init setup_log_buf(int early)
 	if (!new_log_buf_len)
 		return;
 
+	new_descs_count = new_log_buf_len >> PRB_AVGBITS;
+	if (new_descs_count == 0) {
+		pr_err("new_log_buf_len: %lu too small\n", new_log_buf_len);
+		return;
+	}
+
 	new_log_buf = memblock_alloc(new_log_buf_len, LOG_ALIGN);
 	if (unlikely(!new_log_buf)) {
-		pr_err("log_buf_len: %lu bytes not available\n",
-			new_log_buf_len);
+		pr_err("log_buf_len: %lu text bytes not available\n",
+		       new_log_buf_len);
+		return;
+	}
+
+	new_dict_buf = memblock_alloc(new_log_buf_len, LOG_ALIGN);
+	if (unlikely(!new_dict_buf)) {
+		pr_err("log_buf_len: %lu dict bytes not available\n",
+		       new_log_buf_len);
+		memblock_free(__pa(new_log_buf), new_log_buf_len);
 		return;
 	}
 
+	new_descs_size = new_descs_count * sizeof(struct prb_desc);
+	new_descs = memblock_alloc(new_descs_size, LOG_ALIGN);
+	if (unlikely(!new_descs)) {
+		pr_err("log_buf_len: %lu desc bytes not available\n",
+		       new_descs_size);
+		memblock_free(__pa(new_dict_buf), new_log_buf_len);
+		memblock_free(__pa(new_log_buf), new_log_buf_len);
+		return;
+	}
+
+	prb_rec_init_rd(&r, &info,
+			&setup_text_buf[0], sizeof(setup_text_buf),
+			&setup_dict_buf[0], sizeof(setup_dict_buf));
+
+	prb_init(&printk_rb_dynamic,
+		 new_log_buf, order_base_2(new_log_buf_len),
+		 new_dict_buf, order_base_2(new_log_buf_len),
+		 new_descs, order_base_2(new_descs_count));
+
 	logbuf_lock_irqsave(flags);
+
 	log_buf_len = new_log_buf_len;
 	log_buf = new_log_buf;
 	new_log_buf_len = 0;
-	free = __LOG_BUF_LEN - log_next_idx;
-	memcpy(log_buf, __log_buf, __LOG_BUF_LEN);
+
+	free = __LOG_BUF_LEN;
+	prb_for_each_record(0, &printk_rb_static, seq, &r)
+		free -= add_to_rb(&printk_rb_dynamic, &r);
+
+	/*
+	 * This is early enough that everything is still running on the
+	 * boot CPU and interrupts are disabled. So no new messages will
+	 * appear during this switch.
+	 */
+	prb = &printk_rb_dynamic;
+
 	logbuf_unlock_irqrestore(flags);
 
+	/* Verify no messages were dropped. */
+	if (seq != prb_next_seq(&printk_rb_static)) {
+		pr_err("dropped %llu messages\n",
+		       prb_next_seq(&printk_rb_static) - seq);
+	}
+
 	pr_info("log_buf_len: %u bytes\n", log_buf_len);
 	pr_info("early log buf free: %u(%u%%)\n",
 		free, (free * 100) / __LOG_BUF_LEN);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
