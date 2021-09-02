Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ua1-f42.google.com ([209.85.222.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLpsv-00A2PD-03
 for kexec@lists.infradead.org; Thu, 02 Sep 2021 16:48:18 +0000
Received: by mail-ua1-f42.google.com with SMTP id a14so1270399uao.0
 for <kexec@lists.infradead.org>; Thu, 02 Sep 2021 09:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210715193359.25946-1-john.ogness@linutronix.de>
 <20210715193359.25946-4-john.ogness@linutronix.de>
In-Reply-To: <20210715193359.25946-4-john.ogness@linutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Sep 2021 18:48:04 +0200
Message-ID: <CAMuHMdXa-ahzQX2FMb-YZ9Yc4Z=72JpaN8Z9bC5htmyvEDSh+w@mail.gmail.com>
Subject: Re: [PATCH printk v4 3/6] printk: remove safe buffers
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
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, Alexey Kardashevskiy <aik@ozlabs.ru>, Yue Hu <huyue2@yulong.com>, "Paul E. McKenney" <paulmck@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kexec@lists.infradead.org

Hi John,

On Thu, Jul 15, 2021 at 9:53 PM John Ogness <john.ogness@linutronix.de> wrote:
> With @logbuf_lock removed, the high level printk functions for
> storing messages are lockless. Messages can be stored from any
> context, so there is no need for the NMI and safe buffers anymore.
> Remove the NMI and safe buffers.
>
> Although the safe buffers are removed, the NMI and safe context
> tracking is still in place. In these contexts, store the message
> immediately but still use irq_work to defer the console printing.
>
> Since printk recursion tracking is in place, safe context tracking
> for most of printk is not needed. Remove it. Only safe context
> tracking relating to the console and console_owner locks is left
> in place. This is because the console and console_owner locks are
> needed for the actual printing.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Thank you very much for reducing kernel size by ca. 8 KiB!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
