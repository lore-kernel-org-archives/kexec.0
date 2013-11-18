Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ViNaj-0000Od-HL
 for kexec@lists.infradead.org; Mon, 18 Nov 2013 12:06:10 +0000
Message-ID: <528A0292.4040205@eu.citrix.com>
Date: Mon, 18 Nov 2013 12:05:38 +0000
From: George Dunlap <george.dunlap@eu.citrix.com>
MIME-Version: 1.0
Subject: Re: [PATCH] xen/kexec: Clear unused registers before jumping into
 an image
References: <1384530974-26813-1-git-send-email-daniel.kiper@oracle.com>
 <52867EE6.7080205@citrix.com> <5289EC150200007800103EC2@nat28.tlf.novell.com>
 <5289F8AF.7090909@citrix.com>
 <20131118114750.GE3506@olila.local.net-space.pl>
In-Reply-To: <20131118114750.GE3506@olila.local.net-space.pl>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Daniel Kiper <daniel.kiper@oracle.com>, David Vrabel <david.vrabel@citrix.com>
Cc: keir@xen.org, andrew.cooper3@citrix.com, kexec@lists.infradead.org, xen-devel@lists.xen.org, ebiederm@xmission.com, Jan Beulich <JBeulich@suse.com>

On 18/11/13 11:47, Daniel Kiper wrote:
> On Mon, Nov 18, 2013 at 11:23:27AM +0000, David Vrabel wrote:
>> On 18/11/13 09:29, Jan Beulich wrote:
>>>>>> On 15.11.13 at 21:07, David Vrabel <david.vrabel@citrix.com> wrote:
>>>> On 15/11/13 15:56, Daniel Kiper wrote:
>>>>> Clear unused registers before jumping into an image. This way
>>>>> loaded image could not assume that any register has an specific
>>>>> info about earlier running Xen hypervisor. However, it also
>>>>> does not mean that the image may expect that a given register
>>>>> is zeroed. The image MUST assume that every register has a random
>>>>> value or in other words it is uninitialized or has undefined state.
>>>> I think this, where the specification (registers undefined) differs from
>>>> the implementation (registers zeroed), is the worst option.
>>>>
>>>> I also think it is more likely for an image to inadvertently rely on a
>>>> zero value that whatever junk Xen has left behind.
>>> Preventing users to rely on anything would likely make it
>>> desirable to put some random value into all unused registers.
>> I don't think we need to go that far.
>>
>> I would just like to avoid someone looking that the implementation (and
>> not the documentation) and concluding that zero-ing of the registers is
>> part of the specified behaviour, or looking at the implementation and
>> documentation and wondering why they don't agree.
> David, my comment clearly states why we are doing that and what should
> be expected. What is wrong with it? I could improve it but say how?

You seem to be saying that the registers may contain useful information 
about Xen that are not part of the spec, and you are worried that the 
image may decide to use these and come to rely on them, making it hard 
to change the interface in the future.

David has a similar concern -- that if the registers are zeroed, the 
image may come to rely on the registers being pre-zeroed, and not zero 
them itself.  This would also make it hard to change the interface in 
the future.

A simple solution would be to "poison" the registers with useless data: 
0xdeadbeef is a favorite.  Anyone seeing that in the registers will 
immediately know, "Someone used a value that they shouldn't have."

Of course, it's *possible* that then the images might come to rely on 
that poison being there; having a non-deterministic value there, like a 
hash of the TSC, would make this impossible.  But even then, you could 
make the argument that the image may come to rely on a *pseudo-random* 
number being there, which it uses for some other kind of seed 
somewhere.  At some point you just have to give up on this like of 
thought. :-)

Personally I think having a poison is likely to be more useful -- if you 
crash because your pointer is 0xdeadbeef, then it's immediately obvious 
what kind of bug you have; whereas if you crash with a random value that 
changes every time, it's not so obvious.

  -George

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
