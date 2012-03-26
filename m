Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tango.0pointer.de ([85.214.72.216])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SCEjr-0001Fd-0R
 for kexec@lists.infradead.org; Mon, 26 Mar 2012 18:33:56 +0000
Date: Mon, 26 Mar 2012 20:07:30 +0200
From: Lennart Poettering <lennart@poettering.net>
Subject: Re: Doing kexec reboot right in systemd
Message-ID: <20120326180729.GB5398@tango.0pointer.de>
References: <CABRT9RAB--szWwmYO9_JyjXRP-9YYgkG-TsAg8jS=birUF2e=w@mail.gmail.com>
 <20120322223646.GC26794@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120322223646.GC26794@verge.net.au>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec list <kexec@lists.infradead.org>, Marti Raudsepp <marti@juffo.org>, systemd-devel <systemd-devel@lists.freedesktop.org>

On Fri, 23.03.12 07:36, Simon Horman (horms@verge.net.au) wrote:

> 
> On Thu, Mar 22, 2012 at 09:14:56PM +0200, Marti Raudsepp wrote:
> > Hi list,
> 
> Hi Marti,
> 
> > I was recently pondering how systemd could use kexec "properly", in a
> > reasonably general way, to make reboots faster. I exchanged an email
> > with Poettering on the systemd list and he suggested me to ask here.
> > 
> > My current proposal:
> > 1. Include a template 'kexec-load.service' with kexec-tools, which
> > distros/users could customize to load the right kernel and initrd via
> > /sbin/kexec

Hmm, so since this would then belong in the shutdown path of systemd,
and only be added for the kexec shutdown path I actually think it would
make more sense to add this into systemd itself instead of kexec-tools,
to ensure the right ordering.

Marti, sorry for changing my mind on this: would be great if you could
prep a patch for this for systemd itself.

> > 3. During a reboot, after systemd has finished shutting down, it
> > detects via /sys/kernel/kexec_loaded whether the kexec kernel is
> > loaded. If 1, it performs a 'kexec -e'. If not, it does a normal
> > reboot.

I'd like to keep kexec.target different from reboot.target by
default, so that people have both options available.

So, how I'd envision this:

a) we introduce kexec-load.service which is always in the kexec.target
   shutdown path, never in reboot.target. Doesn't need to be enabled.

b) kexec-load.service becomes a NOP if a kernel is already loaded

c) "systemctl reboot" continues to check whether a kernel is already
   loaded, and if so results in kexec.target being started rather than
   reboot.target

d) If the user wants that the machine is always rebooted via kexec,
   never with traditional reboot, he can manually create a symlink
   /etc/systemd/system/reboot.target to
   /etc/systemd/system/kexec.target.

That way, that in general both paths always exist, unless the admin
manually loaded a kernel or manually redirected all reboots to kexec.

Does that make sense?

Lennart

-- 
Lennart Poettering - Red Hat, Inc.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
