Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n2qcZ-0041Ac-2r
 for kexec@lists.infradead.org; Thu, 30 Dec 2021 08:17:13 +0000
From: Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] fs/proc/vmcore: Fix vmcore_alloc_buf() kernel-doc
 comment
Date: Thu, 30 Dec 2021 16:17:01 +0800
Message-Id: <20211230081701.42593-1-yang.lee@linux.alibaba.com>
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
To: bhe@redhat.com
Cc: vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>, Abaci Robot <abaci@linux.alibaba.com>

Fix a spelling mistake sizez -> size, to remove some warnings
found by running scripts/kernel-doc, which is caused by using
'make W=1'.
fs/proc/vmcore.c:489: warning: Function parameter or member 'size' not
described in 'vmcore_alloc_buf'
fs/proc/vmcore.c:489: warning: Excess function parameter 'sizez'
description in 'vmcore_alloc_buf'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/proc/vmcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 702754dd1daf..cbb3ac5ca0c4 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -477,7 +477,7 @@ static const struct vm_operations_struct vmcore_mmap_ops = {
 
 /**
  * vmcore_alloc_buf - allocate buffer in vmalloc memory
- * @sizez: size of buffer
+ * @size: size of buffer
  *
  * If CONFIG_MMU is defined, use vmalloc_user() to allow users to mmap
  * the buffer to user-space by means of remap_vmalloc_range().
-- 
2.20.1.7.g153144c


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
