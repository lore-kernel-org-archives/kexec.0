Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 7/7] vmcore-dmesg: Define _GNU_SOURCE
Date: Wed,  8 Mar 2017 22:41:14 +0000
Message-Id: <20170308224114.49729-7-dwmw2@infradead.org>
In-Reply-To: <20170308224114.49729-1-dwmw2@infradead.org>
References: <20170308224114.49729-1-dwmw2@infradead.org>
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
Cc: Khem Raj <raj.khem@gmail.com>, David Woodhouse <dwmw@amazon.co.uk>

From: Khem Raj <raj.khem@gmail.com>

loff_t is guarded with _GNU_SOURCE on some C library implementations
e.g. musl since this type is not defined by POSIX. Define _GNU_SOURCE to
include this define, it should help compiling on musl while nothing
changes for glibc based systems since there _GNU_SOURCE is already
defined

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
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
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
