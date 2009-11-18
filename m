Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ey-out-1920.google.com ([74.125.78.149])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NAtmE-0004bL-S6
	for kexec@lists.infradead.org; Wed, 18 Nov 2009 23:17:35 +0000
Received: by ey-out-1920.google.com with SMTP id 4so254735eyg.26
	for <kexec@lists.infradead.org>; Wed, 18 Nov 2009 15:17:28 -0800 (PST)
From: Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH] add support for loading lzma compressed kernels
Date: Thu, 19 Nov 2009 00:17:22 +0100
References: <200911160053.10339.florian@openwrt.org>
	<200911171523.15419.florian@openwrt.org>
	<20091118035518.GJ18493@verge.net.au>
In-Reply-To: <20091118035518.GJ18493@verge.net.au>
MIME-Version: 1.0
Message-Id: <200911190017.23744.florian@openwrt.org>
Reply-To: Florian Fainelli <florian@openwrt.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>

Hello Simon,

Le mercredi 18 novembre 2009 04:55:18, Simon Horman a =E9crit :
> On Tue, Nov 17, 2009 at 03:23:15PM +0100, Florian Fainelli wrote:
> > On Tuesday 17 November 2009 15:08:29 Florian Fainelli wrote:
> > > Hello Simon,
> > >
> > > On Tuesday 17 November 2009 04:04:38 Simon Horman wrote:
> > > > On Mon, Nov 16, 2009 at 12:53:06AM +0100, Florian Fainelli wrote:
> > > > > Hi Eric,
> > > > >
> > > > > This patch allows one to load a lzma compressed kernel using kexec
> > > > > -l. As I wanted the lzma code to be very similar to the existing
> > > > > zlib slurp_decompress I took lzread and associated routines from
> > > > > the cpio lzma support. Tested on my x86 laptop using the following
> > > > > commands:
> > > > >
> > > > > lzma e bzImage bzImage.lzma
> > > > > kexec -l bzImage.lzma
> > > > >
> > > > > Having lzma support is particularly useful on some embedded
> > > > > systems on which we have the kernel already lzma compressed
> > > > > and available on a mtd partition.
> > > > >
> > > > > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > > >
> > > > Should lzma_code_ be lzma_code. The former doesn't seem to work with
> > > > liblzma 4.999.9beta+20091016-1 from Debian.
> > >
> > > You are right it's actually lzma_code (without the trailing _).
> > >
> > > > > +		AC_MSG_NOTICE([lzma support disabled])))
> > > >
> > > > The trailing "fi" line appears to be missing.
> > >
> > > Fixed too.
> > > [snip]
> > >
> > > > Does this imply that zlib compression isn't supported if
> > > > lzma compression support is enabled?
> > >
> > > Indeed, we might want to support both at runtime. Would you agree with
> > > the following proposal:
> > >
> > > - rename slurp_decompress_file to zlib/lzma_decompress_file
> > > - in case gzopen fails, do not die, but return NULL
> > > - test the return value of zlib_decompress_file and try
> > >  lzma_decompress_file
> =

>       Something along those lines sounds entirely reasonable to me.
> =

> > We would also have to modify the call sites of slurp_decompress file th=
is
> > might become pretty heavy if we support more decompression algorithms.
> > What do you think?
> =

> Perhaps slurp_decompress could be a wrapper which tries each algorithm in
> turn as necessary?
> =

> Also, I'd like to get rid of the #ifdef around what is currently
> slurp_decompress_file() if possible. My idea would be to move
> zlib_decompress_file and lzma_decompress_file into, for instance
> zlib.c and lzma.c respectively and have zlib.h and lzma.h provide
> more-or-less null functions for the case where the algorithm
> in question isn't supported.

Please find below a version which should address your comments.
Thanks for reviewing the patch.
--
From: Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] add support for loading lzma compressed kernels

This patch allows one to load a lzma compressed kernel using kexec -l.
As I wanted the lzma code to be very similar to the existing
zlib slurp_decompress I took lzread and associated routines
from the cpio lzma support. Tested on my x86 laptop using the
following commands:

