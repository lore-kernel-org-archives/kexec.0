Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2D4E77180
	for <kexec@archiver.kernel.org>; Wed, 11 Dec 2024 14:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tQO+GnWSWtVY6hnrR8hNhH0R5VS6qahf7segxlq0eOU=; b=ezuIXhNd0G64szRVB1XrsVYyWz
	B1/g7w6V7jvgi0TS9fnlWpRFx+URA9duma+4fBSFIr6V6Zr907eKKrOzLfPrw1LbqRKTlyAfU3QFh
	Q/T/ag/1JNwb20W+nl3pXKAP38NSdFee885E6LZ0o0m3q0VdjAnSErz5GsaK451zH1cVLLdg2YDbZ
	Qybr8Ir7SwgJD7r6fOnu+je8rgn210d7JQdg1I5P8DMNvBhRZIyOBRsQrF4Ir3vnw43uYF7TkAv13
	nBhfxsazxWj1jNnYU6suwcSL2b5tr3udY/cjQBiGyPRxCRmxu7At1IxV2ycINzEVFcEgK2nCYzmNh
	Cy08qzTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLO5P-0000000FCRv-3f2j;
	Wed, 11 Dec 2024 14:53:11 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLO5N-0000000FCRF-0Re8
	for kexec@lists.infradead.org;
	Wed, 11 Dec 2024 14:53:10 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A59B339;
	Wed, 11 Dec 2024 06:53:36 -0800 (PST)
Received: from [192.168.20.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BD693F5A1;
	Wed, 11 Dec 2024 06:53:07 -0800 (PST)
Message-ID: <c95eb9e5-66b4-4919-a2c9-6cfc8945e1df@arm.com>
Date: Wed, 11 Dec 2024 08:53:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] zstd: Add zstd decompression logic
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, horms@kernel.org, ardb@kernel.org
References: <20241211025810.242894-1-jeremy.linton@arm.com>
 <20241211025810.242894-2-jeremy.linton@arm.com>
 <CAF+s44QSxzzUBWY4qg8GZuxADgjXRwe7O+Pe9m--pf3Y3nVkwA@mail.gmail.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <CAF+s44QSxzzUBWY4qg8GZuxADgjXRwe7O+Pe9m--pf3Y3nVkwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_065309_245066_423C2C77 
X-CRM114-Status: GOOD (  36.44  )
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

Hi,

