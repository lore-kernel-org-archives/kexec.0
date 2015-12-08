Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a6BLg-0006zt-4g
 for kexec@lists.infradead.org; Tue, 08 Dec 2015 06:02:05 +0000
Date: Tue, 8 Dec 2015 15:01:39 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 3/3] ppc64: Add a flag to tell the kernel it's booting
 from kexec
Message-ID: <20151208060139.GA20730@verge.net.au>
References: <1444172150-29493-1-git-send-email-scottwood@freescale.com>
 <1444172150-29493-3-git-send-email-scottwood@freescale.com>
 <1449520948.15946.89.camel@freescale.com>
 <1449546377.12218.9.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1449546377.12218.9.camel@ellerman.id.au>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org

On Tue, Dec 08, 2015 at 02:46:17PM +1100, Michael Ellerman wrote:
> On Mon, 2015-12-07 at 14:42 -0600, Scott Wood wrote:
> > On Tue, 2015-10-06 at 17:55 -0500, Scott Wood wrote:
> > > It needs to know this because the SMP release mechanism for Freescale
> > > book3e is different from when booting with normal hardware.  In theory
> > > we could simulate the normal spin table mechanism, but not (easily) at
> > > the addresses U-Boot put in the device tree -- so there'd need to be
> > > even more communication between the kernel and kexec to set that up.
> > > 
> > > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > > ---
> > > v2: Use a device tree property rather than setting a flag in the kernel
> > > image, as requested by Michael Ellerman.
> > 
> > ping?
> > 
> > Michael, can you review this?  Simon is waiting for another PPC person to
> > review it.
> 
> Oh sorry I thought it'd been merged already, but I see now only 1 & 2 went in.
> 
> Horms this looks fine to me:
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