lzma e bzImage bzImage.lzma
kexec -l bzImage.lzma

Having lzma support is particularly useful on some embedded
systems on which we have the kernel already lzma compressed
and available on a mtd partition.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff -urN kexec-tools-2.0.1/configure.ac kexec-tools-2.0.1.lzma/configure.ac
--- kexec-tools-2.0.1/configure.ac	2009-11-18 23:11:36.000000000 +0100
+++ kexec-tools-2.0.1.lzma/configure.ac	2009-11-18 23:11:21.000000000 +0100
@@ -79,6 +79,9 @@
 AC_ARG_WITH([zlib], AC_HELP_STRING([--without-zlib],[disable zlib support]=
),
 	[ with_zlib=3D"$withval"], [ with_zlib=3Dyes ] )
 =

+AC_ARG_WITH([lzma], AC_HELP_STRING([--without-lzma],[disable lzma support]=
),
+	[ with_lzma=3D"$withval"], [ with_lzma=3Dyes ] )
+
 AC_ARG_WITH([xen], AC_HELP_STRING([--without-xen],
 	[disable extended xen support]), [ with_xen=3D"$withval"], [ with_xen=3Dy=
es ] )
 =

@@ -142,6 +145,13 @@
 		AC_MSG_NOTICE([zlib support disabled])))
 fi
 =

+dnl See if I have a usable copy of lzma available
+if test "$with_lzma" =3D yes ; then
+	AC_CHECK_HEADER(lzma.h,
+		AC_CHECK_LIB(lzma, lzma_code, ,
+		AC_MSG_NOTICE([lzma support disabled])))
+fi
+
 dnl find Xen control stack libraries
 if test "$with_xen" =3D yes ; then
 	AC_CHECK_HEADER(xenctrl.h,
diff -urN kexec-tools-2.0.1/kexec/Makefile kexec-tools-2.0.1.lzma/kexec/Mak=
efile
--- kexec-tools-2.0.1/kexec/Makefile	2009-11-18 23:11:37.000000000 +0100
+++ kexec-tools-2.0.1.lzma/kexec/Makefile	2009-11-18 23:15:21.000000000 +01=
00
@@ -22,6 +22,8 @@
 KEXEC_SRCS +=3D kexec/crashdump.c
 KEXEC_SRCS +=3D kexec/crashdump-xen.c
 KEXEC_SRCS +=3D kexec/phys_arch.c
+KEXEC_SRCS +=3D kexec/lzma.c
+KEXEC_SRCS +=3D kexec/zlib.c
 =

 KEXEC_GENERATED_SRCS +=3D $(PURGATORY_HEX_C)
 =

diff -urN kexec-tools-2.0.1/kexec/kexec-lzma.h kexec-tools-2.0.1.lzma/kexec=
/kexec-lzma.h
--- kexec-tools-2.0.1/kexec/kexec-lzma.h	1970-01-01 01:00:00.000000000 +0100
+++ kexec-tools-2.0.1.lzma/kexec/kexec-lzma.h	2009-11-19 00:06:24.000000000=
 +0100
@@ -0,0 +1,29 @@
+#ifndef __KEXEC_LZMA_H
+#define __KEXEC_LZMA_H
+
+#include <stdio.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <inttypes.h>
+#include <lzma.h>
+
+#include "config.h"
+
+#ifdef HAVE_LIBLZMA
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
+#endif /* HAVE_LIBLZMA */
+
+char *lzma_decompress_file(const char *filename, off_t *r_size);
+#endif /* __KEXEC_LZMA_H */
diff -urN kexec-tools-2.0.1/kexec/kexec-zlib.h kexec-tools-2.0.1.lzma/kexec=
/kexec-zlib.h
--- kexec-tools-2.0.1/kexec/kexec-zlib.h	1970-01-01 01:00:00.000000000 +0100
+++ kexec-tools-2.0.1.lzma/kexec/kexec-zlib.h	2009-11-19 00:04:38.000000000=
 +0100
@@ -0,0 +1,10 @@
+#ifndef __KEXEC_ZLIB_H
+#define __KEXEC_ZLIB_H
+
+#include <stdio.h>
+#include <sys/types.h>
+
+#include "config.h"
+
+char *zlib_decompress_file(const char *filename, off_t *r_size);
+#endif /* __KEXEC_ZLIB_H */
diff -urN kexec-tools-2.0.1/kexec/kexec.c kexec-tools-2.0.1.lzma/kexec/kexe=
c.c
--- kexec-tools-2.0.1/kexec/kexec.c	2009-11-18 23:11:45.000000000 +0100
+++ kexec-tools-2.0.1.lzma/kexec/kexec.c	2009-11-18 23:19:46.000000000 +0100
@@ -38,14 +38,13 @@
 =

 #include "config.h"
 =

-#ifdef HAVE_LIBZ
-#include <zlib.h>
-#endif
 #include <sha256.h>
 #include "kexec.h"
 #include "kexec-syscall.h"
 #include "kexec-elf.h"
 #include "kexec-sha256.h"
+#include "kexec-zlib.h"
+#include "kexec-lzma.h"
 #include <arch/options.h>
 =

 unsigned long long mem_min =3D 0;
@@ -554,67 +553,18 @@
 	return buf;
 }
 =

