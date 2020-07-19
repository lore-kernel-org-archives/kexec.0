Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxAPf-0003vR-JD
 for kexec@lists.infradead.org; Sun, 19 Jul 2020 14:35:36 +0000
Received: by mail-pg1-x543.google.com with SMTP id l63so9079578pge.12
 for <kexec@lists.infradead.org>; Sun, 19 Jul 2020 07:35:35 -0700 (PDT)
Date: Sun, 19 Jul 2020 23:35:27 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 2/4] printk: store instead of processing cont parts
Message-ID: <20200719143527.GA566@jagdpanzerIV.localdomain>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <20200717234818.8622-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200717234818.8622-3-john.ogness@linutronix.de>
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

On (20/07/18 01:54), John Ogness wrote:
> ---
>  kernel/printk/printk.c | 114 ++++-------------------------------------
>  1 file changed, 11 insertions(+), 103 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index fec71229169e..c4274c867771 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -495,9 +495,14 @@ static void truncate_msg(u16 *text_len, u16 *trunc_msg_len)
>  		*trunc_msg_len = 0;
>  }
>  
> +static inline u32 printk_caller_id(void)
> +{
> +	return in_task() ? task_pid_nr(current) :
> +		0x80000000 + raw_smp_processor_id();
> +}

Can we merge lines that we don't want to merge?

   pr_cont()  ->  IRQ -> pr_cont() -> NMI -> pr_cont()

                  |__________________________________|
   different       same 0x80000000 + cpu_id caller id
   caller id

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
