Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zt4Wv-0003FC-Od
 for kexec@lists.infradead.org; Mon, 02 Nov 2015 02:07:30 +0000
Date: Mon, 2 Nov 2015 11:06:55 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 2/3] ppc64: Avoid rfid if no need to clear MSR_LE
Message-ID: <20151102020655.GD11188@verge.net.au>
References: <1444172150-29493-1-git-send-email-scottwood@freescale.com>
 <1444172150-29493-2-git-send-email-scottwood@freescale.com>
 <20151101225553.GA1995@localhost.localdomain>
 <20151102002143.GA7053@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20151102002143.GA7053@localhost.localdomain>
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
To: Sam Mendoza-Jonas <sam.mj@au1.ibm.com>
Cc: Scott Wood <scottwood@freescale.com>, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org

On Mon, Nov 02, 2015 at 11:21:43AM +1100, Sam Mendoza-Jonas wrote:
> On Mon, Nov 02, 2015 at 09:55:53AM +1100, Sam Mendoza-Jonas wrote:
> > On Tue, Oct 06, 2015 at 05:55:49PM -0500, Scott Wood wrote:
> > > Commit a304e2d82a8c3 ("ppc64: purgatory: Reset primary cpu endian to
> > > big-endian) changed bctr to rfid.  rfid is book3s-only and will cause a
> > > fatal exception on book3e.
> > > 
> > > Purgatory is an isolated environment which makes importing information
> > > about the subarch awkward, so instead rely on the fact that MSR_LE
> > > should never be set on book3e, and the rfid is only needed if MSR_LE is
> > > set (and thus needs to be cleared).  In theory that MSR bit is reserved
> > > on book3e, rather than zero, but in practice I have not seen it set.
> > > 
> > > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > > Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
> > > ---
> > > v2: new patch
> > 
> > Looks good to me, thanks for catching this!
> > I'll ping Michael too if you'd like his reviewed-by.
> > 
> > Reviewed-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
> 
> Following up, also add my
> 
> Tested-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>

Thanks, I have queued this up for v2.0.11.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
