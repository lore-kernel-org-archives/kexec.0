Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ViMvo-0007yU-6l
 for kexec@lists.infradead.org; Mon, 18 Nov 2013 11:23:53 +0000
Message-ID: <5289F8AF.7090909@citrix.com>
Date: Mon, 18 Nov 2013 11:23:27 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [PATCH] xen/kexec: Clear unused registers before jumping into
 an image
References: <1384530974-26813-1-git-send-email-daniel.kiper@oracle.com>
 <52867EE6.7080205@citrix.com> <5289EC150200007800103EC2@nat28.tlf.novell.com>
In-Reply-To: <5289EC150200007800103EC2@nat28.tlf.novell.com>
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
To: Jan Beulich <JBeulich@suse.com>
Cc: keir@xen.org, george.dunlap@eu.citrix.com, andrew.cooper3@citrix.com, Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, xen-devel@lists.xen.org, ebiederm@xmission.com

On 18/11/13 09:29, Jan Beulich wrote:
>>>> On 15.11.13 at 21:07, David Vrabel <david.vrabel@citrix.com> wrote:
>> On 15/11/13 15:56, Daniel Kiper wrote:
>>> Clear unused registers before jumping into an image. This way
>>> loaded image could not assume that any register has an specific
>>> info about earlier running Xen hypervisor. However, it also
>>> does not mean that the image may expect that a given register
>>> is zeroed. The image MUST assume that every register has a random
>>> value or in other words it is uninitialized or has undefined state.
>>
>> I think this, where the specification (registers undefined) differs from
>> the implementation (registers zeroed), is the worst option.
>>
>> I also think it is more likely for an image to inadvertently rely on a
>> zero value that whatever junk Xen has left behind.
> 
> Preventing users to rely on anything would likely make it
> desirable to put some random value into all unused registers.

I don't think we need to go that far.

I would just like to avoid someone looking that the implementation (and
not the documentation) and concluding that zero-ing of the registers is
part of the specified behaviour, or looking at the implementation and
documentation and wondering why they don't agree.

I really don't think there is anything more to be said on this.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
