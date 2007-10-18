Return-path: <kexec-bounces@lists.infradead.org>
Received: from pasmtpb.tele.dk ([80.160.77.98])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Iidfy-0002tj-V8
	for kexec@lists.infradead.org; Thu, 18 Oct 2007 23:17:14 +0100
Date: Fri, 19 Oct 2007 00:18:13 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [patch 1/3] Add BSS to resource tree
Message-ID: <20071018221813.GA23801@uranus.ravnborg.org>
References: <20071018111535.356215664@strauss.suse.de>
	<20071018111535.883533731@strauss.suse.de>
	<20071018142642.5b3f6ba4.akpm@linux-foundation.org>
	<20071018214836.GA3459@bingen.suse.de>
	<20071018215827.GB23708@uranus.ravnborg.org>
	<20071018220048.GB3459@bingen.suse.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071018220048.GB3459@bingen.suse.de>
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
Errors-To: kexec-bounces@lists.infradead.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, vgoyal@in.ibm.com, kexec@lists.infradead.org, Bernhard Walle <bwalle@suse.de>, linux-kernel@vger.kernel.org

On Fri, Oct 19, 2007 at 12:00:48AM +0200, Andi Kleen wrote:
> On Thu, Oct 18, 2007 at 11:58:27PM +0200, Sam Ravnborg wrote:
> > On Thu, Oct 18, 2007 at 11:48:37PM +0200, Andi Kleen wrote:
> > > > > +extern char _text[], _end[], _etext[], _edata[], _bss[];
> > > > 
> > > > These should be in a header file.
> > > 
> > > Normally the "no externs in .c" rule doesn't apply to assembler or linker 
> > > script defined labels. That's because the point of the header file is to 
> > > type check them, but there is nothing to type check here.
> > 
> > For linker generated symbols we have sections.h for this purpose.
> > The above symbols are all available if we do an:
> > #include <asm/sections.h>
> > 
> > This is the right fix in this case.
> 
> The problem is that they're often the wrong type here. E.g. wrong signedness 
> etc. I ran into problems in the past where using this required ugly casts.

But then we should fix them instead of working around the problem - no?

Grepping for _text shows that there are plenty of different ways to declare
that symbol extern - this does not look correct.

And I recall that extern char sym[] is considered correct by binutils 
people - but I'm not 100% sure and google did not give me an appropriate hit.

	Sam

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
