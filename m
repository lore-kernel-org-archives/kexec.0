Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1UAD9R-0000W4-Gv
 for kexec@lists.infradead.org; Tue, 26 Feb 2013 05:32:30 +0000
Message-ID: <512C4881.90409@cn.fujitsu.com>
Date: Tue, 26 Feb 2013 13:30:41 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH v3 2/2] kexec: Use min_t to simplify logic
References: <512C44E4.70907@cn.fujitsu.com>
In-Reply-To: <512C44E4.70907@cn.fujitsu.com>
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

This is just a tweak: using min_t to simplify logic of variable
assignments.

v3:
- cast type of (PAGE_SIZE - (maddr & ~PAGE_MASK)) into size_t.

v2:
- Rewrite patch description as Simon suggested.
- Fix an inappropriate if test introduced by v1. Thanks Simon.

Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kernel/kexec.c |   24 ++++++++----------------
 1 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 3cbfcc7..b6b16f9 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -822,13 +822,9 @@ static int kimage_load_normal_segment(struct kimage *image,
 		/* Start with a clear page */
 		clear_page(ptr);
 		ptr += maddr & ~PAGE_MASK;
-		mchunk = PAGE_SIZE - (maddr & ~PAGE_MASK);
-		if (mchunk > mbytes)
-			mchunk = mbytes;
-
-		uchunk = mchunk;
-		if (uchunk > ubytes)
-			uchunk = ubytes;
+		mchunk = min_t(size_t, mbytes,
+			       (size_t)(PAGE_SIZE - (maddr & ~PAGE_MASK)));
+		uchunk = min_t(size_t, ubytes, mchunk);
 
 		result = copy_from_user(ptr, buf, uchunk);
 		kunmap(page);
@@ -874,13 +870,10 @@ static int kimage_load_crash_segment(struct kimage *image,
 		}
 		ptr = kmap(page);
 		ptr += maddr & ~PAGE_MASK;
-		mchunk = PAGE_SIZE - (maddr & ~PAGE_MASK);
-		if (mchunk > mbytes)
-			mchunk = mbytes;
-
-		uchunk = mchunk;
-		if (uchunk > ubytes) {
-			uchunk = ubytes;
+		mchunk = min_t(size_t, mbytes,
+			       (size_t)(PAGE_SIZE - (maddr & ~PAGE_MASK)));
+		uchunk = min_t(size_t, ubytes, mchunk);
+		if (mchunk > uchunk) {
 			/* Zero the trailing part of the page */
 			memset(ptr + uchunk, 0, mchunk - uchunk);
 		}
@@ -1461,8 +1454,7 @@ void vmcoreinfo_append_str(const char *fmt, ...)
 	r = vsnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
 
-	if (r + vmcoreinfo_size > vmcoreinfo_max_size)
-		r = vmcoreinfo_max_size - vmcoreinfo_size;
+	r = min_t(size_t, r, vmcoreinfo_max_size - vmcoreinfo_size);
 
 	memcpy(&vmcoreinfo_data[vmcoreinfo_size], buf, r);
 
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
