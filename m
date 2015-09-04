Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZXnbb-00087B-6j
 for kexec@lists.infradead.org; Fri, 04 Sep 2015 09:48:23 +0000
Date: Fri, 4 Sep 2015 18:47:35 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] purgatory/arch/ppc64: Reset primary cpu endian to
 big-endian
Message-ID: <20150904094735.GB30724@verge.net.au>
References: <1440125476-9420-1-git-send-email-sam.mj@au1.ibm.com>
 <20150902010251.GC30886@verge.net.au>
 <1441257482.29016.6.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1441257482.29016.6.camel@ellerman.id.au>
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
Cc: kexec@lists.infradead.org, Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org

On Thu, Sep 03, 2015 at 03:18:02PM +1000, Michael Ellerman wrote:
> On Wed, 2015-09-02 at 10:02 +0900, Simon Horman wrote:
> > [CC linuxppc-dev]
> > 
> > On Fri, Aug 21, 2015 at 12:51:16PM +1000, Samuel Mendoza-Jonas wrote:
> > > Older big-endian ppc64 kernels don't include the FIXUP_ENDIAN check,
> > > meaning if we kexec from a little-endian kernel the target kernel will
> > > fail to boot.
> > > Returning to big-endian before we enter the target kernel ensures that
> > > the target kernel can boot whether or not it includes FIXUP_ENDIAN.
> > > 
> > > This mirrors commit 150b14e7 in kexec-lite.
> > > 
> > > Signed-off-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
> > 
> > I would value a review from one of the PPC folks.
> 
> The diff looks good to me, and I've also tested it, so take your pick:
> 
> Tested-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks, I took the latter.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
