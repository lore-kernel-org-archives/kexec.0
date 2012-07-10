Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SocO9-00035Z-G7
 for kexec@lists.infradead.org; Tue, 10 Jul 2012 15:30:10 +0000
Message-ID: <1341934149.8586.45.camel@hastur.hellion.org.uk>
Subject: Re: [Xen-devel] incorrect layout of globals from head_64.S during
 kexec boot
From: Ian Campbell <ian.campbell@citrix.com>
Date: Tue, 10 Jul 2012 09:29:09 -0600
In-Reply-To: <20120710145110.GA15218@phenom.dumpdata.com>
References: <20120706084120.GA31219@router-fw-old.local.net-space.pl>
 <20120706120750.GA8970@aepfle.de>
 <4FF6FCA9020000780008E0BB@nat28.tlf.novell.com>
 <20120706133105.GA20600@aepfle.de> <20120706141419.GA21951@aepfle.de>
 <4FF7174C020000780008E1FF@nat28.tlf.novell.com>
 <20120706172918.GA15222@aepfle.de> <20120710093327.GA13864@aepfle.de>
 <20120710141411.GB1791@phenom.dumpdata.com>
 <1341931594.8586.44.camel@hastur.hellion.org.uk>
 <20120710145110.GA15218@phenom.dumpdata.com>
MIME-Version: 1.0
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
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Olaf Hering <olaf@aepfle.de>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@suse.com>, Daniel Kiper <dkiper@net-space.pl>

On Tue, 2012-07-10 at 10:51 -0400, Konrad Rzeszutek Wilk wrote:
> On Tue, Jul 10, 2012 at 08:46:34AM -0600, Ian Campbell wrote:
> > On Tue, 2012-07-10 at 10:14 -0400, Konrad Rzeszutek Wilk wrote:
> > > Which brings me to another question - say we do use this patch, what
> > > if the decompressor overwrites the old kernels .data section. Won't
> > > we run into this problem again?
> > 
> > I've not really been following this thread that closely but wouldn't the
> > right answer be for the original kernel to unmap the shared info on
> > kexec? Or maybe remap it up to some high/reserved address? Can it read
> 
> That would be the right answer I think, but I don't see the a VCPU_deregister
> call (only VCPU_register).

Is the issue here vcpuinfo or the shared info (or both)?

> But perhaps the XENMEM_decrease_reservation for the particular MFN is the
> answer to do a VCPU "de-register" ?
> 
> > the original address used by hvmloader at start of day and reuse that?
> 
> Wait, we can map multiple shared_info? Ooh, somehow I thought the guest
> could only do one registration.

I think you can only have one mapping but you can move it by registering
it again.

Ian.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
