Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOdtt-00CUKJ-Mn
 for kexec@lists.infradead.org; Fri, 10 Sep 2021 10:36:55 +0000
Received: by mail-pf1-f197.google.com with SMTP id
 k76-20020a62844f000000b00415e244e9b1so1091835pfd.17
 for <kexec@lists.infradead.org>; Fri, 10 Sep 2021 03:33:47 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
Subject: [PATCH 08/11] makedumpfile: Add parallel threads zstd uncompression
 processing
Date: Fri, 10 Sep 2021 18:33:15 +0800
Message-Id: <20210910103318.292017-9-ltao@redhat.com>
In-Reply-To: <20210910103318.292017-1-ltao@redhat.com>
References: <20210910103318.292017-1-ltao@redhat.com>
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
To: kexec@lists.infradead.org
Cc: k-hagio-ab@nec.com, Tao Liu <ltao@redhat.com>

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 makedumpfile.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index e70d882..2514eb6 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -919,7 +919,7 @@ readpage_kdump_compressed_parallel(int fd_memory, unsigned long long paddr,
 	 * Read page data
 	 */
 	rdbuf = pd.flags & (DUMP_DH_COMPRESSED_ZLIB | DUMP_DH_COMPRESSED_LZO |
-		DUMP_DH_COMPRESSED_SNAPPY) ? buf : bufptr;
+		DUMP_DH_COMPRESSED_SNAPPY | DUMP_DH_COMPRESSED_ZSTD) ? buf : bufptr;
 	if (read(fd_memory, rdbuf, pd.size) != pd.size) {
 		ERRMSG("Can't read %s. %s\n",
 				info->name_memory, strerror(errno));
@@ -960,6 +960,14 @@ readpage_kdump_compressed_parallel(int fd_memory, unsigned long long paddr,
 			ERRMSG("Uncompress failed: %d\n", ret);
 			return FALSE;
 		}
+#endif
+#ifdef USEZSTD
+	} else if ((pd.flags & DUMP_DH_COMPRESSED_ZSTD)) {
+		ret = ZSTD_decompress(bufptr, info->page_size, buf, pd.size);
+		if (ZSTD_isError(ret) || (ret != info->page_size)) {
+			ERRMSG("Uncompress failed: %d\n", ret);
+			return FALSE;
+		}
 #endif
 	}
 
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
