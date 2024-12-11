Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54529E7717D
	for <kexec@archiver.kernel.org>; Wed, 11 Dec 2024 12:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rrmjs+RIigRJSVM6KsMBGxxCo4INMKUaIxTI0gu6lKs=; b=zaF+Jj8SnmVtJvu+A5eVkmYUaE
	mtYh2CsSotgcore90Am7+hWlJ9sZIGbosAKteKTxoRgxk4DlnI4QhbE36iYGH8u5M5BCFMSIymZQj
	/IwoJnlrCHmnJNDS5P1oVqmBSC0niAuh0ZDWoJcmmiYYtuPlMlagNa8QM6iHvCq7aELhivHuPEdHj
	Pg8s4nOwUuPE57PHcoZPdCiDH0pj5wzmBDubKUyZj40Zz2P2FfNAvN1cnzAiQdffSNU5CY3iVfUOs
	x06e5hvy1UVTF54+Ct5tBE7Dym/IRVTvMl8rDgsaD6mt5AZg77/39/KJansrT8xfQBwi33dbMRnkv
	adZHzdHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLLds-0000000Enav-13fo;
	Wed, 11 Dec 2024 12:16:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLLdn-0000000EnZx-1dpL
	for kexec@lists.infradead.org;
	Wed, 11 Dec 2024 12:16:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733919389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rrmjs+RIigRJSVM6KsMBGxxCo4INMKUaIxTI0gu6lKs=;
	b=BkVIZi63ldZ7jwGyyAmdw+O6gXAWxKHou0ZdFyyPp8WRpUCfteCRQ7cyeH1VRGiQ01r/o+
	OC8u5ZuspeaOeRCwV+mNYstydXKUZvIpLLyEJxs1xScnwU8AH7YQX0XFI1bXMUBU3Bxbc2
	HlxTkBCP6/TB+gmXKSggs870yxT2EZc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-HdkZeQlwO5mVzX4u3dRKLA-1; Wed, 11 Dec 2024 07:16:27 -0500
X-MC-Unique: HdkZeQlwO5mVzX4u3dRKLA-1
X-Mimecast-MFC-AGG-ID: HdkZeQlwO5mVzX4u3dRKLA
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d8897ea603so11801806d6.1
        for <kexec@lists.infradead.org>; Wed, 11 Dec 2024 04:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733919387; x=1734524187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rrmjs+RIigRJSVM6KsMBGxxCo4INMKUaIxTI0gu6lKs=;
        b=vjEj+/LvJ9L3P6kf0DOTCalEMhk+JKTJxc0fk4P5mn2d/+yQZkscNKXAGBDkvAb8kd
         9OXs/uMwwd/nmv0jjuy+HXSFVN2gVITTBNGOlko6uWMh82dyl2oL9Q36CY1rvRcOwXIU
         O3pIaFe59gWGUk3jeseOkUB+FcgOdqHhRW2RckWRKX3vJ3siseMsuqHpM1Qi0gqQRK2S
         SMcY9XU8wq/9OHHnn18yExiScqsqU1gVjMMhIffAsO3YvHHiXsx21lWWkZ9+63MdCeba
         SNpXgdXlPLT2yy5tUaqQm6ptQYAbUY5JAVv8BfDs2JFcBPLpr8Dar3g4FGztu6daXfRa
         fzwQ==
X-Gm-Message-State: AOJu0YxE3wzO8Hf/h1xYT+mtsyruGhdbnjlEFR/po7x6CR7vvryn4jSA
	pzFtt5kUtDVkFhNC1lNlQhx2keJD+HJrBH2gLC3lfFKgAYqceiMFnV/5XwjA3E03+gy1e7B3Izv
	lrgmeSCFd7O8mdgVf6uZ/yk/B8HznKNVIttog+EKmv/zHwDH0X63V3bprSeHhSFZHWe5vvHtqhD
	jeXqsA2aDM9IzuIswTswoh7P4GvdCal92X
X-Gm-Gg: ASbGncsZQo6NS37sser80S6OyQsq1EPqvtf1LbvQ9v7wr1d36eEGERzUhnoTb1B03gD
	mzuGDbBtASY++EGCSK+Vz3sasmENOOUAigYSD
