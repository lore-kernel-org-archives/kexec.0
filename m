Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NAEMy-000526-PS
	for kexec@lists.infradead.org; Tue, 17 Nov 2009 03:04:45 +0000
Date: Tue, 17 Nov 2009 14:04:38 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] add support for loading lzma compressed kernels
Message-ID: <20091117030429.GC12541@verge.net.au>
References: <200911160053.10339.florian@openwrt.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200911160053.10339.florian@openwrt.org>
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

On Mon, Nov 16, 2009 at 12:53:06AM +0100, Florian Fainelli wrote:
> Hi Eric,
> 
> This patch allows one to load a lzma compressed kernel using kexec -l.
> As I wanted the lzma code to be very similar to the existing
> zlib slurp_decompress I took lzread and associated routines
> from the cpio lzma support. Tested on my x86 laptop using the
> following commands:
> 
> lzma e bzImage bzImage.lzma
> kexec -l bzImage.lzma
> 
> Having lzma support is particularly useful on some embedded
> systems on which we have the kernel already lzma compressed
> and available on a mtd partition.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> -- 
> diff -urN kexec-tools-2.0.1/configure.ac kexec-tools-2.0.1.lzma/configure.ac
> --- kexec-tools-2.0.1/configure.ac	2009-08-13 01:28:04.000000000 +0200
> +++ kexec-tools-2.0.1.lzma/configure.ac	2009-11-16 00:30:42.000000000 +0100
> @@ -79,6 +79,9 @@
>  AC_ARG_WITH([zlib], AC_HELP_STRING([--without-zlib],[disable zlib support]),
>  	[ with_zlib="$withval"], [ with_zlib=yes ] )
> 
> +AC_ARG_WITH([lzma], AC_HELP_STRING([--without-lzma],[disable lzma support]),
> +	[ with_lzma="$withval"], [ with_lzma=yes ] )
> +
>  AC_ARG_WITH([xen], AC_HELP_STRING([--without-xen],
>  	[disable extended xen support]), [ with_xen="$withval"], [ with_xen=yes ] )
> 
> @@ -142,6 +145,12 @@
>  		AC_MSG_NOTICE([zlib support disabled])))
>  fi
> 
> +dnl See if I have a usable copy of lzma available
> +if test "$with_lzma" = yes ; then
> +	AC_CHECK_HEADER(lzma.h,
> +		AC_CHECK_LIB(lzma, lzma_code_, ,

Should lzma_code_ be lzma_code. The former doesn't seem to work with
liblzma 4.999.9beta+20091016-1 from Debian.

> +		AC_MSG_NOTICE([lzma support disabled])))

The trailing "fi" line appears to be missing.

