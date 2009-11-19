Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NAuUw-0001DL-UK
	for kexec@lists.infradead.org; Thu, 19 Nov 2009 00:03:47 +0000
Subject: Re: [PATCH] add support for loading lzma compressed kernels
References: <200911160053.10339.florian@openwrt.org>
	<200911171523.15419.florian@openwrt.org>
	<20091118035518.GJ18493@verge.net.au>
	<200911190017.23744.florian@openwrt.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 18 Nov 2009 16:03:27 -0800
In-Reply-To: <200911190017.23744.florian@openwrt.org> (Florian Fainelli's
	message of "Thu\, 19 Nov 2009 00\:17\:22 +0100")
Message-ID: <m1y6m3754g.fsf@fess.ebiederm.org>
MIME-Version: 1.0
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
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

Florian Fainelli <florian@openwrt.org> writes:

> Please find below a version which should address your comments.
> Thanks for reviewing the patch.
> --
> From: Florian Fainelli <florian@openwrt.org>
> Subject: [PATCH] add support for loading lzma compressed kernels
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

Yes.  I don't think it is particularly useful on x86 (as we have
a decompressor built into the kernel) but on other arches
it makes a lot of sense.

A few minor comments inline.

> diff -urN kexec-tools-2.0.1/kexec/kexec-lzma.h kexec-tools-2.0.1.lzma/kexec/kexec-lzma.h
> --- kexec-tools-2.0.1/kexec/kexec-lzma.h	1970-01-01 01:00:00.000000000 +0100
> +++ kexec-tools-2.0.1.lzma/kexec/kexec-lzma.h	2009-11-19 00:06:24.000000000 +0100
> @@ -0,0 +1,29 @@
> +#ifndef __KEXEC_LZMA_H
> +#define __KEXEC_LZMA_H
> +
> +#include <stdio.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <inttypes.h>
> +#include <lzma.h>
> +
> +#include "config.h"
> +
> +#ifdef HAVE_LIBLZMA
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

I don't think we need any of these definitions in the header file.

> +#endif /* HAVE_LIBLZMA */
> +
> +char *lzma_decompress_file(const char *filename, off_t *r_size);

Ideally the lzma_decompress_file stub would live here and would not
even compile kexec/lzma.c if we don't have lzma.

> +#endif /* __KEXEC_LZMA_H */


Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
