Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from vmicros1.altlinux.org ([194.107.17.57])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1cgfgl-0005UE-PL
 for kexec@lists.infradead.org; Wed, 22 Feb 2017 22:47:14 +0000
Date: Thu, 23 Feb 2017 01:46:46 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH] uapi: fix linux/kexec.h userspace compilation errors
Message-ID: <20170222224646.GC14311@altlinux.org>
Mime-Version: 1.0
Content-Disposition: inline
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Include <stddef.h> (guarded by #ifndef __KERNEL__) to fix the following
linux/kexec.h userspace compilation errors:

/usr/include/linux/kexec.h:53:2: error: unknown type name 'size_t'
  size_t bufsz;
/usr/include/linux/kexec.h:55:2: error: unknown type name 'size_t'
  size_t memsz;

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 include/uapi/linux/kexec.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index aae5ebf..7def5f5 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -45,6 +45,9 @@
 #define KEXEC_SEGMENT_MAX 16
 
 #ifndef __KERNEL__
+
+#include <stddef.h>    /* For size_t. */
+
 /*
  * This structure is used to hold the arguments that are used when
  * loading  kernel binaries.
-- 
ldv

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
