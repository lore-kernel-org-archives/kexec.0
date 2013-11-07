Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VeWxB-0002qE-7f
 for kexec@lists.infradead.org; Thu, 07 Nov 2013 21:17:25 +0000
Date: Thu, 7 Nov 2013 22:16:51 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCHv10 0/9] Xen: extend kexec hypercall for use with pv-ops
 kernels
Message-ID: <20131107211651.GC11159@olila.local.net-space.pl>
References: <1383749386-11891-1-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1383749386-11891-1-git-send-email-david.vrabel@citrix.com>
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

On Wed, Nov 06, 2013 at 02:49:37PM +0000, David Vrabel wrote:
> The series (for Xen 4.4) improves the kexec hypercall by making Xen
> responsible for loading and relocating the image.  This allows kexec
> to be usable by pv-ops kernels and should allow kexec to be usable
> from a HVM or PVH privileged domain.
>
> I have now tested this with a Linux kernel image using the VGA console
> which was what was causing problems in v9 (this turned out to be a
> kexec-tools bug).
>
> The required patch series for kexec-tools will be posted shortly and
> are available from the xen-v7 branch of:

In general it works. However, quite often I am not able to execute panic
kernel. Machine hangs with following message:

(XEN) Domain 0 crashed: Executing crash image

gdb shows:

(gdb) bt
#0  0xffff82d0801a0092 in do_nmi_crash (regs=<optimized out>) at crash.c:113
#1  0xffff82d0802281d9 in nmi_crash () at entry.S:666
#2  0x0000000000000000 in ?? ()
(gdb)

Especially second bt line scares me... ;-)))

I have not been able to identify why NMI was activated because
stack is completely cleared. I tried to record execution in gdb
but it stops with following message:

cpumask_clear_cpu (dstp=0xffff82d0802f7f78 <call_data+24>, cpu=0)
    at /srv/dev/xen/xen_20130413_20131107.kexec/xen/include/xen/cpumask.h:108
108             clear_bit(cpumask_check(cpu), dstp->bits);
Process record: failed to record execution log.

Do you know how to find out why NMI was activated?

I am able almost always reproduce this issue doing this:
  - boot Xen,
  - load panic kernel,
  - echo c > /proc/sysrq-trigger,
  - reboot from command line,
  - boot Xen,
  - load panic kernel,
  - echo c > /proc/sysrq-trigger.

Additionally, my compiler fails because it detects unused result
variable in xen/common/kimage.c:kimage_crash_alloc().

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
