Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZXW3-00080h-BD
 for kexec@lists.infradead.org; Fri, 15 May 2020 10:24:32 +0000
Received: by mail-pj1-x1042.google.com with SMTP id s69so720375pjb.4
 for <kexec@lists.infradead.org>; Fri, 15 May 2020 03:24:30 -0700 (PDT)
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Date: Fri, 15 May 2020 19:24:27 +0900
Subject: Re: [PATCH v2 0/3] printk: replace ringbuffer
Message-ID: <20200515102427.GB42471@jagdpanzerIV.localdomain>
References: <20200501094010.17694-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200501094010.17694-1-john.ogness@linutronix.de>
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
Cc: Andrea Parri <parri.andrea@gmail.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On (20/05/01 11:46), John Ogness wrote:
> Hello,
> 
> Here is a v2 for the first series to rework the printk subsystem. The
> v1 and history are here [0]. This first series only replaces the
> existing ringbuffer implementation. No locking is removed. No
> semantics/behavior of printk are changed.
> 
> The VMCOREINFO is updated. RFC patches for the external tools
> crash(8) [1] and makedumpfile(8) [2] have been submitted that allow
> the new ringbuffer to be correctly read.
> 
> This series is in line with the agreements [3] made at the meeting
> during LPC2019 in Lisbon, with 1 exception: support for dictionaries
> will not be discontinued [4]. Dictionaries are stored in a separate
> buffer so that they cannot interfere with the human-readable buffer.

I'm willing to bless this. The code looks good to me, nice job guys.

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
