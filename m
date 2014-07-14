Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from host81-137-131-225.in-addr.btopenworld.com ([81.137.131.225]
 helo=zimbra.overnetdata.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X6e1g-0007hG-Ee
 for kexec@lists.infradead.org; Mon, 14 Jul 2014 11:02:34 +0000
Message-ID: <53C3B876.2010304@overnetdata.com>
Date: Mon, 14 Jul 2014 12:01:10 +0100
From: Anthony Wright <anthony@overnetdata.com>
MIME-Version: 1.0
Subject: Re: Can't load bzImage crashkernel on xen system with 32 bit kernel
References: <53BBC94B.8060905@overnetdata.com>
 <20140710074713.GA23099@dhcp-17-89.nay.redhat.com>
 <53BE66C5.6090604@overnetdata.com>
 <20140711075835.GA21010@dhcp-17-89.nay.redhat.com>
 <53BFB093.10307@citrix.com> <53BFCA2C.6010403@overnetdata.com>
 <53BFD5D1.2080207@citrix.com>
In-Reply-To: <53BFD5D1.2080207@citrix.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: David Vrabel <david.vrabel@citrix.com>, WANG Chao <chaowang@redhat.com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On 11/07/2014 13:17, David Vrabel wrote:
> On 11/07/14 12:27, Anthony Wright wrote:
>> On 11/07/2014 10:38, David Vrabel wrote:
>>> On 11/07/14 08:58, WANG Chao wrote:
>>>> On 07/10/14 at 11:11am, Anthony Wright wrote:
>>>>> Hi Chao,
>>>>>
>>>>> Thanks for looking at this.
>>>>>
>>>>> On 10/07/2014 08:47, WANG Chao wrote:
>>>>>> Hi, Anthony
>>>>>>
>>>>>> On 07/08/14 at 11:34am, Anthony Wright wrote:
>>>>>>> After successfully modifying kexec-tools to get it to load a crashkernel
>>>>>>> on a standard 32 bit linux 3.10.17 kernel, I tried to get it to load the
>>>>>>> same crashkernel on the same 32 bit linux kernel running under xen
>>>>>>> 4.4.0, but get the error "Cannot load <kernel-path>".
>>> Are you trying to do an in-guest kexec or are you trying to kexec from Xen?
>>>
>>> If it's the latter, it should just work with 32 and 64-bit images, Xen
>>> 4.4 and kexec-tools 2.0.5 or later.
>>>
>>> In-guest kexec doesn't work at all.
>>>
>>> David
>> I'm trying to do the kexec from within a 32 bit linux 3.10.17 Dom0
>> running under a 64 bit xen 4.4.0. When you say 'guest', does that mean
>> DomU's or does that include Dom0 as well? If it includes Dom0 could you
>> point me at some documentation to explain how/if it's possible to set up
>> kexec/kdump for Dom0.
>>
>> I have a Dom0 kernel that's crashing infrequently. I can't reproduce it
>> easily and all the standard diagnostic techniques haven't been very
>> helpful. I'd hoped to generate a crashdump using kexec/kdump to help
>> diagnose the problem.
> I would suggest trying a Xen kexec and exec'ing your crashdump kernel
> (which will then be running on baremetal).
>
> You will need to reserve a region of memory for the crash kernel on the
> Xen command line (e.g., crashkernel=64M@32M) and use kexec-tools 2.0.5
> or later.
>
> We don't actually collect memory dumps from this environment (only basic
> PCPU/VCPU state, Xen/dom0 backtraces, and console logs) so I'm not sure
> what the status of tools for this are.  Daniel Kiper might know.
>
> David
I had the 'crashkernel=128M' parameter on the Dom0 linux kernel cmdline.
Removing it from the Dom0 linux kernel command line and placing it on
the Xen command line changed things, but unfortunately it still doesn't
work.

I get the error message 'failed to get crash region from hypervisor'. On
further investigation the call to xc_kexec_get_range() fails returning
-1 with an errno of 34 (Numerical result out of range). According to the
xen kexec documentation that I could find
(http://xenbits.xen.org/docs/4.4-testing/misc/kexec_and_kdump.txt),
there should be a 'Crash kernel' entry in /proc/iomem, however when I
look, no such entry exists. I do wonder if this is an error in the
documentation as I would expect a crashkernel= entry on the linux kernel
command line to create such an entry in /proc/iomem, but was suprised
when the documentation says the entry is created when you put
crashkernel= on the xen command line.

On a more fundamental note, are you suggesting that the approach I'm
taking simply isn't going to work? I'm trying to solve a problem where a
Dom0 kernel running on a machine that I don't have physical access to
crashes intermittently with a panic. The on screen part of the panic
isn't as helpful as I'd like but it does suggest that the panic is from
the disk driver. To give us the best chance of diagnosing the bug I had
intended to generate a dump of the kernel after the panic. My plan was
to use kexec/kdump to fire up a crash kernel and use that to write the
content of the crashed kernel's memory to the filesystem. Once dumped I
would reboot and upload the dump.

thanks,

Anthony.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
