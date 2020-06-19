Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jmAqA-0006ff-EJ
 for kexec@lists.infradead.org; Fri, 19 Jun 2020 06:49:31 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH] printk: _printk_rb_static_dict can be static
References: <20200618144919.9806-4-john.ogness@linutronix.de>
 <20200618182323.GA72993@4e49555bcca1>
Date: Fri, 19 Jun 2020 08:49:21 +0200
In-Reply-To: <20200618182323.GA72993@4e49555bcca1> (kernel test robot's
 message of "Fri, 19 Jun 2020 02:23:23 +0800")
Message-ID: <871rmbim8e.fsf@vostro.fn.ogness.net>
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
To: kernel test robot <lkp@intel.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, Petr Mladek <pmladek@suse.com>, kbuild-all@lists.01.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>

On 2020-06-18, kernel test robot <lkp@intel.com> wrote:
> Signed-off-by: kernel test robot <lkp@intel.com>
> ---
>  printk.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 7642ef634956f..d812ada06735f 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -434,7 +434,7 @@ static u32 log_buf_len = __LOG_BUF_LEN;
>   */
>  #define PRB_AVGBITS 5	/* 32 character average length */
>  
> -_DECLARE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
> +static _DECLARE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
>  		  PRB_AVGBITS, PRB_AVGBITS, &__log_buf[0]);

_DECLARE_PRINTKRB declares multiple variables, so this patch will not
work as intended. I would like to declare the variables static but am
not sure how best to go about it.

In the Linux source I see examples of macros just desclaring the
variables static. And I see examples of the macros providing a parameter
where the "static" keyword can be specified.

Since the ringbuffer was created exclusively to serve printk, I would
prefer to just have _DECLARE_PRINTKRB (and DECLARE_PRINTKRB) declare all
the variables as static.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
