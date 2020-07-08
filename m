Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtBAK-0007wG-Ec
 for kexec@lists.infradead.org; Wed, 08 Jul 2020 14:35:17 +0000
Date: Wed, 8 Jul 2020 16:35:15 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v4 4/4] printk: use the lockless ringbuffer
Message-ID: <20200708143514.GE4751@alley>
References: <20200707145932.8752-1-john.ogness@linutronix.de>
 <20200707145932.8752-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200707145932.8752-5-john.ogness@linutronix.de>
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
Cc: Andrea Parri <parri.andrea@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On Tue 2020-07-07 17:05:32, John Ogness wrote:
> Replace the existing ringbuffer usage and implementation with
> lockless ringbuffer usage. Even though the new ringbuffer does not
> require locking, all existing locking is left in place. Therefore,
> this change is purely replacing the underlining ringbuffer.
> 
> Changes that exist due to the ringbuffer replacement:
> 
> - The VMCOREINFO has been updated for the new structures.
> 
> - Dictionary data is now stored in a separate data buffer from the
>   human-readable messages. The dictionary data buffer is set to the
>   same size as the message buffer. Therefore, the total required
>   memory for both dictionary and message data is
>   2 * (2 ^ CONFIG_LOG_BUF_SHIFT) for the initial static buffers and
>   2 * log_buf_len (the kernel parameter) for the dynamic buffers.
> 
> - Record meta-data is now stored in a separate array of descriptors.
>   This is an additional 72 * (2 ^ (CONFIG_LOG_BUF_SHIFT - 5)) bytes
>   for the static array and 72 * (log_buf_len >> 5) bytes for the
>   dynamic array.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