X-Received: by 2002:a05:6214:2622:b0:6d8:9f61:de6c with SMTP id 6a1803df08f44-6d9352f1cebmr37564556d6.18.1733919386898;
        Wed, 11 Dec 2024 04:16:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGZyz1daPlmsGiwMVpLaxE6uhjT6LToCWjrfexXMZWVJ7ZsGcoWfAig3d/58u+Zxd/ygTBc1/bvvmX5n0CrBo=
X-Received: by 2002:a05:6214:2622:b0:6d8:9f61:de6c with SMTP id
 6a1803df08f44-6d9352f1cebmr37564216d6.18.1733919386503; Wed, 11 Dec 2024
 04:16:26 -0800 (PST)
MIME-Version: 1.0
References: <20241211025810.242894-1-jeremy.linton@arm.com> <20241211025810.242894-2-jeremy.linton@arm.com>
In-Reply-To: <20241211025810.242894-2-jeremy.linton@arm.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Wed, 11 Dec 2024 20:16:15 +0800
Message-ID: <CAF+s44QSxzzUBWY4qg8GZuxADgjXRwe7O+Pe9m--pf3Y3nVkwA@mail.gmail.com>
Subject: Re: [PATCH 1/2] zstd: Add zstd decompression logic
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: kexec@lists.infradead.org, horms@kernel.org, ardb@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 46rRtfjA2-5j3y03C3aJIKLdu4rGk16hZsn3pcJJZv0_1733919387
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_041631_506677_4AE3BD4B 
X-CRM114-Status: GOOD (  42.23  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Dec 11, 2024 at 10:58=E2=80=AFAM Jeremy Linton <jeremy.linton@arm.c=
om> wrote:
>
> zstd is becoming a popular zlib replacement because it both tends to
> get a better compression ratio as well performs considerably
> better. As such, zstd is now one of the options that can be used to
> compress the Linux kernel.
>
> Lets enable it by using a system provided shared library, creating the
> required boilerplate to match the existing zlib/lzma function
> signatures, and creating build options to enable/disable it.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  configure.ac       |  10 +++
>  kexec/Makefile     |   4 +-
>  kexec/kexec-zstd.h |   7 ++
>  kexec/zstd.c       | 191 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 211 insertions(+), 1 deletion(-)
>  create mode 100644 kexec/kexec-zstd.h
>  create mode 100644 kexec/zstd.c
>
> diff --git a/configure.ac b/configure.ac
> index e030302..43cdb64 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -106,6 +106,9 @@ AC_ARG_WITH([zlib], AS_HELP_STRING([--without-zlib],[=
disable zlib support]),
>  AC_ARG_WITH([lzma], AS_HELP_STRING([--without-lzma],[disable lzma suppor=
t]),
>         [ with_lzma=3D"$withval"], [ with_lzma=3Dyes ] )
>
> +AC_ARG_WITH([zstd], AS_HELP_STRING([--without-zstd],[disable zstd suppor=
t]),
> +       [ with_zstd=3D"$withval"], [ with_zstd=3Dyes ] )
> +
>  AC_ARG_WITH([xen], AS_HELP_STRING([--without-xen],
>         [disable extended xen support]), [ with_xen=3D"$withval"], [ with=
_xen=3Dyes ] )
>
> @@ -180,6 +183,13 @@ if test "$with_lzma" =3D yes ; then
>                 AC_MSG_NOTICE([lzma support disabled]))])
>  fi
>
> +dnl See if I have a usable copy of zstd available
> +if test "$with_zstd" =3D yes ; then
> +       AC_CHECK_HEADER(zstd.h,
> +               [AC_CHECK_LIB(zstd, ZSTD_decompress, ,
> +               AC_MSG_NOTICE([zstd support disabled]))])
> +fi
> +
>  dnl find Xen control stack libraries
>  if test "$with_xen" =3D yes ; then
>         AC_CHECK_HEADER(xenctrl.h,
> diff --git a/kexec/Makefile b/kexec/Makefile
> index d4f26d7..e969d1e 100644
> --- a/kexec/Makefile
> +++ b/kexec/Makefile
> @@ -26,6 +26,7 @@ KEXEC_SRCS_base +=3D kexec/crashdump-xen.c
>  KEXEC_SRCS_base +=3D kexec/phys_arch.c
>  KEXEC_SRCS_base +=3D kexec/lzma.c
>  KEXEC_SRCS_base +=3D kexec/zlib.c
> +KEXEC_SRCS_base +=3D kexec/zstd.c
>  KEXEC_SRCS_base +=3D kexec/kexec-xen.c
>  KEXEC_SRCS_base +=3D kexec/symbols.c
>
> @@ -36,7 +37,8 @@ dist +=3D kexec/Makefile                               =
                 \
>         kexec/crashdump.h kexec/firmware_memmap.h               \
>         kexec/kexec-elf-boot.h                                  \
>         kexec/kexec-elf.h kexec/kexec-sha256.h                  \
> -       kexec/kexec-zlib.h kexec/kexec-lzma.h                   \
> +       kexec/kexec-zlib.h kexec/kexec-lzma.h                   \
> +       kexec/kexec-zstd.h                                      \
>         kexec/kexec-xen.h                                       \
>         kexec/kexec-syscall.h kexec/kexec.h kexec/kexec.8
>
> diff --git a/kexec/kexec-zstd.h b/kexec/kexec-zstd.h
> new file mode 100644
> index 0000000..c5dbb24
> --- /dev/null
> +++ b/kexec/kexec-zstd.h
> @@ -0,0 +1,7 @@
> +#ifndef __KEXEC_ZSTD_H
> +#define __KEXEC_ZSTD_H
> +
> +#include <sys/types.h>
> +
> +char *zstd_decompress_file(const char *filename, off_t *r_size);
> +#endif /* __KEXEC_ZSTD_H */
> diff --git a/kexec/zstd.c b/kexec/zstd.c
> new file mode 100644
> index 0000000..9309251
> --- /dev/null
> +++ b/kexec/zstd.c
> @@ -0,0 +1,191 @@
> +#include "kexec-zstd.h"
> +#include "kexec.h"
> +
> +#include "config.h"
> +
> +#ifdef HAVE_LIBZSTD
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <limits.h>
> +#include <stdbool.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +#include <ctype.h>
> +#include <zstd.h>
> +
> +
> +/*
> + * Reimplementation of private function available if lib is statically l=
inked.
> + * Remove when said function becomes public.
> + */
> +unsigned ZSTD_isFrame(const void* buffer, size_t size)
> +{
> +       uint8_t *buf =3D (uint8_t *)buffer;
> +       /* Magic zstd frame header value */
> +       if ((buf[0] =3D=3D 0x28) &&
> +           (buf[1] =3D=3D 0xB5) &&
> +           (buf[2] =3D=3D 0x2F) &&
> +           (buf[3] =3D=3D 0xFD))
> +               return 1;
> +
> +       return 0;
> +}
> +
> +/*
> + * A guess at the nax compression ratio for buffer overallocation
> + * Real values are frequently around 4:1, if this is wrong
> + * it just results in buffer reallocation and the decompression
> + * operation being restarted from where it left off.
> + */
> +#define EXPECTED_RATIO 8
> +
> +/*
> + * This supports the streaming compression mode the kernel uses
> + * that can result in multiple zstd frames comprising a single
> + * compressed image. In order too be a bit more efficient than
> + * the libz/lzma implementations, we attempt to discover the input
> + * and output image sizes before performing the decompression.
> + * But, in streaming mode the first frame may not have a length
> + * or it seems the length could be incorrect if multiple frames
> + * are appended together. So, its written with buffer resize logic
> + * but a guess at the compression ratio is made to avoid the resize/copy
> + * operation. Ideally this code efficiently allocates the
> + * correct input buffer, and no more than 2-3x the output buffer
> + * size so that it can perform the decompress operation with a
> + * single decompress call.
> + */
> +char *zstd_decompress_file(const char *filename, off_t *r_size)
> +{
> +       bool again;
> +       void *cBuff =3D NULL;
> +       FILE *fp =3D NULL; /* use c streams to match gzip/lzma logic */
> +       struct stat fp_stats;
> +       uint8_t magic[4];
> +       ZSTD_DCtx* dctx =3D NULL;
> +
> +       ZSTD_outBuffer output =3D { NULL, 0, 0 };
> +       ZSTD_inBuffer input =3D { NULL, 0, 0 };
> +
> +
> +       *r_size =3D 0;
> +       if (!filename) {
> +               return NULL;
> +       }
> +       if (stat(filename, &fp_stats))
> +       {
            ^^^ inconsistent coding style. I prefer the kernel coding style=
.

> +               dbgprintf("Cannot stat `%s'\n", filename);
> +               return NULL;
> +       }
> +       if (fp_stats.st_size < sizeof(magic))
> +       {
            ^^^ ditto and the following brace.


Thanks,

Pingfan

> +               dbgprintf("short file\n");
> +               return NULL;
> +       }
> +       input.size =3D fp_stats.st_size;
> +
> +       fp =3D fopen(filename, "rb");
> +       if (fp =3D=3D 0) {
> +               dbgprintf("Cannot open `%s'\n", filename);
> +               goto fail;
> +       }
> +       /* before we read the whole buffer see if this looks like a zstd =
frame */
> +       if (fread(&magic, 1, sizeof(magic), fp) !=3D sizeof(magic)) {
> +               dbgprintf("Unable to read zstd header\n");
> +               goto fail;
> +       }
> +
> +       if (!ZSTD_isFrame((void*)&magic, sizeof(magic)))
> +       {
> +               dbgprintf("Not zstd compressed\n");
> +               goto fail;
> +       }
> +
> +       cBuff =3D xmalloc(input.size);
> +       input.src =3D cBuff; /* use cBuff ptr to avoid const/mismatches *=
/
> +       rewind(fp);
> +       if (fread(cBuff, 1, input.size, fp) !=3D input.size)
> +       {
> +               dbgprintf("Unable to read compressed data\n");
> +               goto fail;
> +       }
> +       fclose(fp);
> +       fp =3D NULL;
> +
> +
> +       output.size =3D ZSTD_getFrameContentSize(input.src, input.size);
> +       if (output.size =3D=3D ZSTD_CONTENTSIZE_ERROR)
> +       {
> +               dbgprintf("not compressed by zstd\n");
> +               goto fail;
> +       }
> +
> +       if (output.size =3D=3D ZSTD_CONTENTSIZE_UNKNOWN)
> +       {
> +               /*
> +                * The compressed size is an optional field in the header
> +                * So we guess at the compression ratio to avoid realloca=
ting
> +                * the buffer, but this can fail so we still have code to
> +                * handle that case.
> +                */
> +               dbgprintf("original zstd size unknown!\n");
> +               output.size =3D fp_stats.st_size * EXPECTED_RATIO;
> +       }
> +       output.dst =3D xmalloc(output.size);
> +
> +       dctx =3D ZSTD_createDCtx();
> +       if (dctx =3D=3D NULL) {
> +               dbgprintf("zstd context allocation error\n");
> +               goto fail;
> +       }
> +
> +       do {
> +               again =3D false;
> +               size_t const ret =3D ZSTD_decompressStream(dctx, &output =
, &input);
> +               if (ZSTD_isError(ret)) {
> +                       dbgprintf("zstd error %s\n", ZSTD_getErrorName(re=
t));
> +                       goto fail;
> +               }
> +               dbgprintf("zstd decompressed to input=3D%ld output=3D%ld\=
n", input.pos, output.pos);
> +               if (output.pos =3D=3D output.size) {
> +                       /* uh the output buffer wasn't large enough, doub=
le it */
> +                       output.size <<=3D 1;
> +                       output.dst =3D xrealloc(output.dst, output.size);
> +                       /*
> +                        * handle case where all the input was consumed b=
ut not all the
> +                        * output was written because of insufficient out=
put buffer
> +                        */
> +                       again =3D true;
> +               }
> +
> +       } while ((input.pos < input.size) || again);
> +
> +       free(cBuff);
> +       ZSTD_freeDCtx(dctx);
> +
> +       *r_size =3D output.pos;
> +
> +       return output.dst;
> +
> +fail:
> +       if (fp)
> +               fclose(fp);
> +       if (dctx)
> +               ZSTD_freeDCtx(dctx);
> +       if (output.dst)
> +               free(output.dst);
> +       if (cBuff)
> +               free(cBuff);
> +
> +       return NULL;
> +
> +}
> +#else
> +
> +char *zstd_decompress_file(const char *filename, off_t *r_size)
> +{
> +       return NULL;
> +}
> +#endif
> --
> 2.47.0
>
>