> +
>  dnl find Xen control stack libraries
>  if test "$with_xen" = yes ; then
>  	AC_CHECK_HEADER(xenctrl.h,
> diff -urN kexec-tools-2.0.1/include/kexec_lzma.h kexec-tools-2.0.1.lzma/include/kexec_lzma.h
> --- kexec-tools-2.0.1/include/kexec_lzma.h	1970-01-01 01:00:00.000000000 +0100
> +++ kexec-tools-2.0.1.lzma/include/kexec_lzma.h	2009-11-16 00:45:23.000000000 +0100
> @@ -0,0 +1,24 @@
> +#ifndef __KEXEC_LZMA_H
> +#define __KEXEC_LZMA_H
> +
> +#include <sys/types.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <inttypes.h>
> +#include <lzma.h>
> +
> +#define kBufferSize (1 << 15)
> +
> +typedef struct lzfile {
> +	uint8_t buf[kBufferSize];
> +	lzma_stream strm;
> +	FILE *file;
> +	int encoding;
> +	int eof;
> +} LZFILE;
> +
> +LZFILE *lzopen(const char *path, const char *mode);
> +int lzclose(LZFILE *lzfile);
> +ssize_t lzread(LZFILE *lzfile, void *buf, size_t len);
> +
> +#endif /* __KEXEC_LZMA_H */
> Files kexec-tools-2.0.1/kexec/.kexec.c.swo and kexec-tools-2.0.1.lzma/kexec/.kexec.c.swo differ
> diff -urN kexec-tools-2.0.1/kexec/Makefile kexec-tools-2.0.1.lzma/kexec/Makefile
> --- kexec-tools-2.0.1/kexec/Makefile	2008-10-09 00:32:14.000000000 +0200
> +++ kexec-tools-2.0.1.lzma/kexec/Makefile	2009-11-15 20:36:37.000000000 +0100
> @@ -22,6 +22,7 @@
>  KEXEC_SRCS += kexec/crashdump.c
>  KEXEC_SRCS += kexec/crashdump-xen.c
>  KEXEC_SRCS += kexec/phys_arch.c
> +KEXEC_SRCS += kexec/lzma.c
> 
>  KEXEC_GENERATED_SRCS += $(PURGATORY_HEX_C)
> 
> diff -urN kexec-tools-2.0.1/kexec/kexec.c kexec-tools-2.0.1.lzma/kexec/kexec.c
> --- kexec-tools-2.0.1/kexec/kexec.c	2009-03-18 09:38:55.000000000 +0100
> +++ kexec-tools-2.0.1.lzma/kexec/kexec.c	2009-11-16 00:50:37.000000000 +0100
> @@ -41,6 +41,9 @@
>  #ifdef HAVE_LIBZ
>  #include <zlib.h>
>  #endif
> +#ifdef HAVE_LIBLZMA
> +#include <kexec_lzma.h>
> +#endif
>  #include <sha256.h>
>  #include "kexec.h"
>  #include "kexec-syscall.h"
> @@ -609,6 +612,47 @@
>  	*r_size =  size;
>  	return buf;
>  }
> +#elif defined (HAVE_LIBLZMA)
> +char *slurp_decompress_file(const char *filename, off_t *r_size)

Does this imply that zlib compression isn't supported if
lzma compression support is enabled?

