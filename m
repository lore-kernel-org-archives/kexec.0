Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KSLlR-0004tW-Jm
	for kexec@lists.infradead.org; Mon, 11 Aug 2008 01:00:02 +0000
Subject: Re: [PATCH -v2 6/8] kexec jump: fix for lockdep
From: Huang Ying <ying.huang@intel.com>
In-Reply-To: <1218190426.8625.71.camel@twins>
References: <1218178365.22039.79.camel@caritas-dev.intel.com>
	<1218190426.8625.71.camel@twins>
Date: Mon, 11 Aug 2008 08:59:56 +0800
Message-Id: <1218416396.30464.9.camel@caritas-dev.intel.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu, Vivek Goyal <vgoyal@redhat.com>

On Fri, 2008-08-08 at 12:13 +0200, Peter Zijlstra wrote:
> On Fri, 2008-08-08 at 14:52 +0800, Huang Ying wrote:
> > Replace local_irq_disable() with raw_local_irq_disable() to prevent
> > lockdep complain.
> Uhhm, please provide more information - just using raw_* to silence
> lockdep is generally the wrong thing to do.

In traditional kexec, the new kernel will replace current one, so the
irq is simply disabled. But now jumping back from kexeced kernel is
supported, so the irq should be enabled again.

The code sequence of irq during kexec jump is as follow:

local_irq_disable(); /* in kernel_kexec() */
local_irq_disable(); /* in machine_kexec() */
local_irq_enable(); /* in kernel_kexec() */

The disable and enable is not match. Maybe another method is to use
local_irq_save(), local_irq_restore() pair in machine_kexec(), so the
disable and enable is matched.

Best Regrards,
Huang Ying



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
