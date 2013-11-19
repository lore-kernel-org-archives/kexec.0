Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VirLy-0001DL-5v
 for kexec@lists.infradead.org; Tue, 19 Nov 2013 19:52:55 +0000
Date: Tue, 19 Nov 2013 14:51:16 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [PATCH] xen/kexec: Clear unused registers before
 jumping into an image
Message-ID: <20131119195116.GC7824@phenom.dumpdata.com>
References: <1384530974-26813-1-git-send-email-daniel.kiper@oracle.com>
 <52867EE6.7080205@citrix.com>
 <5289EC150200007800103EC2@nat28.tlf.novell.com>
 <5289F8AF.7090909@citrix.com>
 <20131118114750.GE3506@olila.local.net-space.pl>
 <528A0292.4040205@eu.citrix.com>
 <20131118124102.GH3506@olila.local.net-space.pl>
 <20131118141343.3350a21b@hananiah.suse.cz>
 <528A1EEC.4060509@eu.citrix.com>
 <20131119193541.GA31196@andromeda.dapyr.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131119193541.GA31196@andromeda.dapyr.net>
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
To: Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc: keir@xen.org, George Dunlap <george.dunlap@eu.citrix.com>, Petr Tesarik <ptesarik@suse.cz>, Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, xen-devel@lists.xen.org, David Vrabel <david.vrabel@citrix.com>, Jan Beulich <JBeulich@suse.com>, andrew.cooper3@citrix.com, ebiederm@xmission.com

On Tue, Nov 19, 2013 at 03:35:41PM -0400, Konrad Rzeszutek Wilk wrote:
> On Mon, Nov 18, 2013 at 02:06:36PM +0000, George Dunlap wrote:
> > On 18/11/13 13:13, Petr Tesarik wrote:
> > >On Mon, 18 Nov 2013 13:41:02 +0100
> > >Daniel Kiper <daniel.kiper@oracle.com> wrote:
> > >
> > >>On Mon, Nov 18, 2013 at 12:05:38PM +0000, George Dunlap wrote:
> > >>>On 18/11/13 11:47, Daniel Kiper wrote:
> > >>>>On Mon, Nov 18, 2013 at 11:23:27AM +0000, David Vrabel wrote:
> > >>>>>On 18/11/13 09:29, Jan Beulich wrote:
> > >>>>>>>>>On 15.11.13 at 21:07, David Vrabel <david.vrabel@citrix.com> wrote:
> > >>>>>>>On 15/11/13 15:56, Daniel Kiper wrote:
> > >>>>>>>>Clear unused registers before jumping into an image. This way
> > >>>>>>>>loaded image could not assume that any register has an specific
> > >>>>>>>>info about earlier running Xen hypervisor. However, it also
> > >>>>>>>>does not mean that the image may expect that a given register
> > >>>>>>>>is zeroed. The image MUST assume that every register has a random
> > >>>>>>>>value or in other words it is uninitialized or has undefined state.
> > >>>>>>>I think this, where the specification (registers undefined) differs 
> > >>>>>>>from
> > >>>>>>>the implementation (registers zeroed), is the worst option.
> > >>>>>>>
> > >>>>>>>I also think it is more likely for an image to inadvertently rely on 
> > >>>>>>>a
> > >>>>>>>zero value that whatever junk Xen has left behind.
> > >>>>>>Preventing users to rely on anything would likely make it
> > >>>>>>desirable to put some random value into all unused registers.
> > >>>>>I don't think we need to go that far.
> > >>>>>
> > >>>>>I would just like to avoid someone looking that the implementation (and
> > >>>>>not the documentation) and concluding that zero-ing of the registers is
> > >>>>>part of the specified behaviour, or looking at the implementation and
> > >>>>>documentation and wondering why they don't agree.
> > >>>>David, my comment clearly states why we are doing that and what should
> > >>>>be expected. What is wrong with it? I could improve it but say how?
> > >>>You seem to be saying that the registers may contain useful
> > >>>information about Xen that are not part of the spec, and you are
> > >>>worried that the image may decide to use these and come to rely on
> > >>>them, making it hard to change the interface in the future.
> > >>>
> > >>>David has a similar concern -- that if the registers are zeroed, the
> > >>>image may come to rely on the registers being pre-zeroed, and not
> > >>>zero them itself.  This would also make it hard to change the
> > >>>interface in the future.
> > >>>
> > >>>A simple solution would be to "poison" the registers with useless
> > >>>data: 0xdeadbeef is a favorite.  Anyone seeing that in the registers
> > >>>will immediately know, "Someone used a value that they shouldn't
> > >>>have."
> > >>>
> > >>>Of course, it's *possible* that then the images might come to rely
> > >>>on that poison being there; having a non-deterministic value there,
> > >>>like a hash of the TSC, would make this impossible.  But even then,
> > >>>you could make the argument that the image may come to rely on a
> > >>>*pseudo-random* number being there, which it uses for some other
> > >>>kind of seed somewhere.  At some point you just have to give up on
> > >>>this like of thought. :-)
> > >>:-)))
> > >>
> > >>>Personally I think having a poison is likely to be more useful -- if
> > >>>you crash because your pointer is 0xdeadbeef, then it's immediately
> > >>>obvious what kind of bug you have; whereas if you crash with a
> > >>>random value that changes every time, it's not so obvious.
> > >>It works for me too. Any solution has pros and cons. However, in general
> > >>I think that wiping registers in that case is nice idea. So we could zero
> > >>registers, write 0xdeadbeef into them or even use TSC. But please do not
> > >>leave registers as is.
> > >DEADBABE or DEADBEEF sounds best.
> > 
> > "DEADBABE" sounds awful.  We have enough problems with getting women to 
> > contribute to the kernel without reminding them of the risks of violence 
> > they face on a regular basis.
> 
> <nods>

Just to clarify - I completely agree with George. That 'DEADBABE' or any
other (see http://www.wired.com/wiredenterprise/2012/07/b16b00b5/) are
offensive.

> 
> I would like to point out that Eric Biederman stated that the
> reason for using 0 was:
>  0/NULL is a good choice because if you are expecting pointer for some
> strange reason interesting things happen.
> " (See http://article.gmane.org/gmane.linux.kernel/1577040).
> 
> Which is a bit inline with - we don't want folks to depend on it,
> so we make sure to poison it (with zeros in this case).
> 
> 0xdeadbeef would get the same thing. If we are going that route
> we perhaps we should do the same thing on Linux?
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> http://lists.xen.org/xen-devel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
