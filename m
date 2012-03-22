Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SAqcr-00053A-Jv
 for kexec@lists.infradead.org; Thu, 22 Mar 2012 22:36:58 +0000
Date: Fri, 23 Mar 2012 07:36:46 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: Doing kexec reboot right in systemd
Message-ID: <20120322223646.GC26794@verge.net.au>
References: <CABRT9RAB--szWwmYO9_JyjXRP-9YYgkG-TsAg8jS=birUF2e=w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CABRT9RAB--szWwmYO9_JyjXRP-9YYgkG-TsAg8jS=birUF2e=w@mail.gmail.com>
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
To: Marti Raudsepp <marti@juffo.org>
Cc: systemd-devel <systemd-devel@lists.freedesktop.org>, kexec list <kexec@lists.infradead.org>, Lennart Poettering <lennart@poettering.net>

On Thu, Mar 22, 2012 at 09:14:56PM +0200, Marti Raudsepp wrote:
> Hi list,

Hi Marti,

> I was recently pondering how systemd could use kexec "properly", in a
> reasonably general way, to make reboots faster. I exchanged an email
> with Poettering on the systemd list and he suggested me to ask here.
> 
> My current proposal:
> 1. Include a template 'kexec-load.service' with kexec-tools, which
> distros/users could customize to load the right kernel and initrd via
> /sbin/kexec
> 
> 2. If the user does 'systemctl enable kexec-load.service', then this
> service would trigger before every reboot. Loading the kernel any
> earlier would waste memory (5+14 MB on Ubuntu Server). Also a common
> reason for rebooting is to boot into a newly-installed kernel. Loading
> it any earlier would boot you into an older kernel.
> 
> 3. During a reboot, after systemd has finished shutting down, it
> detects via /sys/kernel/kexec_loaded whether the kexec kernel is
> loaded. If 1, it performs a 'kexec -e'. If not, it does a normal
> reboot.
> 
> ----
> 
> Lennart commented on #2 that kexec might have problems finding
> contiguous memory to load the kernel into, this late in the lifecycle.
> Do you think this is a deal-breaker for such a feature? If it's rare
> enough, then it might not be a problem -- we can always fall back to a
> normal reboot.

In general kexec doesn't store the kernel in contiguous memory at load-time.
Rather, when kexec -e is called the kernel is copped from (most likely)
discontiguous pages) into its destination location.

> I'm also assuming that "kexec --load" will fail atomically -- that it
> won't try to boot a half-loaded kernel, or boot a kernel whose initrd
> failed to load.

Yes, that is correct.

However, I speculate that there is a greater chance of the boot of a
kexeced kernel failing than the same kernel booting by more conventional
means on the same hardware. Primarily because there are most likely
shutdown/boot paths, especially in drivers, that have not been well
exercised.

So while it may work well on some hardware, perhaps even most hardware, I
suspect there are cases where it will fail.  I guess that is where
systemctl enable/disable kexec-load.service comes into play.

> Also, #3 doesn't yet work that way in systemd (currently it detects
> before shutdown) and Poettering hasn't agreed yet.
> 
> Does this proposal seem sane to kexec folks? Did I miss anything?

If it is desirable to use kexec as a reboot mechanism then
from a kexec point of view I think your proposal makes sense.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
