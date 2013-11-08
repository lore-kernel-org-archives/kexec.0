Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vence-0006KK-48
 for kexec@lists.infradead.org; Fri, 08 Nov 2013 15:05:20 +0000
Date: Fri, 8 Nov 2013 16:04:36 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCHv10 0/9] Xen: extend kexec hypercall for use with pv-ops
 kernels
Message-ID: <20131108150436.GA3439@olila.local.net-space.pl>
References: <1383749386-11891-1-git-send-email-david.vrabel@citrix.com>
 <20131107211651.GC11159@olila.local.net-space.pl>
 <527CE397.10101@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <527CE397.10101@citrix.com>
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
To: David Vrabel <david.vrabel@citrix.com>
Cc: Keir Fraser <keir@xen.org>, kexec@lists.infradead.org, Jan Beulich <jbeulich@suse.com>, xen-devel@lists.xen.org

On Fri, Nov 08, 2013 at 01:13:59PM +0000, David Vrabel wrote:

[...]

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
> >
> > I have not been able to identify why NMI was activated because
> > stack is completely cleared.
>
> All this you have described here is correct and expected behavior,
> which, quite frankly, you should have been able to see with even the
> most cursory look at the code.

This is more a fun stuff than a real concern. That is why I have added
smile at the end of my statement. nmi_crash () at entry.S:666 is
a quite interesting coincidence for me... ;-)))

Anyway, it is interesting why all CPUs were stopped at this stage.
One should execute kdump code still. I will try to reproduce this
on real hardware.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
