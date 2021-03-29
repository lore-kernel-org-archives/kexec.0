Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lQtaD-000jDO-56
 for kexec@lists.infradead.org; Mon, 29 Mar 2021 15:13:57 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH next v1 2/3] printk: remove safe buffers
In-Reply-To: <87sg4e6lo5.fsf@jogness.linutronix.de>
References: <20210316233326.10778-1-john.ogness@linutronix.de>
 <20210316233326.10778-3-john.ogness@linutronix.de> <YFnHKlCvIA2nI41c@alley>
 <87pmzmi2xm.fsf@jogness.linutronix.de> <YGGmNu5ilDnSKH3g@alley>
 <87sg4e6lo5.fsf@jogness.linutronix.de>
Date: Mon, 29 Mar 2021 17:13:30 +0200
Message-ID: <87o8f26lid.fsf@jogness.linutronix.de>
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
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Alistair Popple <alistair@popple.id.au>, Jordan Niethe <jniethe5@gmail.com>, Peter Zijlstra <peterz@infradead.org>, =?utf-8?Q?C?= =?utf-8?Q?=C3=A9dric?= Le Goater <clg@kaod.org>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Yue Hu <huyue2@yulong.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Rafael Aquini <aquini@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, "Guilherme G.
 Piccoli" <gpiccoli@canonical.com>, "Paul E. McKenney" <paulmck@kernel.org>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org

On 2021-03-29, John Ogness <john.ogness@linutronix.de> wrote:
>> Will you call console write() callback with irq enabled from the
>> kthread?
>
> No. That defeats the fundamental purpose of this entire rework
> excercise. ;-)

Sorry, I misread your question. The answer is "yes". We want to avoid a
local_irq_save() when calling into console->write().

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
