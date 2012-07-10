Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mo6-p00-ob.rzone.de ([2a01:238:20a:202:5300::1])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SocVo-0003rH-Ao
 for kexec@lists.infradead.org; Tue, 10 Jul 2012 15:38:04 +0000
Date: Tue, 10 Jul 2012 17:37:47 +0200
From: Olaf Hering <olaf@aepfle.de>
Subject: Re: [Xen-devel] incorrect layout of globals from head_64.S during
 kexec boot
Message-ID: <20120710153747.GA1731@aepfle.de>
References: <4FF6FCA9020000780008E0BB@nat28.tlf.novell.com>
 <20120706133105.GA20600@aepfle.de>
 <20120706141419.GA21951@aepfle.de>
 <4FF7174C020000780008E1FF@nat28.tlf.novell.com>
 <20120706172918.GA15222@aepfle.de>
 <20120710093327.GA13864@aepfle.de>
 <20120710141411.GB1791@phenom.dumpdata.com>
 <1341931594.8586.44.camel@hastur.hellion.org.uk>
 <20120710145110.GA15218@phenom.dumpdata.com>
 <1341934149.8586.45.camel@hastur.hellion.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1341934149.8586.45.camel@hastur.hellion.org.uk>
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
To: Ian Campbell <ian.campbell@citrix.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@suse.com>, Daniel Kiper <dkiper@net-space.pl>

On Tue, Jul 10, Ian Campbell wrote:

> On Tue, 2012-07-10 at 10:51 -0400, Konrad Rzeszutek Wilk wrote:
> > On Tue, Jul 10, 2012 at 08:46:34AM -0600, Ian Campbell wrote:
> > > On Tue, 2012-07-10 at 10:14 -0400, Konrad Rzeszutek Wilk wrote:
> > > > Which brings me to another question - say we do use this patch, what
> > > > if the decompressor overwrites the old kernels .data section. Won't
> > > > we run into this problem again?
> > > 
> > > I've not really been following this thread that closely but wouldn't the
> > > right answer be for the original kernel to unmap the shared info on
> > > kexec? Or maybe remap it up to some high/reserved address? Can it read
> > 
> > That would be the right answer I think, but I don't see the a VCPU_deregister
> > call (only VCPU_register).
> 
> Is the issue here vcpuinfo or the shared info (or both)?

shared info is the issue in PVonHVM.

Olaf

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
