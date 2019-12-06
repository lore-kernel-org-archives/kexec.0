Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1idEPp-0000cm-0D
 for kexec@lists.infradead.org; Fri, 06 Dec 2019 14:17:07 +0000
From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [RFC PATCH v5 0/3] printk: new ringbuffer implementation
Date: Fri,  6 Dec 2019 09:16:53 -0500
Message-Id: <20191206141653.1199-1-prarit@redhat.com>
In-Reply-To: <87zhg6zx31.fsf@linutronix.de>
References: <87zhg6zx31.fsf@linutronix.de>
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
To: prarit@redhat.com
Cc: andrea.parri@amarulasolutions.com, pmladek@suse.com, sergey.senozhatsky.work@gmail.com, john.ogness@linutronix.de, peterz@infradead.org, gregkh@linuxfoundation.org, brendanhiggins@google.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org, sergey.senozhatsky@gmail.com, tglx@linutronix.de, torvalds@linux-foundation.org, kexec@lists.infradead.org

  John Ogness <john.ogness@linutronix.de> wrote:
> Hi Prarit,
> 
> On 2019-12-05, Prarit Bhargava <prarit@redhat.com> wrote:
> > Based on the comments there is going to be a v6 but in any case I am
> > starting testing of this patchset on several large core systems across
> > multiple architectures (x86_64, ARM64, s390, ppc64le).  Some of those
> > systems are known to fail boot due to the large amount of printk output so
> > it will be good to see if these changes resolve those issues.
> 
> Right now the patches only include the ringbuffer as a separate entity
> with a test module. So they do not yet have any effect on printk.
> 
> If you apply the patches and then build the "modules" target, you will
> have a new test_prb.ko module. Loading that module will start some heavy
> testing of the ringbuffer. As long as the testing is successful, the
> module will keep testing. During this time the machine will be very
> slow, but should still respond.
> 
> The test can be stopped by unloading the module. If the test stops on
> its own, then a problem was found. The output of the test is put into
> the ftrace buffer.
> 
> It would be nice if you could run the test module on some fat machines,
> at least for a few minutes to see if anything explodes. ARM64 and
> ppc64le will probably be the most interesting, due to memory barrier
> testing.
> 

I've run the module overnight on all 4 arches I mentioned above.  I didn't
see any failures but IIUC the module test runs at max.  I'm going to put a
load test on these systems that introduces a variable load to interfere
with the prbtest module to see if that kicks anything.

> Otherwise I will definitely be reaching out to you when we are ready to
> perform actual printk testing with the newly agreed up semantics
> (lockless, per-console printing threads, synchronous panic
> consoles). Thanks for your help with this.
>

np :) but I should be the one thanking you ;)

P.

> John Ogness


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
