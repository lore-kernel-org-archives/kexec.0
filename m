Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g6t1526.atlanta.hp.com ([15.193.200.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WUvwC-0003y5-AO
 for kexec@lists.infradead.org; Tue, 01 Apr 2014 10:29:00 +0000
Subject: [PATCH v2] makedumpfile: cleanup: reduce unnecessary memory copy
From: Jingbai Ma <jingbai.ma@hp.com>
Date: Tue, 01 Apr 2014 18:28:26 +0800
Message-ID: <20140401102826.31131.85379.stgit@k.asiapacific.hpqcorp.net>
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

Changelog:
v2:
- Simplify write buffer out logic.
- Add benchmark result.

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

Benchmark:
Hardware: HP BL280c G6 Blade Server with 32GB RAM
Test method: Run 10 times test for original and patched makedumpfile, and get
the average time of the "Copying data" stage.
makedumpfile -l --message-level 23 -d 31 -f /vmcores/vmcore /dev/null

Original: 7.089s
 Patched: 7.092s

Taking into account measurement error, two test results can be regarded as the
same. That's mean there is no measurable difference on a machine with 32GB RAM.


Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
---
 makedumpfile.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 23251a1..c9fa44c 100644
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
@@ -6286,7 +6283,7 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 		/*
 		 * Write the page data.
 		 */
-		if (!write_cache(cd_page, buf, pd.size))
+		if (!write_cache(cd_page, pd.flags ? buf_out : buf, pd.size))
 			goto out;
 	}
 
@@ -6424,7 +6421,6 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 		    && (size_out < info->page_size)) {
 			pd.flags = DUMP_DH_COMPRESSED_ZLIB;
 			pd.size  = size_out;
-			memcpy(buf, buf_out, pd.size);
 #ifdef USELZO
 		} else if (info->flag_lzo_support
 			   && (info->flag_compress & DUMP_DH_COMPRESSED_LZO)
@@ -6434,7 +6430,6 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 			   && (size_out < info->page_size)) {
 			pd.flags = DUMP_DH_COMPRESSED_LZO;
 			pd.size  = size_out;
-			memcpy(buf, buf_out, pd.size);
 #endif
 #ifdef USESNAPPY
 		} else if ((info->flag_compress & DUMP_DH_COMPRESSED_SNAPPY)
@@ -6446,7 +6441,6 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 			   && (size_out < info->page_size)) {
 			pd.flags = DUMP_DH_COMPRESSED_SNAPPY;
 			pd.size  = size_out;
-			memcpy(buf, buf_out, pd.size);
 #endif
 		} else {
 			pd.flags = 0;
@@ -6465,7 +6459,7 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
                 /*
                  * Write the page data.
                  */
-                if (!write_cache(cd_page, buf, pd.size))
+		if (!write_cache(cd_page, pd.flags ? buf_out : buf, pd.size))
                         goto out;
         }
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
