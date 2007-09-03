Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IS85V-0007aj-Jf
	for kexec@lists.infradead.org; Mon, 03 Sep 2007 05:19:20 -0400
Date: Mon, 3 Sep 2007 03:11:45 +0000
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation: kexec jump
Message-ID: <20070903031145.GF21721@ucw.cz>
References: <1188177280.3247.37.camel@caritas-dev.intel.com>
	<20070827184829.GB4104@ucw.cz>
	<1188548842.1365.13.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1188548842.1365.13.camel@caritas-dev.intel.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

Hi!

> > > @@ -94,6 +94,10 @@
> > >  		unsigned long start_address,
> > >  		unsigned int has_pae) ATTRIB_NORET;
> > >  
> > > +#ifdef CONFIG_KEXEC_JUMP
> > > +extern asmlinkage int machine_kexec_real_jump(void *buf);
> > > +#endif
> > 
> > Is it really neccessery to have ifdef here?
> 
> It is not necessary. I will fix it in the next version.

Looking forward to next version :-).

> > > +#define CR3	0x18
> > > +#define CR4	0x1c
> > > +#define FLAG	0x20
> > > +#define RET	0x24
> > 
> > Hmm, is this enough? Should it use struct ptregs for normal registers?
> > What about segment registers -- they could change between kernel
> > version. Should some kind of 'version of kjump protocol' be
> > introduced?
> 
> All "preserve" registers defined in ABI are saved, I think that is
> sufficient. The "swsusp_arch_suspend" saves only these registers too.
> 
> An extensible inter-kernel kjump protocol and corresponding version
> number seems sensible. I will work on this.

Ok, perhaps that can wait after initial merge.

> > What about CX/DX/fpu state? GDT pointer?
> > 
> > Actually I think that you _do_ need to save FPU. You should probably
> > use relevant swsusp parts here.
> 
> Before and after "machine_kexec_jump" is called, the
> save_processor_state() and restore_processor_state() are called, where
> the MTRR/FPU/GDT/IDT/TR/segments/cr are saved and restored. These two
> functions come from swsusp. Thanks swsusp guys. :)

So I'm blind. Sorry for the noise.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
