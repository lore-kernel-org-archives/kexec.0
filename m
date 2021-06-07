Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1410078.outbound.protection.outlook.com
 ([40.107.141.78] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lq41b-001Bgi-5V
 for kexec@lists.infradead.org; Mon, 07 Jun 2021 01:25:57 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH]  add support for zstd
Date: Mon, 7 Jun 2021 01:25:47 +0000
Message-ID: <TYYPR01MB6777A2598D252675453921A3DD389@TYYPR01MB6777.jpnprd01.prod.outlook.com>
References: <202106011651268624715@zte.com.cn>
In-Reply-To: <202106011651268624715@zte.com.cn>
Content-Language: ja-JP
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "yang.yang29@zte.com.cn" <yang.yang29@zte.com.cn>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Coiby Xu <coxu@redhat.com>
Cc: "zhang.yunkai@zte.com.cn" <zhang.yunkai@zte.com.cn>, "zhang.wenya1@zte.com.cn" <zhang.wenya1@zte.com.cn>

-----Original Message-----
> Date: Tue, 1 Jun 2021 15:43:00 +0800
> Subject: [PATCH] add support for zstd
> 
> Add support for zstd

Thanks for the patch, but we've worked on the zstd support based on
these test patches:
https://github.com/k-hagio/makedumpfile/commit/f6eaf2424f41d8e9af40f7ce67e0f52b387311af
https://github.com/k-hagio/crash/commit/5c55c380120d7b7d450e07c4605aaf330f6219dc

I would like to proceed with those, please wait for a while.

Coiby, do you have any patch you can share and how is the state?
IIRC, your draft patches supported also decompression etc.

Thanks,
Kazu

