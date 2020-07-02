Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqv6a-0005qF-PS
 for kexec@lists.infradead.org; Thu, 02 Jul 2020 09:02:05 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v3 3/3] printk: use the lockless ringbuffer
In-Reply-To: <ba338fab-9e98-366b-8fd4-05d4daa14f6d@redhat.com>
References: <20200618144919.9806-1-john.ogness@linutronix.de>
 <20200618144919.9806-4-john.ogness@linutronix.de>
 <ba338fab-9e98-366b-8fd4-05d4daa14f6d@redhat.com>
Date: Thu, 02 Jul 2020 11:08:02 +0206
Message-ID: <87zh8imgs5.fsf@jogness.linutronix.de>
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
To: lijiang <lijiang@redhat.com>, Petr Mladek <pmladek@suse.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On 2020-07-02, lijiang <lijiang@redhat.com> wrote:
> About the VMCOREINFO part, I made some tests based on the kernel patch
> v3, the makedumpfile and crash-utility can work as expected with your
> patch(userspace patch), but, unfortunately, the vmcore-dmesg(kexec-tools)
> can't correctly read the printk ring buffer information, and get the
> following error:
>
> "Missing the log_buf symbol"
>
> The kexec-tools(vmcore-dmesg) should also have a similar patch, just like
> in the makedumpfile and crash-utility.

Yes, a patch for this is needed (as well as for any other related
software floating around the internet).

I have no RFC patches for vmcore-dmesg. Looking at the code, I think it
would be quite straight forward to port the makedumpfile patch. I will
try to make some time for this.

I do not want to patch any other software for this. I think with 3
examples (crash, makedumpfile, vmcore-dmesg), others should be able to
implement the changes to their software without needing my help.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
