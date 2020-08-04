Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2txP-0006Dv-0M
 for kexec@lists.infradead.org; Tue, 04 Aug 2020 10:14:08 +0000
Date: Tue, 4 Aug 2020 12:14:00 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2][next] printk: ringbuffer: support dataless records
Message-ID: <20200804101400.GB24529@alley>
References: <20200721132528.9661-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200721132528.9661-1-john.ogness@linutronix.de>
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
Cc: Marco Elver <elver@google.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On Tue 2020-07-21 15:31:28, John Ogness wrote:
> With commit ("printk: use the lockless ringbuffer"), printk()
> started silently dropping messages without text because such
> records are not supported by the new printk ringbuffer.
> 
> Add support for such records.
> 
> Currently dataless records are denoted by INVALID_LPOS in order
> to recognize failed prb_reserve() calls. Change the ringbuffer
> to instead use two different identifiers (FAILED_LPOS and
> NO_LPOS) to distinguish between failed prb_reserve() records and
> successful dataless records, respectively.
> 
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index 7355ca99e852..0659b50872b5 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
>  static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
>  {
>  	struct prb_data_block *db = NULL;
>  
> -	/*
> -	 * Writers are not allowed to write data-less records. Such records
> -	 * are used only internally by the ringbuffer to denote records where
> -	 * their data failed to allocate or have been lost.
> -	 */
>  	if (size == 0)
> -		return false;
> +		return true;

Nit: This might deserve a comment why size == 0 is handled
     a special way.specially. I think about something like:

	/*
	 * Empty data blocks are handled by special lpos values in
	 * the record descriptor. No space is needed in the data ring.
	 */

or simply

	/* Data-less records take no space in the data ring. */

>  	/*
>  	 * Ensure the alignment padded size could possibly fit in the data

> @@ -1025,6 +1020,10 @@ static char *data_alloc(struct printk_ringbuffer *rb,
>  static unsigned int space_used(struct prb_data_ring *data_ring,
>  			       struct prb_data_blk_lpos *blk_lpos)
>  {
> +	/* Data-less blocks take no space. */
> +	if (LPOS_DATALESS(blk_lpos->begin))
> +		return 0;

Nit: It seems that all the other locations check also blk_lpos->next,
     for example, get_data() does:

	if (LPOS_DATALESS(blk_lpos->begin) && LPOS_DATALESS(blk_lpos->next)) {


     Both approaches are error prone. I would either simplify the
     other locations and check only lpos->begin. But better might
     be to be on the safe side do a paranoid check, like:

bool is_dataless(struct prb_data_blk_lpos *blk_lpos)
{
	if (LPOS_DATALESS(blk_lpos->begin) || LPOS_DATALESS(blk_lpos->next)) {
		WARN_ON_ONCE(blk_lpos->begin != blk_lpos->next);
		return true;
	}

	return false;
}

> +
>  	if (DATA_WRAPS(data_ring, blk_lpos->begin) == DATA_WRAPS(data_ring, blk_lpos->next)) {
>  		/* Data block does not wrap. */
>  		return (DATA_INDEX(data_ring, blk_lpos->next) -

Anyway, the patch looks fine. It is already pushed in
printk/linux.git. So, if you agree with my nits, we should
solve them with separate patches on top of the existing ones.

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
