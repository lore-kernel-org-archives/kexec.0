Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x22b.google.com ([2607:f8b0:400e:c03::22b])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aI4hc-0001J3-Hh
 for kexec@lists.infradead.org; Sun, 10 Jan 2016 01:21:53 +0000
Received: by mail-pa0-x22b.google.com with SMTP id uo6so285064041pac.1
 for <kexec@lists.infradead.org>; Sat, 09 Jan 2016 17:21:31 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] vmcore-dmesg: Define _GNU_SOURCE
Date: Sat,  9 Jan 2016 17:21:22 -0800
Message-Id: <1452388882-11712-1-git-send-email-raj.khem@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, Khem Raj <raj.khem@gmail.com>

loff_t is guarded with _GNU_SOURCE on some C library implementations
e.g. musl since this type is not defined by POSIX. Define _GNU_SOURCE to
include this define, it should help compiling on musl while nothing
changes for glibc based systems since there _GNU_SOURCE is already
defined

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 vmcore-dmesg/vmcore-dmesg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
index 0364636..a8f56df 100644
--- a/vmcore-dmesg/vmcore-dmesg.c
+++ b/vmcore-dmesg/vmcore-dmesg.c
@@ -1,4 +1,5 @@
 #define _XOPEN_SOURCE 600
+#define _GNU_SOURCE
 #define _LARGEFILE_SOURCE 1
 #define _FILE_OFFSET_BITS 64
 #include <endian.h>
-- 
2.7.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
