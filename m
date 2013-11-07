Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VeXa0-0003jw-9c
 for kexec@lists.infradead.org; Thu, 07 Nov 2013 21:57:33 +0000
Message-ID: <527C0CB1.6000804@citrix.com>
Date: Thu, 7 Nov 2013 21:57:05 +0000
From: Andrew Cooper <andrew.cooper3@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCHv10 0/9] Xen: extend kexec hypercall for use
 with pv-ops kernels
References: <1383749386-11891-1-git-send-email-david.vrabel@citrix.com>
 <20131107211651.GC11159@olila.local.net-space.pl>
 <527C054D.4090606@citrix.com>
 <20131107214138.GD11159@olila.local.net-space.pl>
In-Reply-To: <20131107214138.GD11159@olila.local.net-space.pl>
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

On 07/11/2013 21:41, Daniel Kiper wrote:
> On Thu, Nov 07, 2013 at 09:25:33PM +0000, Andrew Cooper wrote:
>> On 07/11/13 21:16, Daniel Kiper wrote:
>>> On Wed, Nov 06, 2013 at 02:49:37PM +0000, David Vrabel wrote:
>>>> The series (for Xen 4.4) improves the kexec hypercall by making Xen
>>>> responsible for loading and relocating the image.  This allows kexec
>>>> to be usable by pv-ops kernels and should allow kexec to be usable
>>>> from a HVM or PVH privileged domain.
>>>>
>>>> I have now tested this with a Linux kernel image using the VGA console
>>>> which was what was causing problems in v9 (this turned out to be a
>>>> kexec-tools bug).
>>>>
>>>> The required patch series for kexec-tools will be posted shortly and
>>>> are available from the xen-v7 branch of:
>>> In general it works. However, quite often I am not able to execute panic
>>> kernel. Machine hangs with following message:
>>>
>>> (XEN) Domain 0 crashed: Executing crash image
>>>
>>> gdb shows:
>>>
>>> (gdb) bt
>>> #0  0xffff82d0801a0092 in do_nmi_crash (regs=<optimized out>) at crash.c:113
>>> #1  0xffff82d0802281d9 in nmi_crash () at entry.S:666
>>> #2  0x0000000000000000 in ?? ()
>>> (gdb)
>>>
>>> Especially second bt line scares me... ;-)))
>> Why? This is completely normal.  If you look in crash.c at that line, it
>> is a for (;;) halt(); loop
> I thought more about this:
>
> #1  0xffff82d0802281d9 in nmi_crash () at entry.S:666
>
> Look at the end of this line... ;-)))

Which line and what about it?  In current master, that is a SAVE_ALL,
but as the call to do_nmi_crash has happened, I presume
0xffff82d0802281d9 is a ud2 instruction in your tree?

>
>> How are you hooking gdb up?
> I am doing tests in QEMU and using QEMU's -gdb option.
>
>>> I have not been able to identify why NMI was activated because
>>> stack is completely cleared. I tried to record execution in gdb
>>> but it stops with following message:
>> NMIs are used for cpu shootdown of the non-crashing cpus.  Again, this
>> is not touched by the series.
> Ahh... It makes sens. However, why machine hangs at this stage? Hmmm...
> CPU sending NMIs receives one and instead of ignoring it halts itself?
>
> Daniel

No - there is very clear protection from racing down the crash path. 
The crashing CPU forces all other cpus into nmi_crash(), where they will
stay until reset.

It is the one cpu which is not executing nmi_crash() which will end up
executing the crash image.

~Andrew

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