-#if HAVE_LIBZ
 char *slurp_decompress_file(const char *filename, off_t *r_size)
 {
-	gzFile fp;
-	int errnum;
-	const char *msg;
-	char *buf;
-	off_t size, allocated;
-	ssize_t result;
-
-	if (!filename) {
-		*r_size =3D 0;
-		return 0;
-	}
-	fp =3D gzopen(filename, "rb");
-	if (fp =3D=3D 0) {
-		msg =3D gzerror(fp, &errnum);
-		if (errnum =3D=3D Z_ERRNO) {
-			msg =3D strerror(errno);
-		}
-		die("Cannot open `%s': %s\n", filename, msg);
-	}
-	size =3D 0;
-	allocated =3D 65536;
-	buf =3D xmalloc(allocated);
-	do {
-		if (size =3D=3D allocated) {
-			allocated <<=3D 1;
-			buf =3D xrealloc(buf, allocated);
-		}
-		result =3D gzread(fp, buf + size, allocated - size);
-		if (result < 0) {
-			if ((errno =3D=3D EINTR) || (errno =3D=3D EAGAIN))
-				continue;
+	char *kernel_buf;
 =

-			msg =3D gzerror(fp, &errnum);
-			if (errnum =3D=3D Z_ERRNO) {
-				msg =3D strerror(errno);
-			}
-			die ("read on %s of %ld bytes failed: %s\n",
-				filename, (allocated - size) + 0UL, msg);
-		}
-		size +=3D result;
-	} while(result > 0);
-	result =3D gzclose(fp);
-	if (result !=3D Z_OK) {
-		msg =3D gzerror(fp, &errnum);
-		if (errnum =3D=3D Z_ERRNO) {
-			msg =3D strerror(errno);
-		}
-		die ("Close of %s failed: %s\n", filename, msg);
+	kernel_buf =3D zlib_decompress_file(filename, r_size);
+	if (!kernel_buf) {
+		kernel_buf =3D lzma_decompress_file(filename, r_size);
+		if (!kernel_buf)
+			return slurp_file(filename, r_size);
 	}
-	*r_size =3D  size;
-	return buf;
+	return kernel_buf;
 }
-#else
-char *slurp_decompress_file(const char *filename, off_t *r_size)
-{
-	return slurp_file(filename, r_size);
-}
-#endif
 =

 static void update_purgatory(struct kexec_info *info)
 {
diff -urN kexec-tools-2.0.1/kexec/lzma.c kexec-tools-2.0.1.lzma/kexec/lzma.c
--- kexec-tools-2.0.1/kexec/lzma.c	1970-01-01 01:00:00.000000000 +0100
+++ kexec-tools-2.0.1.lzma/kexec/lzma.c	2009-11-19 00:03:54.000000000 +0100
@@ -0,0 +1,187 @@
+#include "kexec-lzma.h"
+#ifdef HAVE_LIBLZMA
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdarg.h>
+#include <string.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <limits.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <ctype.h>
+#include <lzma.h>
+
+#include "kexec.h"
+
+static LZFILE *lzopen_internal(const char *path, const char *mode, int fd)
+{
+	int level =3D 5;
+	int encoding =3D 0;
+	FILE *fp;
+	LZFILE *lzfile;
+	lzma_ret ret;
+	lzma_stream lzma_strm_tmp =3D LZMA_STREAM_INIT;
+
+	for (; *mode; mode++) {
+		if (*mode =3D=3D 'w')
+			encoding =3D 1;
+		else if (*mode =3D=3D 'r')
+			encoding =3D 0;
+		else if (*mode >=3D '1' && *mode <=3D '9')
+			level =3D *mode - '0';
+	}
+	if (fd !=3D -1)
+		fp =3D fdopen(fd, encoding ? "w" : "r");
+	else
+		fp =3D fopen(path, encoding ? "w" : "r");
+	if (!fp)
+		return NULL;
+
+	lzfile =3D calloc(1, sizeof(*lzfile));
+
+	if (!lzfile) {
+		fclose(fp);
+		return NULL;
+	}
+
+	lzfile->file =3D fp;
+	lzfile->encoding =3D encoding;
+	lzfile->eof =3D 0;
+	lzfile->strm =3D lzma_strm_tmp;
+	if (encoding) {
+		lzma_options_lzma opt_lzma;
+		if (lzma_lzma_preset(&opt_lzma, level - 1))
+			return NULL;
+		ret =3D lzma_alone_encoder(&lzfile->strm, &opt_lzma);
+	} else {
+		ret =3D lzma_auto_decoder(&lzfile->strm,
+					UINT64_C(64) * 1024 * 1024, 0);
+	}
+	if (ret !=3D LZMA_OK) {
+		fclose(fp);
+		free(lzfile);
+		return NULL;
+	}
+	return lzfile;
+}
+
+LZFILE *lzopen(const char *path, const char *mode)
+{
+	return lzopen_internal(path, mode, -1);
+}
+
+int lzclose(LZFILE *lzfile)
+{
+	lzma_ret ret;
+	int n;
+
+	if (!lzfile)
+		return -1;
+
+	if (lzfile->encoding) {
+		for (;;) {
+			lzfile->strm.avail_out =3D kBufferSize;
+			lzfile->strm.next_out =3D lzfile->buf;
+			ret =3D lzma_code(&lzfile->strm, LZMA_FINISH);
+			if (ret !=3D LZMA_OK && ret !=3D LZMA_STREAM_END)
+				return -1;
+			n =3D kBufferSize - lzfile->strm.avail_out;
+			if (n && fwrite(lzfile->buf, 1, n, lzfile->file) !=3D n)
+				return -1;
+			if (ret =3D=3D LZMA_STREAM_END)
+				break;
+		}
+	}
+	lzma_end(&lzfile->strm);
+
+	return fclose(lzfile->file);
+	free(lzfile);
+}
+
+ssize_t lzread(LZFILE *lzfile, void *buf, size_t len)
+{
+	lzma_ret ret;
+	int eof =3D 0;
+
+	if (!lzfile || lzfile->encoding)
+		return -1;
+
+	if (lzfile->eof)
+		return 0;
+
+	lzfile->strm.next_out =3D buf;
+	lzfile->strm.avail_out =3D len;
+
+	for (;;) {
+		if (!lzfile->strm.avail_in) {
+			lzfile->strm.next_in =3D lzfile->buf;
+			lzfile->strm.avail_in =3D fread(lzfile->buf, 1, kBufferSize, lzfile->fi=
le);
+			if (!lzfile->strm.avail_in)
+				eof =3D 1;
+		}
+
+		ret =3D lzma_code(&lzfile->strm, LZMA_RUN);
+		if (ret =3D=3D LZMA_STREAM_END) {
+			lzfile->eof =3D 1;
+			return len - lzfile->strm.avail_out;
+		}
+
+		if (ret !=3D LZMA_OK)
+			return -1;
+
+		if (!lzfile->strm.avail_out)
+			return len;
+
+		if (eof)
+			return -1;
+	}
+}
+
+char *lzma_decompress_file(const char *filename, off_t *r_size)
+{
+	LZFILE *fp;
+	char *buf;
+	off_t size, allocated;
+	ssize_t result;
+
+	if (!filename) {
+		*r_size =3D 0;
+		return 0;
+	}
+	fp =3D lzopen(filename, "rb");
+	if (fp =3D=3D 0) {
+		die("Cannot open `%s': %s\n", filename);
+	}
+	size =3D 0;
+	allocated =3D 65536;
+	buf =3D xmalloc(allocated);
+	do {
+		if (size =3D=3D allocated) {
+			allocated <<=3D 1;
+			buf =3D xrealloc(buf, allocated);
+		}
+		result =3D lzread(fp, buf + size, allocated - size);
+		if (result < 0) {
+			if ((errno =3D=3D EINTR) || (errno =3D=3D EAGAIN))
+				continue;
+
+			die ("read on %s of %ld bytes failed\n",
+				filename, (allocated - size) + 0UL);
+		}
+		size +=3D result;
+	} while(result > 0);
+	result =3D lzclose(fp);
+	if (result !=3D LZMA_OK) {
+		die ("Close of %s failed\n", filename);
+	}
+	*r_size =3D  size;
+	return buf;
+}
+#else
+char *lzma_decompress_file(const char *filename, off_t *r_size)
+{
+	return NULL;
+}
+#endif /* HAVE_LIBLZMA */
diff -urN kexec-tools-2.0.1/kexec/zlib.c kexec-tools-2.0.1.lzma/kexec/zlib.c
--- kexec-tools-2.0.1/kexec/zlib.c	1970-01-01 01:00:00.000000000 +0100
+++ kexec-tools-2.0.1.lzma/kexec/zlib.c	2009-11-19 00:05:28.000000000 +0100
@@ -0,0 +1,78 @@
+#include "kexec-zlib.h"
+#ifdef HAVE_LIBZ
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdarg.h>
+#include <string.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <limits.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <ctype.h>
+#include <zlib.h>
+
+#include "kexec.h"
+
+char *zlib_decompress_file(const char *filename, off_t *r_size)
+{
+	gzFile fp;
+	int errnum;
+	const char *msg;
+	char *buf;
+	off_t size, allocated;
+	ssize_t result;
+
+	if (!filename) {
+		*r_size =3D 0;
+		return 0;
+	}
+	fp =3D gzopen(filename, "rb");
+	if (fp =3D=3D 0) {
+		msg =3D gzerror(fp, &errnum);
+		if (errnum =3D=3D Z_ERRNO) {
+			msg =3D strerror(errno);
+		}
+		fprintf(stderr, "Cannot open `%s': %s\n", filename, msg);
+		return NULL;
+	}
+	size =3D 0;
+	allocated =3D 65536;
+	buf =3D xmalloc(allocated);
+	do {
+		if (size =3D=3D allocated) {
+			allocated <<=3D 1;
+			buf =3D xrealloc(buf, allocated);
+		}
+		result =3D gzread(fp, buf + size, allocated - size);
+		if (result < 0) {
+			if ((errno =3D=3D EINTR) || (errno =3D=3D EAGAIN))
+				continue;
+
+			msg =3D gzerror(fp, &errnum);
+			if (errnum =3D=3D Z_ERRNO) {
+				msg =3D strerror(errno);
+			}
+			die ("read on %s of %ld bytes failed: %s\n",
+				filename, (allocated - size) + 0UL, msg);
+		}
+		size +=3D result;
+	} while(result > 0);
+	result =3D gzclose(fp);
+	if (result !=3D Z_OK) {
+		msg =3D gzerror(fp, &errnum);
+		if (errnum =3D=3D Z_ERRNO) {
+			msg =3D strerror(errno);
+		}
+		die ("Close of %s failed: %s\n", filename, msg);
+	}
+	*r_size =3D  size;
+	return buf;
+}
+#else
+char *zlib_decompress_file(const char *filename, off_t *r_size)
+{
+	return NULL;
+}
+#endif /* HAVE_ZLIB */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
