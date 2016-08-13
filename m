Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bYUGr-0000xD-Bc
 for kexec@lists.infradead.org; Sat, 13 Aug 2016 08:26:21 +0000
From: Xunlei Pang <xlpang@redhat.com>
Subject: [PATCH] kexec: Account crashk_low_res to kexec_crash_size
Date: Sat, 13 Aug 2016 16:26:10 +0800
Message-Id: <1471076770-29426-1-git-send-email-xlpang@redhat.com>
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
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: Baoquan He <bhe@redhat.com>, Xunlei Pang <xlpang@redhat.com>, ebiederm@xmission.com, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

"/sys/kernel/kexec_crash_size" only includes crashk_res, it
is fine in most cases, but sometimes we have crashk_low_res.
For example, when "crashkernel=size[KMG],high" combined with
"crashkernel=size[KMG],low" is used for 64-bit x86.

Let "/sys/kernel/kexec_crash_size" reflect all the reserved
memory including crashk_low_res, this is more understandable
from its naming.

Although we can get all the crash memory from "/proc/iomem"
by filtering all "Crash kernel" keyword, it is more convenient
to utilize this file, and the two ways should stay consistent.

Note that write to "/sys/kernel/kexec_crash_size" is to shrink
the reserved memory, and we want to shrink crashk_res only.
So we add some additional check in crash_shrink_memory() since
crashk_low_res now is involved.

Signed-off-by: Xunlei Pang <xlpang@redhat.com>
---
 kernel/kexec_core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 5616755..d5ae780 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -932,6 +932,8 @@ size_t crash_get_memory_size(void)
 	mutex_lock(&kexec_mutex);
 	if (crashk_res.end != crashk_res.start)
 		size = resource_size(&crashk_res);
+	if (crashk_low_res.end != crashk_low_res.start)
+		size += resource_size(&crashk_low_res);
 	mutex_unlock(&kexec_mutex);
 	return size;
 }
@@ -949,7 +951,7 @@ int crash_shrink_memory(unsigned long new_size)
 {
 	int ret = 0;
 	unsigned long start, end;
-	unsigned long old_size;
+	unsigned long low_size, old_size;
 	struct resource *ram_res;
 
 	mutex_lock(&kexec_mutex);
@@ -958,6 +960,17 @@ int crash_shrink_memory(unsigned long new_size)
 		ret = -ENOENT;
 		goto unlock;
 	}
+
+	start = crashk_low_res.start;
+	end = crashk_low_res.end;
+	low_size = (end == 0) ? 0 : end - start + 1;
+	/* Do not shrink crashk_low_res. */
+	if (new_size <= low_size) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	new_size -= low_size;
 	start = crashk_res.start;
 	end = crashk_res.end;
 	old_size = (end == 0) ? 0 : end - start + 1;
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
