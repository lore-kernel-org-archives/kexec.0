Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga06-in.huawei.com ([45.249.212.32])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjccE-0000Dy-UU
 for kexec@lists.infradead.org; Mon, 30 Nov 2020 06:24:52 +0000
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CkwDY4y2Szhkhd
 for <kexec@lists.infradead.org>; Mon, 30 Nov 2020 14:24:13 +0800 (CST)
From: qiuguorui1 <qiuguorui1@huawei.com>
Subject: [PATCH] zlib: fix resource leak when gzdirect failed
Date: Mon, 30 Nov 2020 14:41:25 +0800
Message-ID: <20201130064125.1379-1-qiuguorui1@huawei.com>
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
To: kexec@lists.infradead.org, yszhou4tech@gmail.com
Cc: qiuguorui1@huawei.com, horms@verge.net.au, leeyou.li@huawei.com, zengweilin@huawei.com

In function zlib_decompress_file, when gzdirect(fp) fails,
we should gzclose fp before return.

Fixes: d606837b56d46 ("Fix zlib/lzma decompression.")
Signed-off-by: qiuguorui1 <qiuguorui1@huawei.com>
---
 kexec/zlib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/zlib.c b/kexec/zlib.c
index 9bc340d..3ed6bd6 100644
--- a/kexec/zlib.c
+++ b/kexec/zlib.c
@@ -60,7 +60,7 @@ char *zlib_decompress_file(const char *filename, off_t *r_size)
 	gzFile fp;
 	int errnum;
 	const char *msg;
-	char *buf;
+	char *buf = NULL;
 	off_t size = 0, allocated;
 	ssize_t result;
 
@@ -78,7 +78,7 @@ char *zlib_decompress_file(const char *filename, off_t *r_size)
 	}
 	if (gzdirect(fp)) {
 		/* It's not in gzip format */
-		return NULL;
+		goto fail;
 	}
 	allocated = 65536;
 	buf = xmalloc(allocated);
-- 
2.12.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
