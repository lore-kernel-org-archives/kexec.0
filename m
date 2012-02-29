Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1S2YPl-0005Tc-Qz
 for kexec@lists.infradead.org; Wed, 29 Feb 2012 01:33:10 +0000
Date: Wed, 29 Feb 2012 10:32:57 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: crash: don't save swapper_pg_dir for !CONFIG_MMU
 configurations
Message-ID: <20120229013257.GG6013@verge.net.au>
References: <20120227193054.GB24605@mudshark.cambridge.arm.com>
 <20120227235235.GE24159@verge.net.au>
 <20120227155643.cafb1c6d.akpm@linux-foundation.org>
 <20120228001928.GB11325@verge.net.au>
 <20120227162631.55cf014e.akpm@linux-foundation.org>
 <20120228005130.GE11325@verge.net.au>
 <20120227172555.46bffedf.akpm@linux-foundation.org>
 <20120228013526.GA7913@verge.net.au>
 <20120228094057.GC25625@mudshark.cambridge.arm.com>
 <20120228124554.73b4f051.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120228124554.73b4f051.akpm@linux-foundation.org>
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

On Tue, Feb 28, 2012 at 12:45:54PM -0800, Andrew Morton wrote:
> On Tue, 28 Feb 2012 09:40:57 +0000
> Will Deacon <will.deacon@arm.com> wrote:
> 
> > > > Still, you didn't answer my question!  What effect will the absence of
> > > > SYMBOL(swapper_pg_dir)= have upon downstream tools?  If "none" then
> > > > sure, let's remove it.  If "explosion" then we should emit a dummy
> > > > SYMBOL(swapper_pg_dir)=0 if CONFIG_NOMMU.
> > > 
> > > My thought was that the tools wouldn't be used in the CONFIG_NOMMU case (yet).
> > > But I take your point and I think the answer is that the fallout is unknown.
> > > Emitting a dummy value as you suggest seems reasonable.
> > 
> > The reason I didn't choose a dummy value to start with is because there are
> > plenty of other fields in the dump that are predicated on build-time CONFIG
> > options. Admittedly, some of these appear to be tagged with length
> > information, but consider these guys:
> > 
> > #ifndef CONFIG_NEED_MULTIPLE_NODES
> >         VMCOREINFO_SYMBOL(mem_map);
> >         VMCOREINFO_SYMBOL(contig_page_data);
> > #endif
> > 
> > Since the VMCOREINFO_SYMBOL macro stringifies the identifier, I guess userspace
> > has to treat the whole thing as a map, meaning that we *can* safely remove
> > elements from it.
> > 
> > So that's my speculation. Maybe somebody on the kexec list can confirm?
> 
> Yeah, I do think the chance of breaking anything here is small, and in
> the unlikely event that something *does* break then a) it deserved to
> break ;) and b) the user of that app will be a developer who can
> unbreak it.
> 
> Let's run with the patch as-is.

Fine by me :)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
