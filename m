Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zt2tu-0003QU-Sn
 for kexec@lists.infradead.org; Mon, 02 Nov 2015 00:23:08 +0000
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <sam.mj@au1.ibm.com>;
 Mon, 2 Nov 2015 10:22:43 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 30F452BB003F
 for <kexec@lists.infradead.org>; Mon,  2 Nov 2015 11:22:41 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA20MY0G34406514
 for <kexec@lists.infradead.org>; Mon, 2 Nov 2015 11:22:42 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA20M8pr027376
 for <kexec@lists.infradead.org>; Mon, 2 Nov 2015 11:22:08 +1100
Date: Mon, 2 Nov 2015 11:21:43 +1100
From: Sam Mendoza-Jonas <sam.mj@au1.ibm.com>
Subject: Re: [PATCH v2 2/3] ppc64: Avoid rfid if no need to clear MSR_LE
Message-ID: <20151102002143.GA7053@localhost.localdomain>
References: <1444172150-29493-1-git-send-email-scottwood@freescale.com>
 <1444172150-29493-2-git-send-email-scottwood@freescale.com>
 <20151101225553.GA1995@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20151101225553.GA1995@localhost.localdomain>
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
To: Scott Wood <scottwood@freescale.com>
Cc: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, linuxppc-dev@lists.ozlabs.org

On Mon, Nov 02, 2015 at 09:55:53AM +1100, Sam Mendoza-Jonas wrote:
> On Tue, Oct 06, 2015 at 05:55:49PM -0500, Scott Wood wrote:
> > Commit a304e2d82a8c3 ("ppc64: purgatory: Reset primary cpu endian to
> > big-endian) changed bctr to rfid.  rfid is book3s-only and will cause a
> > fatal exception on book3e.
> > 
> > Purgatory is an isolated environment which makes importing information
> > about the subarch awkward, so instead rely on the fact that MSR_LE
> > should never be set on book3e, and the rfid is only needed if MSR_LE is
> > set (and thus needs to be cleared).  In theory that MSR bit is reserved
> > on book3e, rather than zero, but in practice I have not seen it set.
> > 
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
> > ---
> > v2: new patch
> 
> Looks good to me, thanks for catching this!
> I'll ping Michael too if you'd like his reviewed-by.
> 
> Reviewed-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>

Following up, also add my

Tested-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>

> 
> > 
> >  purgatory/arch/ppc64/v2wrap.S | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/purgatory/arch/ppc64/v2wrap.S b/purgatory/arch/ppc64/v2wrap.S
> > index 179ade9..3534080 100644
> > --- a/purgatory/arch/ppc64/v2wrap.S
> > +++ b/purgatory/arch/ppc64/v2wrap.S
> > @@ -116,9 +116,17 @@ master:
> >  	stw	7,0x5c(4)	# and patch it into the kernel
> >  	mr      3,16            # restore dt address
> >  
> > +	mfmsr	5
> > +	andi.	10,5,1		# test MSR_LE
> > +	bne	little_endian
> > +
> > +	li	5,0		# r5 will be 0 for kernel
> > +	mtctr	4		# prepare branch to
> > +	bctr			# start kernel
> > +	
> > +little_endian:			# book3s-only
> >  	mtsrr0	4		# prepare branch to
> >  
> > -	mfmsr	5
> >  	clrrdi	5,5,1		# clear MSR_LE
> >  	mtsrr1	5
> >  
> > -- 
> > 2.1.4
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
