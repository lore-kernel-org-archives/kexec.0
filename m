Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.active-venture.com ([67.228.131.205])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UPvQn-0005YD-Rr
 for kexec@lists.infradead.org; Wed, 10 Apr 2013 13:51:22 +0000
Date: Wed, 10 Apr 2013 06:51:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH] watchdog: Add hook for kicking in kdump path
Message-ID: <20130410135123.GB15456@roeck-us.net>
References: <1365192994-94850-1-git-send-email-dzickus@redhat.com>
 <516259D2.7000805@redhat.com> <20130408124858.GC79013@redhat.com>
 <20130408151509.GA20919@roeck-us.net>
 <20130409144431.GL79013@redhat.com>
 <20130409145228.GA1111@roeck-us.net>
 <20130409151423.GM79013@redhat.com>
 <20130409160757.GA27050@roeck-us.net>
 <20130410134039.GV79013@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130410134039.GV79013@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Don Zickus <dzickus@redhat.com>
Cc: linux-watchdog@vger.kernel.org, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, wim@iguana.be, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

On Wed, Apr 10, 2013 at 09:40:39AM -0400, Don Zickus wrote:
> On Tue, Apr 09, 2013 at 09:07:58AM -0700, Guenter Roeck wrote:
> > > > Just look for the use of mod_timer in the watchdog directory.
> > > 
> > > So looking at the mod_timer logic in various drivers, it seems regardless
> > > if the /dev/watchdog device is opened or not, if it is running, it will
> > > automagically kick the watchdog.
> > > 
> > yes
> > 
> > > This seems that we can avoid pulling in userspace pieces for this.  Just
> > > load the driver and the hardware starts getting kicked.
> > > 
> > Only if it is already running. Also, you don't want to rely on it, because you
> > lose protection against user space issues.
> 
> IOW if something goes wrong with a runaway userspace app, the kernel
> blindly continues to kick the watchdog, which masks the problem, right?
> 
That would be wrong if any of the drivers does that. The kernel should stop
kicking after the software timeout expires.

For example, if the HW needs to be kicked every second, and the high level
timeout is set to one minute, the driver should keep kicking the hardware
watchdog for one minute and then stop doing it if /dev/watchdog was opened
and userspace is silent. 

> > 
> > A second use is if the hw watchdog needs to be pinged more often than user
> > space can provide. Some of the HW watchdogs need a ping in one-second intervals
> > or even faster.
> > 
> > > Is that true?  And if so, do all drivers detect if the hardware is already
> > > running during their init?  Or is it based on the first device open?
> > > 
> > It is usually done in the probe function.
> 
> Ok.  Thanks for the understanding of how the softdog stuff works.
> 
> However, we still have the problem that if the machine panics and we want
> to jump into the kdump kernel, we need to 'kick' the watchdog one more
> time.  This provides us a sane sync point for determining how long we have
> to load the watchdog driver in the second kernel before the hardware
> reboots us.  Otherwise the reboots are pretty random and nothing is
> guaranteed.
> 
> Hence the need for some sort of patch resembling the one I posted.
> 
> Soooooooo, any thoughts about that patch and what changes I should make?
> :-)
> 
The FIXME is a problem, and I think the name and scope would have to be
more generic (watchdog_kick ?). Also, it doesn't solve the problem
of having multiple open watchdogs (my system has three, for example),
and it doesn't check if the watchdog is running.

Guenter

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
