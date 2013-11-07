Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VeXL6-0003O2-Q2
 for kexec@lists.infradead.org; Thu, 07 Nov 2013 21:42:09 +0000
Date: Thu, 7 Nov 2013 22:41:38 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [Xen-devel] [PATCHv10 0/9] Xen: extend kexec hypercall for use
 with pv-ops kernels
Message-ID: <20131107214138.GD11159@olila.local.net-space.pl>
References: <1383749386-11891-1-git-send-email-david.vrabel@citrix.com>
 <20131107211651.GC11159@olila.local.net-space.pl>
 <527C054D.4090606@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <527C054D.4090606@citrix.com>
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
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>, Jan Beulich <jbeulich@suse.com>, xen-devel@lists.xen.org

On Thu, Nov 07, 2013 at 09:25:33PM +0000, Andrew Cooper wrote:
> On 07/11/13 21:16, Daniel Kiper wrote:
> > On Wed, Nov 06, 2013 at 02:49:37PM +0000, David Vrabel wrote:
> >> The series (for Xen 4.4) improves the kexec hypercall by making Xen
> >> responsible for loading and relocating the image.  This allows kexec
> >> to be usable by pv-ops kernels and should allow kexec to be usable
> >> from a HVM or PVH privileged domain.
> >>
> >> I have now tested this with a Linux kernel image using the VGA console
> >> which was what was causing problems in v9 (this turned out to be a
> >> kexec-tools bug).
> >>
> >> The required patch series for kexec-tools will be posted shortly and
> >> are available from the xen-v7 branch of:
> > In general it works. However, quite often I am not able to execute panic
> > kernel. Machine hangs with following message:
> >
> > (XEN) Domain 0 crashed: Executing crash image
> >
> > gdb shows:
> >
> > (gdb) bt
> > #0  0xffff82d0801a0092 in do_nmi_crash (regs=<optimized out>) at crash.c:113
> > #1  0xffff82d0802281d9 in nmi_crash () at entry.S:666
> > #2  0x0000000000000000 in ?? ()
> > (gdb)
> >
> > Especially second bt line scares me... ;-)))
>
> Why? This is completely normal.  If you look in crash.c at that line, it
> is a for (;;) halt(); loop

I thought more about this:

#1  0xffff82d0802281d9 in nmi_crash () at entry.S:666

Look at the end of this line... ;-)))

> How are you hooking gdb up?

I am doing tests in QEMU and using QEMU's -gdb option.

> > I have not been able to identify why NMI was activated because
> > stack is completely cleared. I tried to record execution in gdb
> > but it stops with following message:
>
> NMIs are used for cpu shootdown of the non-crashing cpus.  Again, this
> is not touched by the series.

Ahh... It makes sens. However, why machine hangs at this stage? Hmmm...
CPU sending NMIs receives one and instead of ignoring it halts itself?

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
