Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1S2An0-0000m2-Bf
 for kexec@lists.infradead.org; Tue, 28 Feb 2012 00:19:35 +0000
Date: Tue, 28 Feb 2012 09:19:28 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: crash: don't save swapper_pg_dir for !CONFIG_MMU
 configurations
Message-ID: <20120228001928.GB11325@verge.net.au>
References: <1330094447-11900-1-git-send-email-will.deacon@arm.com>
 <20120225023748.GE21429@verge.net.au>
 <20120226225842.GA23028@mudshark.cambridge.arm.com>
 <20120227003727.GA30831@verge.net.au>
 <20120227193054.GB24605@mudshark.cambridge.arm.com>
 <20120227235235.GE24159@verge.net.au>
 <20120227155643.cafb1c6d.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120227155643.cafb1c6d.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Will Deacon <will.deacon@arm.com>

On Mon, Feb 27, 2012 at 03:56:43PM -0800, Andrew Morton wrote:
> On Tue, 28 Feb 2012 08:52:35 +0900
> Simon Horman <horms@verge.net.au> wrote:
> 
> > On Mon, Feb 27, 2012 at 07:30:54PM +0000, Will Deacon wrote:
> > > On Mon, Feb 27, 2012 at 12:37:30AM +0000, Simon Horman wrote:
> > > > On Sun, Feb 26, 2012 at 10:58:42PM +0000, Will Deacon wrote:
> > > > > On Sat, Feb 25, 2012 at 02:37:49AM +0000, Simon Horman wrote:
> > > > > 
> > > > > > might this cover cases where swapper_pg_dir is interesting?
> > > > > 
> > > > > The only case where it's interesting is when you have CONFIG_MMU enabled -
> > > > > otherwise it's always NULL. If it's #defined as NULL, the current code will
> > > > > fail at build time so simply omitting it from the dump seems like the best
> > > > > bet to me (the alternative being to add a NULL entry explicitly, but I don't
> > > > > see what the gains us).
> > > > 
> > > > Hi Will,
> > > > 
> > > > thanks for the clarification. FWIW I am happy with your patch.
> > > > 
> > > > Reviewed-by: Simon Horman <horms@verge.net.au>
> > > 
> > > Cheers, Simon. What's the usual path for generic kexec code getting into
> > > mainline? Do I need to get this queued somewhere?
> > 
> > I think that Andrew Morton often picks up these kind of patches.
> 
> I'll take anything, if I have any chance of vaguely understanding it ;)
> 
> > Andrew, can you pick this up if its reposted with you CCed?
> > For reference the patch is as follows:
> > 
> > 
> > From: Will Deacon <will.deacon@arm.com>
> > 
> > kexec: crash: don't save swapper_pg_dir for !CONFIG_MMU configurations
> > 
> > nommu platforms don't have very interesting swapper_pg_dir pointers and
> > usually just #define them to NULL, meaning that we can't include them in
> > the vmcoreinfo on the kexec crash path.
> > 
> > This patch only saves the swapper_pg_dir if we have an MMU.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > Reviewed-by: Simon Horman <horms@verge.net.au>
> > 
> > ---
> >  kernel/kexec.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > index 7b08867..cb5d13c 100644
> > --- a/kernel/kexec.c
> > +++ b/kernel/kexec.c
> > @@ -1462,7 +1462,9 @@ static int __init crash_save_vmcoreinfo_init(void)
> >  
> >  	VMCOREINFO_SYMBOL(init_uts_ns);
> >  	VMCOREINFO_SYMBOL(node_online_map);
> > +#ifdef CONFIG_MMU
> >  	VMCOREINFO_SYMBOL(swapper_pg_dir);
> > +#endif
> >  	VMCOREINFO_SYMBOL(_stext);
> >  	VMCOREINFO_SYMBOL(vmlist);
> 
> Well, what might be the effects of this patch?  nommu crashfiles will
> no longer have the swapper_pg_dir string?  What are the chances that
> someone's (badly written!) downstream tool will crash and burn if this
> is absent?

My understanding is that up until this patch creating a dump
for nonmmu platform wouldn't work.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
