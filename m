Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1S2BI0-0002MS-FJ
 for kexec@lists.infradead.org; Tue, 28 Feb 2012 00:51:37 +0000
Date: Tue, 28 Feb 2012 09:51:30 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: crash: don't save swapper_pg_dir for !CONFIG_MMU
 configurations
Message-ID: <20120228005130.GE11325@verge.net.au>
References: <1330094447-11900-1-git-send-email-will.deacon@arm.com>
 <20120225023748.GE21429@verge.net.au>
 <20120226225842.GA23028@mudshark.cambridge.arm.com>
 <20120227003727.GA30831@verge.net.au>
 <20120227193054.GB24605@mudshark.cambridge.arm.com>
 <20120227235235.GE24159@verge.net.au>
 <20120227155643.cafb1c6d.akpm@linux-foundation.org>
 <20120228001928.GB11325@verge.net.au>
 <20120227162631.55cf014e.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120227162631.55cf014e.akpm@linux-foundation.org>
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

On Mon, Feb 27, 2012 at 04:26:31PM -0800, Andrew Morton wrote:
> On Tue, 28 Feb 2012 09:19:28 +0900
> Simon Horman <horms@verge.net.au> wrote:
> 
> > > > --- a/kernel/kexec.c
> > > > +++ b/kernel/kexec.c
> > > > @@ -1462,7 +1462,9 @@ static int __init crash_save_vmcoreinfo_init(void)
> > > >  
> > > >  	VMCOREINFO_SYMBOL(init_uts_ns);
> > > >  	VMCOREINFO_SYMBOL(node_online_map);
> > > > +#ifdef CONFIG_MMU
> > > >  	VMCOREINFO_SYMBOL(swapper_pg_dir);
> > > > +#endif
> > > >  	VMCOREINFO_SYMBOL(_stext);
> > > >  	VMCOREINFO_SYMBOL(vmlist);
> > > 
> > > Well, what might be the effects of this patch?  nommu crashfiles will
> > > no longer have the swapper_pg_dir string?  What are the chances that
> > > someone's (badly written!) downstream tool will crash and burn if this
> > > is absent?
> > 
> > My understanding is that up until this patch creating a dump
> > for nonmmu platform wouldn't work.
> 
> Surprised.  From reading the code I expect it would have emitted 
> 
> 	SYMBOL(swapper_pg_dir)=0

Hi Andrew,

My understanding from discussion with Will earlier in this thread is that if
CONFIG_MMU is not defined then swapper_pg_dir is NULL and the current code
doesn't compile.

	<quote>
	The only case where it's interesting is when you have CONFIG_MMU
	enabled - otherwise it's always NULL. If it's #defined as NULL, the
	current code will fail at build time so simply omitting it from the
	dump seems like the best bet to me (the alternative being to add a
	NULL entry explicitly, but I don't see what the gains us).
	</quote>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
