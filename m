Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VfE3m-0004Ab-8L
 for kexec@lists.infradead.org; Sat, 09 Nov 2013 19:19:07 +0000
Date: Sat, 9 Nov 2013 20:18:31 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCHv10 0/9] Xen: extend kexec hypercall for use with pv-ops
 kernels
Message-ID: <20131109191831.GD3439@olila.local.net-space.pl>
References: <1383749386-11891-1-git-send-email-david.vrabel@citrix.com>
 <20131107211651.GC11159@olila.local.net-space.pl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131107211651.GC11159@olila.local.net-space.pl>
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
Cc: kexec@lists.infradead.org, Jan Beulich <jbeulich@suse.com>, xen-devel@lists.xen.org

On Thu, Nov 07, 2013 at 10:16:51PM +0100, Daniel Kiper wrote:
> On Wed, Nov 06, 2013 at 02:49:37PM +0000, David Vrabel wrote:
> > The series (for Xen 4.4) improves the kexec hypercall by making Xen
> > responsible for loading and relocating the image.  This allows kexec
> > to be usable by pv-ops kernels and should allow kexec to be usable
> > from a HVM or PVH privileged domain.
> >
> > I have now tested this with a Linux kernel image using the VGA console
> > which was what was causing problems in v9 (this turned out to be a
> > kexec-tools bug).
> >
> > The required patch series for kexec-tools will be posted shortly and
> > are available from the xen-v7 branch of:
>
> In general it works. However, quite often I am not able to execute panic
> kernel. Machine hangs with following message:
>
> (XEN) Domain 0 crashed: Executing crash image
>
> gdb shows:
>
> (gdb) bt
> #0  0xffff82d0801a0092 in do_nmi_crash (regs=<optimized out>) at crash.c:113
> #1  0xffff82d0802281d9 in nmi_crash () at entry.S:666
> #2  0x0000000000000000 in ?? ()
> (gdb)
>
> Especially second bt line scares me... ;-)))
>
> I have not been able to identify why NMI was activated because
> stack is completely cleared. I tried to record execution in gdb
> but it stops with following message:
>
> cpumask_clear_cpu (dstp=0xffff82d0802f7f78 <call_data+24>, cpu=0)
>     at /srv/dev/xen/xen_20130413_20131107.kexec/xen/include/xen/cpumask.h:108
> 108             clear_bit(cpumask_check(cpu), dstp->bits);
> Process record: failed to record execution log.
>
> Do you know how to find out why NMI was activated?
>
> I am able almost always reproduce this issue doing this:
>   - boot Xen,
>   - load panic kernel,
>   - echo c > /proc/sysrq-trigger,
>   - reboot from command line,
>   - boot Xen,
>   - load panic kernel,
>   - echo c > /proc/sysrq-trigger.

I am not able to reproduce this on real hardware. Sorry for confusion.

Hence, for whole Xen kexec/kdump series:

Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
Tested-by: Daniel Kiper <daniel.kiper@oracle.com>

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
