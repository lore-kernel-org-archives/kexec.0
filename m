Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jzytI-0003P7-5D
 for kexec@lists.infradead.org; Mon, 27 Jul 2020 08:53:49 +0000
Received: by mail-pj1-x1041.google.com with SMTP id gc9so8912631pjb.2
 for <kexec@lists.infradead.org>; Mon, 27 Jul 2020 01:53:47 -0700 (PDT)
Date: Mon, 27 Jul 2020 17:53:43 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v2][next] printk: ringbuffer: support dataless records
Message-ID: <20200727085343.GF1386@jagdpanzerIV.localdomain>
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
Cc: Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On (20/07/21 15:31), John Ogness wrote:
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
> Reported-by: Marco Elver <elver@google.com>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Applied to printk-rework, thanks.

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
