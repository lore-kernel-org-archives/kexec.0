Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rcsinet15.oracle.com ([148.87.113.117])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SofMi-0000GM-Ds
 for kexec@lists.infradead.org; Tue, 10 Jul 2012 18:40:54 +0000
Date: Tue, 10 Jul 2012 14:32:13 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] incorrect layout of globals from head_64.S during
 kexec boot
Message-ID: <20120710183213.GB24536@phenom.dumpdata.com>
References: <4FF6FCA9020000780008E0BB@nat28.tlf.novell.com>
 <20120706133105.GA20600@aepfle.de>
 <20120706141419.GA21951@aepfle.de>
 <4FF7174C020000780008E1FF@nat28.tlf.novell.com>
 <20120706172918.GA15222@aepfle.de>
 <20120710093327.GA13864@aepfle.de>
 <20120710141411.GB1791@phenom.dumpdata.com>
 <20120710152308.GA31819@aepfle.de>
 <20120710172626.GA6868@phenom.dumpdata.com>
 <20120710180953.GB20075@aepfle.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120710180953.GB20075@aepfle.de>
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
To: Olaf Hering <olaf@aepfle.de>
Cc: Jan Beulich <JBeulich@suse.com>, xen-devel@lists.xensource.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Daniel Kiper <dkiper@net-space.pl>

On Tue, Jul 10, 2012 at 08:09:53PM +0200, Olaf Hering wrote:
> On Tue, Jul 10, Konrad Rzeszutek Wilk wrote:
> 
> > On Tue, Jul 10, 2012 at 05:23:08PM +0200, Olaf Hering wrote:
> > > I was not thinking of statically allocated pages but some new concept of
> > > allocating such shared pages. Shouldnt there be some dedicated area in
> > > the E820 table which has to be used during the whole life time of the
> > > guest?
> > 
> > Not that I can see. But I don't see why that could not be added? Perhaps
> > the HVM loader can make it happen? But then how would it tell the kernel
> > that this E820_RESERVED is the shared_info one. Not the other ones..
> 
> Maybe just use a new E820 type for this sort of thing? Its just the

Ewww.
> question wether some other OS can cope with an unknown type. From my
> reading of the e820 related code a region with an unknown type is just
> ignored.

Sure. And we could scan it.. but scanning E820_UNKNOWN for some magic
header seems .. hacky.

> 
> > > Are there more shared areas or is it just the shared info page?
> > > 
> > > > And I am kind of worried that moving it to the .data section won't
> > > > be completly safe - as the decompressor might blow away that part too.
> > > 
> > > The decompressor may just clear the area, but since there is no way to
> > > tell where the shared pages are its always a risk to allocate them at
> > > compile time.
> > 
> > Yeah, and with the hypervisor potentially still updating the "old"
> > MFN before the new kernel has registered the new MFN, we can end up
> > corrupting the new kernel. Ouch.
> > 
> > Would all of these issues disappear if the hypervisor had a hypercall
> > that would stop updating the shared info? or just deregister the MFN?
> > What if you ripped the GMFN out using 'decrease_reservation' hypercall?
> > Would that eliminate the pesky GMFN?
> 
> I'm not sure, most likely the gfn will just disappear from the guest,
> like a ballooned page disappears. Accessing it will likely cause a
> crash.

What about an populate_physmap right afterwards to stick a newly
minted GMFN in its place? I don't really know whether this dance
of balloon out/balloon in the same GMFN will break the shared_info
relationship. Perhaps not?

What we are going for is to stop the hypervisor from using the shared_info
MFN... perhaps there are other ways to do this?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
