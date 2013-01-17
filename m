Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TvteY-0005mm-1a
 for kexec@lists.infradead.org; Thu, 17 Jan 2013 17:53:26 +0000
Message-ID: <50F83A8D.2030307@citrix.com>
Date: Thu, 17 Jan 2013 17:53:17 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] kexec: extend hypercall with improved load/unload ops
References: <1358353746-1899-1-git-send-email-david.vrabel@citrix.com>
 <1358353746-1899-2-git-send-email-david.vrabel@citrix.com>
 <20130117122803.GC2871@host-192-168-1-59.local.net-space.pl>
 <50F80FB2.9080107@citrix.com>
 <20130117151712.GE2871@host-192-168-1-59.local.net-space.pl>
In-Reply-To: <20130117151712.GE2871@host-192-168-1-59.local.net-space.pl>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Eric Biederman <ebiederm@xmission.com>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On 17/01/13 15:17, Daniel Kiper wrote:
> On Thu, Jan 17, 2013 at 02:50:26PM +0000, David Vrabel wrote:
>> On 17/01/13 12:28, Daniel Kiper wrote:
>>> On Wed, Jan 16, 2013 at 04:29:04PM +0000, David Vrabel wrote:
[..]
>>>> +    if ( image->class == KEXEC_CLASS_32 )
>>>> +        compat_machine_kexec(image->entry_maddr);
>>>
>>> Why do you need that?
>>
>> image->class controls whether the processor is in 32-bit or 64-bit mode
>> when calling the image.  The current implementation only allows images
>> to be executed with the same class as dom0.
>>
>> It's called class because that's the term ELF uses in the ELF header.
> 
> As I correctly understand this sets processor mode before new kernel exection.
> If yes then it is not needed. Purgatory code (from kexec-tools) does all
> needed things. Please check.

On x86 I think it would probably be fine to specify entry is always in
64-bit mode but for ARM and future architectures it is less clear and it
becomes more difficult to have a well-defined ABI.

In fact, we probably want a more generic architecture field. e.g,

#define XEN_KEXEC_ARCH_X86_32 0
#define XEN_KEXEC_ARCH_X86_64 1
#define XEN_KEXEC_ARCH_ARMv7  2
#define XEN_KEXEC_ARCH_ARMv8  3

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
