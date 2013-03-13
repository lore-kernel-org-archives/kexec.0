Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UFpYw-0006af-T8
 for kexec@lists.infradead.org; Wed, 13 Mar 2013 17:34:03 +0000
Received: by mail-pb0-f43.google.com with SMTP id md12so1254021pbc.2
 for <kexec@lists.infradead.org>; Wed, 13 Mar 2013 10:34:01 -0700 (PDT)
Message-ID: <5140B881.8010504@gmail.com>
Date: Thu, 14 Mar 2013 01:33:53 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 11/13] kexec: s390: remove ALIGN_UP and use _ALIGN_UP
References: <5140B511.7020109@gmail.com>
In-Reply-To: <5140B511.7020109@gmail.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

We have _ALIGN_UP now, so remove ALIGN_UP and use _ALIGN_UP
instead of it.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/s390/kexec-image.c |    2 +-
 kexec/arch/s390/kexec-s390.h  |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/s390/kexec-image.c b/kexec/arch/s390/kexec-image.c
index ee101cb..d3af800 100644
--- a/kexec/arch/s390/kexec-image.c
+++ b/kexec/arch/s390/kexec-image.c
@@ -112,7 +112,7 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
 			return -1;
 		}
 		ramdisk_origin = MAX(RAMDISK_ORIGIN_ADDR, kernel_size);
-		ramdisk_origin = ALIGN_UP(ramdisk_origin, 0x100000);
+		ramdisk_origin = _ALIGN_UP(ramdisk_origin, 0x100000);
 		add_segment_check(info, rd_buffer, ramdisk_len,
 				  ramdisk_origin, ramdisk_len);
 	}
diff --git a/kexec/arch/s390/kexec-s390.h b/kexec/arch/s390/kexec-s390.h
index cbc3340..ee62888 100644
--- a/kexec/arch/s390/kexec-s390.h
+++ b/kexec/arch/s390/kexec-s390.h
@@ -21,7 +21,6 @@
 #define COMMAND_LINESIZE      896
 #define MAX_MEMORY_RANGES     1024
 
-#define ALIGN_UP(addr, size) (((addr) + ((size)-1)) & (~((size)-1)))
 #define MAX(x, y) ((x) > (y) ? (x) : (y))
 #define MIN(x, y) ((x) < (y) ? (x) : (y))
 
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
