Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TwISD-0006id-J2
 for kexec@lists.infradead.org; Fri, 18 Jan 2013 20:22:22 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1358353746-1899-1-git-send-email-david.vrabel@citrix.com>
 <1358353746-1899-2-git-send-email-david.vrabel@citrix.com>
 <20130117122803.GC2871@host-192-168-1-59.local.net-space.pl>
 <50F80FB2.9080107@citrix.com>
 <20130117151712.GE2871@host-192-168-1-59.local.net-space.pl>
 <50F83A8D.2030307@citrix.com>
Date: Fri, 18 Jan 2013 11:01:50 -0800
In-Reply-To: <50F83A8D.2030307@citrix.com> (David Vrabel's message of "Thu, 17
 Jan 2013 17:53:17 +0000")
Message-ID: <87pq12pb6p.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] kexec: extend hypercall with improved load/unload ops
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
To: David Vrabel <david.vrabel@citrix.com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

David Vrabel <david.vrabel@citrix.com> writes:

> On 17/01/13 15:17, Daniel Kiper wrote:
>> On Thu, Jan 17, 2013 at 02:50:26PM +0000, David Vrabel wrote:
>>> On 17/01/13 12:28, Daniel Kiper wrote:
>>>> On Wed, Jan 16, 2013 at 04:29:04PM +0000, David Vrabel wrote:
> [..]
>>>>> +    if ( image->class == KEXEC_CLASS_32 )
>>>>> +        compat_machine_kexec(image->entry_maddr);
>>>>
>>>> Why do you need that?
>>>
>>> image->class controls whether the processor is in 32-bit or 64-bit mode
>>> when calling the image.  The current implementation only allows images
>>> to be executed with the same class as dom0.
>>>
>>> It's called class because that's the term ELF uses in the ELF header.
>> 
>> As I correctly understand this sets processor mode before new kernel exection.
>> If yes then it is not needed. Purgatory code (from kexec-tools) does all
>> needed things. Please check.
>
> On x86 I think it would probably be fine to specify entry is always in
> 64-bit mode but for ARM and future architectures it is less clear and it
> becomes more difficult to have a well-defined ABI.
>
> In fact, we probably want a more generic architecture field. e.g,
>
> #define XEN_KEXEC_ARCH_X86_32 0
> #define XEN_KEXEC_ARCH_X86_64 1
> #define XEN_KEXEC_ARCH_ARMv7  2
> #define XEN_KEXEC_ARCH_ARMv8  3

The way this is defined for kexec on linux is that we always transition
in the processors native mode.  The page tables for the transition are
definined as being identity mapped for the pages specified in the image.

The linux kexec pass in what architecture it thinks the system is runing
in so that the kexec_load implemenation can fail load requests with the
wrong architecture.

In particular a 32bit kexec on a x86_64 kernel does expect to transition
in 64bit mode.

Non-native transitions are possible if you want to support them when Xen
is crashing but I don't see the point.  I do admit I am a bit puzzled on
how a 32bit dom0 on a 64bit hypervisor implements kexec on panic
functionality today.  Xen is weird.  Shrug.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
