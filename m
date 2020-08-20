Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8iMD-00012Z-Dt
 for kexec@lists.infradead.org; Thu, 20 Aug 2020 11:03:46 +0000
Date: Thu, 20 Aug 2020 12:43:48 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [patch 0/2] timekeeping: NMI safe timekeeper enhancements
Message-ID: <20200820104348.GF4353@alley>
References: <20200814101933.574326079@linutronix.de>
 <20200820084738.GD4353@alley>
 <878se9ip7k.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <878se9ip7k.fsf@nanos.tec.linutronix.de>
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
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Prarit Bhargava <prarit@redhat.com>, Baoquan He <bhe@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, John Stultz <john.stultz@linaro.org>, Orson Zhai <orsonzhai@gmail.com>, Stephen Boyd <sboyd@kernel.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu 2020-08-20 12:30:55, Thomas Gleixner wrote:
> Petr,
> 
> On Thu, Aug 20 2020 at 10:47, Petr Mladek wrote:
> > The interface is perfectly fine for printk() needs.
> 
> Good. So I suggest that I apply that on top of rc1 somewhere in tip and
> tag the top commit. So you can pull that tag into your printk branch and
> go wild.

Sounds good to me.

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
