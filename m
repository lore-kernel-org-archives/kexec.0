Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from jack.tiscali.it ([213.205.33.53])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JQreD-0004dN-37
	for kexec@lists.infradead.org; Sun, 17 Feb 2008 22:06:09 +0000
From: Francesco Chiechi <francesco.chiechi@colibre.it>
Subject: Re: [PATCH] kexec tools mipsel port
Date: Sun, 17 Feb 2008 23:05:57 +0100
References: <47B6CE01.60701@wpkg.org> <47B74826.8090707@wpkg.org>
	<20080217045634.GA4098@verge.net.au>
In-Reply-To: <20080217045634.GA4098@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200802172305.57993.francesco.chiechi@colibre.it>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>, Tomasz Chmielewski <mangoo@wpkg.org>

On Sunday 17 February 2008 05:56:36 Simon Horman wrote:
> On Sat, Feb 16, 2008 at 09:31:34PM +0100, Tomasz Chmielewski wrote:
> > Simon Horman schrieb:
> >> On Sat, Feb 16, 2008 at 12:50:25PM +0100, Tomasz Chmielewski wrote:
> >>>>> We developed a patch to port kexec-tools to mips arch and included
> >>>>> support for command line passing through elf boot notes.  We did it
> >
> > (...)
> >
> >>> There was a thread about kexec-tools mipsel port on Kexec Mailing
> >>> List  in June 2007.
> >>>
> >>> What's the current state of this patch?
> >>>
> >>> Is it working, will be merged, will not be merged?
> >>
> >> Its still very much in the state of needing someone to
> >> nurse it into a merge.
> >
> > Funny thing is, kernel supports kexec, but there is no userland support
> > for it (well, unless you patch kexec-tools with the patches you found
> > somewhere on the internet).
> >
> > I'll try to see if the old patches posted to this list work for me.
>
> I'm quite happy to accept patches to add mipsel to kexec-tools
> (for the kexec-tools-testing tree that I maintain) and include
> it in the next release.
>
> The problem is that I'm not sure what state the patches are in.

Hi,

I'm really sorry because I did not have time to work again on the patch, which 
I confirm is working for the application we developed it for.

There were surely a couple of problems that made it difficult to be for 
general use:

the first (probably simple to solve) is about physical/virtual mapping, Simon 
suggestion was about removing #ifdef __MIPSEL__ stuff in kexec.c

the second, a bit harder (for me at least), is that I had to insert cache 
flushing code in kexec tools assembly part because leaving the job to the 
kernel did not work

I don't know if I will have time for it in the near future because it implies 
quite a bit of studying for me... anyway I'll keep an eye on it but I cannot 
promise

bye

Francesco


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
