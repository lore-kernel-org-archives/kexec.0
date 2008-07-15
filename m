Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.suse.de ([195.135.220.2])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KIjbn-00036T-HI
	for kexec@lists.infradead.org; Tue, 15 Jul 2008 12:26:23 +0000
Date: Tue, 15 Jul 2008 14:26:59 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Allow BUILD_CFLAGS and TARGET_CFLAGS to be specified at
	configure time
Message-ID: <20080715142659.2b3f7d2e@halley.suse.de>
In-Reply-To: <20080715122410.GA24840@verge.net.au>
References: <20080715102808.GA29267@verge.net.au>
	<1216123702.433919.719662663715.1.gpush@pingu>
	<20080715122410.GA24840@verge.net.au>
Mime-Version: 1.0
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Jeremy Kerr <jk@ozlabs.org>

* Simon Horman [2008-07-15 22:24]:
>
> On Tue, Jul 15, 2008 at 10:08:22PM +1000, Jeremy Kerr wrote:
> > Currently, we're unconditionally setting the build and target cflags in
> > the configure script, which means that they can't be easily
> > overwritten.
> > 
> > This change conditionally sets these variables if they're not specified
> > during configure, allowing something like:
> > 
> > BUILD_CFLAGS=-Werror ./configure
> > 
> > Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> > 
> > ---
> >  configure.ac |    9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/configure.ac b/configure.ac
> > index 5f1c15a..fa5330a 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -56,8 +56,13 @@ if test "${host_alias}" ; then
> >  	OBJDIR="$OBJDIR-${host_alias}"
> >  fi
> >  
> > -BUILD_CFLAGS='-O2 -Wall'
> > -TARGET_CFLAGS='-O2 -Wall'
> > +if test "x$BUILD_CFLAGS" = "x" ; then
> > +	BUILD_CFLAGS='-O2 -Wall'
> > +fi
> > +
> > +if test "x$TARGET_CFLAGS" = "x" ; then
> > +	TARGET_CFLAGS='-O2 -Wall'
> > +fi
> >  
> >  AC_ARG_WITH([objdir], AC_HELP_STRING([--with-objdir=<dir>],[select directory for object files]),
> >  	[ OBJDIR="$withval" ], [ OBJDIR="$OBJDIR" ])
> 
> Can we get rid of TARGET_CFLAGS? It doesn't seem to be used anywhere.
> 
> Also I think you need the following util/Makefile snippet as Bernhards
> patch is already in the tree (I was working on a similar patch myself :-)
> 
> diff --git a/util/Makefile b/util/Makefile
> index a1a78ac..0ea59d4 100644
> --- a/util/Makefile
> +++ b/util/Makefile
> @@ -5,8 +5,8 @@ $(BIN_TO_HEX): $(srcdir)/util/bin-to-hex.c
>  	$(LINK.o) $(CFLAGS) -o $@ $^
>  
>  $(BIN_TO_HEX): CC=$(BUILD_CC)
> -$(BIN_TO_HEX): CFLAGS+=$(BUILD_CFLAGS)
> -$(BIN_TO_HEX): LDFLAGS=
> +$(BIN_TO_HEX): CFLAGS=$(BUILD_CFLAGS)
> +$(BIN_TO_HEX): LDFLAGS=$(BUILD_LDFLAGS)

Yes. I was just working on a patch that does that. :)



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
