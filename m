Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtTZf-0004hF-Ow
 for kexec@lists.infradead.org; Thu, 09 Jul 2020 10:14:40 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [printk] 18a2dc6982: ltp.kmsg01.fail
In-Reply-To: <20200709083323.GA572@jagdpanzerIV.localdomain>
References: <20200707145932.8752-5-john.ogness@linutronix.de>
 <20200709071411.GR3874@shao2-debian>
 <20200709083323.GA572@jagdpanzerIV.localdomain>
Date: Thu, 09 Jul 2020 12:20:35 +0206
Message-ID: <874kqhm1v8.fsf@jogness.linutronix.de>
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
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, kernel test robot <rong.a.chen@intel.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, lkp@lists.01.org, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On 2020-07-09, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> On (20/07/09 15:14), kernel test robot wrote:
> [..]
>
> Took me a while to find the FAIL-ed test:
>
>> kmsg01.c:393: INFO: TEST: read returns EPIPE when messages get overwritten
>> kmsg01.c:398: INFO: first seqno: 0
>> kmsg01.c:411: INFO: first seqno now: 881
>> kmsg01.c:425: FAIL: read returned: 77: SUCCESS (0)
>
> So this is seq number related
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/logging/kmsg/kmsg01.c#L383

Excellent test.

Since the messages are above the expected average size, the dataring is
wrapping before the descriptor ring. This means that the initial
descriptors are still there, but their data is gone. Initially I would
generate an EPIPE for this, but it was changed. Here is the thread [0]
we had about this.

I have some ideas how to correctly handle this. Let me try some
alternatives and post a proposed solution.

John Ogness

[0] https://lkml.kernel.org/r/20200213090757.GA36551@google.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
