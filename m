Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tr8Q6-0006TL-7Z
 for kexec@lists.infradead.org; Fri, 04 Jan 2013 14:38:51 +0000
Message-ID: <50E6E974.5090805@citrix.com>
Date: Fri, 4 Jan 2013 14:38:44 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH v3 00/11] xen: Initial kexec/kdump
 implementation
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>	<50DBC856.6030208@zytor.com>	<791b4922-078f-4adc-b3f3-0651f2266147@email.android.com>	<50DC58C4.3000307@citrix.com>
 <874nj7qsor.fsf@xmission.com>	<50E41973.9050705@citrix.com>
 <20130104142257.GC3346@host-192-168-1-59.local.net-space.pl>
In-Reply-To: <20130104142257.GC3346@host-192-168-1-59.local.net-space.pl>
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
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "H. Peter Anvin" <hpa@zytor.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, Andrew Cooper <andrew.cooper3@citrix.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "jbeulich@suse.com" <jbeulich@suse.com>, "maxim.uvarov@oracle.com" <maxim.uvarov@oracle.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 04/01/13 14:22, Daniel Kiper wrote:
> On Wed, Jan 02, 2013 at 11:26:43AM +0000, Andrew Cooper wrote:
>> On 27/12/12 18:02, Eric W. Biederman wrote:
>>> Andrew Cooper<andrew.cooper3@citrix.com>  writes:
>>>
>>>> On 27/12/2012 07:53, Eric W. Biederman wrote:
>>>>> The syscall ABI still has the wrong semantics.
>>>>>
>>>>> Aka totally unmaintainable and umergeable.
>>>>>
>>>>> The concept of domU support is also strange.  What does domU support even mean, when the dom0 support is loading a kernel to pick up Xen when Xen falls over.
>>>> There are two requirements pulling at this patch series, but I agree
>>>> that we need to clarify them.
>>> It probably make sense to split them apart a little even.
>>>
>>>
>>
>> Thinking about this split, there might be a way to simply it even more.
>>
>> /sbin/kexec can load the "Xen" crash kernel itself by issuing
>> hypercalls using /dev/xen/privcmd.  This would remove the need for
>> the dom0 kernel to distinguish between loading a crash kernel for
>> itself and loading a kernel for Xen.
>>
>> Or is this just a silly idea complicating the matter?
> 
> This is impossible with current Xen kexec/kdump interface.
> It should be changed to do that. However, I suppose that
> Xen community would not be interested in such changes.

I don't see why the hypercall ABI cannot be extended with new sub-ops
that do the right thing -- the existing ABI is a bit weird.

I plan to start prototyping something shortly (hopefully next week) for
the Xen kexec case.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
