Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1OCZPi-0001ZE-Hp
	for kexec@lists.infradead.org; Thu, 13 May 2010 14:29:27 +0000
Date: Thu, 13 May 2010 23:29:15 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: remove unused code from
	arch_process_options (arm, cris, ia64, mips, ppc)
Message-ID: <20100513142909.GA10534@verge.net.au>
References: <4BEBAB67.30107@ozlabs.org>
 <4BEBAF60.5000300@ozlabs.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4BEBAF60.5000300@ozlabs.org>
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
To: Matt Evans <matt@ozlabs.org>
Cc: kexec@lists.infradead.org

On Thu, May 13, 2010 at 05:50:56PM +1000, Matt Evans wrote:
> Matt Evans wrote:
> > These architectures don't have any architecture-specific options
> > (note: distinct from loader options, which are more specific), yet
> > their arch_process_options() functions contain getopts_long() calls
> > followed by no argument processing.  The code doesn't do anything,
> > so this patch removes it.
> > 
> > Signed-off-by: Matt Evans <matt@ozlabs.org>
> > ---
> >  kexec/arch/arm/kexec-arm.c   |   17 -----------------
> >  kexec/arch/cris/kexec-cris.c |   17 -----------------
> >  kexec/arch/ia64/kexec-ia64.c |   21 +++------------------
> >  kexec/arch/mips/kexec-mips.c |   17 -----------------
> >  kexec/arch/ppc/kexec-ppc.c   |   17 -----------------
> >  5 files changed, 3 insertions(+), 86 deletions(-)
> 
> I forgot to add that unfortunately I have only been able to compile this
> patch on ppc.  Since the code carefully removed doesn't have any effect I
> am hopeful for the rest...  :-)

Thanks, applied.

I successfully compiled the code for the other architectures
with the exception of cris (as I don't have access to the box
with that cross compiler at the moment).

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
