Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NAbdY-0007tq-Ay
	for kexec@lists.infradead.org; Wed, 18 Nov 2009 03:55:25 +0000
Date: Wed, 18 Nov 2009 14:55:18 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] add support for loading lzma compressed kernels
Message-ID: <20091118035518.GJ18493@verge.net.au>
References: <200911160053.10339.florian@openwrt.org>
	<20091117030429.GC12541@verge.net.au>
	<200911171508.29971.florian@openwrt.org>
	<200911171523.15419.florian@openwrt.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200911171523.15419.florian@openwrt.org>
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
To: Florian Fainelli <florian@openwrt.org>
Cc: kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>

On Tue, Nov 17, 2009 at 03:23:15PM +0100, Florian Fainelli wrote:
> On Tuesday 17 November 2009 15:08:29 Florian Fainelli wrote:
> > Hello Simon,
> > 
> > On Tuesday 17 November 2009 04:04:38 Simon Horman wrote:
> > > On Mon, Nov 16, 2009 at 12:53:06AM +0100, Florian Fainelli wrote:
> > > > Hi Eric,
> > > >
> > > > This patch allows one to load a lzma compressed kernel using kexec -l.
> > > > As I wanted the lzma code to be very similar to the existing
> > > > zlib slurp_decompress I took lzread and associated routines
> > > > from the cpio lzma support. Tested on my x86 laptop using the
> > > > following commands:
> > > >
> > > > lzma e bzImage bzImage.lzma
> > > > kexec -l bzImage.lzma
> > > >
> > > > Having lzma support is particularly useful on some embedded
> > > > systems on which we have the kernel already lzma compressed
> > > > and available on a mtd partition.
> > > >
> > > > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > >
> > > Should lzma_code_ be lzma_code. The former doesn't seem to work with
> > > liblzma 4.999.9beta+20091016-1 from Debian.
> > 
> > You are right it's actually lzma_code (without the trailing _).
> > 
> > > > +		AC_MSG_NOTICE([lzma support disabled])))
> > >
> > > The trailing "fi" line appears to be missing.
> > 
> > Fixed too.
> > [snip]
> > 
> > > Does this imply that zlib compression isn't supported if
> > > lzma compression support is enabled?
> > 
> > Indeed, we might want to support both at runtime. Would you agree with the
> > following proposal:
> > 
> > - rename slurp_decompress_file to zlib/lzma_decompress_file
> > - in case gzopen fails, do not die, but return NULL
> > - test the return value of zlib_decompress_file and try
> >  lzma_decompress_file

      Something along those lines sounds entirely reasonable to me.

> We would also have to modify the call sites of slurp_decompress file this might 
> become pretty heavy if we support more decompression algorithms. What do you 
> think?

Perhaps slurp_decompress could be a wrapper which tries each algorithm in
turn as necessary?

Also, I'd like to get rid of the #ifdef around what is currently
slurp_decompress_file() if possible. My idea would be to move
zlib_decompress_file and lzma_decompress_file into, for instance
zlib.c and lzma.c respectively and have zlib.h and lzma.h provide
more-or-less null functions for the case where the algorithm
in question isn't supported.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
