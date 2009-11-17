Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ey-out-1920.google.com ([74.125.78.148])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NAOlI-0004sz-A1
	for kexec@lists.infradead.org; Tue, 17 Nov 2009 14:10:32 +0000
Received: by ey-out-1920.google.com with SMTP id 4so1835633eyg.2
	for <kexec@lists.infradead.org>; Tue, 17 Nov 2009 06:10:26 -0800 (PST)
From: Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH] add support for loading lzma compressed kernels
Date: Tue, 17 Nov 2009 15:08:29 +0100
References: <200911160053.10339.florian@openwrt.org>
	<20091117030429.GC12541@verge.net.au>
In-Reply-To: <20091117030429.GC12541@verge.net.au>
MIME-Version: 1.0
Message-Id: <200911171508.29971.florian@openwrt.org>
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
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>

Hello Simon,

On Tuesday 17 November 2009 04:04:38 Simon Horman wrote:
> On Mon, Nov 16, 2009 at 12:53:06AM +0100, Florian Fainelli wrote:
> > Hi Eric,
> >
> > This patch allows one to load a lzma compressed kernel using kexec -l.
> > As I wanted the lzma code to be very similar to the existing
> > zlib slurp_decompress I took lzread and associated routines
> > from the cpio lzma support. Tested on my x86 laptop using the
> > following commands:
> >
> > lzma e bzImage bzImage.lzma
> > kexec -l bzImage.lzma
> >
> > Having lzma support is particularly useful on some embedded
> > systems on which we have the kernel already lzma compressed
> > and available on a mtd partition.
> >
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> 
> Should lzma_code_ be lzma_code. The former doesn't seem to work with
> liblzma 4.999.9beta+20091016-1 from Debian.

You are right it's actually lzma_code (without the trailing _).

> 
> > +		AC_MSG_NOTICE([lzma support disabled])))
> 
> The trailing "fi" line appears to be missing.

Fixed too.
[snip]

> Does this imply that zlib compression isn't supported if
> lzma compression support is enabled?

Indeed, we might want to support both at runtime. Would you agree with the 
following proposal:

- rename slurp_decompress_file to zlib/lzma_decompress_file
- in case gzopen fails, do not die, but return NULL
- test the return value of zlib_decompress_file and try lzma_decompress_file

> 
> > +{
> > +	LZFILE *fp;
> > +	char *buf;
> > +	off_t size, allocated;
> > +	ssize_t result;
> > +
> > +	if (!filename) {
> > +		*r_size = 0;
> > +		return 0;
> > +	}
> > +	fp = lzopen(filename, "rb");
> > +	if (fp == 0) {
> > +		die("Cannot open `%s': %s\n", filename);
> > +	}
> > +	size = 0;
> > +	allocated = 65536;
> > +	buf = xmalloc(allocated);
> > +	do {
> > +		if (size == allocated) {
> > +			allocated <<= 1;
> > +			buf = xrealloc(buf, allocated);
> > +		}
> > +		result = lzread(fp, buf + size, allocated - size);
> > +		if (result < 0) {
> > +			if ((errno == EINTR) || (errno == EAGAIN))
> > +				continue;
> > +
> > +			die ("read on %s of %ld bytes failed\n",
> > +				filename, (allocated - size) + 0UL);
> > +		}
> > +		size += result;
> > +	} while(result > 0);
> > +	result = lzclose(fp);
> > +	if (result != LZMA_OK) {
> > +		die ("Close of %s failed\n", filename);
> > +	}
> > +	*r_size =  size;
> > +	return buf;
> > +}
> >  #else
> >  char *slurp_decompress_file(const char *filename, off_t *r_size)
> >  {
> > diff -urN kexec-tools-2.0.1/kexec/lzma.c
> > kexec-tools-2.0.1.lzma/kexec/lzma.c ---
> > kexec-tools-2.0.1/kexec/lzma.c	1970-01-01 01:00:00.000000000 +0100 +++
> > kexec-tools-2.0.1.lzma/kexec/lzma.c	2009-11-16 00:44:56.000000000 +0100
> > @@ -0,0 +1,132 @@
> > +#include <sys/types.h>
> > +#include <inttypes.h>
> > +#include <string.h>
> > +#include <stdlib.h>
> > +#include <lzma.h>
> > +#include <kexec_lzma.h>
> > +
> > +#ifdef HAVE_LIBLZMA
> 
> #include <kexec_lzma.h> needs to be inside HAVE_LIBLZMA,
> it seems just as well to move the #ifdef to the top of the file.

Fixed.
--
WBR, Florian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
