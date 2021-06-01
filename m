Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mxhk.zte.com.cn ([63.217.80.70])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lo08C-00FRry-MI
 for kexec@lists.infradead.org; Tue, 01 Jun 2021 08:52:14 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 by Forcepoint Email with ESMTPS id 620B6397F86338AF14FA
 for <kexec@lists.infradead.org>; Tue,  1 Jun 2021 16:52:04 +0800 (CST)
Received: from kjyxapp01.zte.com.cn ([10.30.12.200])
 by mse-fl1.zte.com.cn with SMTP id 1518pQm3008148
 for <kexec@lists.infradead.org>; Tue, 1 Jun 2021 16:51:26 +0800 (GMT-8)
 (envelope-from yang.yang29@zte.com.cn)
Date: Tue, 1 Jun 2021 16:51:26 +0800 (CST)
Message-ID: <202106011651268624715@zte.com.cn>
Mime-Version: 1.0
From: <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSAgYWRkIHN1cHBvcnQgZm9yIHpzdGQ=?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: zhang.yunkai@zte.com.cn, zhang.wenya1@zte.com.cn



--=====_001_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"

Date: Tue, 1 Jun 2021 15:43:00 +0800
Subject: [PATCH] add support for zstd

Add support for zstd

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 Makefile       |  5 +++++
 diskdump_mod.h |  1 +
 makedumpfile.c | 36 ++++++++++++++++++++++++++++++------
 makedumpfile.h |  1 +
 4 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 5d61a69..725c186 100644
--- a/Makefile
+++ b/Makefile
@@ -68,6 +68,11 @@ endif
 CFLAGS += -DUSESNAPPY
 endif

+ifeq ($(USEZSTD), on)
+LIBS := -lzstd $(LIBS)
+CFLAGS += -DUSEZSTD
+endif
+
 LIBS := $(LIBS) -lpthread

 try-run = $(shell set -e;      \
diff --git a/diskdump_mod.h b/diskdump_mod.h
index 3733953..ffd9ab2 100644
--- a/diskdump_mod.h
+++ b/diskdump_mod.h
@@ -98,6 +98,7 @@ struct kdump_sub_header {
 #define DUMP_DH_COMPRESSED_INCOMPLETE  0x8
                    /* indicate an incomplete dumpfile */
 #define DUMP_DH_EXCLUDED_VMEMMAP 0x10  /* unused vmemmap pages are excluded */
+#define DUMP_DH_COMPRESSED_ZSTD 0x20

 /* descriptor of each page for vmcore */
 typedef struct page_desc {
diff --git a/makedumpfile.c b/makedumpfile.c
index 894c88e..3b588c3 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -26,6 +26,9 @@
 #include <limits.h>
 #include <assert.h>
 #include <zlib.h>
+#ifdef USEZSTD
+#include <zstd.h>
+#endif

 struct symbol_table    symbol_table;
 struct size_table  size_table;
@@ -296,10 +299,10 @@ is_cache_page(unsigned long flags)
 static inline unsigned long
 calculate_len_buf_out(long page_size)
 {
-   unsigned long len_buf_out_zlib, len_buf_out_lzo, len_buf_out_snappy;
+   unsigned long len_buf_out_zlib, len_buf_out_lzo, len_buf_out_snappy, len_buf_out_zstd;
    unsigned long len_buf_out;

-   len_buf_out_zlib = len_buf_out_lzo = len_buf_out_snappy = 0;
+   len_buf_out_zlib = len_buf_out_lzo = len_buf_out_snappy = len_buf_out_zstd = 0;

 #ifdef USELZO
    len_buf_out_lzo = page_size + page_size / 16 + 64 + 3;
@@ -309,11 +312,14 @@ calculate_len_buf_out(long page_size)
    len_buf_out_snappy = snappy_max_compressed_length(page_size);
 #endif

+#ifdef USEZSTD
+   len_buf_out_zstd = ZSTD_compressBound(page_size);
+#endif
+
    len_buf_out_zlib = compressBound(page_size);

-   len_buf_out = MAX(len_buf_out_zlib,
-             MAX(len_buf_out_lzo,
-                 len_buf_out_snappy));
+   len_buf_out = MAX(MAX(len_buf_out_zlib,len_buf_out_zstd),
+           MAX(len_buf_out_lzo,len_buf_out_snappy));

    return len_buf_out;
 }
@@ -7235,6 +7241,10 @@ write_kdump_header(void)

    if (info->flag_compress & DUMP_DH_COMPRESSED_ZLIB)
        dh->status |= DUMP_DH_COMPRESSED_ZLIB;
+#ifdef USEZSTD
+   else if (info->flag_compress & DUMP_DH_COMPRESSED_ZSTD)
+       dh->status |= DUMP_DH_COMPRESSED_ZSTD;
+#endif
 #ifdef USELZO
    else if (info->flag_compress & DUMP_DH_COMPRESSED_LZO)
        dh->status |= DUMP_DH_COMPRESSED_LZO;
@@ -8589,6 +8599,17 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
            && (size_out < info->page_size)) {
            pd.flags = DUMP_DH_COMPRESSED_ZLIB;
            pd.size  = size_out;
+#ifdef USEZSTD
+       } else if ((info->flag_compress & DUMP_DH_COMPRESSED_ZSTD)
+               && (size_out = len_buf_out)
+               && (len_buf_out = ZSTD_compress((void *)buf_out,
+                       size_out, (const void *)buf, info->page_size, 1))
+               && (len_buf_out < info->page_size)
+             ) {
+           CHECK_ZSTD(len_buf_out);
+           pd.flags = DUMP_DH_COMPRESSED_ZSTD;
+           pd.size  = len_buf_out;
+#endif
 #ifdef USELZO
        } else if (info->flag_lzo_support
               && (info->flag_compress & DUMP_DH_COMPRESSED_LZO)
@@ -11605,7 +11626,7 @@ main(int argc, char *argv[])

    info->block_order = DEFAULT_ORDER;
    message_level = DEFAULT_MSG_LEVEL;
-   while ((opt = getopt_long(argc, argv, "b:cDd:eEFfg:hi:lpRvXx:", longopts,
+   while ((opt = getopt_long(argc, argv, "b:cDd:eEFfg:hi:lpRvXx:z", longopts,
        NULL)) != -1) {
        switch (opt) {
        case OPT_BLOCK_ORDER:
@@ -11617,6 +11638,9 @@ main(int argc, char *argv[])
        case OPT_COMPRESS_ZLIB:
            info->flag_compress = DUMP_DH_COMPRESSED_ZLIB;
            break;
+       case OPT_COMPRESS_ZSTD:
+           info->flag_compress = DUMP_DH_COMPRESSED_ZSTD;
+           break;
        case OPT_DEBUG:
            flag_debug = TRUE;
            break;
diff --git a/makedumpfile.h b/makedumpfile.h
index 79046f2..3fb1b57 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -2463,6 +2463,7 @@ struct elf_prstatus {
 #define OPT_VERSION             'v'
 #define OPT_EXCLUDE_XEN_DOM     'X'
 #define OPT_VMLINUX             'x'
+#define OPT_COMPRESS_ZSTD       'z'
 #define OPT_START               256
 #define OPT_SPLIT               OPT_START+0
 #define OPT_REASSEMBLE          OPT_START+1
-- 
1.8.3.1
--=====_003_next=====--

--=====_001_next=====
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--=====_001_next=====--


