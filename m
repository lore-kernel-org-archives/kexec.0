Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJEjr-0005st-27
 for kexec@lists.infradead.org; Fri, 18 Sep 2020 11:39:39 +0000
Date: Fri, 18 Sep 2020 13:39:36 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH printk 2/3] printk: move dictionary keys to dev_printk_info
Message-ID: <20200918113936.GC14605@alley>
References: <20200917131644.25838-1-john.ogness@linutronix.de>
 <20200917131644.25838-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200917131644.25838-3-john.ogness@linutronix.de>
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
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu 2020-09-17 15:22:43, John Ogness wrote:
> Dictionaries are only used for SUBSYSTEM and DEVICE properties. The
> current implementation stores the property names each time they are
> used. This requires more space than otherwise necessary. Also,
> because the dictionary entries are currently considered optional,
> it cannot be relied upon that they are always available, even if the
> writer wanted to store them. These issues will increase should new
> dictionary properties be introduced.
> 
> Rather than storing the subsystem and device properties in the
> dict ring, introduce a struct dev_printk_info with separate fields
> to store only the property values. Embed this struct within the
> struct printk_info to provide guaranteed availability.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
