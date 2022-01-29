From: Yang Li <yang.lee@linux.alibaba.com>
Date: Sat, 29 Jan 2022 09:14:49 +0800
Subject: [PATCH -next] proc/vmcore: Fix vmcore_alloc_buf() kernel-doc comment
Message-ID: <20220129011449.105278-1-yang.lee@linux.alibaba.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Fix a spelling problem to remove warnings found
by running scripts/kernel-doc, which is caused by
using 'make W=1'.

fs/proc/vmcore.c:492: warning: Function parameter or member 'size' not
described in 'vmcore_alloc_buf'
fs/proc/vmcore.c:492: warning: Excess function parameter 'sizez'
description in 'vmcore_alloc_buf'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/proc/vmcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index edeb01dfe05d..6f1b8ddc6f7a 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -480,7 +480,7 @@ static const struct vm_operations_struct vmcore_mmap_ops = {
 
 /**
  * vmcore_alloc_buf - allocate buffer in vmalloc memory
- * @sizez: size of buffer
+ * @size: size of buffer
  *
  * If CONFIG_MMU is defined, use vmalloc_user() to allow users to mmap
  * the buffer to user-space by means of remap_vmalloc_range().
-- 
2.20.1.7.g153144c