> +{
> +	LZFILE *fp;
> +	char *buf;
> +	off_t size, allocated;
> +	ssize_t result;
> +
> +	if (!filename) {
> +		*r_size = 0;
> +		return 0;
> +	}
> +	fp = lzopen(filename, "rb");
> +	if (fp == 0) {
> +		die("Cannot open `%s': %s\n", filename);
> +	}
> +	size = 0;
> +	allocated = 65536;
> +	buf = xmalloc(allocated);
> +	do {
> +		if (size == allocated) {
> +			allocated <<= 1;
> +			buf = xrealloc(buf, allocated);
> +		}
> +		result = lzread(fp, buf + size, allocated - size);
> +		if (result < 0) {
> +			if ((errno == EINTR) || (errno == EAGAIN))
> +				continue;
> +
> +			die ("read on %s of %ld bytes failed\n",
> +				filename, (allocated - size) + 0UL);
> +		}
> +		size += result;
> +	} while(result > 0);
> +	result = lzclose(fp);
> +	if (result != LZMA_OK) {
> +		die ("Close of %s failed\n", filename);
> +	}
> +	*r_size =  size;
> +	return buf;
> +}
>  #else
>  char *slurp_decompress_file(const char *filename, off_t *r_size)
>  {
> diff -urN kexec-tools-2.0.1/kexec/lzma.c kexec-tools-2.0.1.lzma/kexec/lzma.c
> --- kexec-tools-2.0.1/kexec/lzma.c	1970-01-01 01:00:00.000000000 +0100
> +++ kexec-tools-2.0.1.lzma/kexec/lzma.c	2009-11-16 00:44:56.000000000 +0100
> @@ -0,0 +1,132 @@
> +#include <sys/types.h>
> +#include <inttypes.h>
> +#include <string.h>
> +#include <stdlib.h>
> +#include <lzma.h>
> +#include <kexec_lzma.h>
> +
> +#ifdef HAVE_LIBLZMA

#include <kexec_lzma.h> needs to be inside HAVE_LIBLZMA,
it seems just as well to move the #ifdef to the top of the file.

> +static LZFILE *lzopen_internal(const char *path, const char *mode, int fd)
> +{
> +	int level = 5;
> +	int encoding = 0;
> +	FILE *fp;
> +	LZFILE *lzfile;
> +	lzma_ret ret;
> +	lzma_stream lzma_strm_tmp = LZMA_STREAM_INIT;
> +
> +	for (; *mode; mode++) {
> +		if (*mode == 'w')
> +			encoding = 1;
> +		else if (*mode == 'r')
> +			encoding = 0;
> +		else if (*mode >= '1' && *mode <= '9')
> +			level = *mode - '0';
> +	}
> +	if (fd != -1)
> +		fp = fdopen(fd, encoding ? "w" : "r");
> +	else
> +		fp = fopen(path, encoding ? "w" : "r");
> +	if (!fp)
> +		return NULL;
> +
> +	lzfile = calloc(1, sizeof(*lzfile));
> +
> +	if (!lzfile) {
> +		fclose(fp);
> +		return NULL;
> +	}
> +
> +	lzfile->file = fp;
> +	lzfile->encoding = encoding;
> +	lzfile->eof = 0;
> +	lzfile->strm = lzma_strm_tmp;
> +	if (encoding) {
> +		lzma_options_lzma opt_lzma;
> +		if (lzma_lzma_preset(&opt_lzma, level - 1))
> +			return NULL;
> +		ret = lzma_alone_encoder(&lzfile->strm, &opt_lzma);
> +	} else {
> +		ret = lzma_auto_decoder(&lzfile->strm,
> +					UINT64_C(64) * 1024 * 1024, 0);
> +	}
> +	if (ret != LZMA_OK) {
> +		fclose(fp);
> +		free(lzfile);
> +		return NULL;
> +	}
> +	return lzfile;
> +}
> +
> +LZFILE *lzopen(const char *path, const char *mode)
> +{
> +	return lzopen_internal(path, mode, -1);
> +}
> +
> +int lzclose(LZFILE *lzfile)
> +{
> +	lzma_ret ret;
> +	int n;
> +
> +	if (!lzfile)
> +		return -1;
> +
> +	if (lzfile->encoding) {
> +		for (;;) {
> +			lzfile->strm.avail_out = kBufferSize;
> +			lzfile->strm.next_out = lzfile->buf;
> +			ret = lzma_code(&lzfile->strm, LZMA_FINISH);
> +			if (ret != LZMA_OK && ret != LZMA_STREAM_END)
> +				return -1;
> +			n = kBufferSize - lzfile->strm.avail_out;
> +			if (n && fwrite(lzfile->buf, 1, n, lzfile->file) != n)
> +				return -1;
> +			if (ret == LZMA_STREAM_END)
> +				break;
> +		}
> +	}
> +	lzma_end(&lzfile->strm);
> +
> +	return fclose(lzfile->file);
> +	free(lzfile);
> +}
> +
> +ssize_t lzread(LZFILE *lzfile, void *buf, size_t len)
> +{
> +	lzma_ret ret;
> +	int eof = 0;
> +
> +	if (!lzfile || lzfile->encoding)
> +		return -1;
> +
> +	if (lzfile->eof)
> +		return 0;
> +
> +	lzfile->strm.next_out = buf;
> +	lzfile->strm.avail_out = len;
> +
> +	for (;;) {
> +		if (!lzfile->strm.avail_in) {
> +			lzfile->strm.next_in = lzfile->buf;
> +			lzfile->strm.avail_in = fread(lzfile->buf, 1, kBufferSize, lzfile->file);
> +			if (!lzfile->strm.avail_in)
> +				eof = 1;
> +		}
> +
> +		ret = lzma_code(&lzfile->strm, LZMA_RUN);
> +		if (ret == LZMA_STREAM_END) {
> +			lzfile->eof = 1;
> +			return len - lzfile->strm.avail_out;
> +		}
> +
> +		if (ret != LZMA_OK)
> +			return -1;
> +
> +		if (!lzfile->strm.avail_out)
> +			return len;
> +
> +		if (eof)
> +			return -1;
> +	}
> +}
> +#endif /* HAVE_LIBLZMA */
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
