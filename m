Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from nat28.tlf.novell.com ([130.57.49.28])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ViLA6-0005uR-4c
 for kexec@lists.infradead.org; Mon, 18 Nov 2013 09:30:31 +0000
Message-Id: <5289EC150200007800103EC2@nat28.tlf.novell.com>
Date: Mon, 18 Nov 2013 09:29:41 +0000
From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [PATCH] xen/kexec: Clear unused registers before jumping
 into an image
References: <1384530974-26813-1-git-send-email-daniel.kiper@oracle.com>
 <52867EE6.7080205@citrix.com>
In-Reply-To: <52867EE6.7080205@citrix.com>
Mime-Version: 1.0
Content-Disposition: inline
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
To: David Vrabel <david.vrabel@citrix.com>, Daniel Kiper <daniel.kiper@oracle.com>
Cc: keir@xen.org, george.dunlap@eu.citrix.com, andrew.cooper3@citrix.com, kexec@lists.infradead.org, xen-devel@lists.xen.org, ebiederm@xmission.com

>>> On 15.11.13 at 21:07, David Vrabel <david.vrabel@citrix.com> wrote:
> On 15/11/13 15:56, Daniel Kiper wrote:
>> Clear unused registers before jumping into an image. This way
>> loaded image could not assume that any register has an specific
>> info about earlier running Xen hypervisor. However, it also
>> does not mean that the image may expect that a given register
>> is zeroed. The image MUST assume that every register has a random
>> value or in other words it is uninitialized or has undefined state.
> 
> I think this, where the specification (registers undefined) differs from
> the implementation (registers zeroed), is the worst option.
> 
> I also think it is more likely for an image to inadvertently rely on a
> zero value that whatever junk Xen has left behind.

Preventing users to rely on anything would likely make it
desirable to put some random value into all unused registers.

Jan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
