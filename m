Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jmG94-0004pp-W0
 for kexec@lists.infradead.org; Fri, 19 Jun 2020 12:29:24 +0000
Date: Fri, 19 Jun 2020 08:29:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH] printk: _printk_rb_static_dict can be static
Message-ID: <20200619082919.5d604e58@oasis.local.home>
In-Reply-To: <871rmbim8e.fsf@vostro.fn.ogness.net>
References: <20200618144919.9806-4-john.ogness@linutronix.de>
 <20200618182323.GA72993@4e49555bcca1>
 <871rmbim8e.fsf@vostro.fn.ogness.net>
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
To: John Ogness <john.ogness@linutronix.de>
Cc: Andrea Parri <parri.andrea@gmail.com>, Petr Mladek <pmladek@suse.com>, kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>

On Fri, 19 Jun 2020 08:49:21 +0200
John Ogness <john.ogness@linutronix.de> wrote:

> > +++ b/kernel/printk/printk.c
> > @@ -434,7 +434,7 @@ static u32 log_buf_len = __LOG_BUF_LEN;
> >   */
> >  #define PRB_AVGBITS 5	/* 32 character average length */
> >  
> > -_DECLARE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
> > +static _DECLARE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
> >  		  PRB_AVGBITS, PRB_AVGBITS, &__log_buf[0]);  
> 
> _DECLARE_PRINTKRB declares multiple variables, so this patch will not
> work as intended. I would like to declare the variables static but am
> not sure how best to go about it.
> 
> In the Linux source I see examples of macros just desclaring the
> variables static. And I see examples of the macros providing a parameter
> where the "static" keyword can be specified.
> 
> Since the ringbuffer was created exclusively to serve printk, I would
> prefer to just have _DECLARE_PRINTKRB (and DECLARE_PRINTKRB) declare all
> the variables as static.

Haven written macros that do such things, I agree with your last
statement. Just have the macro declare all the variables static.

-- Steve

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
