Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from host81-137-131-225.in-addr.btopenworld.com ([81.137.131.225]
 helo=zimbra.overnetdata.com)
 by casper.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X5Z0P-0001dQ-8I
 for kexec@lists.infradead.org; Fri, 11 Jul 2014 11:28:47 +0000
Message-ID: <53BFCA2C.6010403@overnetdata.com>
Date: Fri, 11 Jul 2014 12:27:40 +0100
From: Anthony Wright <anthony@overnetdata.com>
MIME-Version: 1.0
Subject: Re: Can't load bzImage crashkernel on xen system with 32 bit kernel
References: <53BBC94B.8060905@overnetdata.com>
 <20140710074713.GA23099@dhcp-17-89.nay.redhat.com>
 <53BE66C5.6090604@overnetdata.com>
 <20140711075835.GA21010@dhcp-17-89.nay.redhat.com>
 <53BFB093.10307@citrix.com>
In-Reply-To: <53BFB093.10307@citrix.com>
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

On 11/07/2014 10:38, David Vrabel wrote:
> On 11/07/14 08:58, WANG Chao wrote:
>> On 07/10/14 at 11:11am, Anthony Wright wrote:
>>> Hi Chao,
>>>
>>> Thanks for looking at this.
>>>
>>> On 10/07/2014 08:47, WANG Chao wrote:
>>>> Hi, Anthony
>>>>
>>>> On 07/08/14 at 11:34am, Anthony Wright wrote:
>>>>> After successfully modifying kexec-tools to get it to load a crashkernel
>>>>> on a standard 32 bit linux 3.10.17 kernel, I tried to get it to load the
>>>>> same crashkernel on the same 32 bit linux kernel running under xen
>>>>> 4.4.0, but get the error "Cannot load <kernel-path>".
> Are you trying to do an in-guest kexec or are you trying to kexec from Xen?
>
> If it's the latter, it should just work with 32 and 64-bit images, Xen
> 4.4 and kexec-tools 2.0.5 or later.
>
> In-guest kexec doesn't work at all.
>
> David
I'm trying to do the kexec from within a 32 bit linux 3.10.17 Dom0
running under a 64 bit xen 4.4.0. When you say 'guest', does that mean
DomU's or does that include Dom0 as well? If it includes Dom0 could you
point me at some documentation to explain how/if it's possible to set up
kexec/kdump for Dom0.

I have a Dom0 kernel that's crashing infrequently. I can't reproduce it
easily and all the standard diagnostic techniques haven't been very
helpful. I'd hoped to generate a crashdump using kexec/kdump to help
diagnose the problem.

Anthony.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
