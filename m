Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKI7D-00082r-NV
 for kexec@lists.infradead.org; Mon, 21 Sep 2020 09:28:08 +0000
Date: Mon, 21 Sep 2020 11:28:03 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH printk v2 1/3] printk: move printk_info into separate array
Message-ID: <20200921092803.GG14605@alley>
References: <20200918223421.21621-1-john.ogness@linutronix.de>
 <20200918223421.21621-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200918223421.21621-2-john.ogness@linutronix.de>
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
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On Sat 2020-09-19 00:40:19, John Ogness wrote:
> The majority of the size of a descriptor is taken up by meta data,
> which is often not of interest to the ringbuffer (for example,
> when performing state checks). Since descriptors are often
> temporarily stored on the stack, keeping their size minimal will
> help reduce stack pressure.
> 
> Rather than embedding the printk_info into the descriptor, create
> a separate printk_info array. The index of a descriptor in the
> descriptor array corresponds to the printk_info with the same
> index in the printk_info array. The rules for validity of a
> printk_info match the existing rules for the data blocks: the
> descriptor must be in a consistent state.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