On 12/11/24 6:16 AM, Pingfan Liu wrote:
> On Wed, Dec 11, 2024 at 10:58 AM Jeremy Linton <jeremy.linton@arm.com> wrote:
>>
>> zstd is becoming a popular zlib replacement because it both tends to
>> get a better compression ratio as well performs considerably
>> better. As such, zstd is now one of the options that can be used to
>> compress the Linux kernel.
>>
>> Lets enable it by using a system provided shared library, creating the
>> required boilerplate to match the existing zlib/lzma function
>> signatures, and creating build options to enable/disable it.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   configure.ac       |  10 +++
>>   kexec/Makefile     |   4 +-
>>   kexec/kexec-zstd.h |   7 ++
>>   kexec/zstd.c       | 191 +++++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 211 insertions(+), 1 deletion(-)
>>   create mode 100644 kexec/kexec-zstd.h
>>   create mode 100644 kexec/zstd.c
>>
>> diff --git a/configure.ac b/configure.ac
>> index e030302..43cdb64 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -106,6 +106,9 @@ AC_ARG_WITH([zlib], AS_HELP_STRING([--without-zlib],[disable zlib support]),
>>   AC_ARG_WITH([lzma], AS_HELP_STRING([--without-lzma],[disable lzma support]),
>>          [ with_lzma="$withval"], [ with_lzma=yes ] )
>>
>> +AC_ARG_WITH([zstd], AS_HELP_STRING([--without-zstd],[disable zstd support]),
>> +       [ with_zstd="$withval"], [ with_zstd=yes ] )
>> +
>>   AC_ARG_WITH([xen], AS_HELP_STRING([--without-xen],
>>          [disable extended xen support]), [ with_xen="$withval"], [ with_xen=yes ] )
>>
>> @@ -180,6 +183,13 @@ if test "$with_lzma" = yes ; then
>>                  AC_MSG_NOTICE([lzma support disabled]))])
>>   fi
>>
>> +dnl See if I have a usable copy of zstd available
>> +if test "$with_zstd" = yes ; then
>> +       AC_CHECK_HEADER(zstd.h,
>> +               [AC_CHECK_LIB(zstd, ZSTD_decompress, ,
>> +               AC_MSG_NOTICE([zstd support disabled]))])
>> +fi
>> +
>>   dnl find Xen control stack libraries
>>   if test "$with_xen" = yes ; then
>>          AC_CHECK_HEADER(xenctrl.h,
>> diff --git a/kexec/Makefile b/kexec/Makefile
>> index d4f26d7..e969d1e 100644
>> --- a/kexec/Makefile
>> +++ b/kexec/Makefile
>> @@ -26,6 +26,7 @@ KEXEC_SRCS_base += kexec/crashdump-xen.c
>>   KEXEC_SRCS_base += kexec/phys_arch.c
>>   KEXEC_SRCS_base += kexec/lzma.c
>>   KEXEC_SRCS_base += kexec/zlib.c
>> +KEXEC_SRCS_base += kexec/zstd.c
>>   KEXEC_SRCS_base += kexec/kexec-xen.c
>>   KEXEC_SRCS_base += kexec/symbols.c
>>
>> @@ -36,7 +37,8 @@ dist += kexec/Makefile                                                \
>>          kexec/crashdump.h kexec/firmware_memmap.h               \
>>          kexec/kexec-elf-boot.h                                  \
>>          kexec/kexec-elf.h kexec/kexec-sha256.h                  \
>> -       kexec/kexec-zlib.h kexec/kexec-lzma.h                   \
>> +       kexec/kexec-zlib.h kexec/kexec-lzma.h                   \
>> +       kexec/kexec-zstd.h                                      \
>>          kexec/kexec-xen.h                                       \
>>          kexec/kexec-syscall.h kexec/kexec.h kexec/kexec.8
>>
>> diff --git a/kexec/kexec-zstd.h b/kexec/kexec-zstd.h
>> new file mode 100644
>> index 0000000..c5dbb24
>> --- /dev/null
>> +++ b/kexec/kexec-zstd.h
>> @@ -0,0 +1,7 @@
>> +#ifndef __KEXEC_ZSTD_H
>> +#define __KEXEC_ZSTD_H
>> +
>> +#include <sys/types.h>
>> +
>> +char *zstd_decompress_file(const char *filename, off_t *r_size);
>> +#endif /* __KEXEC_ZSTD_H */
>> diff --git a/kexec/zstd.c b/kexec/zstd.c
>> new file mode 100644
>> index 0000000..9309251
>> --- /dev/null
>> +++ b/kexec/zstd.c
>> @@ -0,0 +1,191 @@
>> +#include "kexec-zstd.h"
>> +#include "kexec.h"
>> +
>> +#include "config.h"
>> +
>> +#ifdef HAVE_LIBZSTD
>> +#include <stdio.h>
>> +#include <stdint.h>
>> +#include <stdlib.h>
>> +#include <errno.h>
>> +#include <limits.h>
>> +#include <stdbool.h>
>> +#include <sys/types.h>
>> +#include <sys/stat.h>
>> +#include <unistd.h>
>> +#include <ctype.h>
>> +#include <zstd.h>
>> +
>> +
>> +/*
>> + * Reimplementation of private function available if lib is statically linked.
>> + * Remove when said function becomes public.
>> + */
>> +unsigned ZSTD_isFrame(const void* buffer, size_t size)
>> +{
>> +       uint8_t *buf = (uint8_t *)buffer;
>> +       /* Magic zstd frame header value */
>> +       if ((buf[0] == 0x28) &&
>> +           (buf[1] == 0xB5) &&
>> +           (buf[2] == 0x2F) &&
>> +           (buf[3] == 0xFD))
>> +               return 1;
>> +
>> +       return 0;
>> +}
>> +
>> +/*
>> + * A guess at the nax compression ratio for buffer overallocation
>> + * Real values are frequently around 4:1, if this is wrong
>> + * it just results in buffer reallocation and the decompression
>> + * operation being restarted from where it left off.
>> + */
>> +#define EXPECTED_RATIO 8
>> +
>> +/*
>> + * This supports the streaming compression mode the kernel uses
>> + * that can result in multiple zstd frames comprising a single
>> + * compressed image. In order too be a bit more efficient than
>> + * the libz/lzma implementations, we attempt to discover the input
>> + * and output image sizes before performing the decompression.
>> + * But, in streaming mode the first frame may not have a length
>> + * or it seems the length could be incorrect if multiple frames
>> + * are appended together. So, its written with buffer resize logic
>> + * but a guess at the compression ratio is made to avoid the resize/copy
>> + * operation. Ideally this code efficiently allocates the
>> + * correct input buffer, and no more than 2-3x the output buffer
>> + * size so that it can perform the decompress operation with a
>> + * single decompress call.
>> + */
>> +char *zstd_decompress_file(const char *filename, off_t *r_size)
>> +{
>> +       bool again;
>> +       void *cBuff = NULL;
>> +       FILE *fp = NULL; /* use c streams to match gzip/lzma logic */
>> +       struct stat fp_stats;
>> +       uint8_t magic[4];
>> +       ZSTD_DCtx* dctx = NULL;
>> +
>> +       ZSTD_outBuffer output = { NULL, 0, 0 };
>> +       ZSTD_inBuffer input = { NULL, 0, 0 };
>> +
>> +
>> +       *r_size = 0;
>> +       if (!filename) {
>> +               return NULL;
>> +       }
>> +       if (stat(filename, &fp_stats))
>> +       {
>              ^^^ inconsistent coding style. I prefer the kernel coding style.

I think I noted to someone a while back I've lost my ability to see this.

But you right, I will repost it with consistent bracing style.

Thanks for taking a look at this.


> 
>> +               dbgprintf("Cannot stat `%s'\n", filename);
>> +               return NULL;
>> +       }
>> +       if (fp_stats.st_size < sizeof(magic))
>> +       {
>              ^^^ ditto and the following brace.
> 
> 
> Thanks,
> 
> Pingfan
> 
>> +               dbgprintf("short file\n");
>> +               return NULL;
>> +       }
>> +       input.size = fp_stats.st_size;
>> +
>> +       fp = fopen(filename, "rb");
>> +       if (fp == 0) {
>> +               dbgprintf("Cannot open `%s'\n", filename);
>> +               goto fail;
>> +       }
>> +       /* before we read the whole buffer see if this looks like a zstd frame */
>> +       if (fread(&magic, 1, sizeof(magic), fp) != sizeof(magic)) {
>> +               dbgprintf("Unable to read zstd header\n");
>> +               goto fail;
>> +       }
>> +
>> +       if (!ZSTD_isFrame((void*)&magic, sizeof(magic)))
>> +       {
>> +               dbgprintf("Not zstd compressed\n");
>> +               goto fail;
>> +       }
>> +
>> +       cBuff = xmalloc(input.size);
>> +       input.src = cBuff; /* use cBuff ptr to avoid const/mismatches */
>> +       rewind(fp);
>> +       if (fread(cBuff, 1, input.size, fp) != input.size)
>> +       {
>> +               dbgprintf("Unable to read compressed data\n");
>> +               goto fail;
>> +       }
>> +       fclose(fp);
>> +       fp = NULL;
>> +
>> +
>> +       output.size = ZSTD_getFrameContentSize(input.src, input.size);
>> +       if (output.size == ZSTD_CONTENTSIZE_ERROR)
>> +       {
>> +               dbgprintf("not compressed by zstd\n");
>> +               goto fail;
>> +       }
>> +
>> +       if (output.size == ZSTD_CONTENTSIZE_UNKNOWN)
>> +       {
>> +               /*
>> +                * The compressed size is an optional field in the header
>> +                * So we guess at the compression ratio to avoid reallocating
>> +                * the buffer, but this can fail so we still have code to
>> +                * handle that case.
>> +                */
>> +               dbgprintf("original zstd size unknown!\n");
>> +               output.size = fp_stats.st_size * EXPECTED_RATIO;
>> +       }
>> +       output.dst = xmalloc(output.size);
>> +
>> +       dctx = ZSTD_createDCtx();
>> +       if (dctx == NULL) {
>> +               dbgprintf("zstd context allocation error\n");
>> +               goto fail;
>> +       }
>> +
>> +       do {
>> +               again = false;
>> +               size_t const ret = ZSTD_decompressStream(dctx, &output , &input);
>> +               if (ZSTD_isError(ret)) {
>> +                       dbgprintf("zstd error %s\n", ZSTD_getErrorName(ret));
>> +                       goto fail;
>> +               }
>> +               dbgprintf("zstd decompressed to input=%ld output=%ld\n", input.pos, output.pos);
>> +               if (output.pos == output.size) {
>> +                       /* uh the output buffer wasn't large enough, double it */
>> +                       output.size <<= 1;
>> +                       output.dst = xrealloc(output.dst, output.size);
>> +                       /*
>> +                        * handle case where all the input was consumed but not all the
>> +                        * output was written because of insufficient output buffer
>> +                        */
>> +                       again = true;
>> +               }
>> +
>> +       } while ((input.pos < input.size) || again);
>> +
>> +       free(cBuff);
>> +       ZSTD_freeDCtx(dctx);
>> +
>> +       *r_size = output.pos;
>> +
>> +       return output.dst;
>> +
>> +fail:
>> +       if (fp)
>> +               fclose(fp);
>> +       if (dctx)
>> +               ZSTD_freeDCtx(dctx);
>> +       if (output.dst)
>> +               free(output.dst);
>> +       if (cBuff)
>> +               free(cBuff);
>> +
>> +       return NULL;
>> +
>> +}
>> +#else
>> +
>> +char *zstd_decompress_file(const char *filename, off_t *r_size)
>> +{
>> +       return NULL;
>> +}
>> +#endif
>> --
>> 2.47.0
>>
>>
> 


