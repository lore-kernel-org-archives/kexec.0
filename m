Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NEzAj-0003Ma-60
	for kexec@lists.infradead.org; Mon, 30 Nov 2009 05:51:46 +0000
Date: Mon, 30 Nov 2009 16:51:39 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] add support for loading lzma compressed kernels
Message-ID: <20091130055135.GA17567@verge.net.au>
References: <200911160053.10339.florian@openwrt.org>
	<200911171523.15419.florian@openwrt.org>
	<20091118035518.GJ18493@verge.net.au>
	<200911190017.23744.florian@openwrt.org>
	<m1y6m3754g.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1y6m3754g.fsf@fess.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, Florian Fainelli <florian@openwrt.org>

On Wed, Nov 18, 2009 at 04:03:27PM -0800, Eric W. Biederman wrote:
> Florian Fainelli <florian@openwrt.org> writes:
> 
> > Please find below a version which should address your comments.
> > Thanks for reviewing the patch.

Thanks, Applied.

> > --
> > From: Florian Fainelli <florian@openwrt.org>
> > Subject: [PATCH] add support for loading lzma compressed kernels
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
> 
> Yes.  I don't think it is particularly useful on x86 (as we have
> a decompressor built into the kernel) but on other arches
> it makes a lot of sense.
> 
> A few minor comments inline.
> 
> > diff -urN kexec-tools-2.0.1/kexec/kexec-lzma.h kexec-tools-2.0.1.lzma/kexec/kexec-lzma.h
> > --- kexec-tools-2.0.1/kexec/kexec-lzma.h	1970-01-01 01:00:00.000000000 +0100
> > +++ kexec-tools-2.0.1.lzma/kexec/kexec-lzma.h	2009-11-19 00:06:24.000000000 +0100
> > @@ -0,0 +1,29 @@
> > +#ifndef __KEXEC_LZMA_H
> > +#define __KEXEC_LZMA_H
> > +
> > +#include <stdio.h>
> > +#include <sys/types.h>
> > +#include <unistd.h>
> > +#include <inttypes.h>
> > +#include <lzma.h>
> > +
> > +#include "config.h"
> > +
> > +#ifdef HAVE_LIBLZMA
> > +#define kBufferSize (1 << 15)
> > +
> > +typedef struct lzfile {
> > +	uint8_t buf[kBufferSize];
> > +	lzma_stream strm;
> > +	FILE *file;
> > +	int encoding;
> > +	int eof;
> > +} LZFILE;
> > +
> > +LZFILE *lzopen(const char *path, const char *mode);
> > +int lzclose(LZFILE *lzfile);
> > +ssize_t lzread(LZFILE *lzfile, void *buf, size_t len);
> 
> I don't think we need any of these definitions in the header file.
> 
> > +#endif /* HAVE_LIBLZMA */
> > +
> > +char *lzma_decompress_file(const char *filename, off_t *r_size);
> 
> Ideally the lzma_decompress_file stub would live here and would not
> even compile kexec/lzma.c if we don't have lzma.
> 
> > +#endif /* __KEXEC_LZMA_H */

I have also applied the following change

----------------------------------------------------------------------

lzma: Move the bulk of kexec-lzma.h into lzma.c

There isn't any need for anything in kexec-lzma.h other
than a declaration of zlib_decompress_file().

Other being cleaner it also fixes a build problem when
lzma support isn't being compiled in.

$ make all
i686-unknown-linux-gnu-gcc -Wall -Wextra -O2 -fomit-frame-pointer -pipe -fno-strict-aliasing -Wall -Wstrict-prototypes -I/home/horms/local/opt/crosstool/i686/gcc-3.4.5-glibc-2.3.6/i686-unknown-linux-gnu/include -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/i386/include  -c
-MD -o kexec/kexec.o kexec/kexec.c
In file included from kexec/kexec.c:47:
kexec/kexec-lzma.h:8:18: lzma.h: No such file or directory
kexec/kexec.c: In function `locate_hole':
kexec/kexec.c:203: warning: comparison between signed and unsigned

It ought to be possible to just provide a stub for zlib_decompress_file()
in kexec-lzma.h and not compile lzma.c at all in the case where
lzma support isn't being compiled in. However I see no obvious way
to do this with the existing build system. So I'd like to deal
with that as a separate possible change.

Changes as suggested by Eric W. Biederman.

Cc: Florian Fainelli <florian@openwrt.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

Index: kexec-tools/kexec/kexec-lzma.h
===================================================================
--- kexec-tools.orig/kexec/kexec-lzma.h	2009-11-30 16:43:38.000000000 +1100
+++ kexec-tools/kexec/kexec-lzma.h	2009-11-30 16:44:15.000000000 +1100
@@ -1,29 +1,8 @@
 #ifndef __KEXEC_LZMA_H
 #define __KEXEC_LZMA_H
 
-#include <stdio.h>
 #include <sys/types.h>
-#include <unistd.h>
-#include <inttypes.h>
-#include <lzma.h>
-
-#include "config.h"
-
-#ifdef HAVE_LIBLZMA
-#define kBufferSize (1 << 15)
-
-typedef struct lzfile {
-	uint8_t buf[kBufferSize];
-	lzma_stream strm;
-	FILE *file;
-	int encoding;
-	int eof;
-} LZFILE;
-
-LZFILE *lzopen(const char *path, const char *mode);
-int lzclose(LZFILE *lzfile);
-ssize_t lzread(LZFILE *lzfile, void *buf, size_t len);
-#endif /* HAVE_LIBLZMA */
 
 char *lzma_decompress_file(const char *filename, off_t *r_size);
+
 #endif /* __KEXEC_LZMA_H */
Index: kexec-tools/kexec/lzma.c
===================================================================
--- kexec-tools.orig/kexec/lzma.c	2009-11-30 16:43:38.000000000 +1100
+++ kexec-tools/kexec/lzma.c	2009-11-30 16:44:15.000000000 +1100
@@ -1,4 +1,9 @@
+#include <unistd.h>
+#include <sys/types.h>
+
 #include "kexec-lzma.h"
+#include "config.h"
+
 #ifdef HAVE_LIBLZMA
 #define _GNU_SOURCE
 #include <stdio.h>
@@ -7,14 +12,26 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <limits.h>
-#include <sys/types.h>
 #include <sys/stat.h>
-#include <unistd.h>
 #include <ctype.h>
 #include <lzma.h>
 
 #include "kexec.h"
 
+#define kBufferSize (1 << 15)
+
+typedef struct lzfile {
+	uint8_t buf[kBufferSize];
+	lzma_stream strm;
+	FILE *file;
+	int encoding;
+	int eof;
+} LZFILE;
+
+LZFILE *lzopen(const char *path, const char *mode);
+int lzclose(LZFILE *lzfile);
+ssize_t lzread(LZFILE *lzfile, void *buf, size_t len);
+
 static LZFILE *lzopen_internal(const char *path, const char *mode, int fd)
 {
 	int level = 5;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
