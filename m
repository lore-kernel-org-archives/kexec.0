Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icrls-00055Z-8h
 for kexec@lists.infradead.org; Thu, 05 Dec 2019 14:06:21 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH v5 0/3] printk: new ringbuffer implementation
References: <20191128015235.12940-1-john.ogness@linutronix.de>
 <20191205134652.12631-1-prarit@redhat.com>
Date: Thu, 05 Dec 2019 15:05:54 +0100
In-Reply-To: <20191205134652.12631-1-prarit@redhat.com> (Prarit Bhargava's
 message of "Thu, 5 Dec 2019 08:46:52 -0500")
Message-ID: <87zhg6zx31.fsf@linutronix.de>
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
To: Prarit Bhargava <prarit@redhat.com>
Cc: andrea.parri@amarulasolutions.com, pmladek@suse.com, sergey.senozhatsky.work@gmail.com, peterz@infradead.org, gregkh@linuxfoundation.org, brendanhiggins@google.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org, sergey.senozhatsky@gmail.com, tglx@linutronix.de, torvalds@linux-foundation.org, kexec@lists.infradead.org

Hi Prarit,

On 2019-12-05, Prarit Bhargava <prarit@redhat.com> wrote:
> Based on the comments there is going to be a v6 but in any case I am
> starting testing of this patchset on several large core systems across
> multiple architectures (x86_64, ARM64, s390, ppc64le).  Some of those
> systems are known to fail boot due to the large amount of printk output so
> it will be good to see if these changes resolve those issues.

Right now the patches only include the ringbuffer as a separate entity
with a test module. So they do not yet have any effect on printk.

If you apply the patches and then build the "modules" target, you will
have a new test_prb.ko module. Loading that module will start some heavy
testing of the ringbuffer. As long as the testing is successful, the
module will keep testing. During this time the machine will be very
slow, but should still respond.

The test can be stopped by unloading the module. If the test stops on
its own, then a problem was found. The output of the test is put into
the ftrace buffer.

It would be nice if you could run the test module on some fat machines,
at least for a few minutes to see if anything explodes. ARM64 and
ppc64le will probably be the most interesting, due to memory barrier
testing.

Otherwise I will definitely be reaching out to you when we are ready to
perform actual printk testing with the newly agreed up semantics
(lockless, per-console printing threads, synchronous panic
consoles). Thanks for your help with this.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
