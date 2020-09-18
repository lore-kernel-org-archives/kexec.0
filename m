Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJFug-0001x2-EQ
 for kexec@lists.infradead.org; Fri, 18 Sep 2020 12:55:01 +0000
From: Wang Hai <wanghai38@huawei.com>
Subject: [PATCH -next] fs/proc/vmcore: Fix 'sizez' kernel-doc warning in
 vmcore.c
Date: Fri, 18 Sep 2020 20:51:48 +0800
Message-ID: <20200918125148.8292-1-wanghai38@huawei.com>
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
To: dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com, adobriyan@gmail.com
Cc: linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

fs/proc/vmcore.c:458: warning: Excess function parameter 'sizez' description in 'vmcore_alloc_buf'

Rename sizez to size.

Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 fs/proc/vmcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index c3a345c28a93..bfb0aa4d63e4 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -446,7 +446,7 @@ static const struct vm_operations_struct vmcore_mmap_ops = {
 
 /**
  * vmcore_alloc_buf - allocate buffer in vmalloc memory
- * @sizez: size of buffer
+ * @size: size of buffer
  *
  * If CONFIG_MMU is defined, use vmalloc_user() to allow users to mmap
  * the buffer to user-space by means of remap_vmalloc_range().
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
