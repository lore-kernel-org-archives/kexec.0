Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-m17637.qiye.163.com ([59.111.176.37])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOXUv-00DXBf-Jm
 for kexec@lists.infradead.org; Tue, 23 Mar 2021 03:14:28 +0000
From: Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] include: linux: Remove duplicate include of pgtable.h
Date: Tue, 23 Mar 2021 11:13:52 +0800
Message-Id: <20210323031352.258587-1-wanjiabing@vivo.com>
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
To: Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>

linux/pgtable.h has been included at line 11 with annotation.
So we remove the duplicate one at line 8.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 include/linux/crash_dump.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index a5192b718dbe..be79a45d7aa3 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -5,7 +5,6 @@
 #include <linux/kexec.h>
 #include <linux/proc_fs.h>
 #include <linux/elf.h>
-#include <linux/pgtable.h>
 #include <uapi/linux/vmcore.h>
 
 #include <linux/pgtable.h> /* for pgprot_t */
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
