Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtLEn-0004Uc-VU
 for kexec@lists.infradead.org; Thu, 09 Jul 2020 01:20:34 +0000
Received: by mail-pj1-x1042.google.com with SMTP id t15so343686pjq.5
 for <kexec@lists.infradead.org>; Wed, 08 Jul 2020 18:20:33 -0700 (PDT)
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Date: Thu, 9 Jul 2020 10:20:31 +0900
Subject: Re: [PATCH v4 3/4] Revert "printk: lock/unlock console only for new
 logbuf entries"
Message-ID: <20200709012031.GA580805@jagdpanzerIV.localdomain>
References: <20200707145932.8752-1-john.ogness@linutronix.de>
 <20200707145932.8752-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200707145932.8752-4-john.ogness@linutronix.de>
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
Cc: Andrea Parri <parri.andrea@gmail.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On (20/07/07 17:05), John Ogness wrote:
> This reverts commit 3ac37a93fa9217e576bebfd4ba3e80edaaeb2289.
> 
> This optimization will not apply once the transition to a lockless
> printk is complete. Rather than porting this optimization through
> the transition only to remove it anyway, just revert it now to
> simplify the transition.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
