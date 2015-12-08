Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([103.22.144.67])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a69Ei-0004Xb-6z
 for kexec@lists.infradead.org; Tue, 08 Dec 2015 03:46:45 +0000
Message-ID: <1449546377.12218.9.camel@ellerman.id.au>
Subject: Re: [PATCH v2 3/3] ppc64: Add a flag to tell the kernel it's
 booting from kexec
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 08 Dec 2015 14:46:17 +1100
In-Reply-To: <1449520948.15946.89.camel@freescale.com>
References: <1444172150-29493-1-git-send-email-scottwood@freescale.com>
 <1444172150-29493-3-git-send-email-scottwood@freescale.com>
 <1449520948.15946.89.camel@freescale.com>
Mime-Version: 1.0
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
To: Scott Wood <scottwood@freescale.com>, Simon Horman <horms@verge.net.au>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org

On Mon, 2015-12-07 at 14:42 -0600, Scott Wood wrote:
> On Tue, 2015-10-06 at 17:55 -0500, Scott Wood wrote:
> > It needs to know this because the SMP release mechanism for Freescale
> > book3e is different from when booting with normal hardware.  In theory
> > we could simulate the normal spin table mechanism, but not (easily) at
> > the addresses U-Boot put in the device tree -- so there'd need to be
> > even more communication between the kernel and kexec to set that up.
> > 
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > ---
> > v2: Use a device tree property rather than setting a flag in the kernel
> > image, as requested by Michael Ellerman.
> 
> ping?
> 
> Michael, can you review this?  Simon is waiting for another PPC person to
> review it.

Oh sorry I thought it'd been merged already, but I see now only 1 & 2 went in.

Horms this looks fine to me:

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