> 
> Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
> ---
>  Makefile       |  5 +++++
>  diskdump_mod.h |  1 +
>  makedumpfile.c | 36 ++++++++++++++++++++++++++++++------
>  makedumpfile.h |  1 +
>  4 files changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 5d61a69..725c186 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -68,6 +68,11 @@ endif
>  CFLAGS += -DUSESNAPPY
>  endif
> 
> +ifeq ($(USEZSTD), on)
> +LIBS := -lzstd $(LIBS)
> +CFLAGS += -DUSEZSTD
> +endif
> +
>  LIBS := $(LIBS) -lpthread
> 
>  try-run = $(shell set -e;      \
> diff --git a/diskdump_mod.h b/diskdump_mod.h
> index 3733953..ffd9ab2 100644
> --- a/diskdump_mod.h
> +++ b/diskdump_mod.h
> @@ -98,6 +98,7 @@ struct kdump_sub_header {
>  #define DUMP_DH_COMPRESSED_INCOMPLETE  0x8
>                     /* indicate an incomplete dumpfile */
>  #define DUMP_DH_EXCLUDED_VMEMMAP 0x10  /* unused vmemmap pages are excluded */
> +#define DUMP_DH_COMPRESSED_ZSTD 0x20
> 
>  /* descriptor of each page for vmcore */
>  typedef struct page_desc {
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 894c88e..3b588c3 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -26,6 +26,9 @@
>  #include <limits.h>
>  #include <assert.h>
>  #include <zlib.h>
> +#ifdef USEZSTD
> +#include <zstd.h>
> +#endif
> 
>  struct symbol_table    symbol_table;
>  struct size_table  size_table;
> @@ -296,10 +299,10 @@ is_cache_page(unsigned long flags)
>  static inline unsigned long
>  calculate_len_buf_out(long page_size)
>  {
> -   unsigned long len_buf_out_zlib, len_buf_out_lzo, len_buf_out_snappy;
> +   unsigned long len_buf_out_zlib, len_buf_out_lzo, len_buf_out_snappy, len_buf_out_zstd;
>     unsigned long len_buf_out;
> 
> -   len_buf_out_zlib = len_buf_out_lzo = len_buf_out_snappy = 0;
> +   len_buf_out_zlib = len_buf_out_lzo = len_buf_out_snappy = len_buf_out_zstd = 0;
> 
>  #ifdef USELZO
>     len_buf_out_lzo = page_size + page_size / 16 + 64 + 3;
> @@ -309,11 +312,14 @@ calculate_len_buf_out(long page_size)
>     len_buf_out_snappy = snappy_max_compressed_length(page_size);
>  #endif
> 
> +#ifdef USEZSTD
> +   len_buf_out_zstd = ZSTD_compressBound(page_size);
> +#endif
> +
>     len_buf_out_zlib = compressBound(page_size);
> 
> -   len_buf_out = MAX(len_buf_out_zlib,
> -             MAX(len_buf_out_lzo,
> -                 len_buf_out_snappy));
> +   len_buf_out = MAX(MAX(len_buf_out_zlib,len_buf_out_zstd),
> +           MAX(len_buf_out_lzo,len_buf_out_snappy));
> 
>     return len_buf_out;
>  }
> @@ -7235,6 +7241,10 @@ write_kdump_header(void)
> 
>     if (info->flag_compress & DUMP_DH_COMPRESSED_ZLIB)
>         dh->status |= DUMP_DH_COMPRESSED_ZLIB;
> +#ifdef USEZSTD
> +   else if (info->flag_compress & DUMP_DH_COMPRESSED_ZSTD)
> +       dh->status |= DUMP_DH_COMPRESSED_ZSTD;
> +#endif
>  #ifdef USELZO
>     else if (info->flag_compress & DUMP_DH_COMPRESSED_LZO)
>         dh->status |= DUMP_DH_COMPRESSED_LZO;
> @@ -8589,6 +8599,17 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
>             && (size_out < info->page_size)) {
>             pd.flags = DUMP_DH_COMPRESSED_ZLIB;
>             pd.size  = size_out;
> +#ifdef USEZSTD
> +       } else if ((info->flag_compress & DUMP_DH_COMPRESSED_ZSTD)
> +               && (size_out = len_buf_out)
> +               && (len_buf_out = ZSTD_compress((void *)buf_out,
> +                       size_out, (const void *)buf, info->page_size, 1))
> +               && (len_buf_out < info->page_size)
> +             ) {
> +           CHECK_ZSTD(len_buf_out);
> +           pd.flags = DUMP_DH_COMPRESSED_ZSTD;
> +           pd.size  = len_buf_out;
> +#endif
>  #ifdef USELZO
>         } else if (info->flag_lzo_support
>                && (info->flag_compress & DUMP_DH_COMPRESSED_LZO)
> @@ -11605,7 +11626,7 @@ main(int argc, char *argv[])
> 
>     info->block_order = DEFAULT_ORDER;
>     message_level = DEFAULT_MSG_LEVEL;
> -   while ((opt = getopt_long(argc, argv, "b:cDd:eEFfg:hi:lpRvXx:", longopts,
> +   while ((opt = getopt_long(argc, argv, "b:cDd:eEFfg:hi:lpRvXx:z", longopts,
>         NULL)) != -1) {
>         switch (opt) {
>         case OPT_BLOCK_ORDER:
> @@ -11617,6 +11638,9 @@ main(int argc, char *argv[])
>         case OPT_COMPRESS_ZLIB:
>             info->flag_compress = DUMP_DH_COMPRESSED_ZLIB;
>             break;
> +       case OPT_COMPRESS_ZSTD:
> +           info->flag_compress = DUMP_DH_COMPRESSED_ZSTD;
> +           break;
>         case OPT_DEBUG:
>             flag_debug = TRUE;
>             break;
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 79046f2..3fb1b57 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -2463,6 +2463,7 @@ struct elf_prstatus {
>  #define OPT_VERSION             'v'
>  #define OPT_EXCLUDE_XEN_DOM     'X'
>  #define OPT_VMLINUX             'x'
> +#define OPT_COMPRESS_ZSTD       'z'
>  #define OPT_START               256
>  #define OPT_SPLIT               OPT_START+0
>  #define OPT_REASSEMBLE          OPT_START+1
> --
> 1.8.3.1
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
