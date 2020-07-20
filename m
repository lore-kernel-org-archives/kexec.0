Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxWe4-0002Kz-Rm
 for kexec@lists.infradead.org; Mon, 20 Jul 2020 14:19:57 +0000
Received: by mail-wm1-x341.google.com with SMTP id q15so22457642wmj.2
 for <kexec@lists.infradead.org>; Mon, 20 Jul 2020 07:19:56 -0700 (PDT)
Date: Mon, 20 Jul 2020 16:19:49 +0200
From: Marco Elver <elver@google.com>
Subject: Re: [PATCH][next] printk: ringbuffer: support dataless records
Message-ID: <20200720141949.GA2471546@elver.google.com>
References: <20200720140111.19935-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200720140111.19935-1-john.ogness@linutronix.de>
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
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Jul 20, 2020 at 04:07PM +0206, John Ogness wrote:
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
> Fixes: ("printk: use the lockless ringbuffer")
> Fixes: https://lkml.kernel.org/r/20200718121053.GA691245@elver.google.com
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  based on next-20200720
> 
>  kernel/printk/printk_ringbuffer.c | 58 ++++++++++++++-----------------
>  kernel/printk/printk_ringbuffer.h | 15 ++++----
>  2 files changed, 35 insertions(+), 38 deletions(-)

Thanks! Ran a couple tests and sanitizer report blank lines are back
where they're expected.

Tested-by: Marco Elver <elver@google.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
