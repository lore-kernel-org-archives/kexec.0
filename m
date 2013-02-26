Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1UAD3e-0000Nl-JF
 for kexec@lists.infradead.org; Tue, 26 Feb 2013 05:26:31 +0000
Message-ID: <512C44E4.70907@cn.fujitsu.com>
Date: Tue, 26 Feb 2013 13:15:16 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH v3 1/2] kexec: fix wrong types of some local variables
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

The types of the following local variables:
  - ubytes/mbytes in kimage_load_crash_segment()/kimage_load_normal_segment()
  - r in vmcoreinfo_append_str()
are wrong, so fix them.

Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Simon Horman <horms@verge.net.au>
Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kernel/kexec.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 2436ffc..3cbfcc7 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -789,7 +789,7 @@ static int kimage_load_normal_segment(struct kimage *image,
 					 struct kexec_segment *segment)
 {
 	unsigned long maddr;
-	unsigned long ubytes, mbytes;
+	size_t ubytes, mbytes;
 	int result;
 	unsigned char __user *buf;
 
@@ -853,7 +853,7 @@ static int kimage_load_crash_segment(struct kimage *image,
 	 * We do things a page at a time for the sake of kmap.
 	 */
 	unsigned long maddr;
-	unsigned long ubytes, mbytes;
+	size_t ubytes, mbytes;
 	int result;
 	unsigned char __user *buf;
 
@@ -1455,7 +1455,7 @@ void vmcoreinfo_append_str(const char *fmt, ...)
 {
 	va_list args;
 	char buf[0x50];
-	int r;
+	size_t r;
 
 	va_start(args, fmt);
 	r = vsnprintf(buf, sizeof(buf), fmt, args);
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
