Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga02-in.huawei.com ([119.145.14.65])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wdu0O-0002zd-D9
 for kexec@lists.infradead.org; Sat, 26 Apr 2014 04:14:25 +0000
From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 3/4] makedumpfile: add -D_GNU_SOURCE to CFLAGS
Date: Sat, 26 Apr 2014 12:07:08 +0800
Message-ID: <1398485229-43295-4-git-send-email-wangnan0@huawei.com>
In-Reply-To: <1398485229-43295-1-git-send-email-wangnan0@huawei.com>
References: <1398485229-43295-1-git-send-email-wangnan0@huawei.com>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: Wang Nan <wangnan0@huawei.com>, Liu Hua <sdu.liu@huawei.com>, Petr Tesarik <ptesarik@suse.cz>, kexec@lists.infradead.org, Geng Hui <hui.geng@huawei.com>

This patch is preparation for introduce pread/pwrite.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: Petr Tesarik <ptesarik@suse.cz>
Cc: kexec@lists.infradead.org
Cc: Geng Hui <hui.geng@huawei.com>
Cc: Liu Hua <sdu.liu@huawei.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 68db947..1c65e61 100644
--- a/Makefile
+++ b/Makefile
@@ -9,11 +9,11 @@ CC	= gcc
 endif
 
 CFLAGS = -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
-	  -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE \
+	  -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_GNU_SOURCE \
 	  -DVERSION='"$(VERSION)"' -DRELEASE_DATE='"$(DATE)"' \
 	  -I/home/w00229757/makedumpfile/elfutils-root/include
 CFLAGS_ARCH	= -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
-		    -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
+		    -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_GNU_SOURCE
 # LDFLAGS = -L/usr/local/lib -I/usr/local/include
 LDFLAGS = -L/home/w00229757/makedumpfile/elfutils-root/lib
 
-- 
1.8.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
