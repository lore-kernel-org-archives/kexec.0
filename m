Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ViNPb-0000DD-J2
 for kexec@lists.infradead.org; Mon, 18 Nov 2013 11:54:40 +0000
Date: Mon, 18 Nov 2013 12:53:08 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH] xen/kexec: Clear unused registers before jumping into an
 image
Message-ID: <20131118115308.GF3506@olila.local.net-space.pl>
References: <1384530974-26813-1-git-send-email-daniel.kiper@oracle.com>
 <52867EE6.7080205@citrix.com>
 <5289EC150200007800103EC2@nat28.tlf.novell.com>
 <20131118110845.GC3506@olila.local.net-space.pl>
 <528A07B60200007800103FD1@nat28.tlf.novell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <528A07B60200007800103FD1@nat28.tlf.novell.com>
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
Cc: keir@xen.org, george.dunlap@eu.citrix.com, andrew.cooper3@citrix.com, kexec@lists.infradead.org, xen-devel@lists.xen.org, David Vrabel <david.vrabel@citrix.com>, ebiederm@xmission.com

On Mon, Nov 18, 2013 at 11:27:34AM +0000, Jan Beulich wrote:
> >>> On 18.11.13 at 12:08, Daniel Kiper <daniel.kiper@oracle.com> wrote:
> > On Mon, Nov 18, 2013 at 09:29:41AM +0000, Jan Beulich wrote:
> >> >>> On 15.11.13 at 21:07, David Vrabel <david.vrabel@citrix.com> wrote:
> >> > On 15/11/13 15:56, Daniel Kiper wrote:
> >> >> Clear unused registers before jumping into an image. This way
> >> >> loaded image could not assume that any register has an specific
> >> >> info about earlier running Xen hypervisor. However, it also
> >> >> does not mean that the image may expect that a given register
> >> >> is zeroed. The image MUST assume that every register has a random
> >> >> value or in other words it is uninitialized or has undefined state.
> >> >
> >> > I think this, where the specification (registers undefined) differs from
> >> > the implementation (registers zeroed), is the worst option.
> >> >
> >> > I also think it is more likely for an image to inadvertently rely on a
> >> > zero value that whatever junk Xen has left behind.
> >>
> >> Preventing users to rely on anything would likely make it
> >> desirable to put some random value into all unused registers.
> >
> > Right, but on the other hand this way we lose completely chance
> > to differentiate between old and new implementation of kexec
> > if we would like to do that in the future (yes, this is small
> > chance but it still exists). Additionally, I think it could be
> > quite difficult because at this stage there is no simple reliable
> > RNGs. Although there are some CPUs with RNGs but they are not
> > very common right now. However, I will do not object if we find
> > another simple RNG.
>
> We surely wouldn't need a good quality random number here -
> the TSC would very likely already be more random than anything
> we need.

I forgot about TSC. This is OK in that case. Thanks. Personally I prefer
zeroing (I explained above and in other emails why) but if David do not
like it we could use TSC. David?

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
