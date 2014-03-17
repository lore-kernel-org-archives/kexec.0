Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g4t3425.houston.hp.com ([15.201.208.53])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WPT9D-0003Ai-LD
 for kexec@lists.infradead.org; Mon, 17 Mar 2014 08:43:52 +0000
Subject: [PATCH] makedumpfile: reduce unnecessary memory copy
From: Jingbai Ma <jingbai.ma@hp.com>
Date: Mon, 17 Mar 2014 16:43:18 +0800
Message-ID: <20140317084318.13494.34955.stgit@k.asiapacific.hpqcorp.net>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org, lisa.mitchell@hp.com

This patch intends to reduce unnecessary memory copy in compressing memory
blocks.

old logic like this:
    compress(buf_out, &size_out, buf, size);
    ...
    memcpy(buf, buf_out, pd.size);
    ...
    write_cache(cd_page, buf, pd.size)

new logic:
    compress(buf_out, &size_out, buf, size);
    ...
    if (compressed?)
        write_cache(cd_page, buf_out, pd.size)
    else
        write_cache(cd_page, buf, pd.size)

This occurs for each single page, so by the new logic it can reduce a lot of
unnecessary memcpy() on machines with huge memory.
This patch wasn't expected to improve the kdump performance dramatically due to
the memory copy operations on modern processors are pretty fast.


Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
---
 makedumpfile.c |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 23251a1..80f76cf 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -6245,7 +6245,6 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 		    && (size_out < info->page_size)) {
 			pd.flags = DUMP_DH_COMPRESSED_ZLIB;
 			pd.size  = size_out;
-			memcpy(buf, buf_out, pd.size);
 #ifdef USELZO
 		} else if (info->flag_lzo_support
 			   && (info->flag_compress & DUMP_DH_COMPRESSED_LZO)
@@ -6255,7 +6254,6 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 			   && (size_out < info->page_size)) {
 			pd.flags = DUMP_DH_COMPRESSED_LZO;
 			pd.size  = size_out;
-			memcpy(buf, buf_out, pd.size);
 #endif
 #ifdef USESNAPPY
 		} else if ((info->flag_compress & DUMP_DH_COMPRESSED_SNAPPY)
@@ -6267,7 +6265,6 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 			   && (size_out < info->page_size)) {
 			pd.flags = DUMP_DH_COMPRESSED_SNAPPY;
 			pd.size  = size_out;
-			memcpy(buf, buf_out, pd.size);
 #endif
 		} else {
 			pd.flags = 0;
@@ -6286,8 +6283,13 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 		/*
 		 * Write the page data.
 		 */
-		if (!write_cache(cd_page, buf, pd.size))
-			goto out;
+		if (pd.flags == 0) {
+			if (!write_cache(cd_page, buf, pd.size))
+				goto out;
+		} else {
+			if (!write_cache(cd_page, buf_out, pd.size))
+				goto out;
+		}
 	}
 
 	/*
@@ -6424,7 +6426,6 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 		    && (size_out < info->page_size)) {
 			pd.flags = DUMP_DH_COMPRESSED_ZLIB;
 			pd.size  = size_out;
-			memcpy(buf, buf_out, pd.size);
 #ifdef USELZO
 		} else if (info->flag_lzo_support
 			   && (info->flag_compress & DUMP_DH_COMPRESSED_LZO)
@@ -6434,7 +6435,6 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 			   && (size_out < info->page_size)) {
 			pd.flags = DUMP_DH_COMPRESSED_LZO;
 			pd.size  = size_out;
-			memcpy(buf, buf_out, pd.size);
 #endif
 #ifdef USESNAPPY
 		} else if ((info->flag_compress & DUMP_DH_COMPRESSED_SNAPPY)
@@ -6446,7 +6446,6 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 			   && (size_out < info->page_size)) {
 			pd.flags = DUMP_DH_COMPRESSED_SNAPPY;
 			pd.size  = size_out;
-			memcpy(buf, buf_out, pd.size);
 #endif
 		} else {
 			pd.flags = 0;
@@ -6465,8 +6464,13 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
                 /*
                  * Write the page data.
                  */
-                if (!write_cache(cd_page, buf, pd.size))
-                        goto out;
+		if (pd.flags == 0) {
+			if (!write_cache(cd_page, buf, pd.size))
+				goto out;
+		} else {
+			if (!write_cache(cd_page, buf_out, pd.size))
+				goto out;
+		}
         }
 
 	ret = TRUE;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
