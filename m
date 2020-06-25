Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joMCw-0000yl-ET
 for kexec@lists.infradead.org; Thu, 25 Jun 2020 07:22:03 +0000
Date: Thu, 25 Jun 2020 15:19:59 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v3 0/3] printk: replace ringbuffer
Message-ID: <20200625071959.GA18744@dhcp-128-65.nay.redhat.com>
References: <20200618144919.9806-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200618144919.9806-1-john.ogness@linutronix.de>
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
Cc: Andrea Parri <parri.andrea@gmail.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

Hi John,
On 06/18/20 at 04:55pm, John Ogness wrote:
> Hello,
> 
> Here is a v3 for the first series to rework the printk
> subsystem. The v2 and history are here [0]. This first series
> only replaces the existing ringbuffer implementation. No locking
> is removed. No semantics/behavior of printk are changed.
> 
> Reviews on the ringbuffer are still ongoing, but I was asked to
> post this new version since several changes from v2 have been
> already agreed upon.
> 
> The series is based on v5.8-rc1.

Do you have the kdump userspace part link so that people can try
and do some testing?

Eg. some makedumpfile/crash tool git branch etc.

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
