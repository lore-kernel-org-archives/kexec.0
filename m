Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([2401:3900:2:1::2])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZXMuo-0003Gy-M7
 for kexec@lists.infradead.org; Thu, 03 Sep 2015 05:18:27 +0000
Message-ID: <1441257482.29016.6.camel@ellerman.id.au>
Subject: Re: [PATCH] purgatory/arch/ppc64: Reset primary cpu endian to
 big-endian
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 03 Sep 2015 15:18:02 +1000
In-Reply-To: <20150902010251.GC30886@verge.net.au>
References: <1440125476-9420-1-git-send-email-sam.mj@au1.ibm.com>
 <20150902010251.GC30886@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org

On Wed, 2015-09-02 at 10:02 +0900, Simon Horman wrote:
> [CC linuxppc-dev]
> 
> On Fri, Aug 21, 2015 at 12:51:16PM +1000, Samuel Mendoza-Jonas wrote:
> > Older big-endian ppc64 kernels don't include the FIXUP_ENDIAN check,
> > meaning if we kexec from a little-endian kernel the target kernel will
> > fail to boot.
> > Returning to big-endian before we enter the target kernel ensures that
> > the target kernel can boot whether or not it includes FIXUP_ENDIAN.
> > 
> > This mirrors commit 150b14e7 in kexec-lite.
> > 
> > Signed-off-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
> 
> I would value a review from one of the PPC folks.

The diff looks good to me, and I've also tested it, so take your pick:

Tested-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
