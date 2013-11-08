Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VeltI-0003WU-4A
 for kexec@lists.infradead.org; Fri, 08 Nov 2013 13:14:25 +0000
Message-ID: <527CE397.10101@citrix.com>
Date: Fri, 8 Nov 2013 13:13:59 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [PATCHv10 0/9] Xen: extend kexec hypercall for use with pv-ops
 kernels
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
Cc: Keir Fraser <keir@xen.org>, kexec@lists.infradead.org, Jan Beulich <jbeulich@suse.com>, xen-devel@lists.xen.org

Keir,

Sorry, forgot to CC you on this series.

Can we have your opinion on whether this kexec series can be merged?
And if not, what further work and/or testing is required?

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
> 
> In general it works. However, quite often I am not able to execute panic
> kernel. Machine hangs with following message:

I cannot reproduce any failures, neither on my dev box nor on any of the
automated XenServer tests that run on a range of different hardware
platforms.  I find kexec to be very reliable and an earlier version of
this series has been in production within XenServer for a while now and
has seen real use in the field.

None of the issues reported so far have been regressions but failures in
specific uses of the new support for pv-ops kernels.

I really can't see how I can do anything else to make this series
acceptable for merging.

In my opinion, the current implementation is so broken[1] and useless[2]
that anything that even vaguely looks like it might work is significant
improvement, and something that is deployed usefully in production
should definitely be merged.

[1] Uses code provided by the guest to jump out of Xen into the image
which works only through luck. Does not (and has never) worked reliably
with 32-bit dom0.

[2] Does not work at all (and will never work) with upstream kernels.

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
> stack is completely cleared.

All this you have described here is correct and expected behavior,
which, quite frankly, you should have been able to see with even the
most cursory look at the code.

> Additionally, my compiler fails because it detects unused result
> variable in xen/common/kimage.c:kimage_crash_alloc().

Yes, sorry about that.  That was fallout from a last minute trivial
cleanup.  I've posted an updated patch correcting this.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
