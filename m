Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lS9KP-00BjJi-QT
 for kexec@lists.infradead.org; Fri, 02 Apr 2021 02:14:32 +0000
Received: by mail-pg1-x533.google.com with SMTP id k8so2746046pgf.4
 for <kexec@lists.infradead.org>; Thu, 01 Apr 2021 19:14:28 -0700 (PDT)
Date: Fri, 2 Apr 2021 11:14:18 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH printk v2 2/5] printk: remove safe buffers
Message-ID: <YGZ9+kfQKxASmVDR@google.com>
References: <20210330153512.1182-1-john.ogness@linutronix.de>
 <20210330153512.1182-3-john.ogness@linutronix.de>
 <YGW63/elFr/gYW1u@alley> <87a6qiqgzr.fsf@jogness.linutronix.de>
 <YGXV8LJarjUJDhvy@alley>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YGXV8LJarjUJDhvy@alley>
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
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Nicholas Piggin <npiggin@gmail.com>, Alistair Popple <alistair@popple.id.au>, Jordan Niethe <jniethe5@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, Alexey Kardashevskiy <aik@ozlabs.ru>, Yue Hu <huyue2@yulong.com>, Rafael Aquini <aquini@redhat.com>, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, "Paul E. McKenney" <paulmck@kernel.org>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org

On (21/04/01 16:17), Petr Mladek wrote:
> > For the long term, we should introduce a printk-context API that allows
> > callers to perfectly pack their multi-line output into a single
> > entry. We discussed [0][1] this back in August 2020.
> 
> We need a "short" term solution. There are currently 3 solutions:
> 
> 1. Keep nmi_safe() and all the hacks around.
> 
> 2. Serialize nmi_cpu_backtrace() by a spin lock and later by
>    the special lock used also by atomic consoles.
> 
> 3. Tell complaining people how to sort the messed logs.

Are we talking about nmi_cpu_backtrace()->dump_stack() or some
other path?

dump_stack() seems to be already serialized by `dump_lock`. Hmm,
show_regs() is not serialized, seems like it should be under the
same `dump_lock` as dump_stack().

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
