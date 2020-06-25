Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joSdf-00028l-ER
 for kexec@lists.infradead.org; Thu, 25 Jun 2020 14:14:04 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v3 0/3] printk: replace ringbuffer
References: <20200618144919.9806-1-john.ogness@linutronix.de>
 <20200625071959.GA18744@dhcp-128-65.nay.redhat.com>
Date: Thu, 25 Jun 2020 16:13:52 +0200
In-Reply-To: <20200625071959.GA18744@dhcp-128-65.nay.redhat.com> (Dave Young's
 message of "Thu, 25 Jun 2020 15:19:59 +0800")
Message-ID: <87wo3vi673.fsf@jogness.linutronix.de>
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
To: Dave Young <dyoung@redhat.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Dave,

On 2020-06-25, Dave Young <dyoung@redhat.com> wrote:
> On 06/18/20 at 04:55pm, John Ogness wrote:
>> Here is a v3 for the first series to rework the printk
>> subsystem. The v2 and history are here [0]. This first series
>> only replaces the existing ringbuffer implementation. No locking
>> is removed. No semantics/behavior of printk are changed.
>> 
>> Reviews on the ringbuffer are still ongoing, but I was asked to
>> post this new version since several changes from v2 have been
>> already agreed upon.
>> 
>> The series is based on v5.8-rc1.
>
> Do you have the kdump userspace part link so that people can try
> and do some testing?
>
> Eg. some makedumpfile/crash tool git branch etc.

I have set up github forks, each with the RFC patch on top in their
respective "printk" branch:

    https://github.com/Linutronix/crash.git

    https://github.com/Linutronix/makedumpfile.git

Note that for crash, only the "log" command (using debug symbols) is
implemented. The --log argument (using VMCOREINFO) is not implemented.

For makedumpfile both symbol and VMCOREINFO variants are implemented.

The VMCOREINFO implementation in makedumpfile shows that there is enough
VMCOREINFO exported. So it will not be a problem to implement that for
crash as well.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
