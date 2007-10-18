Return-path: <kexec-bounces@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IidR7-0002Iw-VZ
	for kexec@lists.infradead.org; Thu, 18 Oct 2007 23:01:53 +0100
Date: Fri, 19 Oct 2007 00:00:48 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 1/3] Add BSS to resource tree
Message-ID: <20071018220048.GB3459@bingen.suse.de>
References: <20071018111535.356215664@strauss.suse.de>
	<20071018111535.883533731@strauss.suse.de>
	<20071018142642.5b3f6ba4.akpm@linux-foundation.org>
	<20071018214836.GA3459@bingen.suse.de>
	<20071018215827.GB23708@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071018215827.GB23708@uranus.ravnborg.org>
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
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com, Andrew Morton <akpm@linux-foundation.org>

On Thu, Oct 18, 2007 at 11:58:27PM +0200, Sam Ravnborg wrote:
> On Thu, Oct 18, 2007 at 11:48:37PM +0200, Andi Kleen wrote:
> > > > +extern char _text[], _end[], _etext[], _edata[], _bss[];
> > > 
> > > These should be in a header file.
> > 
> > Normally the "no externs in .c" rule doesn't apply to assembler or linker 
> > script defined labels. That's because the point of the header file is to 
> > type check them, but there is nothing to type check here.
> 
> For linker generated symbols we have sections.h for this purpose.
> The above symbols are all available if we do an:
> #include <asm/sections.h>
> 
> This is the right fix in this case.

The problem is that they're often the wrong type here. E.g. wrong signedness 
etc. I ran into problems in the past where using this required ugly casts.

-Andi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
