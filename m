Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ic90p-0005Jc-5z
 for kexec@lists.infradead.org; Tue, 03 Dec 2019 14:18:48 +0000
Date: Tue, 3 Dec 2019 09:18:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH v5 1/3] printk-rb: new printk ringbuffer
 implementation (writer)
Message-ID: <20191203091843.678461e4@gandalf.local.home>
In-Reply-To: <20191203011721.GH93017@google.com>
References: <20191128015235.12940-1-john.ogness@linutronix.de>
 <20191128015235.12940-2-john.ogness@linutronix.de>
 <20191202154841.qikvuvqt4btudxzg@pathway.suse.cz>
 <20191202155955.meawljmduiciw5t2@pathway.suse.cz>
 <87sgm2fzuh.fsf@linutronix.de> <20191203011721.GH93017@google.com>
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
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, kexec@lists.infradead.org

On Tue, 3 Dec 2019 10:17:21 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> > > BTW: If I am counting correctly. The ABA problem would happen when
> > > exactly 2^30 (1G) messages is written in the mean time.  
> > 
> > All the ringbuffer code assumes that the use of index numbers handles
> > the ABA problem (i.e. there must not be 1 billion printk's within an
> > NMI). If we want to support 1 billion+ printk's within an NMI, then
> > perhaps the index number should be increased. For 64-bit systems it
> > would be no problem to go to 62 bits. For 32-bit systems, I don't know
> > how well the 64-bit atomic operations are supported.  
> 
> ftrace dumps from NMI (DUMP_ALL type ftrace_dump_on_oops on a $BIG
> machine)? 1G seems large enough, but who knows.

ftrace dump from NMI is the most likely case to hit this, but when that
happens, you are in debugging mode, and the system usually becomes
unreliable at this moment. I agree with Petr, that we should not
complicate the code more to handle this theoretical condition.

-- Steve

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
