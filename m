Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VeX5S-00032w-RX
 for kexec@lists.infradead.org; Thu, 07 Nov 2013 21:25:59 +0000
Message-ID: <527C054D.4090606@citrix.com>
Date: Thu, 7 Nov 2013 21:25:33 +0000
From: Andrew Cooper <andrew.cooper3@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCHv10 0/9] Xen: extend kexec hypercall for use
 with pv-ops kernels
References: <1383749386-11891-1-git-send-email-david.vrabel@citrix.com>
 <20131107211651.GC11159@olila.local.net-space.pl>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>, Jan Beulich <jbeulich@suse.com>, xen-devel@lists.xen.org

On 07/11/13 21:16, Daniel Kiper wrote:
> On Wed, Nov 06, 2013 at 02:49:37PM +0000, David Vrabel wrote:
>> The series (for Xen 4.4) improves the kexec hypercall by making Xen
>> responsible for loading and relocating the image.  This allows kexec
>> to be usable by pv-ops kernels and should allow kexec to be usable
>> from a HVM or PVH privileged domain.
>>
>> I have now tested this with a Linux kernel image using the VGA console
>> which was what was causing problems in v9 (this turned out to be a
>> kexec-tools bug).
>>
>> The required patch series for kexec-tools will be posted shortly and
>> are available from the xen-v7 branch of:
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

Why? This is completely normal.  If you look in crash.c at that line, it
is a for (;;) halt(); loop

How are you hooking gdb up?

>
> I have not been able to identify why NMI was activated because
> stack is completely cleared. I tried to record execution in gdb
> but it stops with following message:

NMIs are used for cpu shootdown of the non-crashing cpus.  Again, this
is not touched by the series.

~Andrew

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
>
> Additionally, my compiler fails because it detects unused result
> variable in xen/common/kimage.c:kimage_crash_alloc().
>
> Daniel
>
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> http://lists.xen.org/xen-devel


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
