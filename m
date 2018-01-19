Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ecTFa-0006GA-3K
 for kexec@lists.infradead.org; Fri, 19 Jan 2018 09:46:19 +0000
Received: by mail-pg0-x242.google.com with SMTP id s9so1016718pgq.13
 for <kexec@lists.infradead.org>; Fri, 19 Jan 2018 01:46:07 -0800 (PST)
Date: Fri, 19 Jan 2018 18:46:03 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] print kdump kernel loaded status in stack dump
Message-ID: <20180119094603.GA3685@tigerII.localdomain>
References: <20180117045057.GA4994@dhcp-128-65.nay.redhat.com>
 <878tcvt592.fsf@linux.intel.com>
 <20180119054538.GA484@jagdpanzerIV>
 <20180119081628.GB3985@dhcp-128-65.nay.redhat.com>
 <20180119082835.GA477@jagdpanzerIV>
 <20180119084223.GC3985@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180119084223.GC3985@dhcp-128-65.nay.redhat.com>
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
Cc: pmladek@suse.com, Andi Kleen <ak@linux.intel.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, sergey.senozhatsky@gmail.com, akpm@linux-foundation.org

On (01/19/18 16:42), Dave Young wrote:
[..]
> > [I'm not entirely sure I see why do we have printk_delay() in
> >    vprintk_emit()... I mean I probably can see some reasoning behind
> >    it, but at the same it makes sense to slow down console_unlock()
> >    as well]
> 
> Looks like I am the guy who added the code :)

LOL :)

> Actually no special reason, just did not thinking about the performance
> issue at all at that time..

it's quite reasonable to have it in vprintk_emit(), actually.

the thing is that it limits the rate at which new messages appear in
the kernel log buffer, which does not necessarily correspond to the rate
at which new messages appear on the consoles.

printk has a "direct path"  printk -> console_unlock() -> consoles,
and "indirect path" - when it fails to acquire console semaphore,
because it's locked by someone else. that someone else, a console_sem
owner, might be scheduled out under console_sem; all printks in the
meantime will just log_store() messages [after printk_delay()].
once the console_sem owner will be back to running it will resume
console_unlock() printing loop and print out all pending messages
immediately [modulo preemption]. so there are ways for messages to
bypass printk_delay() and appear on the consoles with no visible
delay.

additionally printk_delay() does touch_nmi_watchdog() so we,
technically, are fine with moving it to console_unlock().

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
